From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 21:52:53 +0900
Subject: [OpenRISC] [PATCH v6 4/5] gdb: testsuite: Add or1k tdesc-regs.exp
	test support
In-Reply-To: <cover.1493038197.git.shorne@gmail.com>
References: <cover.1493038197.git.shorne@gmail.com>
Message-ID: <e81976c7a05ff46ad7016e4b150e8285895e80c8.1493038197.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

gdb/testsuite/ChangeLog:

2017-04-20  Stafford Horne  <shorne@gmail.com>

	* gdb.xml/tdesc-regs.exp: Add or1k support.
---
 gdb/testsuite/gdb.xml/tdesc-regs.exp | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gdb/testsuite/gdb.xml/tdesc-regs.exp b/gdb/testsuite/gdb.xml/tdesc-regs.exp
index 70fc0e0..d62ed98 100644
--- a/gdb/testsuite/gdb.xml/tdesc-regs.exp
+++ b/gdb/testsuite/gdb.xml/tdesc-regs.exp
@@ -50,6 +50,9 @@ switch -glob -- [istarget] {
     "nios2-*-*" {
 	set core-regs {nios2-cpu.xml}
     }
+    "or1k-*-*" {
+	set core-regs {or1k-core.xml}
+    }
     "powerpc*-*-*" {
 	set regdir "rs6000/"
 	set core-regs {power-core.xml}
-- 
2.9.3

