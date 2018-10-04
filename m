From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 Oct 2018 12:48:01 +0900
Subject: [OpenRISC] [PATCH v2 1/3] or1k: libgcc: initial support for openrisc
In-Reply-To: <20181004034803.18066-1-shorne@gmail.com>
References: <20181004034803.18066-1-shorne@gmail.com>
Message-ID: <20181004034803.18066-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
	    Richard Henderson  <rth@twiddle.net>

libgcc/ChangeLog:

	* config.host: Add OpenRISC support.
	* config/or1k/*: New.
---
Changes since v1:
 - Use __or1k_cmov__ in *.S to conditionally use l.cmov insn
 - Use init/fini array making the crti/crtn basically blank

 libgcc/config.host                |  13 ++
 libgcc/config/or1k/crti.S         |  33 +++++
 libgcc/config/or1k/crtn.S         |   1 +
 libgcc/config/or1k/lib1funcs.S    | 223 ++++++++++++++++++++++++++++++
 libgcc/config/or1k/linux-unwind.h |  87 ++++++++++++
 libgcc/config/or1k/sfp-machine.h  |  54 ++++++++
 libgcc/config/or1k/t-or1k         |  22 +++
 7 files changed, 433 insertions(+)
 create mode 100644 libgcc/config/or1k/crti.S
 create mode 100644 libgcc/config/or1k/crtn.S
 create mode 100644 libgcc/config/or1k/lib1funcs.S
 create mode 100644 libgcc/config/or1k/linux-unwind.h
 create mode 100644 libgcc/config/or1k/sfp-machine.h
 create mode 100644 libgcc/config/or1k/t-or1k

diff --git a/libgcc/config.host b/libgcc/config.host
index 029f6569caf..8f4cff743ad 100644
--- a/libgcc/config.host
+++ b/libgcc/config.host
@@ -165,6 +165,9 @@ nds32*-*)
 nios2*-*-*)
 	cpu_type=nios2
 	;;
+or1k*-*-*)
+	cpu_type=or1k
+	;;
 powerpc*-*-*)
 	cpu_type=rs6000
 	;;
@@ -1039,6 +1042,16 @@ nios2-*-*)
 	tmake_file="$tmake_file nios2/t-nios2 t-softfp-sfdf t-softfp-excl t-softfp"
 	extra_parts="$extra_parts crti.o crtn.o"
 	;;
+or1k-*-linux*)
+	tmake_file="$tmake_file or1k/t-or1k"
+	tmake_file="$tmake_file t-softfp-sfdf t-softfp-excl t-softfp"
+	md_unwind_header=or1k/linux-unwind.h
+	;;
+or1k-*-*)
+	tmake_file="$tmake_file or1k/t-or1k"
+	tmake_file="$tmake_file t-softfp-sfdf t-softfp-excl t-softfp"
+	extra_parts="$extra_parts crti.o crtn.o"
+	;;
 pdp11-*-*)
 	tmake_file="pdp11/t-pdp11 t-fdpbit"
 	;;
diff --git a/libgcc/config/or1k/crti.S b/libgcc/config/or1k/crti.S
new file mode 100644
index 00000000000..9fcf6ae5995
--- /dev/null
+++ b/libgcc/config/or1k/crti.S
@@ -0,0 +1,33 @@
+/* Copyright (C) 2012-2018 Free Software Foundation, Inc.
+
+This file is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the
+Free Software Foundation; either version 3, or (at your option) any
+later version.
+
+This file is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+General Public License for more details.
+
+Under Section 7 of GPL version 3, you are granted additional
+permissions described in the GCC Runtime Library Exception, version
+3.1, as published by the Free Software Foundation.
+
+You should have received a copy of the GNU General Public License and
+a copy of the GCC Runtime Library Exception along with this program;
+see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+<http://www.gnu.org/licenses/>.  */
+
+/* Here _init and _fini are empty because .init_array/.fini_array are used
+   exclusively.  However, the functions are still needed as required when
+   linking.  */
+	.align 4
+	.global	_init
+	.type	_init, at function
+_init:
+	.global	_fini
+	.type	_fini, at function
+_fini:
+	l.jr	r9
+	 l.nop
diff --git a/libgcc/config/or1k/crtn.S b/libgcc/config/or1k/crtn.S
new file mode 100644
index 00000000000..ca6ee7b6fba
--- /dev/null
+++ b/libgcc/config/or1k/crtn.S
@@ -0,0 +1 @@
+/* crtn.S is empty because .init_array/.fini_array are used exclusively. */
diff --git a/libgcc/config/or1k/lib1funcs.S b/libgcc/config/or1k/lib1funcs.S
new file mode 100644
index 00000000000..354aadae8c4
--- /dev/null
+++ b/libgcc/config/or1k/lib1funcs.S
@@ -0,0 +1,223 @@
+/* Copyright (C) 2018 Free Software Foundation, Inc.
+
+This file is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the
+Free Software Foundation; either version 3, or (at your option) any
+later version.
+
+This file is distributed in the hope that it will be useful, but
+WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+General Public License for more details.
+
+Under Section 7 of GPL version 3, you are granted additional
+permissions described in the GCC Runtime Library Exception, version
+3.1, as published by the Free Software Foundation.
+
+You should have received a copy of the GNU General Public License and
+a copy of the GCC Runtime Library Exception along with this program;
+see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+<http://www.gnu.org/licenses/>.  */
+
+
+#ifdef L__mulsi3
+	.balign 4
+	.globl	__mulsi3
+	.type	__mulsi3, @function
+__mulsi3:
+	l.movhi		r11, 0			/* initial r */
+
+	/* Given R = X * Y ... */
+1:	l.sfeq		r4, r0			/* while (y != 0) */
+	l.bf		2f
+	 l.andi		r5, r4, 1		/* if (y & 1) ... */
+	l.add		r12, r11, r3
+	l.sfne		r5, r0
+#if defined(__or1k_cmov__)
+	l.cmov		r11, r12, r11		/* ... r += x. */
+	l.srli		r4, r4, 1		/* y >>= 1 */
+#else
+	l.bnf		3f
+	 l.srli		r4, r4, 1		/* y >>= 1 */
+	l.ori		r11, r12, 0
+3:
+#endif
+	l.j		1b
+	 l.add		r3, r3, r3		/* x <<= 1 */
+
+2:	l.jr		r9
+	 l.nop
+
+	.size	__mulsi3, . - __mulsi3
+#endif
+
+#if defined(L__udivsi3) || defined(L__umodsi3) \
+    || defined(L__divsi3) || defined(L__modsi3)
+	.global	__udivmodsi3_internal
+	.hidden	__udivmodsi3_internal
+	.type	__udivmodsi3_internal, @function
+#endif
+
+#ifdef L__udivsi3
+	.balign	4
+	.global	__udivsi3
+	.type	__udivsi3, @function
+__udivsi3:
+__udivmodsi3_internal:
+	/* Note that the other division routines assume that r13
+	   is not clobbered by this routine, and use that as to
+	   save a return address without creating a stack frame.  */
+
+        l.sfeqi		r4, 0		/* division by zero; return 0.  */
+        l.ori		r11, r0, 0	/* initial quotient */
+	l.bf		9f
+	 l.ori		r12, r3, 0	/* initial remainder */
+
+	/* Given X/Y, shift Y left until Y >= X.  */
+	l.ori		r6, r0, 1	/* mask = 1 */
+1:	l.sfltsi	r4, 0		/* y has msb set */
+	l.bf		2f
+	 l.sfltu	r4, r12		/* y < x */
+	l.add		r4, r4, r4	/* y <<= 1 */
+	l.bnf		1b
+	 l.add		r6, r6, r6	/* mask <<= 1 */
+
+	/* Shift Y back to the right again, subtracting from X.  */
+2:	l.add		r7, r11, r6	/* tmp1 = quot + mask */
+3:	l.srli		r6, r6, 1	/* mask >>= 1 */
+	l.sub		r8, r12, r4	/* tmp2 = x - y */
+	l.sfleu		r4, r12		/* y <= x */
+	l.srli		r4, r4, 1	/* y >>= 1 */
+#if defined(__or1k_cmov__)
+	l.cmov		r11, r7, r11	/* if (y <= x) quot = tmp1 */
+	l.cmov		r12, r8, r12	/* if (y <= x) x = tmp2 */
+#else
+	l.bnf		4f
+	 l.nop
+	l.ori		r11, r7, 0
+	l.ori		r12, r8, 0
+4:
+#endif
+	l.sfne		r6, r0		/* loop until mask == 0 */
+	l.bf		3b
+	 l.add		r7, r11, r6	/* delay fill from loop start */
+
+9:	l.jr		r9
+	 l.nop
+
+	.size	__udivsi3, . - __udivsi3
+	.size	__udivmodsi3_internal, . - __udivmodsi3_internal
+#endif
+
+#ifdef L__umodsi3
+	.balign	4
+	.global	__umodsi3
+	.type	__umodsi3, @function
+	.cfi_startproc
+__umodsi3:
+	/* Know that __udivmodsi3_internal does not clobber r13.  */
+	l.ori		r13, r9, 0
+	.cfi_register	9, 13
+	l.jal		__udivmodsi3_internal
+	 l.nop
+	l.jr		r13		/* return to saved lr */
+	 l.ori		r11, r12, 0	/* move remainder to rv */
+
+	.cfi_endproc
+	.size	__umodsi3, . - __umodsi3
+#endif
+
+/* For signed division we do:
+ *
+ *   -x / y = x / -y = -(x / y)
+ *   -x % y = -(x % y)
+ *   x % -y = x % b
+ *
+ * which has the property that (x/y)*y + (x%y) = x.
+ */
+
+#ifdef L__divsi3
+	.balign	4
+	.global	__divsi3
+	.type	__divsi3, @function
+	.cfi_startproc
+__divsi3:
+	l.xor		r6, r3, r4	/* need result negate?  */
+
+	l.sflts		r3, r0		/* abs(x) */
+#if defined(__or1k_cmov__)
+	l.sub		r5, r0, r3
+	l.cmov		r3, r5, r3
+#else
+	l.bnf		1f
+	 l.sub		r5, r0, r3
+	l.ori		r3, r5, 0
+1:
+#endif
+	l.sflts		r4, r0		/* abs(y) */
+#if defined(__or1k_cmov__)
+	l.sub		r5, r0, r4
+	l.cmov		r4, r5, r4
+#else
+	l.bnf		2f
+	 l.sub		r5, r0, r4
+	l.ori		r4, r5, 0
+2:
+#endif
+
+	/* If the result will not require sign flip, tail call.  */
+	l.sflts		r6, r0
+        l.bnf		__udivmodsi3_internal
+	 l.ori		r13, r9, 0	/* save lr */
+
+	/* Otherwise, know that __udivmodsi3_internal does not clobber r13.
+	   Perform a normal call, then negate and return via saved lr.  */
+	.cfi_register	9, 13
+        l.jal		__udivmodsi3_internal
+	 l.nop
+	l.jr		r13
+	 l.sub		r11, r0, r11
+
+	.cfi_endproc
+	.size	__divsi3, . - __divsi3
+#endif
+
+#ifdef L__modsi3
+	.balign	4
+	.global	__modsi3
+	.type	__modsi3, @function
+	.cfi_startproc
+__modsi3:
+	l.sflts		r4, r0		/* abs(y) */
+#if defined(__or1k_cmov__)
+	l.sub		r5, r0, r4
+	l.cmov		r4, r5, r4
+#else
+	l.bnf		2f
+	 l.sub		r5, r0, r4
+	l.ori		r4, r5, 0
+2:
+#endif
+
+	l.sflts		r3, r0		/* x negative? */
+	l.bf		1f
+	 l.ori		r13, r9, 0	/* save lr */
+
+	/* Know that __udivmodsi3_internal does not clobber r13.  */
+	.cfi_register	9, 13
+
+	/* X positive; no negate of the result required.  */
+	l.jal		__udivmodsi3_internal
+	 l.nop
+	l.jr		r13		/* return to saved lr */
+	 l.ori		r11, r12, 0	/* move remainder to rv */
+
+	/* X negative; negate both X and the result.  */
+1:	l.jal		__udivmodsi3_internal
+	 l.sub		r3, r0, r3
+	l.jr		r13		/* return to saved lr */
+	 l.sub		r11, r0, r12	/* negate remainder to rv */
+
+	.cfi_endproc
+	.size __modsi3, .- __modsi3
+#endif
diff --git a/libgcc/config/or1k/linux-unwind.h b/libgcc/config/or1k/linux-unwind.h
new file mode 100644
index 00000000000..e80e9e0f309
--- /dev/null
+++ b/libgcc/config/or1k/linux-unwind.h
@@ -0,0 +1,87 @@
+/* DWARF2 EH unwinding support for OpenRISC Linux.
+   Copyright (C) 2018 Free Software Foundation, Inc.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 3, or (at your option)
+any later version.
+
+GCC is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+Under Section 7 of GPL version 3, you are granted additional
+permissions described in the GCC Runtime Library Exception, version
+3.1, as published by the Free Software Foundation.
+
+You should have received a copy of the GNU General Public License and
+a copy of the GCC Runtime Library Exception along with this program;
+see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
+<http://www.gnu.org/licenses/>.  */
+
+#ifndef inhibit_libc
+/* Do code reading to identify a signal frame, and set the frame
+   state data appropriately.  See unwind-dw2.c for the structs.  */
+
+#include <signal.h>
+#include <sys/ucontext.h>
+
+#define MD_FALLBACK_FRAME_STATE_FOR or1k_fallback_frame_state
+
+static _Unwind_Reason_Code
+or1k_fallback_frame_state (struct _Unwind_Context *context,
+			   _Unwind_FrameState *fs)
+{
+  unsigned int *pc = context->ra;
+  struct rt_sigframe {
+    siginfo_t info;
+    ucontext_t uc;
+  } *rt;
+  struct sigcontext *sc;
+  long new_cfa;
+  int i;
+
+  if (pc[0] != 0xa960008b		/* l.ori r11, r0, NR_rt_sigreturn */
+      || pc[1] != 0x20000001)		/* l.sys 1 */
+    return _URC_END_OF_STACK;
+  if (context->cfa == 0)
+    return _URC_END_OF_STACK;
+
+  rt = context->cfa;
+  sc = &rt->uc.uc_mcontext;
+
+  new_cfa = sc->regs.gpr[1];
+  fs->regs.cfa_how = CFA_REG_OFFSET;
+  fs->regs.cfa_reg = 1;
+  fs->regs.cfa_offset = new_cfa - (long) context->cfa;
+  for (i = 2; i < 32; ++i)
+    {
+      fs->regs.reg[i].how = REG_SAVED_OFFSET;
+      fs->regs.reg[i].loc.offset = (long) &sc->regs.gpr[i] - new_cfa;
+    }
+  fs->regs.reg[32].how = REG_SAVED_OFFSET;
+  fs->regs.reg[32].loc.offset = (long)&sc->regs.pc - new_cfa;
+  fs->retaddr_column = 32;
+  fs->signal_frame = 1;
+
+  return _URC_NO_REASON;
+}
+
+#define MD_FROB_UPDATE_CONTEXT or1k_frob_update_context
+
+/* Fix up for signal handlers that don't have S flag set.  */
+
+static void
+or1k_frob_update_context (struct _Unwind_Context *context,
+			   _Unwind_FrameState *fs ATTRIBUTE_UNUSED)
+{
+  unsigned int *pc = context->ra;
+
+  if (pc[0] == 0xa960008b		/* l.ori r11, r0, NR_rt_sigreturn */
+      && pc[1] == 0x20000001)		/* l.sys 1 */
+    _Unwind_SetSignalFrame (context, 1);
+}
+#endif
diff --git a/libgcc/config/or1k/sfp-machine.h b/libgcc/config/or1k/sfp-machine.h
new file mode 100644
index 00000000000..5da9e84990d
--- /dev/null
+++ b/libgcc/config/or1k/sfp-machine.h
@@ -0,0 +1,54 @@
+#define _FP_W_TYPE_SIZE		32
+#define _FP_W_TYPE		unsigned long
+#define _FP_WS_TYPE		signed long
+#define _FP_I_TYPE		long
+
+#define _FP_MUL_MEAT_S(R,X,Y)				\
+  _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_D(R,X,Y)				\
+  _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_Q(R,X,Y)				\
+  _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
+#define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_loop(S,R,X,Y)
+#define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
+#define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
+
+#define _FP_NANFRAC_S		((_FP_QNANBIT_S << 1) - 1)
+#define _FP_NANFRAC_D		((_FP_QNANBIT_D << 1) - 1), -1
+#define _FP_NANFRAC_Q		((_FP_QNANBIT_Q << 1) - 1), -1, -1, -1
+#define _FP_NANSIGN_S		0
+#define _FP_NANSIGN_D		0
+#define _FP_NANSIGN_Q		0
+
+#define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
+
+/* Someone please check this.  */
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
+  do {								\
+    if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs)		\
+	&& !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs))	\
+      {								\
+	R##_s = Y##_s;						\
+	_FP_FRAC_COPY_##wc(R,Y);				\
+      }								\
+    else							\
+      {								\
+	R##_s = X##_s;						\
+	_FP_FRAC_COPY_##wc(R,X);				\
+      }								\
+    R##_c = FP_CLS_NAN;						\
+  } while (0)
+
+#define	__LITTLE_ENDIAN	1234
+#define	__BIG_ENDIAN	4321
+
+#define __BYTE_ORDER __BIG_ENDIAN
+
+#define _FP_TININESS_AFTER_ROUNDING 0
+
+/* Define ALIASNAME as a strong alias for NAME.  */
+# define strong_alias(name, aliasname) _strong_alias(name, aliasname)
+# define _strong_alias(name, aliasname) \
+  extern __typeof (name) aliasname __attribute__ ((alias (#name)));
diff --git a/libgcc/config/or1k/t-or1k b/libgcc/config/or1k/t-or1k
new file mode 100644
index 00000000000..73a703ac58d
--- /dev/null
+++ b/libgcc/config/or1k/t-or1k
@@ -0,0 +1,22 @@
+# Libgcc Makefile fragment for OpenRISC
+# Copyright (C) 2018 Free Software Foundation, Inc.
+# Contributed by Stafford Horne.
+#
+# This file is part of GCC.
+#
+# GCC is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published
+# by the Free Software Foundation; either version 3, or (at your
+# option) any later version.
+#
+# GCC is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+# License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with GCC; see the file COPYING3.  If not see
+# <http://www.gnu.org/licenses/>.
+
+LIB1ASMSRC = or1k/lib1funcs.S
+LIB1ASMFUNCS = __mulsi3 __udivsi3 __divsi3 __umodsi3 __modsi3
-- 
2.17.1

