From: Stafford Horne <shorne@gmail.com>
Date: Sat, 27 Oct 2018 13:37:01 +0900
Subject: [OpenRISC] [PATCH v3 2/3] or1k: testsuite: initial support for
	openrisc
In-Reply-To: <20181027043702.18414-1-shorne@gmail.com>
References: <20181027043702.18414-1-shorne@gmail.com>
Message-ID: <20181027043702.18414-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
	    Richard Henderson  <rth@twiddle.net>

gcc/testsuite/ChangeLog:

	* gcc.c-torture/execute/20101011-1.c: Adjust for OpenRISC.
	* gcc.dg/20020312-2.c: Likewise.
	* gcc.dg/attr-alloc_size-11.c: Likewise.
	* gcc.dg/builtin-apply2.c: Likewise.
	* gcc.dg/nop.h: Likewise.
	* gcc.dg/torture/stackalign/builtin-apply-2.c: Likewise.
	* gcc.dg/tree-ssa/20040204-1.c: Likewise.
	* gcc.dg/tree-ssa/reassoc-33.c: Likewise.
	* gcc.dg/tree-ssa/reassoc-34.c: Likewise.
	* gcc.dg/tree-ssa/reassoc-35.c: Likewise.
	* gcc.dg/tree-ssa/reassoc-36.c: Likewise.
	* lib/target-supports.exp
	(check_effective_target_logical_op_short_circuit): Add or1k*-*-*.
	* gcc.target/or1k/*: New.
---
 .../gcc.c-torture/execute/20101011-1.c        |  3 ++
 gcc/testsuite/gcc.dg/20020312-2.c             |  2 +
 gcc/testsuite/gcc.dg/attr-alloc_size-11.c     |  4 +-
 gcc/testsuite/gcc.dg/builtin-apply2.c         |  2 +-
 gcc/testsuite/gcc.dg/nop.h                    |  2 +
 .../torture/stackalign/builtin-apply-2.c      |  2 +-
 gcc/testsuite/gcc.dg/tree-ssa/20040204-1.c    |  2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-33.c    |  2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-34.c    |  2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-35.c    |  2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-36.c    |  2 +-
 gcc/testsuite/gcc.target/or1k/args-1.c        | 19 +++++++++
 gcc/testsuite/gcc.target/or1k/args-2.c        | 15 +++++++
 gcc/testsuite/gcc.target/or1k/cmov-1.c        |  8 ++++
 gcc/testsuite/gcc.target/or1k/cmov-2.c        |  9 ++++
 gcc/testsuite/gcc.target/or1k/div-mul-1.c     |  9 ++++
 gcc/testsuite/gcc.target/or1k/div-mul-2.c     |  9 ++++
 gcc/testsuite/gcc.target/or1k/or1k.exp        | 41 +++++++++++++++++++
 gcc/testsuite/gcc.target/or1k/return-1.c      | 10 +++++
 gcc/testsuite/gcc.target/or1k/return-2.c      | 19 +++++++++
 gcc/testsuite/gcc.target/or1k/return-3.c      | 19 +++++++++
 gcc/testsuite/gcc.target/or1k/return-4.c      | 19 +++++++++
 gcc/testsuite/gcc.target/or1k/ror-1.c         |  8 ++++
 gcc/testsuite/gcc.target/or1k/ror-2.c         |  9 ++++
 gcc/testsuite/gcc.target/or1k/ror-3.c         |  8 ++++
 gcc/testsuite/gcc.target/or1k/shftimm-1.c     |  8 ++++
 gcc/testsuite/gcc.target/or1k/shftimm-2.c     |  8 ++++
 gcc/testsuite/gcc.target/or1k/sibcall-1.c     | 18 ++++++++
 gcc/testsuite/lib/target-supports.exp         |  1 +
 29 files changed, 253 insertions(+), 9 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/args-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/args-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/cmov-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/cmov-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/div-mul-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/div-mul-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/or1k.exp
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-3.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-4.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-3.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/shftimm-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/shftimm-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/sibcall-1.c

diff --git a/gcc/testsuite/gcc.c-torture/execute/20101011-1.c b/gcc/testsuite/gcc.c-torture/execute/20101011-1.c
index 8261b796a47..d2beeb52a0e 100644
--- a/gcc/testsuite/gcc.c-torture/execute/20101011-1.c
+++ b/gcc/testsuite/gcc.c-torture/execute/20101011-1.c
@@ -100,6 +100,9 @@ __aeabi_idiv0 (int return_value)
 #elif defined (__moxie__)
   /* Not all moxie configurations may raise exceptions.  */
 # define DO_TEST 0
