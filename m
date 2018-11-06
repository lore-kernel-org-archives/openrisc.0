From: Stafford Horne <shorne@gmail.com>
Date: Wed,  7 Nov 2018 06:21:11 +0900
Subject: [OpenRISC] [PATCH v4 3/3] or1k: gcc: initial support for openrisc
In-Reply-To: <20181106212111.31800-1-shorne@gmail.com>
References: <20181106212111.31800-1-shorne@gmail.com>
Message-ID: <20181106212111.31800-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
	    Richard Henderson  <rth@twiddle.net>
	    Joel Sherrill  <joel@rtems.org>

gcc/ChangeLog:

	* common/config/or1k/or1k-common.c: New file.
	* config/or1k/*: New.
	* config.gcc (or1k*-*-*): New.
	* configure.ac (or1k*-*-*): New test for openrisc tls.
	* configure: Regenerated.
	* doc/install.texi: Document OpenRISC triplets.
	* doc/invoke.texi: Document OpenRISC arguments.
	* doc/md.texi: Document OpenRISC.
---
 gcc/common/config/or1k/or1k-common.c |   41 +
 gcc/config.gcc                       |   45 +
 gcc/config/or1k/constraints.md       |   55 +
 gcc/config/or1k/elf.h                |   42 +
 gcc/config/or1k/elf.opt              |   33 +
 gcc/config/or1k/linux.h              |   45 +
 gcc/config/or1k/or1k-protos.h        |   38 +
 gcc/config/or1k/or1k.c               | 2183 ++++++++++++++++++++++++++
 gcc/config/or1k/or1k.h               |  392 +++++
 gcc/config/or1k/or1k.md              |  897 +++++++++++
 gcc/config/or1k/or1k.opt             |   67 +
 gcc/config/or1k/predicates.md        |   84 +
 gcc/config/or1k/rtems.h              |   30 +
 gcc/config/or1k/t-or1k               |   22 +
 gcc/config/or1k/t-rtems              |    3 +
 gcc/configure                        |   12 +
 gcc/configure.ac                     |   12 +
 gcc/doc/install.texi                 |   19 +
 gcc/doc/invoke.texi                  |   68 +
 gcc/doc/md.texi                      |   25 +
 20 files changed, 4113 insertions(+)
 create mode 100644 gcc/common/config/or1k/or1k-common.c
 create mode 100644 gcc/config/or1k/constraints.md
 create mode 100644 gcc/config/or1k/elf.h
 create mode 100644 gcc/config/or1k/elf.opt
 create mode 100644 gcc/config/or1k/linux.h
 create mode 100644 gcc/config/or1k/or1k-protos.h
 create mode 100644 gcc/config/or1k/or1k.c
 create mode 100644 gcc/config/or1k/or1k.h
 create mode 100644 gcc/config/or1k/or1k.md
 create mode 100644 gcc/config/or1k/or1k.opt
 create mode 100644 gcc/config/or1k/predicates.md
 create mode 100644 gcc/config/or1k/rtems.h
 create mode 100644 gcc/config/or1k/t-or1k
 create mode 100644 gcc/config/or1k/t-rtems

diff --git a/gcc/common/config/or1k/or1k-common.c b/gcc/common/config/or1k/or1k-common.c
new file mode 100644
index 00000000000..044e843fd19
--- /dev/null
+++ b/gcc/common/config/or1k/or1k-common.c
@@ -0,0 +1,41 @@
+/* Common hooks for OpenRISC
+   Copyright (C) 2018 Free Software Foundation, Inc.
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 3, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING3.  If not see
+   <http://www.gnu.org/licenses/>.  */
+
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "diagnostic-core.h"
+#include "tm.h"
+#include "common/common-target.h"
+#include "common/common-target-def.h"
+#include "opts.h"
+#include "flags.h"
+
+/* Implement TARGET_OPTION_OPTIMIZATION_TABLE.  */
+static const struct default_options or1k_option_optimization_table[] =
+  {
+    /* Enable section anchors by default at -O1 or higher.  */
+    { OPT_LEVELS_1_PLUS, OPT_fsection_anchors, NULL, 1 },
+    { OPT_LEVELS_NONE, 0, NULL, 0 }
+  };
+
+#undef TARGET_OPTION_OPTIMIZATION_TABLE
+#define TARGET_OPTION_OPTIMIZATION_TABLE or1k_option_optimization_table
+
+struct gcc_targetm_common targetm_common = TARGETM_COMMON_INITIALIZER;
diff --git a/gcc/config.gcc b/gcc/config.gcc
index 284f7d178de..7ef8d27f091 100644
--- a/gcc/config.gcc
+++ b/gcc/config.gcc
@@ -484,6 +484,9 @@ nios2-*-*)
 nvptx-*-*)
 	cpu_type=nvptx
 	;;
+or1k*-*-*)
+	cpu_type=or1k
+	;;
 powerpc*-*-*spe*)
 	cpu_type=powerpcspe
 	extra_headers="ppc-asm.h altivec.h spe.h ppu_intrinsics.h paired.h spu2vmx.h vec_types.h si2vmx.h htmintrin.h htmxlintrin.h"
@@ -2490,6 +2493,48 @@ nvptx-*)
 		tm_file="${tm_file} nvptx/offload.h"
 	fi
 	;;
+or1k*-*-*)
+	tm_file="elfos.h ${tm_file}"
+	tmake_file="${tmake_file} or1k/t-or1k"
+	# Force .init_array support.  The configure script cannot always
+	# automatically detect that GAS supports it, yet we require it.
+	gcc_cv_initfini_array=yes
+
+	# Handle --with-multilib-list=...
+	or1k_multilibs="${with_multilib_list}"
+	if test "$or1k_multilibs" = "default"; then
+		or1k_multilibs="mcmov,msoft-mul,msoft-div"
+	fi
+	or1k_multilibs=`echo $or1k_multilibs | sed -e 's/,/ /g'`
+	for or1k_multilib in ${or1k_multilibs}; do
+		case ${or1k_multilib} in
+		mcmov | msext | msfimm | \
+		mhard-div | mhard-mul | \
+		msoft-div | msoft-mul )
+			TM_MULTILIB_CONFIG="${TM_MULTILIB_CONFIG},${or1k_multilib}"
+			;;
+		*)
+			echo "--with-multilib-list=${with_multilib_list} not supported."
+			exit 1
+		esac
+	done
+	TM_MULTILIB_CONFIG=`echo $TM_MULTILIB_CONFIG | sed 's/^,//'`
+
+        case ${target} in
+        or1k*-*-linux*)
+                tm_file="${tm_file} gnu-user.h linux.h glibc-stdint.h"
+                tm_file="${tm_file} or1k/linux.h"
+                ;;
+	or1k*-*-elf*)
+		tm_file="${tm_file} newlib-stdint.h or1k/elf.h"
+		extra_options="${extra_options} or1k/elf.opt"
+		;;
+	or1k*-*-rtems*)
+		tm_file="${tm_file} newlib-stdint.h or1k/rtems.h rtems.h"
+		tmake_file="${tmake_file} or1k/t-rtems"
+		;;
+	esac
+	;;
 pdp11-*-*)
 	tm_file="${tm_file} newlib-stdint.h"
 	use_gcc_stdint=wrap
