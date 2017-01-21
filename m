From: Stafford Horne <shorne@gmail.com>
Date: Sat, 21 Jan 2017 12:03:55 +0900
Subject: [OpenRISC] [PATCH v2 6/6] sim: testsuite: add testsuite for or1k sim
In-Reply-To: <cover.1484967575.git.shorne@gmail.com>
References: <cover.1484967575.git.shorne@gmail.com>
Message-ID: <10ed0dc5f34374a58c90d60003e13d87f420e259.1484967575.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

From: Peter Gavin <pgavin@gmail.com>

* sim/testsuite/ChangeLog-OR1K:

	* add testsuite for or1k
---
 sim/testsuite/sim/or1k/add.S                   | 546 +++++++++++++++++
 sim/testsuite/sim/or1k/alltests.exp            |  19 +
 sim/testsuite/sim/or1k/and.S                   | 208 +++++++
 sim/testsuite/sim/or1k/basic.S                 | 535 +++++++++++++++++
 sim/testsuite/sim/or1k/div.S                   | 198 +++++++
 sim/testsuite/sim/or1k/ext.S                   | 251 ++++++++
 sim/testsuite/sim/or1k/find.S                  | 119 ++++
 sim/testsuite/sim/or1k/flag.S                  | 405 +++++++++++++
 sim/testsuite/sim/or1k/jump.S                  | 121 ++++
 sim/testsuite/sim/or1k/load.S                  | 373 ++++++++++++
 sim/testsuite/sim/or1k/mac.S                   | 785 +++++++++++++++++++++++++
 sim/testsuite/sim/or1k/mfspr.S                 | 196 ++++++
 sim/testsuite/sim/or1k/mul.S                   | 277 +++++++++
 sim/testsuite/sim/or1k/or.S                    | 207 +++++++
 sim/testsuite/sim/or1k/or1k-asm-test-env.h     |  61 ++
 sim/testsuite/sim/or1k/or1k-asm-test-helpers.h | 134 +++++
 sim/testsuite/sim/or1k/or1k-asm-test.h         | 258 ++++++++
 sim/testsuite/sim/or1k/or1k-asm.h              |  20 +
 sim/testsuite/sim/or1k/or1k-test.ld            |  57 ++
 sim/testsuite/sim/or1k/ror.S                   | 186 ++++++
 sim/testsuite/sim/or1k/shift.S                 | 572 ++++++++++++++++++
 sim/testsuite/sim/or1k/spr-defs.h              | 590 +++++++++++++++++++
 sim/testsuite/sim/or1k/sub.S                   | 176 ++++++
 sim/testsuite/sim/or1k/xor.S                   | 210 +++++++
 24 files changed, 6504 insertions(+)
 create mode 100644 sim/testsuite/sim/or1k/add.S
 create mode 100644 sim/testsuite/sim/or1k/alltests.exp
 create mode 100644 sim/testsuite/sim/or1k/and.S
 create mode 100644 sim/testsuite/sim/or1k/basic.S
 create mode 100644 sim/testsuite/sim/or1k/div.S
 create mode 100644 sim/testsuite/sim/or1k/ext.S
 create mode 100644 sim/testsuite/sim/or1k/find.S
 create mode 100644 sim/testsuite/sim/or1k/flag.S
 create mode 100644 sim/testsuite/sim/or1k/jump.S
 create mode 100644 sim/testsuite/sim/or1k/load.S
 create mode 100644 sim/testsuite/sim/or1k/mac.S
 create mode 100644 sim/testsuite/sim/or1k/mfspr.S
 create mode 100644 sim/testsuite/sim/or1k/mul.S
 create mode 100644 sim/testsuite/sim/or1k/or.S
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test-env.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test-helpers.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-test.ld
 create mode 100644 sim/testsuite/sim/or1k/ror.S
 create mode 100644 sim/testsuite/sim/or1k/shift.S
 create mode 100644 sim/testsuite/sim/or1k/spr-defs.h
 create mode 100644 sim/testsuite/sim/or1k/sub.S
 create mode 100644 sim/testsuite/sim/or1k/xor.S