+#elif defined (__or1k__)
+  /* On OpenRISC division by zero does not trap.  */
+# define DO_TEST 0
 #else
 # define DO_TEST 1
 #endif
diff --git a/gcc/testsuite/gcc.dg/20020312-2.c b/gcc/testsuite/gcc.dg/20020312-2.c
index 1a8afd81506..e72a5b261ae 100644
--- a/gcc/testsuite/gcc.dg/20020312-2.c
+++ b/gcc/testsuite/gcc.dg/20020312-2.c
@@ -117,6 +117,8 @@ extern void abort (void);
 # if defined (__CK807__) || defined (__CK810__)
 #   define PIC_REG  "r28"
 # endif
+#elif defined (__or1k__)
+/* No pic register.  */
 #else
 # error "Modify the test for your target."
 #endif
diff --git a/gcc/testsuite/gcc.dg/attr-alloc_size-11.c b/gcc/testsuite/gcc.dg/attr-alloc_size-11.c
index 3ec44dc1463..6bb904f4794 100644
--- a/gcc/testsuite/gcc.dg/attr-alloc_size-11.c
+++ b/gcc/testsuite/gcc.dg/attr-alloc_size-11.c
@@ -47,8 +47,8 @@ typedef __SIZE_TYPE__    size_t;
 
 /* The following tests fail because of missing range information.  The xfail
    exclusions are PR79356.  */
-TEST (signed char, SCHAR_MIN + 2, ALLOC_MAX);   /* { dg-warning "argument 1 range \\\[13, \[0-9\]+\\\] exceeds maximum object size 12" "missing range info for signed char" { xfail { ! { aarch64*-*-* arm*-*-* avr-*-* alpha*-*-* ia64-*-* mips*-*-* powerpc*-*-* sparc*-*-* s390*-*-* visium-*-* } } } } */
-TEST (short, SHRT_MIN + 2, ALLOC_MAX); /* { dg-warning "argument 1 range \\\[13, \[0-9\]+\\\] exceeds maximum object size 12" "missing range info for short" { xfail { ! { aarch64*-*-* arm*-*-* alpha*-*-* avr-*-* ia64-*-* mips*-*-* powerpc*-*-* sparc*-*-* s390x-*-* visium-*-* } } } } */
+TEST (signed char, SCHAR_MIN + 2, ALLOC_MAX);   /* { dg-warning "argument 1 range \\\[13, \[0-9\]+\\\] exceeds maximum object size 12" "missing range info for signed char" { xfail { ! { aarch64*-*-* arm*-*-* avr-*-* alpha*-*-* ia64-*-* mips*-*-* powerpc*-*-* sparc*-*-* s390*-*-* visium-*-* or1k*-*-* } } } } */
+TEST (short, SHRT_MIN + 2, ALLOC_MAX); /* { dg-warning "argument 1 range \\\[13, \[0-9\]+\\\] exceeds maximum object size 12" "missing range info for short" { xfail { ! { aarch64*-*-* arm*-*-* alpha*-*-* avr-*-* ia64-*-* mips*-*-* powerpc*-*-* sparc*-*-* s390x-*-* visium-*-* or1k*-*-* } } } } */
 TEST (int, INT_MIN + 2, ALLOC_MAX);    /* { dg-warning "argument 1 range \\\[13, \[0-9\]+\\\] exceeds maximum object size 12" } */
 TEST (int, -3, ALLOC_MAX);             /* { dg-warning "argument 1 range \\\[13, \[0-9\]+\\\] exceeds maximum object size 12" } */
 TEST (int, -2, ALLOC_MAX);             /* { dg-warning "argument 1 range \\\[13, \[0-9\]+\\\] exceeds maximum object size 12" } */