diff --git a/gcc/config/or1k/constraints.md b/gcc/config/or1k/constraints.md
new file mode 100644
index 00000000000..2e7797b72fb
--- /dev/null
+++ b/gcc/config/or1k/constraints.md
@@ -0,0 +1,55 @@
+;; Constraint definitions for OpenRISC
+;; Copyright (C) 2018 Free Software Foundation, Inc.
+;; Contributed by Stafford Horne
+
+;; This file is part of GCC.
+
+;; GCC is free software; you can redistribute it and/or modify it
+;; under the terms of the GNU General Public License as published
+;; by the Free Software Foundation; either version 3, or (at your
+;; option) any later version.
+
+;; GCC is distributed in the hope that it will be useful, but WITHOUT
+;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+;; License for more details.
+
+;; You should have received a copy of the GNU General Public License
+;; along with GCC; see the file COPYING3.  If not see
+;; <http://www.gnu.org/licenses/>.
+
+;; -------------------------------------------------------------------------
+;; Constraints
+;; -------------------------------------------------------------------------
+
+; We use:
+;  c - sibcall registers
+;  I - constant signed 16-bit
+;  K - constant unsigned 16-bit
+;  M - constant signed 16-bit shifted left 16-bits (l.movhi)
+;  O - constant zero
+
+(define_register_constraint "c" "SIBCALL_REGS"
+  "Registers which can hold a sibling call address")
+
+;; Immediates
+(define_constraint "I"
+  "A signed 16-bit immediate in the range -32768 to 32767."
+  (and (match_code "const_int")
+       (match_test "IN_RANGE (ival, -32768, 32767)")))
+
+(define_constraint "K"
+  "An unsigned 16-bit immediate in the range 0 to 0xffff."
+  (and (match_code "const_int")
+       (match_test "IN_RANGE (ival, 0, 65535)")))
+
+(define_constraint "M"
+  "A shifted signed 16-bit constant suitable for l.movhi."
+  (and (match_code "const_int")
+       (match_test "(ival & 0xffff) == 0
+		    && (ival >> 31 == -1 || ival >> 31 == 0)")))
+
+(define_constraint "O"
+  "The constant zero"
+  (and (match_code "const_int")
+       (match_test "ival == 0")))
diff --git a/gcc/config/or1k/elf.h b/gcc/config/or1k/elf.h
new file mode 100644
index 00000000000..7d2d19f06ce
--- /dev/null
+++ b/gcc/config/or1k/elf.h
@@ -0,0 +1,42 @@
+/* Target Newlib Definitions for OpenRISC.
+   Copyright (C) 2018 Free Software Foundation, Inc.
+   Contributed by Stafford Horne.
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 3, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING3.  If not see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef GCC_OR1K_ELF_H
+#define GCC_OR1K_ELF_H
+
+#undef  LIB_SPEC
+#define LIB_SPEC "--start-group -lc -lor1k "			\
+  "%{mboard=*:-lboard-%*; :-lboard-or1ksim} --end-group"
+
+#undef	LINK_SPEC
+#define LINK_SPEC "%{h*}			\
+   %{static:-Bstatic}				\
+   %{shared:-shared}				\
+   %{symbolic:-Bsymbolic}			\
+   %{!static:%{rdynamic:-export-dynamic}}	\
+   --entry=0x100"
+
+#undef  STARTFILE_SPEC
+#define STARTFILE_SPEC "crt0.o%s crtbegin.o%s"
+
+#undef  ENDFILE_SPEC
+#define ENDFILE_SPEC "crtend.o%s"
+
+#endif /* GCC_OR1K_ELF_H */
diff --git a/gcc/config/or1k/elf.opt b/gcc/config/or1k/elf.opt
new file mode 100644
index 00000000000..956d395003d
--- /dev/null
+++ b/gcc/config/or1k/elf.opt
@@ -0,0 +1,33 @@
+; OpenRISC command line options for newlib binaries
+
+; Copyright (C) 2010-2018 Free Software Foundation, Inc.
+;
+; This file is part of GCC.
+;
+; GCC is free software; you can redistribute it and/or modify it under
+; the terms of the GNU General Public License as published by the Free
+; Software Foundation; either version 3, or (at your option) any later
+; version.
+;
+; GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+; WARRANTY; without even the implied warranty of MERCHANTABILITY or
+; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+; for more details.
+;
+; You should have received a copy of the GNU General Public License
+; along with GCC; see the file COPYING3.  If not see
+; <http://www.gnu.org/licenses/>.
+
+; See the GCC internals manual (options.texi) for a description of
+; this file's format.
+
+; Please try to keep this file in ASCII collating order.
+
+mboard=
+Target RejectNegative Joined
+Configure board specific runtime.
+
+mnewlib
+Target RejectNegative
+For compatibility, it's always newlib for elf now.
+
diff --git a/gcc/config/or1k/linux.h b/gcc/config/or1k/linux.h
new file mode 100644
index 00000000000..c734a2afd5a
--- /dev/null
+++ b/gcc/config/or1k/linux.h
@@ -0,0 +1,45 @@
+/* Linux Definitions for OpenRISC.
+   Copyright (C) 2018 Free Software Foundation, Inc.
+   Contributed by Stafford Horne.
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 3, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING3.  If not see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef GCC_OR1K_LINUX_H
+#define GCC_OR1K_LINUX_H
+
+/* elfos.h should have already been included.  Now just override
+   any conflicting definitions and add any extras.  */
+
+#define TARGET_OS_CPP_BUILTINS() \
+  GNU_USER_TARGET_OS_CPP_BUILTINS ()
+
+#define GLIBC_DYNAMIC_LINKER "/lib/ld-linux-or1k.so.1"
+
+#undef MUSL_DYNAMIC_LINKER
+#define MUSL_DYNAMIC_LINKER  "/lib/ld-musl-or1k.so.1"
+
+#undef LINK_SPEC
+#define LINK_SPEC "%{h*}			\
+   %{static:-Bstatic}				\
+   %{shared:-shared}				\
+   %{symbolic:-Bsymbolic}			\
+   %{!static:%{!static-pie:			\
+     %{rdynamic:-export-dynamic}		\
+     %{!shared:-dynamic-linker " GNU_USER_DYNAMIC_LINKER "}}} \
+   %{static-pie:-Bstatic -pie --no-dynamic-linker -z text}"
+
+#endif /* GCC_OR1K_LINUX_H */
diff --git a/gcc/config/or1k/or1k-protos.h b/gcc/config/or1k/or1k-protos.h
new file mode 100644
index 00000000000..e18383ae781
--- /dev/null
+++ b/gcc/config/or1k/or1k-protos.h
@@ -0,0 +1,38 @@
+/* Prototypes for OpenRISC functions used in the md file & elsewhere.
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
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+extern HOST_WIDE_INT or1k_initial_elimination_offset (int, int);
+extern void or1k_expand_prologue (void);
+extern void or1k_expand_epilogue (void);
+extern void or1k_expand_eh_return (rtx);
+extern rtx  or1k_initial_frame_addr (void);
+extern rtx  or1k_dynamic_chain_addr (rtx);
+extern rtx  or1k_return_addr (int, rtx);
+extern void or1k_expand_move (machine_mode, rtx, rtx);
+extern void or1k_expand_compare (rtx *);
+extern void or1k_expand_call (rtx, rtx, rtx, bool);
+
+#ifdef RTX_CODE
+void or1k_expand_atomic_compare_and_swap (rtx operands[]);
+void or1k_expand_atomic_compare_and_swap_qihi (rtx operands[]);
+void or1k_expand_atomic_exchange (rtx operands[]);
+void or1k_expand_atomic_exchange_qihi (rtx operands[]);
+void or1k_expand_atomic_op (rtx_code, rtx, rtx, rtx, rtx);
+void or1k_expand_atomic_op_qihi (rtx_code, rtx, rtx, rtx, rtx);
+#endif
diff --git a/gcc/config/or1k/or1k.c b/gcc/config/or1k/or1k.c
new file mode 100644
index 00000000000..27cc73f76fe
--- /dev/null
+++ b/gcc/config/or1k/or1k.c
@@ -0,0 +1,2183 @@
+/* Target Code for OpenRISC
+   Copyright (C) 2018 Free Software Foundation, Inc.
+   Contributed by Stafford Horne based on other ports.
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 3, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING3.  If not see
+   <http://www.gnu.org/licenses/>.  */
+
+#define IN_TARGET_CODE 1
+
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "backend.h"
+#include "target.h"
+#include "rtl.h"
+#include "tree.h"
+#include "stringpool.h"
+#include "attribs.h"
+#include "df.h"
+#include "regs.h"
+#include "memmodel.h"
+#include "emit-rtl.h"
+#include "diagnostic-core.h"
+#include "output.h"
+#include "stor-layout.h"
+#include "varasm.h"
+#include "calls.h"
+#include "expr.h"
+#include "builtins.h"
+#include "optabs.h"
+#include "explow.h"
+#include "cfgrtl.h"
+#include "alias.h"
+
+/* These 4 are needed to allow using satisfies_constraint_J.  */
+#include "insn-config.h"
+#include "recog.h"
+#include "tm_p.h"
+#include "tm-constrs.h"
+
+/* This file should be included last.  */
+#include "target-def.h"
+
+/* Per-function machine data.  */
+struct GTY(()) machine_function
+{
+  /* Number of bytes saved on the stack for callee saved registers.  */
+  HOST_WIDE_INT callee_saved_reg_size;
+
+  /* Number of bytes saved on the stack for local variables.  */
+  HOST_WIDE_INT local_vars_size;
+
+  /* Number of bytes saved on the stack for outgoing/sub-function args.  */
+  HOST_WIDE_INT args_size;
+
+  /* The sum of sizes: locals vars, called saved regs, stack pointer
+     and an optional frame pointer.
+     Used in expand_prologue () and expand_epilogue ().  */
+  HOST_WIDE_INT total_size;
+
+  /* Remember where the set_got_placeholder is located.  */
+  rtx_insn *set_got_insn;
+};
+
+/* Zero initialization is OK for all current fields.  */
+
+static struct machine_function *
+or1k_init_machine_status (void)
+{
+  return ggc_cleared_alloc<machine_function> ();
+}
+
+
+/* Worker for TARGET_OPTION_OVERRIDE.
+   We currently only use this to setup init_machine_status.  */
+
+static void
+or1k_option_override (void)
+{
+  /* Set the per-function-data initializer.  */
+  init_machine_status = or1k_init_machine_status;
+}
+
+/* Returns true if REGNO must be saved for the current function.  */
+
+static bool
+callee_saved_regno_p (int regno)
+{
+  /* Check call-saved registers.  */
+  if (!call_used_regs[regno] && df_regs_ever_live_p (regno))
+    return true;
+
+  switch (regno)
+    {
+    case HARD_FRAME_POINTER_REGNUM:
+      return frame_pointer_needed;
+
+    case LR_REGNUM:
+      /* Always save LR if we are saving HFP, producing a walkable
+	 stack chain with -fno-omit-frame-pointer.  */
+      return (frame_pointer_needed
+	      || !crtl->is_leaf
+	      || crtl->uses_pic_offset_table
+	      || df_regs_ever_live_p (regno));
+
+    case HW_TO_GCC_REGNO (25):
+    case HW_TO_GCC_REGNO (27):
+    case HW_TO_GCC_REGNO (29):
+    case HW_TO_GCC_REGNO (31):
+      /* See EH_RETURN_DATA_REGNO.  */
+      return crtl->calls_eh_return;
+
+    default:
+      return false;
+    }
+}
+
+/* Worker for TARGET_COMPUTE_FRAME_LAYOUT.
+   Compute and populate machine specific function attributes which are globally
+   accessible via cfun->machine.  These include the sizes needed for
+   stack stored local variables, callee saved registers and space for stack
+   arguments which may be passed to a next function.  The values are used for
+   the epilogue, prologue and eliminations.
+
+   OpenRISC stack grows downwards and contains:
+
+    ---- previous frame --------
+    current func arg[n]
+    current func arg[0]   <-- r2 [HFP,AP]
+    ---- current stack frame ---  ^  ---\
+    return address      r9        |     |
+    old frame pointer   r2       (+)    |-- machine->total_size
+    callee saved regs             |     | > machine->callee_saved_reg_size
+    local variables               |     | > machine->local_vars_size       <-FP
+    next function args    <-- r1 [SP]---/ > machine->args_size
+    ----------------------------  |
+				 (-)
+	   (future)               |
+				  V
+
+   All of these contents are optional.  */
+
+static void
+or1k_compute_frame_layout (void)
+{
+  HOST_WIDE_INT local_vars_size, args_size, save_reg_size;
+
+  local_vars_size = get_frame_size ();
+  local_vars_size = ROUND_UP (local_vars_size, UNITS_PER_WORD);
+
+  args_size = crtl->outgoing_args_size;
+  args_size = ROUND_UP (args_size, UNITS_PER_WORD);
+
+  save_reg_size = 0;
+  for (int regno = 0; regno < FIRST_PSEUDO_REGISTER; regno++)
+    if (callee_saved_regno_p (regno))
+      save_reg_size += UNITS_PER_WORD;
+
+  cfun->machine->local_vars_size = local_vars_size;
+  cfun->machine->args_size = args_size;
+  cfun->machine->callee_saved_reg_size = save_reg_size;
+  cfun->machine->total_size = save_reg_size + local_vars_size + args_size;
+}
+
+/* Emit rtl to save register REGNO contents to stack memory at the given OFFSET
+   from the current stack pointer.  */
+
+static void
+or1k_save_reg (int regno, HOST_WIDE_INT offset)
+{
+  rtx reg = gen_rtx_REG (Pmode, regno);
+  rtx mem = gen_frame_mem (SImode, plus_constant (Pmode, stack_pointer_rtx,
+						  offset));
+  rtx insn = emit_move_insn (mem, reg);
+  RTX_FRAME_RELATED_P (insn) = 1;
+}
+
+/* Emit rtl to restore register REGNO contents from stack memory at the given
+   OFFSET from the current stack pointer.  */
+
+static rtx
+or1k_restore_reg (int regno, HOST_WIDE_INT offset, rtx cfa_restores)
+{
+  rtx reg = gen_rtx_REG (Pmode, regno);
+  rtx mem = gen_frame_mem (SImode, plus_constant (Pmode, stack_pointer_rtx,
+						  offset));
+  emit_move_insn (reg, mem);
+  return alloc_reg_note (REG_CFA_RESTORE, reg, cfa_restores);
+}
+
+/* Expand the "prologue" pattern.  */
+
+void
+or1k_expand_prologue (void)
+{
+  HOST_WIDE_INT sp_offset = -cfun->machine->total_size;
+  HOST_WIDE_INT reg_offset, this_offset;
+  rtx insn;
+
+  if (flag_stack_usage_info)
+    current_function_static_stack_size = -sp_offset;
+
+  /* Early exit for frameless functions.  */
+  if (sp_offset == 0)
+    goto fini;
+
+  /* Adjust the stack pointer.  For large stack offsets we will
+     do this in multiple parts, before and after saving registers.  */
+  reg_offset = (sp_offset + cfun->machine->local_vars_size
+		+ cfun->machine->args_size);
+  this_offset = MAX (sp_offset, -32764);
+  reg_offset -= this_offset;
+  sp_offset -= this_offset;
+
+  insn = emit_insn (gen_frame_addsi3 (stack_pointer_rtx, stack_pointer_rtx,
+				      GEN_INT (this_offset)));
+  RTX_FRAME_RELATED_P (insn) = 1;
+
+  /* Save callee-saved registers.  */
+  for (int regno = 0; regno < FIRST_PSEUDO_REGISTER; regno++)
+    if (regno != HARD_FRAME_POINTER_REGNUM
+	&& regno != LR_REGNUM
+	&& callee_saved_regno_p (regno))
+      {
+	or1k_save_reg (regno, reg_offset);
+	reg_offset += UNITS_PER_WORD;
+      }
+
+  /* Save and update frame pointer.  */
+  if (callee_saved_regno_p (HARD_FRAME_POINTER_REGNUM))
+    {
+      or1k_save_reg (HARD_FRAME_POINTER_REGNUM, reg_offset);
+      if (frame_pointer_needed)
+	{
+	  insn = emit_insn (gen_addsi3 (hard_frame_pointer_rtx,
+					stack_pointer_rtx,
+					GEN_INT (-this_offset)));
+	  RTX_FRAME_RELATED_P (insn) = 1;
+	}
+      reg_offset += UNITS_PER_WORD;
+    }
+
+  /* Save the link register.  */
+  if (callee_saved_regno_p (LR_REGNUM))
+    {
+      or1k_save_reg (LR_REGNUM, reg_offset);
+      reg_offset += UNITS_PER_WORD;
+    }
+  gcc_assert (reg_offset + this_offset == 0);
+
+  /* Allocate the rest of the stack frame, if any.  */
+  if (sp_offset != 0)
+    {
+      if (sp_offset < 2 * -32768)
+	{
+	  /* For very large offsets, we need a temporary register.  */
+	  rtx tmp = gen_rtx_REG (Pmode, PE_TMP_REGNUM);
+	  emit_move_insn (tmp, GEN_INT (sp_offset));
+	  insn = emit_insn (gen_frame_addsi3 (stack_pointer_rtx,
+					      stack_pointer_rtx, tmp));
+	  if (!frame_pointer_needed)
+	    {
+	      RTX_FRAME_RELATED_P (insn) = 1;
+	      add_reg_note (insn, REG_CFA_ADJUST_CFA,
+			    gen_rtx_SET (stack_pointer_rtx,
+					 plus_constant (Pmode,
+							stack_pointer_rtx,
+							sp_offset)));
+	    }
+	}
+      else
+	{
+	  /* Otherwise, emit one or two sequential subtracts.  */
+	  do
+	    {
+	      this_offset = MAX (sp_offset, -32768);
+	      sp_offset -= this_offset;
+
+	      insn = emit_insn (gen_frame_addsi3 (stack_pointer_rtx,
+						  stack_pointer_rtx,
+						  GEN_INT (this_offset)));
+	      if (!frame_pointer_needed)
+		RTX_FRAME_RELATED_P (insn) = 1;
+	    }
+	  while (sp_offset != 0);
+	}
+    }
+
+ fini:
+  /* Fix up, or remove, the insn that initialized the pic register.  */
+  rtx_insn *set_got_insn = cfun->machine->set_got_insn;
+  if (crtl->uses_pic_offset_table)
+    {
+      rtx reg = SET_DEST (PATTERN (set_got_insn));
+      rtx_insn *insn = emit_insn_before (gen_set_got (reg), set_got_insn);
+      RTX_FRAME_RELATED_P (insn) = 1;
+      add_reg_note (insn, REG_CFA_FLUSH_QUEUE, NULL_RTX);
+    }
+  delete_insn (set_got_insn);
+}
+
+/* Expand the "epilogue" pattern.  */
+
+void
+or1k_expand_epilogue (void)
+{
+  HOST_WIDE_INT reg_offset, sp_offset;
+  rtx insn, cfa_restores = NULL;
+
+  sp_offset = cfun->machine->total_size;
+  if (sp_offset == 0)
+    return;
+
+  reg_offset = cfun->machine->local_vars_size + cfun->machine->args_size;
+
+  if (sp_offset >= 32768 || cfun->calls_alloca)
+    {
+      /* The saved registers are out of range of the stack pointer.
+	 We need to partially deallocate the stack frame now.  */
+      if (frame_pointer_needed)
+	{
+	  /* Reset the stack pointer to the bottom of the saved regs.  */
+	  sp_offset -= reg_offset;
+	  reg_offset = 0;
+	  insn = emit_insn (gen_frame_addsi3 (stack_pointer_rtx,
+					      hard_frame_pointer_rtx,
+					      GEN_INT (-sp_offset)));
+	  RTX_FRAME_RELATED_P (insn) = 1;
+	  add_reg_note (insn, REG_CFA_DEF_CFA,
+			plus_constant (Pmode, stack_pointer_rtx, sp_offset));
+	}
+      else if (sp_offset >= 3 * 32768)
+	{
+	  /* For very large offsets, we need a temporary register.  */
+	  rtx tmp = gen_rtx_REG (Pmode, PE_TMP_REGNUM);
+	  emit_move_insn (tmp, GEN_INT (reg_offset));
+	  insn = emit_insn (gen_frame_addsi3 (stack_pointer_rtx,
+					      stack_pointer_rtx, tmp));
+	  sp_offset -= reg_offset;
+	  reg_offset = 0;
+	  RTX_FRAME_RELATED_P (insn) = 1;
+	  add_reg_note (insn, REG_CFA_DEF_CFA,
+			plus_constant (Pmode, stack_pointer_rtx, sp_offset));
+	}
+      else
+	{
+	  /* Otherwise, emit one or two sequential additions.  */
+	  do
+	    {
+	      HOST_WIDE_INT this_offset = MIN (reg_offset, 32764);
+	      reg_offset -= this_offset;
+	      sp_offset -= this_offset;
+
+	      insn = emit_insn (gen_frame_addsi3 (stack_pointer_rtx,
+						  stack_pointer_rtx,
+						  GEN_INT (this_offset)));
+	      RTX_FRAME_RELATED_P (insn) = 1;
+	      add_reg_note (insn, REG_CFA_DEF_CFA,
+			    plus_constant (Pmode, stack_pointer_rtx,
+					   sp_offset));
+	    }
+	  while (sp_offset >= 32768);
+	}
+    }
+
+  /* Restore callee-saved registers.  */
+  for (int regno = 0; regno < FIRST_PSEUDO_REGISTER; regno++)
+    if (regno != HARD_FRAME_POINTER_REGNUM
+	&& regno != LR_REGNUM
+	&& callee_saved_regno_p (regno))
+      {
+	cfa_restores = or1k_restore_reg (regno, reg_offset, cfa_restores);
+	reg_offset += UNITS_PER_WORD;
+      }
+
+  /* Restore frame pointer.  */
+  if (callee_saved_regno_p (HARD_FRAME_POINTER_REGNUM))
+    {
+      cfa_restores = or1k_restore_reg (HARD_FRAME_POINTER_REGNUM,
+				       reg_offset, cfa_restores);
+      reg_offset += UNITS_PER_WORD;
+    }
+
+  /* Restore link register.  */
+  if (callee_saved_regno_p (LR_REGNUM))
+    {
+      cfa_restores = or1k_restore_reg (LR_REGNUM, reg_offset, cfa_restores);
+      reg_offset += UNITS_PER_WORD;
+    }
+  gcc_assert (reg_offset == sp_offset);
+
+  /* Restore stack pointer.  */
+  insn = emit_insn (gen_frame_addsi3 (stack_pointer_rtx, stack_pointer_rtx,
+				      GEN_INT (sp_offset)));
+  RTX_FRAME_RELATED_P (insn) = 1;
+  REG_NOTES (insn) = cfa_restores;
+  add_reg_note (insn, REG_CFA_DEF_CFA, stack_pointer_rtx);
+
+  /* Move up to the stack frame of an exception handler.  */
+  if (crtl->calls_eh_return)
+    emit_insn (gen_addsi3 (stack_pointer_rtx, stack_pointer_rtx,
+			   EH_RETURN_STACKADJ_RTX));
+}
+
+/* Worker for TARGET_INIT_PIC_REG.
+   Initialize the cfun->machine->set_got_insn rtx and insert it at the entry
+   of the current function.  The rtx is just a temporary placeholder for
+   the GOT and will be replaced or removed during or1k_expand_prologue.  */
+
+static void
+or1k_init_pic_reg (void)
+{
+  start_sequence ();
+
+  cfun->machine->set_got_insn
+    = emit_insn (gen_set_got_tmp (pic_offset_table_rtx));
+
+  rtx_insn *seq = get_insns ();
+  end_sequence ();
+
+  edge entry_edge = single_succ_edge (ENTRY_BLOCK_PTR_FOR_FN (cfun));
+  insert_insn_on_edge (seq, entry_edge);
+  commit_one_edge_insertion (entry_edge);
+}
+
+#undef TARGET_INIT_PIC_REG
+#define TARGET_INIT_PIC_REG  or1k_init_pic_reg
+#undef TARGET_USE_PSEUDO_PIC_REG
+#define TARGET_USE_PSEUDO_PIC_REG  hook_bool_void_true
+
+/* Worker for INITIAL_FRAME_ADDRESS_RTX.
+   Returns the RTX representing the address of the initial stack frame.  */
+
+rtx
+or1k_initial_frame_addr ()
+{
+  /* Use this to force a stack frame for the current function.  */
+  crtl->accesses_prior_frames = 1;
+  return arg_pointer_rtx;
+}
+
+/* Worker for DYNAMIC_CHAIN_ADDRESS.
+   Returns the RTX representing the address of where the caller's frame pointer
+   may be stored on the stack.  */
+
+rtx
+or1k_dynamic_chain_addr (rtx frame)
+{
+  return plus_constant (Pmode, frame, -2 * UNITS_PER_WORD);
+}
+
+/* Worker for RETURN_ADDR_RTX.
+   Returns the RTX representing the address of where the link register may be
+   stored on the stack.  */
+
+rtx
+or1k_return_addr (int, rtx frame)
+{
+  return gen_frame_mem (Pmode, plus_constant (Pmode, frame, -UNITS_PER_WORD));
+}
+
+/* Worker for TARGET_FRAME_POINTER_REQUIRED.
+   Returns true if the current function must use a frame pointer.  */
+
+static bool
+or1k_frame_pointer_required ()
+{
+  /* ??? While IRA checks accesses_prior_frames, reload does not.
+     We do want the frame pointer for this case.  */
+  return (crtl->accesses_prior_frames || crtl->profile);
+}
+
+/* Expand the "eh_return" pattern.
+   Used for defining __builtin_eh_return, this will emit RTX to override the
+   current function's return address stored on the stack.  The emitted RTX is
+   inserted before the epilogue so we can't just update the link register.
+   This is used when handling exceptions to jump into the exception handler
+   catch block upon return from _Unwind_RaiseException.  */
+
+void
+or1k_expand_eh_return (rtx eh_addr)
+{
+  rtx lraddr;
+
+  lraddr = gen_frame_mem (Pmode, plus_constant (Pmode,
+						arg_pointer_rtx,
+						-UNITS_PER_WORD));
+  /* Set address to volatile to ensure the store doesn't get optimized out.  */
+  MEM_VOLATILE_P (lraddr) = true;
+  emit_move_insn (lraddr, eh_addr);
+}
+
+/* Helper for defining INITIAL_ELIMINATION_OFFSET.
+   We allow the following eliminiations:
+     FP -> HARD_FP or SP
+     AP -> HARD_FP or SP
+
+   HARD_FP and AP are the same which is handled below.  */
+
+HOST_WIDE_INT
+or1k_initial_elimination_offset (int from, int to)
+{
+  HOST_WIDE_INT offset;
+
+  /* Set OFFSET to the offset from the stack pointer.  */
+  switch (from)
+    {
+    /* Incoming args are all the way up at the previous frame.  */
+    case ARG_POINTER_REGNUM:
+      offset = cfun->machine->total_size;
+      break;
+
+    /* Local args grow downward from the saved registers.  */
+    case FRAME_POINTER_REGNUM:
+      offset = cfun->machine->args_size + cfun->machine->local_vars_size;
+      break;
+
+    default:
+      gcc_unreachable ();
+    }
+
+  if (to == HARD_FRAME_POINTER_REGNUM)
+    offset -= cfun->machine->total_size;
+
+  return offset;
+}
+
+/* Worker for TARGET_LEGITIMATE_ADDRESS_P.
+   Returns true if X is a legitimate address RTX on OpenRISC.  */
+
+static bool
+or1k_legitimate_address_p (machine_mode, rtx x, bool strict_p)
+{
+  rtx base, addend;
+
+  switch (GET_CODE (x))
+    {
+    case REG:
+      base = x;
+      break;
+
+    case PLUS:
+      base = XEXP (x, 0);
+      addend = XEXP (x, 1);
+      if (!REG_P (base))
+	return false;
+      /* Register elimination is going to adjust all of these offsets.
+	 We might as well keep them as a unit until then.  */
+      if (!strict_p && virtual_frame_reg_operand (base, VOIDmode))
+	return CONST_INT_P (addend);
+      if (!satisfies_constraint_I (addend))
+	return false;
+      break;
+
+    case LO_SUM:
+      base = XEXP (x, 0);
+      if (!REG_P (base))
+	return false;
+      x = XEXP (x, 1);
+      switch (GET_CODE (x))
+	{
+	case CONST:
+	case SYMBOL_REF:
+	case LABEL_REF:
+	  /* Assume legitimize_address properly categorized
+	     the symbol.  Continue to check the base.  */
+	  break;
+
+	case UNSPEC:
+	  switch (XINT (x, 1))
+	    {
+	    case UNSPEC_GOT:
+	    case UNSPEC_GOTOFF:
+	    case UNSPEC_TPOFF:
+	    case UNSPEC_GOTTPOFF:
+	      /* Assume legitimize_address properly categorized
+	         the symbol.  Continue to check the base.  */
+	      break;
+	    default:
+	      return false;
+	    }
+	  break;
+
+	default:
+	  return false;
+	}
+      break;
+
+    default:
+      return false;
+    }
+
+  unsigned regno = REGNO (base);
+  if (regno >= FIRST_PSEUDO_REGISTER)
+    {
+      if (strict_p)
+	regno = reg_renumber[regno];
+      else
+	return true;
+    }
+  if (strict_p)
+    return regno <= 31;
+  else
+    return REGNO_OK_FOR_BASE_P (regno);
+}
+
+/* Return the TLS type for TLS symbols, 0 otherwise.  */
+
+static tls_model
+or1k_tls_symbolic_operand (rtx op)
+{
+  rtx sym, addend;
+  split_const (op, &sym, &addend);
+  if (SYMBOL_REF_P (sym))
+    return SYMBOL_REF_TLS_MODEL (sym);
+  return TLS_MODEL_NONE;
+}
+
+/* Get a reference to the '__tls_get_addr' symbol.  */
+
+static GTY(()) rtx gen_tls_tga;
+
+static rtx
+gen_tls_get_addr (void)
+{
+  if (!gen_tls_tga)
+    gen_tls_tga = init_one_libfunc ("__tls_get_addr");
+  return gen_tls_tga;
+}
+
+/* Emit a call to '__tls_get_addr'.  */
+
+static void
+or1k_tls_call (rtx dest, rtx arg)
+{
+  emit_library_call_value (gen_tls_get_addr (), dest, LCT_CONST,
+			   Pmode, arg, Pmode);
+}
+
+/* Helper for or1k_legitimize_address_1.  Wrap X in an unspec.  */
+
+static rtx
+gen_sym_unspec (rtx x, int kind)
+{
+  return gen_rtx_UNSPEC (Pmode, gen_rtvec (1, x), kind);
+}
+
+/* Worker for TARGET_LEGITIMIZE_ADDRESS_DISPLACEMENT.
+   Split an out-of-range address displacement into hi and lo parts.
+   The hi part will have to be loaded into a register separately,
+   but the low part will be folded into the memory operand.  */
+
+static bool
+or1k_legitimize_address_displacement (rtx *off1, rtx *off2,
+				      poly_int64 poly_offset, machine_mode)
+{
+  HOST_WIDE_INT orig_offset = poly_offset;
+  HOST_WIDE_INT lo, hi;
+
+  /* If the displacement is within range of 2 addi insns, prefer that.
+     Otherwise split as per normal,@which point the register allocator
+     will see that OFF1 is not a valid add3 operand and load it into
+     a register, as desired.  */
+  if (orig_offset >= 0 && orig_offset < 2 * 32767)
+    {
+      hi = 32767;
+      lo = orig_offset - hi;
+    }
+  else if (orig_offset < 0 && orig_offset >= 2 * -32768)
+    {
+      hi = -32768;
+      lo = orig_offset - hi;
+    }
+  else
+    {
+      lo = sext_hwi (orig_offset, 16);
+      hi = orig_offset - lo;
+    }
+
+  *off1 = GEN_INT (hi);
+  *off2 = GEN_INT (lo);
+  return true;
+}
+
+#undef  TARGET_LEGITIMIZE_ADDRESS_DISPLACEMENT
+#define TARGET_LEGITIMIZE_ADDRESS_DISPLACEMENT \
+  or1k_legitimize_address_displacement
+
+/* Helper function to implement both TARGET_LEGITIMIZE_ADDRESS and expand the
+   patterns "movqi", "movqi" and "movsi".  Returns an valid OpenRISC RTX that
+   represents the argument X which is an invalid address RTX.  The argument
+   SCRATCH may be used as a temporary when building addresses.  */
+
+static rtx
+or1k_legitimize_address_1 (rtx x, rtx scratch)
+{
+  rtx base, addend, t1, t2;
+  tls_model tls_kind = TLS_MODEL_NONE;
+  bool is_local = true;
+
+  split_const (x, &base, &addend);
+  switch (GET_CODE (base))
+    {
+    default:
+      gcc_assert (can_create_pseudo_p ());
+      base = force_reg (Pmode, base);
+      break;
+
+    case REG:
+    case SUBREG:
+      break;
+
+    case SYMBOL_REF:
+      tls_kind = SYMBOL_REF_TLS_MODEL (base);
+      is_local = SYMBOL_REF_LOCAL_P (base);
+      /* FALLTHRU */
+
+    case LABEL_REF:
+      switch (tls_kind)
+	{
+	case TLS_MODEL_NONE:
+	  t1 = can_create_pseudo_p () ? gen_reg_rtx (Pmode) : scratch;
+	  if (!flag_pic)
+	    {
+	      emit_insn (gen_rtx_SET (t1, gen_rtx_HIGH (Pmode, x)));
+	      return gen_rtx_LO_SUM (Pmode, t1, x);
+	    }
+	  else if (is_local)
+	    {
+	      crtl->uses_pic_offset_table = 1;
+	      t2 = gen_sym_unspec (x, UNSPEC_GOTOFF);
+	      emit_insn (gen_rtx_SET (t1, gen_rtx_HIGH (Pmode, t2)));
+	      emit_insn (gen_add3_insn (t1, t1, pic_offset_table_rtx));
+	      return gen_rtx_LO_SUM (Pmode, t1, copy_rtx (t2));
+	    }
+	  else
+	    {
+	      base = gen_sym_unspec (base, UNSPEC_GOT);
+	      crtl->uses_pic_offset_table = 1;
+	      t2 = gen_rtx_LO_SUM (Pmode, pic_offset_table_rtx, base);
+	      t2 = gen_const_mem (Pmode, t2);
+	      emit_insn (gen_rtx_SET (t1, t2));
+	      base = t1;
+	    }
+	  break;
+
+	case TLS_MODEL_GLOBAL_DYNAMIC:
+	case TLS_MODEL_LOCAL_DYNAMIC:
+	  /* TODO: For now, treat LD as GD.  */
+	  t1 = gen_reg_rtx (Pmode);
+	  base = gen_sym_unspec (base, UNSPEC_TLSGD);
+	  emit_insn (gen_rtx_SET (t1, gen_rtx_HIGH (Pmode, base)));
+	  emit_insn (gen_rtx_SET (t1, gen_rtx_LO_SUM (Pmode, t1, base)));
+	  crtl->uses_pic_offset_table = 1;
+	  emit_insn (gen_add3_insn (t1, t1, pic_offset_table_rtx));
+	  base = gen_reg_rtx (Pmode);
+	  or1k_tls_call (base, t1);
+	  break;
+
+	case TLS_MODEL_INITIAL_EXEC:
+	  t1 = gen_reg_rtx (Pmode);
+	  t2 = gen_reg_rtx (Pmode);
+	  base = gen_sym_unspec (base, UNSPEC_GOTTPOFF);
+	  emit_insn (gen_rtx_SET (t1, gen_rtx_HIGH (Pmode, base)));
+	  crtl->uses_pic_offset_table = 1;
+	  emit_insn (gen_add3_insn (t1, t1, pic_offset_table_rtx));
+	  t1 = gen_rtx_LO_SUM (Pmode, t1, base);
+	  emit_move_insn (t2, gen_const_mem (Pmode, t1));
+	  t1 = gen_rtx_REG (Pmode, TLS_REGNUM);
+	  emit_insn (gen_add3_insn (t2, t2, t1));
+	  base = t2;
+	  break;
+
+	case TLS_MODEL_LOCAL_EXEC:
+	  x = gen_sym_unspec (x, UNSPEC_TPOFF);
+	  t1 = gen_reg_rtx (Pmode);
+	  emit_insn (gen_rtx_SET (t1, gen_rtx_HIGH (Pmode, x)));
+	  t2 = gen_rtx_REG (Pmode, TLS_REGNUM);
+	  emit_insn (gen_add3_insn (t1, t1, t2));
+	  return gen_rtx_LO_SUM (Pmode, t1, x);
+
+	default:
+	  gcc_unreachable ();
+	}
+      break;
+
+    /* Accept what we may have already emitted.  */
+
+    case LO_SUM:
+    case UNSPEC:
+      return x;
+    }
+
+  /* If we get here, we still have addend outstanding.  */
+  gcc_checking_assert (register_operand (base, Pmode));
+  if (addend == const0_rtx)
+    return base;
+  if (satisfies_constraint_I (addend)
+      || virtual_frame_reg_operand (base, VOIDmode))
+    return gen_rtx_PLUS (Pmode, base, addend);
+  else
+    {
+      rtx hi, lo;
+      bool ok = (or1k_legitimize_address_displacement
+		 (&hi, &lo, INTVAL (addend), SImode));
+      gcc_assert (ok);
+
+      t2 = can_create_pseudo_p () ? gen_reg_rtx (Pmode) : scratch;
+      if (satisfies_constraint_I (hi))
+	emit_insn (gen_addsi3 (t2, base, hi));
+      else
+	{
+	  t1 = can_create_pseudo_p () ? gen_reg_rtx (Pmode) : scratch;
+	  emit_move_insn (t1, hi);
+	  emit_insn (gen_add3_insn (t2, base, t1));
+	}
+      if (lo == const0_rtx)
+	return t2;
+      else
+	return gen_rtx_PLUS (Pmode, t2, lo);
+    }
+}
+
+/* Worker for TARGET_LEGITIMIZE_ADDRESS.
+   This delegates implementation to or1k_legitimize_address_1.  */
+
+static rtx
+or1k_legitimize_address (rtx x, rtx /* oldx */, machine_mode)
+{
+  return or1k_legitimize_address_1 (x, NULL_RTX);
+}
+
+#undef  TARGET_LEGITIMIZE_ADDRESS
+#define TARGET_LEGITIMIZE_ADDRESS or1k_legitimize_address
+
+/* Worker for TARGET_DELEGITIMIZE_ADDRESS.
+   In the name of slightly smaller debug output, and to cater to
+   general assembler lossage, recognize PIC+GOTOFF and turn it back
+   into a direct symbol reference.  */
+
+static rtx
+or1k_delegitimize_address (rtx x)
+{
+  if (GET_CODE (x) == UNSPEC)
+    {
+      /* The LO_SUM to which X was attached has been stripped.
+	 Since the only legitimate address we could have been computing
+	 is that of the symbol, assume that's what we've done.  */
+      if (XINT (x, 1) == UNSPEC_GOTOFF)
+	return XVECEXP (x, 0, 0);
+    }
+  else if (MEM_P (x))
+    {
+      rtx addr = XEXP (x, 0);
+      if (GET_CODE (addr) == LO_SUM
+	  && XEXP (addr, 0) == pic_offset_table_rtx)
+	{
+	  rtx inner = XEXP (addr, 1);
+	  if (GET_CODE (inner) == UNSPEC
+	      && XINT (inner, 1) == UNSPEC_GOT)
+	    return XVECEXP (inner, 0, 0);
+	}
+    }
+  return delegitimize_mem_from_attrs (x);
+}
+
+#undef  TARGET_DELEGITIMIZE_ADDRESS
+#define TARGET_DELEGITIMIZE_ADDRESS or1k_delegitimize_address
+
+/* Worker for TARGET_CANNOT_FORCE_CONST_MEM.
+   Primarily this is required for TLS symbols, but given that our move
+   patterns *ought* to be able to handle any symbol at any time, we
+   should never be spilling symbolic operands to the constant pool, ever.  */
+
+static bool
+or1k_cannot_force_const_mem (machine_mode, rtx x)
+{
+  rtx_code code = GET_CODE (x);
+  return (code == SYMBOL_REF
+	  || code == LABEL_REF
+	  || code == CONST
+	  || code == HIGH);
+}
+
+#undef  TARGET_CANNOT_FORCE_CONST_MEM
+#define TARGET_CANNOT_FORCE_CONST_MEM or1k_cannot_force_const_mem
+
+/* Worker for TARGET_LEGITIMATE_CONSTANT_P.
+   Returns true is the RTX X represents a constant that can be used as an
+   immediate operand in OpenRISC.  */
+
+static bool
+or1k_legitimate_constant_p (machine_mode, rtx x)
+{
+  switch (GET_CODE (x))
+    {
+    case CONST_INT:
+    case CONST_WIDE_INT:
+    case HIGH:
+      /* We construct these, rather than spilling to memory.  */
+      return true;
+
+    case CONST:
+    case SYMBOL_REF:
+    case LABEL_REF:
+      /* These may need to be split and not reconstructed.  */
+      return or1k_tls_symbolic_operand (x) == TLS_MODEL_NONE;
+
+    default:
+      return false;
+    }
+}
+
+#undef  TARGET_LEGITIMATE_CONSTANT_P
+#define TARGET_LEGITIMATE_CONSTANT_P or1k_legitimate_constant_p
+
+/* Worker for TARGET_PASS_BY_REFERENCE.
+   Returns true if an argument of TYPE in MODE should be passed by reference
+   as required by the OpenRISC ABI.  On OpenRISC structures, unions and
+   arguments larger than 64-bits are passed by reference.  */
+
+static bool
+or1k_pass_by_reference (cumulative_args_t, machine_mode mode,
+			const_tree type, bool)
+{
+  HOST_WIDE_INT size;
+  if (type)
+    {
+      if (AGGREGATE_TYPE_P (type))
+	return true;
+      size = int_size_in_bytes (type);
+    }
+  else
+    size = GET_MODE_SIZE (mode);
+  return size < 0 || size > 8;
+}
+
+/* Worker for TARGET_FUNCTION_VALUE.
+   Returns an RTX representing the location where function return values will
+   be stored.  On OpenRISC this is the register r11.  64-bit return value's
+   upper 32-bits are returned in r12, this is automatically done by GCC.  */
+
+static rtx
+or1k_function_value (const_tree valtype,
+		     const_tree /* fn_decl_or_type */,
+		     bool /* outgoing */)
+{
+  return gen_rtx_REG (TYPE_MODE (valtype), RV_REGNUM);
+}
+
+/* Worker for TARGET_LIBCALL_VALUE.
+   Returns an RTX representing the location where function return values to
+   external libraries will be stored.  On OpenRISC this the same as local
+   function calls.  */
+
+static rtx
+or1k_libcall_value (machine_mode mode,
+		    const_rtx /* fun */)
+{
+  return gen_rtx_REG (mode, RV_REGNUM);
+}
+
+
+/* Worker for TARGET_FUNCTION_VALUE_REGNO_P.
+   Returns true if REGNO is a valid register for storing a function return
+   value.  */
+
+static bool
+or1k_function_value_regno_p (const unsigned int regno)
+{
+  return (regno == RV_REGNUM);
+}
+
+/* Worker for TARGET_STRICT_ARGUMENT_NAMING.
+   Return true always as on OpenRISC the last argument in a variatic function
+   is named.  */
+
+static bool
+or1k_strict_argument_naming (cumulative_args_t /* ca */)
+{
+  return true;
+}
+
+#undef  TARGET_STRICT_ARGUMENT_NAMING
+#define TARGET_STRICT_ARGUMENT_NAMING or1k_strict_argument_naming
+
+/* Worker for TARGET_FUNCTION_ARG.
+   Return the next register to be used to hold a function argument or NULL_RTX
+   if there's no more space.  Arugment CUM_V represents the current argument
+   offset, zero for the first function argument.  OpenRISC function arguments
+   maybe be passed in registers r3 to r8.  */
+
+static rtx
+or1k_function_arg (cumulative_args_t cum_v, machine_mode mode,
+		   const_tree /* type */, bool named)
+{
+  /* VOIDmode is passed as a special flag for "last argument".  */
+  if (mode == VOIDmode)
+    return NULL_RTX;
+
+  CUMULATIVE_ARGS *cum = get_cumulative_args (cum_v);
+  int nreg = CEIL (GET_MODE_SIZE (mode), UNITS_PER_WORD);
+
+  /* Note that all large arguments are passed by reference.  */
+  gcc_assert (nreg <= 2);
+  if (named && *cum + nreg <= 6)
+    return gen_rtx_REG (mode, *cum + 3);
+  else
+    return NULL_RTX;
+}
+
+/* Worker for TARGET_FUNCTION_ARG_ADVANCE.
+   Update the cumulative args descriptor CUM_V to advance past the next function
+   argument.  Note, this is not called for arguments passed on the stack.  */
+
+static void
+or1k_function_arg_advance (cumulative_args_t cum_v, machine_mode mode,
+			   const_tree /* type */, bool named)
+{
+  CUMULATIVE_ARGS *cum = get_cumulative_args (cum_v);
+  int nreg = CEIL (GET_MODE_SIZE (mode), UNITS_PER_WORD);
+
+  /* Note that all large arguments are passed by reference.  */
+  gcc_assert (nreg <= 2);
+  if (named)
+    *cum += nreg;
+}
+
+/* worker function for TARGET_RETURN_IN_MEMORY.
+   Returns true if the argument of TYPE should be returned in memory.  On
+   OpenRISC this is any value larger than 64-bits.  */
+
+static bool
+or1k_return_in_memory (const_tree type, const_tree /* fntype */)
+{
+  const HOST_WIDE_INT size = int_size_in_bytes (type);
+  return (size == -1 || size > (2 * UNITS_PER_WORD));
+}
+
+/* Print reloc (x + add).  */
+
+static void
+output_addr_reloc (FILE *stream, rtx x, HOST_WIDE_INT add, const char *reloc)
+{
+  if (*reloc)
+    {
+      fputs (reloc, stream);
+      fputc ('(', stream);
+    }
+  output_addr_const (stream, x);
+  if (add)
+    {
+      if (add > 0)
+	fputc ('+', stream);
+      fprintf (stream, HOST_WIDE_INT_PRINT_DEC, add);
+    }
+  if (*reloc)
+    fputc (')', stream);
+}
+
+enum reloc_kind
+{
+  RKIND_LO,
+  RKIND_HI,
+  RKIND_MAX
+};
+
+enum reloc_type
+{
+  RTYPE_DIRECT,
+  RTYPE_GOT,
+  RTYPE_GOTOFF,
+  RTYPE_TPOFF,
+  RTYPE_GOTTPOFF,
+  RTYPE_TLSGD,
+  RTYPE_MAX
+};
+
+static void
+print_reloc (FILE *stream, rtx x, HOST_WIDE_INT add, reloc_kind kind)
+{
+  /* All data relocations.  A NULL in this table indicates a form that
+     we expect to never generate, while "" indicates a form that requires
+     no special markup.  */
+  static const char * const relocs[RKIND_MAX][RTYPE_MAX] = {
+    { "lo", "got", "gotofflo", "tpofflo", "gottpofflo", "tlsgdlo" },
+    { "ha", NULL,  "gotoffha", "tpoffha", "gottpoffha", "tlsgdhi" },
+  };
+  reloc_type type = RTYPE_DIRECT;
+
+  if (GET_CODE (x) == UNSPEC)
+    {
+      switch (XINT (x, 1))
+	{
+	case UNSPEC_GOT:
+	  type = RTYPE_GOT;
+	  break;
+	case UNSPEC_GOTOFF:
+	  type = RTYPE_GOTOFF;
+	  break;
+	case UNSPEC_TPOFF:
+	  type = RTYPE_TPOFF;
+	  break;
+	case UNSPEC_GOTTPOFF:
+	  type = RTYPE_GOTTPOFF;
+	  break;
+	case UNSPEC_TLSGD:
+	  type = RTYPE_TLSGD;
+	  break;
+	default:
+	  output_operand_lossage ("invalid relocation");
+	  return;
+	}
+      x = XVECEXP (x, 0, 0);
+    }
+
+  const char *reloc = relocs[kind][type];
+  if (reloc == NULL)
+    output_operand_lossage ("invalid relocation");
+  else
+    output_addr_reloc (stream, x, add, reloc);
+}
+
+/* Worker for TARGET_PRINT_OPERAND_ADDRESS.
+   Prints the argument ADDR, an address RTX, to the file FILE.  The output is
+   formed as expected by the OpenRISC assembler.  Examples:
+
+     RTX							      OUTPUT
+     (reg:SI 3)							       0(r3)
+     (plus:SI (reg:SI 3) (const_int 4))				     0x4(r3)
+     (lo_sum:SI (reg:SI 3) (symbol_ref:SI ("x"))))		   lo(x)(r3)  */
+
+static void
+or1k_print_operand_address (FILE *file, machine_mode, rtx addr)
+{
+  rtx offset;
+
+  switch (GET_CODE (addr))
+    {
+    case REG:
+      fputc ('0', file);
+      break;
+
+    case PLUS:
+      offset = XEXP (addr, 1);
+      addr = XEXP (addr, 0);
+      gcc_assert (CONST_INT_P (offset));
+      if (GET_CODE (addr) == LO_SUM)
+	{
+	  print_reloc (file, XEXP (addr, 1), INTVAL (offset), RKIND_LO);
+	  addr = XEXP (addr, 0);
+	}
+      else
+	output_addr_const (file, offset);
+      break;
+
+    case LO_SUM:
+      offset = XEXP (addr, 1);
+      addr = XEXP (addr, 0);
+      print_reloc (file, offset, 0, RKIND_LO);
+      break;
+
+    default:
+      output_addr_const (file, addr);
+      return;
+    }
+
+  fprintf (file, "(%s)", reg_names[REGNO (addr)]);
+}
+
+/* Worker for TARGET_PRINT_OPERAND.
+   Print operand X, an RTX, to the file FILE.  The output is formed as expected
+   by the OpenRISC assember.  CODE is the letter following a '%' in an
+   instrunction template used to control the RTX output.  Example(s):
+
+     CODE   RTX                   OUTPUT     COMMENT
+     0      (reg:SI 3)                r3     output an operand
+     r      (reg:SI 3)                r3     output a register or const zero
+     H      (reg:SI 3)                r4     output the high pair register
+     h      (symbol_ref:SI ("x"))  ha(x)     output a signed high relocation
+     L      (symbol_ref:SI ("x"))  lo(x)     output a low relocation
+
+   Note, '#' is a special code used to fill the branch delay slot with an l.nop
+   instruction.  The l.nop (no-op) instruction is only outputted when the delay
+   slot has not been filled.  */
+
+static void
+or1k_print_operand (FILE *file, rtx x, int code)
+{
+  rtx operand = x;
+
+  switch (code)
+    {
+    case '#':
+      /* Conditionally add a nop in unfilled delay slot.  */
+      if (final_sequence == NULL)
+	fputs ("\n\t l.nop\n", file);
+      break;
+
+    case 'r':
+      if (REG_P (x))
+	fprintf (file, "%s", reg_names[REGNO (operand)]);
+      else if (x == CONST0_RTX (GET_MODE (x)))
+	fprintf (file, "r0");
+      else
+	output_operand_lossage ("invalid %%r value");
+      break;
+
+    case 'H':
+      if (REG_P (x))
+	fprintf (file, "%s", reg_names[REGNO (operand) + 1]);
+      else
+	output_operand_lossage ("invalid %%H value");
+      break;
+
+    case 'h':
+      print_reloc (file, x, 0, RKIND_HI);
+      break;
+    case 'L':
+      print_reloc (file, x, 0, RKIND_LO);
+      break;
+    case 'P':
+      if (!flag_pic || SYMBOL_REF_LOCAL_P (x))
+	output_addr_const (file, x);
+      else
+	output_addr_reloc (file, x, 0, "plt");
+      break;
+
+    case 0:
+      /* Print an operand as without a modifier letter.  */
+      switch (GET_CODE (operand))
+	{
+	case REG:
+	  if (REGNO (operand) > 31)
+	    internal_error ("internal error: bad register: %d",
+			    REGNO (operand));
+	  fprintf (file, "%s", reg_names[REGNO (operand)]);
+	  break;
+
+	case MEM:
+	  output_address (GET_MODE (XEXP (operand, 0)), XEXP (operand, 0));
+	  break;
+
+	case CODE_LABEL:
+	case LABEL_REF:
+	  output_asm_label (operand);
+	  break;
+
+	default:
+	  /* No need to handle all strange variants, let output_addr_const
+	     do it for us.  */
+	  if (CONSTANT_P (operand))
+	    output_addr_const (file, operand);
+	  else
+	    internal_error ("unexpected operand: %d", GET_CODE (operand));
+	  break;
+	}
+      break;
+
+    default:
+      output_operand_lossage ("unknown operand letter: '%c'", code);
+      break;
+    }
+}
+
+/* Worker for TARGET_TRAMPOLINE_INIT.
+   This is called to initialize a trampoline.  The argument M_TRAMP is an RTX
+   for the memory block to be initialized with trampoline code.  The argument
+   FNDECL contains the definition of the nested function to be called, we use
+   this to get the function's address.  The argument CHAIN is an RTX for the
+   static chain value to be passed to the nested function.  */
+
+static void
+or1k_trampoline_init (rtx m_tramp, tree fndecl, rtx chain)
+{
+  const unsigned movhi_r13 = (0x06u << 26) | (13 << 21);
+  const unsigned movhi_r11 = (0x06u << 26) | (11 << 21);
+  const unsigned ori_r13_r13 = (0x2a << 26) | (13 << 21) | (13 << 16);
+  const unsigned ori_r11_r11 = (0x2a << 26) | (11 << 21) | (11 << 16);
+  const unsigned jr_r13 = (0x11 << 26) | (13 << 11);
+  rtx tramp[5], fnaddr, f_hi, f_lo, c_hi, c_lo;
+
+  fnaddr = force_operand (XEXP (DECL_RTL (fndecl), 0), NULL);
+  f_hi = expand_binop (SImode, lshr_optab, fnaddr, GEN_INT (16),
+		       NULL, true, OPTAB_DIRECT);
+  f_lo = expand_binop (SImode, and_optab, fnaddr, GEN_INT (0xffff),
+		       NULL, true, OPTAB_DIRECT);
+
+  chain = force_operand (chain, NULL);
+  c_hi = expand_binop (SImode, lshr_optab, chain, GEN_INT (16),
+		       NULL, true, OPTAB_DIRECT);
+  c_lo = expand_binop (SImode, and_optab, chain, GEN_INT (0xffff),
+		       NULL, true, OPTAB_DIRECT);
+
+  /* We want to generate
+
+	l.movhi r13,hi(nested_func)
+	l.movhi r11,hi(static_chain)
+	l.ori	r13,r13,lo(nested_func)
+	l.jr	r13
+	 l.ori	r11,r11,lo(static_chain)
+   */
+  tramp[0] = expand_binop (SImode, ior_optab, f_hi,
+			   gen_int_mode (movhi_r13, SImode),
+			   f_hi, true, OPTAB_DIRECT);
+  tramp[1] = expand_binop (SImode, ior_optab, c_hi,
+			   gen_int_mode (movhi_r11, SImode),
+			   c_hi, true, OPTAB_DIRECT);
+  tramp[2] = expand_binop (SImode, ior_optab, f_lo,
+			   gen_int_mode (ori_r13_r13, SImode),
+			   f_lo, true, OPTAB_DIRECT);
+  tramp[4] = expand_binop (SImode, ior_optab, c_lo,
+			   gen_int_mode (ori_r11_r11, SImode),
+			   c_lo, true, OPTAB_DIRECT);
+  tramp[3] = gen_int_mode (jr_r13, SImode);
+
+  for (int i = 0; i < 5; ++i)
+    {
+      rtx mem = adjust_address (m_tramp, SImode, i * 4);
+      emit_move_insn (mem, tramp[i]);
+    }
+
+  /* Flushing the trampoline from the instruction cache needs
+     to be done here. */
+}
+
+/* Worker for TARGET_HARD_REGNO_MODE_OK.
+   Returns true if the hard register REGNO is ok for storing values of mode
+   MODE.  */
+
+static bool
+or1k_hard_regno_mode_ok (unsigned int regno, machine_mode mode)
+{
+  /* For OpenRISC, GENERAL_REGS can hold anything, while
+     FLAG_REGS are really single bits within SP[SR].  */
+  if (REGNO_REG_CLASS (regno) == FLAG_REGS)
+    return mode == BImode;
+  return true;
+}
+
+#undef TARGET_HARD_REGNO_MODE_OK
+#define TARGET_HARD_REGNO_MODE_OK or1k_hard_regno_mode_ok
+
+/* Worker for TARGET_CAN_CHANGE_MODE_CLASS.
+   Returns true if its ok to change a register in class RCLASS from mode FROM to
+   mode TO.  In general OpenRISC registers, other than special flags, handle all
+   supported classes.  */
+
+static bool
+or1k_can_change_mode_class (machine_mode from, machine_mode to,
+			    reg_class_t rclass)
+{
+  if (rclass == FLAG_REGS)
+    return from == to;
+  return true;
+}
+
+#undef TARGET_CAN_CHANGE_MODE_CLASS
+#define TARGET_CAN_CHANGE_MODE_CLASS or1k_can_change_mode_class
+
+/* Expand the patterns "movqi", "movqi" and "movsi".  The argument OP0 is the
+   destination and OP1 is the source.  This expands to set OP0 to OP1.  OpenRISC
+   cannot do memory to memory assignments so for those cases we force one
+   argument to a register.  Constants that can't fit into a 16-bit immediate are
+   split.  Symbols are legitimized using split relocations.  */
+
+void
+or1k_expand_move (machine_mode mode, rtx op0, rtx op1)
+{
+  if (MEM_P (op0))
+    {
+      if (!const0_operand (op1, mode))
+	op1 = force_reg (mode, op1);
+    }
+  else if (mode == QImode || mode == HImode)
+    {
+      /* ??? Maybe promote MEMs and CONST_INT to SImode,
+	 and then squish back with gen_lowpart.  */
+    }
+  else
+    {
+      switch (GET_CODE (op1))
+	{
+	case CONST_INT:
+	  if (!input_operand (op1, mode))
+	    {
+	      HOST_WIDE_INT i = INTVAL (op1);
+	      HOST_WIDE_INT lo = i & 0xffff;
+	      HOST_WIDE_INT hi = i ^ lo;
+	      rtx subtarget = op0;
+
+	      if (!cse_not_expected && can_create_pseudo_p ())
+		subtarget = gen_reg_rtx (SImode);
+	      emit_insn (gen_rtx_SET (subtarget, GEN_INT (hi)));
+	      emit_insn (gen_iorsi3 (op0, subtarget, GEN_INT (lo)));
+	      return;
+	    }
+	  break;
+
+	case CONST:
+	case SYMBOL_REF:
+	case LABEL_REF:
+	  op1 = or1k_legitimize_address_1 (op1, op0);
+	  break;
+
+	default:
+	  break;
+	}
+    }
+  emit_insn (gen_rtx_SET (op0, op1));
+}
+
+/* Used to expand patterns "movsicc", "movqicc", "movhicc", "cstoresi4" and
+   "cbranchsi4".
+   Expands a comparison where OPERANDS is an array of RTX describing the
+   comparison.  The first argument OPERANDS[0] is the operator and OPERANDS[1]
+   and OPERANDS[2] are the operands.  Split out the compare into SR[F] and
+   return a new operation in OPERANDS[0].  The inputs OPERANDS[1] and
+   OPERANDS[2] are not directly used, only overridden.  */
+
+void
+or1k_expand_compare (rtx *operands)
+{
+  rtx sr_f = gen_rtx_REG (BImode, SR_F_REGNUM);
+
+  /* The RTL may receive an immediate in argument 1 of the compare, this is not
+     supported unless we have l.sf*i instructions, force them into registers.  */
+  if (!TARGET_SFIMM)
+    XEXP (operands[0], 1) = force_reg (SImode, XEXP (operands[0], 1));
+
+  /* Emit the given comparison into the Flag bit.  */
+  PUT_MODE (operands[0], BImode);
+  emit_insn (gen_rtx_SET (sr_f, operands[0]));
+
+  /* Adjust the operands for use in the caller.  */
+  operands[0] = gen_rtx_NE (VOIDmode, sr_f, const0_rtx);
+  operands[1] = sr_f;
+  operands[2] = const0_rtx;
+}
+
+/* Expand the patterns "call", "sibcall", "call_value" and "sibcall_value".
+   Expands a function call where argument RETVAL is an optional RTX providing
+   return value storage, the argument FNADDR is and RTX describing the function
+   to call, the argument CALLARG1 is the number or registers used as operands
+   and the argument SIBCALL should be true if this is a nested function call.
+   If FNADDR is a non local symbol and FLAG_PIC is enabled this will generate
+   a PLT call.  */
+
+void
+or1k_expand_call (rtx retval, rtx fnaddr, rtx callarg1, bool sibcall)
+{
+  rtx call, use = NULL;
+
+  /* Calls via the PLT require the PIC register.  */
+  if (flag_pic
+      && GET_CODE (XEXP (fnaddr, 0)) == SYMBOL_REF
+      && !SYMBOL_REF_LOCAL_P (XEXP (fnaddr, 0)))
+    {
+      crtl->uses_pic_offset_table = 1;
+      rtx hard_pic = gen_rtx_REG (Pmode, REAL_PIC_OFFSET_TABLE_REGNUM);
+      emit_move_insn (hard_pic, pic_offset_table_rtx);
+      use_reg (&use, hard_pic);
+    }
+
+  if (!call_insn_operand (XEXP (fnaddr, 0), Pmode))
+    {
+      fnaddr = copy_to_mode_reg (Pmode, XEXP (fnaddr, 0));
+      fnaddr = gen_rtx_MEM (SImode, fnaddr);
+    }
+
+  call = gen_rtx_CALL (VOIDmode, fnaddr, callarg1);
+  if (retval)
+    call = gen_rtx_SET (retval, call);
+
+  /* Normal calls clobber LR.  This is required in order to
+     prevent e.g. a prologue store of LR being placed into
+     the delay slot of the call, after it has been updated.  */
+  if (!sibcall)
+    {
+      rtx clob = gen_rtx_CLOBBER (VOIDmode, gen_rtx_REG (Pmode, LR_REGNUM));
+      call = gen_rtx_PARALLEL (VOIDmode, gen_rtvec (2, call, clob));
+    }
+  call = emit_call_insn (call);
+
+  CALL_INSN_FUNCTION_USAGE (call) = use;
+}
+
+/* Worker for TARGET_FUNCTION_OK_FOR_SIBCALL.
+   Returns true if the function declared by DECL is ok for calling as a nested
+   function.  */
+
+static bool
+or1k_function_ok_for_sibcall (tree decl, tree /* exp */)
+{
+  /* We can sibcall to any function if not PIC.  */
+  if (!flag_pic)
+    return true;
+
+  /* We can sibcall any indirect function.  */
+  if (decl == NULL)
+    return true;
+
+  /* If the call may go through the PLT, we need r16 live.  */
+  return targetm.binds_local_p (decl);
+}
+
+#undef TARGET_FUNCTION_OK_FOR_SIBCALL
+#define TARGET_FUNCTION_OK_FOR_SIBCALL or1k_function_ok_for_sibcall
+
+/* Worker for TARGET_RTX_COSTS.  */
+
+static bool
+or1k_rtx_costs (rtx x, machine_mode mode, int outer_code, int /* opno */,
+		int *total, bool /* speed */)
+{
+  switch (GET_CODE (x))
+    {
+    case CONST_INT:
+      if (x == const0_rtx)
+	*total = 0;
+      else if ((outer_code == PLUS || outer_code == XOR || outer_code == MULT)
+	       && satisfies_constraint_I (x))
+	*total = 0;
+      else if ((outer_code == AND || outer_code == IOR)
+	       && satisfies_constraint_K (x))
+	*total = 0;
+      else if (satisfies_constraint_I (x)
+	       || satisfies_constraint_K (x)
+	       || satisfies_constraint_M (x))
+	*total = 2;
+      else
+	*total = COSTS_N_INSNS (2);
+      return true;
+
+    case CONST_DOUBLE:
+      *total = (x == CONST0_RTX (mode) ? 0 : COSTS_N_INSNS (2));
+      return true;
+
+    case HIGH:
+      /* This is effectively an 'M' constraint.  */
+      *total = 2;
+      return true;
+
+    case LO_SUM:
+      /* This is effectively an 'I' constraint.  */
+      *total = (outer_code == MEM ? 0 : 2);
+      return true;
+
+    case CONST:
+    case SYMBOL_REF:
+    case LABEL_REF:
+      if (outer_code == LO_SUM || outer_code == HIGH)
+	*total = 0;
+      else
+	{
+	  /* ??? Extra cost for GOT or TLS symbols.  */
+	  *total = COSTS_N_INSNS (1 + (outer_code != MEM));
+	}
+      return true;
+
+    case PLUS:
+      if (outer_code == MEM)
+	*total = 0;
+      break;
+
+    default:
+      break;
+    }
+  return false;
+}
+
+#undef TARGET_RTX_COSTS
+#define TARGET_RTX_COSTS or1k_rtx_costs
+
+
+/* A subroutine of the atomic operation splitters.  Jump to LABEL if
+   COND is true.  Mark the jump as unlikely to be taken.  */
+
+static void
+emit_unlikely_jump (rtx_code code, rtx label)
+{
+  rtx x;
+
+  x = gen_rtx_REG (BImode, SR_F_REGNUM);
+  x = gen_rtx_fmt_ee (code, VOIDmode, x, const0_rtx);
+  x = gen_rtx_IF_THEN_ELSE (VOIDmode, x, label, pc_rtx);
+  emit_jump_insn (gen_rtx_SET (pc_rtx, x));
+
+  // Disable this for now -- producing verify_cfg failures on probabilities.
+  // int very_unlikely = REG_BR_PROB_BASE / 100 - 1;
+  // add_int_reg_note (insn, REG_BR_PROB, very_unlikely);
+}
+
+/* A subroutine of the atomic operation splitters.
+   Emit a raw comparison for A CODE B.  */
+
+static void
+emit_compare (rtx_code code, rtx a, rtx b)
+{
+  emit_insn (gen_rtx_SET (gen_rtx_REG (BImode, SR_F_REGNUM),
+			  gen_rtx_fmt_ee (code, BImode, a, b)));
+}
+
+/* A subroutine of the atomic operation splitters.
+   Emit a load-locked instruction in MODE.  */
+
+static void
+emit_load_locked (machine_mode mode, rtx reg, rtx mem)
+{
+  gcc_assert (mode == SImode);
+  emit_insn (gen_load_locked_si (reg, mem));
+}
+
+/* A subroutine of the atomic operation splitters.
+   Emit a store-conditional instruction in MODE.  */
+
+static void
+emit_store_conditional (machine_mode mode, rtx mem, rtx val)
+{
+  gcc_assert (mode == SImode);
+  emit_insn (gen_store_conditional_si (mem, val));
+}
+
+/* A subroutine of the various atomic expanders.  For sub-word operations,
+   we must adjust things to operate on SImode.  Given the original MEM,
+   return a new aligned memory.  Also build and return the quantities by
+   which to shift and mask.  */
+
+static rtx
+or1k_adjust_atomic_subword (rtx orig_mem, rtx *pshift, rtx *pmask)
+{
+  rtx addr, align, shift, mask, mem;
+  machine_mode mode = GET_MODE (orig_mem);
+
+  addr = XEXP (orig_mem, 0);
+  addr = force_reg (Pmode, addr);
+
+  /* Aligned memory containing subword.  Generate a new memory.  We
+     do not want any of the existing MEM_ATTR data, as we're now
+     accessing memory outside the original object.  */
+  align = expand_binop (Pmode, and_optab, addr, GEN_INT (-4),
+			NULL_RTX, 1, OPTAB_LIB_WIDEN);
+  mem = gen_rtx_MEM (SImode, align);
+  MEM_VOLATILE_P (mem) = MEM_VOLATILE_P (orig_mem);
+  if (MEM_ALIAS_SET (orig_mem) == ALIAS_SET_MEMORY_BARRIER)
+    set_mem_alias_set (mem, ALIAS_SET_MEMORY_BARRIER);
+
+  /* Shift amount for subword relative to aligned word.  */
+  rtx mode_mask = GEN_INT (mode == QImode ? 3 : 2);
+  shift = expand_binop (SImode, and_optab, gen_lowpart (SImode, addr),
+			mode_mask, NULL_RTX, 1, OPTAB_LIB_WIDEN);
+  if (BYTES_BIG_ENDIAN)
+    shift = expand_binop (SImode, xor_optab, shift, mode_mask,
+			  shift, 1, OPTAB_LIB_WIDEN);
+  shift = expand_binop (SImode, ashl_optab, shift, GEN_INT (3),
+			shift, 1, OPTAB_LIB_WIDEN);
+  *pshift = shift;
+
+  /* Mask for insertion.  */
+  mask = expand_binop (SImode, ashl_optab, GEN_INT (GET_MODE_MASK (mode)),
+		       shift, NULL_RTX, 1, OPTAB_LIB_WIDEN);
+  *pmask = mask;
+
+  return mem;
+}
+
+/* A subroutine of the various atomic expanders.  For sub-word operations,
+   complete the operation by shifting result to the lsb of the SImode
+   temporary and then extracting the result in MODE with a SUBREG.  */
+
+static void
+or1k_finish_atomic_subword (machine_mode mode, rtx o, rtx n, rtx shift)
+{
+  n = expand_binop (SImode, lshr_optab, n, shift,
+		    NULL_RTX, 1, OPTAB_LIB_WIDEN);
+  emit_move_insn (o, gen_lowpart (mode, n));
+}
+
+/* Expand an atomic compare and swap operation.
+   Emits the RTX to perform a compare and swap operation.  This function takes
+   8 RTX arguments in the OPERANDS array.  The compare and swap operation
+   loads a value from memory (OPERANDS[2]) and compares it with an expected
+   value (OPERANDS[3]), if the values are equal it stores a new value
+   (OPERANDS[4]) to memory.  The argument OPERANDS[0] represents a boolean
+   result which will be set to true if the operation succeeds.  A return value
+   (OPERANDS[1]) will be set to what was loaded from memory.  The argument
+   OPERAND[5] is used to indicate if the compare and swap is to be treated as
+   weak.  OpenRISC does not use OPERANDS[5] or OPERANDS[6] which provide memory
+   model details.
+   For OpenRISC this emits RTX which will translate to assembly using the
+   'l.lwa' (load word atomic) and 'l.swa' (store word atomic) instructions.  */
+
+void
+or1k_expand_atomic_compare_and_swap (rtx operands[])
+{
+  rtx boolval, retval, mem, oldval, newval;
+  rtx label1, label2;
+  machine_mode mode;
+  bool is_weak;
+
+  boolval = operands[0];
+  retval = operands[1];
+  mem = operands[2];
+  oldval = operands[3];
+  newval = operands[4];
+  is_weak = (INTVAL (operands[5]) != 0);
+  mode = GET_MODE (mem);
+
+  if (reg_overlap_mentioned_p (retval, oldval))
+    oldval = copy_to_reg (oldval);
+
+  label1 = NULL_RTX;
+  /* If strong, create a label to try again.  */
+  if (!is_weak)
+    {
+      label1 = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+      emit_label (XEXP (label1, 0));
+    }
+  label2 = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+
+  emit_load_locked (mode, retval, mem);
+  emit_compare (EQ, retval, oldval);
+  emit_unlikely_jump (EQ, label2);
+  emit_store_conditional (mode, mem, newval);
+
+  /* If strong, jump back to try again on fails.  */
+  if (!is_weak)
+    emit_unlikely_jump (EQ, label1);
+  emit_label (XEXP (label2, 0));
+
+  /* In all cases, SR_F contains 1 on success, and 0 on failure.  */
+  emit_insn (gen_sne_sr_f (boolval));
+}
+
+void
+or1k_expand_atomic_compare_and_swap_qihi (rtx operands[])
+{
+  rtx boolval, orig_retval, retval, scratch, mem, oldval, newval;
+  rtx label1, label2, mask, shift;
+  machine_mode mode;
+  bool is_weak;
+
+  boolval = operands[0];
+  orig_retval = operands[1];
+  mem = operands[2];
+  oldval = operands[3];
+  newval = operands[4];
+  is_weak = (INTVAL (operands[5]) != 0);
+  mode = GET_MODE (mem);
+
+  mem = or1k_adjust_atomic_subword (mem, &shift, &mask);
+
+  /* Shift and mask OLDVAL and NEWVAL into position with the word.  */
+  if (oldval != const0_rtx)
+    {
+      oldval = convert_modes (SImode, mode, oldval, 1);
+      oldval = expand_binop (SImode, ashl_optab, oldval, shift,
+			     NULL_RTX, 1, OPTAB_LIB_WIDEN);
+    }
+  if (newval != const0_rtx)
+    {
+      newval = convert_modes (SImode, mode, newval, 1);
+      newval = expand_binop (SImode, ashl_optab, newval, shift,
+			     NULL_RTX, 1, OPTAB_LIB_WIDEN);
+    }
+
+  label1 = NULL_RTX;
+  if (!is_weak)
+    {
+      label1 = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+      emit_label (XEXP (label1, 0));
+    }
+  label2 = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+
+  scratch = gen_reg_rtx (SImode);
+  emit_load_locked (SImode, scratch, mem);
+
+  retval = expand_binop (SImode, and_optab, scratch, mask,
+			 NULL_RTX, 1, OPTAB_LIB_WIDEN);
+  scratch = expand_binop (SImode, xor_optab, scratch, retval,
+			  scratch, 1, OPTAB_LIB_WIDEN);
+
+  emit_compare (EQ, retval, oldval);
+  emit_unlikely_jump (EQ, label2);
+
+  if (newval != const0_rtx)
+    scratch = expand_binop (SImode, ior_optab, scratch, newval,
+			    scratch, 1, OPTAB_LIB_WIDEN);
+
+  emit_store_conditional (SImode, mem, scratch);
+
+  if (!is_weak)
+    emit_unlikely_jump (EQ, label1);
+  emit_label (XEXP (label2, 0));
+
+  or1k_finish_atomic_subword (mode, orig_retval, retval, shift);
+
+  /* In all cases, SR_F contains 1 on success, and 0 on failure.  */
+  emit_insn (gen_sne_sr_f (boolval));
+}
+
+/* Expand an atomic exchange operation.
+   Emits the RTX to perform an exchange operation.  This function takes 4 RTX
+   arguments in the OPERANDS array.  The exchange operation atomically loads a
+   value from memory (OPERANDS[1]) to a return value (OPERANDS[0]) and stores a
+   new value (OPERANDS[2]) back to the memory location.
+   Another argument (OPERANDS[3]) is used to indicate the memory model and
+   is not used by OpenRISC.
+   For OpenRISC this emits RTX which will translate to assembly using the
+   'l.lwa' (load word atomic) and 'l.swa' (store word atomic) instructions.  */
+
+void
+or1k_expand_atomic_exchange (rtx operands[])
+{
+  rtx retval, mem, val, label;
+  machine_mode mode;
+
+  retval = operands[0];
+  mem = operands[1];
+  val = operands[2];
+  mode = GET_MODE (mem);
+
+  if (reg_overlap_mentioned_p (retval, val))
+    val = copy_to_reg (val);
+
+  label = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+  emit_label (XEXP (label, 0));
+
+  emit_load_locked (mode, retval, mem);
+  emit_store_conditional (mode, mem, val);
+  emit_unlikely_jump (EQ, label);
+}
+
+void
+or1k_expand_atomic_exchange_qihi (rtx operands[])
+{
+  rtx orig_retval, retval, mem, val, scratch;
+  rtx label, mask, shift;
+  machine_mode mode;
+
+  orig_retval = operands[0];
+  mem = operands[1];
+  val = operands[2];
+  mode = GET_MODE (mem);
+
+  mem = or1k_adjust_atomic_subword (mem, &shift, &mask);
+
+  /* Shift and mask VAL into position with the word.  */
+  if (val != const0_rtx)
+    {
+      val = convert_modes (SImode, mode, val, 1);
+      val = expand_binop (SImode, ashl_optab, val, shift,
+		          NULL_RTX, 1, OPTAB_LIB_WIDEN);
+    }
+
+  label = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+  emit_label (XEXP (label, 0));
+
+  scratch = gen_reg_rtx (SImode);
+  emit_load_locked (SImode, scratch, mem);
+
+  retval = expand_binop (SImode, and_optab, scratch, mask,
+			 NULL_RTX, 1, OPTAB_LIB_WIDEN);
+  scratch = expand_binop (SImode, xor_optab, scratch, retval,
+			  scratch, 1, OPTAB_LIB_WIDEN);
+  if (val != const0_rtx)
+    scratch = expand_binop (SImode, ior_optab, scratch, val,
+			    scratch, 1, OPTAB_LIB_WIDEN);
+
+  emit_store_conditional (SImode, mem, scratch);
+  emit_unlikely_jump (EQ, label);
+
+  or1k_finish_atomic_subword (mode, orig_retval, retval, shift);
+}
+
+/* Expand an atomic fetch-and-operate pattern.  CODE is the binary operation
+   to perform (with MULT as a stand-in for NAND).  MEM is the memory on which
+   to operate.  VAL is the second operand of the binary operator.  BEFORE and
+   AFTER are optional locations to return the value of MEM either before of
+   after the operation.  */
+
+void
+or1k_expand_atomic_op (rtx_code code, rtx mem, rtx val,
+		       rtx orig_before, rtx orig_after)
+{
+  machine_mode mode = GET_MODE (mem);
+  rtx before = orig_before, after = orig_after;
+  rtx label;
+
+  label = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+  emit_label (XEXP (label, 0));
+
+  if (before == NULL_RTX)
+    before = gen_reg_rtx (mode);
+
+  emit_load_locked (mode, before, mem);
+
+  if (code == MULT)
+    {
+      after = expand_binop (mode, and_optab, before, val,
+			    after, 1, OPTAB_LIB_WIDEN);
+      after = expand_unop (mode, one_cmpl_optab, after, after, 1);
+    }
+  else
+    after = expand_simple_binop (mode, code, before, val,
+				 after, 1, OPTAB_LIB_WIDEN);
+
+  emit_store_conditional (mode, mem, after);
+  emit_unlikely_jump (EQ, label);
+
+  if (orig_before)
+    emit_move_insn (orig_before, before);
+  if (orig_after)
+    emit_move_insn (orig_after, after);
+}
+
+void
+or1k_expand_atomic_op_qihi (rtx_code code, rtx mem, rtx val,
+			    rtx orig_before, rtx orig_after)
+{
+  machine_mode mode = GET_MODE (mem);
+  rtx label, mask, shift, x;
+  rtx before, after, scratch;
+
+  mem = or1k_adjust_atomic_subword (mem, &shift, &mask);
+
+  /* Shift and mask VAL into position with the word.  */
+  val = convert_modes (SImode, mode, val, 1);
+  val = expand_binop (SImode, ashl_optab, val, shift,
+		      NULL_RTX, 1, OPTAB_LIB_WIDEN);
+
+  switch (code)
+    {
+    case IOR:
+    case XOR:
+      /* We've already zero-extended VAL.  That is sufficient to
+	 make certain that it does not affect other bits.  */
+      break;
+
+    case AND:
+    case MULT: /* NAND */
+      /* If we make certain that all of the other bits in VAL are
+	 set, that will be sufficient to not affect other bits.  */
+      x = expand_unop (SImode, one_cmpl_optab, mask, NULL_RTX, 1);
+      val = expand_binop (SImode, ior_optab, val, x,
+			  val, 1, OPTAB_LIB_WIDEN);
+      break;
+
+    case PLUS:
+    case MINUS:
+      /* These will all affect bits outside the field and need
+	 adjustment via MASK within the loop.  */
+      break;
+
+    default:
+      gcc_unreachable ();
+    }
+
+  label = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+  emit_label (XEXP (label, 0));
+
+  before = scratch = gen_reg_rtx (SImode);
+  emit_load_locked (SImode, before, mem);
+
+  switch (code)
+    {
+    case IOR:
+    case XOR:
+    case AND:
+      after = expand_simple_binop (SImode, code, before, val,
+				   NULL_RTX, 1, OPTAB_LIB_WIDEN);
+      scratch = after;
+      break;
+
+    case PLUS:
+    case MINUS:
+      before = expand_binop (SImode, and_optab, scratch, mask,
+			     NULL_RTX, 1, OPTAB_LIB_WIDEN);
+      scratch = expand_binop (SImode, xor_optab, scratch, before,
+			      scratch, 1, OPTAB_LIB_WIDEN);
+      after = expand_simple_binop (SImode, code, before, val,
+				   NULL_RTX, 1, OPTAB_LIB_WIDEN);
+      after = expand_binop (SImode, and_optab, after, mask,
+			    after, 1, OPTAB_LIB_WIDEN);
+      scratch = expand_binop (SImode, ior_optab, scratch, after,
+			      scratch, 1, OPTAB_LIB_WIDEN);
+      break;
+
+    case MULT: /* NAND */
+      after = expand_binop (SImode, and_optab, before, val,
+			    NULL_RTX, 1, OPTAB_LIB_WIDEN);
+      after = expand_binop (SImode, xor_optab, after, mask,
+			    after, 1, OPTAB_LIB_WIDEN);
+      scratch = after;
+      break;
+
+    default:
+      gcc_unreachable ();
+    }
+
+  emit_store_conditional (SImode, mem, scratch);
+  emit_unlikely_jump (EQ, label);
+
+  if (orig_before)
+    or1k_finish_atomic_subword (mode, orig_before, before, shift);
+  if (orig_after)
+    or1k_finish_atomic_subword (mode, orig_after, after, shift);
+}
+
+/* Worker for TARGET_ASM_OUTPUT_MI_THUNK.
+   Output the assembler code for a thunk function.  THUNK_DECL is the
+   declaration for the thunk function itself, FUNCTION is the decl for
+   the target function.  DELTA is an immediate constant offset to be
+   added to THIS.  If VCALL_OFFSET is nonzero, the word at address
+   (*THIS + VCALL_OFFSET) should be additionally added to THIS.  */
+
+static void
+or1k_output_mi_thunk (FILE *file, tree /* thunk_fndecl */,
+		      HOST_WIDE_INT delta, HOST_WIDE_INT vcall_offset,
+		      tree function)
+{
+  rtx this_rtx, funexp;
+  rtx_insn *insn;
+
+  reload_completed = 1;
+  epilogue_completed = 1;
+
+  emit_note (NOTE_INSN_PROLOGUE_END);
+
+  /* Find the "this" pointer.  Normally in r3, but if the function
+     returns a structure, the structure return pointer is in r3 and
+     the "this" pointer is in r4 instead.  */
+  if (aggregate_value_p (TREE_TYPE (TREE_TYPE (function)), function))
+    this_rtx = gen_rtx_REG (Pmode, 4);
+  else
+    this_rtx = gen_rtx_REG (Pmode, 3);
+
+  /* Add DELTA.  When possible use a plain add, otherwise load it
+     into a register first.  */
+  if (delta)
+    {
+      rtx delta_rtx = GEN_INT (delta);
+
+      if (!satisfies_constraint_I (delta_rtx))
+	{
+	  rtx scratch = gen_rtx_REG (Pmode, PE_TMP_REGNUM);
+	  emit_move_insn (scratch, delta_rtx);
+	  delta_rtx = scratch;
+	}
+
+      /* THIS_RTX += DELTA.  */
+      emit_insn (gen_add2_insn (this_rtx, delta_rtx));
+    }
+
+  /* Add the word at address (*THIS_RTX + VCALL_OFFSET).  */
+  if (vcall_offset)
+    {
+      rtx scratch = gen_rtx_REG (Pmode, PE_TMP_REGNUM);
+      HOST_WIDE_INT lo = sext_hwi (vcall_offset, 16);
+      HOST_WIDE_INT hi = vcall_offset - lo;
+      rtx tmp;
+
+      /* SCRATCH = *THIS_RTX.  */
+      tmp = gen_rtx_MEM (Pmode, this_rtx);
+      emit_move_insn (scratch, tmp);
+
+      if (hi != 0)
+	{
+	  rtx scratch2 = gen_rtx_REG (Pmode, RV_REGNUM);
+	  emit_move_insn (scratch2, GEN_INT (hi));
+	  emit_insn (gen_add2_insn (scratch, scratch2));
+	}
+
+      /* SCRATCH = *(*THIS_RTX + VCALL_OFFSET).  */
+      tmp = plus_constant (Pmode, scratch, lo);
+      tmp = gen_rtx_MEM (Pmode, tmp);
+      emit_move_insn (scratch, tmp);
+
+      /* THIS_RTX += *(*THIS_RTX + VCALL_OFFSET).  */
+      emit_insn (gen_add2_insn (this_rtx, scratch));
+    }
+
+  /* Generate a tail call to the target function.  */
+  if (!TREE_USED (function))
+    {
+      assemble_external (function);
+      TREE_USED (function) = 1;
+    }
+  funexp = XEXP (DECL_RTL (function), 0);
+
+  /* The symbol will be a local alias and therefore always binds local.  */
+  gcc_assert (SYMBOL_REF_LOCAL_P (funexp));
+
+  funexp = gen_rtx_MEM (FUNCTION_MODE, funexp);
+  insn = emit_call_insn (gen_sibcall (funexp, const0_rtx));
+  SIBLING_CALL_P (insn) = 1;
+  emit_barrier ();
+
+  /* Run just enough of rest_of_compilation to get the insns emitted.
+     There's not really enough bulk here to make other passes such as
+     instruction scheduling worth while.  Note that use_thunk calls
+     assemble_start_function and assemble_end_function.  */
+  insn = get_insns ();
+  shorten_branches (insn);
+  final_start_function (insn, file, 1);
+  final (insn, file, 1);
+  final_end_function ();
+
+  reload_completed = 0;
+  epilogue_completed = 0;
+}
+
+#undef  TARGET_ASM_OUTPUT_MI_THUNK
+#define TARGET_ASM_OUTPUT_MI_THUNK or1k_output_mi_thunk
+#undef  TARGET_ASM_CAN_OUTPUT_MI_THUNK
+#define TARGET_ASM_CAN_OUTPUT_MI_THUNK \
+  hook_bool_const_tree_hwi_hwi_const_tree_true
+
+#undef  TARGET_OPTION_OVERRIDE
+#define TARGET_OPTION_OVERRIDE or1k_option_override
+
+#undef  TARGET_COMPUTE_FRAME_LAYOUT
+#define TARGET_COMPUTE_FRAME_LAYOUT or1k_compute_frame_layout
+
+#undef  TARGET_LEGITIMATE_ADDRESS_P
+#define TARGET_LEGITIMATE_ADDRESS_P or1k_legitimate_address_p
+
+#undef  TARGET_HAVE_TLS
+#define TARGET_HAVE_TLS true
+
+#undef  TARGET_HAVE_SPECULATION_SAFE_VALUE
+#define TARGET_HAVE_SPECULATION_SAFE_VALUE speculation_safe_value_not_needed
+
+/* Calling Conventions.  */
+#undef  TARGET_FUNCTION_VALUE
+#define TARGET_FUNCTION_VALUE or1k_function_value
+#undef  TARGET_LIBCALL_VALUE
+#define TARGET_LIBCALL_VALUE or1k_libcall_value
+#undef  TARGET_FUNCTION_VALUE_REGNO_P
+#define TARGET_FUNCTION_VALUE_REGNO_P or1k_function_value_regno_p
+#undef  TARGET_FUNCTION_ARG
+#define TARGET_FUNCTION_ARG or1k_function_arg
+#undef  TARGET_FUNCTION_ARG_ADVANCE
+#define TARGET_FUNCTION_ARG_ADVANCE or1k_function_arg_advance
+#undef  TARGET_RETURN_IN_MEMORY
+#define TARGET_RETURN_IN_MEMORY or1k_return_in_memory
+#undef  TARGET_PASS_BY_REFERENCE
+#define TARGET_PASS_BY_REFERENCE or1k_pass_by_reference
+#undef  TARGET_TRAMPOLINE_INIT
+#define TARGET_TRAMPOLINE_INIT or1k_trampoline_init
+#undef  TARGET_FRAME_POINTER_REQUIRED
+#define TARGET_FRAME_POINTER_REQUIRED or1k_frame_pointer_required
+#undef  TARGET_CUSTOM_FUNCTION_DESCRIPTORS
+#define TARGET_CUSTOM_FUNCTION_DESCRIPTORS 1
+
+/* Assembly generation.  */
+#undef  TARGET_PRINT_OPERAND
+#define TARGET_PRINT_OPERAND or1k_print_operand
+#undef  TARGET_PRINT_OPERAND_ADDRESS
+#define TARGET_PRINT_OPERAND_ADDRESS or1k_print_operand_address
+
+/* Section anchor support.  */
+#undef  TARGET_MIN_ANCHOR_OFFSET
+#define TARGET_MIN_ANCHOR_OFFSET  -32768
+#undef  TARGET_MAX_ANCHOR_OFFSET
+#define TARGET_MAX_ANCHOR_OFFSET  32767
+
+struct gcc_target targetm = TARGET_INITIALIZER;
+
+#include "gt-or1k.h"
diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
new file mode 100644
index 00000000000..c3e42a08724
--- /dev/null
+++ b/gcc/config/or1k/or1k.h
@@ -0,0 +1,392 @@
+/* Target Definitions for OpenRISC.
+   Copyright (C) 2018 Free Software Foundation, Inc.
+   Contributed by Stafford Horne.
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 3, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING3.  If not see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef GCC_OR1K_H
+#define GCC_OR1K_H
+
+/* Names to predefine in the preprocessor for this target machine.  */
+#define TARGET_CPU_CPP_BUILTINS()		\
+  do						\
+    {						\
+      builtin_define ("__OR1K__");		\
+      builtin_define ("__OR1K_DELAY__");	\
+      builtin_define ("__or1k__");		\
+      if (TARGET_CMOV)				\
+	builtin_define ("__or1k_cmov__");	\
+      builtin_assert ("cpu=or1k");		\
+      builtin_assert ("machine=or1k");		\
+    }						\
+  while (0)
+
+/* Storage layout.  */
+
+#define DEFAULT_SIGNED_CHAR 1
+#define BITS_BIG_ENDIAN 0
+#define BYTES_BIG_ENDIAN 1
+#define WORDS_BIG_ENDIAN 1
+#define BITS_PER_WORD 32
+#define UNITS_PER_WORD 4
+#define POINTER_SIZE 32
+#define BIGGEST_ALIGNMENT 32
+#define STRICT_ALIGNMENT 1
+#define FUNCTION_BOUNDARY 32
+#define PARM_BOUNDARY 32
+#define STACK_BOUNDARY 32
+#define PREFERRED_STACK_BOUNDARY 32
+#define MAX_FIXED_MODE_SIZE 64
+
+/* Layout of source language data types.  */
+
+#define INT_TYPE_SIZE 32
+#define SHORT_TYPE_SIZE 16
+#define LONG_TYPE_SIZE 32
+#define LONG_LONG_TYPE_SIZE 64
+#define FLOAT_TYPE_SIZE 32
+#define DOUBLE_TYPE_SIZE 64
+#define LONG_DOUBLE_TYPE_SIZE 64
+#define WCHAR_TYPE_SIZE 32
+
+#undef SIZE_TYPE
+#define SIZE_TYPE "unsigned int"
+
+#undef PTRDIFF_TYPE
+#define PTRDIFF_TYPE "int"
+
+#undef WCHAR_TYPE
+#define WCHAR_TYPE "unsigned int"
+
+/* Describing Relative Costs of Operations.  */
+#define MOVE_MAX 4
+#define SLOW_BYTE_ACCESS 1
+
+/* Register usage, class and contents.  */
+
+/* In OpenRISC there are 32 general purpose registers with the following
+   designations:
+
+   r0    always 0
+   r1    stack pointer
+   r2    frame pointer (optional)
+   r3    arg 0
+   r4    arg 1
+   r5    arg 2
+   r6    arg 3
+   r7    arg 4
+   r8    arg 5
+   r9    function call return link address
+   r10   thread local storage
+   r11   function return value & static chain
+   r12   function return value high (upper 64-bit)
+   r13   temporary (used in prologue and epilogue)
+   r14   callee saved
+   r15   temporary
+   r16   callee saved & pic base register
+   r17   temporary
+   r18   callee saved
+   r19   temporary
+   r20   callee saved
+   r21   temporary
+   r22   callee saved
+   r23   temporary
+   r24   callee saved
+   r25   temporary
+   r26   callee saved
+   r27   temporary
+   r28   callee saved
+   r29   temporary
+   r30   callee saved
+   r31   temporary
+
+   r32   soft argument pointer
+   r33   soft frame pointer
+   r34   SR[F] (bit) register
+
+   This ABI has no adjacent call-saved register, which means that
+   DImode/DFmode pseudos cannot be call-saved and will always be
+   spilled across calls.  To solve this without changing the ABI,
+   remap the compiler internal register numbers to place the even
+   call-saved registers r16-r30 in 24-31, and the odd call-clobbered
+   registers r17-r31 in 16-23.  */
+
+#define FIRST_PSEUDO_REGISTER  35
+
+#define HW_TO_GCC_REGNO(X)		\
+  ((X) < 16 || (X) > 31 ? (X)		\
+   : (X) & 1 ? ((X) - 16) / 2 + 16	\
+   : ((X) - 16) / 2 + 24)
+
+#define GCC_TO_HW_REGNO(X)		\
+  ((X) < 16 || (X) > 31 ? (X)		\
+   : (X) < 24 ? ((X) - 16) * 2 + 17	\
+   : ((X) - 24) * 2 + 16)
+
+#define DBX_REGISTER_NUMBER(X)  GCC_TO_HW_REGNO(X)
+
+#define REGISTER_NAMES { \
+  "r0",   "r1",   "r2",   "r3",   "r4",   "r5",   "r6",   "r7",   \
+  "r8",   "r9",   "r10",  "r11",  "r12",  "r13",  "r14",  "r15",  \
+  "r17",  "r19",  "r21",  "r23",  "r25",  "r27",  "r29",  "r31",  \
+  "r16",  "r18",  "r20",  "r22",  "r24",  "r26",  "r28",  "r30",  \
+  "?ap",  "?fp",  "?sr_f" }
+
+#define FIXED_REGISTERS		\
+{ 1, 1, 0, 0, 0, 0, 0, 0,	\
+  0, 0, 1, 0, 0, 0, 0, 0,	\
+  0, 0, 0, 0, 0, 0, 0, 0,	\
+  0, 0, 0, 0, 0, 0, 0, 0,	\
+  1, 1, 1 }
+
+/* Caller saved/temporary registers + args + fixed */
+#define CALL_USED_REGISTERS	\
+{ 1, 1, 0, 1, 1, 1, 1, 1,	\
+  1, 1, 1, 1, 1, 1, 0, 1,	\
+  1, 1, 1, 1, 1, 1, 1, 1,	\
+  0, 0, 0, 0, 0, 0, 0, 0,	\
+  1, 1, 1 }
+
+/* List the order in which to allocate registers.  Each register must
+   be listed once, even those in FIXED_REGISTERS.
+
+   ??? Note that placing REAL_PIC_OFFSET_TABLE_REGNUM (r16 = 24) first
+   happens to make it most likely selected *as* the pic register when
+   compiling without optimization, simply because the pic pseudo happens
+   to be allocated with the lowest pseudo regno.  */
+
+#define REG_ALLOC_ORDER { \
+  16, 17, 18, 19, 20, 21, 22, 23,	/* r17-r31 (odd), non-saved */	\
+  13, 15,				/* non-saved */			\
+  12, 11,				/* non-saved return values */	\
+  8, 7, 6, 5, 4, 3,			/* non-saved argument regs */	\
+  24,					/* r16, saved, pic reg */	\
+  25, 26, 27, 28, 29, 30, 31,		/* r18-r31 (even), saved */	\
+  14,					/* r14, saved */		\
+  2,					/* saved hard frame pointer */	\
+  9,					/* saved return address */	\
+  0,					/* fixed zero reg */		\
+  1,					/* fixed stack pointer */	\
+  10,					/* fixed thread pointer */	\
+  32, 33, 34,				/* fixed ap, fp, sr[f], */	\
+}
+
+enum reg_class
+{
+  NO_REGS,
+  SIBCALL_REGS,
+  GENERAL_REGS,
+  FLAG_REGS,
+  ALL_REGS,
+  LIM_REG_CLASSES
+};
+
+#define N_REG_CLASSES (int) LIM_REG_CLASSES
+
+#define REG_CLASS_NAMES {	\
+  "NO_REGS", 			\
+  "SIBCALL_REGS",		\
+  "GENERAL_REGS",		\
+  "FLAG_REGS",			\
+  "ALL_REGS" }
+
+/* The SIBCALL_REGS must be call-clobbered, and not used as a temporary
+   in the epilogue.  This excludes R9 (LR), R11 (STATIC_CHAIN), and
+   R13 (PE_TMP_REGNUM).  */
+#define SIBCALL_REGS_MASK  0x00ff95f8u
+
+#define REG_CLASS_CONTENTS      \
+{ { 0x00000000, 0x00000000 },	\
+  { SIBCALL_REGS_MASK,   0 },	\
+  { 0xffffffff, 0x00000003 },	\
+  { 0x00000000, 0x00000004 },	\
+  { 0xffffffff, 0x00000007 }	\
+}
+
+/* A C expression whose value is a register class containing hard
+   register REGNO.  In general there is more that one such class;
+   choose a class which is "minimal", meaning that no smaller class
+   also contains the register.  */
+#define REGNO_REG_CLASS(REGNO) \
+  ((REGNO) >= SR_F_REGNUM ? FLAG_REGS \
+   : (REGNO) < 32 && ((SIBCALL_REGS_MASK >> (REGNO)) & 1) ? SIBCALL_REGS \
+   : GENERAL_REGS)
+
+#define PROMOTE_MODE(MODE,UNSIGNEDP,TYPE)               \
+do {                                                    \
+  if (GET_MODE_CLASS (MODE) == MODE_INT                 \
+      && GET_MODE_SIZE (MODE) < UNITS_PER_WORD)         \
+    (MODE) = word_mode;                                 \
+} while (0)
+
+/* A macro whose definition is the name of the class to which a valid
+   base register must belong.  A base register is one used in an
+   address which is the register value plus a displacement.  */
+#define BASE_REG_CLASS GENERAL_REGS
+
+#define INDEX_REG_CLASS NO_REGS
+
+/* Assembly definitions.  */
+
+#define ASM_APP_ON ""
+#define ASM_APP_OFF ""
+
+#define ASM_COMMENT_START "# "
+
+#define GLOBAL_ASM_OP "\t.global\t"
+#define TEXT_SECTION_ASM_OP "\t.section\t.text"
+#define DATA_SECTION_ASM_OP "\t.section\t.data"
+#define BSS_SECTION_ASM_OP "\t.section\t.bss"
+#define SBSS_SECTION_ASM_OP "\t.section\t.sbss"
+
+/* This is how to output an assembler line
+   that says to advance the location counter
+   to a multiple of 2**LOG bytes.  */
+#define ASM_OUTPUT_ALIGN(FILE,LOG)			\
+  do							\
+    {							\
+      if ((LOG) != 0)					\
+	fprintf (FILE, "\t.align %d\n", 1 << (LOG));	\
+    }							\
+  while (0)
+
+/* This is used in crtstuff to create call stubs in the
+   _init() and _fini() functions.  Defining this here saves
+   a few bytes created by the dummy call_xxx() functions.  */
+#define CRT_CALL_STATIC_FUNCTION(SECTION_OP, FUNC)	\
+  asm (SECTION_OP "\n"					\
+"	l.jal " #FUNC "\n"				\
+"	 l.nop\n"					\
+"	.previous");
+
+
+#define PRINT_OPERAND_PUNCT_VALID_P(CODE) (code == '#')
+
+/* Calling convention definitions.  */
+#define CUMULATIVE_ARGS int
+#define INIT_CUMULATIVE_ARGS(CUM, FNTYPE, LIBNAME, FNDECL, N_NAMED_ARGS) \
+  do { (CUM) = 0; } while (0)
+
+
+/* Trampolines, for nested functions */
+#define TRAMPOLINE_SIZE      20
+#define TRAMPOLINE_ALIGNMENT 32
+
+/* Pointer mode */
+#define Pmode SImode
+#define FUNCTION_MODE SImode
+#define STACK_POINTER_REGNUM SP_REGNUM
+#define FRAME_POINTER_REGNUM SFP_REGNUM
+#define HARD_FRAME_POINTER_REGNUM HFP_REGNUM
+#define STATIC_CHAIN_REGNUM RV_REGNUM
+
+/* The register number of the arg pointer register, which is used to
+   access the function's argument list.  */
+#define ARG_POINTER_REGNUM AP_REGNUM
+
+/* Position Independent Code.  See or1k_init_pic_reg.  */
+#define REAL_PIC_OFFSET_TABLE_REGNUM  HW_TO_GCC_REGNO (16)
+
+/* ??? Follow i386 in working around gimple costing estimation, which
+   happens without properly initializing the pic_offset_table pseudo.  */
+#define PIC_OFFSET_TABLE_REGNUM \
+  (pic_offset_table_rtx ? INVALID_REGNUM : REAL_PIC_OFFSET_TABLE_REGNUM)
+
+/* A C expression that is nonzero if REGNO is the number of a hard
+   register in which function arguments are sometimes passed.  */
+#define FUNCTION_ARG_REGNO_P(r) (r >= 3 && r <= 8)
+
+#define MAX_REGS_PER_ADDRESS 1
+
+/* The ELIMINABLE_REGS macro specifies a table of register pairs used to
+   eliminate unneeded registers that point into the stack frame. Note,
+   the only elimination attempted by the compiler is to replace references
+   to the frame pointer with references to the stack pointer.  */
+
+#define ELIMINABLE_REGS					\
+{{ FRAME_POINTER_REGNUM, STACK_POINTER_REGNUM },	\
+ { FRAME_POINTER_REGNUM, HARD_FRAME_POINTER_REGNUM },	\
+ { ARG_POINTER_REGNUM,   STACK_POINTER_REGNUM },	\
+ { ARG_POINTER_REGNUM,   HARD_FRAME_POINTER_REGNUM }}
+
+#define INITIAL_ELIMINATION_OFFSET(FROM, TO, OFFSET) \
+  do {							\
+    (OFFSET) = or1k_initial_elimination_offset ((FROM), (TO)); \
+  } while (0)
+
+#define REGNO_OK_FOR_INDEX_P(REGNO) 0
+#define REGNO_OK_FOR_BASE_P(REGNO)  ((REGNO) <= SFP_REGNUM)
+
+/* If defined, the maximum amount of space required for outgoing
+   arguments will be computed and placed into the variable
+   'crtl->outgoing_args_size'.  No space will be pushed
+   onto the stack for each call; instead, the function prologue
+   should increase the stack frame size by this amount.  */
+#define ACCUMULATE_OUTGOING_ARGS 1
+
+/* Stack layout and stack pointer usage.  */
+
+/* This plus ARG_POINTER_REGNUM points to the first word of incoming args.  */
+#define FIRST_PARM_OFFSET(FNDECL) (0)
+
+/* This plus STACK_POINTER_REGNUM points to the first work of outgoing args.  */
+#define STACK_POINTER_OFFSET (0)
+
+/* Define this macro if pushing a word onto the stack moves the stack
+   pointer to a smaller address.  */
+#define STACK_GROWS_DOWNWARD 1
+
+#define FRAME_GROWS_DOWNWARD 1
+
+/* An alias for a machine mode name.  This is the machine mode that
+   elements of a jump-table should have.  */
+#define CASE_VECTOR_MODE SImode
+
+#define STORE_FLAG_VALUE 1
+
+/* Indicates how loads of narrow mode values are loaded into words.  */
+#define LOAD_EXTEND_OP(MODE) (ZERO_EXTEND)
+
+/* EXIT_IGNORE_STACK should be nonzero if, when returning from a function,
+   the stack pointer does not matter.  */
+#define EXIT_IGNORE_STACK 1
+
+/* Macros related to the access of the stack frame chain.  */
+#define INITIAL_FRAME_ADDRESS_RTX  or1k_initial_frame_addr ()
+#define DYNAMIC_CHAIN_ADDRESS      or1k_dynamic_chain_addr
+#define RETURN_ADDR_RTX            or1k_return_addr
+
+/* Always pass the SYMBOL_REF for direct calls to the expanders.  */
+#define NO_FUNCTION_CSE 1
+
+/* Profiling */
+#define FUNCTION_PROFILER(FILE,LABELNO) (abort (), 0)
+
+/* Dwarf 2 Support */
+#define DWARF2_DEBUGGING_INFO 1
+#define INCOMING_RETURN_ADDR_RTX gen_rtx_REG (Pmode, LR_REGNUM)
+#define DWARF_FRAME_RETURN_COLUMN LR_REGNUM
+
+/* Describe how we implement __builtin_eh_return.  */
+#define EH_RETURN_REGNUM HW_TO_GCC_REGNO (23)
+/* Use r25, r27, r29 and r31 (clobber regs) for exception data.
+   Recall that these are remapped consecutively.  */
+#define EH_RETURN_DATA_REGNO(N)	\
+    ((N) < 4 ? HW_TO_GCC_REGNO (25) + (N) : INVALID_REGNUM)
+#define EH_RETURN_STACKADJ_RTX gen_rtx_REG (Pmode, EH_RETURN_REGNUM)
+
+#endif /* GCC_OR1K_H */
diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
new file mode 100644
index 00000000000..d131aa53abf
--- /dev/null
+++ b/gcc/config/or1k/or1k.md
@@ -0,0 +1,897 @@
+;; Machine description for OpenRISC
+;; Copyright (C) 2018 Free Software Foundation, Inc.
+;; Contributed by Stafford Horne
+
+;; This file is part of GCC.
+
+;; GCC is free software; you can redistribute it and/or modify it
+;; under the terms of the GNU General Public License as published
+;; by the Free Software Foundation; either version 3, or (at your
+;; option) any later version.
+
+;; GCC is distributed in the hope that it will be useful, but WITHOUT
+;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+;; License for more details.
+
+;; You should have received a copy of the GNU General Public License
+;; along with GCC; see the file COPYING3.  If not see
+;; <http://www.gnu.org/licenses/>.
+
+;; -------------------------------------------------------------------------
+;; OpenRISC specific constraints, predicates and attributes
+;; -------------------------------------------------------------------------
+
+(include "constraints.md")
+(include "predicates.md")
+
+;; Register numbers
+(define_constants
+  [(SP_REGNUM       1)
+   (HFP_REGNUM      2)
+   (LR_REGNUM       9)
+   (TLS_REGNUM     10)
+   (RV_REGNUM      11)
+   (PE_TMP_REGNUM  13)
+   (AP_REGNUM      32)
+   (SFP_REGNUM     33)
+   (SR_F_REGNUM    34)]
+)
+
+(define_c_enum "unspec" [
+  UNSPEC_SET_GOT
+  UNSPEC_GOT
+  UNSPEC_GOTOFF
+  UNSPEC_TPOFF
+  UNSPEC_GOTTPOFF
+  UNSPEC_TLSGD
+  UNSPEC_MSYNC
+])
+
+(define_c_enum "unspecv" [
+  UNSPECV_SET_GOT
+  UNSPECV_LL
+  UNSPECV_SC
+])
+
+;; Instruction scheduler
+
+; Most instructions are 4 bytes long.
+(define_attr "length" "" (const_int 4))
+
+(define_attr "type"
+  "alu,st,ld,control,multi"
+  (const_string "alu"))
+
+(define_attr "insn_support" "class1,sext,sfimm,shftimm" (const_string "class1"))
+
+(define_attr "enabled" ""
+  (cond [(eq_attr "insn_support" "class1") (const_int 1)
+	 (and (eq_attr "insn_support" "sext")
+	      (ne (symbol_ref "TARGET_SEXT") (const_int 0))) (const_int 1)
+	 (and (eq_attr "insn_support" "sfimm")
+	      (ne (symbol_ref "TARGET_SFIMM") (const_int 0))) (const_int 1)
+	 (and (eq_attr "insn_support" "shftimm")
+	      (ne (symbol_ref "TARGET_SHFTIMM") (const_int 0))) (const_int 1)]
+	(const_int 0)))
+
+;; Describe a user's asm statement.
+(define_asm_attributes
+  [(set_attr "type" "multi")])
+
+(define_automaton "or1k")
+(define_cpu_unit "cpu" "or1k")
+(define_insn_reservation "alu" 1
+  (eq_attr "type" "alu")
+  "cpu")
+(define_insn_reservation "st" 1
+  (eq_attr "type" "st")
+  "cpu")
+(define_insn_reservation "ld" 3
+  (eq_attr "type" "st")
+  "cpu")
+(define_insn_reservation "control" 1
+  (eq_attr "type" "control")
+  "cpu")
+
+; Define delay slots for any branch
+(define_delay (eq_attr "type" "control")
+  [(eq_attr "type" "alu,st,ld") (nil) (nil)])
+
+;; -------------------------------------------------------------------------
+;; nop instruction
+;; -------------------------------------------------------------------------
+
+(define_insn "nop"
+  [(const_int 0)]
+  ""
+  "l.nop")
+
+;; -------------------------------------------------------------------------
+;; Arithmetic instructions
+;; -------------------------------------------------------------------------
+
+(define_insn "addsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	  (plus:SI
+	   (match_operand:SI 1 "register_operand"   "%r,r")
+	   (match_operand:SI 2 "reg_or_s16_operand" " r,I")))]
+  ""
+  "@
+  l.add\t%0, %1, %2
+  l.addi\t%0, %1, %2")
+
+(define_insn "mulsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	  (mult:SI
+	   (match_operand:SI 1 "register_operand"   "%r,r")
+	   (match_operand:SI 2 "reg_or_s16_operand" " r,I")))]
+  "!TARGET_SOFT_MUL"
+  "@
+  l.mul\t%0, %1, %2
+  l.muli\t%0, %1, %2")
+
+(define_insn "divsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	  (div:SI
+	   (match_operand:SI 1 "register_operand" "r")
+	   (match_operand:SI 2 "register_operand" "r")))]
+  "!TARGET_SOFT_DIV"
+  "l.div\t%0, %1, %2")
+
+(define_insn "udivsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	  (udiv:SI
+	   (match_operand:SI 1 "register_operand" "r")
+	   (match_operand:SI 2 "register_operand" "r")))]
+  "!TARGET_SOFT_DIV"
+  "l.divu\t%0, %1, %2")
+
+(define_insn "subsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	  (minus:SI
+	   (match_operand:SI 1 "reg_or_0_operand" "rO")
+	   (match_operand:SI 2 "register_operand" "r")))]
+  ""
+  "l.sub\t%0, %r1, %2")
+
+;; -------------------------------------------------------------------------
+;; Logical operators
+;; -------------------------------------------------------------------------
+
+(define_code_iterator SHIFT  [ashift ashiftrt lshiftrt])
+(define_code_attr shift_op   [(ashift "ashl") (ashiftrt "ashr")
+			      (lshiftrt "lshr")])
+(define_code_attr shift_asm  [(ashift "sll") (ashiftrt "sra")
+			      (lshiftrt "srl")])
+
+(define_insn "<shift_op>si3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	(SHIFT:SI (match_operand:SI 1 "register_operand"  "r,r")
+		  (match_operand:SI 2 "reg_or_u6_operand" "r,n")))]
+  ""
+  "@
+   l.<shift_asm>\t%0, %1, %2
+   l.<shift_asm>i\t%0, %1, %2"
+  [(set_attr "insn_support" "*,shftimm")])
+
+(define_insn "rotrsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	(rotatert:SI (match_operand:SI 1 "register_operand"  "r,r")
+		  (match_operand:SI 2 "reg_or_u6_operand" "r,n")))]
+  "TARGET_ROR"
+  "@
+   l.ror\t%0, %1, %2
+   l.rori\t%0, %1, %2"
+  [(set_attr "insn_support" "*,shftimm")])
+
+(define_insn "andsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	  (and:SI
+	   (match_operand:SI 1 "register_operand"   "%r,r")
+	   (match_operand:SI 2 "reg_or_u16_operand" " r,K")))]
+  ""
+  "@
+  l.and\t%0, %1, %2
+  l.andi\t%0, %1, %2")
+
+(define_insn "xorsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	  (xor:SI
+	   (match_operand:SI 1 "register_operand"   "%r,r")
+	   (match_operand:SI 2 "reg_or_s16_operand" " r,I")))]
+  ""
+  "@
+  l.xor\t%0, %1, %2
+  l.xori\t%0, %1, %2")
+
+(define_insn "iorsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	  (ior:SI
+	   (match_operand:SI 1 "register_operand"   "%r,r")
+	   (match_operand:SI 2 "reg_or_u16_operand" " r,K")))]
+  ""
+  "@
+  l.or\t%0, %1, %2
+  l.ori\t%0, %1, %2")
+
+(define_expand "one_cmplsi2"
+  [(set (match_operand:SI 0 "register_operand" "")
+	(xor:SI (match_operand:SI 1 "register_operand" "") (const_int -1)))]
+  ""
+  "")
+
+;; -------------------------------------------------------------------------
+;; Move instructions
+;; -------------------------------------------------------------------------
+
+(define_mode_iterator I [QI HI SI])
+(define_mode_iterator I12 [QI HI])
+
+(define_mode_attr ldst [(QI "b") (HI "h") (SI "w")])
+(define_mode_attr zext_andi [(QI "0xff") (HI "0xffff")])
+
+(define_expand "mov<I:mode>"
+  [(set (match_operand:I 0 "nonimmediate_operand" "")
+	(match_operand:I 1 "general_operand" ""))]
+  ""
+{
+  or1k_expand_move (<MODE>mode, operands[0], operands[1]);
+  DONE;
+})
+
+;; 8-bit, 16-bit and 32-bit moves
+
+(define_insn "*mov<I:mode>_internal"
+  [(set (match_operand:I 0 "nonimmediate_operand" "=r,r,r,r, m,r")
+	(match_operand:I 1 "input_operand"        " r,M,K,I,rO,m"))]
+  "register_operand (operands[0], <I:MODE>mode)
+   || reg_or_0_operand (operands[1], <I:MODE>mode)"
+  "@
+   l.or\t%0, %1, %1
+   l.movhi\t%0, hi(%1)
+   l.ori\t%0, r0, %1
+   l.xori\t%0, r0, %1
+   l.s<I:ldst>\t%0, %r1
+   l.l<I:ldst>z\t%0, %1"
+  [(set_attr "type" "alu,alu,alu,alu,st,ld")])
+
+;; Hi/Low moves for constant and symbol loading
+
+(define_insn "movsi_high"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(high:SI (match_operand:SI 1 "high_operand" "")))]
+  ""
+  "l.movhi\t%0, %h1"
+  [(set_attr "type" "alu")])
+
+(define_insn "*movsi_lo_sum_iori"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(lo_sum:SI (match_operand:SI 1 "register_operand"  "r")
+		   (match_operand:SI 2 "losum_ior_operand" "")))]
+  ""
+  "l.ori\t%0, %1, %L2"
+  [(set_attr "type" "alu")])
+
+(define_insn "*movsi_lo_sum_addi"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(lo_sum:SI (match_operand:SI 1 "register_operand"  "r")
+		   (match_operand:SI 2 "losum_add_operand" "")))]
+  ""
+  "l.addi\t%0, %1, %L2"
+  [(set_attr "type" "alu")])
+
+;; 64-bit moves
+;; ??? The clobber that emit_move_multi_word emits is arguably incorrect.
+;; Consider gcc.c-torture/execute/20030222-1.c, where a reg-reg DImode
+;; move gets register allocated to a no-op move.  At which point the
+;; we actively clobber the input.
+
+(define_expand "movdi"
+  [(set (match_operand:DI 0 "nonimmediate_operand" "")
+	(match_operand:DI 1 "general_operand" ""))]
+  ""
+{
+  if (MEM_P (operands[0]) && !const0_operand(operands[1], DImode))
+    operands[1] = force_reg (DImode, operands[1]);
+})
+
+(define_insn_and_split "*movdi"
+  [(set (match_operand:DI 0 "nonimmediate_operand" "=r,r,o,r")
+	(match_operand:DI 1 "general_operand"      " r,o,rO,n"))]
+  "register_operand (operands[0], DImode)
+   || reg_or_0_operand (operands[1], DImode)"
+  "#"
+  ""
+  [(const_int 0)]
+{
+  rtx l0 = operand_subword (operands[0], 0, 0, DImode);
+  rtx l1 = operand_subword (operands[1], 0, 0, DImode);
+  rtx h0 = operand_subword (operands[0], 1, 0, DImode);
+  rtx h1 = operand_subword (operands[1], 1, 0, DImode);
+
+  if (reload_completed && reg_overlap_mentioned_p (l0, h1))
+    {
+      gcc_assert (!reg_overlap_mentioned_p (h0, l1));
+      emit_move_insn (h0, h1);
+      emit_move_insn (l0, l1);
+    }
+  else
+    {
+      emit_move_insn (l0, l1);
+      emit_move_insn (h0, h1);
+    }
+  DONE;
+})
+
+;; -------------------------------------------------------------------------
+;; Sign Extending
+;; -------------------------------------------------------------------------
+
+;; Zero extension can always be done with AND and an extending load.
+
+(define_insn "zero_extend<mode>si2"
+  [(set (match_operand:SI 0 "register_operand"                     "=r,r")
+	(zero_extend:SI (match_operand:I12 1 "nonimmediate_operand" "r,m")))]
+  ""
+  "@
+   l.andi\t%0, %1, <zext_andi>
+   l.l<ldst>z\t%0, %1")
+
+;; Sign extension in registers is an optional extension, but the
+;; extending load is always available.  If SEXT is not available,
+;; force the middle-end to do the expansion to shifts.
+
+(define_insn "extend<mode>si2"
+  [(set (match_operand:SI 0 "register_operand"                      "=r,r")
+	(sign_extend:SI (match_operand:I12 1 "nonimmediate_operand"  "r,m")))]
+  "TARGET_SEXT"
+  "@
+   l.ext<ldst>s\t%0, %1
+   l.l<ldst>s\t%0, %1")
+
+(define_insn "*extend<mode>si2_mem"
+  [(set (match_operand:SI 0 "register_operand"                "=r")
+	(sign_extend:SI (match_operand:I12 1 "memory_operand"  "m")))]
+  ""
+  "l.l<ldst>s\t%0, %1")
+
+;; -------------------------------------------------------------------------
+;; Compare instructions
+;; -------------------------------------------------------------------------
+
+;; OpenRISC supports these integer comparisons:
+;;
+;;     l.sfeq[i] - equality, r r or r i
+;;     l.sfne[i] - not equal, r r or r i
+;;     l.sflt{s,u}[i] - less than, signed or unsigned, r r or r i
+;;     l.sfle{s,u}[i] - less than or equal, signed or unsigned, r r or r i
+;;     l.sfgt{s,u}[i] - greater than, signed or unsigned, r r or r i
+;;     l.sfge{s,u}[i] - greater than or equal, signed or unsigned, r r or r i
+;;
+;;  EQ,NE,LT,LTU,LE,LEU,GT,GTU,GE,GEU
+;;  We iterate through all of these
+;;
+
+(define_code_iterator intcmpcc [ne eq lt ltu gt gtu ge le geu leu])
+(define_code_attr insn [(ne "ne") (eq "eq") (lt "lts") (ltu "ltu")
+			(gt "gts") (gtu "gtu") (ge "ges") (le "les")
+			(geu "geu") (leu "leu") ])
+
+(define_insn "*sf_insn"
+  [(set (reg:BI SR_F_REGNUM)
+	(intcmpcc:BI (match_operand:SI 0 "reg_or_0_operand"   "rO,rO")
+		     (match_operand:SI 1 "reg_or_s16_operand" "r,I")))]
+  ""
+  "@
+   l.sf<insn>\t%r0, %1
+   l.sf<insn>i\t%r0, %1"
+  [(set_attr "insn_support" "*,sfimm")])
+
+;; -------------------------------------------------------------------------
+;; Conditional Store instructions
+;; -------------------------------------------------------------------------
+
+(define_expand "cstoresi4"
+  [(set (match_operand:SI 0 "register_operand" "")
+	(if_then_else:SI
+	  (match_operator 1 "comparison_operator"
+	    [(match_operand:SI 2 "reg_or_0_operand" "")
+	     (match_operand:SI 3 "reg_or_s16_operand" "")])
+	  (match_dup 0)
+	  (const_int 0)))]
+  ""
+{
+  or1k_expand_compare (operands + 1);
+  PUT_MODE (operands[1], SImode);
+  emit_insn (gen_rtx_SET (operands[0], operands[1]));
+  DONE;
+})
+
+;; Being able to "copy" SR_F to a general register is helpful for
+;; the atomic insns, wherein the usual usage is to test the success
+;; of the compare-and-swap.  Representing the operation in this way,
+;; rather than exposing the cmov immediately, allows the optimizers
+;; to propagate the use of SR_F directly into a branch.
+
+(define_expand "sne_sr_f"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(ne:SI (reg:BI SR_F_REGNUM) (const_int 0)))]
+  "")
+
+(define_insn_and_split "*scc"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(match_operator:SI 1 "equality_comparison_operator"
+	  [(reg:BI SR_F_REGNUM) (const_int 0)]))]
+  ""
+  "#"
+  "reload_completed"
+  [(set (match_dup 0) (const_int 1))
+   (set (match_dup 0)
+	(if_then_else:SI (match_dup 1)
+	  (match_dup 0)
+	  (const_int 0)))]
+  "")
+
+(define_expand "mov<I:mode>cc"
+  [(set (match_operand:I 0 "register_operand" "")
+	(if_then_else:I (match_operand 1 "comparison_operator" "")
+	  (match_operand:I 2 "reg_or_0_operand" "")
+	  (match_operand:I 3 "reg_or_0_operand" "")))]
+  ""
+{
+  rtx xops[3] = { operands[1], XEXP (operands[1], 0), XEXP (operands[1], 1) };
+  or1k_expand_compare (xops);
+  operands[1] = xops[0];
+})
+
+(define_insn_and_split "*cmov<I:mode>"
+  [(set (match_operand:I 0 "register_operand" "=r")
+	(if_then_else:I
+	  (match_operator 3 "equality_comparison_operator"
+	    [(reg:BI SR_F_REGNUM) (const_int 0)])
+	  (match_operand:I 1 "reg_or_0_operand" "rO")
+	  (match_operand:I 2 "reg_or_0_operand" "rO")))]
+  ""
+{
+  return (GET_CODE (operands[3]) == NE
+	  ? "l.cmov\t%0, %r1, %r2"
+	  : "l.cmov\t%0, %r2, %r1");
+}
+  "!TARGET_CMOV"
+  [(const_int 0)]
+{
+  rtx x;
+  rtx label = gen_rtx_LABEL_REF (VOIDmode, gen_label_rtx ());
+
+  /* Generated a *cbranch pattern.  */
+  if (rtx_equal_p (operands[0], operands[2]))
+    {
+      PUT_CODE (operands[3], (GET_CODE (operands[3]) == NE) ? EQ : NE);
+      x = gen_rtx_IF_THEN_ELSE (VOIDmode, operands[3], label, pc_rtx);
+      emit_jump_insn (gen_rtx_SET (pc_rtx, x));
+      emit_move_insn (operands[0], operands[1]);
+    }
+  else
+    {
+      x = gen_rtx_IF_THEN_ELSE (VOIDmode, operands[3], label, pc_rtx);
+      emit_move_insn (operands[0], operands[1]);
+      emit_jump_insn (gen_rtx_SET (pc_rtx, x));
+      emit_move_insn (operands[0], operands[2]);
+    }
+
+  emit_label (XEXP (label, 0));
+  DONE;
+})
+
+;; -------------------------------------------------------------------------
+;; Branch instructions
+;; -------------------------------------------------------------------------
+
+(define_expand "cbranchsi4"
+  [(set (pc)
+	(if_then_else
+	  (match_operator 0 "comparison_operator"
+	    [(match_operand:SI 1 "reg_or_0_operand" "")
+	     (match_operand:SI 2 "reg_or_s16_operand" "")])
+	  (label_ref (match_operand 3 "" ""))
+	  (pc)))]
+  ""
+{
+  or1k_expand_compare (operands);
+})
+
+(define_insn "*cbranch"
+  [(set (pc)
+	(if_then_else
+	  (match_operator 1 "equality_comparison_operator"
+	    [(reg:BI SR_F_REGNUM) (const_int 0)])
+	  (label_ref (match_operand 0 "" ""))
+	  (pc)))]
+  ""
+{
+  return (GET_CODE (operands[1]) == NE
+	  ? "l.bf\t%0%#"
+	  : "l.bnf\t%0%#");
+}
+  [(set_attr "type" "control")])
+
+;; -------------------------------------------------------------------------
+;; Jump instructions
+;; -------------------------------------------------------------------------
+
+(define_insn "jump"
+  [(set (pc) (label_ref (match_operand 0 "" "")))]
+  ""
+  "l.j\t%0%#"
+  [(set_attr "type" "control")])
+
+(define_insn "indirect_jump"
+  [(set (pc) (match_operand:SI 0 "register_operand" "r"))]
+  ""
+  "l.jr\t%0%#"
+  [(set_attr "type" "control")])
+
+;; -------------------------------------------------------------------------
+;; Prologue & Epilogue
+;; -------------------------------------------------------------------------
+
+(define_expand "prologue"
+  [(const_int 1)]
+  ""
+{
+  or1k_expand_prologue ();
+  DONE;
+})
+
+;; Expand epilogue as RTL
+(define_expand "epilogue"
+  [(return)]
+  ""
+{
+  or1k_expand_epilogue ();
+  emit_jump_insn (gen_simple_return ());
+  DONE;
+})
+
+(define_expand "sibcall_epilogue"
+  [(return)]
+  ""
+{
+  or1k_expand_epilogue ();
+  /* Placing a USE of LR here, rather than as a REG_USE on the
+     sibcall itself, means that LR is not unnecessarily live
+     within the function itself, which would force creation of
+     a stack frame.  */
+  emit_insn (gen_rtx_USE (VOIDmode, gen_rtx_REG (Pmode, LR_REGNUM)));
+  DONE;
+})
+
+(define_expand "simple_return"
+  [(parallel [(simple_return) (use (match_dup 0))])]
+  ""
+{
+  operands[0] = gen_rtx_REG (Pmode, LR_REGNUM);
+})
+
+(define_insn "*simple_return"
+  [(simple_return)
+   (use (match_operand:SI 0 "register_operand" "r"))]
+  ""
+  "l.jr\t%0%#"
+  [(set_attr "type" "control")])
+
+(define_expand "eh_return"
+  [(use (match_operand 0 "general_operand"))]
+  ""
+{
+  or1k_expand_eh_return (operands[0]);
+  DONE;
+})
+
+;; This is a placeholder, during RA, in order to create the PIC regiter.
+;; We do this so that we don't unconditionally mark the LR register as
+;; clobbered.  It is replaced during prologue generation with the proper
+;; set_got pattern below.  This works because the set_got_tmp insn is the
+;; first insn in the stream and that it isn't moved during RA.
+(define_insn "set_got_tmp"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(unspec_volatile:SI [(const_int 0)] UNSPECV_SET_GOT))]
+  ""
+{
+  gcc_unreachable ();
+})
+
+;; The insn to initialize the GOT.
+(define_insn "set_got"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(unspec:SI [(const_int 0)] UNSPEC_SET_GOT))
+   (clobber (reg:SI LR_REGNUM))]
+  ""
+{
+  return ("l.jal\t8\;"
+	  " l.movhi\t%0, gotpchi(_GLOBAL_OFFSET_TABLE_-4)\;"
+	  "l.ori\t%0, %0, gotpclo(_GLOBAL_OFFSET_TABLE_+0)\;"
+	  "l.add\t%0, %0, r9");
+}
+  [(set_attr "length" "16")
+   (set_attr "type" "multi")])
+
+;; Block memory operations from being scheduled across frame (de)allocation.
+(define_insn "frame_addsi3"
+  [(set (match_operand:SI 0 "register_operand" "=r,r")
+	  (plus:SI
+	   (match_operand:SI 1 "register_operand"   "%r,r")
+	   (match_operand:SI 2 "reg_or_s16_operand" " r,I")))
+   (clobber (mem:BLK (scratch)))]
+  "reload_completed"
+  "@
+  l.add\t%0, %1, %2
+  l.addi\t%0, %1, %2")
+
+;; -------------------------------------------------------------------------
+;; Atomic Operations
+;; -------------------------------------------------------------------------
+
+;; Note that MULT stands in for the non-existant NAND rtx_code.
+(define_code_iterator FETCHOP [plus minus ior xor and mult])
+
+(define_code_attr fetchop_name
+  [(plus "add")
+   (minus "sub")
+   (ior "or")
+   (xor "xor")
+   (and "and")
+   (mult "nand")])
+
+(define_code_attr fetchop_pred
+  [(plus "reg_or_s16_operand")
+   (minus "register_operand")
+   (ior "reg_or_u16_operand")
+   (xor "reg_or_s16_operand")
+   (and "reg_or_u16_operand")
+   (mult "reg_or_u16_operand")])
+
+(define_expand "mem_thread_fence"
+  [(match_operand:SI 0 "const_int_operand" "")]		;; model
+  ""
+{
+  memmodel model = memmodel_base (INTVAL (operands[0]));
+  if (model != MEMMODEL_RELAXED)
+    emit_insn (gen_msync ());
+  DONE;
+})
+
+(define_expand "msync"
+  [(set (match_dup 0) (unspec:BLK [(match_dup 0)] UNSPEC_MSYNC))]
+  ""
+{
+  operands[0] = gen_rtx_MEM (BLKmode, gen_rtx_SCRATCH (Pmode));
+  MEM_VOLATILE_P (operands[0]) = 1;
+})
+
+(define_insn "*msync"
+  [(set (match_operand:BLK 0 "" "")
+	(unspec:BLK [(match_dup 0)] UNSPEC_MSYNC))]
+  ""
+  "l.msync")
+
+(define_insn "load_locked_si"
+  [(set (match_operand:SI 0 "register_operand" "=r")
+	(unspec_volatile:SI
+	  [(match_operand:SI 1 "memory_operand" "m")] UNSPECV_LL))]
+  ""
+  "l.lwa\t%0,%1"
+  [(set_attr "type" "ld")])
+
+(define_insn "store_conditional_si"
+  [(set (reg:BI SR_F_REGNUM)
+	(unspec_volatile:BI [(const_int 0)] UNSPECV_SC))
+   (set (match_operand:SI 0 "memory_operand" "=m")
+	(match_operand:SI 1 "reg_or_0_operand" "rO"))]
+  ""
+  "l.swa\t%0,%r1"
+  [(set_attr "type" "st")])
+
+(define_expand "atomic_compare_and_swapsi"
+  [(match_operand:SI 0 "register_operand")   ;; bool output
+   (match_operand:SI 1 "register_operand")   ;; val output
+   (match_operand:SI 2 "memory_operand")     ;; memory
+   (match_operand:SI 3 "reg_or_s16_operand") ;; expected
+   (match_operand:SI 4 "reg_or_0_operand")   ;; desired
+   (match_operand:SI 5 "const_int_operand")  ;; is_weak
+   (match_operand:SI 6 "const_int_operand")  ;; mod_s
+   (match_operand:SI 7 "const_int_operand")] ;; mod_f
+  ""
+{
+  or1k_expand_atomic_compare_and_swap (operands);
+  DONE;
+})
+
+(define_expand "atomic_compare_and_swap<mode>"
+  [(match_operand:SI 0 "register_operand")   ;; bool output
+   (match_operand:I12 1 "register_operand")  ;; val output
+   (match_operand:I12 2 "memory_operand")    ;; memory
+   (match_operand:I12 3 "register_operand")  ;; expected
+   (match_operand:I12 4 "reg_or_0_operand")  ;; desired
+   (match_operand:SI 5 "const_int_operand")  ;; is_weak
+   (match_operand:SI 6 "const_int_operand")  ;; mod_s
+   (match_operand:SI 7 "const_int_operand")] ;; mod_f
+  ""
+{
+  or1k_expand_atomic_compare_and_swap_qihi (operands);
+  DONE;
+})
+
+(define_expand "atomic_exchangesi"
+  [(match_operand:SI 0 "register_operand")	;; output
+   (match_operand:SI 1 "memory_operand")	;; memory
+   (match_operand:SI 2 "reg_or_0_operand")	;; input
+   (match_operand:SI 3 "const_int_operand")]	;; model
+  ""
+{
+  or1k_expand_atomic_exchange (operands);
+  DONE;
+})
+
+(define_expand "atomic_exchange<mode>"
+  [(match_operand:I12 0 "register_operand")	;; output
+   (match_operand:I12 1 "memory_operand")	;; memory
+   (match_operand:I12 2 "reg_or_0_operand")	;; input
+   (match_operand:SI 3 "const_int_operand")]	;; model
+  ""
+{
+  or1k_expand_atomic_exchange_qihi (operands);
+  DONE;
+})
+
+(define_expand "atomic_<fetchop_name>si"
+  [(match_operand:SI 0 "memory_operand")	;; memory
+   (FETCHOP:SI (match_dup 0)
+     (match_operand:SI 1 "<fetchop_pred>"))	;; operand
+   (match_operand:SI 2 "const_int_operand")]	;; model
+  ""
+{
+  or1k_expand_atomic_op (<CODE>, operands[0], operands[1], NULL, NULL);
+  DONE;
+})
+
+(define_expand "atomic_<fetchop_name><mode>"
+  [(match_operand:I12 0 "memory_operand")	;; memory
+   (FETCHOP:I12 (match_dup 0)
+     (match_operand:I12 1 "register_operand"))	;; operand
+   (match_operand:SI 2 "const_int_operand")]	;; model
+  ""
+{
+  or1k_expand_atomic_op_qihi (<CODE>, operands[0], operands[1], NULL, NULL);
+  DONE;
+})
+
+(define_expand "atomic_fetch_<fetchop_name>si"
+  [(match_operand:SI 0 "register_operand" "")		;; output
+   (match_operand:SI 1 "memory_operand" "")		;; memory
+   (FETCHOP:SI (match_dup 1)
+     (match_operand:SI 2 "<fetchop_pred>" ""))		;; operand
+   (match_operand:SI 3 "const_int_operand" "")]		;; model
+  ""
+{
+  or1k_expand_atomic_op (<CODE>, operands[1], operands[2], operands[0], NULL);
+  DONE;
+})
+
+(define_expand "atomic_fetch_<fetchop_name><mode>"
+  [(match_operand:I12 0 "register_operand" "")		;; output
+   (match_operand:I12 1 "memory_operand" "")		;; memory
+   (FETCHOP:I12 (match_dup 1)
+     (match_operand:I12 2 "<fetchop_pred>" ""))		;; operand
+   (match_operand:SI 3 "const_int_operand" "")]		;; model
+  ""
+{
+  or1k_expand_atomic_op_qihi (<CODE>, operands[1], operands[2],
+			      operands[0], NULL);
+  DONE;
+})
+
+(define_expand "atomic_<fetchop_name>_fetchsi"
+  [(match_operand:SI 0 "register_operand" "")		;; output
+   (match_operand:SI 1 "memory_operand" "")		;; memory
+   (FETCHOP:SI (match_dup 1)
+     (match_operand:SI 2 "<fetchop_pred>" ""))		;; operand
+   (match_operand:SI 3 "const_int_operand" "")]		;; model
+  ""
+{
+  or1k_expand_atomic_op (<CODE>, operands[1], operands[2], NULL, operands[0]);
+  DONE;
+})
+
+(define_expand "atomic_<fetchop_name>_fetch<mode>"
+  [(match_operand:I12 0 "register_operand" "")		;; output
+   (match_operand:I12 1 "memory_operand" "")		;; memory
+   (FETCHOP:I12 (match_dup 1)
+     (match_operand:I12 2 "<fetchop_pred>" ""))	;; operand
+   (match_operand:SI 3 "const_int_operand" "")]		;; model
+  ""
+{
+  or1k_expand_atomic_op_qihi (<CODE>, operands[1], operands[2],
+			      NULL, operands[0]);
+  DONE;
+})
+
+;; -------------------------------------------------------------------------
+;; Call Instructions
+;; -------------------------------------------------------------------------
+
+;; Leave these to last, as the modeless operand for call_value
+;; interferes with normal patterns.
+
+(define_expand "call"
+  [(call (match_operand 0) (match_operand 1))]
+  ""
+{
+  or1k_expand_call (NULL, operands[0], operands[1], false);
+  DONE;
+})
+
+(define_expand "sibcall"
+  [(call (match_operand 0) (match_operand 1))]
+  ""
+{
+  or1k_expand_call (NULL, operands[0], operands[1], true);
+  DONE;
+})
+
+(define_expand "call_value"
+  [(set (match_operand 0) (call (match_operand 1) (match_operand 2)))]
+  ""
+{
+  or1k_expand_call (operands[0], operands[1], operands[2], false);
+  DONE;
+})
+
+(define_expand "sibcall_value"
+  [(set (match_operand 0) (call (match_operand 1) (match_operand 2)))]
+  ""
+{
+  or1k_expand_call (operands[0], operands[1], operands[2], true);
+  DONE;
+})
+
+(define_insn "*call"
+  [(call (mem:SI (match_operand:SI 0 "call_insn_operand" "r,s"))
+	 (match_operand 1))
+   (clobber (reg:SI LR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+  "@
+   l.jalr\t%0%#
+   l.jal\t%P0%#"
+  [(set_attr "type" "control")])
+
+(define_insn "*sibcall"
+  [(call (mem:SI (match_operand:SI 0 "call_insn_operand" "c,s"))
+	 (match_operand 1))]
+  "SIBLING_CALL_P (insn)"
+  "@
+   l.jr\t%0%#
+   l.j\t%P0%#"
+  [(set_attr "type" "control")])
+
+(define_insn "*call_value"
+  [(set (match_operand 0)
+	(call (mem:SI (match_operand:SI 1 "call_insn_operand" "r,s"))
+	      (match_operand 2)))
+   (clobber (reg:SI LR_REGNUM))]
+  "!SIBLING_CALL_P (insn)"
+  "@
+   l.jalr\t%1%#
+   l.jal\t%P1%#"
+  [(set_attr "type" "control")])
+
+(define_insn "*sibcall_value"
+  [(set (match_operand 0)
+	(call (mem:SI (match_operand:SI 1 "call_insn_operand" "c,s"))
+	      (match_operand 2)))]
+  "SIBLING_CALL_P (insn)"
+  "@
+   l.jr\t%1%#
+   l.j\t%P1%#"
+  [(set_attr "type" "control")])
diff --git a/gcc/config/or1k/or1k.opt b/gcc/config/or1k/or1k.opt
new file mode 100644
index 00000000000..3cc9422f756
--- /dev/null
+++ b/gcc/config/or1k/or1k.opt
@@ -0,0 +1,67 @@
+; OpenRISC command line options
+
+; Copyright (C) 2010-2018 Free Software Foundation, Inc.
+;
+; This file is part of GCC.
+;
+; GCC is free software; you can redistribute it and/or modify it under
+; the terms of the GNU General Public License as published by the Free
+; Software Foundation; either version 3, or (at your option) any later
+; version.
+;
+; GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+; WARRANTY; without even the implied warranty of MERCHANTABILITY or
+; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+; for more details.
+;
+; You should have received a copy of the GNU General Public License
+; along with GCC; see the file COPYING3.  If not see
+; <http://www.gnu.org/licenses/>.
+
+; See the GCC internals manual (options.texi) for a description of
+; this file's format.
+
+; Please try to keep this file in ASCII collating order.
+
+mhard-div
+Target RejectNegative InverseMask(SOFT_DIV)
+Use hardware divide instructions, use -msoft-div for emulation.
+
+mhard-mul
+Target RejectNegative InverseMask(SOFT_MUL).
+Use hardware multiply instructions, use -msoft-mul for emulation.
+
+mcmov
+Target RejectNegative Mask(CMOV)
+Allows generation of binaries which use the l.cmov instruction.  If your target
+does not support this the compiler will generate the equivalent using set and
+branch.
+
+mror
+Target RejectNegative Mask(ROR)
+Allows generation of binaries which use the l.rori instructions.
+
+msext
+Target RejectNegative Mask(SEXT)
+Allows generation of binaries which use sign-extension instructions.  If your
+target does not support this the compiler will use memory loads to perform sign
+extension.
+
+msfimm
+Target RejectNegative Mask(SFIMM)
+Allows generation of binaries which use l.sf*i instructions.  If your target
+does not support this the compiler will generate instructions to store the
+immediate to a register first.
+
+mshftimm
+Target RejectNegative Mask(SHFTIMM)
+Allows generation of binaries which support shifts and rotate instructions
+supporting immediate arguments, for example l.rori.
+
+msoft-div
+Target RejectNegative Mask(SOFT_DIV)
+Use divide emulation.
+
+msoft-mul
+Target RejectNegative Mask(SOFT_MUL).
+Use multiply emulation.
diff --git a/gcc/config/or1k/predicates.md b/gcc/config/or1k/predicates.md
new file mode 100644
index 00000000000..3f6b4a451b8
--- /dev/null
+++ b/gcc/config/or1k/predicates.md
@@ -0,0 +1,84 @@
+;; Predicate definitions for OpenRISC
+;; Copyright (C) 2018 Free Software Foundation, Inc.
+;; Contributed by Stafford Horne
+
+;; This file is part of GCC.
+
+;; GCC is free software; you can redistribute it and/or modify it
+;; under the terms of the GNU General Public License as published
+;; by the Free Software Foundation; either version 3, or (at your
+;; option) any later version.
+
+;; GCC is distributed in the hope that it will be useful, but WITHOUT
+;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+;; License for more details.
+
+;; You should have received a copy of the GNU General Public License
+;; along with GCC; see the file COPYING3.  If not see
+;; <http://www.gnu.org/licenses/>.
+
+;; -------------------------------------------------------------------------
+;; Predicates
+;; -------------------------------------------------------------------------
+
+(define_predicate "input_operand"
+  (ior (match_operand 0 "register_operand")
+       (match_operand 0 "memory_operand")
+       (and (match_code "const_int")
+	    (match_test "satisfies_constraint_I (op)
+			 || satisfies_constraint_K (op)
+			 || satisfies_constraint_M (op)"))))
+
+(define_predicate "const0_operand"
+  (and (match_code "const_int,const_wide_int,const_double,const_vector")
+       (match_test "op == CONST0_RTX (mode)")))
+
+(define_predicate "reg_or_0_operand"
+  (ior (match_operand 0 "register_operand")
+       (match_operand 0 "const0_operand")))
+
+(define_predicate "reg_or_u6_operand"
+  (if_then_else (match_code "const_int")
+    (match_test "INTVAL (op) >= 0 && INTVAL (op) <= 0x3f")
+    (match_operand 0 "register_operand")))
+
+(define_predicate "reg_or_u16_operand"
+  (if_then_else (match_code "const_int")
+    (match_test "INTVAL (op) >= 0 && INTVAL (op) <= 0xffff")
+    (match_operand 0 "register_operand")))
+
+(define_predicate "reg_or_s16_operand"
+  (if_then_else (match_code "const_int")
+    (match_test "INTVAL (op) >= -32768 && INTVAL (op) <= 32767")
+    (match_operand 0 "register_operand")))
+
+(define_predicate "call_insn_operand"
+  (ior (match_code "symbol_ref")
+       (match_operand 0 "register_operand")))
+
+(define_predicate "high_operand"
+  (match_code "symbol_ref,label_ref,const,unspec"))
+
+;; Return true for relocations that must use MOVHI+ADDI
+(define_predicate "losum_add_operand"
+  (match_code "symbol_ref,label_ref,const,unspec"))
+
+;; Return true for relocations that must use MOVHI+ORI
+(define_predicate "losum_ior_operand"
+  (and (match_code "unspec")
+       (match_test "XINT(op, 1) == UNSPEC_TLSGD")))
+
+;; Return true for a "virtual" or "soft" register that will be
+;; adjusted to a "soft" or "hard" register during elimination.
+(define_predicate "virtual_frame_reg_operand"
+  (match_code "reg")
+{
+  unsigned regno = REGNO (op);
+  return (regno != STACK_POINTER_REGNUM
+	  && regno != HARD_FRAME_POINTER_REGNUM
+	  && REGNO_PTR_FRAME_P (regno));
+})
+
+(define_predicate "equality_comparison_operator"
+  (match_code "ne,eq"))
diff --git a/gcc/config/or1k/rtems.h b/gcc/config/or1k/rtems.h
new file mode 100644
index 00000000000..0c3d39cc9c4
--- /dev/null
+++ b/gcc/config/or1k/rtems.h
@@ -0,0 +1,30 @@
+/* Target Newlib Definitions for OpenRISC.
+   Copyright (C) 2018 Free Software Foundation, Inc.
+   Contributed by Joel Sherrill (joel.sherrill@OARcorp.com).
+
+   This file is part of GCC.
+
+   GCC is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published
+   by the Free Software Foundation; either version 3, or (at your
+   option) any later version.
+
+   GCC is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+   License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with GCC; see the file COPYING3.  If not see
+   <http://www.gnu.org/licenses/>.  */
+
+/* Target OS builtins.  */
+#undef TARGET_OS_CPP_BUILTINS
+#define TARGET_OS_CPP_BUILTINS()		\
+  do						\
+    {						\
+	builtin_define ("__rtems__");		\
+	builtin_define ("__USE_INIT_FINI__");	\
+	builtin_assert ("system=rtems");	\
+    }						\
+  while (0)
diff --git a/gcc/config/or1k/t-or1k b/gcc/config/or1k/t-or1k
new file mode 100644
index 00000000000..6771c82da08
--- /dev/null
+++ b/gcc/config/or1k/t-or1k
@@ -0,0 +1,22 @@
+# Target Makefile Fragment for OpenRISC
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
+comma=,
+MULTILIB_OPTIONS = $(subst $(comma), ,$(TM_MULTILIB_CONFIG))
diff --git a/gcc/config/or1k/t-rtems b/gcc/config/or1k/t-rtems
new file mode 100644
index 00000000000..e4e5e1dca97
--- /dev/null
+++ b/gcc/config/or1k/t-rtems
@@ -0,0 +1,3 @@
+# RTEMS OR1K multilibs
+
+# No custom multilibs defined
diff --git a/gcc/configure b/gcc/configure
index a24221d580c..65e026b817b 100755
--- a/gcc/configure
+++ b/gcc/configure
@@ -24391,6 +24391,18 @@ foo:	.long	25
 	tls_first_minor=20
 	tls_as_opt='--fatal-warnings'
 	;;
+  or1k*-*-*)
+    conftest_s='
+        .section ".tdata","awT", at progbits
+foo:    .long   25
+        .text
+        l.movhi r3, tpoffha(foo)
+        l.add   r3, r3, r10
+        l.lwz   r4, tpofflo(foo)(r3)'
+    tls_first_major=2
+    tls_first_minor=30
+    tls_as_opt=--fatal-warnings
+    ;;
   powerpc-ibm-aix*)
     conftest_s='
 	.extern __get_tpointer
diff --git a/gcc/configure.ac b/gcc/configure.ac
index 59585912556..260d987dadd 100644
--- a/gcc/configure.ac
+++ b/gcc/configure.ac
@@ -3473,6 +3473,18 @@ foo:	.long	25
 	tls_first_minor=20
 	tls_as_opt='--fatal-warnings'
 	;;
+  or1k*-*-*)
+    conftest_s='
+	.section ".tdata","awT", at progbits
+foo:	.long	25
+	.text
+	l.movhi	r3, tpoffha(foo)
+	l.add	r3, r3, r10
+	l.lwz	r4, tpofflo(foo)(r3)'
+    tls_first_major=2
+    tls_first_minor=30
+    tls_as_opt=--fatal-warnings
+    ;;
   powerpc-ibm-aix*)
     conftest_s='
 	.extern __get_tpointer
diff --git a/gcc/doc/install.texi b/gcc/doc/install.texi
index 52548995d95..7ccab525622 100644
--- a/gcc/doc/install.texi
+++ b/gcc/doc/install.texi
@@ -3269,6 +3269,10 @@ information have to.
 @item
 @uref{#nvptx-x-none,,nvptx-*-none}
 @item
+ at uref{#or1k-x-elf,,or1k-*-elf}
+ at item
+ at uref{#or1k-x-linux,,or1k-*-linux}
+ at item
 @uref{#powerpc-x-x,,powerpc*-*-*}
 @item
 @uref{#powerpc-x-darwin,,powerpc-*-darwin*}
@@ -4236,6 +4240,21 @@ the GCC sources.
 Use the @option{--disable-sjlj-exceptions} and
 @option{--enable-newlib-io-long-long} options when configuring.
 
+ at html
+<hr />
+ at end html
+ at anchor{or1k-x-elf}
+ at heading or1k-*-elf
+The OpenRISC 1000 32-bit processor with delay slots.
+This configuration is intended for embedded systems.
+
+ at html
+<hr />
+ at end html
+ at anchor{or1k-x-linux}
+ at heading or1k-*-linux
+The OpenRISC 1000 32-bit processor with delay slots.
+
 @html
 <hr />
 @end html
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index a2df35b5ede..8a1473d4eb8 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -1005,6 +1005,11 @@ Objective-C and Objective-C++ Dialects}.
 @emph{Nvidia PTX Options}
 @gccoptlist{-m32  -m64  -mmainkernel  -moptimize}
 
+ at emph{OpenRISC Options}
+ at gccoptlist{-mboard=@var{name} -mnewlib -mhard-mul -mhard-div @gol
+-msoft-mul -msoft-div @gol
+-mcmov -mror -msext -msfimm -mshftimm}
+
 @emph{PDP-11 Options}
 @gccoptlist{-mfpu  -msoft-float  -mac0  -mno-ac0  -m40  -m45  -m10 @gol
 -mint32  -mno-int16 -mint16  -mno-int32 @gol
@@ -14944,6 +14949,7 @@ platform.
 * NDS32 Options::
 * Nios II Options::
 * Nvidia PTX Options::
+* OpenRISC Options::
 * PDP-11 Options::
 * picoChip Options::
 * PowerPC Options::
@@ -22703,6 +22709,68 @@ Generate code for use in OpenMP offloading: enables @option{-msoft-stack} and
 
 @end table
 
+ at node OpenRISC Options
+ at subsection OpenRISC Options
+ at cindex OpenRISC Options
+
+These options are defined for OpenRISC:
+
+ at table @gcctabopt
+
+ at item -mboard=@var{name}
+ at opindex mboard
+Configure a board specific runtime.  This will be passed to the linker for
+newlib board library linking.  The default is @code{or1ksim}.
+
+ at item -mnewlib
+ at opindex mnewlib
+For compatibility, it's always newlib for elf now.
+
+ at item -mhard-div
+ at opindex mhard-div
+Generate code for hardware which supports divide instructions.  This is the
+default.
+
+ at item -mhard-mul
+ at opindex mhard-mul
+Generate code for hardware which supports multiply instructions.  This is the
+default.
+
+ at item -mcmov
+ at opindex mcmov
+Generate code for hardware which supports the conditional move (@code{l.cmov})
+instruction.
+
+ at item -mror
+ at opindex mror
+Generate code for hardware which supports rotate right instructions.
+
+ at item -msext
+ at opindex msext
+Generate code for hardware which supports sign-extension instructions.
+
+ at item -msfimm
+ at opindex msfimm
+Generate code for hardware which supports set flag immediate (@code{l.sf*i})
+instructions.
+
+ at item -mshftimm
+ at opindex mshftimm
+Generate code for hardware which supports shift immediate related instructions
+(i.e. @code{l.srai}, @code{l.srli}, @code{l.slli}, @code{1.rori}).  Note, to
+enable generation of the @code{l.rori} instruction the @option{-mror} flag must
+also be specified.
+
+ at item -msoft-div
+ at opindex msoft-div
+Generate code for hardware which requires divide instruction emulation.
+
+ at item -msoft-mul
+ at opindex msoft-mul
+Generate code for hardware which requires multiply instruction emulation.
+
+ at end table
+
 @node PDP-11 Options
 @subsection PDP-11 Options
 @cindex PDP-11 Options
diff --git a/gcc/doc/md.texi b/gcc/doc/md.texi
index 360b36b862f..46806bbea37 100644
--- a/gcc/doc/md.texi
+++ b/gcc/doc/md.texi
@@ -3003,6 +3003,31 @@ representing a supported PIC or TLS relocation.
 
 @end table
 
+ at item OpenRISC--- at file{config/or1k/constraints.md}
+ at table @code
+ at item I
+Integer that is valid as an immediate operand in an
+instruction taking a signed 16-bit number. Range
+ at minus{}32768 to 32767.
+
+ at item K
+Integer that is valid as an immediate operand in an
+instruction taking an unsigned 16-bit number. Range
+0 to 65535.
+
+ at item M
+Signed 16-bit constant shifted left 16 bits. (Used with @code{l.movhi})
+
+ at item O
+Zero
+
+ at ifset INTERNALS
+ at item c
+Register usable for sibcalls.
+ at end ifset
+
+ at end table
+
 @item PDP-11--- at file{config/pdp11/constraints.md}
 @table @code
 @item a
-- 
2.17.2

