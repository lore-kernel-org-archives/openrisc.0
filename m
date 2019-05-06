From: Stafford Horne <shorne@gmail.com>
Date: Mon,  6 May 2019 22:16:20 +0900
Subject: [OpenRISC] [PATCH 1/2] or1k: Fix code quality for volatile memory
 loads
In-Reply-To: <20190506131621.29929-1-shorne@gmail.com>
References: <20190506131621.29929-1-shorne@gmail.com>
Message-ID: <20190506131621.29929-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Volatile memory does not match the memory_operand predicate.  This
causes extra extend/mask instructions instructions when reading
from volatile memory.  On OpenRISC loading volitile memory can be
treated the same as regular memory loads which supports combined
sign/zero extends.  Fixing this eliminates the need for extra
extend/mask instructions.

This also adds a test provided by Richard Selvaggi which uncovered the
issue while we were looking into another issue.

gcc/ChangeLog:

	PR target/90363
	* config/or1k/or1k.md (zero_extend<mode>si2): Update predicate.
	(extend<mode>si2): Update predicate.
	* gcc/config/or1k/predicates.md (volatile_mem_operand): New.
	(reg_or_mem_operand): New.

gcc/testsuite/ChangeLog:

	PR target/90363
	* gcc.target/or1k/swap-1.c: New test.
	* gcc.target/or1k/swap-2.c: New test.
---
 gcc/config/or1k/or1k.md                |  6 +-
 gcc/config/or1k/predicates.md          | 18 ++++++
 gcc/testsuite/gcc.target/or1k/swap-1.c | 86 ++++++++++++++++++++++++++
 gcc/testsuite/gcc.target/or1k/swap-2.c | 63 +++++++++++++++++++
 4 files changed, 170 insertions(+), 3 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/swap-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/swap-2.c

diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index 2dad51cd46b..757d899c442 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -328,11 +328,11 @@
 ;; Sign Extending
 ;; -------------------------------------------------------------------------
 
-;; Zero extension can always be done with AND and an extending load.
+;; Zero extension can always be done with AND or an extending load.
 
 (define_insn "zero_extend<mode>si2"
   [(set (match_operand:SI 0 "register_operand"                     "=r,r")
-	(zero_extend:SI (match_operand:I12 1 "nonimmediate_operand" "r,m")))]
+	(zero_extend:SI (match_operand:I12 1 "reg_or_mem_operand" "r,m")))]
   ""
   "@
    l.andi\t%0, %1, <zext_andi>
@@ -344,7 +344,7 @@
 
 (define_insn "extend<mode>si2"
   [(set (match_operand:SI 0 "register_operand"                      "=r,r")
-	(sign_extend:SI (match_operand:I12 1 "nonimmediate_operand"  "r,m")))]
+	(sign_extend:SI (match_operand:I12 1 "reg_or_mem_operand"  "r,m")))]
   "TARGET_SEXT"
   "@
    l.ext<ldst>s\t%0, %1
diff --git a/gcc/config/or1k/predicates.md b/gcc/config/or1k/predicates.md
index 879236bca49..b895f1b4228 100644
--- a/gcc/config/or1k/predicates.md
+++ b/gcc/config/or1k/predicates.md
@@ -82,3 +82,21 @@
 
 (define_predicate "equality_comparison_operator"
   (match_code "ne,eq"))
