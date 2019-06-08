From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Jun 2019 06:32:18 +0900
Subject: [OpenRISC] [PATCH v3 02/11] cpu/or1k: Define unordered comparisons
In-Reply-To: <20190608213225.3230-1-shorne@gmail.com>
References: <20190608213225.3230-1-shorne@gmail.com>
Message-ID: <20190608213225.3230-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add support for new floating point unordered comparisons.  These have been
defined in OpenRISC architecture proposal 7[0] and are now included in the
architecture specification 1.3.

These new instructions provide the ability for floating point comparisons to
detect NaNs.

[0] https://openrisc.io/proposals/lfsf

cpu/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* or1korfpx.cpu (insn-opcode-float-regreg): Add SFUEQ_S, SFUNE_S,
	SFUGT_S, SFUGE_S, SFULT_S, SFULE_S, SFUN_S, SFUEQ_D, SFUNE_D, SFUGT_D,
	SFUGE_D, SFULT_D, SFULE_D, SFUN_D opcodes.
	(float-setflag-insn-base): New pmacro based on float-setflag-insn.
	(float-setflag-symantics, float-setflag-unordered-cmp-symantics,
	float-setflag-unordered-symantics): New pmacro for instruction
	symantics.
	(float-setflag-insn): Update to use float-setflag-insn-base.
	(float-setflag-unordered-insn): New pmacro for generating instructions.
---
 cpu/or1korfpx.cpu | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/cpu/or1korfpx.cpu b/cpu/or1korfpx.cpu
index eb01f1ca66..5e33b82a44 100644
--- a/cpu/or1korfpx.cpu
+++ b/cpu/or1korfpx.cpu
@@ -54,6 +54,20 @@
    ("SFGE_D" #x1b)
    ("SFLT_D" #x1c)
    ("SFLE_D" #x1d)
+   ("SFUEQ_S" #x28)
+   ("SFUNE_S" #x29)
+   ("SFUGT_S" #x2a)
+   ("SFUGE_S" #x2b)
+   ("SFULT_S" #x2c)
+   ("SFULE_S" #x2d)
+   ("SFUN_S" #x2e)
+   ("SFUEQ_D" #x38)
+   ("SFUNE_D" #x39)
+   ("SFUGT_D" #x3a)
+   ("SFUGE_D" #x3b)
+   ("SFULT_D" #x3c)
+   ("SFULE_D" #x3d)
+   ("SFUN_D" #x3e)
    ("CUST1_S" #xd0)
    ("CUST1_D" #xe0)
    )
@@ -252,14 +266,14 @@
      ()
      )
 
-(define-pmacro (float-setflag-insn mnemonic)
+(define-pmacro (float-setflag-insn-base mnemonic rtx-mnemonic symantics)
   (begin
     (dni (.sym lf- mnemonic -s)
          (.str "lf.sf" mnemonic ".s reg/reg")
          ((MACH ORFPX32-MACHS))
          (.str "lf.sf" mnemonic ".s $rASF,$rBSF")
          (+ OPC_FLOAT (f-r1 0) rASF rBSF (f-resv-10-3 0) (.sym OPC_FLOAT_REGREG_SF (.upcase mnemonic) _S))
-         (set BI sys-sr-f (mnemonic SF rASF rBSF))
+         (symantics rtx-mnemonic SF rASF rBSF)
          ()
          )
     (dni (.sym lf- mnemonic -d)
@@ -267,7 +281,7 @@
          ((MACH ORFPX64-MACHS))
          (.str "lf.sf" mnemonic ".d $rADF,$rBDF")
          (+ OPC_FLOAT (f-r1 0) rADF rBDF (f-resv-10-3 0) (.sym OPC_FLOAT_REGREG_SF (.upcase mnemonic) _D))
-         (set BI sys-sr-f (mnemonic DF rADF rBDF))
+         (symantics rtx-mnemonic DF rADF rBDF)
          ()
          )
     (dni (.sym lf- mnemonic -d32)
@@ -275,18 +289,43 @@
          ((MACH ORFPX64A32-MACHS))
          (.str "lf.sf" mnemonic ".d $rAD32F,$rBD32F")
          (+ OPC_FLOAT (f-r1 0) rAD32F rBD32F (f-resv-10-1 0) (.sym OPC_FLOAT_REGREG_SF (.upcase mnemonic) _D))
-         (set BI sys-sr-f (mnemonic DF rAD32F rBD32F))
+         (symantics rtx-mnemonic DF rAD32F rBD32F)
          ()
          )
     )
   )
 
+(define-pmacro (float-setflag-symantics mnemonic mode r1 r2)
+  (set BI sys-sr-f (mnemonic mode r1 r2)))
+
+(define-pmacro (float-setflag-insn mnemonic)
+  (float-setflag-insn-base mnemonic mnemonic float-setflag-symantics))
+
+(define-pmacro (float-setflag-unordered-cmp-symantics mnemonic mode r1 r2)
+  (set BI sys-sr-f (or (unordered mode r1 r2)
+                       (mnemonic mode r1 r2))))
+
+(define-pmacro (float-setflag-unordered-symantics mnemonic mode r1 r2)
+  (set BI sys-sr-f (unordered mode r1 r2)))
+
+(define-pmacro (float-setflag-unordered-insn mnemonic)
+  (float-setflag-insn-base (.str "u" mnemonic)
+                           mnemonic
+                           float-setflag-unordered-cmp-symantics))
+
 (float-setflag-insn eq)
 (float-setflag-insn ne)
 (float-setflag-insn ge)
 (float-setflag-insn gt)
 (float-setflag-insn lt)
 (float-setflag-insn le)
+(float-setflag-unordered-insn eq)
+(float-setflag-unordered-insn ne)
+(float-setflag-unordered-insn gt)
+(float-setflag-unordered-insn ge)
+(float-setflag-unordered-insn lt)
+(float-setflag-unordered-insn le)
+(float-setflag-insn-base un () float-setflag-unordered-symantics)
 
 (dni lf-madd-s
      "lf.madd.s reg/reg/reg"
-- 
2.21.0

