From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Jun 2019 06:32:19 +0900
Subject: [OpenRISC] [PATCH v3 03/11] cpu/or1k: Document no branch delay slot
 architectures and l.adrp
In-Reply-To: <20190608213225.3230-1-shorne@gmail.com>
References: <20190608213225.3230-1-shorne@gmail.com>
Message-ID: <20190608213225.3230-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The 'nd' architectures did not mention what the 'nd' stands for.
Document that these mean 'no brach delay slot'.

cpu/ChangeLog:

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

	* or1k.cpu (or64nd, or32nd, or1200nd): Update comment.a
	(l-adrp): Improve comment.
---
 cpu/or1k.cpu      | 6 +++---
 cpu/or1korbis.cpu | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cpu/or1k.cpu b/cpu/or1k.cpu
index e1ae1b8c88..b796862d1b 100644
--- a/cpu/or1k.cpu
+++ b/cpu/or1k.cpu
@@ -77,7 +77,7 @@
 
       (define-mach
         (name or32nd)
-        (comment "Generic OpenRISC 1000 32-bit CPU")
+        (comment "Generic OpenRISC 1000 32-bit CPU with no branch delay slot")
         (cpu or1k32bf)
         (bfd-name "or1knd")
         )
@@ -92,7 +92,7 @@
 
       ; OpenRISC 1200 - 32-bit or1k CPU implementation
       (define-model
-        (name or1200nd) (comment "OpenRISC 1200 model")
+        (name or1200nd) (comment "OpenRISC 1200 model with no branch delay slot")
         (attrs NO-DELAY-SLOT)
         (mach or32nd)
         (unit u-exec "Execution Unit" () 1 1 () () () ())
@@ -120,7 +120,7 @@
 
       (define-mach
         (name or64nd)
-        (comment "Generic OpenRISC 1000 ND 64-bit CPU")
+        (comment "Generic OpenRISC 1000 ND 64-bit CPU with no branch delay slot")
         (cpu or1k64bf)
         (bfd-name "or1k64nd")
         )
diff --git a/cpu/or1korbis.cpu b/cpu/or1korbis.cpu
index 308f37861d..3741d4c8f7 100644
--- a/cpu/or1korbis.cpu
+++ b/cpu/or1korbis.cpu
@@ -433,7 +433,7 @@
            )
   )
 
-(dni l-adrp "adrp reg/disp21"
+(dni l-adrp "load pc-relative page address"
     ((MACH ORBIS-MACHS))
     "l.adrp $rD,${disp21}"
     (+ OPC_ADRP rD disp21)
-- 
2.21.0

