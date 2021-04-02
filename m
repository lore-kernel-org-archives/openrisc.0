From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:18 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 16/20] sparc: Convert to GENERIC_CMDLINE
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <37fc5bd333125270f7032b8f9be225297e6dbe4f.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/sparc/Kconfig           | 18 +-----------------
 arch/sparc/prom/bootstr_64.c |  2 +-
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..2a197f3a2549 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -50,6 +50,7 @@ config SPARC
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select SET_FS
+	select GENERIC_CMDLINE if SPARC64
 
 config SPARC32
 	def_bool !64BIT
@@ -313,23 +314,6 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-	depends on SPARC64
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 root=/dev/sda1"
-	help
-	  Say Y here if you want to be able to pass default arguments to
-	  the kernel. This will be overridden by the bootloader, if you
-	  use one (such as SILO). This is most useful if you want to boot
-	  a kernel from TFTP, and want default options to be available
-	  with having them passed on the command line.
-
-	  NOTE: This option WILL override the PROM bootargs setting!
-
 config SUN_PM
 	bool
 	default y if SPARC32
diff --git a/arch/sparc/prom/bootstr_64.c b/arch/sparc/prom/bootstr_64.c
index f1cc34d99eec..4853a45b3de9 100644
--- a/arch/sparc/prom/bootstr_64.c
+++ b/arch/sparc/prom/bootstr_64.c
@@ -25,7 +25,7 @@ struct {
 	char bootstr_buf[BARG_LEN];
 } bootstr_info = {
 	.bootstr_len = BARG_LEN,
-#ifdef CONFIG_CMDLINE
+#if CONFIG_CMDLINE != ""
 	.bootstr_valid = 1,
 	.bootstr_buf = CONFIG_CMDLINE,
 #endif
-- 
2.25.0

