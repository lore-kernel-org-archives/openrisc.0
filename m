From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:03:00 +0100
Subject: [OpenRISC] [PATCH 13/17] arch/*: Purge references to
	CONFIG_RD_BZIP2/LZMA from various defconfigs
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
Message-ID: <20181109190304.8573-13-kilobyte@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

They don't exist anymore.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/arm/configs/aspeed_g4_defconfig       | 1 -
 arch/arm/configs/aspeed_g5_defconfig       | 1 -
 arch/arm/configs/clps711x_defconfig        | 1 -
 arch/arm/configs/ezx_defconfig             | 2 --
 arch/arm/configs/hisi_defconfig            | 1 -
 arch/arm/configs/imote2_defconfig          | 2 --
 arch/arm/configs/lpc18xx_defconfig         | 2 --
 arch/arm/configs/vf610m4_defconfig         | 2 --
 arch/m68k/configs/stmark2_defconfig        | 2 --
 arch/mips/configs/ar7_defconfig            | 1 -
 arch/mips/configs/ath25_defconfig          | 1 -
 arch/mips/configs/ath79_defconfig          | 1 -
 arch/mips/configs/lemote2f_defconfig       | 2 --
 arch/mips/configs/loongson3_defconfig      | 2 --
 arch/mips/configs/nlm_xlp_defconfig        | 2 --
 arch/mips/configs/nlm_xlr_defconfig        | 2 --
 arch/mips/configs/pistachio_defconfig      | 2 --
 arch/openrisc/configs/simple_smp_defconfig | 2 --
 arch/powerpc/configs/44x/fsp2_defconfig    | 1 -
 arch/powerpc/configs/skiroot_defconfig     | 2 --
 arch/sh/configs/sdk7786_defconfig          | 2 --
 arch/xtensa/configs/cadence_csp_defconfig  | 2 --
 arch/xtensa/configs/nommu_kc705_defconfig  | 2 --
 23 files changed, 38 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 1446262921b4..2e978ba5fab3 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -8,7 +8,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 # CONFIG_UID16 is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 02fa3a41add5..4fef8a5d208a 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -8,7 +8,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 # CONFIG_UID16 is not set
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index fc105c9178cc..63e029d9c5a6 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -2,7 +2,6 @@ CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_LZMA=y
 CONFIG_EMBEDDED=y
 CONFIG_SLOB=y
 CONFIG_JUMP_LABEL=y
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index 484e51fbd4a6..47bbd7b20f07 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -4,8 +4,6 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 74d611e41e02..c8660e175f15 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -1,7 +1,6 @@
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_LZMA=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index f204017c26b9..5cd017270f1e 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -3,8 +3,6 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 23df2518203d..f0d36814111a 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -1,8 +1,6 @@
 CONFIG_CROSS_COMPILE="arm-linux-gnueabihf-"
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index a89f035c3b01..6b34e135035b 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -1,7 +1,5 @@
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_KALLSYMS_ALL=y
diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index 3d07b1de7eb0..fe82d37ba81d 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -5,8 +5,6 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
index 5651f4d8f45c..a0ce69fb4fcb 100644
--- a/arch/mips/configs/ar7_defconfig
+++ b/arch/mips/configs/ar7_defconfig
@@ -12,7 +12,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_LZMA=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_ELF_CORE is not set
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index b8d48038e74f..1a83f91dad42 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -9,7 +9,6 @@ CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 951c4231bdb8..c11f1870ed6f 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -12,7 +12,6 @@ CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
-CONFIG_RD_LZMA=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 02be95c1b712..2e2561f1aec3 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -17,8 +17,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 324dfee23dfb..42eae3436bb4 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -32,8 +32,6 @@ CONFIG_SCHED_AUTOGROUP=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_MODULES=y
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index e8e1dd8e0e99..16e44d0f1d29 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -21,8 +21,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index c4477a4d40c1..9340f42184f7 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -22,8 +22,6 @@ CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_INITRAMFS_COMPRESSION_GZIP=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
index b22a3cf149b6..4257f90d1272 100644
--- a/arch/mips/configs/pistachio_defconfig
+++ b/arch/mips/configs/pistachio_defconfig
@@ -21,8 +21,6 @@ CONFIG_CFS_BANDWIDTH=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index b6e3c7e158e7..03b7633a9a2b 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -4,8 +4,6 @@ CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index bae6b26bcfba..8ccae1052efb 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -9,7 +9,6 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index cfdd08897a06..5d790a65e733 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -16,8 +16,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=20
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index e9ee0c878ead..4e71a98bc814 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -29,8 +29,6 @@ CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_BZIP2=y
-CONFIG_RD_LZMA=y
 CONFIG_RD_LZO=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 3221b7053fa3..e7b295ec6acd 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -15,8 +15,6 @@ CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index f3fc4f970ca8..9a449d13eb1e 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -15,8 +15,6 @@ CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
-- 
2.19.1

