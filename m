From: Boqun Feng <boqun.feng@gmail.com>
Date: Sun, 17 Apr 2022 10:44:25 +0800
Subject: [OpenRISC] [PATCH v3 1/7] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <mhng-78fec320-bd16-4774-9e24-2e5c0ce33121@palmer-ri-x1c9>
References: <YljFyY7acyRDBmK7@tardis>
 <mhng-78fec320-bd16-4774-9e24-2e5c0ce33121@palmer-ri-x1c9>
Message-ID: <Ylt/CdbB9vF9dXjo@tardis>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Apr 14, 2022 at 10:20:04PM -0700, Palmer Dabbelt wrote:
> On Thu, 14 Apr 2022 18:09:29 PDT (-0700), boqun.feng at gmail.com wrote:
> > Hi,
> > 
> > On Thu, Apr 14, 2022 at 03:02:08PM -0700, Palmer Dabbelt wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > This is a simple, fair spinlock.  Specifically it doesn't have all the
> > > subtle memory model dependencies that qspinlock has, which makes it more
> > > suitable for simple systems as it is more likely to be correct.  It is
> > > implemented entirely in terms of standard atomics and thus works fine
> > > without any arch-specific code.
> > > 
> > > This replaces the existing asm-generic/spinlock.h, which just errored
> > > out on SMP systems.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > ---
> > >  include/asm-generic/spinlock.h       | 85 +++++++++++++++++++++++++---
> > >  include/asm-generic/spinlock_types.h | 17 ++++++
> > >  2 files changed, 94 insertions(+), 8 deletions(-)
> > >  create mode 100644 include/asm-generic/spinlock_types.h
> > > 
> > > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> > > index adaf6acab172..ca829fcb9672 100644
> > > --- a/include/asm-generic/spinlock.h
> > > +++ b/include/asm-generic/spinlock.h
> > > @@ -1,12 +1,81 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 */
> > > -#ifndef __ASM_GENERIC_SPINLOCK_H
> > > -#define __ASM_GENERIC_SPINLOCK_H
> > > +
> > >  /*
> > > - * You need to implement asm/spinlock.h for SMP support. The generic
> > > - * version does not handle SMP.
> > > + * 'Generic' ticket-lock implementation.
> > > + *
> > > + * It relies on atomic_fetch_add() having well defined forward progress
> > > + * guarantees under contention. If your architecture cannot provide this, stick
> > > + * to a test-and-set lock.
> > > + *
> > > + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> > > + * sub-word of the value. This is generally true for anything LL/SC although
> > > + * you'd be hard pressed to find anything useful in architecture specifications
> > > + * about this. If your architecture cannot do this you might be better off with
> > > + * a test-and-set.
> > > + *
> > > + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> > > + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> > > + *
> > > + * The implementation uses smp_cond_load_acquire() to spin, so if the
> > > + * architecture has WFE like instructions to sleep instead of poll for word
> > > + * modifications be sure to implement that (see ARM64 for example).
> > > + *
> > >   */
> > > -#ifdef CONFIG_SMP
> > > -#error need an architecture specific asm/spinlock.h
> > > -#endif
> > > -#endif /* __ASM_GENERIC_SPINLOCK_H */
> > > +#ifndef __ASM_GENERIC_TICKET_LOCK_H
> > > +#define __ASM_GENERIC_TICKET_LOCK_H
> > > +
> > > +#include <linux/atomic.h>
> > > +#include <asm-generic/spinlock_types.h>
> > > +
> > > +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> > > +{
> > > +	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> > > +	u16 ticket = val >> 16;
> > > +
> > > +	if (ticket == (u16)val)
> > > +		return;
> > > +
> > > +	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
> > 
> > Looks like my follow comment is missing:
> > 
> > 	https://lore.kernel.org/lkml/YjM+P32I4fENIqGV at boqun-archlinux/
> > 
> > Basically, I suggested that 1) instead of "SC", use "fully-ordered" as
> > that's a complete definition in our atomic API ("RCsc" is fine), 2)
> > introduce a RCsc atomic_cond_read_acquire() or add a full barrier here
> > to make arch_spin_lock() RCsc otherwise arch_spin_lock() is RCsc on
> > fastpath but RCpc on slowpath.
> 
> Sorry about that, now that you mention it I remember seeing that comment but
> I guess I dropped it somehow -- I've been down a bunch of other RISC-V
> memory model rabbit holes lately, so I guess this just got lost in the
> shuffle.
> 
> I'm not really a memory model person, so I'm a bit confused here, but IIUC
> the issue is that there's only an RCpc ordering between the store_release
> that publishes the baker's ticket and the customer's spin to obtain a
> contested lock.  Thus we could see RCpc-legal accesses before the
> atomic_cond_read_acquire().
> 
> That's where I get a bit lost: the atomic_fetch_add() is RCsc, so the
> offending accesses are bounded to remain within arch_spin_lock().  I'm not
> sure how that lines up with the LKMM requirements, which I always see
> expressed in terms of the entire lock being RCsc (specifically with
> unlock->lock reordering weirdness, which the fully ordered AMO seems to
> prevent here).
> 

