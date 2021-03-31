From: guoren@kernel.org <guoren@kernel.org>
Date: Wed, 31 Mar 2021 14:30:36 +0000
Subject: [OpenRISC] [PATCH v6 5/9] csky: Convert custom spinlock/rwlock to
 generic qspinlock/qrwlock
In-Reply-To: <1617201040-83905-1-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
Message-ID: <1617201040-83905-6-git-send-email-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Guo Ren <guoren@linux.alibaba.com>

Update the C-SKY port to use the generic qspinlock and qrwlock.

C-SKY only support ldex.w/stex.w with word(double word) size &
align access. So it must select XCHG32 to let qspinlock only use
word atomic xchg_tail.

Default is still ticket lock.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                      | 8 ++++++++
 arch/csky/include/asm/Kbuild           | 2 ++
 arch/csky/include/asm/spinlock.h       | 4 ++++
 arch/csky/include/asm/spinlock_types.h | 4 ++++
 4 files changed, 18 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 34e91224adc3..ae12332edb7b 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,6 +8,8 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS	if !CSKY_TICKET_LOCK
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
@@ -304,6 +306,12 @@ config NR_CPUS
 	depends on SMP
 	default "4"
 
+config CSKY_TICKET_LOCK
+	bool "Ticket-based spin-locking"
+	default y
+	help
+	  Say Y here to use ticket-based spin-locking.
+
 config HIGHMEM
 	bool "High Memory Support"
 	depends on !CPU_CK610
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index cc24bb8e539f..2a2d09963bb9 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -2,6 +2,8 @@
 generic-y += asm-offsets.h
 generic-y += gpio.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index 69677167977a..fe98ad8ece51 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -6,6 +6,7 @@
 #include <linux/spinlock_types.h>
 #include <asm/barrier.h>
 
+#ifdef CONFIG_CSKY_TICKET_LOCK
 /*
  * Ticket-based spin-locking.
  */
@@ -80,6 +81,9 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 	return (tickets.next - tickets.owner) > 1;
 }
 #define arch_spin_is_contended	arch_spin_is_contended
+#else /* CONFIG_CSKY_TICKET_LOCK */
+#include <asm/qspinlock.h>
+#endif /* CONFIG_CSKY_TICKET_LOCK */
 
 #include <asm/qrwlock.h>
 
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
index 8ff0f6ff3a00..547f035f6dd5 100644
--- a/arch/csky/include/asm/spinlock_types.h
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -7,6 +7,7 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_CSKY_TICKET_LOCK
 #define TICKET_NEXT	16
 
 typedef struct {
@@ -21,6 +22,9 @@ typedef struct {
 } arch_spinlock_t;
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
+#else
+#include <asm-generic/qspinlock_types.h>
+#endif
 
 #include <asm-generic/qrwlock_types.h>
 
-- 
2.17.1

