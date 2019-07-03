From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Jul 2019 12:33:49 +0900
Subject: [OpenRISC] [PATCH v2 3/5] or1k: Add mrori option, fix option docs
In-Reply-To: <20190703033351.11924-1-shorne@gmail.com>
References: <20190703033351.11924-1-shorne@gmail.com>
Message-ID: <20190703033351.11924-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

gcc/ChangeLog:

	* config.gcc (or1k*-*-*): Add mrori and mror to validation.
	* doc/invoke.texi (OpenRISC Options): Add mrori option, rewrite all
	documenation to be more clear.
	* config/or1k/elf.opt (mboard=, mnewlib): Rewrite documentation to be
	more clear.
	* config/or1k/or1k.opt (mrori): New option.
	(mhard-div, msoft-div, mhard-mul, msoft-mul, mcmov, mror, msext,
	msfimm, mshftimm): Rewrite documentation to be more clear.
	* config/or1k/or1k.md (insn_support): Add ror and rori.
	(enabled): Add conditions for ror and rori.
	(rotrsi3): Replace condition for shftimm with ror and rori.

gcc/testsuite/ChangeLog:

	* gcc.target/or1k/ror-4.c: New file.
	* gcc.target/or1k/shftimm-1.c: Update test from rotate to shift
	as the shftimm option no longer controls rotate.
---
Changes since v1:
 - new patch

 gcc/config.gcc                            |  1 +
 gcc/config/or1k/elf.opt                   |  6 +--
 gcc/config/or1k/or1k.md                   | 12 +++--
 gcc/config/or1k/or1k.opt                  | 56 +++++++++++++----------
 gcc/doc/invoke.texi                       | 56 +++++++++++++----------
 gcc/testsuite/gcc.target/or1k/ror-4.c     |  8 ++++
 gcc/testsuite/gcc.target/or1k/shftimm-1.c |  8 ++--
 7 files changed, 87 insertions(+), 60 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-4.c

diff --git a/gcc/config.gcc b/gcc/config.gcc
index c281c418b28..aeab8b4544e 100644
--- a/gcc/config.gcc
+++ b/gcc/config.gcc
@@ -2578,6 +2578,7 @@ or1k*-*-*)
 	for or1k_multilib in ${or1k_multilibs}; do
 		case ${or1k_multilib} in
 		mcmov | msext | msfimm | \
+		mror | mrori | \
 		mhard-div | mhard-mul | \
 		msoft-div | msoft-mul )
 			TM_MULTILIB_CONFIG="${TM_MULTILIB_CONFIG},${or1k_multilib}"
diff --git a/gcc/config/or1k/elf.opt b/gcc/config/or1k/elf.opt
index 641b6ddd4be..2d4d1875d02 100644
--- a/gcc/config/or1k/elf.opt
+++ b/gcc/config/or1k/elf.opt
@@ -25,9 +25,9 @@
 
 mboard=
 Target RejectNegative Joined
-Configure board specific runtime.
+Configure the newlib board specific runtime.  The default is or1ksim.
 
 mnewlib
 Target RejectNegative
-For compatibility, it's always newlib for elf now.
-
+This option is ignored; it is provided for compatibility purposes only.  This
+used to select linker and preprocessor options for use with newlib.
diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index 757d899c442..bbad593db40 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -63,7 +63,7 @@
   "alu,st,ld,control,multi"
   (const_string "alu"))
 
-(define_attr "insn_support" "class1,sext,sfimm,shftimm" (const_string "class1"))
+(define_attr "insn_support" "class1,sext,sfimm,shftimm,ror,rori" (const_string "class1"))
 
 (define_attr "enabled" ""
   (cond [(eq_attr "insn_support" "class1") (const_int 1)
@@ -72,7 +72,11 @@
 	 (and (eq_attr "insn_support" "sfimm")
 	      (ne (symbol_ref "TARGET_SFIMM") (const_int 0))) (const_int 1)
 	 (and (eq_attr "insn_support" "shftimm")
-	      (ne (symbol_ref "TARGET_SHFTIMM") (const_int 0))) (const_int 1)]
+	      (ne (symbol_ref "TARGET_SHFTIMM") (const_int 0))) (const_int 1)
+	 (and (eq_attr "insn_support" "ror")
+	      (ne (symbol_ref "TARGET_ROR") (const_int 0))) (const_int 1)
+	 (and (eq_attr "insn_support" "rori")
+	      (ne (symbol_ref "TARGET_RORI") (const_int 0))) (const_int 1)]
 	(const_int 0)))
 
 ;; Describe a user's asm statement.
