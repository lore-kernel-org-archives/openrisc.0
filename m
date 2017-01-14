From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 08:08:12 +0900
Subject: [OpenRISC] [PATCH 15/22] openrisc: Add optimized memset
In-Reply-To: <cover.1484432596.git.shorne@gmail.com>
References: <cover.1484432596.git.shorne@gmail.com>
Message-ID: <2e80b58fc61f01263b1cadc0419bfb6a5b30f677.1484432596.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Olof Kindgren <olof.kindgren@gmail.com>

This adds a hand-optimized assembler version of memset and sets
__HAVE_ARCH_MEMSET to use this version instead of the generic C
routine

Signed-off-by: Olof Kindgren <olof.kindgren@gmail.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/string.h |  7 +++
 arch/openrisc/kernel/or32_ksyms.c  |  1 +
 arch/openrisc/lib/Makefile         |  2 +-
 arch/openrisc/lib/memset.S         | 98 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/string.h
 create mode 100644 arch/openrisc/lib/memset.S

diff --git a/arch/openrisc/include/asm/string.h b/arch/openrisc/include/asm/string.h
new file mode 100644
index 0000000..33470d4
--- /dev/null
+++ b/arch/openrisc/include/asm/string.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_OPENRISC_STRING_H
+#define __ASM_OPENRISC_STRING_H
+
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *s, int c, __kernel_size_t n);
+
+#endif /* __ASM_OPENRISC_STRING_H */
diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 86e31cf..5c4695d 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -44,3 +44,4 @@ DECLARE_EXPORT(__ashldi3);
 DECLARE_EXPORT(__lshrdi3);
 
 EXPORT_SYMBOL(__copy_tofrom_user);
+EXPORT_SYMBOL(memset);
diff --git a/arch/openrisc/lib/Makefile b/arch/openrisc/lib/Makefile
index 966f65d..67c583e 100644
--- a/arch/openrisc/lib/Makefile
+++ b/arch/openrisc/lib/Makefile
@@ -2,4 +2,4 @@
 # Makefile for or32 specific library files..
 #
 
-obj-y  = string.o delay.o
+obj-y  = memset.o string.o delay.o
diff --git a/arch/openrisc/lib/memset.S b/arch/openrisc/lib/memset.S
new file mode 100644
index 0000000..92cc2ea
--- /dev/null
+++ b/arch/openrisc/lib/memset.S
@@ -0,0 +1,98 @@
+/*
+ * OpenRISC memset.S
+ *
+ * Hand-optimized assembler version of memset for OpenRISC.
+ * Algorithm inspired by several other arch-specific memset routines
+ * in the kernel tree
+ *
+ * Copyright (C) 2015 Olof Kindgren <olof.kindgren@gmail.com>
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+	.global memset
+	.type	memset, @function
+memset:
+	/* arguments:
+	 * r3 = *s
+	 * r4 = c
+	 * r5 = n
+	 * r13, r15, r17, r19 used as temp regs
+	*/
+
+	/* Exit if n == 0 */
+	l.sfeqi		r5, 0
+	l.bf		4f
+
+	/* Truncate c to char */
+	l.andi  	r13, r4, 0xff
+
+	/* Skip word extension if c is 0 */
+	l.sfeqi		r13, 0
+	l.bf		1f
+	/* Check for at least two whole words (8 bytes) */
+	 l.sfleui	r5, 7
+
+	/* Extend char c to 32-bit word cccc in r13 */
+	l.slli		r15, r13, 16  // r13 = 000c, r15 = 0c00
+	l.or		r13, r13, r15 // r13 = 0c0c, r15 = 0c00
+	l.slli		r15, r13, 8   // r13 = 0c0c, r15 = c0c0
+	l.or		r13, r13, r15 // r13 = cccc, r15 = c0c0
+
+1:	l.addi		r19, r3, 0 // Set r19 = src
+	/* Jump to byte copy loop if less than two words */
+	l.bf		3f
+	 l.or		r17, r5, r0 // Set r17 = n
+
+	/* Mask out two LSBs to check alignment */
+	l.andi		r15, r3, 0x3
+
+	/* lsb == 00, jump to word copy loop */
+	l.sfeqi		r15, 0
+	l.bf		2f
+	 l.addi		r19, r3, 0 // Set r19 = src
+
+	/* lsb == 01,10 or 11 */
+	l.sb		0(r3), r13   // *src = c
+	l.addi		r17, r17, -1 // Decrease n
+
+	l.sfeqi		r15, 3
+	l.bf		2f
+	 l.addi		r19, r3, 1  // src += 1
+
+	/* lsb == 01 or 10 */
+	l.sb		1(r3), r13   // *(src+1) = c
+	l.addi		r17, r17, -1 // Decrease n
+
+	l.sfeqi		r15, 2
+	l.bf		2f
+	 l.addi		r19, r3, 2  // src += 2
+
+	/* lsb == 01 */
+	l.sb		2(r3), r13   // *(src+2) = c
+	l.addi		r17, r17, -1 // Decrease n
+	l.addi		r19, r3, 3   // src += 3
+
+	/* Word copy loop */
+2:	l.sw		0(r19), r13  // *src = cccc
+	l.addi		r17, r17, -4 // Decrease n
+	l.sfgeui	r17, 4
+	l.bf		2b
+	 l.addi		r19, r19, 4  // Increase src
+
+	/* When n > 0, copy the remaining bytes, otherwise jump to exit */
+	l.sfeqi		r17, 0
+	l.bf		4f
+
+	/* Byte copy loop */
+3:	l.addi		r17, r17, -1 // Decrease n
+	l.sb		0(r19), r13  // *src = cccc
+	l.sfnei		r17, 0
+	l.bf		3b
+	 l.addi		r19, r19, 1  // Increase src
+
+4:	l.jr		r9
+	 l.ori		r11, r3, 0
-- 
2.9.3

