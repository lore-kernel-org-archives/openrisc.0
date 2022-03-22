From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Mar 2022 06:06:52 +0900
Subject: [OpenRISC] [PATCH V2 1/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <54d6221d-0c4f-9329-042d-4f74c4ea288f@redhat.com>
References: <20220319035457.2214979-1-guoren@kernel.org>
 <20220319035457.2214979-2-guoren@kernel.org>
 <Yjk+LGwhc50zvsk2@antec>
 <54d6221d-0c4f-9329-042d-4f74c4ea288f@redhat.com>
Message-ID: <Yjo6bI+DWolVT/bQ@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Mar 22, 2022 at 11:54:37AM -0400, Waiman Long wrote:
> On 3/21/22 23:10, Stafford Horne wrote:
> > Hello,
> > 
> > There is a problem with this patch on Big Endian machines, see below.
> > 
> > On Sat, Mar 19, 2022 at 11:54:53AM +0800, guoren at kernel.org wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > This is a simple, fair spinlock.  Specifically it doesn't have all the
> > > subtle memory model dependencies that qspinlock has, which makes it more
> > > suitable for simple systems as it is more likely to be correct.
> > > 
> > > [Palmer: commit text]
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > 
> > > --
> > > 
> > > I have specifically not included Peter's SOB on this, as he sent his
> > > original patch
> > > <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> > > without one.
> > > ---
> > >   include/asm-generic/spinlock.h          | 11 +++-
> > >   include/asm-generic/spinlock_types.h    | 15 +++++
> > >   include/asm-generic/ticket-lock-types.h | 11 ++++
> > >   include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
> > >   4 files changed, 120 insertions(+), 3 deletions(-)
> > >   create mode 100644 include/asm-generic/spinlock_types.h
> > >   create mode 100644 include/asm-generic/ticket-lock-types.h
> > >   create mode 100644 include/asm-generic/ticket-lock.h
> > > 
> > > diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
> > > new file mode 100644
> > > index 000000000000..59373de3e32a
> > > --- /dev/null
> > > +++ b/include/asm-generic/ticket-lock.h
> > ...
> > 
> > > +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> > > +{
> > > +	u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
> > As mentioned, this patch series breaks SMP on OpenRISC.  I traced it to this
> > line.  The above `__is_defined(__BIG_ENDIAN)`  does not return 1 as expected
> > even on BIG_ENDIAN machines.  This works:
> > 
> > 
> > diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
> > index 59373de3e32a..52b5dc9ffdba 100644
> > --- a/include/asm-generic/ticket-lock.h
> > +++ b/include/asm-generic/ticket-lock.h
> > @@ -26,6 +26,7 @@
> >   #define __ASM_GENERIC_TICKET_LOCK_H
> >   #include <linux/atomic.h>
> > +#include <linux/kconfig.h>
> >   #include <asm-generic/ticket-lock-types.h>
> >   static __always_inline void ticket_lock(arch_spinlock_t *lock)
> > @@ -51,7 +52,7 @@ static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
> >   static __always_inline void ticket_unlock(arch_spinlock_t *lock)
> >   {
> > -       u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
> > +       u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> >          u32 val = atomic_read(lock);
> >          smp_store_release(ptr, (u16)val + 1);
> > 
> > 
> > > +	u32 val = atomic_read(lock);
> > > +
> > > +	smp_store_release(ptr, (u16)val + 1);
> > > +}
> > > +
> 
> __BIG_ENDIAN is defined in <linux/kconfig.h>. I believe that if you include
> <linux/kconfig.h>, the second hunk is not really needed and vice versa.

I thought so too, but it doesn't seem to work.  I think __is_defined is not
doing what we think in this context.  It looks like __is_defined works when a
macro is defined as 1, in this case we have __BIG_ENDIAN 4321.

With just the first hunk, we can see we still get 0 for the lock offset as per
below:

diff --git a/include/asm-generic/ticket-lock.h
b/include/asm-generic/ticket-lock.h
index 59373de3e32a..769561fb6997 100644
--- a/include/asm-generic/ticket-lock.h
+++ b/include/asm-generic/ticket-lock.h
@@ -26,6 +26,7 @@
 #define __ASM_GENERIC_TICKET_LOCK_H

 #include <linux/atomic.h>
+#include <linux/kconfig.h>
 #include <asm-generic/ticket-lock-types.h>

 static __always_inline void ticket_lock(arch_spinlock_t *lock)

--

 make ARCH=openrisc simple_smp_defconfig
 make ARCH=openrisc CROSS_COMPILE=or1k-linux- kernel/locking/spinlock.i
 grep -C3 'lock +' kernel/locking/spinlock.i

    static inline __attribute__((__gnu_inline__)) __attribute__((__unused__)) __attribute__((__no_instrument_function__)) __attribute__((__always_inline__)) void
    ticket_unlock(arch_spinlock_t *lock)
    {
     u16 *ptr = (u16 *)lock + 0;

     u32 val = atomic_read(lock);

-Stafford