diff --git a/gcc/testsuite/gcc.dg/builtin-apply2.c b/gcc/testsuite/gcc.dg/builtin-apply2.c
index 3768caa5d5a..dd521973cae 100644
--- a/gcc/testsuite/gcc.dg/builtin-apply2.c
+++ b/gcc/testsuite/gcc.dg/builtin-apply2.c
@@ -1,7 +1,7 @@
 /* { dg-do run } */
 /* { dg-require-effective-target untyped_assembly } */
 /* { dg-skip-if "Variadic funcs have all args on stack. Normal funcs have args in registers." { "avr-*-* nds32*-*-*" } } */
-/* { dg-skip-if "Variadic funcs use different argument passing from normal funcs." { "riscv*-*-*" } } */
+/* { dg-skip-if "Variadic funcs use different argument passing from normal funcs." { "riscv*-*-* or1k*-*-*" } } */
 /* { dg-skip-if "Variadic funcs use Base AAPCS.  Normal funcs use VFP variant." { arm*-*-* && arm_hf_eabi } } */
 
 /* PR target/12503 */
diff --git a/gcc/testsuite/gcc.dg/nop.h b/gcc/testsuite/gcc.dg/nop.h
index a0c19a34414..23491a603f5 100644
--- a/gcc/testsuite/gcc.dg/nop.h
+++ b/gcc/testsuite/gcc.dg/nop.h
@@ -2,6 +2,8 @@
 #define NOP "nop 0"
 #elif defined (__MMIX__)
 #define NOP "swym 0"
+#elif defined (__or1k__)
+#define NOP "l.nop"
 #else
 #define NOP "nop"
 #endif
diff --git a/gcc/testsuite/gcc.dg/torture/stackalign/builtin-apply-2.c b/gcc/testsuite/gcc.dg/torture/stackalign/builtin-apply-2.c
index d033010dc7c..3f8d350ba8f 100644
--- a/gcc/testsuite/gcc.dg/torture/stackalign/builtin-apply-2.c
+++ b/gcc/testsuite/gcc.dg/torture/stackalign/builtin-apply-2.c
@@ -9,7 +9,7 @@
 /* arm_hf_eabi: Variadic funcs use Base AAPCS.  Normal funcs use VFP variant.
    avr: Variadic funcs don't pass arguments in registers, while normal funcs
         do.  */
-/* { dg-skip-if "Variadic funcs use different argument passing from normal funcs" { arm_hf_eabi || { avr-*-* riscv*-*-* } } } */
+/* { dg-skip-if "Variadic funcs use different argument passing from normal funcs" { arm_hf_eabi || { avr-*-* riscv*-*-* or1k*-*-* } } } */
 /* { dg-skip-if "Variadic funcs have all args on stack. Normal funcs have args in registers." { nds32*-*-* } } */
 /* { dg-require-effective-target untyped_assembly } */
    
diff --git a/gcc/testsuite/gcc.dg/tree-ssa/20040204-1.c b/gcc/testsuite/gcc.dg/tree-ssa/20040204-1.c
index a1237cf839b..bc486e32586 100644
--- a/gcc/testsuite/gcc.dg/tree-ssa/20040204-1.c
+++ b/gcc/testsuite/gcc.dg/tree-ssa/20040204-1.c
@@ -33,4 +33,4 @@ void test55 (int x, int y)
    that the && should be emitted (based on BRANCH_COST).  Fix this
    by teaching dom to look through && and register all components
    as true.  */
-/* { dg-final { scan-tree-dump-times "link_error" 0 "optimized" { xfail { ! "alpha*-*-* arm*-*-* aarch64*-*-* powerpc*-*-* cris-*-* crisv32-*-* hppa*-*-* i?86-*-* mmix-*-* mips*-*-* m68k*-*-* moxie-*-* nds32*-*-* s390*-*-* sh*-*-* sparc*-*-* spu-*-* visium-*-* x86_64-*-* riscv*-*-*" } } } } */
+/* { dg-final { scan-tree-dump-times "link_error" 0 "optimized" { xfail { ! "alpha*-*-* arm*-*-* aarch64*-*-* powerpc*-*-* cris-*-* crisv32-*-* hppa*-*-* i?86-*-* mmix-*-* mips*-*-* m68k*-*-* moxie-*-* nds32*-*-* s390*-*-* sh*-*-* sparc*-*-* spu-*-* visium-*-* x86_64-*-* riscv*-*-* or1k*-*-*" } } } } */
diff --git a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-33.c b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-33.c
index 5572df4ae24..243508c872c 100644
--- a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-33.c
+++ b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-33.c
@@ -1,4 +1,4 @@
-/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-*"} } } */
+/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-* or1k-*-*-*"} } } */
 
 /* { dg-options "-O2 -fno-inline -fdump-tree-reassoc1-details" } */
 /* { dg-additional-options "-mbranch-cost=2" { target branch_cost } } */
