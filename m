From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Aug 2021 22:59:46 +0930
Subject: [OpenRISC] [PATCH 3/3] openrisc/litex: Update defconfig
In-Reply-To: <20210826132946.3324593-1-joel@jms.id.au>
References: <20210826132946.3324593-1-joel@jms.id.au>
Message-ID: <20210826132946.3324593-4-joel@jms.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add the liteeth network device and basic network options, and update the
options by doing a savedefconfig.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/openrisc/configs/or1klitex_defconfig | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index 3c2c70d3d740..d695879a4d26 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -1,18 +1,24 @@
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_EMBEDDED=y
+CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
 CONFIG_HZ_100=y
-CONFIG_INITRAMFS_SOURCE="openrisc-rootfs.cpio.gz"
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_OF_OVERLAY=y
-CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
-CONFIG_PANIC_ON_OOPS=y
-CONFIG_PRINTK_TIME=y
-CONFIG_LITEX_SOC_CONTROLLER=y
+CONFIG_NETDEVICES=y
+CONFIG_LITEX_LITEETH=y
 CONFIG_SERIAL_LITEUART=y
 CONFIG_SERIAL_LITEUART_CONSOLE=y
-CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_TTY_PRINTK=y
+CONFIG_LITEX_SOC_CONTROLLER=y
+CONFIG_TMPFS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BUG_ON_DATA_CORRUPTION=y
-- 
2.33.0

