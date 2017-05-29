From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 May 2017 23:56:00 +0900
Subject: [OpenRISC] [PATCH] openrisc: Change toolchain from or32- to or1k-
Message-ID: <20170529145602.15251-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The openrisc toolchain prefix changed a few years ago.  No one
should be using this anylonger. This also saves from people
having to manually update or specify this every build.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/configs/or1ksim_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 42fe530..eb3fc58 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -1,4 +1,4 @@
-CONFIG_CROSS_COMPILE="or32-linux-"
+CONFIG_CROSS_COMPILE="or1k-linux-"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-- 
2.9.4

