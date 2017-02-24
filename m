From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:28 +0900
Subject: [OpenRISC] [PATCH v4 08/24] openrisc: add cmpxchg and xchg
	implementations
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <224a6d832d9035800a7840191f6abd4f4de2b435.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Optimized version that make use of the l.lwa and l.swa atomic instruction
pair.
Most openrisc cores provide these instructions now, if not available
emulation is provided.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: remove OPENRISC_HAVE_INST_LWA_SWA config suggesed by
Alan Cox https://lkml.org/lkml/2014/7/23/666]
[shorne at gmail.com: fixed unused calculated value compiler warning in
define cmpxchg]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild    |  2 -
 arch/openrisc/include/asm/cmpxchg.h | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 arch/openrisc/include/asm/cmpxchg.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 6dd177d..15e6ed5 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -10,8 +10,6 @@ generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
 generic-y += clkdev.h
-generic-y += cmpxchg-local.h
-generic-y += cmpxchg.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
new file mode 100644
index 0000000..5fcb9ac
--- /dev/null
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_OPENRISC_CMPXCHG_H
+#define __ASM_OPENRISC_CMPXCHG_H
+
+#include  <linux/types.h>
+
+/*
+ * This function doesn't exist, so you'll get a linker error
+ * if something tries to do an invalid cmpxchg().
+ */
+extern void __cmpxchg_called_with_bad_pointer(void);
+
+#define __HAVE_ARCH_CMPXCHG 1
+
+static inline unsigned long
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
+{
+	if (size != 4) {
+		__cmpxchg_called_with_bad_pointer();
+		return old;
+	}
+
+	__asm__ __volatile__(
+		"1:	l.lwa %0, 0(%1)		\n"
+		"	l.sfeq %0, %2		\n"
+		"	l.bnf 2f		\n"
+		"	 l.nop			\n"
+		"	l.swa 0(%1), %3		\n"
+		"	l.bnf 1b		\n"
+		"	 l.nop			\n"
+		"2:				\n"
+		: "=&r"(old)
+		: "r"(ptr), "r"(old), "r"(new)
+		: "cc", "memory");
+
+	return old;
+}
+
+#define cmpxchg(ptr, o, n)						\
+	({								\
+		(__typeof__(*(ptr))) __cmpxchg((ptr),			\
+					       (unsigned long)(o),	\
+					       (unsigned long)(n),	\
+					       sizeof(*(ptr)));		\
+	})
+
+/*
+ * This function doesn't exist, so you'll get a linker error if
+ * something tries to do an invalidly-sized xchg().
+ */
+extern void __xchg_called_with_bad_pointer(void);
+
+static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
+				   int size)
+{
+	if (size != 4) {
+		__xchg_called_with_bad_pointer();
+		return val;
+	}
+
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
+#define xchg(ptr, with) \
+	((typeof(*(ptr)))__xchg((unsigned long)(with), (ptr), sizeof(*(ptr))))
+
+#endif /* __ASM_OPENRISC_CMPXCHG_H */
-- 
2.9.3

