From: Stafford Horne <shorne@gmail.com>
Date: Sat,  4 Feb 2017 00:48:40 +0900
Subject: [OpenRISC] [PATCH v2 16/23] openrisc: Add optimized memcpy routine
In-Reply-To: <cover.1486135912.git.shorne@gmail.com>
References: <cover.1486135912.git.shorne@gmail.com>
Message-ID: <7325da3bd9ad24ac290a942e6d9f31083aac5691.1486135912.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The generic memcpy routine provided in kernel does only byte copies.
Using word copies we can lower boot time and cycles spend in memcpy
quite significantly.

Booting on my de0 nano I see boot times go from 7.2 to 5.6 seconds.
The avg cycles in memcpy during boot go from 6467 to 1887.

I tested several algorithms (see code in previous patch mails)

The implementations I tested and avg cycles:
  - Word Copies + Loop Unrolls + Non Aligned    1882
  - Word Copies + Loop Unrolls                  1887
  - Word Copies                                 2441
  - Byte Copies + Loop Unrolls                  6467
  - Byte Copies                                 7600

In the end I ended up going with Word Copies + Loop Unrolls as it
provides best tradeoff between simplicity and boot speedups.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/TODO.openrisc        |   1 -
 arch/openrisc/include/asm/string.h |   3 +
 arch/openrisc/lib/Makefile         |   2 +-
 arch/openrisc/lib/memcpy.c         | 124 +++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100644 arch/openrisc/lib/memcpy.c

diff --git a/arch/openrisc/TODO.openrisc b/arch/openrisc/TODO.openrisc
index 0eb04c8..c43d4e1 100644
--- a/arch/openrisc/TODO.openrisc
+++ b/arch/openrisc/TODO.openrisc
@@ -10,4 +10,3 @@ that are due for investigation shortly, i.e. our TODO list:
    or1k and this change is slowly trickling through the stack.  For the time
    being, or32 is equivalent to or1k.
 
--- Implement optimized version of memcpy and memset
diff --git a/arch/openrisc/include/asm/string.h b/arch/openrisc/include/asm/string.h
index 33470d4..64939cc 100644
--- a/arch/openrisc/include/asm/string.h
+++ b/arch/openrisc/include/asm/string.h
@@ -4,4 +4,7 @@
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *s, int c, __kernel_size_t n);
 
+#define __HAVE_ARCH_MEMCPY
+extern void *memcpy(void *dest, __const void *src, __kernel_size_t n);
+
 #endif /* __ASM_OPENRISC_STRING_H */
diff --git a/arch/openrisc/lib/Makefile b/arch/openrisc/lib/Makefile
index 67c583e..17d9d37 100644
--- a/arch/openrisc/lib/Makefile
+++ b/arch/openrisc/lib/Makefile
@@ -2,4 +2,4 @@
 # Makefile for or32 specific library files..
 #
 
-obj-y  = memset.o string.o delay.o
+obj-y	:= delay.o string.o memset.o memcpy.o
diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
new file mode 100644
index 0000000..4706f01
--- /dev/null
+++ b/arch/openrisc/lib/memcpy.c
@@ -0,0 +1,124 @@
+/*
+ * arch/openrisc/lib/memcpy.c
+ *
+ * Optimized memory copy routines for openrisc.  These are mostly copied
+ * from ohter sources but slightly entended based on ideas discuassed in
+ * #openrisc.
+ *
+ * The word unroll implementation is an extension to the arm byte
+ * unrolled implementation, but using word copies (if things are
+ * properly aligned)
+ *
+ * The great arm loop unroll algorithm can be found at:
+ *  arch/arm/boot/compressed/string.c
+ */
+
+#include <linux/export.h>
+
+#include <linux/string.h>
+
+#ifdef CONFIG_OR1200
+/*
+ * Do memcpy with word copies and loop unrolling. This gives the
+ * best performance on the OR1200 and MOR1KX archirectures
+ */
+void *memcpy(void *dest, __const void *src, __kernel_size_t n)
+{
+	int i = 0;
+	unsigned char *d, *s;
+	uint32_t *dest_w = (uint32_t *)dest, *src_w = (uint32_t *)src;
+
+	/* If both source and dest are word aligned copy words */
+	if (!((unsigned int)dest_w & 3) && !((unsigned int)src_w & 3)) {
+		/* Copy 32 bytes per loop */
+		for (i = n >> 5; i > 0; i--) {
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+		}
+
+		if (n & 1 << 4) {
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+		}
+
+		if (n & 1 << 3) {
+			*dest_w++ = *src_w++;
+			*dest_w++ = *src_w++;
+		}
+
+		if (n & 1 << 2)
+			*dest_w++ = *src_w++;
+
+		d = (unsigned char *)dest_w;
+		s = (unsigned char *)src_w;
+
+	} else {
+		d = (unsigned char *)dest_w;
+		s = (unsigned char *)src_w;
+
+		for (i = n >> 3; i > 0; i--) {
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+		}
+
+		if (n & 1 << 2) {
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+			*d++ = *s++;
+		}
+	}
+
+	if (n & 1 << 1) {
+		*d++ = *s++;
+		*d++ = *s++;
+	}
+
+	if (n & 1)
+		*d++ = *s++;
+
+	return dest;
+}
+#else
+/*
+ * Use word copies but no loop unrolling as we cannot assume there
+ * will be benefits on the archirecture
+ */
+void *memcpy(void *dest, __const void *src, __kernel_size_t n)
+{
+	unsigned char *d = (unsigned char *)dest, *s = (unsigned char *)src;
+	uint32_t *dest_w = (uint32_t *)dest, *src_w = (uint32_t *)src;
+
+	/* If both source and dest are word aligned copy words */
+	if (!((unsigned int)dest_w & 3) && !((unsigned int)src_w & 3)) {
+		for (; n >= 4; n -= 4)
+			*dest_w++ = *src_w++;
+	}
+
+	d = (unsigned char *)dest_w;
+	s = (unsigned char *)src_w;
+
+	/* For remaining or if not aligned, copy bytes */
+	for (; n >= 1; n -= 1)
+		*d++ = *s++;
+
+	return dest;
+
+}
+#endif
+
+EXPORT_SYMBOL(memcpy);
-- 
2.9.3

