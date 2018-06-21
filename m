From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Jun 2018 20:50:29 +0200
Subject: [OpenRISC] [PATCH] openrisc: Fix broken paths to arch/or32
Message-ID: <20180621185029.16773-1-geert@linux-m68k.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

OpenRISC was mainlined as "openrisc", not "or32".
vmlinux.lds is generated from vmlinux.lds.S.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/openrisc/kernel/entry.S | 2 +-
 arch/openrisc/kernel/head.S  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index d5d213cca9bb0d7a..b1085aedaa9175cc 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -240,7 +240,7 @@ handler:							;\
  *	 occured. in fact they never do. if you need them use
  *	 values saved on stack (for SPR_EPC, SPR_ESR) or content
  *       of r4 (for SPR_EEAR). for details look at EXCEPTION_HANDLE()
- *       in 'arch/or32/kernel/head.S'
+ *       in 'arch/openrisc/kernel/head.S'
  */
 
 /* =====================================================[ exceptions] === */
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index fb02b2a1d6f2d875..2cbaef752dfe1625 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1725,7 +1725,7 @@ _string_nl:
 
 /*
  * .data section should be page aligned
- *	(look into arch/or32/kernel/vmlinux.lds)
+ *	(look into arch/openrisc/kernel/vmlinux.lds.S)
  */
 	.section .data,"aw"
 	.align	8192
-- 
2.17.1

