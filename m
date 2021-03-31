From: guoren@kernel.org <guoren@kernel.org>
Date: Wed, 31 Mar 2021 14:30:34 +0000
Subject: [OpenRISC] [PATCH v6 3/9] riscv: locks: Introduce ticket-based
 spinlock implementation
In-Reply-To: <1617201040-83905-1-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
Message-ID: <1617201040-83905-4-git-send-email-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch introduces a ticket lock implementation for riscv, along the
same lines as the implementation for arch/arm & arch/csky.

We still use qspinlock as default.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/Kconfig                      |  7 ++-
 arch/riscv/include/asm/spinlock.h       | 84 +++++++++++++++++++++++++
 arch/riscv/include/asm/spinlock_types.h | 17 +++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 67cc65ba1ea1..34d0276f01d5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -34,7 +34,7 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_USE_QUEUED_RWLOCKS
-	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS	if !RISCV_TICKET_LOCK
 	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
@@ -344,6 +344,11 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA
 
+config RISCV_TICKET_LOCK
+	bool "Ticket-based spin-locking"
+	help
+	  Say Y here to use ticket-based spin-locking.
+
 config RISCV_ISA_C
 	bool "Emit compressed instructions when building Linux"
 	default y
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index a557de67a425..90b7eaa950cf 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -7,7 +7,91 @@
 #ifndef _ASM_RISCV_SPINLOCK_H
 #define _ASM_RISCV_SPINLOCK_H
 
+#ifdef CONFIG_RISCV_TICKET_LOCK
+#ifdef CONFIG_32BIT
+#define __ASM_SLLIW "slli\t"
+#define __ASM_SRLIW "srli\t"
+#else
+#define __ASM_SLLIW "slliw\t"
+#define __ASM_SRLIW "srliw\t"
+#endif
+
+/*
+ * Ticket-based spin-locking.
+ */
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	arch_spinlock_t lockval;
+	u32 tmp;
+
+	asm volatile (
+		"1:	lr.w	%0, %2		\n"
+		"	mv	%1, %0		\n"
+		"	addw	%0, %0, %3	\n"
+		"	sc.w	%0, %0, %2	\n"
+		"	bnez	%0, 1b		\n"
+		: "=&r" (tmp), "=&r" (lockval), "+A" (lock->lock)
+		: "r" (1 << TICKET_NEXT)
+		: "memory");
+
+	smp_cond_load_acquire(&lock->tickets.owner,
+					VAL == lockval.tickets.next);
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 tmp, contended, res;
+
+	do {
+		asm volatile (
+		"	lr.w	%0, %3		\n"
+		__ASM_SRLIW    "%1, %0, %5	\n"
+		__ASM_SLLIW    "%2, %0, %5	\n"
+		"	or	%1, %2, %1	\n"
+		"	li	%2, 0		\n"
+		"	sub	%1, %1, %0	\n"
+		"	bnez	%1, 1f		\n"
+		"	addw	%0, %0, %4	\n"
+		"	sc.w	%2, %0, %3	\n"
+		"1:				\n"
+		: "=&r" (tmp), "=&r" (contended), "=&r" (res),
+		  "+A" (lock->lock)
+		: "r" (1 << TICKET_NEXT), "I" (TICKET_NEXT)
+		: "memory");
+	} while (res);
+
+	if (!contended)
+		__atomic_acquire_fence();
+
+	return !contended;
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	smp_store_release(&lock->tickets.owner, lock->tickets.owner + 1);
+}
+
+static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+	return lock.tickets.owner == lock.tickets.next;
+}
+
+static inline int arch_spin_is_locked(arch_spinlock_t *lock)
+{
+	return !arch_spin_value_unlocked(READ_ONCE(*lock));
+}
+
+static inline int arch_spin_is_contended(arch_spinlock_t *lock)
+{
+	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
+
+	return (tickets.next - tickets.owner) > 1;
+}
+#define arch_spin_is_contended	arch_spin_is_contended
+#else /* CONFIG_RISCV_TICKET_LOCK */
 #include <asm/qspinlock.h>
+#endif /* CONFIG_RISCV_TICKET_LOCK */
+
 #include <asm/qrwlock.h>
 
 #endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index d033a973f287..afbb19841d0f 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -10,7 +10,24 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_RISCV_TICKET_LOCK
+#define TICKET_NEXT	16
+
+typedef struct {
+	union {
+		u32 lock;
+		struct __raw_tickets {
+			/* little endian */
+			u16 owner;
+			u16 next;
+		} tickets;
+	};
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
+#else
 #include <asm-generic/qspinlock_types.h>
+#endif
 #include <asm-generic/qrwlock_types.h>
 
 #endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
-- 
2.17.1

