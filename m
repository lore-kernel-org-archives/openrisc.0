From: Stafford Horne <shorne@gmail.com>
Date: Sun, 10 Sep 2017 15:49:16 +0900
Subject: [OpenRISC] [PATCH v2 04/14] openrisc: use qspinlocks and qrwlocks
In-Reply-To: <20170910064926.5874-1-shorne@gmail.com>
References: <20170910064926.5874-1-shorne@gmail.com>
Message-ID: <20170910064926.5874-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Enable OpenRISC to use qspinlocks and qrwlocks for upcoming SMP support.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig                      |  2 ++
 arch/openrisc/include/asm/Kbuild           |  4 ++++
 arch/openrisc/include/asm/spinlock.h       | 12 +++++++++++-
 arch/openrisc/include/asm/spinlock_types.h |  7 +++++++
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/spinlock_types.h

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 356dd67a86ea..b49acda5e8f4 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -28,6 +28,8 @@ config OPENRISC
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select NO_BOOTMEM
+	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_RWLOCKS
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 5bea416a7792..5f066780d870 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -28,6 +28,10 @@ generic-y += module.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += qspinlock_types.h
+generic-y += qspinlock.h
+generic-y += qrwlock_types.h
+generic-y += qrwlock.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += string.h
diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
index fd00a3a24123..9b761e0e22c3 100644
--- a/arch/openrisc/include/asm/spinlock.h
+++ b/arch/openrisc/include/asm/spinlock.h
@@ -19,6 +19,16 @@
 #ifndef __ASM_OPENRISC_SPINLOCK_H
 #define __ASM_OPENRISC_SPINLOCK_H
 
-#error "or32 doesn't do SMP yet"
+#include <asm/qspinlock.h>
+
+#include <asm/qrwlock.h>
+
+#define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
+#define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
+
+#define arch_spin_relax(lock)	cpu_relax()
+#define arch_read_relax(lock)	cpu_relax()
+#define arch_write_relax(lock)	cpu_relax()
+
 
 #endif
diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..7c6fb1208c88
--- /dev/null
+++ b/arch/openrisc/include/asm/spinlock_types.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
+#define _ASM_OPENRISC_SPINLOCK_TYPES_H
+
+#include <asm/qspinlock_types.h>
+#include <asm/qrwlock_types.h>
+
+#endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
-- 
2.13.5

