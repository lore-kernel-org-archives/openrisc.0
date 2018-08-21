From: Stafford Horne <shorne@gmail.com>
Date: Tue, 21 Aug 2018 23:38:23 +0900
Subject: [OpenRISC] [PATCH 4/4] or1k: Add the l.muld, l.muldu, l.macu,
	l.msbu insns
In-Reply-To: <20180821143823.16985-1-shorne@gmail.com>
References: <20180821143823.16985-1-shorne@gmail.com>
Message-ID: <20180821143823.16985-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Richard Henderson <rth@redhat.com>

Also fix the incorrect definitions of multiply and divide carry and
overflow float.

Changes to the instructions are made in the .cpu file, then we
regenerate the binutils and sim files.

The changes also required a few fixups for tests and additional sim helpers.

yyyy-mm-dd  Richard Henderson  <rth@twiddle.net>
	    Stafford Horne  <shorne@gmail.com>

cpu/ChangeLog:

	* or1korbis.cpu (insn-opcode-mac): Add opcodes for MACU and MSBU.
	(insn-opcode-alu-regreg): Add opcodes for MULD and MULDU.
	(l-mul): Fix overflow support and indentation.
	(l-mulu): Fix overflow support and indentation.
	(l-muld, l-muldu, l-msbu, l-macu): New instructions.
	(l-div); Remove incorrect carry behavior.
	(l-divu): Fix carry and overflow behavior.
	(l-mac): Add overflow support.
	(l-msb, l-msbu): Add carry and overflow support.

opcodes/ChangeLog:

	* or1k-desc.c: Regenerate.
	* or1k-desc.h: Regenerate.
	* or1k-opc.c: Regenerate.
	* or1k-opc.h: Regenerate.
	* or1k-opinst.c: Regenerate.

sim/common/ChangeLog:

	* cgen-ops.h (ADDCFDI): New function, add carry flag DI variant.
	(ADDOFDI): New function, add overflow flag DI variant.
	(SUBCFDI): New function, subtract carry flag DI variant.
	(SUBOFDI): New function, subtract overflow flag DI variant.

sim/or1k/ChangeLog:

	* or1k/cpu.h: Regenerate.
	* or1k/decode.c: Regenerate.
	* or1k/decode.h: Regenerate.
	* or1k/model.c: Regenerate.
	* or1k/sem-switch.c: Regenerate.
	* or1k/sem.c: Regenerate:

sim/testsuite/sim/or1k/ChangeLog:

	* div.S: Fix tests to match correct overflow/carry semantics.
	* mul.S: Likewise.

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

gas/ChangeLog:

	* testsuite/gas/or1k/allinsn.s: Add instruction tests for
	l.muld, l.muldu, l.macu, l.msb, l.msbu.
	* testsuite/gas/or1k/allinsn.d: Add test results for new
	instructions.
---
 cpu/or1korbis.cpu                | 261 +++++++++++++++++----------
 gas/testsuite/gas/or1k/allinsn.d |  25 +++
 gas/testsuite/gas/or1k/allinsn.s |  20 +++
 opcodes/or1k-desc.c              |  24 ++-
 opcodes/or1k-desc.h              |  11 +-
 opcodes/or1k-opc.c               |  34 +++-
 opcodes/or1k-opc.h               |  23 +--
 opcodes/or1k-opinst.c            |  91 +++++++++-
 sim/common/cgen-ops.h            |  36 ++++
 sim/or1k/cpu.h                   |  32 ++++
 sim/or1k/decode.c                | 239 +++++++++++++++++++++++--
 sim/or1k/decode.h                |  82 ++++-----
 sim/or1k/model.c                 | 186 +++++++++++++++++++-
 sim/or1k/sem-switch.c            | 281 +++++++++++++++++++++++------
 sim/or1k/sem.c                   | 293 +++++++++++++++++++++++++------
 sim/testsuite/sim/or1k/div.S     |  12 +-
 sim/testsuite/sim/or1k/mul.S     | 109 ++++++------
 17 files changed, 1404 insertions(+), 355 deletions(-)

