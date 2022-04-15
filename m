From: Boqun Feng <boqun.feng@gmail.com>
Date: Fri, 15 Apr 2022 09:09:29 +0800
Subject: [OpenRISC] [PATCH v3 1/7] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <20220414220214.24556-2-palmer@rivosinc.com>
References: <20220414220214.24556-1-palmer@rivosinc.com>
 <20220414220214.24556-2-palmer@rivosinc.com>
Message-ID: <YljFyY7acyRDBmK7@tardis>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,

On Thu, Apr 14, 2022 at 03:02:08PM -0700, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> This is a simple, fair spinlock.  Specifically it doesn't have all the
> subtle memory model dependencies that qspinlock has, which makes it more
> suitable for simple systems as it is more likely to be correct.  It is
> implemented entirely in terms of standard atomics and thus works fine
> without any arch-specific code.
> 
> This replaces the existing asm-generic/spinlock.h, which just errored
> out on SMP systems.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  include/asm-generic/spinlock.h       | 85 +++++++++++++++++++++++++---
>  include/asm-generic/spinlock_types.h | 17 ++++++
>  2 files changed, 94 insertions(+), 8 deletions(-)
>  create mode 100644 include/asm-generic/spinlock_types.h
> 
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index adaf6acab172..ca829fcb9672 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -1,12 +1,81 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_GENERIC_SPINLOCK_H
> -#define __ASM_GENERIC_SPINLOCK_H
> +
>  /*
> - * You need to implement asm/spinlock.h for SMP support. The generic
> - * version does not handle SMP.
> + * 'Generic' ticket-lock implementation.
> + *
> + * It relies on atomic_fetch_add() having well defined forward progress
> + * guarantees under contention. If your architecture cannot provide this, stick
> + * to a test-and-set lock.
> + *
> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> + * sub-word of the value. This is generally true for anything LL/SC although
> + * you'd be hard pressed to find anything useful in architecture specifications
> + * about this. If your architecture cannot do this you might be better off with
> + * a test-and-set.
> + *
> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> + *
> + * The implementation uses smp_cond_load_acquire() to spin, so if the
> + * architecture has WFE like instructions to sleep instead of poll for word
> + * modifications be sure to implement that (see ARM64 for example).
> + *
>   */
> -#ifdef CONFIG_SMP
> -#error need an architecture specific asm/spinlock.h
> -#endif
>  
> -#endif /* __ASM_GENERIC_SPINLOCK_H */
> +#ifndef __ASM_GENERIC_TICKET_LOCK_H
> +#define __ASM_GENERIC_TICKET_LOCK_H
> +
> +#include <linux/atomic.h>
> +#include <asm-generic/spinlock_types.h>
> +
> +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> +	u16 ticket = val >> 16;
> +
> +	if (ticket == (u16)val)
> +		return;
> +
> +	atomic_cond_read_acquire(lock, ticket == (u16)VAL);

Looks like my follow comment is missing:

	https://lore.kernel.org/lkml/YjM+P32I4fENIqGV at boqun-archlinux/

Basically, I suggested that 1) instead of "SC", use "fully-ordered" as
that's a complete definition in our atomic API ("RCsc" is fine), 2)
introduce a RCsc atomic_cond_read_acquire() or add a full barrier here
to make arch_spin_lock() RCsc otherwise arch_spin_lock() is RCsc on
fastpath but RCpc on slowpath.

Regards,
Boqun

> +}
> +
> +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	u32 old = atomic_read(lock);
> +
> +	if ((old >> 16) != (old & 0xffff))
> +		return false;
> +
> +	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
> +}
> +
[...]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20220415/6d8934ca/attachment-0001.sig>
