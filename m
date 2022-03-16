From: Palmer Dabbelt <palmer@rivosinc.com>
Date: Wed, 16 Mar 2022 16:25:58 -0700
Subject: [OpenRISC] [PATCH 3/5] openrisc: Move to ticket-spinlock
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
Message-ID: <20220316232600.20419-4-palmer@rivosinc.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Zijlstra <peterz@infradead.org>

We have no indications that openrisc meets the qspinlock requirements,
so move to ticket-spinlock as that is more likey to be correct.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I have specifically not included Peter's SOB on this, as he sent his
original patch
<https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
without one.
---
 arch/openrisc/Kconfig                      | 1 -
 arch/openrisc/include/asm/Kbuild           | 5 ++---
 arch/openrisc/include/asm/spinlock.h       | 3 +--
 arch/openrisc/include/asm/spinlock_types.h | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index f724b3f1aeed..f5fa226362f6 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -30,7 +30,6 @@ config OPENRISC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
-	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index ca5987e11053..cb260e7d73db 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
-generic-y += qspinlock_types.h
-generic-y += qspinlock.h
+generic-y += ticket-lock.h
+generic-y += ticket-lock-types.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += user.h
diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
index 264944a71535..40e4c9fdc349 100644
--- a/arch/openrisc/include/asm/spinlock.h
+++ b/arch/openrisc/include/asm/spinlock.h
@@ -15,8 +15,7 @@
 #ifndef __ASM_OPENRISC_SPINLOCK_H
 #define __ASM_OPENRISC_SPINLOCK_H
 
-#include <asm/qspinlock.h>
-
+#include <asm/ticket-lock.h>
 #include <asm/qrwlock.h>
 
 #define arch_spin_relax(lock)	cpu_relax()
diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
index 7c6fb1208c88..58ea31fa65ce 100644
--- a/arch/openrisc/include/asm/spinlock_types.h
+++ b/arch/openrisc/include/asm/spinlock_types.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
 #define _ASM_OPENRISC_SPINLOCK_TYPES_H
 
-#include <asm/qspinlock_types.h>
+#include <asm/ticket-lock-types.h>
 #include <asm/qrwlock_types.h>
 
 #endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
-- 
2.34.1

