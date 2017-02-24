From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:30 +0900
Subject: [OpenRISC] [PATCH v4 10/24] openrisc: add futex_atomic_*
	implementations
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <52d55484a27ab454ead1083d52bb0297078c3806.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Support for the futex_atomic_* operations by using the
load-link/store-conditional l.lwa/l.swa instructions.
Most openrisc cores provide these instructions now if not available,
emulation is provided.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: remove OPENRISC_HAVE_INST_LWA_SWA config suggesed by
Alan Cox https://lkml.org/lkml/2014/7/23/666]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild  |   1 -
 arch/openrisc/include/asm/futex.h | 135 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/futex.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 1cedd63..a669c14 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += exec.h
 generic-y += fb.h
 generic-y += fcntl.h
 generic-y += ftrace.h
-generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
 generic-y += ioctl.h
diff --git a/arch/openrisc/include/asm/futex.h b/arch/openrisc/include/asm/futex.h
new file mode 100644
index 0000000..7780873
--- /dev/null
+++ b/arch/openrisc/include/asm/futex.h
@@ -0,0 +1,135 @@
+#ifndef __ASM_OPENRISC_FUTEX_H
+#define __ASM_OPENRISC_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <asm/errno.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
+({								\
+	__asm__ __volatile__ (					\
+		"1:	l.lwa	%0, %2			\n"	\
+			insn				"\n"	\
+		"2:	l.swa	%2, %1			\n"	\
+		"	l.bnf	1b			\n"	\
+		"	 l.ori	%1, r0, 0		\n"	\
+		"3:					\n"	\
+		".section .fixup,\"ax\"			\n"	\
+		"4:	l.j	3b			\n"	\
+		"	 l.addi	%1, r0, %3		\n"	\
+		".previous				\n"	\
+		".section __ex_table,\"a\"		\n"	\
+		".word	1b,4b,2b,4b			\n"	\
+		".previous				\n"	\
+		: "=&r" (oldval), "=&r" (ret), "+m" (*uaddr)	\
+		: "i" (-EFAULT), "r" (oparg)			\
+		: "cc", "memory"				\
+		);						\
+})
+
+static inline int
+futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	pagefault_disable();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("l.or %1,%4,%4", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("l.add %1,%0,%4", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("l.or %1,%0,%4", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("l.and %1,%0,%4", ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("l.xor %1,%0,%4", ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	pagefault_enable();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ:
+			ret = (oldval == cmparg);
+			break;
+		case FUTEX_OP_CMP_NE:
+			ret = (oldval != cmparg);
+			break;
+		case FUTEX_OP_CMP_LT:
+			ret = (oldval < cmparg);
+			break;
+		case FUTEX_OP_CMP_GE:
+			ret = (oldval >= cmparg);
+			break;
+		case FUTEX_OP_CMP_LE:
+			ret = (oldval <= cmparg);
+			break;
+		case FUTEX_OP_CMP_GT:
+			ret = (oldval > cmparg);
+			break;
+		default:
+			ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	int ret = 0;
+	u32 prev;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	__asm__ __volatile__ (				\
+		"1:	l.lwa	%1, %2		\n"	\
+		"	l.sfeq	%1, %3		\n"	\
+		"	l.bnf	3f		\n"	\
+		"	 l.nop			\n"	\
+		"2:	l.swa	%2, %4		\n"	\
+		"	l.bnf	1b		\n"	\
+		"	 l.nop			\n"	\
+		"3:				\n"	\
+		".section .fixup,\"ax\"		\n"	\
+		"4:	l.j	3b		\n"	\
+		"	 l.addi	%0, r0, %5	\n"	\
+		".previous			\n"	\
+		".section __ex_table,\"a\"	\n"	\
+		".word	1b,4b,2b,4b		\n"	\
+		".previous			\n"	\
+		: "+r" (ret), "=&r" (prev), "+m" (*uaddr) \
+		: "r" (oldval), "r" (newval), "i" (-EFAULT) \
+		: "cc",	"memory"			\
+		);
+
+	*uval = prev;
+	return ret;
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_OPENRISC_FUTEX_H */
-- 
2.9.3

