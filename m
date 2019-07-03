From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Jul 2019 12:33:50 +0900
Subject: [OpenRISC] [PATCH v2 4/5] or1k: Initial support for FPU
In-Reply-To: <20190703033351.11924-1-shorne@gmail.com>
References: <20190703033351.11924-1-shorne@gmail.com>
Message-ID: <20190703033351.11924-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This adds support for OpenRISC hardware floating point instructions.
This is enabled with the -mhard-float option.

Double-prevision floating point operations work using register pairing as
specified in: https://openrisc.io/proposals/orfpx64a32.  This has just been
added in the OpenRISC architecture specification 1.3.
This is enabled with the -mdouble-float option.

Not all architectures support unordered comparisons so an option,
-munordered-float is added.

Currently OpenRISC does not support sf/df or df/sf conversions, but this has
also just been added in architecture specification 1.3.

gcc/ChangeLog:

	* config.gcc (or1k*-*-*): Add mhard-float, mdouble-float, msoft-float
	and munordered-float validations.
	* config/or1k/constraints.md (d): New register constraint.
	* config/or1k/predicates.md (fp_comparison_operator): New.
	* config/or1k/or1k.c (or1k_print_operand): Add support for printing 'd'
	operands.
	(or1k_expand_compare): Normalize unordered comparisons.
	* config/or1k/or1k.h (reg_class): Define DOUBLE_REGS.
	(REG_CLASS_NAMES): Add "DOUBLE_REGS".
	(REG_CLASS_CONTENTS): Add contents for DOUBLE_REGS.
	* config/or1k/or1k.md (type): Add fpu.
	(fpu): New instruction reservation.
	(F, f, fr, fi, FI, FOP, fop): New.
	(<fop><F:mode>3): New ALU instruction definition.
	(float<fi><F:mode>2): New conversion instruction definition.
	(fix_trunc<F:mode><fi>2): New conversion instruction definition.
	(fpcmpcc): New code iterator.
	(*sf_fp_insn): New instruction definition.
	(cstore<F:mode>4): New expand definition.
	(cbranch<F:mode>4): New expand definition.
	* config/or1k/or1k.opt (msoft-float, mhard-float, mdouble-float,
	munordered-float): New options.
	* doc/invoke.texi: Document msoft-float, mhard-float, mdouble-float and
	munordered-float.
---
Changes since v1:
 - User register pairs for 64-bit ops. See or1k_print_operand 

 gcc/config.gcc                 |   1 +
 gcc/config/or1k/constraints.md |   4 ++
 gcc/config/or1k/or1k.c         |  36 ++++++++++-
 gcc/config/or1k/or1k.h         |   3 +
 gcc/config/or1k/or1k.md        | 111 ++++++++++++++++++++++++++++++++-
 gcc/config/or1k/or1k.opt       |  22 +++++++
 gcc/config/or1k/predicates.md  |   5 ++
 gcc/doc/invoke.texi            |  21 +++++++
 8 files changed, 199 insertions(+), 4 deletions(-)

diff --git a/gcc/config.gcc b/gcc/config.gcc
index aeab8b4544e..1678109131f 100644
--- a/gcc/config.gcc
+++ b/gcc/config.gcc
@@ -2579,6 +2579,7 @@ or1k*-*-*)
 		case ${or1k_multilib} in
 		mcmov | msext | msfimm | \
 		mror | mrori | \
+		mhard-float | mdouble-float | munordered-float | msoft-float | \
 		mhard-div | mhard-mul | \
 		msoft-div | msoft-mul )
 			TM_MULTILIB_CONFIG="${TM_MULTILIB_CONFIG},${or1k_multilib}"
diff --git a/gcc/config/or1k/constraints.md b/gcc/config/or1k/constraints.md
index 93da8c058c6..8cac7eb5329 100644
--- a/gcc/config/or1k/constraints.md
+++ b/gcc/config/or1k/constraints.md
@@ -24,6 +24,7 @@
 
 ; We use:
 ;  c - sibcall registers