The case that I had in mind is as follow:

	CPU 0 			CPU 1
	=====			=====
	arch_spin_lock();
	// CPU 0 owns the lock
				arch_spin_lock():
				  atomic_fetch_add(); // fully-ordered
				  if (ticket == (u16)val) // didn't get the ticket yet. 
				  ...
				  atomic_cond_read_acquire():
				    while (true) {
	arch_spin_unlock(); // release
				    	atomic_read_acquire(); // RCpc
					// get the ticket
				    }

In that case the lock is RCpc not RCsc because our atomics are RCpc. So
you will need to enfore the ordering if you want to make generic ticket
lock RCsc.

> That's kind of just a curiosity, though, so assuming we need some stronger
> ordering here I sort of considered this
> 
>    diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
>    index ca829fcb9672..bf4e6050b9b2 100644
>    --- a/include/asm-generic/spinlock.h
>    +++ b/include/asm-generic/spinlock.h
>    @@ -14,7 +14,7 @@
>      * a test-and-set.
>      *
>      * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
>    - * uses atomic_fetch_add() which is SC to create an RCsc lock.
>    + * uses atomic_fetch_add_rcsc() which is RCsc to create an RCsc lock.
>      *
>      * The implementation uses smp_cond_load_acquire() to spin, so if the
>      * architecture has WFE like instructions to sleep instead of poll for word
>    @@ -30,13 +30,13 @@
>     static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>     {
>    	u32 val = atomic_fetch_add(1<<16, lock);
>     	u16 ticket = val >> 16;
>     	if (ticket == (u16)val)
>     		return;
>    -	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
>    +	atomic_cond_read_rcsc(lock, ticket == (u16)VAL);
>     }
>     static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> 
> but that smells a bit awkward: it's not really that the access is RCsc, it's

Yeah, agreed.

> that the whole lock is, and the RCsc->branch->RCpc is just kind of screaming
> for arch-specific optimizations.  I think we either end up with some sort of
> "atomic_*_for_tspinlock" or a "mb_*_for_tspinlock", both of which seem very
> specific.
> 
> That, or we just run with the fence until someone has a concrete way to do
> it faster.  I don't know OpenRISC or C-SKY, but IIUC the full fence is free
> on RISC-V: our smp_cond_read_acquire() only emits read accesses, ends in a
> "fence r,r", and is proceeded by a full smp_mb() from atomic_fetch_add().
> So I'd lean towards the much simpler
> 
>    diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
>    index ca829fcb9672..08e3400a104f 100644
>    --- a/include/asm-generic/spinlock.h
>    +++ b/include/asm-generic/spinlock.h
>    @@ -14,7 +14,9 @@
>      * a test-and-set.
>      *
>      * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
>    - * uses atomic_fetch_add() which is SC to create an RCsc lock.
>    + * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
>    + * a full fence after the spin to upgrade the otherwise-RCpc
>    + * atomic_cond_read_acquire().
>      *
>      * The implementation uses smp_cond_load_acquire() to spin, so if the
>      * architecture has WFE like instructions to sleep instead of poll for word
>    @@ -30,13 +32,22 @@
>     static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>     {
>    -	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
>    +	u32 val = atomic_fetch_add(1<<16, lock);
>     	u16 ticket = val >> 16;
>     	if (ticket == (u16)val)
>     		return;
>    +	/*
>    +	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
>    +	 * custom cond_read_rcsc() here we just emit a full fence.  We only
>    +	 * need the prior reads before subsequent writes ordering from
>    +	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
>    +	 * have no outstanding writes due to the atomic_fetch_add() the extra
>    +	 * orderings are free.
>    +	 */
>     	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
>    +	smp_mb();
>     }
>     static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> 

I like this version ;-)

> I'm also now worried about trylock, but am too far down this rabbit hole to
> try and figure out how try maps between locks and cmpxchg.  This is all way
> too complicated to squash in, though, so I'll definitely plan on a v4.
> 

trylock should be fine, since no one will use a failed trylock to
ordering something (famous last word though ;-)).

Regards,
Boqun

> > Regards,
> > Boqun
> > 
> > > +}
> > > +
> > > +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> > > +{
> > > +	u32 old = atomic_read(lock);
> > > +
> > > +	if ((old >> 16) != (old & 0xffff))
> > > +		return false;
> > > +
> > > +	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
> > > +}
> > > +
> > [...]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20220417/63b62faf/attachment.sig>
