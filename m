From: Stafford Horne <shorne@gmail.com>
Date: Wed, 22 Feb 2017 04:11:38 +0900
Subject: [OpenRISC] [PATCH v3 09/25] openrisc: add optimized atomic
	operations
In-Reply-To: <cover.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
Message-ID: <1479fc4a4a18712003849341affe74b2a0da609a.1487702890.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Using the l.lwa and l.swa atomic instruction pair.
Most openrisc processor cores provide these instructions now. If the
instructions are not available emulation is provided.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: remove OPENRISC_HAVE_INST_LWA_SWA config suggesed by
Alan Cox https://lkml.org/lkml/2014/7/23/666]
[shorne at gmail.com: expand to implement all ops suggested by Peter
Zijlstra https://lkml.org/lkml/2017/2/20/317]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild   |   1 -
 arch/openrisc/include/asm/atomic.h | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/atomic.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 15e6ed5..1cedd63 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 
 header-y += ucontext.h
 
-generic-y += atomic.h
 generic-y += auxvec.h
 generic-y += barrier.h
 generic-y += bitsperlong.h
diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
new file mode 100644
index 0000000..66f47ae
--- /dev/null
+++ b/arch/openrisc/include/asm/atomic.h
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_OPENRISC_ATOMIC_H
+#define __ASM_OPENRISC_ATOMIC_H
+
+#include <linux/types.h>
+
+/* Atomically perform op with v->counter and i */
+#define ATOMIC_OP(op)							\
+static inline void atomic_##op(int i, atomic_t *v)			\
+{									\
+	int tmp;							\
+									\
+	__asm__ __volatile__(						\
+		"1:	l.lwa	%0,0(%1)	\n"			\
+		"	l." #op " %0,%0,%2	\n"			\
+		"	l.swa	0(%1),%0	\n"			\
+		"	l.bnf	1b		\n"			\
+		"	 l.nop			\n"			\
+		: "=&r"(tmp)						\
+		: "r"(&v->counter), "r"(i)				\
+		: "cc", "memory");					\
+}
+
+/* Atomically perform op with v->counter and i, return the result */
+#define ATOMIC_OP_RETURN(op)						\
+static inline int atomic_##op##_return(int i, atomic_t *v)		\
+{									\
+	int tmp;							\
+									\
+	__asm__ __volatile__(						\
+		"1:	l.lwa	%0,0(%1)	\n"			\
+		"	l." #op " %0,%0,%2	\n"			\
+		"	l.swa	0(%1),%0	\n"			\
+		"	l.bnf	1b		\n"			\
+		"	 l.nop			\n"			\
+		: "=&r"(tmp)						\
+		: "r"(&v->counter), "r"(i)				\
+		: "cc", "memory");					\
+									\
+	return tmp;							\
+}
+
+/* Atomically perform op with v->counter and i, return orig v->counter */
+#define ATOMIC_FETCH_OP(op)						\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	int tmp, old;							\
+									\
+	__asm__ __volatile__(						\
+		"1:	l.lwa	%0,0(%2)	\n"			\
+		"	l." #op " %1,%0,%3	\n"			\
+		"	l.swa	0(%2),%1	\n"			\
+		"	l.bnf	1b		\n"			\
+		"	 l.nop			\n"			\
+		: "=&r"(old), "=&r"(tmp)				\
+		: "r"(&v->counter), "r"(i)				\
+		: "cc", "memory");					\
+									\
+	return old;							\
+}
+
+ATOMIC_OP_RETURN(add)
+ATOMIC_OP_RETURN(sub)
+
+ATOMIC_FETCH_OP(add)
+ATOMIC_FETCH_OP(sub)
+ATOMIC_FETCH_OP(and)
+ATOMIC_FETCH_OP(or)
+ATOMIC_FETCH_OP(xor)
+
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+#undef ATOMIC_OP
+
+#define atomic_add_return	atomic_add_return
+#define atomic_sub_return	atomic_sub_return
+#define atomic_fetch_add	atomic_fetch_add
+#define atomic_fetch_sub	atomic_fetch_sub
+#define atomic_fetch_and	atomic_fetch_and
+#define atomic_fetch_or		atomic_fetch_or
+#define atomic_fetch_xor	atomic_fetch_xor
+#define atomic_and	atomic_and
+#define atomic_or	atomic_or
+#define atomic_xor	atomic_xor
+
+
+#include <asm-generic/atomic.h>
+
+#endif /* __ASM_OPENRISC_ATOMIC_H */
-- 
2.9.3

