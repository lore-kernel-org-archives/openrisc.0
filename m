From: Stafford Horne <shorne@gmail.com>
Date: Thu, 11 Apr 2019 06:27:45 +0900
Subject: [OpenRISC] [PATCH 1/3] or1k: Initial support for FPU
In-Reply-To: <20190410212747.18377-1-shorne@gmail.com>
References: <20190410212747.18377-1-shorne@gmail.com>
Message-ID: <20190410212747.18377-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Or1k only supports ordered compares so we fall back to lib functions
for unordered operations.

Doubles work on this 32-bit architecture by using register pairing as
specified in: https://openrisc.io/proposals/orfpx64a32

Or1k does not support sf/df or df/sf conversions.

gcc/ChangeLog:

	* config.gcc (or1k*-*-*): Add mhard-float and mdouble-float validations.
	* config/or1k/or1k.md (type): Add fpu.
	(fpu): New instruction reservation.
	(F, f, fi, FI, FOP, fop): New.
	(<fop><F:mode>3): New ALU instruction definition.
	(float<fi><F:mode>2): New conversion instruction definition.
	(fix_trunc<F:mode><fi>2): New conversion instruction definition.
	(fpcmpcc): New code iterator.
	(*sf_fp_insn): New instruction definition.
	(cstore<F:mode>4): New expand definition.
	(cbranch<F:mode>4): New expand definition.
	* config/or1k/or1k.opt (msoft-float, mhard-float, mdouble-float): New
	options.
	* doc/invoke.texi: Document msoft-float, mhard-float and mdouble-float.
---
 gcc/config.gcc           |   1 +
 gcc/config/or1k/or1k.md  | 103 ++++++++++++++++++++++++++++++++++++++-
 gcc/config/or1k/or1k.opt |  15 +++++-
 gcc/doc/invoke.texi      |  15 ++++++
 4 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/gcc/config.gcc b/gcc/config.gcc
index ebbab5d8b6a..8017851922e 100644
--- a/gcc/config.gcc
+++ b/gcc/config.gcc
@@ -2541,6 +2541,7 @@ or1k*-*-*)
 	for or1k_multilib in ${or1k_multilibs}; do
 		case ${or1k_multilib} in
 		mcmov | msext | msfimm | \
+		mhard-float | mdouble-float | \
 		mhard-div | mhard-mul | \
 		msoft-div | msoft-mul )
 			TM_MULTILIB_CONFIG="${TM_MULTILIB_CONFIG},${or1k_multilib}"
diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index 2dad51cd46b..202493c5ab9 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -60,7 +60,7 @@
 (define_attr "length" "" (const_int 4))
 
 (define_attr "type"
-  "alu,st,ld,control,multi"
+  "alu,st,ld,control,multi,fpu"
   (const_string "alu"))
 
 (define_attr "insn_support" "class1,sext,sfimm,shftimm" (const_string "class1"))
@@ -93,6 +93,10 @@
 (define_insn_reservation "control" 1
   (eq_attr "type" "control")
   "cpu")
