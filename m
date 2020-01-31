From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 31 Jan 2020 08:28:44 -0000
Subject: [OpenRISC] [PATCH v2] openrisc: configs: Cleanup
 CONFIG_CROSS_COMPILE
Message-ID: <1580459313-16926-1-git-send-email-krzk@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Update also docs.
---
 Documentation/openrisc/openrisc_port.rst   | 4 ++--
 arch/openrisc/configs/or1ksim_defconfig    | 1 -
 arch/openrisc/configs/simple_smp_defconfig | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
index a18747a8d191..4b2c437942a0 100644
--- a/Documentation/openrisc/openrisc_port.rst
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -37,8 +37,8 @@ or Stafford's toolchain build and release scripts.
 
 Build the Linux kernel as usual::
 
-	make ARCH=openrisc defconfig
-	make ARCH=openrisc
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
 
 3) Running on FPGA (optional)
 
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
2.7.4