diff --git a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-34.c b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-34.c
index 9b45f1cd9be..24070046ef2 100644
--- a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-34.c
+++ b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-34.c
@@ -1,4 +1,4 @@
-/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-*"} } } */
+/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-* or1k*-*-*"} } } */
 
 /* { dg-options "-O2 -fno-inline -fdump-tree-reassoc1-details" } */
 /* { dg-additional-options "-mbranch-cost=2" { target branch_cost } } */
diff --git a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-35.c b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-35.c
index 9ee3abca04e..e5ba101e001 100644
--- a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-35.c
+++ b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-35.c
@@ -1,4 +1,4 @@
-/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-*"} } } */
+/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-* or1k*-*-*"} } } */
 
 /* { dg-options "-O2 -fno-inline -fdump-tree-reassoc1-details" } */
 /* { dg-additional-options "-mbranch-cost=2" { target branch_cost } } */
diff --git a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-36.c b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-36.c
index ac3a04291b7..4df5840859c 100644
--- a/gcc/testsuite/gcc.dg/tree-ssa/reassoc-36.c
+++ b/gcc/testsuite/gcc.dg/tree-ssa/reassoc-36.c
@@ -1,4 +1,4 @@
-/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-*"} } } */
+/* { dg-do run { target { ! "m68k*-*-* mmix*-*-* bfin*-*-* v850*-*-* moxie*-*-* cris*-*-* m32c*-*-* fr30*-*-* mcore*-*-* powerpc*-*-* xtensa*-*-* hppa*-*-* nios2*-*-* or1k*-*-*"} } } */
 
 /* { dg-options "-O2 -fno-inline -fdump-tree-reassoc1-details" } */
 /* { dg-additional-options "-mbranch-cost=2" { target branch_cost } } */
