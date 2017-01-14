From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 08:08:06 +0900
Subject: [OpenRISC] [PATCH 09/22] openrisc: add optimized atomic operations
In-Reply-To: <cover.1484432596.git.shorne@gmail.com>
References: <cover.1484432596.git.shorne@gmail.com>
Message-ID: <eb53a60d29a8da31f13e09250468f6cd6597f827.1484432596.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Using the l.lwa and l.swa atomic instruction pair.
Most openrisc processor cores provide these instructions now. If the
instructions are not available emulation is provided.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: remove OPENRISC_HAVE_INST_LWA_SWA config suggesed by
Alan Cox https://lkml.org/lkml/2014/7/23/666]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild   |  1 -
 arch/openrisc/include/asm/atomic.h | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
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
index 0000000..67f0b30
--- /dev/null
+++ b/arch/openrisc/include/asm/atomic.h
@@ -0,0 +1,53 @@
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
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	int tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%1)	\n"
+		"	l.add	%0,%0,%2	\n"
+		"	l.swa	0(%1),%0	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(tmp)
+		: "r"(&v->counter), "r"(i)
+		: "cc", "memory");
+
+	return tmp;
+}
+
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	int tmp;
+
+	__asm__ __volatile__(
+		"1:	l.lwa	%0,0(%1)	\n"
+		"	l.sub	%0,%0,%2	\n"
+		"	l.swa	0(%1),%0	\n"
+		"	l.bnf	1b		\n"
+		"	 l.nop			\n"
+		: "=&r"(tmp)
+		: "r"(&v->counter), "r"(i)
+		: "cc", "memory");
+
+	return tmp;
+}
+
+#define atomic_add_return	atomic_add_return
+#define atomic_sub_return	atomic_sub_return
+
+#include <asm-generic/atomic.h>
+
+#endif /* __ASM_OPENRISC_ATOMIC_H */
-- 
2.9.3

