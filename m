From: Guo Ren <guoren@kernel.org>
Date: Mon, 12 Apr 2021 00:01:10 +0800
Subject: [OpenRISC] [PATCH v6 4/9] csky: locks: Optimize coding
 convention
In-Reply-To: <1617201040-83905-5-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-5-git-send-email-guoren@kernel.org>
Message-ID: <CAJF2gTT2Pe8o0wm1ohJE-A0HNjteiB6T3HMcH3Fdj7Tm7SSR8Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 31, 2021 at 10:32 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
>  - Using smp_cond_load_acquire in arch_spin_lock by Peter's
>    advice.
>  - Using __smp_acquire_fence in arch_spin_trylock
>  - Using smp_store_release in arch_spin_unlock
>
> All above are just coding conventions and won't affect the
> function.
>
> TODO in smp_cond_load_acquire for architecture:
>  - current csky only has:
>    lr.w val, <p0>
>    sc.w <p0>. val2
>    (Any other stores to p0 will let sc.w failed)
>
>  - But smp_cond_load_acquire need:
>    lr.w val, <p0>
>    wfe
>    (Any stores to p0 will send the event to let wfe retired)
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Link: https://lore.kernel.org/linux-riscv/CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ at mail.gmail.com/T/#m13adac285b7f51f4f879a5d6b65753ecb1a7524e
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/asm/spinlock.h | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
> index 69f5aa249c5f..69677167977a 100644
> --- a/arch/csky/include/asm/spinlock.h
> +++ b/arch/csky/include/asm/spinlock.h
> @@ -26,10 +26,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>                 : "r"(p), "r"(ticket_next)
>                 : "cc");
>
> -       while (lockval.tickets.next != lockval.tickets.owner)
> -               lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> -
> -       smp_mb();
> +       smp_cond_load_acquire(&lock->tickets.owner,
> +                                       VAL == lockval.tickets.next);
It's wrong, we should determine lockval before next read.

Fixup:

diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index fe98ad8ece51..2be627ceb9df 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -27,7 +27,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
                : "r"(p), "r"(ticket_next)
                : "cc");

-       smp_cond_load_acquire(&lock->tickets.owner,
+       if (lockval.owner != lockval.tickets.next)
+               smp_cond_load_acquire(&lock->tickets.owner,
                                        VAL == lockval.tickets.next);

>  }
>
>  static inline int arch_spin_trylock(arch_spinlock_t *lock)
> @@ -55,15 +53,14 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
>         } while (!res);
>
>         if (!contended)
> -               smp_mb();
> +               __smp_acquire_fence();
>
>         return !contended;
>  }
>
>  static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
> -       smp_mb();
> -       WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
> +       smp_store_release(&lock->tickets.owner, lock->tickets.owner + 1);
>  }
>
>  static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