@@ -179,11 +183,11 @@
   [(set (match_operand:SI 0 "register_operand" "=r,r")
 	(rotatert:SI (match_operand:SI 1 "register_operand"  "r,r")
 		  (match_operand:SI 2 "reg_or_u6_operand" "r,n")))]
-  "TARGET_ROR"
+  "TARGET_ROR || TARGET_RORI"
   "@
    l.ror\t%0, %1, %2
    l.rori\t%0, %1, %2"
-  [(set_attr "insn_support" "*,shftimm")])
+  [(set_attr "insn_support" "ror,rori")])
 
 (define_insn "andsi3"
   [(set (match_operand:SI 0 "register_operand" "=r,r")
diff --git a/gcc/config/or1k/or1k.opt b/gcc/config/or1k/or1k.opt
index 7bdbd842dd4..c2f64c5dd45 100644
--- a/gcc/config/or1k/or1k.opt
+++ b/gcc/config/or1k/or1k.opt
@@ -21,47 +21,55 @@
 ; See the GCC internals manual (options.texi) for a description of
 ; this file's format.
 
-; Please try to keep this file in ASCII collating order.
-
 mhard-div
 Target RejectNegative InverseMask(SOFT_DIV)
-Use hardware divide instructions, use -msoft-div for emulation.
+Enable generation of hardware divide (l.div, l.divu) instructions.  This is the
+default; use -msoft-div to override.
+
+msoft-div
+Target RejectNegative Mask(SOFT_DIV)
+Enable generation of binaries which use functions from libgcc to perform divide
+operations.  The default is -mhard-div.
 
 mhard-mul
 Target RejectNegative InverseMask(SOFT_MUL).
-Use hardware multiply instructions, use -msoft-mul for emulation.
+Enable generation of hardware multiply instructions (l.mul, l.muli) instructions.
+This is the default; use -msoft-mul to override.
+
+msoft-mul
+Target RejectNegative Mask(SOFT_MUL).
+Enable generation of binaries which use functions from libgcc to perform
+multiply operations. The default is -mhard-mul.
 
 mcmov
 Target RejectNegative Mask(CMOV)
-Allows generation of binaries which use the l.cmov instruction.  If your target
-does not support this the compiler will generate the equivalent using set and
-branch.
+Enable generation of conditional move (l.cmov) instructions.  By default the
+equivalent will be generated using using set and branch.
 
 mror
 Target RejectNegative Mask(ROR)
-Allows generation of binaries which use the l.rori instructions.
+Enable generation of rotate right (l.ror) instructions.  By default functions
+from libgcc are used to perform rotate right operations.
+
+mrori
+Target RejectNegative Mask(RORI)
+Enable generation of rotate right with immediate (l.rori) instructions.  By
+default functions from libgcc are used to perform rotate right with immediate
+operations.
 
 msext
 Target RejectNegative Mask(SEXT)
-Allows generation of binaries which use sign-extension instructions.  If your
-target does not support this the compiler will use memory loads to perform sign
-extension.
+Enable generation of sign extension (l.ext*) instructions.  By default memory
+loads are used to perform sign extension.
 
 msfimm
 Target RejectNegative Mask(SFIMM)
-Allows generation of binaries which use l.sf*i instructions.  If your target
-does not support this the compiler will generate instructions to store the
-immediate to a register first.
+Enable generation of compare and set flag with immediate (l.sf*i) instructions.
+By default extra instructions will be generated to store the immediate to a
+register first.
 
 mshftimm
 Target RejectNegative Mask(SHFTIMM)
-Allows generation of binaries which support shifts and rotate instructions
-supporting immediate arguments, for example l.rori.
-
-msoft-div
-Target RejectNegative Mask(SOFT_DIV)
-Use divide emulation.
-
-msoft-mul
-Target RejectNegative Mask(SOFT_MUL).
-Use multiply emulation.
+Enable generation of shift with immediate (l.srai, l.srli, l.slli) instructions.
+By default extra instructions will be generated to store the immediate to a
+register first.
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 6382a840281..1f1f73672bd 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -1033,7 +1033,7 @@ Objective-C and Objective-C++ Dialects}.
 @emph{OpenRISC Options}
 @gccoptlist{-mboard=@var{name}  -mnewlib  -mhard-mul  -mhard-div @gol
 -msoft-mul  -msoft-div @gol
--mcmov  -mror  -msext  -msfimm  -mshftimm}
+-mcmov  -mror  -mrori  -msext  -msfimm  -mshftimm}
 
 @emph{PDP-11 Options}
 @gccoptlist{-mfpu  -msoft-float  -mac0  -mno-ac0  -m40  -m45  -m10 @gol
@@ -23632,50 +23632,56 @@ newlib board library linking.  The default is @code{or1ksim}.
 
 @item -mnewlib
 @opindex mnewlib
-For compatibility, it's always newlib for elf now.
+This option is ignored; it is for compatibility purposes only.  This used to
+select linker and preprocessor options for use with newlib.
 
- at item -mhard-div
+ at item -msoft-div
+ at itemx -mhard-div
+ at opindex msoft-div
 @opindex mhard-div
-Generate code for hardware which supports divide instructions.  This is the
-default.
+Select software or hardware divide (@code{l.div}, @code{l.divu}) instructions.
+This default is hardware divide.
 
- at item -mhard-mul
+ at item -msoft-mul
+ at itemx -mhard-mul
+ at opindex msoft-mul
 @opindex mhard-mul
-Generate code for hardware which supports multiply instructions.  This is the
-default.
+Select software or hardware multiply (@code{l.mul}, @code{l.muli}) instructions.
+This default is hardware multiply.
 
 @item -mcmov
 @opindex mcmov
-Generate code for hardware which supports the conditional move (@code{l.cmov})
-instruction.
+Enable generation of conditional move (@code{l.cmov}) instructions.  By
+default the equivalent will be generated using using set and branch.
 
 @item -mror
 @opindex mror
-Generate code for hardware which supports rotate right instructions.
+Enable generation of rotate right (@code{l.ror}) instructions.  By default
+functions from @file{libgcc} are used to perform rotate right operations.
+
+ at item -mrori
+ at opindex mrori
+Enable generation of rotate right with immediate (@code{l.rori}) instructions.
+By default functions from @file{libgcc} are used to perform rotate right with
+immediate operations.
 
 @item -msext
 @opindex msext
-Generate code for hardware which supports sign-extension instructions.
+Enable generation of sign extension (@code{l.ext*}) instructions.  By default
+memory loads are used to perform sign extension.
 
 @item -msfimm
 @opindex msfimm
-Generate code for hardware which supports set flag immediate (@code{l.sf*i})
-instructions.
+Enable generation of compare and set flag with immediate (@code{l.sf*i})
+instructions.  By default extra instructions will be generated to store the
+immediate to a register first.
 
 @item -mshftimm
 @opindex mshftimm
-Generate code for hardware which supports shift immediate related instructions
-(i.e. @code{l.srai}, @code{l.srli}, @code{l.slli}, @code{1.rori}).  Note, to
-enable generation of the @code{l.rori} instruction the @option{-mror} flag must
-also be specified.
+Enable generation of shift with immediate (@code{l.srai}, @code{l.srli},
+ at code{l.slli}) instructions.  By default extra instructions will be generated
+to store the immediate to a register first.
 
- at item -msoft-div
- at opindex msoft-div
-Generate code for hardware which requires divide instruction emulation.
-
- at item -msoft-mul
- at opindex msoft-mul
-Generate code for hardware which requires multiply instruction emulation.
 
 @end table
 
diff --git a/gcc/testsuite/gcc.target/or1k/ror-4.c b/gcc/testsuite/gcc.target/or1k/ror-4.c
new file mode 100644
index 00000000000..7489ce5b6a2
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/ror-4.c
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-mrori -O2" } */
+
+unsigned int rotate6 (unsigned int a) {
+  return ( a >> 6 ) | ( a << ( 32 - 6 ) );
+}
+
+/* { dg-final { scan-assembler "l.rori" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/shftimm-1.c b/gcc/testsuite/gcc.target/or1k/shftimm-1.c
index be8d9e8b895..3a8dc06df79 100644
--- a/gcc/testsuite/gcc.target/or1k/shftimm-1.c
+++ b/gcc/testsuite/gcc.target/or1k/shftimm-1.c
@@ -1,8 +1,8 @@
 /* { dg-do compile } */
-/* { dg-options "-mror -mshftimm -O2" } */
+/* { dg-options "-mshftimm -O2" } */
 
-unsigned int rotate6 (unsigned int a) {
-  return ( a >> 6 ) | ( a << ( 32 - 6 ) );
+unsigned int shift6 (unsigned int a) {
+  return a << 6;
 }
 
-/* { dg-final { scan-assembler "l.rori" } } */
+/* { dg-final { scan-assembler "l.slli" } } */
-- 
2.21.0

