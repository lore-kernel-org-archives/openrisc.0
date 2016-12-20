From: Stafford Horne <shorne@gmail.com>
Date: Tue, 20 Dec 2016 22:59:49 +0900
Subject: [OpenRISC] [PATCH] openrisc: Define __kernel_size_t to suppress
	compiler warnings
Message-ID: <1482242389-30006-1-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The current build throws numerous warnings like:

  mm/percpu.c:1442:9: warning: format '%zu' expects argument of type
  'size_t', but argument 3 has type 'unsigned int' [-Wformat=]
         ai->unit_size, ai->alloc_size / ai->atom_size, ai->atom_size);
         ^
  mm/percpu.c:1442:9: warning: format '%zu' expects argument of type
  'size_t', but argument 4 has type 'unsigned int' [-Wformat=]

This change defines size_t as unsigned long, after this change there are
no warnings.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild             |  1 -
 arch/openrisc/include/uapi/asm/Kbuild        |  1 +
 arch/openrisc/include/uapi/asm/posix_types.h | 24 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/uapi/asm/posix_types.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index a669c14..98d69c5 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -40,7 +40,6 @@ generic-y += msgbuf.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += sections.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 80761eb..c09b436 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -5,6 +5,7 @@ header-y += byteorder.h
 header-y += elf.h
 header-y += kvm_para.h
 header-y += param.h
+header-y += posix_types.h
 header-y += ptrace.h
 header-y += sigcontext.h
 header-y += unistd.h
diff --git a/arch/openrisc/include/uapi/asm/posix_types.h b/arch/openrisc/include/uapi/asm/posix_types.h
new file mode 100644
index 0000000..9b71c3f
--- /dev/null
+++ b/arch/openrisc/include/uapi/asm/posix_types.h
@@ -0,0 +1,24 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2016 by Stafford Horne
+ */
+#ifndef _ASM_POSIX_TYPES_H
+#define _ASM_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.  Also, we cannot
+ * assume GCC is being used.
+ */
+
+typedef unsigned long	__kernel_size_t;
+typedef long		__kernel_ssize_t;
+typedef long		__kernel_ptrdiff_t;
+#define __kernel_size_t __kernel_size_t
+
+#include <asm-generic/posix_types.h>
+
+#endif /* _ASM_POSIX_TYPES_H */
-- 
2.7.4