+;  d - double pair base registers (excludes r0, r30 and r31 which overflow)
 ;  I - constant signed 16-bit
 ;  K - constant unsigned 16-bit
 ;  M - constant signed 16-bit shifted left 16-bits (l.movhi)
@@ -32,6 +33,9 @@
 (define_register_constraint "c" "SIBCALL_REGS"
   "Registers which can hold a sibling call address")
 
+(define_register_constraint "d" "DOUBLE_REGS"
+  "Registers which can be used for double reg pairs.")
+
 ;; Immediates
 (define_constraint "I"
   "A signed 16-bit immediate in the range -32768 to 32767."
diff --git a/gcc/config/or1k/or1k.c b/gcc/config/or1k/or1k.c
index 54c9e804ea5..d90826b75ca 100644
--- a/gcc/config/or1k/or1k.c
+++ b/gcc/config/or1k/or1k.c
@@ -1226,6 +1226,17 @@ or1k_print_operand (FILE *file, rtx x, int code)
 	output_operand_lossage ("invalid %%H value");
       break;
 
+    case 'd':
+      if (REG_P (x))
+	  if (GET_MODE (x) == DFmode || GET_MODE (x) == DImode)
+	    fprintf (file, "%s,%s", reg_names[REGNO (operand)],
+				    reg_names[REGNO (operand) + 1]);
+	  else
+	    fprintf (file, "%s", reg_names[REGNO (operand)]);
+      else
+	output_operand_lossage ("invalid %%d value");
+      break;
+
     case 'h':
       print_reloc (file, x, 0, RKIND_HI);
       break;
@@ -1435,21 +1446,42 @@ void
 or1k_expand_compare (rtx *operands)
 {
   rtx sr_f = gen_rtx_REG (BImode, SR_F_REGNUM);
+  rtx_code cmp_code = GET_CODE (operands[0]);
+  bool flag_check_ne = true;
 
   /* The RTL may receive an immediate in argument 1 of the compare, this is not
      supported unless we have l.sf*i instructions, force them into registers.  */
   if (!TARGET_SFIMM)
     XEXP (operands[0], 1) = force_reg (SImode, XEXP (operands[0], 1));
 
+  /* Normalize comparison operators to ones OpenRISC support.  */
+  switch (cmp_code)
+    {
+      case LTGT:
+	cmp_code = UNEQ;
+	flag_check_ne = false;
+	break;
+
+      case ORDERED:
+	cmp_code = UNORDERED;
+	flag_check_ne = false;
+	break;
+
+      default:
+	break;
+    }
+
   /* Emit the given comparison into the Flag bit.  */
   PUT_MODE (operands[0], BImode);
+  PUT_CODE (operands[0], cmp_code);
   emit_insn (gen_rtx_SET (sr_f, operands[0]));
 
   /* Adjust the operands for use in the caller.  */
-  operands[0] = gen_rtx_NE (VOIDmode, sr_f, const0_rtx);
+  operands[0] = flag_check_ne ? gen_rtx_NE (VOIDmode, sr_f, const0_rtx)
+			      : gen_rtx_EQ (VOIDmode, sr_f, const0_rtx);
   operands[1] = sr_f;
   operands[2] = const0_rtx;
-}
+ }
 
 /* Expand the patterns "call", "sibcall", "call_value" and "sibcall_value".
    Expands a function call where argument RETVAL is an optional RTX providing
diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
index 6dda230f217..7588c187e5f 100644
--- a/gcc/config/or1k/or1k.h
+++ b/gcc/config/or1k/or1k.h
@@ -189,6 +189,7 @@ enum reg_class
 {
   NO_REGS,
   SIBCALL_REGS,
+  DOUBLE_REGS,
   GENERAL_REGS,
   FLAG_REGS,
   ALL_REGS,
@@ -200,6 +201,7 @@ enum reg_class
 #define REG_CLASS_NAMES {	\
   "NO_REGS", 			\
   "SIBCALL_REGS",		\
+  "DOUBLE_REGS",		\
   "GENERAL_REGS",		\
   "FLAG_REGS",			\
   "ALL_REGS" }
@@ -212,6 +214,7 @@ enum reg_class
 #define REG_CLASS_CONTENTS      \
 { { 0x00000000, 0x00000000 },	\
   { SIBCALL_REGS_MASK,   0 },	\
+  { 0x7ffffefe, 0x00000000 },	\
   { 0xffffffff, 0x00000003 },	\
   { 0x00000000, 0x00000004 },	\
   { 0xffffffff, 0x00000007 }	\
diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index bbad593db40..728ef96b99c 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -60,7 +60,7 @@
 (define_attr "length" "" (const_int 4))
 
 (define_attr "type"
-  "alu,st,ld,control,multi"
+  "alu,st,ld,control,multi,fpu"
   (const_string "alu"))
 
 (define_attr "insn_support" "class1,sext,sfimm,shftimm,ror,rori" (const_string "class1"))
@@ -97,6 +97,10 @@
 (define_insn_reservation "control" 1
   (eq_attr "type" "control")
   "cpu")
+(define_insn_reservation "fpu" 2
+  (eq_attr "type" "fpu")
+  "cpu")
+
 
 ; Define delay slots for any branch
 (define_delay (eq_attr "type" "control")
@@ -159,6 +163,47 @@
   ""
   "l.sub\t%0, %r1, %2")
 
+;; -------------------------------------------------------------------------
+;; Floating Point Arithmetic instructions
+;; -------------------------------------------------------------------------
+
+;; Mode iterator for single/double float
+(define_mode_iterator F [(SF "TARGET_HARD_FLOAT")
+			 (DF "TARGET_DOUBLE_FLOAT")])
+(define_mode_attr f [(SF "s") (DF "d")])
+(define_mode_attr fr [(SF "r") (DF "d")])
+(define_mode_attr fi [(SF "si") (DF "di")])
+(define_mode_attr FI [(SF "SI") (DF "DI")])
+
+;; Basic arithmetic instructions
+(define_code_iterator FOP [plus minus mult div])
+(define_code_attr fop [(plus "add") (minus "sub") (mult "mul") (div "div")])
+
+(define_insn "<fop><F:mode>3"
+  [(set (match_operand:F 0 "register_operand" "=<fr>")
+	(FOP:F (match_operand:F 1 "register_operand" "<fr>")
+	       (match_operand:F 2 "register_operand" "<fr>")))]
+  "TARGET_HARD_FLOAT"
+  "lf.<fop>.<f>\t%d0, %d1, %d2"
+  [(set_attr "type" "fpu")])
+
+;; Basic float<->int conversion
+(define_insn "float<fi><F:mode>2"
+  [(set (match_operand:F 0 "register_operand" "=<fr>")
+	(float:F
+	    (match_operand:<FI> 1 "register_operand" "<fr>")))]
+  "TARGET_HARD_FLOAT"
+  "lf.itof.<f>\t%d0, %d1"
+  [(set_attr "type" "fpu")])
+
+(define_insn "fix_trunc<F:mode><fi>2"
+  [(set (match_operand:<FI> 0 "register_operand" "=<fr>")
+	(fix:<FI>
+	    (match_operand:F 1 "register_operand" "<fr>")))]
+  "TARGET_HARD_FLOAT"
+  "lf.ftoi.<f>\t%d0, %d1"
+  [(set_attr "type" "fpu")])
+
 ;; -------------------------------------------------------------------------
 ;; Logical operators
 ;; -------------------------------------------------------------------------
@@ -380,7 +425,7 @@
 (define_code_iterator intcmpcc [ne eq lt ltu gt gtu ge le geu leu])
 (define_code_attr insn [(ne "ne") (eq "eq") (lt "lts") (ltu "ltu")
 			(gt "gts") (gtu "gtu") (ge "ges") (le "les")
-			(geu "geu") (leu "leu") ])
+			(geu "geu") (leu "leu")])
 
 (define_insn "*sf_insn"
   [(set (reg:BI SR_F_REGNUM)
@@ -392,6 +437,36 @@
    l.sf<insn>i\t%r0, %1"
   [(set_attr "insn_support" "*,sfimm")])
 
+;; Support FP comparisons too
+
+;; The OpenRISC FPU supports these comparisons:
+;;
+;;    lf.sfeq.{d,s} - equality, r r, double or single precision
+;;    lf.sfge.{d,s} - greater than or equal, r r, double or single precision
+;;    lf.sfgt.{d,s} - greater than, r r, double or single precision
+;;    lf.sfle.{d,s} - less than or equal, r r, double or single precision
+;;    lf.sflt.{d,s} - less than, r r, double or single precision
+;;    lf.sfne.{d,s} - not equal, r r, double or single precision
+;;
+;; Double precision is only supported on some hardware.  Only register/register
+;; comparisons are supported.  All comparisons are signed.
+
+(define_code_iterator fpcmpcc [ne eq lt gt ge le uneq unle unlt ungt unge
+			       unordered])
+(define_code_attr fpcmpinsn [(ne "ne") (eq "eq") (lt "lt") (gt "gt") (ge "ge")
+			     (le "le") (uneq "ueq") (unle "ule") (unlt "ult")
+			     (ungt "ugt") (unge "uge") (unordered "un")])
+
+
+(define_insn "*sf_fp_insn"
+  [(set (reg:BI SR_F_REGNUM)
+	(fpcmpcc:BI (match_operand:F 0 "register_operand" "<fr>")
+		    (match_operand:F 1 "register_operand" "<fr>")))]
+  "TARGET_HARD_FLOAT"
+  "lf.sf<fpcmpinsn>.<f>\t%d0, %d1"
+  [(set_attr "type" "fpu")])
+
+
 ;; -------------------------------------------------------------------------
 ;; Conditional Store instructions
 ;; -------------------------------------------------------------------------
@@ -412,6 +487,23 @@
   DONE;
 })
 
+;; Support FP cstores too
+(define_expand "cstore<F:mode>4"
+  [(set (match_operand:SI 0 "register_operand" "")
+	(if_then_else:F
+	  (match_operator 1 "fp_comparison_operator"
+	    [(match_operand:F 2 "register_operand" "")
+	     (match_operand:F 3 "register_operand" "")])
+	  (match_dup 0)
+	  (const_int 0)))]
+  "TARGET_HARD_FLOAT"
+{
+  or1k_expand_compare (operands + 1);
+  PUT_MODE (operands[1], SImode);
+  emit_insn (gen_rtx_SET (operands[0], operands[1]));
+  DONE;
+})
+
 ;; Being able to "copy" SR_F to a general register is helpful for
 ;; the atomic insns, wherein the usual usage is to test the success
 ;; of the compare-and-swap.  Representing the operation in this way,
@@ -505,6 +597,21 @@
   or1k_expand_compare (operands);
 })
 
+;; Support FP branching
+
+(define_expand "cbranch<F:mode>4"
+  [(set (pc)
+	(if_then_else
+	  (match_operator 0 "fp_comparison_operator"
+	    [(match_operand:F 1 "register_operand" "")
+	     (match_operand:F 2 "register_operand" "")])
+	  (label_ref (match_operand 3 "" ""))
+	  (pc)))]
+  "TARGET_HARD_FLOAT"
+{
+  or1k_expand_compare (operands);
+})
+
 (define_insn "*cbranch"
   [(set (pc)
 	(if_then_else
diff --git a/gcc/config/or1k/or1k.opt b/gcc/config/or1k/or1k.opt
index c2f64c5dd45..15085fafa3f 100644
--- a/gcc/config/or1k/or1k.opt
+++ b/gcc/config/or1k/or1k.opt
@@ -41,6 +41,28 @@ Target RejectNegative Mask(SOFT_MUL).
 Enable generation of binaries which use functions from libgcc to perform
 multiply operations. The default is -mhard-mul.
 
+msoft-float
+Target RejectNegative InverseMask(HARD_FLOAT)
+Enable generation of binaries which use functions from libgcc to perform
+floating point operations.  This is the default; use -mhard-float to override.
+
+mhard-float
+Target RejectNegative Mask(HARD_FLOAT)
+Enable generation of hardware floating point instructions. The default is
+-msoft-float.
+
+mdouble-float
+Target Mask(DOUBLE_FLOAT)
+When -mhard-float is selected, enables generation of double-precision floating
+point instructions.  By default functions from libgcc are used to perform
+double-precision floating point operations.
+
+munordered-float
+Target RejectNegative Mask(FP_UNORDERED)
+When -mhard-float is selected, enables generation of unordered floating point
+compare and set flag (lf.sfun*) instructions.  By default functions from libgcc
+are used to perform unordered floating point compare and set flag operations.
+
 mcmov
 Target RejectNegative Mask(CMOV)
 Enable generation of conditional move (l.cmov) instructions.  By default the
diff --git a/gcc/config/or1k/predicates.md b/gcc/config/or1k/predicates.md
index b895f1b4228..a1231dbad33 100644
--- a/gcc/config/or1k/predicates.md
+++ b/gcc/config/or1k/predicates.md
@@ -83,6 +83,11 @@
 (define_predicate "equality_comparison_operator"
   (match_code "ne,eq"))
 
+(define_predicate "fp_comparison_operator"
+  (if_then_else (match_test "TARGET_FP_UNORDERED")
+    (match_operand 0 "comparison_operator")
+    (match_operand 0 "ordered_comparison_operator")))
+
 ;; Borrowed from rs6000
 ;  Return true if the operand is in volatile memory.  Note that during the
 ;; RTL generation phase, memory_operand does not return TRUE for volatile
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 1f1f73672bd..379e4a9b731 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -1033,6 +1033,7 @@ Objective-C and Objective-C++ Dialects}.
 @emph{OpenRISC Options}
 @gccoptlist{-mboard=@var{name}  -mnewlib  -mhard-mul  -mhard-div @gol
 -msoft-mul  -msoft-div @gol
+-msoft-float  -mhard-float  -mdouble-float -munordered-float @gol
 -mcmov  -mror  -mrori  -msext  -msfimm  -mshftimm}
 
 @emph{PDP-11 Options}
@@ -23649,6 +23650,26 @@ This default is hardware divide.
 Select software or hardware multiply (@code{l.mul}, @code{l.muli}) instructions.
 This default is hardware multiply.
 
+ at item -msoft-float
+ at itemx -mhard-float
+ at opindex msoft-float
+ at opindex mhard-float
+Select software or hardware for floating point operations.
+The default is software.
+
+ at item -mdouble-float
+ at opindex mdouble-float
+When @option{-mhard-float} is selected, enables generation of double-precision
+floating point instructions.  By default functions from @file{libgcc} are used
+to perform double-precision floating point operations.
+
+ at item -munordered-float
+ at opindex munordered-float
+When @option{-mhard-float} is selected, enables generation of unordered
+floating point compare and set flag (@code{lf.sfun*}) instructions.  By default
+functions from @file{libgcc} are used to perform unordered floating point
+compare and set flag operations.
+
 @item -mcmov
 @opindex mcmov
 Enable generation of conditional move (@code{l.cmov}) instructions.  By
-- 
2.21.0