diff --git a/cpu/or1korbis.cpu b/cpu/or1korbis.cpu
index 6fbf40ad99..094f0185a7 100644
--- a/cpu/or1korbis.cpu
+++ b/cpu/or1korbis.cpu
@@ -220,8 +220,10 @@
 (define-normal-insn-enum insn-opcode-mac
   "multiply/accumulate insn opcode enums" ((MACH ORBIS-MACHS))
   OPC_MAC_ f-op-3-4
-  (("MAC" #x1)
-   ("MSB" #x2)
+  (("MAC"   #x1)
+   ("MSB"   #x2)
+   ("MACU"  #x3)
+   ("MSBU"  #x4)
    )
   )
 
@@ -263,12 +265,14 @@
    ("OR"    #x4)
    ("XOR"   #x5)
    ("MUL"   #x6)
+   ("MULD"  #x7)
    ("SHROT" #x8)
    ("DIV"   #x9)
    ("DIVU"  #xA)
    ("MULU"  #xB)
    ("EXTBH" #xC)
    ("EXTW"  #xD)
+   ("MULDU" #xD)
    ("CMOV"  #xE)
    ("FFL1"  #xF)
    )
@@ -595,7 +599,7 @@
                (set UWI mac-machi 0)
                )
      ()
-     )
+)
 
 
 ; System releated instructions
@@ -816,77 +820,93 @@
 )
 
 (dni (l-mul) "l.mul reg/reg/reg"
-          ((MACH ORBIS-MACHS))
-          ("l.mul $rD,$rA,$rB")
-          (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_MUL)
-          (sequence ()
-                    (sequence ()
-                              ; 2's complement overflow
-                              (set BI sys-sr-ov (mul-o2flag WI rA rB))
-                              ; 1's complement overflow
-                              (set BI sys-sr-cy (mul-o1flag WI rA rB))
-                              (set rD (mul WI rA rB))
-                              )
-                    (if (andif sys-sr-ov sys-sr-ove)
-                        (raise-exception EXCEPT-RANGE))
-                    )
-          ()
+     ((MACH ORBIS-MACHS))
+     ("l.mul $rD,$rA,$rB")
+     (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_MUL)
+     (sequence ()
+	(sequence ()
+	   (set BI sys-sr-ov (mul-o2flag WI rA rB))
+	   (set rD (mul WI rA rB))
+	)
+	(if (andif sys-sr-ov sys-sr-ove)
+	    (raise-exception EXCEPT-RANGE))
+     )
+     ()
+)
+
+(dni (l-muld) "l.muld reg/reg"
+     ((MACH ORBIS-MACHS))
+     ("l.muld $rA,$rB")
+     (+ OPC_ALU (f-resv-25-5 0) rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_MULD)
+     (sequence ((DI result))
+	(set DI result (mul DI (ext DI rA) (ext DI rB)))
+	(set SI mac-machi (subword SI result 0))
+	(set SI mac-maclo (subword SI result 1))
+     )
+     ()
 )
 
 (dni (l-mulu) "l.mulu reg/reg/reg"
-          ((MACH ORBIS-MACHS))
-          ("l.mulu $rD,$rA,$rB")
-          (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_MULU)
-          (sequence ()
-                    (sequence ()
-                              ; 2's complement overflow
-                              (set BI sys-sr-ov 0)
-                              ; 1's complement overflow
-                              (set BI sys-sr-cy (mul-o1flag UWI rA rB))
-                              (set rD (mul UWI rA rB))
-                              )
-                    (if (andif sys-sr-ov sys-sr-ove)
-                        (raise-exception EXCEPT-RANGE))
-                    )
-          ()
+     ((MACH ORBIS-MACHS))
+     ("l.mulu $rD,$rA,$rB")
+     (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_MULU)
+     (sequence ()
+	(sequence ()
+	   (set BI sys-sr-cy (mul-o1flag UWI rA rB))
+	   (set rD (mul UWI rA rB))
+	)
+	(if (andif sys-sr-cy sys-sr-ove)
+	    (raise-exception EXCEPT-RANGE))
+     )
+     ()
+)
+
+(dni (l-muldu) "l.muld reg/reg"
+     ((MACH ORBIS-MACHS))
+     ("l.muldu $rA,$rB")
+     (+ OPC_ALU (f-resv-25-5 0) rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_MULDU)
+     (sequence ((DI result))
+	(set DI result (mul DI (zext DI rA) (zext DI rB)))
+	(set SI mac-machi (subword SI result 0))
+	(set SI mac-maclo (subword SI result 1))
+     )
+     ()
 )
 
 (dni l-div "divide (signed)"
-          ((MACH ORBIS-MACHS))
-          "l.div $rD,$rA,$rB"
-          (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_DIV)
-          (sequence ()
-                    (if (ne rB 0)
-                        (sequence ()
-                                  (set BI sys-sr-cy 0)
-                                  (set WI rD (div WI rA rB))
-                                  )
-                        (set BI sys-sr-cy 1)
-                        )
-                    (set BI sys-sr-ov 0)
-                    (if (andif sys-sr-cy sys-sr-ove)
-                        (raise-exception EXCEPT-RANGE))
-                    )
-          ()
+     ((MACH ORBIS-MACHS))
+     "l.div $rD,$rA,$rB"
+     (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_DIV)
+     (if (ne rB 0)
+	(sequence ()
+	   (set BI sys-sr-ov 0)
+	   (set WI rD (div WI rA rB))
+	)
+	(sequence ()
+	   (set BI sys-sr-ov 1)
+	   (if sys-sr-ove
+	      (raise-exception EXCEPT-RANGE))
+	)
+     )
+     ()
 )
 
 (dni l-divu "divide (unsigned)"
-          ((MACH ORBIS-MACHS))
-          "l.divu $rD,$rA,$rB"
-          (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_DIVU)
-          (sequence ()
-                    (if (ne rB 0)
-                        (sequence ()
-                                  (set BI sys-sr-cy 0)
-                                  (set rD (udiv UWI rA rB))
-                                  )
-                        (set BI sys-sr-cy 1)
-                        )
-                    (set BI sys-sr-ov 0)
-                    (if (andif sys-sr-cy sys-sr-ove)
-                        (raise-exception EXCEPT-RANGE))
-                    )
-          ()
+     ((MACH ORBIS-MACHS))
+     "l.divu $rD,$rA,$rB"
+     (+ OPC_ALU rD rA rB (f-resv-10-7 #x30) OPC_ALU_REGREG_DIVU)
+     (if (ne rB 0)
+	(sequence ()
+	   (set BI sys-sr-cy 0)
+	   (set rD (udiv UWI rA rB))
+	)
+	(sequence ()
+	   (set BI sys-sr-cy 1)
+	   (if sys-sr-ove
+	       (raise-exception EXCEPT-RANGE))
+	)
+     )
+     ()
 )
 
 (dni l-ff1 "find first '1'"
@@ -984,17 +1004,14 @@
      (+ OPC_MULI rD rA simm16)
      (sequence ()
                (sequence ()
-                         ; 2's complement overflow
                          (set sys-sr-ov (mul-o2flag WI rA (ext WI simm16)))
-                         ; 1's complement overflow
-                         (set sys-sr-cy (mul-o1flag UWI rA (ext UWI simm16)))
                          (set rD (mul WI rA (ext WI simm16)))
                          )
                (if (andif sys-sr-ov sys-sr-ove)
                    (raise-exception EXCEPT-RANGE))
                )
      ()
-     )
+)
 
 (define-pmacro (extbh-insn mnemonic extop extmode truncmode)
   (begin
@@ -1118,42 +1135,100 @@
      ((MACH ORBIS-MACHS))
      "l.mac $rA,$rB"
      (+  OPC_MAC (f-op-25-5 0) rA rB (f-resv-10-7 0) OPC_MAC_MAC)
-     (sequence ((WI prod) (DI result))
-               (set WI prod (mul WI rA rB))
-               (set DI result (add (join DI SI mac-machi mac-maclo) (ext DI prod)))
-               (set SI mac-machi (subword SI result 0))
-               (set SI mac-maclo (subword SI result 1))
-               )
+     (sequence ()
+	(sequence ((DI prod) (DI mac) (DI result))
+	   (set DI prod (mul DI (ext DI rA) (ext DI rB)))
+	   (set DI mac (join DI SI mac-machi mac-maclo))
+	   (set DI result (add prod mac))
+	   (set SI mac-machi (subword SI result 0))
+	   (set SI mac-maclo (subword SI result 1))
+	   (set BI sys-sr-ov (addc-oflag prod mac 0))
+	)
+	(if (andif sys-sr-ov sys-sr-ove)
+	    (raise-exception EXCEPT-RANGE))
+     )
      ()
+)
+
+(dni l-maci
+     "l.maci reg/simm16"
+     ((MACH ORBIS-MACHS))
+     "l.maci $rA,${simm16}"
+     (+ OPC_MACI (f-resv-25-5 0) rA simm16)
+     (sequence ()
+	(sequence ((DI prod) (DI mac) (DI result))
+	   (set DI prod (mul DI (ext DI rA) (ext DI simm16)))
+	   (set DI mac (join DI SI mac-machi mac-maclo))
+	   (set DI result (add mac prod))
+	   (set SI mac-machi (subword SI result 0))
+	   (set SI mac-maclo (subword SI result 1))
+	   (set BI sys-sr-ov (addc-oflag prod mac 0))
+	)
+	(if (andif sys-sr-ov sys-sr-ove)
+	    (raise-exception EXCEPT-RANGE))
      )
+     ()
+)
+
+(dni l-macu
+     "l.macu reg/reg"
+     ((MACH ORBIS-MACHS))
+     "l.macu $rA,$rB"
+     (+  OPC_MAC (f-op-25-5 0) rA rB (f-resv-10-7 0) OPC_MAC_MACU)
+     (sequence ()
+	(sequence ((DI prod) (DI mac) (DI result))
+	   (set DI prod (mul DI (zext DI rA) (zext DI rB)))
+	   (set DI mac (join DI SI mac-machi mac-maclo))
+	   (set DI result (add prod mac))
+	   (set SI mac-machi (subword SI result 0))
+	   (set SI mac-maclo (subword SI result 1))
+	   (set BI sys-sr-cy (addc-cflag prod mac 0))
+	)
+	(if (andif sys-sr-cy sys-sr-ove)
+	    (raise-exception EXCEPT-RANGE))
+     )
+     ()
+)
 
 (dni l-msb
      "l.msb reg/reg"
      ((MACH ORBIS-MACHS))
      "l.msb $rA,$rB"
      (+  OPC_MAC (f-op-25-5 0) rA rB (f-resv-10-7 0) OPC_MAC_MSB)
-     (sequence ((WI prod) (DI result))
-               (set WI prod (mul WI rA rB))
-               (set DI result (sub (join DI SI mac-machi mac-maclo) (ext DI prod)))
-               (set SI mac-machi (subword SI result 0))
-               (set SI mac-maclo (subword SI result 1))
-               )
-     ()
+     (sequence ()
+	(sequence ((DI prod) (DI mac) (DI result))
+	   (set DI prod (mul DI (ext DI rA) (ext DI rB)))
+	   (set DI mac (join DI SI mac-machi mac-maclo))
+	   (set DI result (sub mac prod))
+	   (set SI mac-machi (subword SI result 0))
+	   (set SI mac-maclo (subword SI result 1))
+	   (set BI sys-sr-ov (subc-oflag mac result 0))
+	)
+	(if (andif sys-sr-ov sys-sr-ove)
+	    (raise-exception EXCEPT-RANGE))
      )
+     ()
+)
 
-(dni l-maci
-     "l.maci reg/simm16"
+(dni l-msbu
+     "l.msbu reg/reg"
      ((MACH ORBIS-MACHS))
-     "l.maci $rA,${simm16}"
-     (+ OPC_MACI (f-resv-25-5 0) rA simm16)
-     (sequence ((WI prod) (DI result))
-               (set WI prod (mul WI (ext WI simm16) rA))
-               (set DI result (add (join DI SI mac-machi mac-maclo) (ext DI prod)))
-               (set SI mac-machi (subword SI result 0))
-               (set SI mac-maclo (subword SI result 1))
-               )
-     ()
+     "l.msbu $rA,$rB"
+     (+  OPC_MAC (f-op-25-5 0) rA rB (f-resv-10-7 0) OPC_MAC_MSBU)
+     (sequence ()
+	(sequence ((DI prod) (DI mac) (DI result))
+	   (set DI prod (mul DI (zext DI rA) (zext DI rB)))
+	   (set DI mac (join DI SI mac-machi mac-maclo))
+	   (set DI result (sub mac prod))
+	   (set SI mac-machi (subword SI result 0))
+	   (set SI mac-maclo (subword SI result 1))
+	   (set BI sys-sr-cy (subc-cflag mac result 0))
+	)
+	(if (andif sys-sr-cy sys-sr-ove)
+	    (raise-exception EXCEPT-RANGE))
      )
+     ()
+)
 
 (define-pmacro (cust-insn cust-num)
   (begin
diff --git a/gas/testsuite/gas/or1k/allinsn.d b/gas/testsuite/gas/or1k/allinsn.d
index a4ffe43f0b..4260498fdb 100644
--- a/gas/testsuite/gas/or1k/allinsn.d
+++ b/gas/testsuite/gas/or1k/allinsn.d
@@ -696,3 +696,28 @@ Disassembly of section \.text:
 			840: R_OR1K_PCREL_PG21	globaldata
  844:	08 60 00 00 	l\.adrp r3,0 <localtext>
 			844: R_OR1K_PCREL_PG21	\.data
+
+00000848 <l_muld>:
+ 848:	e0 00 03 07 	l\.muld r0,r0
+ 84c:	e0 1f fb 07 	l\.muld r31,r31
+ 850:	e0 03 23 07 	l\.muld r3,r4
+
+00000854 <l_muldu>:
+ 854:	e0 00 03 0d 	l\.muldu r0,r0
+ 858:	e0 1f fb 0d 	l\.muldu r31,r31
+ 85c:	e0 03 23 0d 	l\.muldu r3,r4
+
+00000860 <l_macu>:
+ 860:	c4 00 00 03 	l\.macu r0,r0
+ 864:	c4 1f f8 03 	l\.macu r31,r31
+ 868:	c4 03 20 03 	l\.macu r3,r4
+
+0000086c <l_msb>:
+ 86c:	c4 00 00 02 	l\.msb r0,r0
+ 870:	c4 1f f8 02 	l\.msb r31,r31
+ 874:	c4 03 20 02 	l\.msb r3,r4
+
+00000878 <l_msbu>:
+ 878:	c4 00 00 04 	l\.msbu r0,r0
+ 87c:	c4 1f f8 04 	l\.msbu r31,r31
+ 880:	c4 03 20 04 	l\.msbu r3,r4
diff --git a/gas/testsuite/gas/or1k/allinsn.s b/gas/testsuite/gas/or1k/allinsn.s
index 55d703734e..e5a7906464 100644
--- a/gas/testsuite/gas/or1k/allinsn.s
+++ b/gas/testsuite/gas/or1k/allinsn.s
@@ -680,3 +680,23 @@ l_maci:
 l_adrp:
 	l.adrp r3,globaldata
 	l.adrp r3,localdata
+l_muld:
+	l.muld r0,r0
+	l.muld r31,r31
+	l.muld r3,r4
+l_muldu:
+	l.muldu r0,r0
+	l.muldu r31,r31
+	l.muldu r3,r4
+l_macu:
+	l.macu r0,r0
+	l.macu r31,r31
+	l.macu r3,r4
+l_msb:
+	l.msb r0,r0
+	l.msb r31,r31
+	l.msb r3,r4
+l_msbu:
+	l.msbu r0,r0
+	l.msbu r31,r31
+	l.msbu r3,r4
diff --git a/opcodes/or1k-desc.c b/opcodes/or1k-desc.c
index 91c2fbd73d..f3c4e9ee23 100644
--- a/opcodes/or1k-desc.c
+++ b/opcodes/or1k-desc.c
@@ -1381,11 +1381,21 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_L_MUL, "l-mul", "l.mul", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* l.muld $rA,$rB */
+  {
+    OR1K_INSN_L_MULD, "l-muld", "l.muld", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
+  },
 /* l.mulu $rD,$rA,$rB */
   {
     OR1K_INSN_L_MULU, "l-mulu", "l.mulu", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* l.muldu $rA,$rB */
+  {
+    OR1K_INSN_L_MULDU, "l-muldu", "l.muldu", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
+  },
 /* l.div $rD,$rA,$rB */
   {
     OR1K_INSN_L_DIV, "l-div", "l.div", 32,
@@ -1576,14 +1586,24 @@ static const CGEN_IBASE or1k_cgen_insn_table[MAX_INSNS] =
     OR1K_INSN_L_MAC, "l-mac", "l.mac", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
+/* l.maci $rA,${simm16} */
+  {
+    OR1K_INSN_L_MACI, "l-maci", "l.maci", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
+  },
+/* l.macu $rA,$rB */
+  {
+    OR1K_INSN_L_MACU, "l-macu", "l.macu", 32,
+    { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
+  },
 /* l.msb $rA,$rB */
   {
     OR1K_INSN_L_MSB, "l-msb", "l.msb", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
-/* l.maci $rA,${simm16} */
+/* l.msbu $rA,$rB */
   {
-    OR1K_INSN_L_MACI, "l-maci", "l.maci", 32,
+    OR1K_INSN_L_MSBU, "l-msbu", "l.msbu", 32,
     { 0, { { { (1<<MACH_OR32)|(1<<MACH_OR32ND)|(1<<MACH_OR64)|(1<<MACH_OR64ND), 0 } } } }
   },
 /* l.cust1 */
diff --git a/opcodes/or1k-desc.h b/opcodes/or1k-desc.h
index d84f0fa52a..040bd926c5 100644
--- a/opcodes/or1k-desc.h
+++ b/opcodes/or1k-desc.h
@@ -306,7 +306,7 @@ typedef enum insn_opcode_movehimacrc {
 
 /* Enum declaration for multiply/accumulate insn opcode enums.  */
 typedef enum insn_opcode_mac {
-  OPC_MAC_MAC = 1, OPC_MAC_MSB = 2
+  OPC_MAC_MAC = 1, OPC_MAC_MSB = 2, OPC_MAC_MACU = 3, OPC_MAC_MSBU = 4
 } INSN_OPCODE_MAC;
 
 /* Enum declaration for shift/rotate insn opcode enums.  */
@@ -327,9 +327,10 @@ typedef enum insn_opcode_extws {
 /* Enum declaration for alu reg/reg insn opcode enums.  */
 typedef enum insn_opcode_alu_regreg {
   OPC_ALU_REGREG_ADD = 0, OPC_ALU_REGREG_ADDC = 1, OPC_ALU_REGREG_SUB = 2, OPC_ALU_REGREG_AND = 3
- , OPC_ALU_REGREG_OR = 4, OPC_ALU_REGREG_XOR = 5, OPC_ALU_REGREG_MUL = 6, OPC_ALU_REGREG_SHROT = 8
- , OPC_ALU_REGREG_DIV = 9, OPC_ALU_REGREG_DIVU = 10, OPC_ALU_REGREG_MULU = 11, OPC_ALU_REGREG_EXTBH = 12
- , OPC_ALU_REGREG_EXTW = 13, OPC_ALU_REGREG_CMOV = 14, OPC_ALU_REGREG_FFL1 = 15
+ , OPC_ALU_REGREG_OR = 4, OPC_ALU_REGREG_XOR = 5, OPC_ALU_REGREG_MUL = 6, OPC_ALU_REGREG_MULD = 7
+ , OPC_ALU_REGREG_SHROT = 8, OPC_ALU_REGREG_DIV = 9, OPC_ALU_REGREG_DIVU = 10, OPC_ALU_REGREG_MULU = 11
+ , OPC_ALU_REGREG_EXTBH = 12, OPC_ALU_REGREG_EXTW = 13, OPC_ALU_REGREG_MULDU = 13, OPC_ALU_REGREG_CMOV = 14
+ , OPC_ALU_REGREG_FFL1 = 15
 } INSN_OPCODE_ALU_REGREG;
 
 /* Enum declaration for setflag insn opcode enums.  */
@@ -632,7 +633,7 @@ typedef enum cgen_operand_type {
 #define MAX_OPERANDS 32
 
 /* Maximum number of operands referenced by any insn.  */
-#define MAX_OPERAND_INSTANCES 9
+#define MAX_OPERAND_INSTANCES 10
 
 /* Insn attribute indices.  */
 
diff --git a/opcodes/or1k-opc.c b/opcodes/or1k-opc.c
index ba820a4c57..337dda5306 100644
--- a/opcodes/or1k-opc.c
+++ b/opcodes/or1k-opc.c
@@ -116,6 +116,10 @@ static const CGEN_IFMT ifmt_l_and ATTRIBUTE_UNUSED = {
   32, 32, 0xfc0007ff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_7) }, { F (F_OP_3_4) }, { 0 } }
 };
 
+static const CGEN_IFMT ifmt_l_muld ATTRIBUTE_UNUSED = {
+  32, 32, 0xffe007ff, { { F (F_OPCODE) }, { F (F_RESV_25_5) }, { F (F_R2) }, { F (F_R3) }, { F (F_RESV_10_7) }, { F (F_OP_3_4) }, { 0 } }
+};
+
 static const CGEN_IFMT ifmt_l_exths ATTRIBUTE_UNUSED = {
   32, 32, 0xfc00ffff, { { F (F_OPCODE) }, { F (F_R1) }, { F (F_R2) }, { F (F_RESV_15_6) }, { F (F_OP_9_4) }, { F (F_RESV_5_2) }, { F (F_OP_3_4) }, { 0 } }
 };
@@ -457,12 +461,24 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RD), ',', OP (RA), ',', OP (RB), 0 } },
     & ifmt_l_and, { 0xe0000306 }
   },
+/* l.muld $rA,$rB */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RA), ',', OP (RB), 0 } },
+    & ifmt_l_muld, { 0xe0000307 }
+  },
 /* l.mulu $rD,$rA,$rB */
   {
     { 0, 0, 0, 0 },
     { { MNEM, ' ', OP (RD), ',', OP (RA), ',', OP (RB), 0 } },
     & ifmt_l_and, { 0xe000030b }
   },
+/* l.muldu $rA,$rB */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RA), ',', OP (RB), 0 } },
+    & ifmt_l_muld, { 0xe000030d }
+  },
 /* l.div $rD,$rA,$rB */
   {
     { 0, 0, 0, 0 },
@@ -691,17 +707,29 @@ static const CGEN_OPCODE or1k_cgen_insn_opcode_table[MAX_INSNS] =
     { { MNEM, ' ', OP (RA), ',', OP (RB), 0 } },
     & ifmt_l_mac, { 0xc4000001 }
   },
+/* l.maci $rA,${simm16} */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RA), ',', OP (SIMM16), 0 } },
+    & ifmt_l_maci, { 0x4c000000 }
+  },
+/* l.macu $rA,$rB */
+  {
+    { 0, 0, 0, 0 },
+    { { MNEM, ' ', OP (RA), ',', OP (RB), 0 } },
+    & ifmt_l_mac, { 0xc4000003 }
+  },
 /* l.msb $rA,$rB */
   {
     { 0, 0, 0, 0 },
     { { MNEM, ' ', OP (RA), ',', OP (RB), 0 } },
     & ifmt_l_mac, { 0xc4000002 }
   },
-/* l.maci $rA,${simm16} */
+/* l.msbu $rA,$rB */
   {
     { 0, 0, 0, 0 },
-    { { MNEM, ' ', OP (RA), ',', OP (SIMM16), 0 } },
-    & ifmt_l_maci, { 0x4c000000 }
+    { { MNEM, ' ', OP (RA), ',', OP (RB), 0 } },
+    & ifmt_l_mac, { 0xc4000004 }
   },
 /* l.cust1 */
   {
diff --git a/opcodes/or1k-opc.h b/opcodes/or1k-opc.h
index d2a377257f..66d077361f 100644
--- a/opcodes/or1k-opc.h
+++ b/opcodes/or1k-opc.h
@@ -51,17 +51,18 @@ typedef enum cgen_insn_type {
  , OR1K_INSN_L_SLLI, OR1K_INSN_L_SRL, OR1K_INSN_L_SRLI, OR1K_INSN_L_SRA
  , OR1K_INSN_L_SRAI, OR1K_INSN_L_ROR, OR1K_INSN_L_RORI, OR1K_INSN_L_AND
  , OR1K_INSN_L_OR, OR1K_INSN_L_XOR, OR1K_INSN_L_ADD, OR1K_INSN_L_SUB
- , OR1K_INSN_L_ADDC, OR1K_INSN_L_MUL, OR1K_INSN_L_MULU, OR1K_INSN_L_DIV
- , OR1K_INSN_L_DIVU, OR1K_INSN_L_FF1, OR1K_INSN_L_FL1, OR1K_INSN_L_ANDI
- , OR1K_INSN_L_ORI, OR1K_INSN_L_XORI, OR1K_INSN_L_ADDI, OR1K_INSN_L_ADDIC
- , OR1K_INSN_L_MULI, OR1K_INSN_L_EXTHS, OR1K_INSN_L_EXTBS, OR1K_INSN_L_EXTHZ
- , OR1K_INSN_L_EXTBZ, OR1K_INSN_L_EXTWS, OR1K_INSN_L_EXTWZ, OR1K_INSN_L_CMOV
- , OR1K_INSN_L_SFGTS, OR1K_INSN_L_SFGTSI, OR1K_INSN_L_SFGTU, OR1K_INSN_L_SFGTUI
- , OR1K_INSN_L_SFGES, OR1K_INSN_L_SFGESI, OR1K_INSN_L_SFGEU, OR1K_INSN_L_SFGEUI
- , OR1K_INSN_L_SFLTS, OR1K_INSN_L_SFLTSI, OR1K_INSN_L_SFLTU, OR1K_INSN_L_SFLTUI
- , OR1K_INSN_L_SFLES, OR1K_INSN_L_SFLESI, OR1K_INSN_L_SFLEU, OR1K_INSN_L_SFLEUI
- , OR1K_INSN_L_SFEQ, OR1K_INSN_L_SFEQI, OR1K_INSN_L_SFNE, OR1K_INSN_L_SFNEI
- , OR1K_INSN_L_MAC, OR1K_INSN_L_MSB, OR1K_INSN_L_MACI, OR1K_INSN_L_CUST1
+ , OR1K_INSN_L_ADDC, OR1K_INSN_L_MUL, OR1K_INSN_L_MULD, OR1K_INSN_L_MULU
+ , OR1K_INSN_L_MULDU, OR1K_INSN_L_DIV, OR1K_INSN_L_DIVU, OR1K_INSN_L_FF1
+ , OR1K_INSN_L_FL1, OR1K_INSN_L_ANDI, OR1K_INSN_L_ORI, OR1K_INSN_L_XORI
+ , OR1K_INSN_L_ADDI, OR1K_INSN_L_ADDIC, OR1K_INSN_L_MULI, OR1K_INSN_L_EXTHS
+ , OR1K_INSN_L_EXTBS, OR1K_INSN_L_EXTHZ, OR1K_INSN_L_EXTBZ, OR1K_INSN_L_EXTWS
+ , OR1K_INSN_L_EXTWZ, OR1K_INSN_L_CMOV, OR1K_INSN_L_SFGTS, OR1K_INSN_L_SFGTSI
+ , OR1K_INSN_L_SFGTU, OR1K_INSN_L_SFGTUI, OR1K_INSN_L_SFGES, OR1K_INSN_L_SFGESI
+ , OR1K_INSN_L_SFGEU, OR1K_INSN_L_SFGEUI, OR1K_INSN_L_SFLTS, OR1K_INSN_L_SFLTSI
+ , OR1K_INSN_L_SFLTU, OR1K_INSN_L_SFLTUI, OR1K_INSN_L_SFLES, OR1K_INSN_L_SFLESI
+ , OR1K_INSN_L_SFLEU, OR1K_INSN_L_SFLEUI, OR1K_INSN_L_SFEQ, OR1K_INSN_L_SFEQI
+ , OR1K_INSN_L_SFNE, OR1K_INSN_L_SFNEI, OR1K_INSN_L_MAC, OR1K_INSN_L_MACI
+ , OR1K_INSN_L_MACU, OR1K_INSN_L_MSB, OR1K_INSN_L_MSBU, OR1K_INSN_L_CUST1
  , OR1K_INSN_L_CUST2, OR1K_INSN_L_CUST3, OR1K_INSN_L_CUST4, OR1K_INSN_L_CUST5
  , OR1K_INSN_L_CUST6, OR1K_INSN_L_CUST7, OR1K_INSN_L_CUST8, OR1K_INSN_LF_ADD_S
  , OR1K_INSN_LF_ADD_D, OR1K_INSN_LF_SUB_S, OR1K_INSN_LF_SUB_D, OR1K_INSN_LF_MUL_S
diff --git a/opcodes/or1k-opinst.c b/opcodes/or1k-opinst.c
index c267efb6c4..53268e21f4 100644
--- a/opcodes/or1k-opinst.c
+++ b/opcodes/or1k-opinst.c
@@ -278,15 +278,53 @@ static const CGEN_OPINST sfmt_l_addc_ops[] ATTRIBUTE_UNUSED = {
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
-static const CGEN_OPINST sfmt_l_div_ops[] ATTRIBUTE_UNUSED = {
+static const CGEN_OPINST sfmt_l_mul_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
-  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, COND_REF },
+  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
+  { INPUT, "rB", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RB), 0, 0 },
+  { INPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "rD", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RD), 0, 0 },
+  { OUTPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
+static const CGEN_OPINST sfmt_l_muld_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
+  { INPUT, "rB", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RB), 0, 0 },
+  { OUTPUT, "mac_machi", HW_H_MAC_MACHI, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "mac_maclo", HW_H_MAC_MACLO, CGEN_MODE_UDI, 0, 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
+static const CGEN_OPINST sfmt_l_mulu_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
+  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
   { INPUT, "rB", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RB), 0, 0 },
   { INPUT, "sys_sr_cy", HW_H_SYS_SR_CY, CGEN_MODE_UDI, 0, 0, 0 },
   { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "rD", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RD), 0, 0 },
+  { OUTPUT, "sys_sr_cy", HW_H_SYS_SR_CY, CGEN_MODE_UDI, 0, 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
+static const CGEN_OPINST sfmt_l_div_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
+  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, COND_REF },
+  { INPUT, "rB", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RB), 0, 0 },
+  { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, COND_REF },
+  { OUTPUT, "rD", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RD), 0, COND_REF },
+  { OUTPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, COND_REF },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
+static const CGEN_OPINST sfmt_l_divu_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
+  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, COND_REF },
+  { INPUT, "rB", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RB), 0, 0 },
+  { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, COND_REF },
   { OUTPUT, "rD", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RD), 0, COND_REF },
   { OUTPUT, "sys_sr_cy", HW_H_SYS_SR_CY, CGEN_MODE_UDI, 0, 0, COND_REF },
-  { OUTPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
@@ -328,6 +366,17 @@ static const CGEN_OPINST sfmt_l_addic_ops[] ATTRIBUTE_UNUSED = {
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
+static const CGEN_OPINST sfmt_l_muli_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
+  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
+  { INPUT, "simm16", HW_H_SIMM16, CGEN_MODE_INT, OP_ENT (SIMM16), 0, 0 },
+  { INPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "rD", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RD), 0, 0 },
+  { OUTPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
 static const CGEN_OPINST sfmt_l_exths_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
   { OUTPUT, "rD", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RD), 0, 0 },
@@ -359,20 +408,42 @@ static const CGEN_OPINST sfmt_l_sfgtsi_ops[] ATTRIBUTE_UNUSED = {
 static const CGEN_OPINST sfmt_l_mac_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "mac_machi", HW_H_MAC_MACHI, CGEN_MODE_UDI, 0, 0, 0 },
   { INPUT, "mac_maclo", HW_H_MAC_MACLO, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
   { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
   { INPUT, "rB", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RB), 0, 0 },
+  { INPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, 0 },
   { OUTPUT, "mac_machi", HW_H_MAC_MACHI, CGEN_MODE_UDI, 0, 0, 0 },
   { OUTPUT, "mac_maclo", HW_H_MAC_MACLO, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
 static const CGEN_OPINST sfmt_l_maci_ops[] ATTRIBUTE_UNUSED = {
   { INPUT, "mac_machi", HW_H_MAC_MACHI, CGEN_MODE_UDI, 0, 0, 0 },
   { INPUT, "mac_maclo", HW_H_MAC_MACLO, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
   { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
   { INPUT, "simm16", HW_H_SIMM16, CGEN_MODE_INT, OP_ENT (SIMM16), 0, 0 },
+  { INPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, 0 },
   { OUTPUT, "mac_machi", HW_H_MAC_MACHI, CGEN_MODE_UDI, 0, 0, 0 },
   { OUTPUT, "mac_maclo", HW_H_MAC_MACLO, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "sys_sr_ov", HW_H_SYS_SR_OV, CGEN_MODE_UDI, 0, 0, 0 },
+  { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
+};
+
+static const CGEN_OPINST sfmt_l_macu_ops[] ATTRIBUTE_UNUSED = {
+  { INPUT, "mac_machi", HW_H_MAC_MACHI, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "mac_maclo", HW_H_MAC_MACLO, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "pc", HW_H_PC, CGEN_MODE_UDI, 0, 0, COND_REF },
+  { INPUT, "rA", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RA), 0, 0 },
+  { INPUT, "rB", HW_H_GPR, CGEN_MODE_UDI, OP_ENT (RB), 0, 0 },
+  { INPUT, "sys_sr_cy", HW_H_SYS_SR_CY, CGEN_MODE_UDI, 0, 0, 0 },
+  { INPUT, "sys_sr_ove", HW_H_SYS_SR_OVE, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "mac_machi", HW_H_MAC_MACHI, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "mac_maclo", HW_H_MAC_MACLO, CGEN_MODE_UDI, 0, 0, 0 },
+  { OUTPUT, "sys_sr_cy", HW_H_SYS_SR_CY, CGEN_MODE_UDI, 0, 0, 0 },
   { END, (const char *)0, (enum cgen_hw_type)0, (enum cgen_mode)0, (enum cgen_operand_type)0, 0, 0 }
 };
 
@@ -502,10 +573,12 @@ static const CGEN_OPINST *or1k_cgen_opinst_table[MAX_INSNS] = {
   & sfmt_l_add_ops[0],
   & sfmt_l_add_ops[0],
   & sfmt_l_addc_ops[0],
-  & sfmt_l_add_ops[0],
-  & sfmt_l_add_ops[0],
-  & sfmt_l_div_ops[0],
+  & sfmt_l_mul_ops[0],
+  & sfmt_l_muld_ops[0],
+  & sfmt_l_mulu_ops[0],
+  & sfmt_l_muld_ops[0],
   & sfmt_l_div_ops[0],
+  & sfmt_l_divu_ops[0],
   & sfmt_l_ff1_ops[0],
   & sfmt_l_ff1_ops[0],
   & sfmt_l_mfspr_ops[0],
@@ -513,7 +586,7 @@ static const CGEN_OPINST *or1k_cgen_opinst_table[MAX_INSNS] = {
   & sfmt_l_xori_ops[0],
   & sfmt_l_addi_ops[0],
   & sfmt_l_addic_ops[0],
-  & sfmt_l_addi_ops[0],
+  & sfmt_l_muli_ops[0],
   & sfmt_l_exths_ops[0],
   & sfmt_l_exths_ops[0],
   & sfmt_l_exths_ops[0],
@@ -542,8 +615,10 @@ static const CGEN_OPINST *or1k_cgen_opinst_table[MAX_INSNS] = {
   & sfmt_l_sfgts_ops[0],
   & sfmt_l_sfgtsi_ops[0],
   & sfmt_l_mac_ops[0],
-  & sfmt_l_mac_ops[0],
   & sfmt_l_maci_ops[0],
+  & sfmt_l_macu_ops[0],
+  & sfmt_l_mac_ops[0],
+  & sfmt_l_macu_ops[0],
   & sfmt_l_msync_ops[0],
   & sfmt_l_msync_ops[0],
   & sfmt_l_msync_ops[0],
diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
index 87ca4836ba..0ce7e58bba 100644
--- a/sim/common/cgen-ops.h
+++ b/sim/common/cgen-ops.h
@@ -647,6 +647,38 @@ MUL1OFSI (USI a, USI b)
   return res;
 }
 
+SEMOPS_INLINE BI
+ADDCFDI (DI a, DI b, BI c)
+{
+  DI tmp = ADDDI (a, ADDDI (b, c));
+  BI res = ((UDI) tmp < (UDI) a) || (c && tmp == a);
+  return res;
+}
+
+SEMOPS_INLINE BI
+ADDOFDI (DI a, DI b, BI c)
+{
+  DI tmp = ADDDI (a, ADDDI (b, c));
+  BI res = (((a < 0) == (b < 0))
+	    && ((a < 0) != (tmp < 0)));
+  return res;
+}
+
+SEMOPS_INLINE BI
+SUBCFDI (DI a, DI b, BI c)
+{
+  BI res = ((UDI) a < (UDI) b) || (c && a == b);
+  return res;
+}
+
+SEMOPS_INLINE BI
+SUBOFDI (DI a, DI b, BI c)
+{
+  DI tmp = SUBDI (a, ADDSI (b, c));
+  BI res = (((a < 0) != (b < 0))
+	    && ((a < 0) != (tmp < 0)));
+  return res;
+}
 #else
 
 SI ADDCSI (SI, SI, BI);
@@ -669,6 +701,10 @@ UBI SUBCFQI (QI, QI, BI);
 UBI SUBOFQI (QI, QI, BI);
 BI MUL1OFSI (SI a, SI b);
 BI MUL2OFSI (SI a, SI b);
+BI ADDCFDI (DI a, DI b, BI c);
+BI ADDOFDI (DI a, DI b, BI c);
+BI SUBCFDI (DI a, DI b, BI c);
+BI SUBOFDI (DI a, DI b, BI c);
 
 #endif
 
diff --git a/sim/or1k/cpu.h b/sim/or1k/cpu.h
index 9646c33df6..b847f53032 100644
--- a/sim/or1k/cpu.h
+++ b/sim/or1k/cpu.h
@@ -4515,6 +4515,10 @@ union sem_fields {
   struct { /*  */
     IADDR i_disp26;
   } sfmt_l_j;
+  struct { /*  */
+    IADDR i_disp21;
+    UINT f_r1;
+  } sfmt_l_adrp;
   struct { /*  */
     UINT f_r1;
     UINT f_r2;
@@ -4614,6 +4618,17 @@ struct scache {
   f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
   f_disp26 = ((((EXTRACT_LSB0_SINT (insn, 32, 25, 26)) << (2))) + (pc)); \
 
+#define EXTRACT_IFMT_L_ADRP_VARS \
+  UINT f_opcode; \
+  UINT f_r1; \
+  USI f_disp21; \
+  unsigned int length;
+#define EXTRACT_IFMT_L_ADRP_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_disp21 = ((((EXTRACT_LSB0_SINT (insn, 32, 20, 21)) + (((SI) (pc) >> (13))))) << (13)); \
+
 #define EXTRACT_IFMT_L_JR_VARS \
   UINT f_opcode; \
   UINT f_resv_25_10; \
@@ -4831,6 +4846,23 @@ struct scache {
   f_resv_10_7 = EXTRACT_LSB0_UINT (insn, 32, 10, 7); \
   f_op_3_4 = EXTRACT_LSB0_UINT (insn, 32, 3, 4); \
 
+#define EXTRACT_IFMT_L_MULD_VARS \
+  UINT f_opcode; \
+  UINT f_resv_25_5; \
+  UINT f_r2; \
+  UINT f_r3; \
+  UINT f_resv_10_7; \
+  UINT f_op_3_4; \
+  unsigned int length;
+#define EXTRACT_IFMT_L_MULD_CODE \
+  length = 4; \
+  f_opcode = EXTRACT_LSB0_UINT (insn, 32, 31, 6); \
+  f_resv_25_5 = EXTRACT_LSB0_UINT (insn, 32, 25, 5); \
+  f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5); \
+  f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5); \
+  f_resv_10_7 = EXTRACT_LSB0_UINT (insn, 32, 10, 7); \
+  f_op_3_4 = EXTRACT_LSB0_UINT (insn, 32, 3, 4); \
+
 #define EXTRACT_IFMT_L_EXTHS_VARS \
   UINT f_opcode; \
   UINT f_r1; \
diff --git a/sim/or1k/decode.c b/sim/or1k/decode.c
index bc99cc2819..e62476f559 100644
--- a/sim/or1k/decode.c
+++ b/sim/or1k/decode.c
@@ -47,6 +47,7 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { VIRTUAL_INSN_X_CHAIN, OR1K32BF_INSN_X_CHAIN, OR1K32BF_SFMT_EMPTY },
   { VIRTUAL_INSN_X_BEGIN, OR1K32BF_INSN_X_BEGIN, OR1K32BF_SFMT_EMPTY },
   { OR1K_INSN_L_J, OR1K32BF_INSN_L_J, OR1K32BF_SFMT_L_J },
+  { OR1K_INSN_L_ADRP, OR1K32BF_INSN_L_ADRP, OR1K32BF_SFMT_L_ADRP },
   { OR1K_INSN_L_JAL, OR1K32BF_INSN_L_JAL, OR1K32BF_SFMT_L_JAL },
   { OR1K_INSN_L_JR, OR1K32BF_INSN_L_JR, OR1K32BF_SFMT_L_JR },
   { OR1K_INSN_L_JALR, OR1K32BF_INSN_L_JALR, OR1K32BF_SFMT_L_JALR },
@@ -88,10 +89,12 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_ADD, OR1K32BF_INSN_L_ADD, OR1K32BF_SFMT_L_ADD },
   { OR1K_INSN_L_SUB, OR1K32BF_INSN_L_SUB, OR1K32BF_SFMT_L_ADD },
   { OR1K_INSN_L_ADDC, OR1K32BF_INSN_L_ADDC, OR1K32BF_SFMT_L_ADDC },
-  { OR1K_INSN_L_MUL, OR1K32BF_INSN_L_MUL, OR1K32BF_SFMT_L_ADD },
-  { OR1K_INSN_L_MULU, OR1K32BF_INSN_L_MULU, OR1K32BF_SFMT_L_ADD },
+  { OR1K_INSN_L_MUL, OR1K32BF_INSN_L_MUL, OR1K32BF_SFMT_L_MUL },
+  { OR1K_INSN_L_MULD, OR1K32BF_INSN_L_MULD, OR1K32BF_SFMT_L_MULD },
+  { OR1K_INSN_L_MULU, OR1K32BF_INSN_L_MULU, OR1K32BF_SFMT_L_MULU },
+  { OR1K_INSN_L_MULDU, OR1K32BF_INSN_L_MULDU, OR1K32BF_SFMT_L_MULD },
   { OR1K_INSN_L_DIV, OR1K32BF_INSN_L_DIV, OR1K32BF_SFMT_L_DIV },
-  { OR1K_INSN_L_DIVU, OR1K32BF_INSN_L_DIVU, OR1K32BF_SFMT_L_DIV },
+  { OR1K_INSN_L_DIVU, OR1K32BF_INSN_L_DIVU, OR1K32BF_SFMT_L_DIVU },
   { OR1K_INSN_L_FF1, OR1K32BF_INSN_L_FF1, OR1K32BF_SFMT_L_FF1 },
   { OR1K_INSN_L_FL1, OR1K32BF_INSN_L_FL1, OR1K32BF_SFMT_L_FF1 },
   { OR1K_INSN_L_ANDI, OR1K32BF_INSN_L_ANDI, OR1K32BF_SFMT_L_MFSPR },
@@ -99,7 +102,7 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_XORI, OR1K32BF_INSN_L_XORI, OR1K32BF_SFMT_L_XORI },
   { OR1K_INSN_L_ADDI, OR1K32BF_INSN_L_ADDI, OR1K32BF_SFMT_L_ADDI },
   { OR1K_INSN_L_ADDIC, OR1K32BF_INSN_L_ADDIC, OR1K32BF_SFMT_L_ADDIC },
-  { OR1K_INSN_L_MULI, OR1K32BF_INSN_L_MULI, OR1K32BF_SFMT_L_ADDI },
+  { OR1K_INSN_L_MULI, OR1K32BF_INSN_L_MULI, OR1K32BF_SFMT_L_MULI },
   { OR1K_INSN_L_EXTHS, OR1K32BF_INSN_L_EXTHS, OR1K32BF_SFMT_L_EXTHS },
   { OR1K_INSN_L_EXTBS, OR1K32BF_INSN_L_EXTBS, OR1K32BF_SFMT_L_EXTHS },
   { OR1K_INSN_L_EXTHZ, OR1K32BF_INSN_L_EXTHZ, OR1K32BF_SFMT_L_EXTHS },
@@ -128,8 +131,10 @@ static const struct insn_sem or1k32bf_insn_sem[] =
   { OR1K_INSN_L_SFNE, OR1K32BF_INSN_L_SFNE, OR1K32BF_SFMT_L_SFGTS },
   { OR1K_INSN_L_SFNEI, OR1K32BF_INSN_L_SFNEI, OR1K32BF_SFMT_L_SFGTSI },
   { OR1K_INSN_L_MAC, OR1K32BF_INSN_L_MAC, OR1K32BF_SFMT_L_MAC },
-  { OR1K_INSN_L_MSB, OR1K32BF_INSN_L_MSB, OR1K32BF_SFMT_L_MAC },
   { OR1K_INSN_L_MACI, OR1K32BF_INSN_L_MACI, OR1K32BF_SFMT_L_MACI },
+  { OR1K_INSN_L_MACU, OR1K32BF_INSN_L_MACU, OR1K32BF_SFMT_L_MACU },
+  { OR1K_INSN_L_MSB, OR1K32BF_INSN_L_MSB, OR1K32BF_SFMT_L_MAC },
+  { OR1K_INSN_L_MSBU, OR1K32BF_INSN_L_MSBU, OR1K32BF_SFMT_L_MACU },
   { OR1K_INSN_L_CUST1, OR1K32BF_INSN_L_CUST1, OR1K32BF_SFMT_L_MSYNC },
   { OR1K_INSN_L_CUST2, OR1K32BF_INSN_L_CUST2, OR1K32BF_SFMT_L_MSYNC },
   { OR1K_INSN_L_CUST3, OR1K32BF_INSN_L_CUST3, OR1K32BF_SFMT_L_MSYNC },
@@ -297,6 +302,38 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 61 : /* fall through */
       case 62 : /* fall through */
       case 63 : itype = OR1K32BF_INSN_L_JAL; goto extract_sfmt_l_jal;
+      case 64 : /* fall through */
+      case 65 : /* fall through */
+      case 66 : /* fall through */
+      case 67 : /* fall through */
+      case 68 : /* fall through */
+      case 69 : /* fall through */
+      case 70 : /* fall through */
+      case 71 : /* fall through */
+      case 72 : /* fall through */
+      case 73 : /* fall through */
+      case 74 : /* fall through */
+      case 75 : /* fall through */
+      case 76 : /* fall through */
+      case 77 : /* fall through */
+      case 78 : /* fall through */
+      case 79 : /* fall through */
+      case 80 : /* fall through */
+      case 81 : /* fall through */
+      case 82 : /* fall through */
+      case 83 : /* fall through */
+      case 84 : /* fall through */
+      case 85 : /* fall through */
+      case 86 : /* fall through */
+      case 87 : /* fall through */
+      case 88 : /* fall through */
+      case 89 : /* fall through */
+      case 90 : /* fall through */
+      case 91 : /* fall through */
+      case 92 : /* fall through */
+      case 93 : /* fall through */
+      case 94 : /* fall through */
+      case 95 : itype = OR1K32BF_INSN_L_ADRP; goto extract_sfmt_l_adrp;
       case 96 : /* fall through */
       case 97 : /* fall through */
       case 98 : /* fall through */
@@ -998,7 +1035,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
       case 1436 : /* fall through */
       case 1437 : /* fall through */
       case 1438 : /* fall through */
-      case 1439 : itype = OR1K32BF_INSN_L_MULI; goto extract_sfmt_l_addi;
+      case 1439 : itype = OR1K32BF_INSN_L_MULI; goto extract_sfmt_l_muli;
       case 1440 : /* fall through */
       case 1441 : /* fall through */
       case 1442 : /* fall through */
@@ -1212,6 +1249,14 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         if ((entire_insn & 0xffe007ff) == 0xc4000002)
           { itype = OR1K32BF_INSN_L_MSB; goto extract_sfmt_l_mac; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1571 :
+        if ((entire_insn & 0xffe007ff) == 0xc4000003)
+          { itype = OR1K32BF_INSN_L_MACU; goto extract_sfmt_l_macu; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1572 :
+        if ((entire_insn & 0xffe007ff) == 0xc4000004)
+          { itype = OR1K32BF_INSN_L_MSBU; goto extract_sfmt_l_macu; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1600 :
         if ((entire_insn & 0xfc0007ff) == 0xc8000000)
           { itype = OR1K32BF_INSN_LF_ADD_S; goto extract_sfmt_lf_add_s; }
@@ -1426,7 +1471,11 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1798 :
         if ((entire_insn & 0xfc0007ff) == 0xe0000306)
-          { itype = OR1K32BF_INSN_L_MUL; goto extract_sfmt_l_add; }
+          { itype = OR1K32BF_INSN_L_MUL; goto extract_sfmt_l_mul; }
+        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+      case 1799 :
+        if ((entire_insn & 0xffe007ff) == 0xe0000307)
+          { itype = OR1K32BF_INSN_L_MULD; goto extract_sfmt_l_muld; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1800 :
         {
@@ -1450,11 +1499,11 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1802 :
         if ((entire_insn & 0xfc0007ff) == 0xe000030a)
-          { itype = OR1K32BF_INSN_L_DIVU; goto extract_sfmt_l_div; }
+          { itype = OR1K32BF_INSN_L_DIVU; goto extract_sfmt_l_divu; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1803 :
         if ((entire_insn & 0xfc0007ff) == 0xe000030b)
-          { itype = OR1K32BF_INSN_L_MULU; goto extract_sfmt_l_add; }
+          { itype = OR1K32BF_INSN_L_MULU; goto extract_sfmt_l_mulu; }
         itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
       case 1804 :
         {
@@ -1473,9 +1522,21 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
           }
         }
       case 1805 :
-        if ((entire_insn & 0xfc00ffff) == 0xe000000d)
-          { itype = OR1K32BF_INSN_L_EXTWS; goto extract_sfmt_l_exths; }
-        itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+        {
+          unsigned int val = (((insn >> 8) & (3 << 0)));
+          switch (val)
+          {
+          case 0 :
+            if ((entire_insn & 0xfc00ffff) == 0xe000000d)
+              { itype = OR1K32BF_INSN_L_EXTWS; goto extract_sfmt_l_exths; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          case 3 :
+            if ((entire_insn & 0xffe007ff) == 0xe000030d)
+              { itype = OR1K32BF_INSN_L_MULDU; goto extract_sfmt_l_muld; }
+            itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          default : itype = OR1K32BF_INSN_X_INVALID; goto extract_sfmt_empty;
+          }
+        }
       case 1806 :
         if ((entire_insn & 0xfc0007ff) == 0xe000000e)
           { itype = OR1K32BF_INSN_L_CMOV; goto extract_sfmt_l_cmov; }
@@ -1629,6 +1690,26 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (i_disp26) = f_disp26;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_j", "disp26 0x%x", 'x', f_disp26, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_l_adrp:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
+    UINT f_r1;
+    USI f_disp21;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_disp21 = ((((EXTRACT_LSB0_SINT (insn, 32, 20, 21)) + (((SI) (pc) >> (13))))) << (13));
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r1) = f_r1;
+  FLD (i_disp21) = f_disp21;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_adrp", "f_r1 0x%x", 'x', f_r1, "disp21 0x%x", 'x', f_disp21, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -1768,7 +1849,7 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   {
     const IDESC *idesc = &or1k32bf_insn_data[itype];
     CGEN_INSN_WORD insn = entire_insn;
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
     UINT f_r1;
 
     f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
@@ -2211,6 +2292,72 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r1) = f_r1;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_addc", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_l_mul:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_mul", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_l_muld:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_muld", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
+
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_l_mulu:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_mulu", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2234,6 +2381,29 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r1) = f_r1;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_div", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_l_divu:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r1;
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_divu", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2323,6 +2493,29 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_r1) = f_r1;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_addic", "f_r2 0x%x", 'x', f_r2, "f_simm16 0x%x", 'x', f_simm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_l_muli:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+    UINT f_r1;
+    UINT f_r2;
+    INT f_simm16;
+
+    f_r1 = EXTRACT_LSB0_UINT (insn, 32, 25, 5);
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_simm16 = EXTRACT_LSB0_SINT (insn, 32, 15, 16);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_simm16) = f_simm16;
+  FLD (f_r1) = f_r1;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_muli", "f_r2 0x%x", 'x', f_r2, "f_simm16 0x%x", 'x', f_simm16, "f_r1 0x%x", 'x', f_r1, (char *) 0));
+
 #undef FLD
     return idesc;
   }
@@ -2446,6 +2639,26 @@ or1k32bf_decode (SIM_CPU *current_cpu, IADDR pc,
   FLD (f_simm16) = f_simm16;
   TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_maci", "f_r2 0x%x", 'x', f_r2, "f_simm16 0x%x", 'x', f_simm16, (char *) 0));
 
+#undef FLD
+    return idesc;
+  }
+
+ extract_sfmt_l_macu:
+  {
+    const IDESC *idesc = &or1k32bf_insn_data[itype];
+    CGEN_INSN_WORD insn = entire_insn;
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+    UINT f_r2;
+    UINT f_r3;
+
+    f_r2 = EXTRACT_LSB0_UINT (insn, 32, 20, 5);
+    f_r3 = EXTRACT_LSB0_UINT (insn, 32, 15, 5);
+
+  /* Record the fields for the semantic handler.  */
+  FLD (f_r2) = f_r2;
+  FLD (f_r3) = f_r3;
+  TRACE_EXTRACT (current_cpu, abuf, (current_cpu, pc, "sfmt_l_macu", "f_r2 0x%x", 'x', f_r2, "f_r3 0x%x", 'x', f_r3, (char *) 0));
+
 #undef FLD
     return idesc;
   }
diff --git a/sim/or1k/decode.h b/sim/or1k/decode.h
index 019a0aa342..b45e4f205d 100644
--- a/sim/or1k/decode.h
+++ b/sim/or1k/decode.h
@@ -35,50 +35,52 @@ extern void or1k32bf_semf_init_idesc_table (SIM_CPU *);
 /* Enum declaration for instructions in cpu family or1k32bf.  */
 typedef enum or1k32bf_insn_type {
   OR1K32BF_INSN_X_INVALID, OR1K32BF_INSN_X_AFTER, OR1K32BF_INSN_X_BEFORE, OR1K32BF_INSN_X_CTI_CHAIN
- , OR1K32BF_INSN_X_CHAIN, OR1K32BF_INSN_X_BEGIN, OR1K32BF_INSN_L_J, OR1K32BF_INSN_L_JAL
- , OR1K32BF_INSN_L_JR, OR1K32BF_INSN_L_JALR, OR1K32BF_INSN_L_BNF, OR1K32BF_INSN_L_BF
- , OR1K32BF_INSN_L_TRAP, OR1K32BF_INSN_L_SYS, OR1K32BF_INSN_L_MSYNC, OR1K32BF_INSN_L_PSYNC
- , OR1K32BF_INSN_L_CSYNC, OR1K32BF_INSN_L_RFE, OR1K32BF_INSN_L_NOP_IMM, OR1K32BF_INSN_L_MOVHI
- , OR1K32BF_INSN_L_MACRC, OR1K32BF_INSN_L_MFSPR, OR1K32BF_INSN_L_MTSPR, OR1K32BF_INSN_L_LWZ
- , OR1K32BF_INSN_L_LWS, OR1K32BF_INSN_L_LWA, OR1K32BF_INSN_L_LBZ, OR1K32BF_INSN_L_LBS
- , OR1K32BF_INSN_L_LHZ, OR1K32BF_INSN_L_LHS, OR1K32BF_INSN_L_SW, OR1K32BF_INSN_L_SB
- , OR1K32BF_INSN_L_SH, OR1K32BF_INSN_L_SWA, OR1K32BF_INSN_L_SLL, OR1K32BF_INSN_L_SLLI
- , OR1K32BF_INSN_L_SRL, OR1K32BF_INSN_L_SRLI, OR1K32BF_INSN_L_SRA, OR1K32BF_INSN_L_SRAI
- , OR1K32BF_INSN_L_ROR, OR1K32BF_INSN_L_RORI, OR1K32BF_INSN_L_AND, OR1K32BF_INSN_L_OR
- , OR1K32BF_INSN_L_XOR, OR1K32BF_INSN_L_ADD, OR1K32BF_INSN_L_SUB, OR1K32BF_INSN_L_ADDC
- , OR1K32BF_INSN_L_MUL, OR1K32BF_INSN_L_MULU, OR1K32BF_INSN_L_DIV, OR1K32BF_INSN_L_DIVU
- , OR1K32BF_INSN_L_FF1, OR1K32BF_INSN_L_FL1, OR1K32BF_INSN_L_ANDI, OR1K32BF_INSN_L_ORI
- , OR1K32BF_INSN_L_XORI, OR1K32BF_INSN_L_ADDI, OR1K32BF_INSN_L_ADDIC, OR1K32BF_INSN_L_MULI
- , OR1K32BF_INSN_L_EXTHS, OR1K32BF_INSN_L_EXTBS, OR1K32BF_INSN_L_EXTHZ, OR1K32BF_INSN_L_EXTBZ
- , OR1K32BF_INSN_L_EXTWS, OR1K32BF_INSN_L_EXTWZ, OR1K32BF_INSN_L_CMOV, OR1K32BF_INSN_L_SFGTS
- , OR1K32BF_INSN_L_SFGTSI, OR1K32BF_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGES
- , OR1K32BF_INSN_L_SFGESI, OR1K32BF_INSN_L_SFGEU, OR1K32BF_INSN_L_SFGEUI, OR1K32BF_INSN_L_SFLTS
- , OR1K32BF_INSN_L_SFLTSI, OR1K32BF_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLES
- , OR1K32BF_INSN_L_SFLESI, OR1K32BF_INSN_L_SFLEU, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFEQ
- , OR1K32BF_INSN_L_SFEQI, OR1K32BF_INSN_L_SFNE, OR1K32BF_INSN_L_SFNEI, OR1K32BF_INSN_L_MAC
- , OR1K32BF_INSN_L_MSB, OR1K32BF_INSN_L_MACI, OR1K32BF_INSN_L_CUST1, OR1K32BF_INSN_L_CUST2
- , OR1K32BF_INSN_L_CUST3, OR1K32BF_INSN_L_CUST4, OR1K32BF_INSN_L_CUST5, OR1K32BF_INSN_L_CUST6
- , OR1K32BF_INSN_L_CUST7, OR1K32BF_INSN_L_CUST8, OR1K32BF_INSN_LF_ADD_S, OR1K32BF_INSN_LF_SUB_S
- , OR1K32BF_INSN_LF_MUL_S, OR1K32BF_INSN_LF_DIV_S, OR1K32BF_INSN_LF_REM_S, OR1K32BF_INSN_LF_ITOF_S
- , OR1K32BF_INSN_LF_FTOI_S, OR1K32BF_INSN_LF_EQ_S, OR1K32BF_INSN_LF_NE_S, OR1K32BF_INSN_LF_GE_S
- , OR1K32BF_INSN_LF_GT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_INSN_LF_LE_S, OR1K32BF_INSN_LF_MADD_S
- , OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_INSN__MAX
+ , OR1K32BF_INSN_X_CHAIN, OR1K32BF_INSN_X_BEGIN, OR1K32BF_INSN_L_J, OR1K32BF_INSN_L_ADRP
+ , OR1K32BF_INSN_L_JAL, OR1K32BF_INSN_L_JR, OR1K32BF_INSN_L_JALR, OR1K32BF_INSN_L_BNF
+ , OR1K32BF_INSN_L_BF, OR1K32BF_INSN_L_TRAP, OR1K32BF_INSN_L_SYS, OR1K32BF_INSN_L_MSYNC
+ , OR1K32BF_INSN_L_PSYNC, OR1K32BF_INSN_L_CSYNC, OR1K32BF_INSN_L_RFE, OR1K32BF_INSN_L_NOP_IMM
+ , OR1K32BF_INSN_L_MOVHI, OR1K32BF_INSN_L_MACRC, OR1K32BF_INSN_L_MFSPR, OR1K32BF_INSN_L_MTSPR
+ , OR1K32BF_INSN_L_LWZ, OR1K32BF_INSN_L_LWS, OR1K32BF_INSN_L_LWA, OR1K32BF_INSN_L_LBZ
+ , OR1K32BF_INSN_L_LBS, OR1K32BF_INSN_L_LHZ, OR1K32BF_INSN_L_LHS, OR1K32BF_INSN_L_SW
+ , OR1K32BF_INSN_L_SB, OR1K32BF_INSN_L_SH, OR1K32BF_INSN_L_SWA, OR1K32BF_INSN_L_SLL
+ , OR1K32BF_INSN_L_SLLI, OR1K32BF_INSN_L_SRL, OR1K32BF_INSN_L_SRLI, OR1K32BF_INSN_L_SRA
+ , OR1K32BF_INSN_L_SRAI, OR1K32BF_INSN_L_ROR, OR1K32BF_INSN_L_RORI, OR1K32BF_INSN_L_AND
+ , OR1K32BF_INSN_L_OR, OR1K32BF_INSN_L_XOR, OR1K32BF_INSN_L_ADD, OR1K32BF_INSN_L_SUB
+ , OR1K32BF_INSN_L_ADDC, OR1K32BF_INSN_L_MUL, OR1K32BF_INSN_L_MULD, OR1K32BF_INSN_L_MULU
+ , OR1K32BF_INSN_L_MULDU, OR1K32BF_INSN_L_DIV, OR1K32BF_INSN_L_DIVU, OR1K32BF_INSN_L_FF1
+ , OR1K32BF_INSN_L_FL1, OR1K32BF_INSN_L_ANDI, OR1K32BF_INSN_L_ORI, OR1K32BF_INSN_L_XORI
+ , OR1K32BF_INSN_L_ADDI, OR1K32BF_INSN_L_ADDIC, OR1K32BF_INSN_L_MULI, OR1K32BF_INSN_L_EXTHS
+ , OR1K32BF_INSN_L_EXTBS, OR1K32BF_INSN_L_EXTHZ, OR1K32BF_INSN_L_EXTBZ, OR1K32BF_INSN_L_EXTWS
+ , OR1K32BF_INSN_L_EXTWZ, OR1K32BF_INSN_L_CMOV, OR1K32BF_INSN_L_SFGTS, OR1K32BF_INSN_L_SFGTSI
+ , OR1K32BF_INSN_L_SFGTU, OR1K32BF_INSN_L_SFGTUI, OR1K32BF_INSN_L_SFGES, OR1K32BF_INSN_L_SFGESI
+ , OR1K32BF_INSN_L_SFGEU, OR1K32BF_INSN_L_SFGEUI, OR1K32BF_INSN_L_SFLTS, OR1K32BF_INSN_L_SFLTSI
+ , OR1K32BF_INSN_L_SFLTU, OR1K32BF_INSN_L_SFLTUI, OR1K32BF_INSN_L_SFLES, OR1K32BF_INSN_L_SFLESI
+ , OR1K32BF_INSN_L_SFLEU, OR1K32BF_INSN_L_SFLEUI, OR1K32BF_INSN_L_SFEQ, OR1K32BF_INSN_L_SFEQI
+ , OR1K32BF_INSN_L_SFNE, OR1K32BF_INSN_L_SFNEI, OR1K32BF_INSN_L_MAC, OR1K32BF_INSN_L_MACI
+ , OR1K32BF_INSN_L_MACU, OR1K32BF_INSN_L_MSB, OR1K32BF_INSN_L_MSBU, OR1K32BF_INSN_L_CUST1
+ , OR1K32BF_INSN_L_CUST2, OR1K32BF_INSN_L_CUST3, OR1K32BF_INSN_L_CUST4, OR1K32BF_INSN_L_CUST5
+ , OR1K32BF_INSN_L_CUST6, OR1K32BF_INSN_L_CUST7, OR1K32BF_INSN_L_CUST8, OR1K32BF_INSN_LF_ADD_S
+ , OR1K32BF_INSN_LF_SUB_S, OR1K32BF_INSN_LF_MUL_S, OR1K32BF_INSN_LF_DIV_S, OR1K32BF_INSN_LF_REM_S
+ , OR1K32BF_INSN_LF_ITOF_S, OR1K32BF_INSN_LF_FTOI_S, OR1K32BF_INSN_LF_EQ_S, OR1K32BF_INSN_LF_NE_S
+ , OR1K32BF_INSN_LF_GE_S, OR1K32BF_INSN_LF_GT_S, OR1K32BF_INSN_LF_LT_S, OR1K32BF_INSN_LF_LE_S
+ , OR1K32BF_INSN_LF_MADD_S, OR1K32BF_INSN_LF_CUST1_S, OR1K32BF_INSN__MAX
 } OR1K32BF_INSN_TYPE;
 
 /* Enum declaration for semantic formats in cpu family or1k32bf.  */
 typedef enum or1k32bf_sfmt_type {
-  OR1K32BF_SFMT_EMPTY, OR1K32BF_SFMT_L_J, OR1K32BF_SFMT_L_JAL, OR1K32BF_SFMT_L_JR
- , OR1K32BF_SFMT_L_JALR, OR1K32BF_SFMT_L_BNF, OR1K32BF_SFMT_L_TRAP, OR1K32BF_SFMT_L_MSYNC
- , OR1K32BF_SFMT_L_NOP_IMM, OR1K32BF_SFMT_L_MOVHI, OR1K32BF_SFMT_L_MACRC, OR1K32BF_SFMT_L_MFSPR
- , OR1K32BF_SFMT_L_MTSPR, OR1K32BF_SFMT_L_LWZ, OR1K32BF_SFMT_L_LWS, OR1K32BF_SFMT_L_LWA
- , OR1K32BF_SFMT_L_LBZ, OR1K32BF_SFMT_L_LBS, OR1K32BF_SFMT_L_LHZ, OR1K32BF_SFMT_L_LHS
- , OR1K32BF_SFMT_L_SW, OR1K32BF_SFMT_L_SB, OR1K32BF_SFMT_L_SH, OR1K32BF_SFMT_L_SWA
- , OR1K32BF_SFMT_L_SLL, OR1K32BF_SFMT_L_SLLI, OR1K32BF_SFMT_L_AND, OR1K32BF_SFMT_L_ADD
- , OR1K32BF_SFMT_L_ADDC, OR1K32BF_SFMT_L_DIV, OR1K32BF_SFMT_L_FF1, OR1K32BF_SFMT_L_XORI
- , OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC, OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV
- , OR1K32BF_SFMT_L_SFGTS, OR1K32BF_SFMT_L_SFGTSI, OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI
- , OR1K32BF_SFMT_LF_ADD_S, OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S
- , OR1K32BF_SFMT_LF_MADD_S
+  OR1K32BF_SFMT_EMPTY, OR1K32BF_SFMT_L_J, OR1K32BF_SFMT_L_ADRP, OR1K32BF_SFMT_L_JAL
+ , OR1K32BF_SFMT_L_JR, OR1K32BF_SFMT_L_JALR, OR1K32BF_SFMT_L_BNF, OR1K32BF_SFMT_L_TRAP
+ , OR1K32BF_SFMT_L_MSYNC, OR1K32BF_SFMT_L_NOP_IMM, OR1K32BF_SFMT_L_MOVHI, OR1K32BF_SFMT_L_MACRC
+ , OR1K32BF_SFMT_L_MFSPR, OR1K32BF_SFMT_L_MTSPR, OR1K32BF_SFMT_L_LWZ, OR1K32BF_SFMT_L_LWS
+ , OR1K32BF_SFMT_L_LWA, OR1K32BF_SFMT_L_LBZ, OR1K32BF_SFMT_L_LBS, OR1K32BF_SFMT_L_LHZ
+ , OR1K32BF_SFMT_L_LHS, OR1K32BF_SFMT_L_SW, OR1K32BF_SFMT_L_SB, OR1K32BF_SFMT_L_SH
+ , OR1K32BF_SFMT_L_SWA, OR1K32BF_SFMT_L_SLL, OR1K32BF_SFMT_L_SLLI, OR1K32BF_SFMT_L_AND
+ , OR1K32BF_SFMT_L_ADD, OR1K32BF_SFMT_L_ADDC, OR1K32BF_SFMT_L_MUL, OR1K32BF_SFMT_L_MULD
+ , OR1K32BF_SFMT_L_MULU, OR1K32BF_SFMT_L_DIV, OR1K32BF_SFMT_L_DIVU, OR1K32BF_SFMT_L_FF1
+ , OR1K32BF_SFMT_L_XORI, OR1K32BF_SFMT_L_ADDI, OR1K32BF_SFMT_L_ADDIC, OR1K32BF_SFMT_L_MULI
+ , OR1K32BF_SFMT_L_EXTHS, OR1K32BF_SFMT_L_CMOV, OR1K32BF_SFMT_L_SFGTS, OR1K32BF_SFMT_L_SFGTSI
+ , OR1K32BF_SFMT_L_MAC, OR1K32BF_SFMT_L_MACI, OR1K32BF_SFMT_L_MACU, OR1K32BF_SFMT_LF_ADD_S
+ , OR1K32BF_SFMT_LF_ITOF_S, OR1K32BF_SFMT_LF_FTOI_S, OR1K32BF_SFMT_LF_EQ_S, OR1K32BF_SFMT_LF_MADD_S
 } OR1K32BF_SFMT_TYPE;
 
 /* Function unit handlers (user written).  */
diff --git a/sim/or1k/model.c b/sim/or1k/model.c
index 35c6479fd7..bf6b00b33a 100644
--- a/sim/or1k/model.c
+++ b/sim/or1k/model.c
@@ -50,6 +50,22 @@ model_or1200_l_j (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_l_adrp (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_l_jal (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -261,7 +277,7 @@ model_or1200_l_movhi (SIM_CPU *current_cpu, void *sem_arg)
 static int
 model_or1200_l_macrc (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -722,6 +738,22 @@ model_or1200_l_mul (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_l_muld (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_l_mulu (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -738,6 +770,22 @@ model_or1200_l_mulu (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_l_muldu (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_l_div (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1346,6 +1394,38 @@ model_or1200_l_mac (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200_l_maci (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
+static int
+model_or1200_l_macu (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1363,9 +1443,9 @@ model_or1200_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200_l_maci (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200_l_msbu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -1762,6 +1842,22 @@ model_or1200nd_l_j (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_l_adrp (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_l_jal (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -1973,7 +2069,7 @@ model_or1200nd_l_movhi (SIM_CPU *current_cpu, void *sem_arg)
 static int
 model_or1200nd_l_macrc (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -2434,6 +2530,22 @@ model_or1200nd_l_mul (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_l_muld (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_l_mulu (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -2450,6 +2562,22 @@ model_or1200nd_l_mulu (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_l_muldu (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_l_div (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3058,6 +3186,38 @@ model_or1200nd_l_mac (SIM_CPU *current_cpu, void *sem_arg)
 #undef FLD
 }
 
+static int
+model_or1200nd_l_maci (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
+static int
+model_or1200nd_l_macu (SIM_CPU *current_cpu, void *sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
+  const IDESC * UNUSED idesc = abuf->idesc;
+  int cycles = 0;
+  {
+    int referenced = 0;
+    int UNUSED insn_referenced = abuf->written;
+    cycles += or1k32bf_model_or1200nd_u_exec (current_cpu, idesc, 0, referenced);
+  }
+  return cycles;
+#undef FLD
+}
+
 static int
 model_or1200nd_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 {
@@ -3075,9 +3235,9 @@ model_or1200nd_l_msb (SIM_CPU *current_cpu, void *sem_arg)
 }
 
 static int
-model_or1200nd_l_maci (SIM_CPU *current_cpu, void *sem_arg)
+model_or1200nd_l_msbu (SIM_CPU *current_cpu, void *sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   const ARGBUF * UNUSED abuf = SEM_ARGBUF ((SEM_ARG) sem_arg);
   const IDESC * UNUSED idesc = abuf->idesc;
   int cycles = 0;
@@ -3471,6 +3631,7 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_X_CHAIN, 0, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_X_BEGIN, 0, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_J, model_or1200_l_j, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_ADRP, model_or1200_l_adrp, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_JAL, model_or1200_l_jal, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_JR, model_or1200_l_jr, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_JALR, model_or1200_l_jalr, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
@@ -3513,7 +3674,9 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_L_SUB, model_or1200_l_sub, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_ADDC, model_or1200_l_addc, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MUL, model_or1200_l_mul, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MULD, model_or1200_l_muld, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MULU, model_or1200_l_mulu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MULDU, model_or1200_l_muldu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_DIV, model_or1200_l_div, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_DIVU, model_or1200_l_divu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_FF1, model_or1200_l_ff1, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
@@ -3552,8 +3715,10 @@ static const INSN_TIMING or1200_timing[] = {
   { OR1K32BF_INSN_L_SFNE, model_or1200_l_sfne, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFNEI, model_or1200_l_sfnei, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MAC, model_or1200_l_mac, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_MSB, model_or1200_l_msb, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MACI, model_or1200_l_maci, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MACU, model_or1200_l_macu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MSB, model_or1200_l_msb, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MSBU, model_or1200_l_msbu, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST1, model_or1200_l_cust1, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST2, model_or1200_l_cust2, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST3, model_or1200_l_cust3, { { (int) UNIT_OR1200_U_EXEC, 1, 1 } } },
@@ -3589,6 +3754,7 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_X_CHAIN, 0, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_X_BEGIN, 0, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_J, model_or1200nd_l_j, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_ADRP, model_or1200nd_l_adrp, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_JAL, model_or1200nd_l_jal, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_JR, model_or1200nd_l_jr, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_JALR, model_or1200nd_l_jalr, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
@@ -3631,7 +3797,9 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_L_SUB, model_or1200nd_l_sub, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_ADDC, model_or1200nd_l_addc, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MUL, model_or1200nd_l_mul, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MULD, model_or1200nd_l_muld, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MULU, model_or1200nd_l_mulu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MULDU, model_or1200nd_l_muldu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_DIV, model_or1200nd_l_div, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_DIVU, model_or1200nd_l_divu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_FF1, model_or1200nd_l_ff1, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
@@ -3670,8 +3838,10 @@ static const INSN_TIMING or1200nd_timing[] = {
   { OR1K32BF_INSN_L_SFNE, model_or1200nd_l_sfne, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_SFNEI, model_or1200nd_l_sfnei, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MAC, model_or1200nd_l_mac, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
-  { OR1K32BF_INSN_L_MSB, model_or1200nd_l_msb, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_MACI, model_or1200nd_l_maci, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MACU, model_or1200nd_l_macu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MSB, model_or1200nd_l_msb, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
+  { OR1K32BF_INSN_L_MSBU, model_or1200nd_l_msbu, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST1, model_or1200nd_l_cust1, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST2, model_or1200nd_l_cust2, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
   { OR1K32BF_INSN_L_CUST3, model_or1200nd_l_cust3, { { (int) UNIT_OR1200ND_U_EXEC, 1, 1 } } },
diff --git a/sim/or1k/sem-switch.c b/sim/or1k/sem-switch.c
index 2f8e0f34da..2045567214 100644
--- a/sim/or1k/sem-switch.c
+++ b/sim/or1k/sem-switch.c
@@ -39,6 +39,7 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_X_CHAIN, && case_sem_INSN_X_CHAIN },
     { OR1K32BF_INSN_X_BEGIN, && case_sem_INSN_X_BEGIN },
     { OR1K32BF_INSN_L_J, && case_sem_INSN_L_J },
+    { OR1K32BF_INSN_L_ADRP, && case_sem_INSN_L_ADRP },
     { OR1K32BF_INSN_L_JAL, && case_sem_INSN_L_JAL },
     { OR1K32BF_INSN_L_JR, && case_sem_INSN_L_JR },
     { OR1K32BF_INSN_L_JALR, && case_sem_INSN_L_JALR },
@@ -81,7 +82,9 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_L_SUB, && case_sem_INSN_L_SUB },
     { OR1K32BF_INSN_L_ADDC, && case_sem_INSN_L_ADDC },
     { OR1K32BF_INSN_L_MUL, && case_sem_INSN_L_MUL },
+    { OR1K32BF_INSN_L_MULD, && case_sem_INSN_L_MULD },
     { OR1K32BF_INSN_L_MULU, && case_sem_INSN_L_MULU },
+    { OR1K32BF_INSN_L_MULDU, && case_sem_INSN_L_MULDU },
     { OR1K32BF_INSN_L_DIV, && case_sem_INSN_L_DIV },
     { OR1K32BF_INSN_L_DIVU, && case_sem_INSN_L_DIVU },
     { OR1K32BF_INSN_L_FF1, && case_sem_INSN_L_FF1 },
@@ -120,8 +123,10 @@ This file is part of the GNU simulators.
     { OR1K32BF_INSN_L_SFNE, && case_sem_INSN_L_SFNE },
     { OR1K32BF_INSN_L_SFNEI, && case_sem_INSN_L_SFNEI },
     { OR1K32BF_INSN_L_MAC, && case_sem_INSN_L_MAC },
-    { OR1K32BF_INSN_L_MSB, && case_sem_INSN_L_MSB },
     { OR1K32BF_INSN_L_MACI, && case_sem_INSN_L_MACI },
+    { OR1K32BF_INSN_L_MACU, && case_sem_INSN_L_MACU },
+    { OR1K32BF_INSN_L_MSB, && case_sem_INSN_L_MSB },
+    { OR1K32BF_INSN_L_MSBU, && case_sem_INSN_L_MSBU },
     { OR1K32BF_INSN_L_CUST1, && case_sem_INSN_L_CUST1 },
     { OR1K32BF_INSN_L_CUST2, && case_sem_INSN_L_CUST2 },
     { OR1K32BF_INSN_L_CUST3, && case_sem_INSN_L_CUST3 },
@@ -373,6 +378,25 @@ if (1)
 }
   NEXT (vpc);
 
+  CASE (sem, INSN_L_ADRP) : /* l.adrp $rD,${disp21} */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    USI opval = FLD (i_disp21);
+    SET_H_GPR (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+  }
+
+#undef FLD
+}
+  NEXT (vpc);
+
   CASE (sem, INSN_L_JAL) : /* l.jal ${disp26} */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
@@ -690,7 +714,7 @@ or1k32bf_nop (current_cpu, ZEXTSISI (FLD (f_uimm16)));
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
@@ -1365,11 +1389,6 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     SET_H_SYS_SR_OV (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
-  {
-    BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
-    SET_H_SYS_SR_CY (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
-  }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
@@ -1385,7 +1404,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_MULU) : /* l.mulu $rD,$rA,$rB */
+  CASE (sem, INSN_L_MULD) : /* l.muld $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1395,12 +1414,35 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-{
+  DI tmp_result;
+  tmp_result = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (GET_H_GPR (FLD (f_r3))));
   {
-    BI opval = 0;
-    SET_H_SYS_SR_OV (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
+}
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_MULU) : /* l.mulu $rD,$rA,$rB */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+{
   {
     BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
@@ -1412,7 +1454,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
-if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
 }
@@ -1421,7 +1463,7 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_DIV) : /* l.div $rD,$rA,$rB */
+  CASE (sem, INSN_L_MULDU) : /* l.muldu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
@@ -1431,37 +1473,60 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
+  DI tmp_result;
+  tmp_result = MULDI (ZEXTSIDI (GET_H_GPR (FLD (f_r2))), ZEXTSIDI (GET_H_GPR (FLD (f_r3))));
+  {
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+  }
+}
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_DIV) : /* l.div $rD,$rA,$rB */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
 if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
 {
   {
     BI opval = 0;
-    SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    SET_H_SYS_SR_OV (opval);
+    written |= (1 << 5);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     SI opval = DIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    written |= (1 << 5);
+    written |= (1 << 4);
     CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
+{
   {
     BI opval = 1;
-    SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
-  }
-}
-  {
-    BI opval = 0;
     SET_H_SYS_SR_OV (opval);
+    written |= (1 << 5);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
-if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+if (GET_H_SYS_SR_OVE ()) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
+}
 }
 
   abuf->written = written;
@@ -1478,38 +1543,33 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-{
 if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
 {
   {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
+    written |= (1 << 5);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = UDIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    written |= (1 << 5);
+    written |= (1 << 4);
     CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
+{
   {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
+    written |= (1 << 5);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
-}
-  {
-    BI opval = 0;
-    SET_H_SYS_SR_OV (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
-  }
-if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+if (GET_H_SYS_SR_OVE ()) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
+}
 }
 
   abuf->written = written;
@@ -1702,11 +1762,6 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
     SET_H_SYS_SR_OV (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
-  {
-    USI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
-    SET_H_SYS_SR_CY (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
-  }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
@@ -2256,10 +2311,97 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  SI tmp_prod;
+{
+  DI tmp_prod;
+  DI tmp_mac;
+  DI tmp_result;
+  tmp_prod = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = ADDDI (tmp_prod, tmp_mac);
+  {
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+  }
+  {
+    BI opval = ADDOFDI (tmp_prod, tmp_mac, 0);
+    SET_H_SYS_SR_OV (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
+}
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_MACI) : /* l.maci $rA,${simm16} */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+{
+  DI tmp_prod;
+  DI tmp_mac;
+  DI tmp_result;
+  tmp_prod = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (FLD (f_simm16)));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = ADDDI (tmp_mac, tmp_prod);
+  {
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+  }
+  {
+    BI opval = ADDOFDI (tmp_prod, tmp_mac, 0);
+    SET_H_SYS_SR_OV (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
+}
+
+#undef FLD
+}
+  NEXT (vpc);
+
+  CASE (sem, INSN_L_MACU) : /* l.macu $rA,$rB */
+{
+  SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+{
+  DI tmp_prod;
+  DI tmp_mac;
   DI tmp_result;
-  tmp_prod = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
-  tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
+  tmp_prod = MULDI (ZEXTSIDI (GET_H_GPR (FLD (f_r2))), ZEXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = ADDDI (tmp_prod, tmp_mac);
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
@@ -2270,6 +2412,15 @@ if (GET_H_SYS_SR_F ()) {
     SET_H_MAC_MACLO (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
+  {
+    BI opval = ADDCFDI (tmp_prod, tmp_mac, 0);
+    SET_H_SYS_SR_CY (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
 }
 
 #undef FLD
@@ -2286,10 +2437,13 @@ if (GET_H_SYS_SR_F ()) {
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  SI tmp_prod;
+{
+  DI tmp_prod;
+  DI tmp_mac;
   DI tmp_result;
-  tmp_prod = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
-  tmp_result = SUBDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
+  tmp_prod = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = SUBDI (tmp_mac, tmp_prod);
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
@@ -2300,26 +2454,38 @@ if (GET_H_SYS_SR_F ()) {
     SET_H_MAC_MACLO (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
+  {
+    BI opval = SUBOFDI (tmp_mac, tmp_result, 0);
+    SET_H_SYS_SR_OV (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
 }
 
 #undef FLD
 }
   NEXT (vpc);
 
-  CASE (sem, INSN_L_MACI) : /* l.maci $rA,${simm16} */
+  CASE (sem, INSN_L_MSBU) : /* l.msbu $rA,$rB */
 {
   SEM_ARG sem_arg = SEM_SEM_ARG (vpc, sc);
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  SI tmp_prod;
+{
+  DI tmp_prod;
+  DI tmp_mac;
   DI tmp_result;
-  tmp_prod = MULSI (EXTSISI (FLD (f_simm16)), GET_H_GPR (FLD (f_r2)));
-  tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
+  tmp_prod = MULDI (ZEXTSIDI (GET_H_GPR (FLD (f_r2))), ZEXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = SUBDI (tmp_mac, tmp_prod);
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
@@ -2330,6 +2496,15 @@ if (GET_H_SYS_SR_F ()) {
     SET_H_MAC_MACLO (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
+  {
+    BI opval = SUBCFDI (tmp_mac, tmp_result, 0);
+    SET_H_SYS_SR_CY (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
 }
 
 #undef FLD
diff --git a/sim/or1k/sem.c b/sim/or1k/sem.c
index 6c052ac79d..f67e50e5f5 100644
--- a/sim/or1k/sem.c
+++ b/sim/or1k/sem.c
@@ -228,6 +228,27 @@ if (1)
 #undef FLD
 }
 
+/* l-adrp: l.adrp $rD,${disp21} */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_adrp) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+  {
+    USI opval = FLD (i_disp21);
+    SET_H_GPR (FLD (f_r1), opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
+  }
+
+  return vpc;
+#undef FLD
+}
+
 /* l-jal: l.jal ${disp26} */
 
 static SEM_PC
@@ -572,7 +593,7 @@ SEM_FN_NAME (or1k32bf,l_movhi) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 static SEM_PC
 SEM_FN_NAME (or1k32bf,l_macrc) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_slli.f
+#define FLD(f) abuf->fields.sfmt_l_adrp.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
@@ -1304,11 +1325,6 @@ SEM_FN_NAME (or1k32bf,l_mul) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
     SET_H_SYS_SR_OV (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
-  {
-    BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
-    SET_H_SYS_SR_CY (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
-  }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
@@ -1324,6 +1340,36 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 #undef FLD
 }
 
+/* l-muld: l.muld $rA,$rB */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_muld) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  DI tmp_result;
+  tmp_result = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (GET_H_GPR (FLD (f_r3))));
+  {
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+  }
+}
+
+  return vpc;
+#undef FLD
+}
+
 /* l-mulu: l.mulu $rD,$rA,$rB */
 
 static SEM_PC
@@ -1337,11 +1383,6 @@ SEM_FN_NAME (or1k32bf,l_mulu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 
 {
 {
-  {
-    BI opval = 0;
-    SET_H_SYS_SR_OV (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
-  }
   {
     BI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_SYS_SR_CY (opval);
@@ -1353,7 +1394,7 @@ SEM_FN_NAME (or1k32bf,l_mulu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
     CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
-if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
 }
@@ -1362,6 +1403,36 @@ or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 #undef FLD
 }
 
+/* l-muldu: l.muldu $rA,$rB */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_muldu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+  DI tmp_result;
+  tmp_result = MULDI (ZEXTSIDI (GET_H_GPR (FLD (f_r2))), ZEXTSIDI (GET_H_GPR (FLD (f_r3))));
+  {
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+  }
+}
+
+  return vpc;
+#undef FLD
+}
+
 /* l-div: l.div $rD,$rA,$rB */
 
 static SEM_PC
@@ -1373,38 +1444,33 @@ SEM_FN_NAME (or1k32bf,l_div) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-{
 if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
 {
   {
     BI opval = 0;
-    SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+    SET_H_SYS_SR_OV (opval);
+    written |= (1 << 5);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
   {
     SI opval = DIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    written |= (1 << 5);
+    written |= (1 << 4);
     CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
+{
   {
     BI opval = 1;
-    SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
-  }
-}
-  {
-    BI opval = 0;
     SET_H_SYS_SR_OV (opval);
+    written |= (1 << 5);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
-if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+if (GET_H_SYS_SR_OVE ()) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
+}
 }
 
   abuf->written = written;
@@ -1423,38 +1489,33 @@ SEM_FN_NAME (or1k32bf,l_divu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
-{
 if (NESI (GET_H_GPR (FLD (f_r3)), 0)) {
 {
   {
     BI opval = 0;
     SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
+    written |= (1 << 5);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
   {
     USI opval = UDIVSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
     SET_H_GPR (FLD (f_r1), opval);
-    written |= (1 << 5);
+    written |= (1 << 4);
     CGEN_TRACE_RESULT (current_cpu, abuf, "gpr", 'x', opval);
   }
 }
 } else {
+{
   {
     BI opval = 1;
     SET_H_SYS_SR_CY (opval);
-    written |= (1 << 6);
+    written |= (1 << 5);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
   }
-}
-  {
-    BI opval = 0;
-    SET_H_SYS_SR_OV (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
-  }
-if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+if (GET_H_SYS_SR_OVE ()) {
 or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
 }
+}
 }
 
   abuf->written = written;
@@ -1663,11 +1724,6 @@ SEM_FN_NAME (or1k32bf,l_muli) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
     SET_H_SYS_SR_OV (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
   }
-  {
-    USI opval = MUL1OFSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
-    SET_H_SYS_SR_CY (opval);
-    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
-  }
   {
     USI opval = MULSI (GET_H_GPR (FLD (f_r2)), EXTSISI (FLD (f_simm16)));
     SET_H_GPR (FLD (f_r1), opval);
@@ -2273,10 +2329,13 @@ SEM_FN_NAME (or1k32bf,l_mac) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  SI tmp_prod;
+{
+  DI tmp_prod;
+  DI tmp_mac;
   DI tmp_result;
-  tmp_prod = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
-  tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
+  tmp_prod = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = ADDDI (tmp_prod, tmp_mac);
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
@@ -2287,6 +2346,103 @@ SEM_FN_NAME (or1k32bf,l_mac) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
     SET_H_MAC_MACLO (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
+  {
+    BI opval = ADDOFDI (tmp_prod, tmp_mac, 0);
+    SET_H_SYS_SR_OV (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
+}
+
+  return vpc;
+#undef FLD
+}
+
+/* l-maci: l.maci $rA,${simm16} */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_lwz.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+{
+  DI tmp_prod;
+  DI tmp_mac;
+  DI tmp_result;
+  tmp_prod = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (FLD (f_simm16)));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = ADDDI (tmp_mac, tmp_prod);
+  {
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+  }
+  {
+    BI opval = ADDOFDI (tmp_prod, tmp_mac, 0);
+    SET_H_SYS_SR_OV (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
+}
+
+  return vpc;
+#undef FLD
+}
+
+/* l-macu: l.macu $rA,$rB */
+
+static SEM_PC
+SEM_FN_NAME (or1k32bf,l_macu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+{
+#define FLD(f) abuf->fields.sfmt_l_sll.f
+  ARGBUF *abuf = SEM_ARGBUF (sem_arg);
+  int UNUSED written = 0;
+  IADDR UNUSED pc = abuf->addr;
+  SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
+
+{
+{
+  DI tmp_prod;
+  DI tmp_mac;
+  DI tmp_result;
+  tmp_prod = MULDI (ZEXTSIDI (GET_H_GPR (FLD (f_r2))), ZEXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = ADDDI (tmp_prod, tmp_mac);
+  {
+    SI opval = SUBWORDDISI (tmp_result, 0);
+    SET_H_MAC_MACHI (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-machi", 'x', opval);
+  }
+  {
+    SI opval = SUBWORDDISI (tmp_result, 1);
+    SET_H_MAC_MACLO (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
+  }
+  {
+    BI opval = ADDCFDI (tmp_prod, tmp_mac, 0);
+    SET_H_SYS_SR_CY (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
 }
 
   return vpc;
@@ -2305,10 +2461,13 @@ SEM_FN_NAME (or1k32bf,l_msb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  SI tmp_prod;
+{
+  DI tmp_prod;
+  DI tmp_mac;
   DI tmp_result;
-  tmp_prod = MULSI (GET_H_GPR (FLD (f_r2)), GET_H_GPR (FLD (f_r3)));
-  tmp_result = SUBDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
+  tmp_prod = MULDI (EXTSIDI (GET_H_GPR (FLD (f_r2))), EXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = SUBDI (tmp_mac, tmp_prod);
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
@@ -2319,28 +2478,40 @@ SEM_FN_NAME (or1k32bf,l_msb) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
     SET_H_MAC_MACLO (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
+  {
+    BI opval = SUBOFDI (tmp_mac, tmp_result, 0);
+    SET_H_SYS_SR_OV (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-ov", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_OV (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
 }
 
   return vpc;
 #undef FLD
 }
 
-/* l-maci: l.maci $rA,${simm16} */
+/* l-msbu: l.msbu $rA,$rB */
 
 static SEM_PC
-SEM_FN_NAME (or1k32bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
+SEM_FN_NAME (or1k32bf,l_msbu) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
 {
-#define FLD(f) abuf->fields.sfmt_l_lwz.f
+#define FLD(f) abuf->fields.sfmt_l_sll.f
   ARGBUF *abuf = SEM_ARGBUF (sem_arg);
   int UNUSED written = 0;
   IADDR UNUSED pc = abuf->addr;
   SEM_PC vpc = SEM_NEXT_VPC (sem_arg, pc, 4);
 
 {
-  SI tmp_prod;
+{
+  DI tmp_prod;
+  DI tmp_mac;
   DI tmp_result;
-  tmp_prod = MULSI (EXTSISI (FLD (f_simm16)), GET_H_GPR (FLD (f_r2)));
-  tmp_result = ADDDI (JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ()), EXTSIDI (tmp_prod));
+  tmp_prod = MULDI (ZEXTSIDI (GET_H_GPR (FLD (f_r2))), ZEXTSIDI (GET_H_GPR (FLD (f_r3))));
+  tmp_mac = JOINSIDI (GET_H_MAC_MACHI (), GET_H_MAC_MACLO ());
+  tmp_result = SUBDI (tmp_mac, tmp_prod);
   {
     SI opval = SUBWORDDISI (tmp_result, 0);
     SET_H_MAC_MACHI (opval);
@@ -2351,6 +2522,15 @@ SEM_FN_NAME (or1k32bf,l_maci) (SIM_CPU *current_cpu, SEM_ARG sem_arg)
     SET_H_MAC_MACLO (opval);
     CGEN_TRACE_RESULT (current_cpu, abuf, "mac-maclo", 'x', opval);
   }
+  {
+    BI opval = SUBCFDI (tmp_mac, tmp_result, 0);
+    SET_H_SYS_SR_CY (opval);
+    CGEN_TRACE_RESULT (current_cpu, abuf, "sys-sr-cy", 'x', opval);
+  }
+}
+if (ANDIF (GET_H_SYS_SR_CY (), GET_H_SYS_SR_OVE ())) {
+or1k32bf_exception (current_cpu, pc, EXCEPT_RANGE);
+}
 }
 
   return vpc;
@@ -2814,6 +2994,7 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_X_CHAIN, SEM_FN_NAME (or1k32bf,x_chain) },
   { OR1K32BF_INSN_X_BEGIN, SEM_FN_NAME (or1k32bf,x_begin) },
   { OR1K32BF_INSN_L_J, SEM_FN_NAME (or1k32bf,l_j) },
+  { OR1K32BF_INSN_L_ADRP, SEM_FN_NAME (or1k32bf,l_adrp) },
   { OR1K32BF_INSN_L_JAL, SEM_FN_NAME (or1k32bf,l_jal) },
   { OR1K32BF_INSN_L_JR, SEM_FN_NAME (or1k32bf,l_jr) },
   { OR1K32BF_INSN_L_JALR, SEM_FN_NAME (or1k32bf,l_jalr) },
@@ -2856,7 +3037,9 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_L_SUB, SEM_FN_NAME (or1k32bf,l_sub) },
   { OR1K32BF_INSN_L_ADDC, SEM_FN_NAME (or1k32bf,l_addc) },
   { OR1K32BF_INSN_L_MUL, SEM_FN_NAME (or1k32bf,l_mul) },
+  { OR1K32BF_INSN_L_MULD, SEM_FN_NAME (or1k32bf,l_muld) },
   { OR1K32BF_INSN_L_MULU, SEM_FN_NAME (or1k32bf,l_mulu) },
+  { OR1K32BF_INSN_L_MULDU, SEM_FN_NAME (or1k32bf,l_muldu) },
   { OR1K32BF_INSN_L_DIV, SEM_FN_NAME (or1k32bf,l_div) },
   { OR1K32BF_INSN_L_DIVU, SEM_FN_NAME (or1k32bf,l_divu) },
   { OR1K32BF_INSN_L_FF1, SEM_FN_NAME (or1k32bf,l_ff1) },
@@ -2895,8 +3078,10 @@ static const struct sem_fn_desc sem_fns[] = {
   { OR1K32BF_INSN_L_SFNE, SEM_FN_NAME (or1k32bf,l_sfne) },
   { OR1K32BF_INSN_L_SFNEI, SEM_FN_NAME (or1k32bf,l_sfnei) },
   { OR1K32BF_INSN_L_MAC, SEM_FN_NAME (or1k32bf,l_mac) },
-  { OR1K32BF_INSN_L_MSB, SEM_FN_NAME (or1k32bf,l_msb) },
   { OR1K32BF_INSN_L_MACI, SEM_FN_NAME (or1k32bf,l_maci) },
+  { OR1K32BF_INSN_L_MACU, SEM_FN_NAME (or1k32bf,l_macu) },
+  { OR1K32BF_INSN_L_MSB, SEM_FN_NAME (or1k32bf,l_msb) },
+  { OR1K32BF_INSN_L_MSBU, SEM_FN_NAME (or1k32bf,l_msbu) },
   { OR1K32BF_INSN_L_CUST1, SEM_FN_NAME (or1k32bf,l_cust1) },
   { OR1K32BF_INSN_L_CUST2, SEM_FN_NAME (or1k32bf,l_cust2) },
   { OR1K32BF_INSN_L_CUST3, SEM_FN_NAME (or1k32bf,l_cust3) },
diff --git a/sim/testsuite/sim/or1k/div.S b/sim/testsuite/sim/or1k/div.S
index e1e28d5621..a3202e9f8c 100644
--- a/sim/testsuite/sim/or1k/div.S
+++ b/sim/testsuite/sim/or1k/div.S
@@ -75,30 +75,30 @@
 # output: report(0x0000000c);\n
 # output: report(0x00000000);\n
 # output: report(0xfffffffd);\n
-# output: report(0x00000001);\n
 # output: report(0x00000000);\n
+# output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffffff4);\n
 # output: report(0x00000000);\n
 # output: report(0xfffffffd);\n
-# output: report(0x00000001);\n
 # output: report(0x00000000);\n
+# output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0x0000000c);\n
 # output: report(0x00000000);\n
 # output: report(0xfffffffd);\n
-# output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: report(0x00000001);\n
+# output: report(0x00000001);\n
 # output: \n
 # output: report(0xfffffff4);\n
 # output: report(0x00000000);\n
 # output: report(0xfffffffd);\n
-# output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: report(0x00000001);\n
+# output: report(0x00000001);\n
 # output: \n
 # output: report(0x0000000c);\n
 # output: report(0x00000003);\n
@@ -233,7 +233,7 @@ start_tests:
 	TEST_INST_I32_I32 l.div, 0x0000000c, 0xfffffffd
 	TEST_INST_I32_I32 l.div, 0x0000000b, 0xfffffffd
 
-	/* Divide by zero.  This will set the carry flag.  */
+	/* Divide by zero.  This will set the overflow flag.  */
 	TEST_INST_I32_I32 l.div, 0x0000000c, 0x00000000
 	TEST_INST_I32_I32 l.div, 0xfffffff4, 0x00000000
 
@@ -241,7 +241,7 @@ start_tests:
 
 	SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
 
-	/* Divide by zero.  This will set the carry flag and trigger an
+	/* Divide by zero.  This will set the overflow flag and trigger an
 	   exception.  */
 	TEST_INST_I32_I32 l.div, 0x0000000c, 0x00000000
 	TEST_INST_I32_I32 l.div, 0xfffffff4, 0x00000000
diff --git a/sim/testsuite/sim/or1k/mul.S b/sim/testsuite/sim/or1k/mul.S
index 964badd951..70bbc41e19 100644
--- a/sim/testsuite/sim/or1k/mul.S
+++ b/sim/testsuite/sim/or1k/mul.S
@@ -40,56 +40,56 @@
 # output: report(0x00010000);\n
 # output: report(0x00010000);\n
 # output: report(0x00000000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffffffe);\n
 # output: report(0xfffffffd);\n
 # output: report(0x00000006);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xffff7fff);\n
 # output: report(0xffff0002);\n
 # output: report(0x7ffffffe);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xffff7fff);\n
 # output: report(0xffff0000);\n
 # output: report(0x80010000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xffff0000);\n
 # output: report(0xfffeffff);\n
 # output: report(0x00010000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0x00000002);\n
 # output: report(0xfffffffd);\n
 # output: report(0xfffffffa);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xffff8000);\n
 # output: report(0x00010000);\n
 # output: report(0x80000000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xffff7fff);\n
 # output: report(0x00010000);\n
 # output: report(0x7fff0000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
@@ -110,14 +110,14 @@
 # output: report(0x00000002);\n
 # output: report(0xfffffffd);\n
 # output: report(0xfffffffa);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xffff7fff);\n
 # output: report(0xffff0000);\n
 # output: report(0x80010000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000001);\n
 # output: \n
@@ -145,56 +145,56 @@
 # output: report(0x00040000);\n
 # output: report(0x00004000);\n
 # output: report(0x00000000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffffffe);\n
 # output: report(0x0000fffd);\n
 # output: report(0x00000006);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffefffe);\n
 # output: report(0x00008001);\n
 # output: report(0x7ffffffe);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffe0000);\n
 # output: report(0x0000bfff);\n
 # output: report(0x80020000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffdfffe);\n
 # output: report(0x00008000);\n
 # output: report(0x00010000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0x00000002);\n
 # output: report(0x0000fffd);\n
 # output: report(0xfffffffa);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0x00010000);\n
 # output: report(0x00008000);\n
 # output: report(0x80000000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffdfffc);\n
 # output: report(0x00004000);\n
 # output: report(0x7fff0000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
 # output: \n
@@ -215,14 +215,14 @@
 # output: report(0xfffffffe);\n
 # output: report(0x0000fffd);\n
 # output: report(0x00000006);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: report(0x00000000);\n
 # output: \n
 # output: report(0xfffdfffe);\n
 # output: report(0x00008000);\n
 # output: report(0x00010000);\n
-# output: report(0x00000001);\n
+# output: report(0x00000000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000001);\n
 # output: \n
@@ -322,14 +322,14 @@
 # output: report(0xfffffffa);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
-# output: report(0x00000000);\n
+# output: report(0x00000001);\n
 # output: \n
 # output: report(0xffff7fff);\n
 # output: report(0xffff0000);\n
 # output: report(0x80010000);\n
 # output: report(0x00000001);\n
 # output: report(0x00000000);\n
-# output: report(0x00000000);\n
+# output: report(0x00000001);\n
 # output: \n
 # output: exit(0)\n
 
@@ -375,21 +375,19 @@ start_tests:
 	   set the overflow, but not the carry flag .  */
 	TEST_INST_I32_I32 l.mul, 0x00008000, 0x00010000
 
-	/* Multiply two large positive numbers.  This should set both the
-	   carry and overflow flags (even though the result is not a
-	   negative number.  */
+	/* Multiply two large positive numbers.  This should set the
+	   overflow flags (even though the result is not a negative
+	   number.  */
 	TEST_INST_I32_I32 l.mul, 0x00010000, 0x00010000
 
-	/* Multiply two small negative numbers.  This will set the carry
-	   flag, but not the overflow flag.  */
+	/* Multiply two small negative numbers.  This will set no flags.  */
 	TEST_INST_I32_I32 l.mul, 0xfffffffe, 0xfffffffd
 
-	/* Multiply two quite large negative numbers.  This will set the
-	   carry flag, but not the overflow flag.  */
+	/* Multiply two quite large negative numbers.  This will no flags.  */
 	TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0002
 
 	/* Multiply two slightly too large negative numbers.  This should
-	   set both the overflow, and the carry flags  */
+	   set the overflow flag.  */
 	TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0000
 
 	/* Multiply two large negative numbers.  This should set the
@@ -398,18 +396,15 @@ start_tests:
 	TEST_INST_I32_I32 l.mul, 0xffff0000, 0xfffeffff
 
 	/* Multiply one small negative number and one small positive
-	   number.  This will set the carry flag, but not the overflow
-	   flag.  */
+	   number.  This will set the no flags.  */
 	TEST_INST_I32_I32 l.mul, 0x00000002, 0xfffffffd
 
 	/* Multiply one quite large negative number and one quite large
-	   positive number.  This will set the carry, but not the
-	   overflow flag.  */
+	   positive number.  This will set no flags.  */
 	TEST_INST_I32_I32 l.mul, 0xffff8000, 0x00010000
 
 	/* Multiply one slightly too large negative number and one slightly
-	   too large positive number.  This should set both the carry and
-	   overflow flags.  */
+	   too large positive number.  This should set the overflow flag.  */
 	TEST_INST_I32_I32 l.mul, 0xffff7fff, 0x00010000
 
 	/* Multiply the largest negative number by positive unity.  This
@@ -423,10 +418,11 @@ start_tests:
 	/* Check that an overflow alone causes a RANGE Exception.  */
 	TEST_INST_I32_I32 l.mul, 0x00008000, 0x00010000
 
-	/* Check that a carry alone does not cause a RANGE Exception.  */
+	/* Check multiply of a negative and positive does not cause a RANGE
+	   Exception.  */
 	TEST_INST_I32_I32 l.mul, 0x00000002, 0xfffffffd
 
-	/* Check that carry and overflow together cause an exception.  */
+	/* Check that negative overflow causes a RANGE exception.  */
 	TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0000
 
 	CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
@@ -445,41 +441,35 @@ start_tests:
 	   set the overflow, but not the carry flag.  */
 	TEST_INST_I32_I16 l.muli, 0x00020000, 0x4000
 
-	/* Multiply two large positive numbers.  This should set both the
-	   carry and overflow flags (even though the result is not a
-	   negative number.  */
+	/* Multiply two large positive numbers.  This should set the
+	   overflow flag, even though the result is not a negative number.  */
 	TEST_INST_I32_I16 l.muli, 0x00040000, 0x4000
 
-	/* Multiply two small negative numbers.  This should set the
-	   carry flag, but not the overflow flag.  */
+	/* Multiply two small negative numbers.  This should set no flags.  */
 	TEST_INST_I32_I16 l.muli, 0xfffffffe, 0xfffd
 
-	/* Multiply two quite large negative numbers.  This will set the
-	   carry, but not the overflow flag.  */
+	/* Multiply two quite large negative numbers.  This will set no
+	   flags.  */
 	TEST_INST_I32_I16 l.muli, 0xfffefffe, 0x8001
 
 	/* Multiply two slightly too large negative numbers.  This should
-	   set both the overflow, and the carry flags  */
+	   set the overflow flag.  */
 	TEST_INST_I32_I16 l.muli, 0xfffe0000, 0xbfff
 
-	/* Multiply two large negative numbers.  This should set the both
-	   the carry and overflow flags (even though the result is a
-	   positive number.  */
+	/* Multiply two large negative numbers.  This should set the
+	   overflow flag, even though the result is a positive number.  */
 	TEST_INST_I32_I16 l.muli, 0xfffdfffe, 0x8000
 
 	/* Multiply one small negative number and one small positive
-	   number.  This will set the carry flag, but not the overflow
-	   flag.  */
+	   number.  This will set no flags.  */
 	TEST_INST_I32_I16 l.muli, 0x00000002, 0xfffd
 
 	/* Multiply one quite large negative number and one quite large
-	   positive number.  This will set the carry flag, but not the
-	   overflow flag.  */
+	   positive number.  This will set no flags.  */
 	TEST_INST_I32_I16 l.muli, 0x00010000, 0x8000
 
 	/* Multiply one slightly too large negative number and one slightly
-	   too large positive number.  This should set both the carry and
-	   overflow flags.  */
+	   too large positive number.  This will set the overflow flag.  */
 	TEST_INST_I32_I16 l.muli, 0xfffdfffc, 0x4000
 
 	/* Multiply the largest negative number by positive unity.  Should
@@ -493,10 +483,11 @@ start_tests:
 	/* Check that an overflow alone causes a RANGE Exception.  */
 	TEST_INST_I32_I16 l.muli, 0x00020000, 0x4000
 
-	/* Check that a carry alone does not cause a RANGE Exception.  */
+	/* Check that two negatives will not cause a RANGE Exception.  */
 	TEST_INST_I32_I16 l.muli, 0xfffffffe, 0xfffd
 
-	/* Check that carry and overflow together cause an exception.  */
+	/* Check that multiply of larget negative and positive numbers causes
+	   a RANGE exception and overflow.  */
 	TEST_INST_I32_I16 l.muli, 0xfffdfffe, 0x8000
 
 	CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
@@ -561,11 +552,11 @@ start_tests:
 	   does not cause a RANGE Exception.  */
 	TEST_INST_I32_I32 l.mulu, 0x00008000, 0x00010000
 
-	/* Check that a carry alone does not cause a RANGE Exception.  */
+	/* Check that a carry causes a RANGE Exception.  */
 	TEST_INST_I32_I32 l.mulu, 0x00000002, 0xfffffffd
 
 	/* Check that what would cause an overflow and carry in 2's
-	   complement does not cause a RANGE Exception.  */
+	   complement causes a RANGE Exception.  */
 	TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0xffff0000
 
 	CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3
-- 
2.17.1

