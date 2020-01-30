From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 30 Jan 2020 19:19:56 -0000
Subject: [OpenRISC] [PATCH] openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
Message-ID: <20200130191938.2444-1-krzk@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/openrisc/configs/or1ksim_defconfig    | 1 -
 arch/openrisc/configs/simple_smp_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index d8ff4f8ffb88..75f2da324d0e 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="or1k-linux-"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 64278992df9c..ff49d868e040 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="or1k-linux-"
 CONFIG_LOCALVERSION="-simple-smp"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
-- 
2.17.1

