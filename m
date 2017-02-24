From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:27 +0900
Subject: [OpenRISC] [PATCH v4 07/24] openrisc: add atomic bitops
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <06bdc8a2358b4c556933e314ec7f2279c14ea9bd.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

This utilize the load-link/store-conditional l.lwa and l.swa
instructions to implement the atomic bitops.
When those instructions are not available emulation is provided.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: remove OPENRISC_HAVE_INST_LWA_SWA config suggesed by
Alan Cox https://lkml.org/lkml/2014/7/23/666, implement
test_and_change_bit]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/bitops.h        |   2 +-
 arch/openrisc/include/asm/bitops/atomic.h | 123 ++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/bitops/atomic.h

diff --git a/arch/openrisc/include/asm/bitops.h b/arch/openrisc/include/asm/bitops.h
index 3003cda..689f568 100644
--- a/arch/openrisc/include/asm/bitops.h
+++ b/arch/openrisc/include/asm/bitops.h
@@ -45,7 +45,7 @@
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
-#include <asm-generic/bitops/atomic.h>
+#include <asm/bitops/atomic.h>
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
diff --git a/arch/openrisc/include/asm/bitops/atomic.h b/arch/openrisc/include/asm/bitops/atomic.h
new file mode 100644
index 0000000..35fb85f
--- /dev/null
+++ b/arch/openrisc/include/asm/bitops/atomic.h
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_OPENRISC_BITOPS_ATOMIC_H
+#define __ASM_OPENRISC_BITOPS_ATOMIC_H
+
+static inline void set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%1)	\n"
+		"	l.or	%0,%0,%2	\n"
+		"	l.swa	0(%1),%0	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(tmp)
+		: "r"(p), "r"(mask)
+		: "cc", "memory");
+}
+
+static inline void clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%1)	\n"
+		"	l.and	%0,%0,%2	\n"
+		"	l.swa	0(%1),%0	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(tmp)
+		: "r"(p), "r"(~mask)
+		: "cc", "memory");
+}
+
+static inline void change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%1)	\n"
+		"	l.xor	%0,%0,%2	\n"
+		"	l.swa	0(%1),%0	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(tmp)
+		: "r"(p), "r"(mask)
+		: "cc", "memory");
+}
+
+static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long old;
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%2)	\n"
+		"	l.or	%1,%0,%3	\n"
+		"	l.swa	0(%2),%1	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(old), "=&r"(tmp)
+		: "r"(p), "r"(mask)
+		: "cc", "memory");
+
+	return (old & mask) != 0;
+}
+
+static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long old;
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%2)	\n"
+		"	l.and	%1,%0,%3	\n"
+		"	l.swa	0(%2),%1	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(old), "=&r"(tmp)
+		: "r"(p), "r"(~mask)
+		: "cc", "memory");
+
+	return (old & mask) != 0;
+}
+
+static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long old;
+	unsigned long tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%2)	\n"
+		"	l.xor	%1,%0,%3	\n"
+		"	l.swa	0(%2),%1	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(old), "=&r"(tmp)
+		: "r"(p), "r"(mask)
+		: "cc", "memory");
+
+	return (old & mask) != 0;
+}
+
+#endif /* __ASM_OPENRISC_BITOPS_ATOMIC_H */
-- 
2.9.3

