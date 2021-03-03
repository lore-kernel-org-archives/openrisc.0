From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Mar 2021 22:50:26 +0900
Subject: [OpenRISC] [PATCH 4/4] openrisc: Implement setjmp/longjmp/initjmp
In-Reply-To: <20210303135026.3450789-1-shorne@gmail.com>
References: <20210303135026.3450789-1-shorne@gmail.com>
Message-ID: <20210303135026.3450789-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Tested on or1ksim and this seems to work.  This is mostly the same
as the glibc port implementation, but adjusted as per requirements per
barebox.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig              |  1 +
 arch/openrisc/include/asm/setjmp.h | 17 +++++++++
 arch/openrisc/lib/Makefile         |  1 +
 arch/openrisc/lib/setjmp.S         | 56 ++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 arch/openrisc/include/asm/setjmp.h
 create mode 100644 arch/openrisc/lib/setjmp.S

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 32d23029d..bd8851e4b 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -4,6 +4,7 @@ config OPENRISC
 	select HAS_CACHE
 	select HAVE_CONFIGURABLE_MEMORY_LAYOUT
 	select GENERIC_FIND_NEXT_BIT
+	select HAS_ARCH_SJLJ
 	default y
 
 # not used
diff --git a/arch/openrisc/include/asm/setjmp.h b/arch/openrisc/include/asm/setjmp.h
new file mode 100644
index 000000000..40f55b7eb
--- /dev/null
+++ b/arch/openrisc/include/asm/setjmp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * Define the machine-dependent type `jmp_buf'.  OpenRISC version.
+ * Copyright (C) 2021 Free Software Foundation, Inc.
+ * This file is part of the GNU C Library.
+ */
+
+#ifndef _OR1K_BITS_SETJMP_H
+#define _OR1K_BITS_SETJMP_H  1
+
+typedef long int jmp_buf[13];
+
+int setjmp(jmp_buf jmp) __attribute__((returns_twice));
+void longjmp(jmp_buf jmp, int ret) __attribute__((noreturn));
+int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
+
+#endif /* _OR1K_BITS_SETJMP_H */
diff --git a/arch/openrisc/lib/Makefile b/arch/openrisc/lib/Makefile
index 62082feed..808b09f3a 100644
--- a/arch/openrisc/lib/Makefile
+++ b/arch/openrisc/lib/Makefile
@@ -5,4 +5,5 @@ obj-y                 += muldi3.o
 obj-y                 += lshrdi3.o
 obj-y                 += ashldi3.o
 obj-y                 += ashrdi3.o
+obj-y                 += setjmp.o
 obj-$(CONFIG_BUILTIN_DTB) += dtb.o
diff --git a/arch/openrisc/lib/setjmp.S b/arch/openrisc/lib/setjmp.S
new file mode 100644
index 000000000..7da347780
--- /dev/null
+++ b/arch/openrisc/lib/setjmp.S
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+
+/* int setjmp (jmp_buf);  */
+ENTRY(setjmp)
+	l.sw	0(r3), r1
+	l.sw	4(r3), r2
+	l.sw	8(r3), r9
+	l.sw	12(r3), r10
+	l.sw	16(r3), r14
+	l.sw	20(r3), r16
+	l.sw	24(r3), r18
+	l.sw	28(r3), r20
+	l.sw	32(r3), r22
+	l.sw	36(r3), r24
+	l.sw	40(r3), r26
+	l.sw	44(r3), r28
+	l.sw	48(r3), r30
+	l.jr	r9
+	 l.movhi r11, 0x0
+END(setjmp)
+
+/* volatile void longjmp (jmp_buf, int);  */
+ENTRY(longjmp)
+	l.lwz	r1, 0(r3)
+	l.lwz	r2, 4(r3)
+
+	/* if r4 is 0, something wrong, so set it to 1 */
+	l.sfeqi	r4, 0x0
+	l.bnf	1f		/* r4 != 0, longjmp value sensible */
+	 l.nop
+	l.ori	r4, r0, 0x1	/* make nonzero */
+1:
+	l.lwz	r9, 8(r3)
+	l.lwz	r10, 12(r3)
+	l.lwz	r14, 16(r3)
+	l.lwz	r16, 20(r3)
+	l.lwz	r18, 24(r3)
+	l.lwz	r20, 28(r3)
+	l.lwz	r22, 32(r3)
+	l.lwz	r24, 36(r3)
+	l.lwz	r26, 40(r3)
+	l.lwz	r28, 44(r3)
+	l.lwz	r30, 48(r3)
+	l.jr	r9
+	 l.addi r11, r4, 0x0
+END(longjmp)
+
+/* int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top); */
+ENTRY(initjmp)
+	l.sw	8(r3), r4
+	l.sw	0(r3), r5
+	l.jr	r9
+	 l.movhi r11, 0x0
+END(initjmp)
-- 
2.26.2