+
+;; Borrowed from rs6000
+;  Return true if the operand is in volatile memory.  Note that during the
+;; RTL generation phase, memory_operand does not return TRUE for volatile
+;; memory references.  So this function allows us to recognize volatile
+;; references where it's safe.
+(define_predicate "volatile_mem_operand"
+  (and (match_code "mem")
+       (match_test "MEM_VOLATILE_P (op)")
+       (if_then_else (match_test "reload_completed")
+	 (match_operand 0 "memory_operand")
+	 (match_test "memory_address_p (mode, XEXP (op, 0))"))))
+
+;; Return true if the operand is a register or memory; including volatile
+;; memory.
+(define_predicate "reg_or_mem_operand"
+  (ior (match_operand 0 "nonimmediate_operand")
+       (match_operand 0 "volatile_mem_operand")))
diff --git a/gcc/testsuite/gcc.target/or1k/swap-1.c b/gcc/testsuite/gcc.target/or1k/swap-1.c
new file mode 100644
index 00000000000..233c4b71627
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/swap-1.c
@@ -0,0 +1,86 @@
+/* { dg-do run } */
+/* { dg-options "-Os -mhard-mul -msoft-div -msoft-float" } */
+
+/* Copyright (C) 2018-2019 Free Software Foundation, Inc.
+   Copyright 2019 Broadcom.   Richard Selvaggi, 2019-March-27
+   The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License, version 2, as
+   published by the Free Software Foundation (the "GPL").
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License version 2 (GPLv2) for more details.
+
+   You should have received a copy of the GNU General Public License
+   version 2 (GPLv2) along with this source code.  */
+
+/* Notes:
+
+   This test failed on or1k GCC 7.2.0, and passes on or1k GCC 5.3.0
+   as well as the or1k port released in GCC 9.1.
+
+   The main program is organized as a loop structure so gcc does not
+   optimize-away the calls to swap_1().  Compiling with -O2 is still smart
+   enough to optimize-away the calls, but using -Os does not.
+   The bad code is only generated when compiled with -Os.
+
+   When the bad code is generated all code is okay except for the very last
+   instruction (a 'l.addc' in the l.jr delay slot).
+   Up to that point in execution, r11 and r12 contain the correct (expected)
+   values, but the execution of the final "l.addc" corrupts r11.
+
+   This test is added to ensure this does not come back.  */
+
+#include <stdint.h>
+
+volatile static uint8_t g_doswap = 1;
+
+uint64_t swap_1 (uint64_t u64) {
+  uint32_t u64_lo, u64_hi, u64_tmp;
+
+  u64_lo = u64 & 0xFFFFFFFF;
+  u64_hi = u64 >> 32;
+
+  if (g_doswap)
+    {
+      u64_tmp = u64_lo;
+      u64_lo  = u64_hi;
+      u64_hi  = u64_tmp;
+    }
+
+  u64 = u64_lo;
+  u64 += ((uint64_t) u64_hi << 32);
+
+  return u64;
+}
+
+int main () {
+  int ret;
+  int iter;
+  uint64_t  aa[2];   // inputs to swap function
+  uint64_t  ee[2];   // expected outputs of swap function
+  uint64_t  rr[2];   // actual results of swap function
+
+  g_doswap = 1;
+
+  // populate inputs, and expected outputs:
+  aa[0] = 0x123456789abcdef0;
+  aa[1] = 0x0123456789abcdef;
+
+  ee[0] = 0x9ABCDEF012345678;
+  ee[1] = 0x89ABCDEF01234567;
+
+  ret = 0;
+  for (iter = 0; iter < 2; iter++)
+    {
+      rr[iter] = swap_1(aa[iter]);
+      // early-out if there's a mis-match:
+      if (ee[iter] != rr[iter])
+        ret = 1;
+    }
+
+  return ret;
+}
diff --git a/gcc/testsuite/gcc.target/or1k/swap-2.c b/gcc/testsuite/gcc.target/or1k/swap-2.c
new file mode 100644
index 00000000000..8ddea4e659f
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/swap-2.c
@@ -0,0 +1,63 @@
+/* { dg-do compile } */
+/* { dg-options "-Os -mhard-mul -msoft-div -msoft-float" } */
+
+/* Copyright (C) 2018-2019 Free Software Foundation, Inc.
+   Copyright 2019 Broadcom.   Richard Selvaggi, 2019-March-27
+   The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License, version 2, as
+   published by the Free Software Foundation (the "GPL").
+
+   This program is distributed in the hope that it will be useful, but
+   WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   General Public License version 2 (GPLv2) for more details.
+
+   You should have received a copy of the GNU General Public License
+   version 2 (GPLv2) along with this source code.  */
+
+/* Notes:
+
+   This test failed on or1k GCC 7.2.0, and passes on or1k GCC 5.3.0
+   as well as the or1k port released in GCC 9.1.
+
+   The main program is organized as a loop structure so gcc does not
+   optimize-away the calls to swap_1().  Compiling with -O2 is still smart
+   enough to optimize-away the calls, but using -Os does not.
+   The bad code is only generated when compiled with -Os.
+
+   When the bad code is generated all code is okay except for the very last
+   instruction (a 'l.addc' in the l.jr delay slot).
+   Up to that point in execution, r11 and r12 contain the correct (expected)
+   values, but the execution of the final "l.addc" corrupts r11.
+
+   This test ensures an l.addc is not in the output.  Also, while confirming
+   this test we uncovered PR/90363, we use it to check for that as well.  */
+
+#include <stdint.h>
+
+volatile static uint8_t g_doswap = 1;
+
+uint64_t swap_1 (uint64_t u64) {
+  uint32_t u64_lo, u64_hi, u64_tmp;
+
+  u64_lo = u64 & 0xFFFFFFFF;
+  u64_hi = u64 >> 32;
+
+  if (g_doswap)
+    {
+      u64_tmp = u64_lo;
+      u64_lo  = u64_hi;
+      u64_hi  = u64_tmp;
+    }
+
+  u64 = u64_lo;
+  u64 += ((uint64_t) u64_hi << 32);
+
+  return u64;
+}
+
+/* Check to ensure the volitile load does not get zero extended.  */
+/* { dg-final { scan-assembler-not "0xff" } } */
+/* { dg-final { scan-assembler-not "l.addc" } } */
-- 
2.19.1

