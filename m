From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Jun 2019 06:32:20 +0900
Subject: [OpenRISC] [PATCH v3 04/11] cpu/or1k: Update fpu compare symbols to
 imply set flag
In-Reply-To: <20190608213225.3230-1-shorne@gmail.com>
References: <20190608213225.3230-1-shorne@gmail.com>
Message-ID: <20190608213225.3230-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The fpu compare symbols where not including 'sf' in the mnemonic.  So
instead of `lf-sfeq` (implying set flag if operands are equal) we were
having `lf-eq`.   This patch adds the 'sf'.  This helps with making the
generated CGEN documentation consistent and ordered correctly.

cpu/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* or1korfpx.cpu (float-setflag-insn-base): Add 'sf' to symbol.
---
 cpu/or1korfpx.cpu | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu/or1korfpx.cpu b/cpu/or1korfpx.cpu
index 5e33b82a44..f43522f2e6 100644
--- a/cpu/or1korfpx.cpu
+++ b/cpu/or1korfpx.cpu
@@ -268,7 +268,7 @@
 
 (define-pmacro (float-setflag-insn-base mnemonic rtx-mnemonic symantics)
   (begin
-    (dni (.sym lf- mnemonic -s)
+    (dni (.sym lf-sf mnemonic -s)
          (.str "lf.sf" mnemonic ".s reg/reg")
          ((MACH ORFPX32-MACHS))
          (.str "lf.sf" mnemonic ".s $rASF,$rBSF")
@@ -276,7 +276,7 @@
          (symantics rtx-mnemonic SF rASF rBSF)
          ()
          )
-    (dni (.sym lf- mnemonic -d)
+    (dni (.sym lf-sf mnemonic -d)
          (.str "lf.sf" mnemonic ".d reg/reg")
          ((MACH ORFPX64-MACHS))
          (.str "lf.sf" mnemonic ".d $rADF,$rBDF")
@@ -284,7 +284,7 @@
          (symantics rtx-mnemonic DF rADF rBDF)
          ()
          )
-    (dni (.sym lf- mnemonic -d32)
+    (dni (.sym lf-sf mnemonic -d32)
          (.str "lf.sf" mnemonic ".d regpair/regpair")
          ((MACH ORFPX64A32-MACHS))
          (.str "lf.sf" mnemonic ".d $rAD32F,$rBD32F")
-- 
2.21.0

