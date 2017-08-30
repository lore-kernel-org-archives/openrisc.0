From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 06:58:34 +0900
Subject: [OpenRISC] [PATCH 03/13] openrisc: add 1 and 2 byte cmpxchg support
In-Reply-To: <cover.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
Message-ID: <1a5c872fdf79d00c84ccd5ba3a5e02d02c1039c6.1504129273.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

OpenRISC only supports hardware instructions that perform 4 byte atomic
operations.  For enabling qrwlocks for upcoming SMP support 1 and 2 byte
implementations are needed.  To do this we leverage the 4 byte atomic
operations and shift/mask the 1 and 2 byte areas as needed.

This heavily borrows ideas and routines from sh and mips, which do
something similar.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/cmpxchg.h | 147 ++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 32 deletions(-)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index f0a5d8b844d6..d29f7db53906 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -1,32 +1,29 @@
 /*
+ * 1,2 and 4 byte cmpxchg and xchg implementations for OpenRISC.
+ *
  * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
+ * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
+ *
+ * Note:
+ * The portable implementations of 1 and 2 byte xchg and cmpxchg using a 4
+ * byte cmpxchg is sourced heavily from the sh and mips implementations.
  */
 
 #ifndef __ASM_OPENRISC_CMPXCHG_H
 #define __ASM_OPENRISC_CMPXCHG_H
 
 #include  <linux/types.h>
-
-/*
- * This function doesn't exist, so you'll get a linker error
- * if something tries to do an invalid cmpxchg().
- */
-extern void __cmpxchg_called_with_bad_pointer(void);
+#include  <linux/bitops.h>
 
 #define __HAVE_ARCH_CMPXCHG 1
 
-static inline unsigned long
-__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
+static inline unsigned long cmpxchg_u32(volatile void *ptr,
+		unsigned long old, unsigned long new)
 {
-	if (size != 4) {
-		__cmpxchg_called_with_bad_pointer();
-		return old;
-	}
-
 	__asm__ __volatile__(
 		"1:	l.lwa %0, 0(%1)		\n"
 		"	l.sfeq %0, %2		\n"
@@ -43,6 +40,97 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 	return old;
 }
 
+static inline unsigned long xchg_u32(volatile void *ptr,
+		unsigned long val)
+{
+	__asm__ __volatile__(
+		"1:	l.lwa %0, 0(%1)		\n"
+		"	l.swa 0(%1), %2		\n"
+		"	l.bnf 1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(val)
+		: "r"(ptr), "r"(val)
+		: "cc", "memory");
+
+	return val;
+}
+
+static inline u32 cmpxchg_small(volatile void *ptr, u32 old, u32 new,
+				int size)
+{
+	int off = (unsigned long)ptr % sizeof(u32);
+	volatile u32 *p = ptr - off;
+#ifdef __BIG_ENDIAN
+	int bitoff = (sizeof(u32) - size - off) * BITS_PER_BYTE;
+#else
+	int bitoff = off * BITS_PER_BYTE;
+#endif
+	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
+	u32 load32, old32, new32;
+	u32 ret;
+
+	load32 = READ_ONCE(*p);
+
+	while (true) {
+		ret = (load32 & bitmask) >> bitoff;
+		if (old != ret)
+			return ret;
+
+		old32 = (load32 & ~bitmask) | (old << bitoff);
+		new32 = (load32 & ~bitmask) | (new << bitoff);
+
+		/* Do 32 bit cmpxchg */
+		load32 = cmpxchg_u32(p, old32, new32);
+		if (load32 == old32)
+			return old;
+	}
+}
+
+/* xchg */
+
+static inline u32 xchg_small(volatile void *ptr, u32 x, int size)
+{
+	int off = (unsigned long)ptr % sizeof(u32);
+	volatile u32 *p = ptr - off;
+#ifdef __BIG_ENDIAN
+	int bitoff = (sizeof(u32) - size - off) * BITS_PER_BYTE;
+#else
+	int bitoff = off * BITS_PER_BYTE;
+#endif
+	u32 bitmask = ((0x1 << size * BITS_PER_BYTE) - 1) << bitoff;
+	u32 oldv, newv;
+	u32 ret;
+
+	do {
+		oldv = READ_ONCE(*p);
+		ret = (oldv & bitmask) >> bitoff;
+		newv = (oldv & ~bitmask) | (x << bitoff);
+	} while (cmpxchg_u32(p, oldv, newv) != oldv);
+
+	return ret;
+}
+
+/*
+ * This function doesn't exist, so you'll get a linker error
+ * if something tries to do an invalid cmpxchg().
+ */
+extern unsigned long __cmpxchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for cmpxchg");
+
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+		unsigned long new, int size)
+{
+	switch (size) {
+	case 1:
+	case 2:
+		return cmpxchg_small(ptr, old, new, size);
+	case 4:
+		return cmpxchg_u32(ptr, old, new);
+	default:
+		return __cmpxchg_called_with_bad_pointer();
+	}
+}
+
 #define cmpxchg(ptr, o, n)						\
 	({								\
 		(__typeof__(*(ptr))) __cmpxchg((ptr),			\
@@ -55,32 +143,27 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
  * This function doesn't exist, so you'll get a linker error if
  * something tries to do an invalidly-sized xchg().
  */
-extern void __xchg_called_with_bad_pointer(void);
+extern unsigned long __xchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for xchg");
 
-static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
-				   int size)
+static inline unsigned long __xchg(volatile void *ptr, unsigned long with,
+		int size)
 {
-	if (size != 4) {
-		__xchg_called_with_bad_pointer();
-		return val;
+	switch (size) {
+	case 1:
+	case 2:
+		return xchg_small(ptr, with, size);
+	case 4:
+		return xchg_u32(ptr, with);
+	default:
+		return __xchg_called_with_bad_pointer();
 	}
-
-	__asm__ __volatile__(
-		"1:	l.lwa %0, 0(%1)		\n"
-		"	l.swa 0(%1), %2		\n"
-		"	l.bnf 1b		\n"
-		"	 l.nop			\n"
-		: "=&r"(val)
-		: "r"(ptr), "r"(val)
-		: "cc", "memory");
-
-	return val;
 }
 
 #define xchg(ptr, with) 						\
 	({								\
-		(__typeof__(*(ptr))) __xchg((unsigned long)(with),	\
-					    (ptr),			\
+		(__typeof__(*(ptr))) __xchg((ptr),			\
+					    (unsigned long)(with),	\
 					    sizeof(*(ptr)));		\
 	})
 
-- 
2.13.5

