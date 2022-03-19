From: guoren@kernel.org <guoren@kernel.org>
Date: Sat, 19 Mar 2022 11:54:56 +0800
Subject: [OpenRISC] [PATCH V2 4/5] RISC-V: Move to ticket-spinlocks & RW
 locks
In-Reply-To: <20220319035457.2214979-1-guoren@kernel.org>
References: <20220319035457.2214979-1-guoren@kernel.org>
Message-ID: <20220319035457.2214979-5-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Our existing spinlocks aren't fair and replacing them has been on the
TODO list for a long time.  This moves to the recently-introduced ticket
spinlocks, which are simple enough that they are likely to be correct
and fast on the vast majority of extant implementations.

With the move to fair spinlocks, we might as well move to fair rwlocks.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig                      |   1 +
 arch/riscv/include/asm/Kbuild           |   2 +
 arch/riscv/include/asm/spinlock.h       | 135 ------------------------
 arch/riscv/include/asm/spinlock_types.h |  25 -----
 4 files changed, 3 insertions(+), 160 deletions(-)
 delete mode 100644 arch/riscv/include/asm/spinlock.h
 delete mode 100644 arch/riscv/include/asm/spinlock_types.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..feb7030cfb6d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -38,6 +38,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_USE_MEMTEST
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 57b86fd9916c..99dab544e5fa 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -2,5 +2,7 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += spinlock_types.h
+generic-y += spinlock.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
deleted file mode 100644
index f4f7fa1b7ca8..000000000000
--- a/arch/riscv/include/asm/spinlock.h
+++ /dev/null
@@ -1,135 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Regents of the University of California
- * Copyright (C) 2017 SiFive
- */
-
-#ifndef _ASM_RISCV_SPINLOCK_H
-#define _ASM_RISCV_SPINLOCK_H
-
-#include <linux/kernel.h>
-#include <asm/current.h>
-#include <asm/fence.h>
-
-/*
- * Simple spin lock operations.  These provide no fairness guarantees.
- */
-
-/* FIXME: Replace this with a ticket lock, like MIPS. */
-
-#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_store_release(&lock->lock, 0);
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	int tmp = 1, busy;
-
-	__asm__ __volatile__ (
-		"	amoswap.w %0, %2, %1\n"
-		RISCV_ACQUIRE_BARRIER
-		: "=r" (busy), "+A" (lock->lock)
-		: "r" (tmp)
-		: "memory");
-
-	return !busy;
-}
-
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	while (1) {
-		if (arch_spin_is_locked(lock))
-			continue;
-
-		if (arch_spin_trylock(lock))
-			break;
-	}
-}
-
-/***********************************************************/
-
-static inline void arch_read_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1b\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline void arch_write_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1b\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1f\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1f\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *lock)
-{
-	__asm__ __volatile__(
-		RISCV_RELEASE_BARRIER
-		"	amoadd.w x0, %1, %0\n"
-		: "+A" (lock->lock)
-		: "r" (-1)
-		: "memory");
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *lock)
-{
-	smp_store_release(&lock->lock, 0);
-}
-
-#endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
deleted file mode 100644
index 5a35a49505da..000000000000
--- a/arch/riscv/include/asm/spinlock_types.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Regents of the University of California
- */
-
-#ifndef _ASM_RISCV_SPINLOCK_TYPES_H
-#define _ASM_RISCV_SPINLOCK_TYPES_H
-
-#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
-#endif
-
-typedef struct {
-	volatile unsigned int lock;
-} arch_spinlock_t;
-
-#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
-
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
-
-#endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
-- 
2.25.1