diff --git a/sim/testsuite/sim/or1k/add.S b/sim/testsuite/sim/or1k/add.S
new file mode 100644
index 0000000..ee565c3
--- /dev/null
+++ b/sim/testsuite/sim/or1k/add.S
@@ -0,0 +1,546 @@
+/* Tests instructions l.add, l.addc, l.addi and l.addic
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000001);\n
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000001);\n
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x40000000);\n
+# output: report(0x3fffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x40000000);\n
+# output: report(0x40000000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xc0000000);\n
+# output: report(0xc0000000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xbfffffff);\n
+# output: report(0xbfffffff);\n
+# output: report(0x7ffffffe);\n
+# output: report(0x00000001);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000001);\n
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x40000000);\n
+# output: report(0x3fffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x40000000);\n
+# output: report(0x3fffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x40000000);\n
+# output: report(0x40000000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xc0000000);\n
+# output: report(0xc0000000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xc0000000);\n
+# output: report(0xbfffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xbfffffff);\n
+# output: report(0xbfffffff);\n
+# output: report(0x7ffffffe);\n
+# output: report(0x00000001);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000001);\n
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000001);\n
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x0000fffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x7fff8000);\n
+# output: report(0x00007fff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x7fffc000);\n
+# output: report(0x00004000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x80008000);\n
+# output: report(0x00008000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x80007fff);\n
+# output: report(0x00008000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x0000fffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000001);\n
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x0000fffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x7fff8000);\n
+# output: report(0x00007fff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x7fff8000);\n
+# output: report(0x00007fff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x7fffc000);\n
+# output: report(0x00004000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x0000ffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x80008000);\n
+# output: report(0x00008000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x80007fff);\n
+# output: report(0x00008000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x80007fff);\n
+# output: report(0x00008000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x0000fffe);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x0000ffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .exception_vectors
+        
+        // Alignment exception.
+	    .org	0x600
+        // TODO: print out address of instruction that caused the problem
+        
+        // Range exception.
+	    .org	0xb00
+
+        // TODO: The stack safety zone is not taken into consideration.
+        
+        // The handling is a bit dubious at present. We just patch the instruction with l.nop and
+        // restart. This will go wrong in branch delay slots. Really we need to single
+
+        // step past and then continue.
+
+
+        // TODO: do we need to patch the instruction? Can we not skip it somehow?
+
+        PUSH r2
+        PUSH r3
+
+        MOVE_FROM_SPR r2, SPR_EPCR_BASE  // Address of the instruction that caused the problem.
+
+	    LOAD_IMMEDIATE r3, 0x15000000	// Opcode for l.nop
+	    l.sw	-4(r2), r3  // TODO: temporary, remove at the end
+	    l.sw	 0(r2), r3
+	    l.sw	+4(r2), r3  // TODO: temporary, remove at the end
+
+        POP r3
+        POP r2
+
+	    l.rfe
+        
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+        
+        // ----------- Test l.add -----------
+        
+        // Add two small positive numbers
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, 1, 2
+
+        // The carry flag should be ignored.
+        TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.add, 1, 2
+
+        // Add two small negative numbers, which should set the carry flag but not the overflow flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, -1, -2
+
+        // Add two quite large positive numbers. Should set neither the overflow nor the carry flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, 0x40000000, 0x3fffffff
+
+        // Add two large positive numbers. Should set the overflow, but not the carry flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, 0x40000000, 0x40000000
+
+        // Add two quite large negative numbers. Should set the carry, but not the overflow flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, -1073741824, -1073741824  // -1073741824 = 0xC0000000
+
+        // Add two large negative numbers. Should set both the overflow and carry flags.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, 0xbfffffff, 0xbfffffff
+
+        
+        // ------ Check that range exceptions are triggered.
+        
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        // TODO: Disabled at the moment, as this test fails against the ORPSoC V2 core.
+        // Check that an overflow alone causes a RANGE Exception.
+        // TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, 0x40000000, 0x40000000
+
+        // Check that a carry alone does not cause a RANGE Exception.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, 0xffffffff, 0xfffffffe
+
+        // TODO: Disabled at the moment, as this test fails against the ORPSoC V2 core.
+        // Check that carry and overflow together cause an exception.
+        // TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.add, 0xbfffffff, 0xbfffffff
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+
+        // ----------- Test l.addc -----------
+
+        // Add two small positive numbers
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV,  l.addc, 1, 2
+
+        // Add two small negative numbers. Sets the carry flag but not the overflow flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, -1, -2
+
+        // Add two quite large positive numbers. Should set neither the overflow nor the carry flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, 0x40000000, 0x3fffffff
+
+        // Add two quite large positive numbers with a carry in. Should set the overflow but not the carry flag.
+        TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.addc, 0x40000000, 0x3fffffff
+
+        // Add two large positive numbers. Should set the overflow, but not the carry flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, 0x40000000, 0x40000000
+
+        // Add the largest unsigned value to zero with a carry. This potentially can break a
+        // simplistic test for carry that does not  consider the carry flag properly. Do it both ways around.
+        // TODO: investigate why this test is failing
+        TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.addc, -1,  0
+        TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.addc,  0, -1
+
+        // Add two quite large negative numbers. Should set the carry, but not the overflow flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, -1073741824, -1073741824  // -1073741824 = 0xC0000000
+
+        // Add two quite large negative numbers that would overflow, with a carry that just avoids
+        // the overflow. Should set the carry, but not the overflow flag.
+        TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.addc, -1073741824, -1073741825  // -1073741824 = 0xC0000000, -1073741825 = 0xBFFFFFFF
+
+        // Add two large negative numbers. Should set both the overflow and  carry flags.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, -1073741825, -1073741825
+
+
+        // ------ Check that range exceptions are triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        // TODO: Disabled at the moment, as this test fails against the ORPSoC V2 core.
+        // Check that an overflow alone causes a RANGE Exception, even when it
+        // is the carry that causes the overflow.
+        // TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, 0x40000000, 0x40000000
+        // TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.addc, 0x40000000, 0x3fffffff
+
+        // Check that a carry alone does not cause a RANGE Exception, even when it is the carry that causes the overflow.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, 0xffffffff, 0xfffffffe
+        TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.addc, 0x00000000, 0xffffffff
+
+        // TODO: Disabled at the moment, as this test fails against the ORPSoC V2 core.
+        // Check that carry and overflow together cause an exception.
+        // TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.addc, 0xbfffffff, 0xbfffffff
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+
+        // ----------- Test l.addi -----------
+
+        // Add two small positive numbers
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 1, 2
+
+        // Check carry in is ignored.
+        TEST_INST_FF_I32_I16 SPR_SR_CY, SPR_SR_OV, l.addi, 1, 2
+
+        // Add two small negative numbers. Sets the carry flag but not the overflow flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0xffffffff, 0xfffe
+
+        // Add two quite large positive numbers. Should set neither the overflow nor the carry flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0x7fff8000, 0x7fff
+
+        // Add two large positive numbers. Should set the overflow, but not the carry flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0x7fffc000, 0x4000
+        
+        // Add two quite large negative numbers. Should set the carry, but not the overflow flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0x80008000, 0x8000
+
+        // Add two large negative numbers. Should set both the overflow and carry flags.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0x80007fff, 0x8000
+
+        // ------ Check that range exceptions are triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        // TODO: Disabled at the moment, as this test fails against the ORPSoC V2 core.
+        // Check that an overflow alone causes a RANGE Exception.
+        // TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0x7fffc000, 0x4000
+
+        // Check that a carry alone does not cause a RANGE Exception.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0xffffffff, 0xfffe
+
+        // TODO: Disabled at the moment, as this test fails against the ORPSoC V2 core.
+        // Check that carry and overflow together cause an exception.
+        // TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addi, 0x80007fff, 0x8000
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+
+        // ----------- Test l.addi -----------
+
+        // Add two small positive numbers
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 1, 2
+
+        // Add two small negative numbers. Sets the carry flag but not the overflow flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0xffffffff, 0xfffe
+
+        // Add two quite large positive numbers. Should set neither the overflow nor the carry flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0x7fff8000, 0x7fff
+
+        // Add two quite large positive numbers with a carry in. Should set the overflow but not the carry flag.
+        TEST_INST_FF_I32_I16 SPR_SR_CY, SPR_SR_OV, l.addic, 0x7fff8000, 0x7fff
+
+        // Add two large positive numbers. Should set the overflow, but not the carry flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0x7fffc000, 0x4000
+
+        // Add the largest unsigned value to zero with a carry. This  potentially can break a simplistic
+        // test for carry that does not  consider the carry flag properly. Do it both ways around.
+        TEST_INST_FF_I32_I16 SPR_SR_CY, SPR_SR_OV, l.addic, 0xffffffff, 0x0000
+        TEST_INST_FF_I32_I16 SPR_SR_CY, SPR_SR_OV, l.addic, 0x00000000, 0xffff
+
+        // Add two quite large negative numbers. Should set the carry, but not the overflow flag.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0x80008000, 0x8000
+
+        // Add two quite large negative numbers that would overflow, with a carry that just avoids the overflow.
+        // Should set the carry, but not the overflow flag. flag.
+        TEST_INST_FF_I32_I16 SPR_SR_CY, SPR_SR_OV, l.addic, 0x80007fff, 0x8000
+
+        // Add two large negative numbers. Should set both the overflow and carry flags.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0x80007fff, 0x8000
+
+        // ------ Check that range exceptions are triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+        
+        // Check that an overflow alone causes a RANGE Exception, even when it
+        //   is the carry that causes the overflow.
+        // TODO: Disabled at the moment, as this test fails against the ORPSoC V2 core.
+        // TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0x7fffc000, 0x4000
+        // TEST_INST_FF_I32_I16 SPR_SR_CY, SPR_SR_OV, l.addic, 0x7fffc000, 0x3fff
+
+        // Check that a carry alone does not cause a RANGE Exception, even
+        // when it is the carry that causes the overflow.
+        TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0xffffffff, 0xfffe
+        TEST_INST_FF_I32_I16 SPR_SR_CY, SPR_SR_OV, l.addic, 0x00000000, 0xffff
+
+        // Check that carry and overflow together cause an exception.
+        // TEST_INST_FF_I32_I16 0, SPR_SR_CY | SPR_SR_OV, l.addic, 0x80007fff, 0x8000
+        
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/alltests.exp b/sim/testsuite/sim/or1k/alltests.exp
new file mode 100644
index 0000000..f10379e
--- /dev/null
+++ b/sim/testsuite/sim/or1k/alltests.exp
@@ -0,0 +1,19 @@
+# OR1K simulator testsuite.
+
+if [istarget or1k*-*-*] {
+    
+    set all_machs "or1k"
+
+    global global_ld_options
+    set global_ld_options "-T $srcdir/$subdir/or1k-test.ld"
+    
+    foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.S]] {
+        
+        if ![runtest_file_p $runtests $src] {
+            continue
+        }
+                
+        run_sim_test $src $all_machs
+    }
+
+}
\ No newline at end of file
diff --git a/sim/testsuite/sim/or1k/and.S b/sim/testsuite/sim/or1k/and.S
new file mode 100644
index 0000000..6552474
--- /dev/null
+++ b/sim/testsuite/sim/or1k/and.S
@@ -0,0 +1,208 @@
+/* Tests instructions l.and, l.andi
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x55555555);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xc4c70f07);\n
+# output: report(0x44400004);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x38f0f83b);\n
+# output: report(0x30800803);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x0000ffff);\n
+# output: report(0x0000ffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x0000aaaa);\n
+# output: report(0x0000aaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00005555);\n
+# output: report(0x00005555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00005555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000f83);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000f07);\n
+# output: report(0x00000004);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000f83b);\n
+# output: report(0x00000803);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+	    // Always set OVE. We should never trigger an exception, even if this bit is set.
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        // Test the l.and instruction with a range of operands.
+        
+	    TEST_INST_I32_I32 l.and, 0x00000000, 0x00000000
+	    TEST_INST_I32_I32 l.and, 0xffffffff, 0xffffffff
+	    TEST_INST_I32_I32 l.and, 0xaaaaaaaa, 0x00000000
+	    TEST_INST_I32_I32 l.and, 0xaaaaaaaa, 0xaaaaaaaa
+	    TEST_INST_I32_I32 l.and, 0x55555555, 0x00000000
+	    TEST_INST_I32_I32 l.and, 0x55555555, 0x55555555
+	    TEST_INST_I32_I32 l.and, 0xaaaaaaaa, 0x55555555
+	    TEST_INST_I32_I32 l.and, 0x4c70f07c, 0xb38f0f83
+	    TEST_INST_I32_I32 l.and, 0x4c70f07c, 0xc4c70f07
+	    TEST_INST_I32_I32 l.and, 0xb38f0f83, 0x38f0f83b
+
+        // Test the l.andi instruction with a range of operands.
+        
+	    TEST_INST_I32_I16 l.andi, 0x00000000, 0x0000
+	    TEST_INST_I32_I16 l.andi, 0xffffffff, 0xffff
+	    TEST_INST_I32_I16 l.andi, 0xaaaaaaaa, 0x0000
+	    TEST_INST_I32_I16 l.andi, 0xaaaaaaaa, 0xaaaa
+	    TEST_INST_I32_I16 l.andi, 0x55555555, 0x0000
+	    TEST_INST_I32_I16 l.andi, 0x55555555, 0x5555
+	    TEST_INST_I32_I16 l.andi, 0xaaaaaaaa, 0x5555
+	    TEST_INST_I32_I16 l.andi, 0x4c70f07c, 0x0f83
+	    TEST_INST_I32_I16 l.andi, 0x4c70f07c, 0x0f07
+	    TEST_INST_I32_I16 l.andi, 0xb38f0f83, 0xf83b
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/basic.S b/sim/testsuite/sim/or1k/basic.S
new file mode 100644
index 0000000..1e349a0
--- /dev/null
+++ b/sim/testsuite/sim/or1k/basic.S
@@ -0,0 +1,535 @@
+/* Tests some basic CPU instructions.
+
+   Copyright (C) 1999-2006 OpenCores
+     Contributors various OpenCores participants
+   Copyright (C) 2010 Embecosm Limited
+     Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+   Copyright (C) 2012 R. Diez
+
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the Free
+   Software Foundation; either version 3 of the License, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+   more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+# mach: or1k
+# output: report(0xffff0012);\n
+# output: report(0x12352af7);\n
+# output: report(0x7ffffffe);\n
+# output: report(0xffffa5a7);\n
+# output: report(0x000fffff);\n
+# output: report(0x00002800);\n
+# output: report(0x00000009);\n
+# output: report(0xdeaddead);\n
+# output: report(0xffff0000);\n
+# output: report(0x12345678);\n
+# output: report(0xabcdf0bd);\n
+# output: exit(0)\n
+
+#include "or1k-asm-test-env.h"
+
+#define FIRST_RAM_ADDR 0x00000000
+
+
+        STANDARD_TEST_HEADER
+
+        // -------- Early test begin.
+        
+        // Do this test upfront, as it modifies STACK_POINTER_R1.
+        
+        l.addi  r1 , r0 , 0x1
+	    l.addi  r2 , r1 , 0x2
+	    l.addi  r3 , r2 , 0x4
+	    l.addi  r4 , r3 , 0x8
+	    l.addi  r5 , r4 , 0x10
+	    l.addi  r6 , r5 , 0x20
+	    l.addi  r7 , r6 , 0x40
+	    l.addi  r8 , r7 , 0x80
+	    l.addi  r9 , r8 , 0x100
+	    l.addi  r10, r9 , 0x200
+	    l.addi  r11, r10, 0x400
+	    l.addi  r12, r11, 0x800
+	    l.addi  r13, r12, 0x1000
+	    l.addi  r14, r13, 0x2000
+	    l.addi  r15, r14, 0x4000
+	    l.addi  r16, r15, 0x8000
+
+	    l.sub   r31, r0 , r1
+	    l.sub   r30, r31, r2
+	    l.sub   r29, r30, r3
+	    l.sub   r28, r29, r4
+	    l.sub   r27, r28, r5
+	    l.sub   r26, r27, r6
+	    l.sub   r25, r26, r7
+	    l.sub   r24, r25, r8
+	    l.sub   r23, r24, r9
+	    l.sub   r22, r23, r10
+	    l.sub   r21, r22, r11
+	    l.sub   r20, r21, r12
+	    l.sub   r19, r20, r13
+	    l.sub   r18, r19, r14
+	    l.sub   r17, r18, r15
+	    l.sub   r16, r17, r16
+
+        // We cannot use REPORT_REG_TO_CONSOLE here, as the stack is not set up yet.
+        MOVE_REG NOP_REPORT_R3, r16
+        REPORT_TO_CONSOLE  // Should be 0xffff0012
+
+        // -------- Early test end.
+
+        STANDARD_TEST_BODY
+
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+        // ------ Read and write from RAM -----
+        
+        LOAD_IMMEDIATE r31, FIRST_RAM_ADDR
+        l.sw    0(r31), r16
+        
+        l.movhi r3,0x1234
+        l.ori   r3,r3,0x5678
+
+        l.sw    4(r31),r3
+
+        l.lbz   r4,4(r31)
+        l.add   r8,r8,r4
+        l.sb    11(r31),r4
+        l.lbz   r4,5(r31)
+        l.add   r8,r8,r4
+        l.sb    10(r31),r4
+        l.lbz   r4,6(r31)
+        l.add   r8,r8,r4
+        l.sb    9(r31),r4
+        l.lbz   r4,7(r31)
+        l.add   r8,r8,r4
+        l.sb    8(r31),r4
+
+        l.lbs   r4,8(r31)
+        l.add   r8,r8,r4
+        l.sb    7(r31),r4
+        l.lbs   r4,9(r31)
+        l.add   r8,r8,r4
+        l.sb    6(r31),r4
+        l.lbs   r4,10(r31)
+        l.add   r8,r8,r4
+        l.sb    5(r31),r4
+        l.lbs   r4,11(r31)
+        l.add   r8,r8,r4
+        l.sb    4(r31),r4
+    
+        l.lhz   r4,4(r31)
+        l.add   r8,r8,r4
+        l.sh    10(r31),r4
+        l.lhz   r4,6(r31)
+        l.add   r8,r8,r4
+        l.sh    8(r31),r4
+
+        l.lhs   r4,8(r31)
+        l.add   r8,r8,r4
+        l.sh    6(r31),r4
+        l.lhs   r4,10(r31)
+        l.add   r8,r8,r4
+        l.sh    4(r31),r4
+
+        l.lwz   r4,4(r31)
+        l.add   r8,r8,r4
+
+        REPORT_REG_TO_CONSOLE r8  // Should be 0x12352af7
+        
+        l.lwz   r9,0(r31)
+        l.add   r8,r9,r8
+        l.sw    0(r31),r8
+
+        
+        // ------ Do some arithmetic operations -----
+        
+        l.addi  r3,r0,1
+        l.addi  r4,r0,2
+        l.addi  r5,r0,-1
+        l.addi  r6,r0,-1
+        l.addi  r8,r0,0
+    
+        l.sub   r7,r5,r3
+        l.sub   r8,r3,r5
+        l.add   r8,r8,r7
+    
+        l.div   r7,r7,r4
+        l.add   r9,r3,r4
+        l.mul   r7,r9,r7
+        l.divu  r7,r7,r4
+        l.add   r8,r8,r7
+
+        REPORT_REG_TO_CONSOLE r8  // Should be 0x7ffffffe
+
+        l.lwz   r9,0(r31)
+        l.add   r8,r9,r8
+        l.sw    0(r31),r8
+
+        
+        // ------ Do some logical operations -----
+        
+        l.addi  r3,r0,1
+        l.addi  r4,r0,2
+        l.addi  r5,r0,-1
+        l.addi  r6,r0,-1
+        l.addi  r8,r0,0 
+
+        l.andi  r8,r8,1
+        l.and   r8,r8,r3
+
+        l.xori  r8,r5,0xa5a5
+        l.xor   r8,r8,r5
+
+        l.ori   r8,r8,2
+        l.or    r8,r8,r4
+
+        REPORT_REG_TO_CONSOLE r8  // Should be 0xffffa5a7
+
+        l.lwz   r9,0(r31)
+        l.add   r8,r9,r8
+        l.sw    0(r31),r8
+
+        
+        // ------ Do some shifting operations -----
+        
+        l.addi  r3,r0,1
+        l.addi  r4,r0,2
+        l.addi  r5,r0,-1
+        l.addi  r6,r0,-1
+        l.addi  r8,r0,0
+
+        l.slli  r8,r5,6
+        l.sll   r8,r8,r4
+    
+        l.srli  r8,r8,6
+        l.srl   r8,r8,r4
+    
+        l.srai  r8,r8,2
+        l.sra   r8,r8,r4    
+
+        REPORT_REG_TO_CONSOLE r8  // Should be 0x000fffff
+
+        l.lwz   r9,0(r31)
+        l.add   r8,r9,r8
+        l.sw    0(r31),r8
+
+        
+        // ------ Test the CPU flag -----
+    
+        l.addi  r3,r0,1
+        l.addi  r4,r0,-2
+        l.addi  r8,r0,0
+
+        l.sfeq  r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfeq  r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfeqi r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfeqi r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4 
+    
+        l.sfne  r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfne  r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4 
+
+        l.sfnei r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfnei r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfgtu r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgtu r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfgtui    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgtui    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfgeu r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgeu r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfgeui    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgeui    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfltu r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfltu r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfltui    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfltui    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfleu r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfleu r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfleui    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfleui    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfgts r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgts r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgtsi    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgtsi    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfges r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfges r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgesi    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfgesi    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sflts r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sflts r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfltsi    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfltsi    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        l.sfles r3,r3
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sfles r3,r4
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sflesi    r3,1
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+ 
+        l.sflesi    r3,-2
+        l.mfspr r5,r0,17
+        l.andi  r4,r5,0x200
+        l.add   r8,r8,r4
+
+        REPORT_REG_TO_CONSOLE r8  // Should be 0x00002800
+
+        l.lwz   r9,0(r31)
+        l.add   r8,r9,r8
+        l.sw    0(r31),r8
+
+
+        // ------ Test the jump instructions -----
+        
+        l.addi  r8,r0,0
+
+        OR1K_DELAYED(
+        OR1K_INST(l.addi  r8,r8,1),
+        OR1K_INST(l.j _T1)
+        )
+
+_T2:    OR1K_DELAYED(
+        OR1K_INST(l.addi  r8,r8,1),
+        OR1K_INST(l.jr    r9)
+        )
+
+_T1:    OR1K_DELAYED(
+        OR1K_INST(l.addi  r8,r8,1),
+        OR1K_INST(l.jal   _T2)
+        )
+
+        l.sfeqi r0,0
+        OR1K_DELAYED(
+        OR1K_INST(l.addi  r8,r8,1),
+        OR1K_INST(l.bf    _T3)
+        )
+
+_T3:    l.sfeqi r0,1
+        OR1K_DELAYED(
+        OR1K_INST(l.addi  r8,r8,1),
+        OR1K_INST(l.bf    _T4)
+        )
+    
+        l.addi  r8,r8,1
+
+_T4:    l.sfeqi r0,0
+        OR1K_DELAYED(
+        OR1K_INST(l.addi  r8,r8,1),
+        OR1K_INST(l.bnf    _T5)
+        )
+
+        l.addi  r8,r8,1
+
+_T5:    l.sfeqi r0,1
+        OR1K_DELAYED(
+        OR1K_INST(l.addi  r8,r8,1),
+        OR1K_INST(l.bnf    _T6)
+        )
+ 
+        l.addi  r8,r8,1
+
+_T6:    l.movhi r3,hi(_T7)
+        l.ori  r3,r3,lo(_T7)
+        l.mtspr r0,r3,32
+        l.mfspr r5,r0,17
+        l.mtspr r0,r5,64
+        l.rfe
+        l.addi  r8,r8,1         // l.rfe should not have a delay slot
+
+        l.addi  r8,r8,1
+
+_T7:    REPORT_REG_TO_CONSOLE r8  // Should be 0x000000009
+
+        l.lwz   r9,0(r31)
+        l.add   r8,r9,r8
+        l.sw    0(r31),r8
+
+        l.lwz   r9,0(r31)
+        l.movhi r3,0x4c69
+        l.ori   r3,r3,0xe5f7
+        l.add   r8,r8,r3
+
+        REPORT_REG_TO_CONSOLE r8  // Should be 0xdeaddead
+
+
+        // Test l.movhi, on 32-bit implementations it should not sign-extend anything.
+        
+        l.movhi r3, -1
+        REPORT_REG_TO_CONSOLE r3
+
+        
+        // Test l.cmov
+        
+        LOAD_IMMEDIATE r14, 0x12345678
+        LOAD_IMMEDIATE r15, 0xABCDF0BD
+        
+        SET_SPR_SR_FLAGS  SPR_SR_F, r6, r7
+        l.cmov r10, r14, r15
+        CLEAR_SPR_SR_FLAGS SPR_SR_F, r6, r7
+        l.cmov r11, r14, r15
+
+        REPORT_REG_TO_CONSOLE r10
+        REPORT_REG_TO_CONSOLE r11
+
+        
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/div.S b/sim/testsuite/sim/or1k/div.S
new file mode 100644
index 0000000..1821e63
--- /dev/null
+++ b/sim/testsuite/sim/or1k/div.S
@@ -0,0 +1,198 @@
+/* Tests the divide instructions.
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x0000000c);\n
+# output: report(0x00000003);\n
+# output: report(0x00000004);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x0000000b);\n
+# output: report(0x00000003);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xfffffff4);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000004);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xfffffff5);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xfffffff4);\n
+# output: report(0x00000003);\n
+# output: report(0xfffffffc);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xfffffff5);\n
+# output: report(0x00000003);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x0000000c);\n
+# output: report(0xfffffffd);\n
+# output: report(0xfffffffc);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x0000000b);\n
+# output: report(0xfffffffd);\n
+# output: report(0xfffffffd);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x0000000c);\n
+# output: report(0x00000003);\n
+# output: report(0x00000004);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x0000000b);\n
+# output: report(0x00000003);\n
+# output: report(0x00000003);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xfffffff4);\n
+# output: report(0x00000003);\n
+# output: report(0x55555551);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xfffffff5);\n
+# output: report(0x00000003);\n
+# output: report(0x55555551);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+        
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+        
+
+        // Test l.div
+
+	    // Divide two positive numbers and check rounding. Should set no flags. 
+        TEST_INST_I32_I32 l.div, 0x0000000c, 0x00000003  // 12 / 3 = 4
+	    TEST_INST_I32_I32 l.div, 0x0000000b, 0x00000003  // 11 / 3 = 3
+        
+	    // Divide two negative numbers and check rounding. Should set no flags. 
+	    TEST_INST_I32_I32 l.div, 0xfffffff4, 0xfffffffd
+	    TEST_INST_I32_I32 l.div, 0xfffffff5, 0xfffffffd
+
+	    // Divide a negative number by a positive number and check rounding. Should set no flags. 
+	    TEST_INST_I32_I32 l.div, 0xfffffff4, 0x00000003
+	    TEST_INST_I32_I32 l.div, 0xfffffff5, 0x00000003
+
+	    // Divide a positive number by a negative number and check rounding. Should set no flags. 
+	    TEST_INST_I32_I32 l.div, 0x0000000c, 0xfffffffd
+	    TEST_INST_I32_I32 l.div, 0x0000000b, 0xfffffffd
+
+	    // Divide by zero. Should set the overflow flag.
+        // TODO: temporarily disabled as these tests fail on both or1ksim and or1200
+	    // TEST_INST_I32_I32 l.div, 0x0000000c, 0x00000000
+	    // TEST_INST_I32_I32 l.div, 0xfffffff4, 0x00000000
+
+        // ------ Check that range exceptions are triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+        
+	    // Divide by zero. Should set the overflow flag and trigger an exception. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+	    // TEST_INST_I32_I32 l.div, 0x0000000c, 0x00000000
+	    // TEST_INST_I32_I32 l.div, 0xfffffff4, 0x00000000
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        
+        // Test l.divu
+       
+	    // Divide two positive numbers and check rounding. Should set no flags. 
+	    TEST_INST_I32_I32 l.divu, 0x0000000c, 0x00000003
+	    TEST_INST_I32_I32 l.divu, 0x0000000b, 0x00000003
+
+	    // Divide two numbers that would be negative under 2's complement and
+	    // check rounding. Should set no flags. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+	    // TEST_INST_I32_I32 l.divu, 0xfffffff4, 0xfffffffd
+	    // TEST_INST_I32_I32 l.divu, 0xfffffff5, 0xfffffffd
+
+	    // Divide a number that would be negative under 2's complement by a
+	    // number that would be positive under 2's complement and check rounding. Should set no flags. 
+	    TEST_INST_I32_I32 l.divu, 0xfffffff4, 0x00000003
+	    TEST_INST_I32_I32 l.divu, 0xfffffff5, 0x00000003
+
+	    // Divide a number that would be positive under 2's complement by a
+	    // number that would be negative under 2's complement and check rounding. Should set no flags. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+	    // TEST_INST_I32_I32 l.divu, 0x0000000c, 0xfffffffd
+	    // TEST_INST_I32_I32 l.divu, 0x0000000b, 0xfffffffd
+
+	    // Divide by zero. Should set the overflow flag. 
+        // TODO: temporarily disabled as these tests fail on both or1ksim and or1200
+	    // TEST_INST_I32_I32 l.divu, 0x0000000c, 0x00000000
+		// TEST_INST_I32_I32 l.divu, 0xfffffff4, 0x00000000
+
+        // ------ Check that range exceptions are triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+	    // Divide by zero. Should set the overflow flag and trigger an exception. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+	    // TEST_INST_I32_I32 l.divu, 0x0000000c, 0x00000000
+	    // TEST_INST_I32_I32 l.divu, 0xfffffff4, 0x00000000
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/ext.S b/sim/testsuite/sim/or1k/ext.S
new file mode 100644
index 0000000..78d9cf2
--- /dev/null
+++ b/sim/testsuite/sim/or1k/ext.S
@@ -0,0 +1,251 @@
+/* Tests the l.ext{b,h}{s,z} instructions
+
+   Copyright (C) 2005 Gy�rgy 'nog' Jeney <nog@sdf.lonestar.org>
+     Contributor Gy�rgy 'nog' Jeney <nog@sdf.lonestar.org>
+   Copyright (C) 2010 Embecosm Limited
+     Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+   Copyright (C) 2012 R. Diez
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the Free
+   Software Foundation; either version 3 of the License, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+   more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+# mach: or1k
+# output: report(0x0000007f);\n
+# output: report(0x0000007f);\n
+# output: report(0x00000053);\n
+# output: report(0x00000053);\n
+# output: report(0x0000ff53);\n
+# output: report(0x00000053);\n
+# output: report(0x00001234);\n
+# output: report(0x00000034);\n
+# output: report(0x000000ff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000080);\n
+# output: report(0xffffff80);\n
+# output: report(0x0000ff80);\n
+# output: report(0xffffff80);\n
+# output: report(0x00007f80);\n
+# output: report(0xffffff80);\n
+# output: report(0x00007fff);\n
+# output: report(0xffffffff);\n
+# output: report(0x0000007f);\n
+# output: report(0x0000007f);\n
+# output: report(0x00000053);\n
+# output: report(0x00000053);\n
+# output: report(0x0000ff53);\n
+# output: report(0x00000053);\n
+# output: report(0x00001234);\n
+# output: report(0x00000034);\n
+# output: report(0x000000ff);\n
+# output: report(0x000000ff);\n
+# output: report(0x00000080);\n
+# output: report(0x00000080);\n
+# output: report(0x0000ff80);\n
+# output: report(0x00000080);\n
+# output: report(0x00007f80);\n
+# output: report(0x00000080);\n
+# output: report(0x00007fff);\n
+# output: report(0x000000ff);\n
+# output: report(0x00007fff);\n
+# output: report(0x00007fff);\n
+# output: report(0x00005233);\n
+# output: report(0x00005233);\n
+# output: report(0xffff2f53);\n
+# output: report(0x00002f53);\n
+# output: report(0x12345678);\n
+# output: report(0x00005678);\n
+# output: report(0x0000ffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00008000);\n
+# output: report(0xffff8000);\n
+# output: report(0x0000ff80);\n
+# output: report(0xffffff80);\n
+# output: report(0x80008000);\n
+# output: report(0xffff8000);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00007fff);\n
+# output: report(0x00007fff);\n
+# output: report(0x00005233);\n
+# output: report(0x00005233);\n
+# output: report(0xffff2f53);\n
+# output: report(0x00002f53);\n
+# output: report(0x12345678);\n
+# output: report(0x00005678);\n
+# output: report(0x0000ffff);\n
+# output: report(0x0000ffff);\n
+# output: report(0x00008000);\n
+# output: report(0x00008000);\n
+# output: report(0x0000ff80);\n
+# output: report(0x0000ff80);\n
+# output: report(0x80008000);\n
+# output: report(0x00008000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x0000ffff);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x7fff7fff);\n
+# output: report(0x7fff7fff);\n
+# output: report(0xffff7f7f);\n
+# output: report(0xffff7f7f);\n
+# output: report(0xffffff7f);\n
+# output: report(0xffffff7f);\n
+# output: report(0xffff7fff);\n
+# output: report(0xffff7fff);\n
+# output: report(0x7fff7f7f);\n
+# output: report(0x7fff7f7f);\n
+# output: report(0x12345678);\n
+# output: report(0x12345678);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x7fff7fff);\n
+# output: report(0x7fff7fff);\n
+# output: report(0xffff7f7f);\n
+# output: report(0xffff7f7f);\n
+# output: report(0xffffff7f);\n
+# output: report(0xffffff7f);\n
+# output: report(0xffff7fff);\n
+# output: report(0xffff7fff);\n
+# output: report(0x7fff7f7f);\n
+# output: report(0x7fff7f7f);\n
+# output: report(0x12345678);\n
+# output: report(0x12345678);\n
+# output: exit(0)\n
+
+#include "or1k-asm-test-env.h"
+
+.macro CHECK_EXT insn, val, mask, high_mask
+    LOAD_IMMEDIATE r4, \val
+    REPORT_REG_TO_CONSOLE r4
+    \insn   r5, r4
+    REPORT_REG_TO_CONSOLE r5
+
+    LOAD_IMMEDIATE r6, \mask
+    l.xori  r7, r6, -1
+
+    l.and   r8, r4, r6
+    l.and   r9, r5, r6
+    l.sfne  r8, r9
+    OR1K_DELAYED_NOP(l.bf    ext_fail)
+        
+    l.and   r8, r5, r7
+
+    LOAD_IMMEDIATE r7, \high_mask
+
+    l.sfne  r8, r7
+    OR1K_DELAYED_NOP(l.bf    ext_fail)
+.endm        
+
+        
+#define CHECK_HIGH3_CLEAR(insn, val) CHECK_EXT insn, val, 0x000000ff, 0
+#define CHECK_HIGH3_SET(val)         CHECK_EXT l.extbs, val, 0x000000ff, 0xffffff00
+#define CHECK_HIGH2_CLEAR(insn, val) CHECK_EXT insn, val, 0x0000ffff, 0
+#define CHECK_HIGH2_SET(val)         CHECK_EXT l.exths, val, 0x0000ffff, 0xffff0000
+
+.macro CHECK_MOVE insn, val
+        
+    LOAD_IMMEDIATE r4, \val    
+    REPORT_REG_TO_CONSOLE r4
+
+    \insn   r5, r4            
+    REPORT_REG_TO_CONSOLE r5
+        
+    l.sfne  r5, r4            
+    OR1K_DELAYED_NOP(l.bf    ext_fail)
+        
+.endm        
+
+
+        STANDARD_TEST_ENVIRONMENT
+        
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+        // Test l.extbs
+        CHECK_HIGH3_CLEAR( l.extbs, 0x7f   )
+        CHECK_HIGH3_CLEAR( l.extbs, 0x53   )
+        CHECK_HIGH3_CLEAR( l.extbs, 0xff53 )
+        CHECK_HIGH3_CLEAR( l.extbs, 0x1234 )
+
+        CHECK_HIGH3_SET(0xff)
+        CHECK_HIGH3_SET(0x80)
+        CHECK_HIGH3_SET(0xff80)
+        CHECK_HIGH3_SET(0x7f80)
+        CHECK_HIGH3_SET(0x7fff)
+
+        // Test l.extbz
+        CHECK_HIGH3_CLEAR(l.extbz, 0x7f)
+        CHECK_HIGH3_CLEAR(l.extbz, 0x53)
+        CHECK_HIGH3_CLEAR(l.extbz, 0xff53)
+        CHECK_HIGH3_CLEAR(l.extbz, 0x1234)
+
+        CHECK_HIGH3_CLEAR(l.extbz, 0xff)
+        CHECK_HIGH3_CLEAR(l.extbz, 0x80)
+        CHECK_HIGH3_CLEAR(l.extbz, 0xff80)
+        CHECK_HIGH3_CLEAR(l.extbz, 0x7f80)
+        CHECK_HIGH3_CLEAR(l.extbz, 0x7fff)
+
+        // Test l.exths
+        CHECK_HIGH2_CLEAR(l.exths, 0x7fff)
+        CHECK_HIGH2_CLEAR(l.exths, 0x5233)
+        CHECK_HIGH2_CLEAR(l.exths, 0xffff2f53)
+        CHECK_HIGH2_CLEAR(l.exths, 0x12345678)
+
+        CHECK_HIGH2_SET(0xffff)
+        CHECK_HIGH2_SET(0x8000)
+        CHECK_HIGH2_SET(0xff80)
+        CHECK_HIGH2_SET(0x80008000)
+        CHECK_HIGH2_SET(0x7fffffff)
+
+        // Test l.exthz
+        CHECK_HIGH2_CLEAR(l.exthz, 0x7fff)
+        CHECK_HIGH2_CLEAR(l.exthz, 0x5233)
+        CHECK_HIGH2_CLEAR(l.exthz, 0xffff2f53)
+        CHECK_HIGH2_CLEAR(l.exthz, 0x12345678)
+
+        CHECK_HIGH2_CLEAR(l.exthz, 0xffff)
+        CHECK_HIGH2_CLEAR(l.exthz, 0x8000)
+        CHECK_HIGH2_CLEAR(l.exthz, 0xff80)
+        CHECK_HIGH2_CLEAR(l.exthz, 0x80008000)
+        CHECK_HIGH2_CLEAR(l.exthz, 0x7fffffff)
+
+        // Test l.extws
+        CHECK_MOVE l.extws, 0xffffffff
+        CHECK_MOVE l.extws, 0x7fffffff
+        CHECK_MOVE l.extws, 0x7fff7fff
+        CHECK_MOVE l.extws, 0xffff7f7f
+        CHECK_MOVE l.extws, 0xffffff7f
+        CHECK_MOVE l.extws, 0xffff7fff
+        CHECK_MOVE l.extws, 0x7fff7f7f
+        CHECK_MOVE l.extws, 0x12345678
+
+        // Test l.extwz
+        CHECK_MOVE l.extwz, 0xffffffff
+        CHECK_MOVE l.extwz, 0x7fffffff
+        CHECK_MOVE l.extwz, 0x7fff7fff
+        CHECK_MOVE l.extwz, 0xffff7f7f
+        CHECK_MOVE l.extwz, 0xffffff7f
+        CHECK_MOVE l.extwz, 0xffff7fff
+        CHECK_MOVE l.extwz, 0x7fff7f7f
+        CHECK_MOVE l.extwz, 0x12345678
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
+        
+ext_fail:
+        EXIT_SIMULATION_WITH_IMMEDIATE_EXIT_CODE SEC_GENERIC_ERROR
diff --git a/sim/testsuite/sim/or1k/find.S b/sim/testsuite/sim/or1k/find.S
new file mode 100644
index 0000000..6c52721
--- /dev/null
+++ b/sim/testsuite/sim/or1k/find.S
@@ -0,0 +1,119 @@
+/* Tests the find instructions.
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000001);\n
+# output: report(0x00000001);\n
+# output: \n
+# output: report(0x80000000);\n
+# output: report(0x00000020);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00000001);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000002);\n
+# output: \n
+# output: report(0x00018000);\n
+# output: report(0x00000010);\n
+# output: \n
+# output: report(0xc0000000);\n
+# output: report(0x0000001f);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000001);\n
+# output: report(0x00000001);\n
+# output: \n
+# output: report(0x80000000);\n
+# output: report(0x00000020);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x0000001f);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000020);\n
+# output: \n
+# output: report(0x00018000);\n
+# output: report(0x00000011);\n
+# output: \n
+# output: report(0xc0000000);\n
+# output: report(0x00000020);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+.macro TEST_FIND opcode, operand
+        
+    LOAD_IMMEDIATE r5, \operand
+
+    REPORT_REG_TO_CONSOLE r5
+
+    \opcode r4, r5
+
+    REPORT_REG_TO_CONSOLE r4
+
+    PRINT_NEWLINE_TO_CONSOLE        
+
+.endm
+        
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+        // Test l.ff1
+        
+ 	    TEST_FIND l.ff1, 0x00000001
+	    TEST_FIND l.ff1, 0x80000000
+	    TEST_FIND l.ff1, 0x55555555
+	    TEST_FIND l.ff1, 0xaaaaaaaa
+	    TEST_FIND l.ff1, 0x00018000
+	    TEST_FIND l.ff1, 0xc0000000
+	    TEST_FIND l.ff1, 0x00000000
+        
+
+        // Test l.fl1
+         
+	    TEST_FIND l.fl1, 0x00000001
+	    TEST_FIND l.fl1, 0x80000000
+	    TEST_FIND l.fl1, 0x55555555
+	    TEST_FIND l.fl1, 0xaaaaaaaa
+	    TEST_FIND l.fl1, 0x00018000
+	    TEST_FIND l.fl1, 0xc0000000
+	    TEST_FIND l.fl1, 0x00000000
+
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/flag.S b/sim/testsuite/sim/or1k/flag.S
new file mode 100644
index 0000000..c8edbe7
--- /dev/null
+++ b/sim/testsuite/sim/or1k/flag.S
@@ -0,0 +1,405 @@
+/* Tests the l.sf* instructions
+ *
+ * Copyright (C) Julius Baxter, ORSoC AB, <julius.baxter@orsoc.se>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+        
+#define INT_MAX          2147483647  // 0x7fffffff
+#define INT_MAX_MIN1     2147483646  // 0x7ffffffe
+#define NEG_INT_MAX     -2147483648  // 0x80000000
+#define NEG_INT_MAX_PL1 -2147483647  // 0x80000001
+#define MIN1            -1           // 0xffffffff
+
+#define SHRT_MIN    (-32768)
+#define SHRT_MAX    32767
+        
+#define UINT_MAX      4294967295  // 0xffffffff
+#define UINT_MAX_MIN1 4294967294  // 0xfffffffe
+
+#define USHRT_MAX      65535
+        
+
+.macro MOVE_TO_R4_R5_AND_REPORT a, b
+
+    LOAD_IMMEDIATE r4, \a
+    LOAD_IMMEDIATE r5, \b
+
+    // During development, add REPORT_xxx statements here to see the operands.
+
+.endm
+
+.macro MOVE_TO_R4_AND_REPORT_I a, b
+        
+    LOAD_IMMEDIATE r4, \a
+
+    // During development, add REPORT_xxx statements here to see the operands.
+        
+.endm
+
+
+.macro SHOULD_BE_SET
+    OR1K_DELAYED_NOP(l.bnf  failed)
+.endm
+        
+.macro SHOULDNT_BE_SET
+    OR1K_DELAYED_NOP(l.bf    failed)
+.endm
+
+
+.macro SHOULD_BE_LESS_THAN_SIGNED a, b
+    MOVE_TO_R4_R5_AND_REPORT \a , \b
+
+    l.sfeq  r4, r5
+    SHOULDNT_BE_SET
+    l.sfne  r4, r5
+    SHOULD_BE_SET
+    l.sfgts r4, r5
+    SHOULDNT_BE_SET
+    l.sfges r4, r5
+    SHOULDNT_BE_SET
+    l.sfles r4, r5
+    SHOULD_BE_SET
+    l.sflts r4, r5
+    SHOULD_BE_SET
+.endm
+
+.macro SHOULD_BE_GREATER_THAN_SIGNED a, b
+    MOVE_TO_R4_R5_AND_REPORT \a , \b
+        
+    l.sfeq  r4, r5
+    SHOULDNT_BE_SET
+    l.sfne  r4, r5
+    SHOULD_BE_SET
+    l.sfgts r4, r5
+    SHOULD_BE_SET
+    l.sfges r4, r5
+    SHOULD_BE_SET
+    l.sfles r4, r5
+    SHOULDNT_BE_SET
+    l.sflts r4, r5
+    SHOULDNT_BE_SET
+.endm
+    
+.macro SHOULD_BE_LESS_THAN_UNSIGNED a, b
+    MOVE_TO_R4_R5_AND_REPORT \a , \b
+        
+    l.sfeq  r4, r5
+    SHOULDNT_BE_SET
+    l.sfne  r4, r5
+    SHOULD_BE_SET 
+    l.sfgtu r4, r5
+    SHOULDNT_BE_SET
+    l.sfgeu r4, r5
+    SHOULDNT_BE_SET
+    l.sfleu r4, r5
+    SHOULD_BE_SET
+    l.sfltu r4, r5
+    SHOULD_BE_SET
+.endm
+
+.macro SHOULD_BE_GREATER_THAN_UNSIGNED a, b
+    MOVE_TO_R4_R5_AND_REPORT \a , \b
+
+    l.sfeq  r4, r5
+    SHOULDNT_BE_SET
+    l.sfne  r4, r5
+    SHOULD_BE_SET
+    l.sfgtu r4, r5
+    SHOULD_BE_SET
+    l.sfgeu r4, r5
+    SHOULD_BE_SET
+    l.sfleu r4, r5
+    SHOULDNT_BE_SET
+    l.sfltu r4, r5
+    SHOULDNT_BE_SET
+.endm
+
+
+.macro SHOULD_BE_EQUAL a, b
+    MOVE_TO_R4_R5_AND_REPORT \a , \b
+        
+    l.sfeq  r4, r5
+    SHOULD_BE_SET
+    l.sfne  r4, r5
+    SHOULDNT_BE_SET
+
+    // Signed tests.        
+    l.sfgts r4, r5
+    SHOULDNT_BE_SET
+    l.sfges r4, r5
+    SHOULD_BE_SET
+    l.sfles r4, r5
+    SHOULD_BE_SET
+    l.sflts r4, r5
+    SHOULDNT_BE_SET
+        
+    // Unsigned tests.
+    l.sfgtu r4, r5
+    SHOULDNT_BE_SET
+    l.sfgeu r4, r5
+    SHOULD_BE_SET
+    l.sfleu r4, r5
+    SHOULD_BE_SET
+    l.sfltu r4, r5
+    SHOULDNT_BE_SET
+
+.endm
+
+.macro SHOULDNT_BE_EQUAL a, b
+    MOVE_TO_R4_R5_AND_REPORT \a , \b
+        
+    l.sfeq  r4, r5
+    SHOULDNT_BE_SET
+    l.sfne  r4, r5
+    SHOULD_BE_SET
+
+.endm
+        
+.macro SHOULD_BE_EQUAL_I a, b
+
+    MOVE_TO_R4_AND_REPORT_I \a, \b
+        
+    l.sfeqi  r4, \b
+    SHOULD_BE_SET
+    l.sfnei  r4, \b
+    SHOULDNT_BE_SET
+
+    // Signed tests.        
+    l.sfgtsi r4, \b
+    SHOULDNT_BE_SET
+    l.sfgesi r4, \b
+    SHOULD_BE_SET
+    l.sflesi r4, \b
+    SHOULD_BE_SET
+    l.sfltsi r4, \b
+    SHOULDNT_BE_SET
+        
+    // Unsigned tests.
+    l.sfgtui r4, \b
+    SHOULDNT_BE_SET
+    l.sfgeui r4, \b
+    SHOULD_BE_SET
+    l.sfleui r4, \b
+    SHOULD_BE_SET
+    l.sfltui r4, \b
+    SHOULDNT_BE_SET
+
+.endm
+
+.macro SHOULDNT_BE_EQUAL_I a, b
+
+    MOVE_TO_R4_AND_REPORT_I \a, \b
+
+    l.sfeqi  r4, \b
+    SHOULDNT_BE_SET
+    l.sfnei  r4, \b
+    SHOULD_BE_SET
+        
+.endm
+
+
+.macro SHOULD_BE_LESS_THAN_SIGNED_I a, b
+
+    MOVE_TO_R4_AND_REPORT_I \a, \b
+        
+    l.sfeqi  r4, \b
+    SHOULDNT_BE_SET
+    l.sfnei  r4, \b
+    SHOULD_BE_SET
+    l.sfgtsi r4, \b
+    SHOULDNT_BE_SET
+    l.sfgesi r4, \b
+    SHOULDNT_BE_SET
+    l.sflesi r4, \b
+    SHOULD_BE_SET
+    l.sfltsi r4, \b
+    SHOULD_BE_SET
+.endm
+
+.macro SHOULD_BE_GREATER_THAN_SIGNED_I a, b
+
+    MOVE_TO_R4_AND_REPORT_I \a, \b
+        
+    l.sfeqi  r4, \b
+    SHOULDNT_BE_SET
+    l.sfnei  r4, \b
+    SHOULD_BE_SET
+    l.sfgtsi r4, \b
+    SHOULD_BE_SET
+    l.sfgesi r4, \b
+    SHOULD_BE_SET
+    l.sflesi r4, \b
+    SHOULDNT_BE_SET
+    l.sfltsi r4, \b
+    SHOULDNT_BE_SET
+.endm
+
+        
+.macro SHOULD_BE_LESS_THAN_UNSIGNED_I a, b
+    MOVE_TO_R4_AND_REPORT_I \a, \b
+        
+    l.sfeqi  r4, \b
+    SHOULDNT_BE_SET
+    l.sfnei  r4, \b
+    SHOULD_BE_SET 
+    l.sfgtui r4, \b
+    SHOULDNT_BE_SET
+    l.sfgeui r4, \b
+    SHOULDNT_BE_SET
+    l.sfleui r4, \b
+    SHOULD_BE_SET
+    l.sfltui r4, \b
+    SHOULD_BE_SET
+.endm
+
+.macro SHOULD_BE_GREATER_THAN_UNSIGNED_I a, b
+    MOVE_TO_R4_AND_REPORT_I \a, \b
+
+    l.sfeqi  r4, \b
+    SHOULDNT_BE_SET
+    l.sfnei  r4, \b
+    SHOULD_BE_SET
+    l.sfgtui r4, \b
+    SHOULD_BE_SET
+    l.sfgeui r4, \b
+    SHOULD_BE_SET
+    l.sfleui r4, \b
+    SHOULDNT_BE_SET
+    l.sfltui r4, \b
+    SHOULDNT_BE_SET
+.endm
+
+        
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+        // Signed tests
+        
+        SHOULD_BE_LESS_THAN_SIGNED 0, 1
+        SHOULD_BE_LESS_THAN_SIGNED MIN1, 0
+        SHOULD_BE_LESS_THAN_SIGNED INT_MAX_MIN1, INT_MAX
+        SHOULD_BE_LESS_THAN_SIGNED NEG_INT_MAX, INT_MAX
+        SHOULD_BE_LESS_THAN_SIGNED NEG_INT_MAX, INT_MAX_MIN1
+        SHOULD_BE_LESS_THAN_SIGNED NEG_INT_MAX_PL1, INT_MAX
+        SHOULD_BE_LESS_THAN_SIGNED NEG_INT_MAX_PL1, INT_MAX_MIN1
+        SHOULD_BE_LESS_THAN_SIGNED -7, -6
+        SHOULD_BE_LESS_THAN_SIGNED NEG_INT_MAX, NEG_INT_MAX_PL1
+        SHOULD_BE_LESS_THAN_SIGNED NEG_INT_MAX, MIN1
+        SHOULD_BE_LESS_THAN_SIGNED NEG_INT_MAX, 0
+    
+        SHOULD_BE_GREATER_THAN_SIGNED 1, 0
+        SHOULD_BE_GREATER_THAN_SIGNED 0, MIN1
+        SHOULD_BE_GREATER_THAN_SIGNED INT_MAX, INT_MAX_MIN1
+        SHOULD_BE_GREATER_THAN_SIGNED INT_MAX, NEG_INT_MAX
+        SHOULD_BE_GREATER_THAN_SIGNED INT_MAX_MIN1, NEG_INT_MAX
+        SHOULD_BE_GREATER_THAN_SIGNED INT_MAX, NEG_INT_MAX_PL1
+        SHOULD_BE_GREATER_THAN_SIGNED INT_MAX_MIN1, NEG_INT_MAX_PL1
+        SHOULD_BE_GREATER_THAN_SIGNED -6, -7
+        SHOULD_BE_GREATER_THAN_SIGNED NEG_INT_MAX_PL1, NEG_INT_MAX
+        SHOULD_BE_GREATER_THAN_SIGNED MIN1, NEG_INT_MAX
+        SHOULD_BE_GREATER_THAN_SIGNED 0, NEG_INT_MAX
+
+        SHOULD_BE_LESS_THAN_SIGNED    0xFFFF7FFF, 0xFFFF8000  // See the immediate tests below.
+        SHOULD_BE_GREATER_THAN_SIGNED 0xFFFF8001, 0xFFFF8000  // See the immediate tests below.
+
+        
+        // Signed tests, immediate
+        
+        SHOULD_BE_LESS_THAN_SIGNED_I   0,  1
+        SHOULD_BE_LESS_THAN_SIGNED_I  -1,  0
+        SHOULD_BE_LESS_THAN_SIGNED_I  -7, -6
+        
+        SHOULD_BE_GREATER_THAN_SIGNED_I 0x00008000, 0x7FFF
+        SHOULD_BE_LESS_THAN_SIGNED_I    0xFFFFFFFF, 0x7FFF
+        SHOULD_BE_LESS_THAN_SIGNED_I    0xFFFF7FFF, 0x8000  // 0x8000 gets sign-extended to 0xFFFF8000.
+        SHOULD_BE_GREATER_THAN_SIGNED_I 0xFFFF8001, 0x8000  // 0x8000 gets sign-extended to 0xFFFF8000.
+        SHOULD_BE_GREATER_THAN_SIGNED_I 0x00008000, 0x8000  // 0x8000 gets sign-extended to 0xFFFF8000.
+
+        
+        // Unsigned tests
+        
+        SHOULD_BE_LESS_THAN_UNSIGNED 0, 1
+        SHOULD_BE_LESS_THAN_UNSIGNED UINT_MAX_MIN1, UINT_MAX
+        SHOULD_BE_GREATER_THAN_UNSIGNED 1, 0
+        SHOULD_BE_GREATER_THAN_UNSIGNED UINT_MAX, UINT_MAX_MIN1
+        SHOULD_BE_GREATER_THAN_UNSIGNED UINT_MAX, 0
+        SHOULD_BE_GREATER_THAN_UNSIGNED 0x80000001,  0x80000000
+        SHOULD_BE_LESS_THAN_UNSIGNED 0x80000000,  0x80000001
+        SHOULD_BE_GREATER_THAN_UNSIGNED 0x80000000, 0x7fffffff
+        SHOULD_BE_LESS_THAN_UNSIGNED 0x7fffffff,  0x80000000
+        SHOULD_BE_GREATER_THAN_UNSIGNED 0x7fffffff,  0x7ffffffe
+        SHOULD_BE_LESS_THAN_UNSIGNED 0x7ffffffe,  0x7fffffff
+        SHOULD_BE_LESS_THAN_UNSIGNED 0x2024fae0,  0xfef03220
+
+        
+        // Unsigned tests, immediate
+        
+        SHOULD_BE_LESS_THAN_UNSIGNED_I 0, 1
+        SHOULD_BE_GREATER_THAN_UNSIGNED_I 1, 0
+        SHOULD_BE_LESS_THAN_UNSIGNED_I    SHRT_MAX - 1, SHRT_MAX
+        SHOULD_BE_GREATER_THAN_UNSIGNED_I SHRT_MAX    , SHRT_MAX - 1
+
+        // The sign extension produces unexpected results here.
+        SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFFFFFF - 1, 0xFFFF  // 0xFFFF gets sign-extended to 0xFFFFFFFF.
+        SHOULD_BE_LESS_THAN_UNSIGNED_I 0xFFFF7FFF    , 0x8000  // 0x8000 gets sign-extended to 0xFFFF8000.
+        
+        
+        // Equal tests.
+        
+        SHOULD_BE_EQUAL 0, 0
+        SHOULD_BE_EQUAL UINT_MAX, UINT_MAX
+        SHOULD_BE_EQUAL MIN1, UINT_MAX
+        SHOULD_BE_EQUAL INT_MAX, INT_MAX
+        SHOULD_BE_EQUAL NEG_INT_MAX, NEG_INT_MAX
+
+        
+        // Equal tests, immediate. Test the 16-to-32-bit sign extension.
+        
+        SHOULD_BE_EQUAL_I 0, 0
+        SHOULD_BE_EQUAL_I 0x00007FFF, 0x7FFF
+        SHOULD_BE_EQUAL_I 0xFFFF8000, 0x8000
+        SHOULD_BE_EQUAL_I 0xFFFFFFFF, 0xFFFF
+
+
+        // Non-equal tests.
+        
+        SHOULDNT_BE_EQUAL 0, 1
+        SHOULDNT_BE_EQUAL UINT_MAX, INT_MAX
+        SHOULDNT_BE_EQUAL UINT_MAX, NEG_INT_MAX
+        SHOULDNT_BE_EQUAL MIN1, NEG_INT_MAX_PL1
+        SHOULDNT_BE_EQUAL INT_MAX, NEG_INT_MAX
+        SHOULDNT_BE_EQUAL NEG_INT_MAX_PL1, UINT_MAX_MIN1
+
+
+        // Non-equal tests, immediate. Test the 16-to-32-bit sign extension.
+        
+        SHOULDNT_BE_EQUAL_I 0x00008000, 0x8000
+        
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
+
+failed:
+        EXIT_SIMULATION_WITH_IMMEDIATE_EXIT_CODE SEC_GENERIC_ERROR
diff --git a/sim/testsuite/sim/or1k/jump.S b/sim/testsuite/sim/or1k/jump.S
new file mode 100644
index 0000000..63b1acc
--- /dev/null
+++ b/sim/testsuite/sim/or1k/jump.S
@@ -0,0 +1,121 @@
+/* Tests the jump instructions
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x48000000);\n
+# output: report(0x00000005);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x44000000);\n
+# output: report(0x00000005);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+/* ----------------------------------------------------------------------------
+ * Tests a jump instruction using a register destination.
+ * Checks whether the jump succeeds, or whether an exception is triggered (but not if the right exception was triggered yet).
+ *
+ * We manually construct the opcode, to allow us to force R9 into the
+ * destination field, to test exception handling. Usually the assembler would
+ * prevent this.
+ *
+ * Do not specify R31 as the register to use for the jump, as it's used internally.
+ * ------------------------------------------------------------------------- */
+
+.macro TEST_JUMP  opcode_value  dest_register_number  alignment_offset
+
+        REPORT_IMMEDIATE_TO_CONSOLE \opcode_value
+        REPORT_IMMEDIATE_TO_CONSOLE \dest_register_number
+        REPORT_IMMEDIATE_TO_CONSOLE \alignment_offset
+
+        LOAD_IMMEDIATE r\dest_register_number, 51f + \alignment_offset
+
+        // Clear the last exception address. Not really necessary.
+        MOVE_TO_SPR  SPR_EPCR_BASE, ZERO_R0
+
+        // Generate the jump opcode.
+    50: OR1K_DELAYED_NOP(.word  ( \opcode_value | (\dest_register_number << 11) ))
+
+        // If the jump failed, we land here.
+        REPORT_IMMEDIATE_TO_CONSOLE 1
+
+        OR1K_DELAYED_NOP(l.j 52f)
+
+        // If the jump succeeds, we land here.
+    51: REPORT_IMMEDIATE_TO_CONSOLE 0
+        
+    52:
+
+.endm
+        
+
+        STANDARD_TEST_ENVIRONMENT
+
+
+        .section .exception_vectors
+        
+        // Alignment exception.
+	    .org	0x600
+        // TODO: We need to patch the instruction here before returning, or we need to return
+        //       to the next instruction. But beware that the or1200 implementation does not behave like the or1ksim simulator.
+	    l.rfe
+        
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+        
+
+        // Test l.jalr (jump and link register)
+
+        TEST_JUMP 0x48000000, 5, 0
+        // TODO: some tests disabled, further work is needed
+        // TEST_JUMP 0x48000000, 5, 1
+        // TEST_JUMP 0x48000000, 5, 2
+        // TEST_JUMP 0x48000000, 5, 3
+        
+        // Test with link register as the destination
+        // TODO: disabled, need to add support for the ILLEGAL INSTRUCTION exception:
+        // TEST_JUMP (0x48000000, 9, 0)
+        
+
+        // Test l.jr (jump register)
+        
+        TEST_JUMP 0x44000000, 5, 0
+        // TODO: some tests disabled, further work is needed
+        // TEST_JUMP 0x44000000, 5, 1
+        // TEST_JUMP 0x44000000, 5, 2
+        // TEST_JUMP 0x44000000, 5, 3
+
+        // Test with link register as the destination (OK here)
+        // TODO: disabled, need to add support for the ILLEGAL INSTRUCTION exception:
+        // TEST_JUMP 0x44000000, 9, 0
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/load.S b/sim/testsuite/sim/or1k/load.S
new file mode 100644
index 0000000..6818ca7
--- /dev/null
+++ b/sim/testsuite/sim/or1k/load.S
@@ -0,0 +1,373 @@
+/* Tests the load and store instructions.
+ *
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0xdeadbeef);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x80000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x80000000);\n
+# output: report(0xffffffff);\n
+# output: report(0xdeadbeef);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x000000de);\n
+# output: report(0x000000ad);\n
+# output: report(0x000000be);\n
+# output: report(0x000000ef);\n
+# output: report(0x000000ef);\n
+# output: report(0x000000be);\n
+# output: report(0x000000ad);\n
+# output: report(0x000000de);\n
+# output: report(0xffffffde);\n
+# output: report(0xffffffad);\n
+# output: report(0xffffffbe);\n
+# output: report(0xffffffef);\n
+# output: report(0xffffffef);\n
+# output: report(0xffffffbe);\n
+# output: report(0xffffffad);\n
+# output: report(0xffffffde);\n
+# output: report(0x0000dead);\n
+# output: report(0x0000beef);\n
+# output: report(0x0000beef);\n
+# output: report(0x0000dead);\n
+# output: report(0xffffdead);\n
+# output: report(0xffffbeef);\n
+# output: report(0xffffbeef);\n
+# output: report(0xffffdead);\n
+# output: report(0xa1a2a3a4);\n
+# output: report(0xb4b3b2b1);\n
+# output: report(0x81828384);\n
+# output: report(0x53545152);\n
+# output: report(0xa0b0c0d0);\n
+# output: report(0xa1b1c1d1);\n
+# output: report(0xa3b3c3d3);\n
+# output: report(0xa2b2c2d2);\n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+.macro TEST_LW  opcode, label, offset
+   
+    LOAD_IMMEDIATE r5, \label
+        
+    \opcode  r4, \offset(r5)
+
+    REPORT_REG_TO_CONSOLE r4
+        
+.endm
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .rodata
+        .balign 4
+        
+50:     .word   0xdeadbeef
+51:     .word   0x00000000
+52:     .word   0x7fffffff
+53:     .word   0x80000000
+54:     .word   0xffffffff
+
+        
+        .section .data
+        .balign 4
+        
+buffer1:  .word 0x00000000
+buffer2:  .word 0x00000000
+buffer3:  .word 0x00000000
+buffer4:  .word 0x00000000
+buffer5:
+
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+        // Test instruction l.lws
+        /* TODO: The instruction l.lws is not implemeted yet in or1200, search for "l.lws support patch" in the mailing list.
+                 Note that this instruction is redundant, as l.lwz does exactly the same.
+
+        // Load with zero offset
+        TEST_LW l.lws 50b, 0
+        TEST_LW l.lws 51b, 0
+        TEST_LW l.lws 52b, 0
+        TEST_LW l.lws 53b, 0
+        TEST_LW l.lws 54b, 0
+
+        // Load with positive offset
+        TEST_LW l.lws 50b,  4
+        TEST_LW l.lws 50b,  8
+        TEST_LW l.lws 50b, 12
+        TEST_LW l.lws 50b, 16
+
+        // Load with negative offset
+        TEST_LW l.lws 54b, -16
+        TEST_LW l.lws 54b, -12
+        TEST_LW l.lws 54b,  -8
+        TEST_LW l.lws 54b,  -4
+
+        add here test cases to cover unaligned memory accesses with l.lws
+        */
+
+
+        // ---------- Test instruction l.lwz ----------
+        // Same tests as above. The instruction l.lwz does the same as l.lws (it is a redundant instruction).
+
+        // Load with zero offset
+        TEST_LW l.lwz 50b, 0
+        TEST_LW l.lwz 51b, 0
+        TEST_LW l.lwz 52b, 0
+        TEST_LW l.lwz 53b, 0
+        TEST_LW l.lwz 54b, 0
+
+        // Load with positive offset
+        TEST_LW l.lwz 50b,  4
+        TEST_LW l.lwz 50b,  8
+        TEST_LW l.lwz 50b, 12
+        TEST_LW l.lwz 50b, 16
+
+        // Load with negative offset
+        TEST_LW l.lwz 54b, -16
+        TEST_LW l.lwz 54b, -12
+        TEST_LW l.lwz 54b,  -8
+        TEST_LW l.lwz 54b,  -4
+        
+        // TODO: add here test cases to cover unaligned memory accesses with l.lwz
+
+        // ---------- Test instruction l.lbz ----------
+        
+        // Read data at label 50, forwards, byte by byte.
+        LOAD_IMMEDIATE r5, 50b
+
+        l.lbz r4, 0(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lbz r4, 1(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lbz r4, 2(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lbz r4, 3(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        
+        // Read data at label 50, backwards, byte by byte.
+        LOAD_IMMEDIATE r31, 51b
+
+        l.lbz r3, -1(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lbz r3, -2(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lbz r3, -3(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lbz r3, -4(r31)
+        REPORT_REG_TO_CONSOLE r3
+        
+
+        // ---------- Test instruction l.lbs ----------
+
+        // Read data at label 50, forwards, byte by byte.
+        LOAD_IMMEDIATE r5, 50b
+
+        l.lbs r4, 0(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lbs r4, 1(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lbs r4, 2(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lbs r4, 3(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        
+        // Read data at label 50, backwards, byte by byte.
+        LOAD_IMMEDIATE r31, 51b
+
+        l.lbs r3, -1(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lbs r3, -2(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lbs r3, -3(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lbs r3, -4(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+
+        // ---------- Test instruction l.lhz ----------
+
+        // Read data at label 50, forwards, half-word by half-word.
+        LOAD_IMMEDIATE r5, 50b
+
+        l.lhz r4, 0(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lhz r4, 2(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        
+        // Read data at label 50, backwards, half-word by half-word.
+        LOAD_IMMEDIATE r31, 51b
+
+        l.lhz r3, -2(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lhz r3, -4(r31)
+        REPORT_REG_TO_CONSOLE r3
+        
+        // TODO: add here test cases to cover unaligned memory accesses with l.lhz
+
+        
+        // ---------- Test instruction l.lhs ----------
+
+        // Read data at label 50, forwards, half-word by half-word.
+        LOAD_IMMEDIATE r5, 50b
+
+        l.lhs r4, 0(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        l.lhs r4, 2(r5)
+        REPORT_REG_TO_CONSOLE r4
+
+        
+        // Read data at label 50, backwards, half-word by half-word.
+        LOAD_IMMEDIATE r31, 51b
+
+        l.lhs r3, -2(r31)
+        REPORT_REG_TO_CONSOLE r3
+
+        l.lhs r3, -4(r31)
+        REPORT_REG_TO_CONSOLE r3
+        
+        // TODO: add here test cases to cover unaligned memory accesses with l.lhs
+
+
+        // ---------- Test instruction l.sb ----------
+
+        // Write 32-bits forwards, byte-to-byte.
+        
+        LOAD_IMMEDIATE r5, buffer1
+
+        LOAD_IMMEDIATE r10, 0xA1
+        LOAD_IMMEDIATE r11, 0xA2
+        LOAD_IMMEDIATE r12, 0xA3
+        LOAD_IMMEDIATE r13, 0xA4
+
+        l.sb 0(r5), r10
+        l.sb 1(r5), r11
+        l.sb 2(r5), r12
+        l.sb 3(r5), r13
+
+        l.lwz r3, 0(r5)
+        REPORT_REG_TO_CONSOLE r3
+
+        // Write 32-bits backwards, byte-to-byte.
+        
+        LOAD_IMMEDIATE r6, buffer2
+
+        LOAD_IMMEDIATE r10, 0xB1
+        LOAD_IMMEDIATE r11, 0xB2
+        LOAD_IMMEDIATE r12, 0xB3
+        LOAD_IMMEDIATE r13, 0xB4
+
+        l.sb -1(r6), r10
+        l.sb -2(r6), r11
+        l.sb -3(r6), r12
+        l.sb -4(r6), r13
+
+        l.lwz r3, 0(r5)
+        REPORT_REG_TO_CONSOLE r3
+        
+        // TODO: add here test cases to cover unaligned memory accesses with l.sb
+
+        
+        // ---------- Test instruction l.sh ----------
+
+        // Write 32-bits forwards, one half-word at a time.
+        
+        LOAD_IMMEDIATE r5, buffer1
+
+        LOAD_IMMEDIATE r10, 0x8182
+        LOAD_IMMEDIATE r11, 0x8384
+
+        l.sh 0(r5), r10
+        l.sh 2(r5), r11
+
+        l.lwz r3, 0(r5)
+        REPORT_REG_TO_CONSOLE r3
+
+        
+        // Write 32-bits backwards, one half-word at a time.
+        
+        LOAD_IMMEDIATE r6, buffer2
+
+        LOAD_IMMEDIATE r10, 0x5152
+        LOAD_IMMEDIATE r11, 0x5354
+
+        l.sh -2(r6), r10
+        l.sh -4(r6), r11
+
+        l.lwz r3, 0(r5)
+        REPORT_REG_TO_CONSOLE r3
+        
+        // TODO: add here test cases to cover unaligned memory accesses with l.sh
+
+        
+        // ---------- Test instruction l.sw ----------
+
+        LOAD_IMMEDIATE r5, buffer1
+        LOAD_IMMEDIATE r6, buffer5
+
+        LOAD_IMMEDIATE r10, 0xA0B0C0D0
+        LOAD_IMMEDIATE r11, 0xA1B1C1D1
+        LOAD_IMMEDIATE r12, 0xA2B2C2D2
+        LOAD_IMMEDIATE r13, 0xA3B3C3D3
+        
+        l.sw  0(r5), r10
+        l.sw  4(r5), r11
+        l.sw -4(r6), r12
+        l.sw -8(r6), r13
+
+        TEST_LW l.lwz buffer1, 0
+        TEST_LW l.lwz buffer2, 0
+        TEST_LW l.lwz buffer3, 0
+        TEST_LW l.lwz buffer4, 0
+
+        // TODO: add here test cases to cover unaligned memory accesses with l.sw
+        
+        
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/mac.S b/sim/testsuite/sim/or1k/mac.S
new file mode 100644
index 0000000..08e0ebb
--- /dev/null
+++ b/sim/testsuite/sim/or1k/mac.S
@@ -0,0 +1,785 @@
+/* Tests the MAC instructions.
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x0000000c);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x40000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000006);\n
+# output: report(0x80000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x7ffffffe);\n
+# output: report(0x00000000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x7ffffffd);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x0000000c);\n
+# output: report(0x00000000);\n
+# output: report(0x00000005);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0xfffffff9);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffff9);\n
+# output: report(0xfffffffe);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000006);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0xfffffffe);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x0000000c);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x40000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000006);\n
+# output: report(0x80000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x7ffffffe);\n
+# output: report(0x00000000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x7ffffffd);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x0000000c);\n
+# output: report(0x00000000);\n
+# output: report(0x00000005);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0xfffffff9);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffff9);\n
+# output: report(0xfffffffe);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000006);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0xfffffffe);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x0000000c);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000006);\n
+# output: report(0x7ffffffe);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x7ffffffd);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x0000000c);\n
+# output: report(0x00000005);\n
+# output: report(0xfffffffa);\n
+# output: report(0x00000006);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffff9);\n
+# output: report(0xfffffff9);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x80000000);\n
+# output: report(0x80000006);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0xfffffffa);\n
+# output: report(0x3fffffff);\n
+# output: report(0xfffffffa);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffff4);\n
+# output: report(0xfffffffe);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000002);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000004);\n
+# output: report(0x00000000);\n
+# output: report(0x00000004);\n
+# output: report(0x7ffffffe);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000001);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000004);\n
+# output: report(0xfffffffe);\n
+# output: report(0x00000004);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0xffffffff);\n
+# output: report(0xfffffff9);\n
+# output: report(0x00000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x0000000c);\n
+# output: report(0x00000001);\n
+# output: report(0x00000005);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000005);\n
+# output: report(0x80000000);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x80000006);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x7fffffff);\n
+# output: report(0x80000000);\n
+# output: report(0x80000000);\n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+.macro TEST_MACRC mac_hi, mac_lo, op1, op2
+
+    LOAD_IMMEDIATE r2, \mac_hi
+    MOVE_TO_SPR SPR_MACHI, r2
+        
+    LOAD_IMMEDIATE r2, \mac_lo
+    MOVE_TO_SPR SPR_MACLO, r2
+        
+    LOAD_IMMEDIATE r5, \op1
+    LOAD_IMMEDIATE r6, \op2
+
+    l.mac   r5, r6
+    l.macrc r3
+        
+    REPORT_REG_TO_CONSOLE r3
+
+.endm
+
+    
+.macro TEST_MAC mac_hi, mac_lo, op1, op2
+
+    LOAD_IMMEDIATE r2, \mac_hi
+    MOVE_TO_SPR SPR_MACHI, r2
+        
+    LOAD_IMMEDIATE r2, \mac_lo
+    MOVE_TO_SPR SPR_MACLO, r2
+        
+    LOAD_IMMEDIATE r5, \op1
+    LOAD_IMMEDIATE r6, \op2
+
+    l.mac r5, r6
+        
+    MOVE_FROM_SPR r3, SPR_MACHI
+    REPORT_REG_TO_CONSOLE r3
+        
+    MOVE_FROM_SPR r3, SPR_MACLO
+    REPORT_REG_TO_CONSOLE r3
+
+.endm
+
+
+.macro TEST_MACI mac_hi, mac_lo, op1, op2_immediate
+
+    LOAD_IMMEDIATE r2, \mac_hi
+    MOVE_TO_SPR SPR_MACHI, r2
+        
+    LOAD_IMMEDIATE r2, \mac_lo
+    MOVE_TO_SPR SPR_MACLO, r2
+        
+    LOAD_IMMEDIATE r5, \op1
+
+    l.maci r5, \op2_immediate
+        
+    MOVE_FROM_SPR r3, SPR_MACHI
+    REPORT_REG_TO_CONSOLE r3
+        
+    MOVE_FROM_SPR r3, SPR_MACLO
+    REPORT_REG_TO_CONSOLE r3
+
+.endm
+        
+
+.macro TEST_MSB mac_hi, mac_lo, op1, op2
+
+    LOAD_IMMEDIATE r2, \mac_hi
+    MOVE_TO_SPR SPR_MACHI, r2
+        
+    LOAD_IMMEDIATE r2, \mac_lo
+    MOVE_TO_SPR SPR_MACLO, r2
+        
+    LOAD_IMMEDIATE r5, \op1
+    LOAD_IMMEDIATE r6, \op2
+
+    l.msb r5, r6
+        
+    MOVE_FROM_SPR r3, SPR_MACHI
+    REPORT_REG_TO_CONSOLE r3
+        
+    MOVE_FROM_SPR r3, SPR_MACLO
+    REPORT_REG_TO_CONSOLE r3
+        
+.endm
+
+    
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+       
+        // Test the l.mac instruction.
+        // --------------------------------------------
+
+        // -------- two small positive numbers --------
+        
+        // MAC two small positive numbers on a zero total 
+        TEST_MAC 0x00000000, 0x00000000, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a small positive total 
+        TEST_MAC 0x00000000, 0x00000006, 0x00000002, 0x00000003,
+
+        // MAC two small positive numbers on a moderate positive total 
+        TEST_MAC 0x00000000, 0xfffffffa, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a large positive total 
+        TEST_MAC 0x3fffffff, 0xfffffffa, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a small negative total 
+        TEST_MAC 0xffffffff, 0xfffffffa, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a moderate negative total 
+        TEST_MAC 0xffffffff, 0x00000000, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a large negative total 
+        TEST_MAC 0x80000000, 0x00000000, 0x00000002, 0x00000003
+
+
+        // -------- two moderate positive numbers --------
+        
+        // MAC two moderate positive numbers on a zero total 
+        TEST_MAC 0x00000000, 0x00000000, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a small positive total 
+        TEST_MAC 0x00000000, 0x00000002, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a moderate positive total 
+        TEST_MAC 0x00000000, 0x80000002, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a large positive total 
+        TEST_MAC 0x7fffffff, 0x80000001, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a small negative total 
+        TEST_MAC 0xffffffff, 0xffffffff, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a moderate negative total 
+        TEST_MAC 0xffffffff, 0x80000002, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a large negative total 
+        TEST_MAC 0xfffffffe, 0x80000002, 0x00008001, 0x0000fffe
+
+
+        // -------- two small negative numbers --------
+        
+        // MAC two small negative numbers on a zero total
+        TEST_MAC 0x00000000, 0x00000000, 0xfffffffe, 0xfffffffd
+
+        // MAC two small negative numbers on a small positive total 
+        TEST_MAC 0x00000000, 0x00000006, 0xfffffffe, 0xfffffffd
+
+        // MAC two small negative numbers on a small negative total 
+        TEST_MAC 0xffffffff, 0xffffffff, 0xfffffffe, 0xfffffffd
+
+
+        // -------- one small positive and one small negative --------
+
+        // MAC one small positive and one small negative number on a zero total 
+        TEST_MAC 0x00000000, 0x00000000, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a small positive total 
+        TEST_MAC 0x00000000, 0x0000000c, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a moderate positive total 
+        TEST_MAC 0x00000001, 0x00000005, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a large positive total 
+        TEST_MAC 0x7fffffff, 0xffffffff, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a small negative total 
+        TEST_MAC 0xffffffff, 0xffffffff, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a moderate negative total 
+        TEST_MAC 0xffffffff, 0x00000005, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a large negative total 
+        TEST_MAC 0x80000000, 0x00000006, 0x00000002, 0xfffffffd
+
+
+        // -------- one moderate positive and one moderate negative number --------
+
+        // MAC one moderate positive and one moderate negative number on a zero total 
+        TEST_MAC 0x00000000, 0x00000000, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a small positive total 
+        TEST_MAC 0x00000000, 0x00000006, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a moderate positive total 
+        TEST_MAC 0x00000000, 0x80000000, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a large positive total 
+        TEST_MAC 0x7fffffff, 0xffffffff, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a small negative total 
+        TEST_MAC 0xffffffff, 0xffffffff, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a moderate negative total 
+        TEST_MAC 0xffffffff, 0x7fffffff, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a large negative total 
+        TEST_MAC 0x80000000, 0x80000000, 0x00008000, 0xffff0000
+
+
+        // Test the l.maci instruction.
+        // --------------------------------------------
+
+        // -------- two small positive numbers --------
+        
+        // MAC two small positive numbers on a zero total 
+        TEST_MACI 0x00000000, 0x00000000, 0x00000002, 0x0003
+
+        // MAC two small positive numbers on a small positive total 
+        TEST_MACI 0x00000000, 0x00000006, 0x00000002, 0x0003
+
+        // MAC two small positive numbers on a moderate positive total 
+        TEST_MACI 0x00000000, 0xfffffffa, 0x00000002, 0x0003
+
+        // MAC two small positive numbers on a large positive total 
+        TEST_MACI 0x3fffffff, 0xfffffffa, 0x00000002, 0x0003
+
+        // MAC two small positive numbers on a small negative total 
+        TEST_MACI 0xffffffff, 0xfffffffa, 0x00000002, 0x0003
+
+        // MAC two small positive numbers on a moderate negative total 
+        TEST_MACI 0xffffffff, 0x00000000, 0x00000002, 0x0003
+
+        // MAC two small positive numbers on a large negative total 
+        TEST_MACI 0x80000000, 0x00000000, 0x00000002, 0x0003
+
+        
+        // -------- two moderate positive numbers --------
+
+        // MAC two moderate positive numbers on a zero total 
+        TEST_MACI 0x00000000, 0x00000000, 0x00010002, 0x7fff
+
+        // MAC two moderate positive numbers on a small positive total 
+        TEST_MACI 0x00000000, 0x00000002, 0x00010002, 0x7fff
+
+        // MAC two moderate positive numbers on a moderate positive total 
+        TEST_MACI 0x00000000, 0x80000002, 0x00010002, 0x7fff
+
+        // MAC two moderate positive numbers on a large positive total 
+        TEST_MACI 0x7fffffff, 0x80000001, 0x00010002, 0x7fff
+
+        // MAC two moderate positive numbers on a small negative total 
+        TEST_MACI 0xffffffff, 0xffffffff, 0x00010002, 0x7fff
+
+        // MAC two moderate positive numbers on a moderate negative total 
+        TEST_MACI 0xffffffff, 0x80000002, 0x00010002, 0x7fff
+
+        // MAC two moderate positive numbers on a large negative total 
+        TEST_MACI 0xfffffffe, 0x80000002, 0x00010002, 0x7fff
+
+
+        // -------- two small negative numbers --------
+        
+        // MAC two small negative numbers on a zero total 
+        TEST_MACI 0x00000000, 0x00000000, 0xfffffffe, 0xfffd
+
+        // MAC two small negative numbers on a small positive total 
+        TEST_MACI 0x00000000, 0x00000006, 0xfffffffe, 0xfffd
+
+        // MAC two small negative numbers on a small negative total 
+        TEST_MACI 0xffffffff, 0xffffffff, 0xfffffffe, 0xfffd
+
+
+        // -------- one small positive and one small negative --------
+
+        // MAC one small positive and one small negative number on a zero total 
+        TEST_MACI 0x00000000, 0x00000000, 0x00000002, 0xfffd
+
+        // MAC one small positive and one small negative number on a small positive total 
+        TEST_MACI 0x00000000, 0x0000000c, 0x00000002, 0xfffd
+
+        // MAC one small positive and one small negative number on a moderate positive total 
+        TEST_MACI 0x00000001, 0x00000005, 0x00000002, 0xfffd
+
+        // MAC one small positive and one small negative number on a large positive total 
+        TEST_MACI 0x7fffffff, 0xffffffff, 0x00000002, 0xfffd
+
+        // MAC one small positive and one small negative number on a small negative total 
+        TEST_MACI 0xffffffff, 0xffffffff, 0x00000002, 0xfffd
+
+        // MAC one small positive and one small negative number on a moderate negative total 
+        TEST_MACI 0xffffffff, 0x00000005, 0x00000002, 0xfffd
+
+        // MAC one small positive and one small negative number on a large negative total 
+        TEST_MACI 0x80000000, 0x00000006, 0x00000002, 0xfffd
+
+        
+        // -------- one moderate positive and one moderate negative --------
+
+        // MAC one moderate positive and one moderate negative number on a zero total 
+        TEST_MACI 0x00000000, 0x00000000, 0x00010000, 0x8000
+
+        // MAC one moderate positive and one moderate negative number on a small positive total 
+        TEST_MACI 0x00000000, 0x00000006, 0x00010000, 0x8000
+
+        // MAC one moderate positive and one moderate negative number on a moderate positive total 
+        TEST_MACI 0x00000000, 0x80000000, 0x00010000, 0x8000
+
+        // MAC one moderate positive and one moderate negative number on a large positive total 
+        TEST_MACI 0x7fffffff, 0xffffffff, 0x00010000, 0x8000
+
+        // MAC one moderate positive and one moderate negative number on a small negative total 
+        TEST_MACI 0xffffffff, 0xffffffff, 0x00010000, 0x8000
+
+        // MAC one moderate positive and one moderate negative number on a moderate negative total 
+        TEST_MACI 0xffffffff, 0x7fffffff, 0x00010000, 0x8000
+
+        // MAC one moderate positive and one moderate negative number on a large negative total 
+        TEST_MACI 0x80000000, 0x80000000, 0x00010000, 0x8000
+
+
+        // Test the l.macrc instruction.
+        // --------------------------------------------
+        // Note that these tests use the same input data as the ones for l.mac above.
+        // The results are the same, but only the low 32-bits are compared.
+        
+        // -------- two small positive numbers --------
+        
+        // MAC two small positive numbers on a zero total 
+        TEST_MACRC 0x00000000, 0x00000000, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a small positive total 
+        TEST_MACRC 0x00000000, 0x00000006, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a moderate positive total 
+        TEST_MACRC 0x00000000, 0xfffffffa, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a large positive total 
+        TEST_MACRC 0x3fffffff, 0xfffffffa, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a small negative total 
+        TEST_MACRC 0xffffffff, 0xfffffffa, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a moderate negative total 
+        TEST_MACRC 0xffffffff, 0x00000000, 0x00000002, 0x00000003
+
+        // MAC two small positive numbers on a large negative total 
+        TEST_MACRC 0x80000000, 0x00000000, 0x00000002, 0x00000003
+
+
+        // -------- two moderate positive numbers --------
+        
+        // MAC two moderate positive numbers on a zero total 
+        TEST_MACRC 0x00000000, 0x00000000, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a small positive total 
+        TEST_MACRC 0x00000000, 0x00000002, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a moderate positive total 
+        TEST_MACRC 0x00000000, 0x80000002, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a large positive total 
+        TEST_MACRC 0x7fffffff, 0x80000001, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a small negative total 
+        TEST_MACRC 0xffffffff, 0xffffffff, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a moderate negative total 
+        TEST_MACRC 0xffffffff, 0x80000002, 0x00008001, 0x0000fffe
+
+        // MAC two moderate positive numbers on a large negative total 
+        TEST_MACRC 0xfffffffe, 0x80000002, 0x00008001, 0x0000fffe
+
+
+        // -------- two small negative numbers --------
+        
+        // MAC two small negative numbers on a zero total 
+        TEST_MACRC 0x00000000, 0x00000000, 0xfffffffe, 0xfffffffd
+
+        // MAC two small negative numbers on a small positive total 
+        TEST_MACRC 0x00000000, 0x00000006, 0xfffffffe, 0xfffffffd
+
+        // MAC two small negative numbers on a small negative total 
+        TEST_MACRC 0xffffffff, 0xffffffff, 0xfffffffe, 0xfffffffd
+
+        
+        // -------- one small positive and one small negative number --------
+        
+        // MAC one small positive and one small negative number on a zero total 
+        TEST_MACRC 0x00000000, 0x00000000, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a small positive total 
+        TEST_MACRC 0x00000000, 0x0000000c, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a moderate positive total 
+        TEST_MACRC 0x00000001, 0x00000005, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a large positive total 
+        TEST_MACRC 0x7fffffff, 0xffffffff, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a small negative total 
+        TEST_MACRC 0xffffffff, 0xffffffff, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a moderate negative total 
+        TEST_MACRC 0xffffffff, 0x00000005, 0x00000002, 0xfffffffd
+
+        // MAC one small positive and one small negative number on a large negative total 
+        TEST_MACRC 0x80000000, 0x00000006, 0x00000002, 0xfffffffd
+
+        
+        // -------- one moderate positive and one moderate negative --------
+
+        // MAC one moderate positive and one moderate negative number on a zero total 
+        TEST_MACRC 0x00000000, 0x00000000, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a small positive total 
+        TEST_MACRC 0x00000000, 0x00000006, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a moderate positive total 
+        TEST_MACRC 0x00000000, 0x80000000, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a large positive total 
+        TEST_MACRC 0x7fffffff, 0xffffffff, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a small negative total 
+        TEST_MACRC 0xffffffff, 0xffffffff, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a moderate negative total 
+        TEST_MACRC 0xffffffff, 0x7fffffff, 0x00008000, 0xffff0000
+
+        // MAC one moderate positive and one moderate negative number on a large negative total 
+        TEST_MACRC 0x80000000, 0x80000000, 0x00008000, 0xffff0000
+
+
+        // Test the l.msb instruction.
+        // --------------------------------------------
+
+        // MSB two small positive numbers on a zero total 
+        TEST_MSB 0x00000000, 0x00000000, 0x00000002, 0x00000003
+
+        // MSB two small positive numbers on a small positive total 
+        TEST_MSB 0x00000000, 0x0000000c, 0x00000002, 0x00000003
+
+        // MSB two small positive numbers on a moderate positive total 
+        TEST_MSB 0x00000001, 0x00000000, 0x00000002, 0x00000003
+
+        // MSB two small positive numbers on a large positive total 
+        TEST_MSB 0x40000000, 0x00000000, 0x00000002, 0x00000003
+
+        // MSB two small positive numbers on a small negative total 
+        TEST_MSB 0xffffffff, 0xfffffffa, 0x00000002, 0x00000003
+
+        // MSB two small positive numbers on a moderate negative total 
+        TEST_MSB 0xffffffff, 0x00000005, 0x00000002, 0x00000003
+
+        // MSB two small positive numbers on a large negative total 
+        TEST_MSB 0x80000000, 0x00000006, 0x00000002, 0x00000003
+
+
+        // -------- two moderate positive numbers --------
+
+        // MSB two moderate positive numbers on a zero total 
+        TEST_MSB 0x00000000, 0x00000000, 0x00008001, 0x0000fffe
+
+        // MSB two moderate positive numbers on a small positive total 
+        TEST_MSB 0x00000000, 0x00000002, 0x00008001, 0x0000fffe
+
+        // MSB two moderate positive numbers on a moderate positive total 
+        TEST_MSB 0x00000000, 0x80000002, 0x00008001, 0x0000fffe
+
+        // MSB two moderate positive numbers on a large positive total 
+        TEST_MSB 0x7fffffff, 0x7ffffffd, 0x00008001, 0x0000fffe
+
+        // MSB two moderate positive numbers on a small negative total 
+        TEST_MSB 0xffffffff, 0xffffffff, 0x00008001, 0x0000fffe
+
+        // MSB two moderate positive numbers on a moderate negative total 
+        TEST_MSB 0xffffffff, 0x80000002, 0x00008001, 0x0000fffe
+
+        // MSB two moderate positive numbers on a large negative total 
+        TEST_MSB 0xfffffffe, 0x80000002, 0x00008001, 0x0000fffe
+
+
+        // -------- two small negative numbers --------
+        
+        // MSB two small negative numbers on a zero total 
+        TEST_MSB 0x00000000, 0x00000006, 0xfffffffe, 0xfffffffd
+
+        // MSB two small negative numbers on a small positive total 
+        TEST_MSB 0x00000000, 0x0000000c, 0xfffffffe, 0xfffffffd
+
+        // MSB two small negative numbers on a small negative total 
+        TEST_MSB 0xffffffff, 0xffffffff, 0xfffffffe, 0xfffffffd
+
+
+        // -------- one small positive and one small negative number --------
+        
+        // MSB one small positive and one small negative number on a zero total 
+        TEST_MSB 0x00000000, 0x00000000, 0x00000002, 0xfffffffd
+
+        // MSB one small positive and one small negative number on a small positive total 
+        TEST_MSB 0x00000000, 0x00000006, 0x00000002, 0xfffffffd
+
+        // MSB one small positive and one small negative number on a moderate positive total 
+        TEST_MSB 0x00000000, 0xffffffff, 0x00000002, 0xfffffffd
+
+        // MSB one small positive and one small negative number on a large positive total 
+        TEST_MSB 0x7fffffff, 0xfffffff9, 0x00000002, 0xfffffffd
+
+        // MSB one small positive and one small negative number on a small negative total 
+        TEST_MSB 0xffffffff, 0xfffffff9, 0x00000002, 0xfffffffd
+
+        // MSB one small positive and one small negative number on a moderate negative total 
+        TEST_MSB 0xfffffffe, 0xffffffff, 0x00000002, 0xfffffffd
+
+        // MSB one small positive and one small negative number on a large negative total 
+        TEST_MSB 0x80000000, 0x00000000, 0x00000002, 0xfffffffd
+
+
+        // -------- one moderate positive and one moderate negative number --------
+        
+        // MSB one moderate positive and one moderate negative number on a zero total 
+        TEST_MSB 0x00000000, 0x00000000, 0x00008000, 0xffff0000
+
+        // MSB one moderate positive and one moderate negative number on a small positive total 
+        TEST_MSB 0x00000000, 0x00000006, 0x00008000, 0xffff0000
+
+        // MSB one moderate positive and one moderate negative number on a moderate positive total 
+        TEST_MSB 0x00000000, 0x80000000, 0x00008000, 0xffff0000
+
+        // MSB one moderate positive and one moderate negative number on a large positive total 
+        TEST_MSB 0x7fffffff, 0x7fffffff, 0x00008000, 0xffff0000
+
+        // MSB one moderate positive and one moderate negative number on a small negative total 
+        TEST_MSB 0xffffffff, 0xffffffff, 0x00008000, 0xffff0000
+
+        // MSB one moderate positive and one moderate negative number on a moderate negative total 
+        TEST_MSB 0xfffffffe, 0xffffffff, 0x00008000, 0xffff0000
+
+        // MSB one moderate positive and one moderate negative number on a large negative total 
+        TEST_MSB 0x80000000, 0x00000000, 0x00008000, 0xffff0000
+
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/mfspr.S b/sim/testsuite/sim/or1k/mfspr.S
new file mode 100644
index 0000000..7007fb6
--- /dev/null
+++ b/sim/testsuite/sim/or1k/mfspr.S
@@ -0,0 +1,196 @@
+/* Tests instructions l.mfspr and l.mtspr
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000000);\n
+# output: report(0x00002801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002801);\n
+# output: report(0x00000000);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002801);\n
+# output: report(0x00002801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00000801);\n
+# output: report(0x00002000);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002000);\n
+# output: report(0x00000801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002801);\n
+# output: report(0x00000001);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00000800);\n
+# output: report(0x00002801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x00002801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002801);\n
+# output: report(0x00000000);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002801);\n
+# output: report(0x00002801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00000801);\n
+# output: report(0x00002000);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002000);\n
+# output: report(0x00000801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00002801);\n
+# output: report(0x00000001);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: report(0x00000800);\n
+# output: report(0x00002801);\n
+# output: report(0xdeadbeef);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-env.h"
+
+#define MACLO_VAL 0xdeadbeef
+        
+
+/* ----------------------------------------------------------------------------
+ * A macro to carry out a test of l.mfspr
+ *
+ * MACLO (0x2801) is used as the SPR, since it can be read and cleared using l.macrc
+ * and can be set using l.maci. spr_number and immediate_val_to_or should be chosen
+ * to address this register.
+ *
+ * The value placed in the register is entirely arbitrary - we use 0xdeadbeef.
+ * ------------------------------------------------------------------------- */
+
+.macro TEST_MFSPR  spr_number, immediate_val_to_or
+
+    REPORT_IMMEDIATE_TO_CONSOLE \spr_number
+    REPORT_IMMEDIATE_TO_CONSOLE \immediate_val_to_or
+
+    // Write MACLO_VAL to MACLO.
+    l.macrc r2
+    LOAD_IMMEDIATE r2, MACLO_VAL
+    l.maci  r2, 1
+
+    LOAD_IMMEDIATE r5, \spr_number
+
+    l.mfspr r4, r5, \immediate_val_to_or
+
+    REPORT_REG_TO_CONSOLE r4
+
+    PRINT_NEWLINE_TO_CONSOLE        
+
+.endm
+
+    
+/* ----------------------------------------------------------------------------
+ * A macro to carry out a test of l.mtspr
+ *
+ * MACLO (0x2801) is used as the SPR, since it can be read and cleared using l.macrc
+ * and can be set using l.maci. spr_number and immediate_val_to_or should be chosen
+ * to address this register.
+ *
+ * The value placed in the register is entirely arbitrary - we use 0xdeadbeef.
+ * ------------------------------------------------------------------------- */
+
+.macro TEST_MTSPR  spr_number, immediate_val_to_or
+
+    REPORT_IMMEDIATE_TO_CONSOLE \spr_number
+    REPORT_IMMEDIATE_TO_CONSOLE \immediate_val_to_or
+
+    // Clear MACLO
+    l.macrc r2
+
+    LOAD_IMMEDIATE r4, MACLO_VAL
+    LOAD_IMMEDIATE r5, \spr_number
+
+    l.mtspr r5, r4, \immediate_val_to_or
+
+    // Retrieve MACLO.
+    l.macrc r4
+    REPORT_REG_TO_CONSOLE r4
+
+    PRINT_NEWLINE_TO_CONSOLE
+        
+.endm
+        
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+        // Test the l.mfspr instruction with a range of operands.
+
+        // Move a test value using zero in the register
+        TEST_MFSPR SPR_VR, SPR_MACLO  // 0x0000, 0x2801
+
+        // Move a test value using zero as the constant
+        TEST_MFSPR SPR_MACLO, SPR_VR  // 0x2801, 0x0000
+
+        // Move a test value using non-zero in both register and constant.
+        // Some of these values will not give the correct result if OR rather
+        // than ADD is used to determine the SPR address
+        TEST_MFSPR SPR_MACLO,  SPR_MACLO  // 0x2801, 0x2801
+        TEST_MFSPR SPR_DMMUPR, SPR_ICCR   // 0x0801, 0x2000
+        TEST_MFSPR SPR_ICCR,   SPR_DMMUPR // 0x2000, 0x0801
+        TEST_MFSPR SPR_MACLO,  SPR_UPR    // 0x2801, 0x0001
+        TEST_MFSPR SPR_DMMUCR, SPR_MACLO  // 0x0800, 0x2801
+
+
+        // Test the l.mtspr instruction with a range of operands.
+        
+        // Move a test value using zero in the register
+        TEST_MTSPR SPR_VR, SPR_MACLO  // 0x0000, 0x2801
+
+        // Move a test value using zero as the constant
+        TEST_MTSPR SPR_MACLO, SPR_VR  // 0x2801, 0x0000
+
+        // Move a test value using non-zero in both register and constant.
+        // Some of these values will not give the correct result if OR rather
+        // than ADD is used to determine the SPR address
+        TEST_MTSPR SPR_MACLO,  SPR_MACLO  // 0x2801, 0x2801
+        TEST_MTSPR SPR_DMMUPR, SPR_ICCR   // 0x0801, 0x2000
+        TEST_MTSPR SPR_ICCR,   SPR_DMMUPR // 0x2000, 0x0801
+        TEST_MTSPR SPR_MACLO,  SPR_UPR    // 0x2801, 0x0001
+        TEST_MTSPR SPR_DMMUCR, SPR_MACLO  // 0x0800, 0x2801
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/mul.S b/sim/testsuite/sim/or1k/mul.S
new file mode 100644
index 0000000..97b703e
--- /dev/null
+++ b/sim/testsuite/sim/or1k/mul.S
@@ -0,0 +1,277 @@
+/* Tests the multiply instructions.
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00008001);\n
+# output: report(0x0000fffe);\n
+# output: report(0x7ffffffe);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00008000);\n
+# output: report(0x00010000);\n
+# output: report(0x80000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000002);\n
+# output: report(0x00000003);\n
+# output: report(0x00000006);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+        // Test l.mul
+        
+        // Multiply two small positive numbers. Should set no flags. 
+        TEST_INST_I32_I32 l.mul, 0x00000002, 0x00000003
+
+        // Multiply two quite large positive numbers. Should set no flags 
+        TEST_INST_I32_I32 l.mul, 0x00008001, 0x0000fffe
+
+        // Multiply two slightly too large positive numbers. Should set the
+        // overflow, but not the carry flag .
+        TEST_INST_I32_I32 l.mul, 0x00008000, 0x00010000
+
+        // Multiply two large positive numbers. Should set both the carry and
+        // overflow flags (even though the result is not a negative number. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0x00010000, 0x00010000
+
+        // Multiply two small negative numbers. Should set the overflow, but not
+        // the carry flag. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0xfffffffe, 0xfffffffd
+
+        // Multiply two quite large negative numbers. Should set the overflow,
+        // but not the carry flag. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0002
+
+        // Multiply two slightly too large negative numbers. Should set both the
+        // overflow, and the carry flags 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0000
+
+        // Multiply two large negative numbers. Should set the
+        // both the carry and overflow flags (even though the result is a
+        // positive number. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0xffff0000, 0xfffeffff
+
+        // Multiply one small negative number and one small positive number.
+        // Should set the overflow, but not the carry flag. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0x00000002, 0xfffffffd
+
+        // Multiply one quite large negative number and one quite large
+        // positive number. Should set the overflow, but not the carry flag. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0xffff8000, 0x00010000
+
+        // Multiply one slightly too large negative number and one slightly
+        // too large positive number. Should set both the carry and overflow flags. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0xffff7fff, 0x00010000
+
+        // Multiply the largest negative number by positive unity. Should set
+        // neither carry, nor overflow flag. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0x80000000, 0x00000001
+
+        // ------ Check that range exceptions are triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+        
+        // Check that an overflow alone causes a RANGE Exception. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0x00008000, 0x00010000
+
+        // Check that a carry alone does not cause a RANGE Exception. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0x00000002, 0xfffffffd
+
+        // Check that carry and overflow together cause an exception. 
+        // TODO: disabled, as it fails against ORPSoC V2's or1200
+        // TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0000
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+
+        // Test l.muli
+        
+        // Multiply two small positive numbers. Should set no flags. 
+        TEST_INST_I32_I16 l.muli, 0x00000002, 0x0003
+
+        /* TODO: carry on here
+        // Multiply two quite large positive numbers. Should set no flags 
+        TEST_INST_I32_I16 l.muli, 0x00010002, 0x7fff
+
+        // Multiply two slightly too large positive numbers. Should set the
+        // overflow, but not the carry flag 
+        TEST_INST_I32_I16 l.muli, 0x00020000, 0x4000
+
+        // Multiply two large positive numbers. Should set both the carry and
+        // overflow flags (even though the result is not a negative number. 
+        TEST_INST_I32_I16 l.muli, 0x00040000, 0x4000
+
+        // Multiply two small negative numbers. Should set the overflow, but not
+        // the carry flag. 
+        TEST_INST_I32_I16 l.muli, 0xfffffffe, 0xfffd
+
+        // Multiply two quite large negative numbers. Should set the overflow,
+        // but not the carry flag. 
+        TEST_INST_I32_I16 l.muli, 0xfffefffe, 0x8001
+
+        // Multiply two slightly too large negative numbers. Should set both the
+        // overflow, and the carry flags 
+        TEST_INST_I32_I16 l.muli, 0xfffe0000, 0xbfff
+
+        // Multiply two large negative numbers. Should set the
+        // both the carry and overflow flags (even though the result is a positive number. 
+        TEST_INST_I32_I16 l.muli, 0xfffdfffe, 0x8000
+
+        // Multiply one small negative number and one small positive number.
+        // Should set the overflow, but not the carry flag. 
+        TEST_INST_I32_I16 l.muli, 0x00000002, 0xfffd
+
+        // Multiply one quite large negative number and one quite large
+        // positive number. Should set the overflow, but not the carry flag. 
+        TEST_INST_I32_I16 l.muli, 0x00010000, 0x8000
+
+        // Multiply one slightly too large negative number and one slightly
+        // too large positive number. Should set both the carry and overflow flags. 
+        TEST_INST_I32_I16 l.muli, 0xfffdfffc, 0x4000
+
+        // Multiply the largest negative number by positive unity. Should set
+        // neither carry, nor overflow flag. 
+        TEST_INST_I32_I16 l.muli, 0x80000000, 0x0001
+
+        // ------ Check that range exceptions are triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        // Check that an overflow alone causes a RANGE Exception. 
+        TEST_INST_I32_I16 l.muli, 0x00020000, 0x4000
+
+        // Check that a carry alone does not cause a RANGE Exception. 
+        TEST_INST_I32_I16 l.muli, 0xfffffffe, 0xfffd
+
+        // Check that carry and overflow together cause an exception. 
+        TEST_INST_I32_I16 l.muli, 0xfffdfffe, 0x8000
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        
+        // Test l.mulu
+        
+        // Multiply two small positive numbers. Should set no flags. 
+        TEST_INST_I32_I32 l.mulu, 0x00000002, 0x00000003
+
+        // Multiply two quite large positive numbers. Should set no flags 
+        TEST_INST_I32_I32 l.mulu, 0x00008001, 0x0000fffe
+
+        // Multiply two slightly too large positive numbers. Should set the
+        // overflow, but not the carry flag 
+        TEST_INST_I32_I32 l.mulu, 0x00008000, 0x00010000
+
+        // Multiply two large positive numbers. Should set both the carry and
+        // overflow flags (even though the result is not a negative number. 
+        TEST_INST_I32_I32 l.mulu, 0x00010000, 0x00010000
+
+        // Multiply two small negative numbers. Should set the overflow, but not
+        // the carry flag. 
+        TEST_INST_I32_I32 l.mulu, 0xfffffffe, 0xfffffffd
+
+        // Multiply two quite large negative numbers. Should set the overflow,
+        // but not the carry flag. 
+        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0xffff0002
+
+        // Multiply two slightly too large negative numbers. Should set both the
+        // overflow, and the carry flags 
+        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0xffff0000
+
+        // Multiply two large negative numbers. Should set the
+        //  both the carry and overflow flags (even though the result is a positive number. 
+        TEST_INST_I32_I32 l.mulu, 0xffff0000, 0xfffeffff
+
+        // Multiply one small negative number and one small positive number.
+        // Should set the overflow, but not the carry flag. 
+        TEST_INST_I32_I32 l.mulu, 0x00000002, 0xfffffffd
+
+        // Multiply one quite large negative number and one quite large
+        // positive number. Should set the overflow, but not the carry flag. 
+        TEST_INST_I32_I32 l.mulu, 0xffff8000, 0x00010000
+
+        // Multiply one slightly too large negative number and one slightly
+        // too large positive number. Should set both the carry and overflow flags. 
+        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0x00010000
+
+        // Multiply the largest negative number by positive unity. Should set
+        // neither carry, nor overflow flag. 
+        TEST_INST_I32_I32 l.mulu, 0x80000000, 0x00000001
+
+
+        // ------ Check that range exceptions are NEVER triggered.
+
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+        
+        // Check that what would cause an overflow alone in 2's complement does
+        // not cause a RANGE Exception. 
+        TEST_INST_I32_I32 l.mulu, 0x00008000, 0x00010000
+
+        // Check that a carry alone does not cause a RANGE Exception. 
+        TEST_INST_I32_I32 l.mulu, 0x00000002, 0xfffffffd
+
+        // Check that what would cause an overflow and carry in 2's complement
+        // does not cause a RANGE Exception. 
+        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0xffff0000
+
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+        */
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/or.S b/sim/testsuite/sim/or1k/or.S
new file mode 100644
index 0000000..5d96baf
--- /dev/null
+++ b/sim/testsuite/sim/or1k/or.S
@@ -0,0 +1,207 @@
+/* Tests instructions l.or, l.ori
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x55555555);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x55555555);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xb38f0f83);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xc4c70f07);\n
+# output: report(0xccf7ff7f);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x38f0f83b);\n
+# output: report(0xbbffffbb);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x0000ffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x0000aaaa);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00005555);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00005555);\n
+# output: report(0xaaaaffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000f83);\n
+# output: report(0x4c70ffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000f07);\n
+# output: report(0x4c70ff7f);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000f83b);\n
+# output: report(0xb38fffbb);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+	    // Always set OVE. We should never trigger an exception, even if this bit is set.
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        // Test the l.or instruction with a range of operands.
+        
+	    TEST_INST_I32_I32 l.or, 0x00000000, 0x00000000
+	    TEST_INST_I32_I32 l.or, 0xffffffff, 0xffffffff
+	    TEST_INST_I32_I32 l.or, 0xaaaaaaaa, 0x00000000
+	    TEST_INST_I32_I32 l.or, 0xaaaaaaaa, 0xaaaaaaaa
+	    TEST_INST_I32_I32 l.or, 0x55555555, 0x00000000
+	    TEST_INST_I32_I32 l.or, 0x55555555, 0x55555555
+	    TEST_INST_I32_I32 l.or, 0xaaaaaaaa, 0x55555555
+	    TEST_INST_I32_I32 l.or, 0x4c70f07c, 0xb38f0f83
+	    TEST_INST_I32_I32 l.or, 0x4c70f07c, 0xc4c70f07
+	    TEST_INST_I32_I32 l.or, 0xb38f0f83, 0x38f0f83b
+
+        // Test the l.ori instruction with a range of operands.
+	    TEST_INST_I32_I16 l.ori, 0x00000000, 0x0000
+	    TEST_INST_I32_I16 l.ori, 0xffffffff, 0xffff
+	    TEST_INST_I32_I16 l.ori, 0xaaaaaaaa, 0x0000
+	    TEST_INST_I32_I16 l.ori, 0xaaaaaaaa, 0xaaaa
+	    TEST_INST_I32_I16 l.ori, 0x55555555, 0x0000
+	    TEST_INST_I32_I16 l.ori, 0x55555555, 0x5555
+	    TEST_INST_I32_I16 l.ori, 0xaaaaaaaa, 0x5555
+	    TEST_INST_I32_I16 l.ori, 0x4c70f07c, 0x0f83
+	    TEST_INST_I32_I16 l.ori, 0x4c70f07c, 0x0f07
+	    TEST_INST_I32_I16 l.ori, 0xb38f0f83, 0xf83b
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/or1k-asm-test-env.h b/sim/testsuite/sim/or1k/or1k-asm-test-env.h
new file mode 100644
index 0000000..3cf3585
--- /dev/null
+++ b/sim/testsuite/sim/or1k/or1k-asm-test-env.h
@@ -0,0 +1,61 @@
+
+#ifndef OR1K_ASM_TEST_ENV_H
+#define OR1K_ASM_TEST_ENV_H
+
+#include "or1k-asm.h"
+#include "or1k-asm-test.h"
+#include "spr-defs.h"
+
+
+.macro STANDARD_TEST_HEADER
+
+        // Without the "a" (allocatable) flag, this section gets some default flags,
+        // and then it's discarded by objcopy when flattening to the binary file.
+        // 'x' means executable.
+        .section .exception_vectors, "ax"
+        .org    0x100
+        .global _start
+    _start:
+        // Clear R0 on start-up. There is no guarantee that R0 is hardwired to zero,
+        // and indeed it is not when simulating the or1200 Verilog core.
+        CLEAR_REG r0
+
+        OR1K_DELAYED_NOP(l.j test_startup)
+
+        .section .text
+      
+    test_startup:
+
+.endm
+
+
+.macro STANDARD_TEST_BODY
+
+        LOAD_IMMEDIATE STACK_POINTER_R1, stack_begin
+
+        CLEAR_BSS r3, r4
+
+        CALL r3, start_tests
+
+        EXIT_SIMULATION_WITH_IMMEDIATE_EXIT_CODE SEC_SUCCESS
+
+        .section .stack
+        .space 4096  // We need more than EXCEPTION_STACK_SKIP_SIZE bytes.
+    stack_begin:
+
+.endm
+
+
+.macro STANDARD_TEST_ENVIRONMENT
+
+       // One of the test cases needs to do some tests before setting up the stack and so on.
+       // That's the reason this macro is split into 2 parts, so that the caller
+       // can inject code between the 2 initialisation phases.
+
+       STANDARD_TEST_HEADER
+       STANDARD_TEST_BODY
+
+.endm
+
+
+#endif  // Include this file only once.
diff --git a/sim/testsuite/sim/or1k/or1k-asm-test-helpers.h b/sim/testsuite/sim/or1k/or1k-asm-test-helpers.h
new file mode 100644
index 0000000..7cc918c
--- /dev/null
+++ b/sim/testsuite/sim/or1k/or1k-asm-test-helpers.h
@@ -0,0 +1,134 @@
+
+#ifndef OR1K_ASM_TEST_HELPERS_H
+#define OR1K_ASM_TEST_HELPERS_H
+
+#include "spr-defs.h"
+#include "or1k-asm-test-env.h"
+
+
+.macro REPORT_EXCEPTION  reg, instruction_addr
+
+    PUSH r2
+    PUSH r3
+
+    MOVE_REG r2, \reg
+
+    LOAD_IMMEDIATE r3, \instruction_addr
+
+    l.sfeq r2, r3
+
+    OR1K_DELAYED_NOP(l.bnf 55f)
+
+    REPORT_IMMEDIATE_TO_CONSOLE 0x00000001
+    OR1K_DELAYED_NOP(l.j 56f)
+
+ 55:
+    REPORT_IMMEDIATE_TO_CONSOLE 0x00000000
+
+ 56:
+    POP r3
+    POP r2
+
+.endm
+
+
+.macro TEST_INST_FF_I32_I32  flags_to_set, flags_to_clear, opcode, op1, op2
+
+    LOAD_IMMEDIATE r5, \op1
+    LOAD_IMMEDIATE r6, \op2
+
+    REPORT_REG_TO_CONSOLE r5
+    REPORT_REG_TO_CONSOLE r6
+
+    // Clear the last exception address.
+    MOVE_TO_SPR SPR_EPCR_BASE, ZERO_R0
+
+    SET_SPR_SR_FLAGS   \flags_to_set  , r2, r3
+    CLEAR_SPR_SR_FLAGS \flags_to_clear, r2, r3
+
+    l.nop 0  // TODO: temporary, remove at the end
+    l.nop 0  // TODO: temporary, remove at the end
+
+\@1$: \opcode r4, r5, r6
+
+    l.nop 0  // TODO: temporary, remove at the end
+    l.nop 0  // TODO: temporary, remove at the end
+
+    MOVE_FROM_SPR r2, SPR_SR         // Save the flags.
+    MOVE_FROM_SPR r5, SPR_EPCR_BASE  // Save the exception address.
+
+    REPORT_REG_TO_CONSOLE r4
+
+    REPORT_BIT_TO_CONSOLE r2, SPR_SR_CY
+    REPORT_BIT_TO_CONSOLE r2, SPR_SR_OV
+
+    REPORT_EXCEPTION r5, \@1$
+
+    PRINT_NEWLINE_TO_CONSOLE
+        
+.endm
+
+
+.macro TEST_INST_FF_I32_I16  flags_to_set, flags_to_clear, opcode, op1, op2
+
+    LOAD_IMMEDIATE r5, \op1
+
+    REPORT_REG_TO_CONSOLE r5
+    REPORT_IMMEDIATE_TO_CONSOLE \op2
+        
+    SET_SPR_SR_FLAGS   \flags_to_set  , r2, r3
+    CLEAR_SPR_SR_FLAGS \flags_to_clear, r2, r3
+
+    // Clear the last exception address.
+    MOVE_TO_SPR SPR_EPCR_BASE, ZERO_R0
+
+\@1$: \opcode r4, r5, \op2
+
+    MOVE_FROM_SPR r2, SPR_SR         // Save the flags.
+    MOVE_FROM_SPR r5, SPR_EPCR_BASE  // Save the exception address.
+
+    REPORT_REG_TO_CONSOLE r4
+
+    REPORT_BIT_TO_CONSOLE r2, SPR_SR_CY
+    REPORT_BIT_TO_CONSOLE r2, SPR_SR_OV
+
+    REPORT_EXCEPTION r5, \@1$
+
+    PRINT_NEWLINE_TO_CONSOLE
+        
+.endm
+
+
+.macro TEST_INST_I32_I32  opcode, op1, op2
+
+  TEST_INST_FF_I32_I32 0, 0, \opcode, \op1, \op2
+
+.endm
+
+        
+.macro TEST_INST_I32_I16  opcode, op1, op2
+
+  TEST_INST_FF_I32_I16 0, 0, \opcode, \op1, \op2
+
+.endm
+
+
+.macro CHECK_CARRY_AND_OVERFLOW_NOT_SET  overwritten_reg1, overwritten_reg2
+
+    MOVE_FROM_SPR \overwritten_reg1, SPR_SR
+
+    LOAD_IMMEDIATE \overwritten_reg2, SPR_SR_CY + SPR_SR_OV
+    l.and   \overwritten_reg1, \overwritten_reg1, \overwritten_reg2
+
+    l.sfne \overwritten_reg1, ZERO_R0
+
+    OR1K_DELAYED_NOP(l.bnf \@1$)
+
+    EXIT_SIMULATION_WITH_IMMEDIATE_EXIT_CODE  SEC_GENERIC_ERROR
+
+  \@1$:
+
+.endm
+
+
+#endif  // Include this file only once.
diff --git a/sim/testsuite/sim/or1k/or1k-asm-test.h b/sim/testsuite/sim/or1k/or1k-asm-test.h
new file mode 100644
index 0000000..14c41fe
--- /dev/null
+++ b/sim/testsuite/sim/or1k/or1k-asm-test.h
@@ -0,0 +1,258 @@
+
+#ifndef OR1K_ASM_TEST_H
+#define OR1K_ASM_TEST_H
+
+#include "spr-defs.h"
+
+
+// ----------- Register definitions -----------
+
+// The "jump and link" instructions store the return address in R9.
+#define LINK_REGISTER_R9 r9
+
+// These register definitions match the ABI.
+#define ZERO_R0          r0
+#define STACK_POINTER_R1 r1
+#define FRAME_POINTER_R2 r2
+#define RETURN_VALUE_R11 r11
+
+
+// ----------- Load/move/clear helpers -----------
+
+.macro LOAD_IMMEDIATE  reg, val
+    l.movhi \reg,       hi( \val ) 
+    l.ori   \reg, \reg, lo( \val )
+.endm
+
+.macro MOVE_REG  dest_reg, src_reg
+    .ifnes "\dest_reg","\src_reg"
+        l.ori \dest_reg, \src_reg, 0
+    .endif
+.endm
+
+.macro CLEAR_REG reg
+    l.movhi \reg, 0
+.endm
+
+
+.macro MOVE_FROM_SPR  reg, spr_reg
+    l.mfspr \reg, ZERO_R0, \spr_reg
+.endm
+
+.macro MOVE_TO_SPR  spr_reg, reg
+    l.mtspr ZERO_R0, \reg, \spr_reg
+.endm
+
+
+.macro SET_SPR_SR_FLAGS flag_mask, scratch_reg_1, scratch_reg_2
+    // We cannot use PUSH and POP here because some flags like Carry would get overwritten.
+
+    // We could optimise this routine, as instruction l.mtspr already does a logical OR.
+    MOVE_FROM_SPR \scratch_reg_2, SPR_SR
+    LOAD_IMMEDIATE \scratch_reg_1, \flag_mask
+    l.or    \scratch_reg_2, \scratch_reg_2, \scratch_reg_1
+    MOVE_TO_SPR SPR_SR, \scratch_reg_2
+
+.endm
+
+.macro CLEAR_SPR_SR_FLAGS flag_mask, scratch_reg_1, scratch_reg_2
+    // We cannot use PUSH and POP here because some flags like Carry would get overwritten.
+
+    MOVE_FROM_SPR \scratch_reg_2, SPR_SR
+    LOAD_IMMEDIATE \scratch_reg_1, ~\flag_mask
+    l.and   \scratch_reg_2, \scratch_reg_2, \scratch_reg_1
+    MOVE_TO_SPR SPR_SR, \scratch_reg_2
+        
+.endm        
+
+
+// ----------- Stack helpers -----------
+
+// This value is defined in the OpenRISC 1000 specification.
+#define EXCEPTION_STACK_SKIP_SIZE  2092
+
+
+// WARNING: Functions without prolog cannot use these PUSH or POP macros.
+// PERFORMANCE WARNING: These PUSH/POP macros are convenient, but can lead to slow code:
+//                      if you need to PUSH or POP several registers, it's faster to
+//                      use non-zero offsets when loading/storing and then increment/decrement
+//                      the stack pointer just once.
+// NOTE: There is a 2092-byte (see EXCEPTION_STACK_SKIP_SIZE) safety zone at the bottom of the stack,
+//       check out the OpenRISC specification for more information.
+.macro PUSH reg
+    l.addi STACK_POINTER_R1, STACK_POINTER_R1, -4
+    l.sw   0(STACK_POINTER_R1), \reg
+.endm
+
+// WARNING: see the warnings for PUSH.
+.macro POP reg
+    l.lwz  \reg, 0(STACK_POINTER_R1)
+    l.addi STACK_POINTER_R1, STACK_POINTER_R1, 4         
+.endm
+
+
+// ----------- l.nop definitions for simulation control and console output -----------
+
+
+// Register definitions for the simulation l.nop codes.
+#define NOP_REPORT_R3 r3
+#define NOP_EXIT_R3   r3
+
+
+// SEC = Simulation Exit Code
+#define SEC_SUCCESS            0
+#define SEC_RETURNED_FROM_MAIN 1
+#define SEC_GENERIC_ERROR      2
+
+// When running under the simulator, this l.nop code terminates the simulation.
+.macro EXIT_SIMULATION_WITH_IMMEDIATE_EXIT_CODE immediate_value
+    LOAD_IMMEDIATE NOP_EXIT_R3, \immediate_value
+    l.nop 1
+.endm
+
+.macro EXIT_SIMULATION_WITH_REG_EXIT_CODE reg
+    MOVE_REG NOP_EXIT_R3, \reg
+    l.nop 1
+.endm
+
+
+// When running under the simulator, this l.nop code prints the value of R3 to the console.
+.macro REPORT_TO_CONSOLE
+    l.nop 2
+.endm
+
+
+// NOTE: The stack must be set up, as this macro uses PUSH and POP.
+.macro REPORT_REG_TO_CONSOLE reg
+
+    .ifeqs "\reg","r3"
+
+        // Nothing more to do here, R3 is the register that gets printed.
+        REPORT_TO_CONSOLE
+
+    .else 
+
+        PUSH     NOP_REPORT_R3
+
+        MOVE_REG NOP_REPORT_R3, \reg
+        REPORT_TO_CONSOLE
+
+        POP      NOP_REPORT_R3
+
+    .endif
+
+.endm
+
+
+// NOTE: The stack must be set up, as this macro uses PUSH and POP.
+.macro REPORT_IMMEDIATE_TO_CONSOLE val
+
+    PUSH     NOP_REPORT_R3
+
+    LOAD_IMMEDIATE NOP_REPORT_R3, \val
+    REPORT_TO_CONSOLE
+
+    POP      NOP_REPORT_R3
+
+.endm
+
+
+.macro PRINT_NEWLINE_TO_CONSOLE
+
+    PUSH  r3
+
+    LOAD_IMMEDIATE r3, 0x0A
+    l.nop 4
+
+    POP   r3
+
+.endm
+
+
+// If SR[F] is set, writes 0x00000001 to the console, otherwise it writes 0x00000000.
+        
+.macro REPORT_SRF_TO_CONSOLE
+
+    OR1K_DELAYED_NOP(l.bnf \@1$)
+
+    REPORT_IMMEDIATE_TO_CONSOLE 0x00000001
+    OR1K_DELAYED_NOP(l.j \@2$)
+
+\@1$:
+    REPORT_IMMEDIATE_TO_CONSOLE 0x00000000
+
+\@2$:
+        
+.endm
+
+
+// If the given register is 0, writes 0x00000000 to the console, otherwise it writes 0x00000001.
+
+.macro REPORT_BOOL_TO_CONSOLE  reg
+
+  l.sfne \reg, ZERO_R0
+
+  REPORT_SRF_TO_CONSOLE
+        
+.endm
+
+
+// Writes to the console the value of the given register bit.
+
+.macro REPORT_BIT_TO_CONSOLE  reg, single_bit_mask
+
+    PUSH r2
+    PUSH r3
+    PUSH r4
+
+    MOVE_REG r2, \reg
+        
+    LOAD_IMMEDIATE r4, \single_bit_mask
+    l.and   r3, r2, r4
+
+    REPORT_BOOL_TO_CONSOLE r3
+        
+    POP r4
+    POP r3
+    POP r2
+
+.endm
+
+
+// ----------- Jump helpers -----------
+
+.macro CALL overwritten_reg, subroutine_name
+    LOAD_IMMEDIATE \overwritten_reg, \subroutine_name
+    OR1K_DELAYED_NOP(l.jalr  \overwritten_reg)
+.endm
+
+.macro RETURN_TO_LINK_REGISTER_R9
+    OR1K_DELAYED_NOP(l.jr LINK_REGISTER_R9)
+.endm
+
+
+// ----------- Clear the BSS section on start-up -----------
+        
+.macro CLEAR_BSS overwritten_reg1, overwritten_reg2
+
+        LOAD_IMMEDIATE \overwritten_reg1, _bss_begin
+        LOAD_IMMEDIATE \overwritten_reg2, _bss_end
+
+        l.sfgeu \overwritten_reg1, \overwritten_reg2
+        OR1K_DELAYED_NOP(l.bf    bss_is_empty)
+
+bss_clear_loop:
+        // Possible optimisation to investigate: move "l.sw 0(\overwritten_reg1), r0" to the jump delay slot
+        // as "l.sw -4(\overwritten_reg1), r0" or similar. But keep in mind that there are plans to remove
+        // the jump delay slot.
+        l.sw    0(\overwritten_reg1), r0
+        l.addi  \overwritten_reg1, \overwritten_reg1, 4
+        l.sfgtu \overwritten_reg2, \overwritten_reg1
+        OR1K_DELAYED_NOP(l.bf    bss_clear_loop)
+
+bss_is_empty:
+
+.endm
+
+
+#endif  // Include this file only once.
diff --git a/sim/testsuite/sim/or1k/or1k-asm.h b/sim/testsuite/sim/or1k/or1k-asm.h
new file mode 100644
index 0000000..c328b20
--- /dev/null
+++ b/sim/testsuite/sim/or1k/or1k-asm.h
@@ -0,0 +1,20 @@
+#ifndef OR1K_ASM_H
+#define OR1K_ASM_H
+
+#define OR1K_INST(...) __VA_ARGS__
+
+#if defined(__OR1K_NODELAY__)
+#define OR1K_DELAYED(a, b) a; b
+#define OR1K_DELAYED_NOP(a) a
+.nodelay
+#elif defined(__OR1K_DELAY__)
+#define OR1K_DELAYED(a, b) b; a
+#define OR1K_DELAYED_NOP(a) a; l.nop
+#elif defined(__OR1K_DELAY_COMPAT__)
+#define OR1K_DELAYED(a, b) a; b; l.nop
+#define OR1K_DELAYED_NOP(a) a; l.nop
+#else
+#error One of __OR1K_NODELAY__, __OR1K_DELAY__, or __OR1K_DELAY_COMPAT__ must be defined
+#endif
+
+#endif
diff --git a/sim/testsuite/sim/or1k/or1k-test.ld b/sim/testsuite/sim/or1k/or1k-test.ld
new file mode 100644
index 0000000..11ed9c9
--- /dev/null
+++ b/sim/testsuite/sim/or1k/or1k-test.ld
@@ -0,0 +1,57 @@
+
+MEMORY
+{
+    /* The exception vectors actually start at 0x100, but if you specify that address here,
+       the "--output-target binary" step will start from address 0 with the contents meant for address 0x100 */
+    exception_vectors : ORIGIN =  0 , LENGTH = 8K
+    ram               : ORIGIN =  8K, LENGTH = 2M - 8K
+}
+
+SECTIONS
+{
+    .exception_vectors :
+    {
+        KEEP(*(.exception_vectors))
+    } > exception_vectors
+
+    .text :
+    {
+        *(.text)
+        *(.text.*)
+        *(.rodata)
+        *(.rodata.*)
+    } > ram
+
+    .data :
+    {
+        *(.data)
+        *(.data.*)
+    } > ram
+
+
+    .bss :
+    {
+        *(.bss)
+        *(.bss.*)
+
+        /* WARNING about section size alignment:
+           The start-up assembly code can only clear BSS section sizes which are aligned to 4 bytes.
+           However, the size of the BSS  section may not be aligned, therefore up to 3 bytes more
+           could be zeroed on start-up. This is normally not an issue, as the start of the next section
+           is usually aligned too, so those extra bytes should be just padding. I did try the following
+           trick to align the BSS section size, to no avail:
+           . = ALIGN(., 4);
+        */
+    } > ram
+
+    _bss_begin = ADDR(.bss);
+    _bss_end   = _bss_begin + SIZEOF(.bss);
+
+
+    .stack ALIGN(16) (NOLOAD):
+    {
+      *(.stack)
+    } > ram
+}
+
+ENTRY(_start)  /* Otherwise, --gc-sections would throw everything away. */
diff --git a/sim/testsuite/sim/or1k/ror.S b/sim/testsuite/sim/or1k/ror.S
new file mode 100644
index 0000000..f263a8e
--- /dev/null
+++ b/sim/testsuite/sim/or1k/ror.S
@@ -0,0 +1,186 @@
+/* Tests instructions l.ror and l.rori
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0x3b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0x0f83b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0x671e1f07);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00002224);\n
+# output: report(0x3b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00f789f0);\n
+# output: report(0x0f83b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0xffffffff);\n
+# output: report(0x671e1f07);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0x3b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0x0f83b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0x671e1f07);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000024);\n
+# output: report(0x3b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000030);\n
+# output: report(0x0f83b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000003f);\n
+# output: report(0x671e1f07);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-env.h"
+
+
+.macro TEST_ROR op1, op2, res
+
+    // Note that 'res' is not used here. We could stop using the .TestResults file
+    // and use 'res' here instead.
+        
+    LOAD_IMMEDIATE r5, \op1
+    LOAD_IMMEDIATE r6, \op2
+
+    REPORT_REG_TO_CONSOLE r5
+    REPORT_REG_TO_CONSOLE r6
+
+    l.ror r4, r5, r6
+
+    REPORT_REG_TO_CONSOLE r4
+
+    PRINT_NEWLINE_TO_CONSOLE        
+
+.endm
+
+
+.macro TEST_RORI op1, op2, res
+
+    // Note that 'res' is not used here. We could stop using the .TestResults file
+    // and use 'res' here instead.
+        
+    LOAD_IMMEDIATE r5, \op1
+
+    REPORT_REG_TO_CONSOLE r5
+    REPORT_IMMEDIATE_TO_CONSOLE \op2        
+
+    l.rori r4, r5, \op2
+
+    REPORT_REG_TO_CONSOLE r4
+
+    PRINT_NEWLINE_TO_CONSOLE        
+
+.endm
+
+    
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+        // Test the l.ror instruction.
+        
+        // Rotate by zero
+        TEST_ROR 0xb38f0f83, 0x00000000, 0xb38f0f83
+
+        // Rotate by amounts in the 1 - 31 range.
+        TEST_ROR 0xb38f0f83, 0x00000001, 0xd9c787c1
+        TEST_ROR 0xb38f0f83, 0x00000004, 0x3b38f0f8
+        TEST_ROR 0xb38f0f83, 0x00000010, 0x0f83b38f
+        TEST_ROR 0xb38f0f83, 0x0000001f, 0x671e1f07
+
+        // Rotate by larger amounts - should be masked.
+        TEST_ROR 0xb38f0f83, 0x00000021, 0xd9c787c1
+        TEST_ROR 0xb38f0f83, 0x00002224, 0x3b38f0f8
+        TEST_ROR 0xb38f0f83, 0x00f789f0, 0x0f83b38f
+        TEST_ROR 0xb38f0f83, 0xffffffff, 0x671e1f07
+    
+
+        // Test the l.rori instruction.
+
+        // Rotate by zero */
+        TEST_RORI 0xb38f0f83, 0x00000000, 0xb38f0f83
+
+        // Rotate by amounts in the 1 - 31 range.
+        TEST_RORI 0xb38f0f83, 0x01, 0xd9c787c1
+        TEST_RORI 0xb38f0f83, 0x04, 0x3b38f0f8
+        TEST_RORI 0xb38f0f83, 0x10, 0x0f83b38f
+        TEST_RORI 0xb38f0f83, 0x1f, 0x671e1f07
+
+        // Rotate by larger amounts (32 - 63) - should be masked.
+        TEST_RORI 0xb38f0f83, 0x21, 0xd9c787c1
+        TEST_RORI 0xb38f0f83, 0x24, 0x3b38f0f8
+        TEST_RORI 0xb38f0f83, 0x30, 0x0f83b38f
+        TEST_RORI 0xb38f0f83, 0x3f, 0x671e1f07
+    
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/shift.S b/sim/testsuite/sim/or1k/shift.S
new file mode 100644
index 0000000..b4b3ea3
--- /dev/null
+++ b/sim/testsuite/sim/or1k/shift.S
@@ -0,0 +1,572 @@
+/* Tests the shift instructions.
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0x671e1f06);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0x38f0f830);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0x0f830000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0x80000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0x671e1f06);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00002224);\n
+# output: report(0x38f0f830);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00f789f0);\n
+# output: report(0x0f830000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0xffffffff);\n
+# output: report(0x80000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0x671e1f06);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0x38f0f830);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0x0f830000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0x80000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0x671e1f06);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000024);\n
+# output: report(0x38f0f830);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000030);\n
+# output: report(0x0f830000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000003f);\n
+# output: report(0x80000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0xfb38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0xffffb38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0xffffffff);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000001);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000004);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000010);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x0000001f);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00002224);\n
+# output: report(0xfb38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00f789f0);\n
+# output: report(0xffffb38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000021);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00002224);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00f789f0);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0xfb38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0xffffb38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0xffffffff);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000001);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000004);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000010);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x0000001f);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0xd9c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000024);\n
+# output: report(0xfb38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000030);\n
+# output: report(0xffffb38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000003f);\n
+# output: report(0xffffffff);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000021);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000024);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000030);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x0000003f);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0x59c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0x0b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0x0000b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0x00000001);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000001);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000004);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000010);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x0000001f);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0x59c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00002224);\n
+# output: report(0x0b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00f789f0);\n
+# output: report(0x0000b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000001);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000021);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00002224);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00f789f0);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000000);\n
+# output: report(0xb38f0f83);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000001);\n
+# output: report(0x59c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000004);\n
+# output: report(0x0b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000010);\n
+# output: report(0x0000b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000001f);\n
+# output: report(0x00000001);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000001);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000004);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000010);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x0000001f);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000021);\n
+# output: report(0x59c787c1);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000024);\n
+# output: report(0x0b38f0f8);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x00000030);\n
+# output: report(0x0000b38f);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000003f);\n
+# output: report(0x00000001);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000021);\n
+# output: report(0x2638783e);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000024);\n
+# output: report(0x04c70f07);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000030);\n
+# output: report(0x00004c70);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x0000003f);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+.macro TEST_SHIFT opcode, op1, op2
+        
+    LOAD_IMMEDIATE r5, \op1
+    LOAD_IMMEDIATE r6, \op2
+
+    REPORT_REG_TO_CONSOLE r5
+    REPORT_REG_TO_CONSOLE r6
+
+    \opcode r4, r5, r6
+
+    CHECK_CARRY_AND_OVERFLOW_NOT_SET r2, r3
+
+    REPORT_REG_TO_CONSOLE r4
+
+    PRINT_NEWLINE_TO_CONSOLE
+
+.endm
+
+        
+.macro TEST_SHIFT_I opcode, op1, op2
+
+    LOAD_IMMEDIATE r5, \op1
+
+    REPORT_REG_TO_CONSOLE r5
+    REPORT_IMMEDIATE_TO_CONSOLE \op2        
+
+    \opcode r4, r5, \op2
+
+    CHECK_CARRY_AND_OVERFLOW_NOT_SET r2, r3
+
+    REPORT_REG_TO_CONSOLE r4
+
+    PRINT_NEWLINE_TO_CONSOLE        
+
+.endm
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+	    // Always set OVE. We should never trigger an exception, even if this bit is set.
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+        
+
+        // Test l.sll
+
+	    // Shift left by zero. 
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x00000000
+
+	    // Shift left by amounts in the 1-31 range 
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x00000001
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x00000004
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x00000010
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x0000001f
+
+	    // Shift left by larger amounts - should be masked. 
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x00000021
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x00002224
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0x00f789f0
+	    TEST_SHIFT l.sll, 0xb38f0f83, 0xffffffff
+
+        
+        // Test l.slli
+        
+	    // Shift left by zero. 
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x0000
+
+	    // Shift left by amounts in the 1-31 range 
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x0001
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x0004
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x0010
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x001f
+
+	    // Shift left by larger amounts - should be masked. 
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x0021
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x0024
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x0030
+	    TEST_SHIFT_I l.slli, 0xb38f0f83, 0x003f
+
+
+        // Test l.sra
+        
+	    // Shift right by zero. 
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x00000000
+
+	    // Shift right by amounts in the 1-31 range 
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x00000001
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x00000004
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x00000010
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x0000001f
+
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0x00000001
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0x00000004
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0x00000010
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0x0000001f
+
+	    // Shift right by larger amounts - should be masked. 
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x00000021
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x00002224
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0x00f789f0
+	    TEST_SHIFT l.sra, 0xb38f0f83, 0xffffffff
+
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0x00000021
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0x00002224
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0x00f789f0
+	    TEST_SHIFT l.sra, 0x4c70f07c, 0xffffffff
+
+
+        // Test l.srai
+
+	    // Shift right by zero. 
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x0000
+
+	    // Shift right by amounts in the 1-31 range 
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x0001
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x0004
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x0010
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x001f
+
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x0001
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x0004
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x0010
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x001f
+
+	    // Shift right by larger amounts - should be masked. 
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x0021
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x0024
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x0030
+	    TEST_SHIFT_I l.srai, 0xb38f0f83, 0x003f
+
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x0021
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x0024
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x0030
+	    TEST_SHIFT_I l.srai, 0x4c70f07c, 0x003f
+
+
+        // Test l.srl
+
+	    // Shift right by zero. 
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x00000000
+
+	    // Shift right by amounts in the 1-31 range 
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x00000001
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x00000004
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x00000010
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x0000001f
+
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0x00000001
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0x00000004
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0x00000010
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0x0000001f
+
+	    // Shift right by larger amounts - should be masked. 
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x00000021
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x00002224
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0x00f789f0
+	    TEST_SHIFT l.srl, 0xb38f0f83, 0xffffffff
+
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0x00000021
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0x00002224
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0x00f789f0
+	    TEST_SHIFT l.srl, 0x4c70f07c, 0xffffffff
+
+        
+        // Test l.srli
+
+	    // Shift right by zero. 
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x0000
+
+	    // Shift right by amounts in the 1-31 range 
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x0001
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x0004
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x0010
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x001f
+
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x0001
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x0004
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x0010
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x001f
+
+	    // Shift right by larger amounts - should be masked. 
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x0021
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x0024
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x0030
+	    TEST_SHIFT_I l.srli, 0xb38f0f83, 0x003f
+
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x0021
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x0024
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x0030
+	    TEST_SHIFT_I l.srli, 0x4c70f07c, 0x003f
+
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/spr-defs.h b/sim/testsuite/sim/or1k/spr-defs.h
new file mode 100644
index 0000000..4499a75
--- /dev/null
+++ b/sim/testsuite/sim/or1k/spr-defs.h
@@ -0,0 +1,590 @@
+/* Special Purpose Registers definitions
+    
+   Copyright (C) 1999, 2000 Damjan Lampret, lampret at opencores.org
+   Copyright (C) 2008, 2010 Embecosm Limited
+     Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+   Copyright (C) 2012, R. Diez
+   
+   
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the Free
+   Software Foundation; either version 3 of the License, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+   more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+
+#ifndef SPR_DEFS_H
+#define SPR_DEFS_H
+
+#define MAX_GRPS 32
+#define MAX_SPRS_PER_GRP_BITS 11
+
+/* Base addresses for the groups */
+#define SPRGROUP_SYS   (0<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_DMMU  (1<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_IMMU  (2<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_DC    (3<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_IC    (4<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_MAC   (5<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_D     (6<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_PC    (7<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_PM    (8<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_PIC   (9<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_TT    (10<< MAX_SPRS_PER_GRP_BITS)
+#define SPRGROUP_FP    (11<< MAX_SPRS_PER_GRP_BITS)
+
+/* System control and status group */
+#define SPR_VR      (SPRGROUP_SYS + 0)   // Value: 0x0000
+#define SPR_UPR     (SPRGROUP_SYS + 1)   // Value: 0x0001
+#define SPR_CPUCFGR (SPRGROUP_SYS + 2)
+#define SPR_DMMUCFGR    (SPRGROUP_SYS + 3)
+#define SPR_IMMUCFGR    (SPRGROUP_SYS + 4)
+#define SPR_DCCFGR  (SPRGROUP_SYS + 5)
+#define SPR_ICCFGR  (SPRGROUP_SYS + 6)
+#define SPR_DCFGR   (SPRGROUP_SYS + 7)
+#define SPR_PCCFGR  (SPRGROUP_SYS + 8)
+#define SPR_NPC         (SPRGROUP_SYS + 16)  /* CZ 21/06/01 */
+#define SPR_SR      (SPRGROUP_SYS + 17)  /* CZ 21/06/01 */
+#define SPR_PPC         (SPRGROUP_SYS + 18)  /* CZ 21/06/01 */
+#define SPR_FPCSR       (SPRGROUP_SYS + 20)  /* CZ 21/06/01 */
+#define SPR_EPCR_BASE   (SPRGROUP_SYS + 32)  /* CZ 21/06/01 */
+#define SPR_EPCR_LAST   (SPRGROUP_SYS + 47)  /* CZ 21/06/01 */
+#define SPR_EEAR_BASE   (SPRGROUP_SYS + 48)
+#define SPR_EEAR_LAST   (SPRGROUP_SYS + 63)
+#define SPR_ESR_BASE    (SPRGROUP_SYS + 64)
+#define SPR_ESR_LAST    (SPRGROUP_SYS + 79)
+#define SPR_GPR_BASE    (SPRGROUP_SYS + 1024)
+
+/* Data MMU group */
+#define SPR_DMMUCR  (SPRGROUP_DMMU + 0)  // Value: 0x0800
+#define SPR_DMMUPR  (SPRGROUP_DMMU + 1)  // Value: 0x0801
+#define SPR_DTLBEIR     (SPRGROUP_DMMU + 2)
+#define SPR_DTLBMR_BASE(WAY)    (SPRGROUP_DMMU + 0x200 + (WAY) * 0x100)
+#define SPR_DTLBMR_LAST(WAY)    (SPRGROUP_DMMU + 0x27f + (WAY) * 0x100)
+#define SPR_DTLBTR_BASE(WAY)    (SPRGROUP_DMMU + 0x280 + (WAY) * 0x100)
+#define SPR_DTLBTR_LAST(WAY)    (SPRGROUP_DMMU + 0x2ff + (WAY) * 0x100)
+
+/* Instruction MMU group */
+#define SPR_IMMUCR  (SPRGROUP_IMMU + 0)
+#define SPR_ITLBEIR     (SPRGROUP_IMMU + 2)
+#define SPR_ITLBMR_BASE(WAY)    (SPRGROUP_IMMU + 0x200 + (WAY) * 0x100)
+#define SPR_ITLBMR_LAST(WAY)    (SPRGROUP_IMMU + 0x27f + (WAY) * 0x100)
+#define SPR_ITLBTR_BASE(WAY)    (SPRGROUP_IMMU + 0x280 + (WAY) * 0x100)
+#define SPR_ITLBTR_LAST(WAY)    (SPRGROUP_IMMU + 0x2ff + (WAY) * 0x100)
+
+/* Data cache group */
+#define SPR_DCCR    (SPRGROUP_DC + 0)
+#define SPR_DCBPR   (SPRGROUP_DC + 1)
+#define SPR_DCBFR   (SPRGROUP_DC + 2)
+#define SPR_DCBIR   (SPRGROUP_DC + 3)
+#define SPR_DCBWR   (SPRGROUP_DC + 4)
+#define SPR_DCBLR   (SPRGROUP_DC + 5)
+#define SPR_DCR_BASE(WAY)   (SPRGROUP_DC + 0x200 + (WAY) * 0x200)
+#define SPR_DCR_LAST(WAY)   (SPRGROUP_DC + 0x3ff + (WAY) * 0x200)
+
+/* Instruction cache group */
+#define SPR_ICCR    (SPRGROUP_IC + 0)  // Value: 0x2000
+#define SPR_ICBPR   (SPRGROUP_IC + 1)
+#define SPR_ICBIR   (SPRGROUP_IC + 2)
+#define SPR_ICBLR   (SPRGROUP_IC + 3)
+#define SPR_ICR_BASE(WAY)   (SPRGROUP_IC + 0x200 + (WAY) * 0x200)
+#define SPR_ICR_LAST(WAY)   (SPRGROUP_IC + 0x3ff + (WAY) * 0x200)
+
+/* MAC group */
+#define SPR_MACLO   (SPRGROUP_MAC + 1)  // Value: 0x2801
+#define SPR_MACHI   (SPRGROUP_MAC + 2)
+
+/* Debug group */
+#define SPR_DVR(N)  (SPRGROUP_D + (N))
+#define SPR_DCR(N)  (SPRGROUP_D + 8 + (N))
+#define SPR_DMR1    (SPRGROUP_D + 16)
+#define SPR_DMR2    (SPRGROUP_D + 17)
+#define SPR_DWCR0   (SPRGROUP_D + 18)
+#define SPR_DWCR1   (SPRGROUP_D + 19)
+#define SPR_DSR     (SPRGROUP_D + 20)
+#define SPR_DRR     (SPRGROUP_D + 21)
+
+/* Performance counters group */
+#define SPR_PCCR(N) (SPRGROUP_PC + (N))
+#define SPR_PCMR(N) (SPRGROUP_PC + 8 + (N))
+
+/* Power management group */
+#define SPR_PMR (SPRGROUP_PM + 0)
+
+/* PIC group */
+#define SPR_PICMR (SPRGROUP_PIC + 0)
+#define SPR_PICPR (SPRGROUP_PIC + 1)
+#define SPR_PICSR (SPRGROUP_PIC + 2)
+
+/* Tick Timer group */
+#define SPR_TTMR (SPRGROUP_TT + 0)
+#define SPR_TTCR (SPRGROUP_TT + 1)
+
+/*
+ * Bit definitions for the Version Register
+ *
+ */
+#define SPR_VR_VER  0xff000000  /* Processor version */
+#define SPR_VR_CFG  0x00ff0000  /* Processor configuration */
+#define SPR_VR_RES  0x0000ffc0  /* Reserved */
+#define SPR_VR_REV  0x0000003f  /* Processor revision */
+
+#define SPR_VR_VER_OFF  24
+#define SPR_VR_CFG_OFF  16
+#define SPR_VR_REV_OFF  0
+
+/*
+ * Bit definitions for the Unit Present Register
+ *
+ */
+#define SPR_UPR_UP     0x00000001  /* UPR present */
+#define SPR_UPR_DCP    0x00000002  /* Data cache present */
+#define SPR_UPR_ICP    0x00000004  /* Instruction cache present */
+#define SPR_UPR_DMP    0x00000008  /* Data MMU present */
+#define SPR_UPR_IMP    0x00000010  /* Instruction MMU present */
+#define SPR_UPR_MP     0x00000020  /* MAC present */
+#define SPR_UPR_DUP    0x00000040  /* Debug unit present */
+#define SPR_UPR_PCUP       0x00000080  /* Performance counters unit present */
+#define SPR_UPR_PMP    0x00000100  /* Power management present */
+#define SPR_UPR_PICP       0x00000200  /* PIC present */
+#define SPR_UPR_TTP    0x00000400  /* Tick timer present */
+#define SPR_UPR_RES    0x00fe0000  /* Reserved */
+#define SPR_UPR_CUP    0xff000000  /* Context units present */
+
+/*
+ * JPB: Bit definitions for the CPU configuration register
+ *
+ */
+#define SPR_CPUCFGR_NSGF   0x0000000f  /* Number of shadow GPR files */
+#define SPR_CPUCFGR_CGF    0x00000010  /* Custom GPR file */
+#define SPR_CPUCFGR_OB32S  0x00000020  /* ORBIS32 supported */
+#define SPR_CPUCFGR_OB64S  0x00000040  /* ORBIS64 supported */
+#define SPR_CPUCFGR_OF32S  0x00000080  /* ORFPX32 supported */
+#define SPR_CPUCFGR_OF64S  0x00000100  /* ORFPX64 supported */
+#define SPR_CPUCFGR_OV64S  0x00000200  /* ORVDX64 supported */
+#define SPR_CPUCFGR_RES    0xfffffc00  /* Reserved */
+
+/*
+ * JPB: Bit definitions for the Debug configuration register and other
+ * constants.
+ *
+ */
+
+#define SPR_DCFGR_NDP      0x00000007  /* Number of matchpoints mask */
+#define SPR_DCFGR_NDP1     0x00000000  /* One matchpoint supported */
+#define SPR_DCFGR_NDP2     0x00000001  /* Two matchpoints supported */
+#define SPR_DCFGR_NDP3     0x00000002  /* Three matchpoints supported */
+#define SPR_DCFGR_NDP4     0x00000003  /* Four matchpoints supported */
+#define SPR_DCFGR_NDP5     0x00000004  /* Five matchpoints supported */
+#define SPR_DCFGR_NDP6     0x00000005  /* Six matchpoints supported */
+#define SPR_DCFGR_NDP7     0x00000006  /* Seven matchpoints supported */
+#define SPR_DCFGR_NDP8     0x00000007  /* Eight matchpoints supported */
+#define SPR_DCFGR_WPCI     0x00000008  /* Watchpoint counters implemented */
+
+#define MATCHPOINTS_TO_NDP(n) (1 == n ? SPR_DCFGR_NDP1 : \
+                               2 == n ? SPR_DCFGR_NDP2 : \
+                               3 == n ? SPR_DCFGR_NDP3 : \
+                               4 == n ? SPR_DCFGR_NDP4 : \
+                               5 == n ? SPR_DCFGR_NDP5 : \
+                               6 == n ? SPR_DCFGR_NDP6 : \
+                               7 == n ? SPR_DCFGR_NDP7 : SPR_DCFGR_NDP8)
+#define MAX_MATCHPOINTS  8
+#define MAX_WATCHPOINTS  (MAX_MATCHPOINTS + 2)
+
+/*
+ * Bit definitions for the Supervision Register
+ *
+ */
+#define SPR_SR_SM          0x00000001  /* Supervisor Mode */
+#define SPR_SR_TEE         0x00000002  /* Tick timer Exception Enable */
+#define SPR_SR_IEE         0x00000004  /* Interrupt Exception Enable */
+#define SPR_SR_DCE         0x00000008  /* Data Cache Enable */
+#define SPR_SR_ICE         0x00000010  /* Instruction Cache Enable */
+#define SPR_SR_DME         0x00000020  /* Data MMU Enable */
+#define SPR_SR_IME         0x00000040  /* Instruction MMU Enable */
+#define SPR_SR_LEE         0x00000080  /* Little Endian Enable */
+#define SPR_SR_CE          0x00000100  /* CID Enable */
+#define SPR_SR_F           0x00000200  /* Condition Flag */
+#define SPR_SR_CY          0x00000400  /* Carry flag */
+#define SPR_SR_OV          0x00000800  /* Overflow flag */
+#define SPR_SR_OVE         0x00001000  /* Overflow flag Exception */
+#define SPR_SR_DSX         0x00002000  /* Delay Slot Exception */
+#define SPR_SR_EPH         0x00004000  /* Exception Prefix High */
+#define SPR_SR_FO          0x00008000  /* Fixed one */
+#define SPR_SR_SUMRA       0x00010000  /* Supervisor SPR read access */
+#define SPR_SR_RES         0x0ffe0000  /* Reserved */
+#define SPR_SR_CID         0xf0000000  /* Context ID */
+
+/*
+ * Bit definitions for the Data MMU Control Register
+ *
+ */
+#define SPR_DMMUCR_P2S     0x0000003e  /* Level 2 Page Size */
+#define SPR_DMMUCR_P1S     0x000007c0  /* Level 1 Page Size */
+#define SPR_DMMUCR_VADDR_WIDTH  0x0000f800  /* Virtual ADDR Width */
+#define SPR_DMMUCR_PADDR_WIDTH  0x000f0000  /* Physical ADDR Width */
+
+/*
+ * Bit definitions for the Instruction MMU Control Register
+ *
+ */
+#define SPR_IMMUCR_P2S     0x0000003e  /* Level 2 Page Size */
+#define SPR_IMMUCR_P1S     0x000007c0  /* Level 1 Page Size */
+#define SPR_IMMUCR_VADDR_WIDTH  0x0000f800  /* Virtual ADDR Width */
+#define SPR_IMMUCR_PADDR_WIDTH  0x000f0000  /* Physical ADDR Width */
+
+/*
+ * Bit definitions for the Data TLB Match Register
+ *
+ */
+#define SPR_DTLBMR_V       0x00000001  /* Valid */
+#define SPR_DTLBMR_PL1     0x00000002  /* Page Level 1 (if 0 then PL2) */
+#define SPR_DTLBMR_CID     0x0000003c  /* Context ID */
+#define SPR_DTLBMR_LRU     0x000000c0  /* Least Recently Used */
+#define SPR_DTLBMR_VPN     0xffffe000  /* Virtual Page Number */
+
+/*
+ * Bit definitions for the Data TLB Translate Register
+ *
+ */
+#define SPR_DTLBTR_CC      0x00000001  /* Cache Coherency */
+#define SPR_DTLBTR_CI      0x00000002  /* Cache Inhibit */
+#define SPR_DTLBTR_WBC     0x00000004  /* Write-Back Cache */
+#define SPR_DTLBTR_WOM     0x00000008  /* Weakly-Ordered Memory */
+#define SPR_DTLBTR_A       0x00000010  /* Accessed */
+#define SPR_DTLBTR_D       0x00000020  /* Dirty */
+#define SPR_DTLBTR_URE     0x00000040  /* User Read Enable */
+#define SPR_DTLBTR_UWE     0x00000080  /* User Write Enable */
+#define SPR_DTLBTR_SRE     0x00000100  /* Supervisor Read Enable */
+#define SPR_DTLBTR_SWE     0x00000200  /* Supervisor Write Enable */
+#define SPR_DTLBTR_PPN     0xffffe000  /* Physical Page Number */
+
+/*
+ * Bit definitions for the Instruction TLB Match Register
+ *
+ */
+#define SPR_ITLBMR_V       0x00000001  /* Valid */
+#define SPR_ITLBMR_PL1     0x00000002  /* Page Level 1 (if 0 then PL2) */
+#define SPR_ITLBMR_CID     0x0000003c  /* Context ID */
+#define SPR_ITLBMR_LRU     0x000000c0  /* Least Recently Used */
+#define SPR_ITLBMR_VPN     0xffffe000  /* Virtual Page Number */
+
+/*
+ * Bit definitions for the Instruction TLB Translate Register
+ *
+ */
+#define SPR_ITLBTR_CC      0x00000001  /* Cache Coherency */
+#define SPR_ITLBTR_CI      0x00000002  /* Cache Inhibit */
+#define SPR_ITLBTR_WBC     0x00000004  /* Write-Back Cache */
+#define SPR_ITLBTR_WOM     0x00000008  /* Weakly-Ordered Memory */
+#define SPR_ITLBTR_A       0x00000010  /* Accessed */
+#define SPR_ITLBTR_D       0x00000020  /* Dirty */
+#define SPR_ITLBTR_SXE     0x00000040  /* User Read Enable */
+#define SPR_ITLBTR_UXE     0x00000080  /* User Write Enable */
+#define SPR_ITLBTR_PPN     0xffffe000  /* Physical Page Number */
+
+/*
+ * Bit definitions for Data Cache Control register
+ *
+ */
+#define SPR_DCCR_EW    0x000000ff  /* Enable ways */
+
+/*
+ * Bit definitions for Insn Cache Control register
+ *
+ */
+#define SPR_ICCR_EW    0x000000ff  /* Enable ways */
+
+/*
+ * Bit definitions for Data Cache Configuration Register
+ *
+ */
+
+#define SPR_DCCFGR_NCW      0x00000007
+#define SPR_DCCFGR_NCS      0x00000078
+#define SPR_DCCFGR_CBS      0x00000080
+#define SPR_DCCFGR_CWS      0x00000100
+#define SPR_DCCFGR_CCRI     0x00000200
+#define SPR_DCCFGR_CBIRI    0x00000400
+#define SPR_DCCFGR_CBPRI    0x00000800
+#define SPR_DCCFGR_CBLRI    0x00001000
+#define SPR_DCCFGR_CBFRI    0x00002000
+#define SPR_DCCFGR_CBWBRI   0x00004000
+
+#define SPR_DCCFGR_NCW_OFF      0
+#define SPR_DCCFGR_NCS_OFF      3
+#define SPR_DCCFGR_CBS_OFF  7
+
+/*
+ * Bit definitions for Instruction Cache Configuration Register
+ *
+ */
+#define SPR_ICCFGR_NCW      0x00000007
+#define SPR_ICCFGR_NCS      0x00000078
+#define SPR_ICCFGR_CBS      0x00000080
+#define SPR_ICCFGR_CCRI     0x00000200
+#define SPR_ICCFGR_CBIRI    0x00000400
+#define SPR_ICCFGR_CBPRI    0x00000800
+#define SPR_ICCFGR_CBLRI    0x00001000
+
+#define SPR_ICCFGR_NCW_OFF      0
+#define SPR_ICCFGR_NCS_OFF      3
+#define SPR_ICCFGR_CBS_OFF  7
+
+/*
+ * Bit definitions for Data MMU Configuration Register
+ *
+ */
+
+#define SPR_DMMUCFGR_NTW    0x00000003
+#define SPR_DMMUCFGR_NTS    0x0000001C
+#define SPR_DMMUCFGR_NAE    0x000000E0
+#define SPR_DMMUCFGR_CRI    0x00000100
+#define SPR_DMMUCFGR_PRI        0x00000200
+#define SPR_DMMUCFGR_TEIRI  0x00000400
+#define SPR_DMMUCFGR_HTR    0x00000800
+
+#define SPR_DMMUCFGR_NTW_OFF    0
+#define SPR_DMMUCFGR_NTS_OFF    2
+
+/*
+ * Bit definitions for Instruction MMU Configuration Register
+ *
+ */
+
+#define SPR_IMMUCFGR_NTW    0x00000003
+#define SPR_IMMUCFGR_NTS    0x0000001C
+#define SPR_IMMUCFGR_NAE    0x000000E0
+#define SPR_IMMUCFGR_CRI    0x00000100
+#define SPR_IMMUCFGR_PRI    0x00000200
+#define SPR_IMMUCFGR_TEIRI  0x00000400
+#define SPR_IMMUCFGR_HTR    0x00000800
+
+#define SPR_IMMUCFGR_NTW_OFF    0
+#define SPR_IMMUCFGR_NTS_OFF    2
+
+/*
+ * Bit definitions for Debug Control registers
+ *
+ */
+#define SPR_DCR_DP  0x00000001  /* DVR/DCR present */
+#define SPR_DCR_CC  0x0000000e  /* Compare condition */
+#define SPR_DCR_SC  0x00000010  /* Signed compare */
+#define SPR_DCR_CT  0x000000e0  /* Compare to */
+
+/* Bit results with SPR_DCR_CC mask */
+#define SPR_DCR_CC_MASKED 0x00000000
+#define SPR_DCR_CC_EQUAL  0x00000002
+#define SPR_DCR_CC_LESS   0x00000004
+#define SPR_DCR_CC_LESSE  0x00000006
+#define SPR_DCR_CC_GREAT  0x00000008
+#define SPR_DCR_CC_GREATE 0x0000000a
+#define SPR_DCR_CC_NEQUAL 0x0000000c
+
+/* Bit results with SPR_DCR_CT mask */
+#define SPR_DCR_CT_DISABLED 0x00000000
+#define SPR_DCR_CT_IFEA     0x00000020
+#define SPR_DCR_CT_LEA      0x00000040
+#define SPR_DCR_CT_SEA      0x00000060
+#define SPR_DCR_CT_LD       0x00000080
+#define SPR_DCR_CT_SD       0x000000a0
+#define SPR_DCR_CT_LSEA     0x000000c0
+#define SPR_DCR_CT_LSD      0x000000e0
+/* SPR_DCR_CT_LSD doesn't seem to be implemented anywhere in or1ksim. 2004-1-30 HP */
+
+/*
+ * Bit definitions for Debug Mode 1 register
+ *
+ */
+#define SPR_DMR1_CW       0x000fffff  /* Chain register pair data */
+#define SPR_DMR1_CW0_AND  0x00000001
+#define SPR_DMR1_CW0_OR   0x00000002
+#define SPR_DMR1_CW0      (SPR_DMR1_CW0_AND | SPR_DMR1_CW0_OR)
+#define SPR_DMR1_CW1_AND  0x00000004
+#define SPR_DMR1_CW1_OR   0x00000008
+#define SPR_DMR1_CW1      (SPR_DMR1_CW1_AND | SPR_DMR1_CW1_OR)
+#define SPR_DMR1_CW2_AND  0x00000010
+#define SPR_DMR1_CW2_OR   0x00000020
+#define SPR_DMR1_CW2      (SPR_DMR1_CW2_AND | SPR_DMR1_CW2_OR)
+#define SPR_DMR1_CW3_AND  0x00000040
+#define SPR_DMR1_CW3_OR   0x00000080
+#define SPR_DMR1_CW3      (SPR_DMR1_CW3_AND | SPR_DMR1_CW3_OR)
+#define SPR_DMR1_CW4_AND  0x00000100
+#define SPR_DMR1_CW4_OR   0x00000200
+#define SPR_DMR1_CW4      (SPR_DMR1_CW4_AND | SPR_DMR1_CW4_OR)
+#define SPR_DMR1_CW5_AND  0x00000400
+#define SPR_DMR1_CW5_OR   0x00000800
+#define SPR_DMR1_CW5      (SPR_DMR1_CW5_AND | SPR_DMR1_CW5_OR)
+#define SPR_DMR1_CW6_AND  0x00001000
+#define SPR_DMR1_CW6_OR   0x00002000
+#define SPR_DMR1_CW6      (SPR_DMR1_CW6_AND | SPR_DMR1_CW6_OR)
+#define SPR_DMR1_CW7_AND  0x00004000
+#define SPR_DMR1_CW7_OR   0x00008000
+#define SPR_DMR1_CW7      (SPR_DMR1_CW7_AND | SPR_DMR1_CW7_OR)
+#define SPR_DMR1_CW8_AND  0x00010000
+#define SPR_DMR1_CW8_OR   0x00020000
+#define SPR_DMR1_CW8      (SPR_DMR1_CW8_AND | SPR_DMR1_CW8_OR)
+#define SPR_DMR1_CW9_AND  0x00040000
+#define SPR_DMR1_CW9_OR   0x00080000
+#define SPR_DMR1_CW9      (SPR_DMR1_CW9_AND | SPR_DMR1_CW9_OR)
+#define SPR_DMR1_RES1      0x00300000  /* Reserved */
+#define SPR_DMR1_ST   0x00400000  /* Single-step trace*/
+#define SPR_DMR1_BT   0x00800000  /* Branch trace */
+#define SPR_DMR1_RES2     0xff000000  /* Reserved */
+
+/*
+ * Bit definitions for Debug Mode 2 register. AWTC and WGB corrected by JPB
+ *
+ */
+#define SPR_DMR2_WCE0      0x00000001  /* Watchpoint counter 0 enable */
+#define SPR_DMR2_WCE1      0x00000002  /* Watchpoint counter 0 enable */
+#define SPR_DMR2_AWTC      0x00000ffc  /* Assign watchpoints to counters */
+#define SPR_DMR2_AWTC_OFF           2  /* Bit offset to AWTC field */
+#define SPR_DMR2_WGB       0x003ff000  /* Watchpoints generating breakpoint */
+#define SPR_DMR2_WGB_OFF           12  /* Bit offset to WGB field */
+#define SPR_DMR2_WBS       0xffc00000  /* JPB: Watchpoint status */
+#define SPR_DMR2_WBS_OFF           22  /* Bit offset to WBS field */
+
+/*
+ * Bit definitions for Debug watchpoint counter registers
+ *
+ */
+#define SPR_DWCR_COUNT      0x0000ffff  /* Count */
+#define SPR_DWCR_MATCH      0xffff0000  /* Match */
+#define SPR_DWCR_MATCH_OFF          16  /* Match bit offset */
+
+/*
+ * Bit definitions for Debug stop register
+ *
+ */
+#define SPR_DSR_RSTE    0x00000001  /* Reset exception */
+#define SPR_DSR_BUSEE   0x00000002  /* Bus error exception */
+#define SPR_DSR_DPFE    0x00000004  /* Data Page Fault exception */
+#define SPR_DSR_IPFE    0x00000008  /* Insn Page Fault exception */
+#define SPR_DSR_TTE 0x00000010  /* Tick Timer exception */
+#define SPR_DSR_AE  0x00000020  /* Alignment exception */
+#define SPR_DSR_IIE 0x00000040  /* Illegal Instruction exception */
+#define SPR_DSR_IE  0x00000080  /* Interrupt exception */
+#define SPR_DSR_DME 0x00000100  /* DTLB miss exception */
+#define SPR_DSR_IME 0x00000200  /* ITLB miss exception */
+#define SPR_DSR_RE  0x00000400  /* Range exception */
+#define SPR_DSR_SCE 0x00000800  /* System call exception */
+#define SPR_DSR_FPE     0x00001000  /* Floating Point Exception */
+#define SPR_DSR_TE  0x00002000  /* Trap exception */
+
+/*
+ * Bit definitions for Debug reason register
+ *
+ */
+#define SPR_DRR_RSTE    0x00000001  /* Reset exception */
+#define SPR_DRR_BUSEE   0x00000002  /* Bus error exception */
+#define SPR_DRR_DPFE    0x00000004  /* Data Page Fault exception */
+#define SPR_DRR_IPFE    0x00000008  /* Insn Page Fault exception */
+#define SPR_DRR_TTE 0x00000010  /* Tick Timer exception */
+#define SPR_DRR_AE  0x00000020  /* Alignment exception */
+#define SPR_DRR_IIE 0x00000040  /* Illegal Instruction exception */
+#define SPR_DRR_IE  0x00000080  /* Interrupt exception */
+#define SPR_DRR_DME 0x00000100  /* DTLB miss exception */
+#define SPR_DRR_IME 0x00000200  /* ITLB miss exception */
+#define SPR_DRR_RE  0x00000400  /* Range exception */
+#define SPR_DRR_SCE 0x00000800  /* System call exception */
+#define SPR_DRR_FPE     0x00001000  /* Floating Point Exception */
+#define SPR_DRR_TE  0x00002000  /* Trap exception */
+
+/*
+ * Bit definitions for Performance counters mode registers
+ *
+ */
+#define SPR_PCMR_CP 0x00000001  /* Counter present */
+#define SPR_PCMR_UMRA   0x00000002  /* User mode read access */
+#define SPR_PCMR_CISM   0x00000004  /* Count in supervisor mode */
+#define SPR_PCMR_CIUM   0x00000008  /* Count in user mode */
+#define SPR_PCMR_LA 0x00000010  /* Load access event */
+#define SPR_PCMR_SA 0x00000020  /* Store access event */
+#define SPR_PCMR_IF 0x00000040  /* Instruction fetch event*/
+#define SPR_PCMR_DCM    0x00000080  /* Data cache miss event */
+#define SPR_PCMR_ICM    0x00000100  /* Insn cache miss event */
+#define SPR_PCMR_IFS    0x00000200  /* Insn fetch stall event */
+#define SPR_PCMR_LSUS   0x00000400  /* LSU stall event */
+#define SPR_PCMR_BS 0x00000800  /* Branch stall event */
+#define SPR_PCMR_DTLBM  0x00001000  /* DTLB miss event */
+#define SPR_PCMR_ITLBM  0x00002000  /* ITLB miss event */
+#define SPR_PCMR_DDS    0x00004000  /* Data dependency stall event */
+#define SPR_PCMR_WPE    0x03ff8000  /* Watchpoint events */
+
+/* 
+ * Bit definitions for the Power management register
+ *
+ */
+#define SPR_PMR_SDF 0x0000000f  /* Slow down factor */
+#define SPR_PMR_DME 0x00000010  /* Doze mode enable */
+#define SPR_PMR_SME 0x00000020  /* Sleep mode enable */
+#define SPR_PMR_DCGE    0x00000040  /* Dynamic clock gating enable */
+#define SPR_PMR_SUME    0x00000080  /* Suspend mode enable */
+
+/*
+ * Bit definitions for PICMR
+ *
+ */
+#define SPR_PICMR_IUM   0xfffffffc  /* Interrupt unmask */
+
+/*
+ * Bit definitions for PICPR
+ *
+ */
+#define SPR_PICPR_IPRIO 0xfffffffc  /* Interrupt priority */
+ 
+/*
+ * Bit definitions for PICSR
+ *
+ */
+#define SPR_PICSR_IS    0xffffffff  /* Interrupt status */
+
+/*
+ * Bit definitions for Tick Timer Control Register
+ *
+ */
+#define SPR_TTCR_CNT    0xffffffff  /* Count, time period */
+#define SPR_TTMR_TP     0x0fffffff  /* Time period */
+#define SPR_TTMR_IP 0x10000000  /* Interrupt Pending */
+#define SPR_TTMR_IE 0x20000000  /* Interrupt Enable */
+#define SPR_TTMR_DI 0x00000000  /* Disabled */
+#define SPR_TTMR_RT 0x40000000  /* Restart tick */
+#define SPR_TTMR_SR     0x80000000  /* Single run */
+#define SPR_TTMR_CR     0xc0000000  /* Continuous run */
+#define SPR_TTMR_M      0xc0000000  /* Tick mode */
+
+/*
+ * Bit definitions for the FP Control Status Register
+ *
+ */
+#define SPR_FPCSR_FPEE  0x00000001  /* Floating Point Exception Enable */
+#define SPR_FPCSR_RM    0x00000006  /* Rounding Mode */
+#define SPR_FPCSR_OVF   0x00000008  /* Overflow Flag */
+#define SPR_FPCSR_UNF   0x00000010  /* Underflow Flag */
+#define SPR_FPCSR_SNF   0x00000020  /* SNAN Flag */
+#define SPR_FPCSR_QNF   0x00000040  /* QNAN Flag */
+#define SPR_FPCSR_ZF    0x00000080  /* Zero Flag */
+#define SPR_FPCSR_IXF   0x00000100  /* Inexact Flag */
+#define SPR_FPCSR_IVF   0x00000200  /* Invalid Flag */
+#define SPR_FPCSR_INF   0x00000400  /* Infinity Flag */
+#define SPR_FPCSR_DZF   0x00000800  /* Divide By Zero Flag */
+#define SPR_FPCSR_ALLF (SPR_FPCSR_OVF | SPR_FPCSR_UNF | SPR_FPCSR_SNF | \
+            SPR_FPCSR_QNF | SPR_FPCSR_ZF | SPR_FPCSR_IXF |  \
+            SPR_FPCSR_IVF | SPR_FPCSR_INF | SPR_FPCSR_DZF)
+
+#define FPCSR_RM_RN (0<<1)
+#define FPCSR_RM_RZ (1<<1)
+#define FPCSR_RM_RIP (2<<1)
+#define FPCSR_RM_RIN (3<<1)
+
+
+#endif  // Include this file only once.
+
diff --git a/sim/testsuite/sim/or1k/sub.S b/sim/testsuite/sim/or1k/sub.S
new file mode 100644
index 0000000..0da4cf0
--- /dev/null
+++ b/sim/testsuite/sim/or1k/sub.S
@@ -0,0 +1,176 @@
+/* Tests instruction l.sub
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000003);\n
+# output: report(0x00000002);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000001);\n
+# output: report(0x00000002);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000003);\n
+# output: report(0x00000002);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xfffffffd);\n
+# output: report(0xfffffffe);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xfffffffe);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x7fffffff);\n
+# output: report(0x3fffffff);\n
+# output: report(0x40000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x40000000);\n
+# output: report(0x40000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x3fffffff);\n
+# output: report(0x40000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x40000000);\n
+# output: report(0x3fffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x80000000);\n
+# output: report(0x7fffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x3fffffff);\n
+# output: report(0x40000000);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000001);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+
+        // ----------- Test l.sub -----------
+
+        // Subtract two small positive numbers. Sets the carry, but never the overflow if the result is negative.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x00000003, 0x00000002
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x00000001, 0x00000002
+
+        // Check carry in is ignored.
+        TEST_INST_FF_I32_I32 SPR_SR_CY, SPR_SR_OV, l.sub, 0x00000003, 0x00000002
+
+        // Subtract two small negative numbers. Sets the carry flag if the
+        // result is negative, but never the overflow flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0xfffffffd, 0xfffffffe
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0xffffffff, 0xfffffffe
+
+        // Subtract two quite large positive numbers. Should set neither the
+        // overflow nor the carry flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x7fffffff, 0x3fffffff
+
+        // Subtract two quite large negative numbers. Should set neither the overflow nor the carry flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x40000000, 0x40000000
+
+        // Subtract two large positive numbers with a negative result. Should
+        // set the carry, but not the overflow flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x3fffffff, 0x40000000
+
+        // Subtract two large negative numbers with a positive result. Should
+        // set neither the carry nor the overflow flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x40000000, 0x3fffffff
+
+        // Subtract a large positive from a large negative number. Should set
+        // overflow but not the carry flag.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x80000000, 0x7fffffff
+
+        // Subtract a large negative from a large positive number. Should set
+        // both the overflow and carry flags.
+        // TODO: disabled, as it fails against ORPSoC V2
+        // TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x7fffffff, 0x80000000
+
+
+        // ------ Check that range exceptions are triggered.
+        
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        
+        /*  TODO: exceptions test disabled until or1200 fix is in place.
+        // Check that an overflow alone causes a RANGE Exception.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x80000000, 0x7fffffff
+        */
+
+        // Check that a carry alone does not cause a RANGE Exception.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x3fffffff, 0x40000000
+
+        /*  TODO: exceptions test disabled until or1200 fix is in place.
+        // Check that carry and overflow together cause an exception.
+        TEST_INST_FF_I32_I32 0, SPR_SR_CY | SPR_SR_OV, l.sub, 0x7fffffff, 0x80000000
+        */
+       
+        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
diff --git a/sim/testsuite/sim/or1k/xor.S b/sim/testsuite/sim/or1k/xor.S
new file mode 100644
index 0000000..4864615
--- /dev/null
+++ b/sim/testsuite/sim/or1k/xor.S
@@ -0,0 +1,210 @@
+/* Tests instructions l.xor, l.xori
+ *
+ * This is not a comprehensive test of any instruction (yet).
+ * Of course what is really needed is a comprehensive instruction test...
+ *
+ * 
+ * Copyright (C) 1999-2006 OpenCores
+ *   Contributors various OpenCores participants
+ * Copyright (C) 2010 Embecosm Limited
+ *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
+ * Copyright (C) 2012 R. Diez
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 3 of the License, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+# mach: or1k
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x55555555);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xb38f0f83);\n
+# output: report(0xffffffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0xc4c70f07);\n
+# output: report(0x88b7ff7b);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x38f0f83b);\n
+# output: report(0x8b7ff7b8);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xffffffff);\n
+# output: report(0x0000ffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x0000aaaa);\n
+# output: report(0x55550000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x55555555);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x55555555);\n
+# output: report(0x00005555);\n
+# output: report(0x55550000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xaaaaaaaa);\n
+# output: report(0x00005555);\n
+# output: report(0xaaaaffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000f83);\n
+# output: report(0x4c70ffff);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0x4c70f07c);\n
+# output: report(0x00000f07);\n
+# output: report(0x4c70ff7b);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: report(0xb38f0f83);\n
+# output: report(0x0000f83b);\n
+# output: report(0x4c70f7b8);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: report(0x00000000);\n
+# output: \n
+# output: exit(0)\n
+
+#include "or1k-asm-test-helpers.h"
+
+
+        STANDARD_TEST_ENVIRONMENT
+
+        .section .text
+start_tests:
+        PUSH LINK_REGISTER_R9
+
+	    // Always set OVE. We should never trigger an exception, even if this bit is set.
+        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
+
+
+        // Test the l.xor instruction with a range of operands.
+        
+	    TEST_INST_I32_I32 l.xor, 0x00000000, 0x00000000
+	    TEST_INST_I32_I32 l.xor, 0xffffffff, 0xffffffff
+	    TEST_INST_I32_I32 l.xor, 0xaaaaaaaa, 0x00000000
+	    TEST_INST_I32_I32 l.xor, 0xaaaaaaaa, 0xaaaaaaaa
+	    TEST_INST_I32_I32 l.xor, 0x55555555, 0x00000000
+	    TEST_INST_I32_I32 l.xor, 0x55555555, 0x55555555
+	    TEST_INST_I32_I32 l.xor, 0xaaaaaaaa, 0x55555555
+	    TEST_INST_I32_I32 l.xor, 0x4c70f07c, 0xb38f0f83
+	    TEST_INST_I32_I32 l.xor, 0x4c70f07c, 0xc4c70f07
+	    TEST_INST_I32_I32 l.xor, 0xb38f0f83, 0x38f0f83b
+
+
+        // Test the l.xori instruction with a range of operands.
+
+	    TEST_INST_I32_I16 l.xori, 0x00000000, 0x0000
+	    TEST_INST_I32_I16 l.xori, 0xffffffff, 0xffff
+	    TEST_INST_I32_I16 l.xori, 0xaaaaaaaa, 0x0000
+	    TEST_INST_I32_I16 l.xori, 0xaaaaaaaa, 0xaaaa
+	    TEST_INST_I32_I16 l.xori, 0x55555555, 0x0000
+	    TEST_INST_I32_I16 l.xori, 0x55555555, 0x5555
+	    TEST_INST_I32_I16 l.xori, 0xaaaaaaaa, 0x5555
+	    TEST_INST_I32_I16 l.xori, 0x4c70f07c, 0x0f83
+	    TEST_INST_I32_I16 l.xori, 0x4c70f07c, 0x0f07
+	    TEST_INST_I32_I16 l.xori, 0xb38f0f83, 0xf83b
+
+        POP LINK_REGISTER_R9
+        RETURN_TO_LINK_REGISTER_R9
-- 
2.9.3