+(define_insn_reservation "fpu" 2
+  (eq_attr "type" "fpu")
+  "cpu")
+
 
 ; Define delay slots for any branch
 (define_delay (eq_attr "type" "control")
@@ -155,6 +159,46 @@
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
+(define_mode_attr fi [(SF "si") (DF "di")])
+(define_mode_attr FI [(SF "SI") (DF "DI")])
+
+;; Basic arithmetic instructions
+(define_code_iterator FOP [plus minus mult div])
+(define_code_attr fop [(plus "add") (minus "sub") (mult "mul") (div "div")])
+
+(define_insn "<fop><F:mode>3"
+  [(set (match_operand:F 0 "register_operand" "=r")
+	(FOP:F (match_operand:F 1 "register_operand" "r")
+	       (match_operand:F 2 "register_operand" "r")))]
+  "TARGET_HARD_FLOAT"
+  "lf.<fop>.<f>\t%0, %1, %2"
+  [(set_attr "type" "fpu")])
+
+;; Basic float<->int conversion
+(define_insn "float<fi><F:mode>2"
+  [(set (match_operand:F 0 "register_operand" "=r")
+	(float:F
+	    (match_operand:<FI> 1 "register_operand" "r")))]
+  "TARGET_HARD_FLOAT"
+  "lf.itof.<f>\t%0, %1"
+  [(set_attr "type" "fpu")])
+
+(define_insn "fix_trunc<F:mode><fi>2"
+  [(set (match_operand:<FI> 0 "register_operand" "=r")
+	(fix:<FI>
+	    (match_operand:F 1 "register_operand" "r")))]
+  "TARGET_HARD_FLOAT"
+  "lf.ftoi.<f>\t%0, %1"
+  [(set_attr "type" "fpu")])
+
 ;; -------------------------------------------------------------------------
 ;; Logical operators
 ;; -------------------------------------------------------------------------
@@ -388,6 +432,31 @@
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
+(define_code_iterator fpcmpcc [ne eq lt gt ge le])
+
+(define_insn "*sf_fp_insn"
+  [(set (reg:BI SR_F_REGNUM)
+	(fpcmpcc:BI (match_operand:F 0 "register_operand" "r")
+		    (match_operand:F 1 "register_operand" "r")))]
+  "TARGET_HARD_FLOAT"
+  "lf.sf<code>.<f>\t%0, %1"
+  [(set_attr "type" "fpu")])
+
+
 ;; -------------------------------------------------------------------------
 ;; Conditional Store instructions
 ;; -------------------------------------------------------------------------
@@ -408,6 +477,23 @@
   DONE;
 })
 
+;; Support FP cstores too
+(define_expand "cstore<F:mode>4"
+  [(set (match_operand:SI 0 "register_operand" "")
+	(if_then_else:F
+	  (match_operator 1 "ordered_comparison_operator"
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
@@ -501,6 +587,21 @@
   or1k_expand_compare (operands);
 })
 
+;; Support FP branching
+
+(define_expand "cbranch<F:mode>4"
+  [(set (pc)
+	(if_then_else
+	  (match_operator 0 "ordered_comparison_operator"
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
index 7bdbd842dd4..9a7e1c8bae7 100644
--- a/gcc/config/or1k/or1k.opt
+++ b/gcc/config/or1k/or1k.opt
@@ -21,8 +21,6 @@
 ; See the GCC internals manual (options.texi) for a description of
 ; this file's format.
 
-; Please try to keep this file in ASCII collating order.
-
 mhard-div
 Target RejectNegative InverseMask(SOFT_DIV)
 Use hardware divide instructions, use -msoft-div for emulation.
@@ -31,6 +29,19 @@ mhard-mul
 Target RejectNegative InverseMask(SOFT_MUL).
 Use hardware multiply instructions, use -msoft-mul for emulation.
 
+msoft-float
+Target RejectNegative InverseMask(HARD_FLOAT)
+Use gcc provided software routines for floating point operations.
+
+mhard-float
+Target RejectNegative Mask(HARD_FLOAT)
+Use hardware floating point instructions.
+
+mdouble-float
+Target Mask(DOUBLE_FLOAT)
+Allows generation of binaries which support 64-bit doubles on 32-bit systems by
+storing doubles in register pairs.
+
 mcmov
 Target RejectNegative Mask(CMOV)
 Allows generation of binaries which use the l.cmov instruction.  If your target
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index cfc3063929b..5b474be265a 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -1028,6 +1028,7 @@ Objective-C and Objective-C++ Dialects}.
 @emph{OpenRISC Options}
 @gccoptlist{-mboard=@var{name}  -mnewlib  -mhard-mul  -mhard-div @gol
 -msoft-mul  -msoft-div @gol
+-msoft-float  -mhard-float  -mdouble-float @gol
 -mcmov  -mror  -msext  -msfimm  -mshftimm}
 
 @emph{PDP-11 Options}
@@ -23551,6 +23552,20 @@ default.
 Generate code for hardware which supports multiply instructions.  This is the
 default.
 
+ at item -msoft-float
+ at opindex msoft-float
+Generate code which uses library calls for floating point operations.  This is
+the default.
+
+ at item -mhard-float
+ at opindex mhard-float
+Generate code for hardware which supports floating point instructions.
+
+ at item -mdouble-float
+ at opindex mdouble-float
+Generate code for hardware which supports 64-bit floating point operations
+on 32-bit OpenRISC targets.
+
 @item -mcmov
 @opindex mcmov
 Generate code for hardware which supports the conditional move (@code{l.cmov})
-- 
2.19.1