diff --git a/gcc/testsuite/gcc.target/or1k/args-1.c b/gcc/testsuite/gcc.target/or1k/args-1.c
new file mode 100644
index 00000000000..7538705d07f
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/args-1.c
@@ -0,0 +1,19 @@
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+struct a {
+  long x;
+  long y;
+  long z;
+};
+
+int passlibstruct (int b, struct a aa);
+
+int main() {
+  struct a aa = { 55, 66, 77 };
+
+  return passlibstruct(-1, aa);
+}
+
+/* Ensure we pass a stack reference in the second arg.  */
+/* { dg-final { scan-assembler-times "r4, r1, " 1 } } */
diff --git a/gcc/testsuite/gcc.target/or1k/args-2.c b/gcc/testsuite/gcc.target/or1k/args-2.c
new file mode 100644
index 00000000000..362f7c0c9e9
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/args-2.c
@@ -0,0 +1,15 @@
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+struct a {
+  long x;
+  long y;
+  long z;
+};
+
+int passstruct (int b, struct a aa) {
+  return aa.z + aa.y + b;
+}
+
+/* Ensure our struct reads are offset from the address in arg 2.  */
+/* { dg-final { scan-assembler-times "l.lwz\\s+r\\d+, \\d+.r4." 2 } } */
diff --git a/gcc/testsuite/gcc.target/or1k/cmov-1.c b/gcc/testsuite/gcc.target/or1k/cmov-1.c
new file mode 100644
index 00000000000..c66b67c07c7
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/cmov-1.c
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-mcmov -O2" } */
+
+int cond (int a, int b) {
+  return a > b;
+}
+
+/* { dg-final { scan-assembler "l.cmov" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/cmov-2.c b/gcc/testsuite/gcc.target/or1k/cmov-2.c
new file mode 100644
index 00000000000..9b3b5529740
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/cmov-2.c
@@ -0,0 +1,9 @@
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+/* { dg-skip-if "" { *-*-* }  { "-mcmov" } { "" } } */
+
+int cond (int a, int b) {
+  return a > b;
+}
+
+/* { dg-final { scan-assembler-not "l.cmov" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/div-mul-1.c b/gcc/testsuite/gcc.target/or1k/div-mul-1.c
new file mode 100644
index 00000000000..a5e8d286545
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/div-mul-1.c
@@ -0,0 +1,9 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -msoft-mul -msoft-div" } */
+
+int calc (int a, int b, int c) {
+  return a * b / c;
+}
+
+/* { dg-final { scan-assembler-not "l.mul" } } */
+/* { dg-final { scan-assembler-not "l.div" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/div-mul-2.c b/gcc/testsuite/gcc.target/or1k/div-mul-2.c
new file mode 100644
index 00000000000..a567d7d9f50
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/div-mul-2.c
@@ -0,0 +1,9 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -msoft-div" } */
+
+int calc (int a, int b, int c) {
+  return a * b / c;
+}
+
+/* { dg-final { scan-assembler "l.mul" } } */
+/* { dg-final { scan-assembler-not "l.div" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/or1k.exp b/gcc/testsuite/gcc.target/or1k/or1k.exp
new file mode 100644
index 00000000000..1a4d53a9f79
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/or1k.exp
@@ -0,0 +1,41 @@
+# Copyright (C) 2017-2018 Free Software Foundation, Inc.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with GCC; see the file COPYING3.  If not see
+# <http://www.gnu.org/licenses/>.
+
+# GCC testsuite that uses the `dg.exp' driver.
+
+# Exit immediately if this isn't an OpenRISC target.
+if ![istarget or1k*-*-*] then {
+  return
+}
+
+# Load support procs.
+load_lib gcc-dg.exp
+
+# If a testcase doesn't have special options, use these.
+global DEFAULT_CFLAGS
+if ![info exists DEFAULT_CFLAGS] then {
+    set DEFAULT_CFLAGS " -ansi -pedantic-errors"
+}
+
+# Initialize `dg'.
+dg-init
+
+# Main loop.
+dg-runtest [lsort [glob -nocomplain $srcdir/$subdir/*.\[cS\]]] \
+	"" $DEFAULT_CFLAGS
+
+# All done.
+dg-finish
diff --git a/gcc/testsuite/gcc.target/or1k/return-1.c b/gcc/testsuite/gcc.target/or1k/return-1.c
new file mode 100644
index 00000000000..6dd04197164
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/return-1.c
@@ -0,0 +1,10 @@
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+long long calc (long long a, long long b) {
+  return a * b + 5;
+}
+
+/* Ensure our return value is set in the r11, r12 pair.  */
+/* { dg-final { scan-assembler "r11," } } */
+/* { dg-final { scan-assembler "r12," } } */
diff --git a/gcc/testsuite/gcc.target/or1k/return-2.c b/gcc/testsuite/gcc.target/or1k/return-2.c
new file mode 100644
index 00000000000..c072ae23142
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/return-2.c
@@ -0,0 +1,19 @@
+/* Large structs are returned at a memory address passed in r3.  */
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+struct a {
+  long x;
+  long y;
+  long z;
+};
+
+struct a getstruct (long aa) {
+  struct a as = { 22, aa, -5 };
+  return as;
+}
+
+/* Ensure our return value is returned on stack.  */
+/* { dg-final { scan-assembler-not "r12," } } */
+/* { dg-final { scan-assembler "l.or\\s+r11, r3, r3" } } */
+/* { dg-final { scan-assembler-times "l.sw\\s+\\d+.r3.," 3 } } */
diff --git a/gcc/testsuite/gcc.target/or1k/return-3.c b/gcc/testsuite/gcc.target/or1k/return-3.c
new file mode 100644
index 00000000000..5c2e5f5ad91
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/return-3.c
@@ -0,0 +1,19 @@
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+struct a {
+  long x;
+  long y;
+  long z;
+};
+
+struct a getlibstruct (long aa);
+
+int main() {
+  struct a rs = getlibstruct(123);
+
+  return rs.x;
+}
+
+/* Ensure our return value is read from memory.  */
+/* { dg-final { scan-assembler "l.lwz\\s+r11," } } */
diff --git a/gcc/testsuite/gcc.target/or1k/return-4.c b/gcc/testsuite/gcc.target/or1k/return-4.c
new file mode 100644
index 00000000000..b866f58a307
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/return-4.c
@@ -0,0 +1,19 @@
+/* Test to ensure small structs are returned in memory too.  */
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+struct a {
+  long x;
+  long y;
+};
+
+struct a getlibstruct (long aa);
+
+int main() {
+  struct a rs = getlibstruct(123);
+
+  return rs.x;
+}
+
+/* Ensure our return value is read from memory.  */
+/* { dg-final { scan-assembler "l.lwz\\s+r11," } } */
diff --git a/gcc/testsuite/gcc.target/or1k/ror-1.c b/gcc/testsuite/gcc.target/or1k/ror-1.c
new file mode 100644
index 00000000000..df55a6adfef
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/ror-1.c
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-mror -O2" } */
+
+unsigned int rotate (unsigned int a, int b) {
+  return ( a >> b ) | ( a << ( 32 - b ) );
+}
+
+/* { dg-final { scan-assembler "l.ror" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/ror-2.c b/gcc/testsuite/gcc.target/or1k/ror-2.c
new file mode 100644
index 00000000000..9cd7f35d285
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/ror-2.c
@@ -0,0 +1,9 @@
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+/* { dg-skip-if "" { *-*-* }  { "-mror" } { "" } } */
+
+unsigned int rotate (unsigned int a, int b) {
+  return ( a >> b ) | ( a << ( 32 - b ) );
+}
+
+/* { dg-final { scan-assembler-not "l.ror" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/ror-3.c b/gcc/testsuite/gcc.target/or1k/ror-3.c
new file mode 100644
index 00000000000..b0a73b3064d
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/ror-3.c
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-mror -O2" } */
+
+unsigned int rotate6 (unsigned int a) {
+  return ( a >> 6 ) | ( a << ( 32 - 6 ) );
+}
+
+/* { dg-final { scan-assembler-not "l.rori" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/shftimm-1.c b/gcc/testsuite/gcc.target/or1k/shftimm-1.c
new file mode 100644
index 00000000000..be8d9e8b895
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/shftimm-1.c
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-mror -mshftimm -O2" } */
+
+unsigned int rotate6 (unsigned int a) {
+  return ( a >> 6 ) | ( a << ( 32 - 6 ) );
+}
+
+/* { dg-final { scan-assembler "l.rori" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/shftimm-2.c b/gcc/testsuite/gcc.target/or1k/shftimm-2.c
new file mode 100644
index 00000000000..ef9b52f2820
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/shftimm-2.c
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-mshftimm -O2" } */
+
+unsigned int shift6 (unsigned int a) {
+  return a >> 6;
+}
+
+/* { dg-final { scan-assembler "l.srli" } } */
diff --git a/gcc/testsuite/gcc.target/or1k/sibcall-1.c b/gcc/testsuite/gcc.target/or1k/sibcall-1.c
new file mode 100644
index 00000000000..8134f0cfe35
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/sibcall-1.c
@@ -0,0 +1,18 @@
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+/* Just create some dummy call that should trigger sibcall, no
+   stack logic.  */
+int calc (int a, int b, int c) {
+  if (c <= 0) return a;
+  return calc (a * b, b, --c);
+}
+
+int main() {
+   return calc (4, 3, 4);
+}
+
+/* Ensure sibcalls do not need to manipulate the stack.  */
+/* { dg-final { scan-assembler-not "r1," } } */
+/* Ensure sibcall maintains the body of the function.  */
+/* { dg-final { scan-assembler "l.mul" } } */
diff --git a/gcc/testsuite/lib/target-supports.exp b/gcc/testsuite/lib/target-supports.exp
index fd74c04d092..528e336752b 100644
--- a/gcc/testsuite/lib/target-supports.exp
+++ b/gcc/testsuite/lib/target-supports.exp
@@ -8394,6 +8394,7 @@ proc check_effective_target_logical_op_short_circuit {} {
 	 || [istarget riscv*-*-*]
 	 || [istarget v850*-*-*]
 	 || [istarget visium-*-*]
+	 || [istarget or1k*-*-*]
 	 || [check_effective_target_arm_cortex_m] } {
 	return 1
     }
-- 
2.17.1

