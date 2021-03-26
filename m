From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 26 Mar 2021 13:45:05 +0000 (UTC)
Subject: [OpenRISC] [PATCH v3 17/17] cmdline: Remove CONFIG_CMDLINE_EXTEND
In-Reply-To: <cover.1616765869.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
Message-ID: <63c9c340da826c14ed0c4f0121e723b16f626bc7.1616765870.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

All architectures providing CONFIG_CMDLINE_EXTEND
are now converted to GENERIC_CMDLINE.

This configuration item is not used anymore, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 init/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index af0d84662cc2..fa002e3765ab 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -163,12 +163,6 @@ config CMDLINE_FORCE
 	  arguments provided by the bootloader.
 endchoice
 
-config CMDLINE_EXTEND
-	bool
-	default CMDLINE_APPEND
-	help
-	  To be removed once all architectures are converted to generic CMDLINE
-
 config COMPILE_TEST
 	bool "Compile also drivers which will not load"
 	depends on HAS_IOMEM
-- 
2.25.0

