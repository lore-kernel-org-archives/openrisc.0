From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri,  2 Apr 2021 15:18:15 +0000 (UTC)
Subject: [OpenRISC] [PATCH v4 13/20] openrisc: Convert to GENERIC_CMDLINE
In-Reply-To: <cover.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <c3d52a6e1423d9d27c59ad7ab945929b09f74866.1617375802.git.christophe.leroy@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This converts the architecture to GENERIC_CMDLINE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/openrisc/Kconfig | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 591acc5990dc..ca1d0f18fe16 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -25,6 +25,7 @@ config OPENRISC
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select GENERIC_CMDLINE
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
@@ -162,15 +163,6 @@ config OPENRISC_HAVE_SHADOW_GPRS
 	  On SMP systems, this feature is mandatory.
 	  On a unicore system it's safe to say N here if you are unsure.
 
-config CMDLINE
-	string "Default kernel command string"
-	default ""
-	help
-	  On some architectures there is currently no way for the boot loader
-	  to pass arguments to the kernel. For these architectures, you should
-	  supply some command-line options at build time by entering them
-	  here.
-
 menu "Debugging options"
 
 config JUMP_UPON_UNHANDLED_EXCEPTION
-- 
2.25.0

