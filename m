From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:02:59 +0100
Subject: [OpenRISC] [PATCH 12/17] Kconfig: Remove support for
	LZMA-compressed initrd
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
Message-ID: <20181109190304.8573-12-kilobyte@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Obsoleted by XZ.

The config option for compressing the kernel stays, as some archs have a
bootloader outside the kernel that wants LZMA.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 Makefile    |  1 -
 usr/Kconfig | 28 ++--------------------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index c812467bfe11..97e4bf26a6d3 100644
--- a/Makefile
+++ b/Makefile
@@ -938,7 +938,6 @@ export mod_compress_cmd
 # This shall be used by the dracut(8) tool while creating an initramfs image.
 #
 INITRD_COMPRESS-y                  := gzip
-INITRD_COMPRESS-$(CONFIG_RD_LZMA)  := lzma
 INITRD_COMPRESS-$(CONFIG_RD_XZ)    := xz
 INITRD_COMPRESS-$(CONFIG_RD_LZO)   := lzo
 INITRD_COMPRESS-$(CONFIG_RD_LZ4)   := lz4
diff --git a/usr/Kconfig b/usr/Kconfig
index 05b6be569041..8d99edacabc9 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -61,15 +61,6 @@ config RD_GZIP
 	  Support loading of a gzip encoded initial ramdisk or cpio buffer.
 	  If unsure, say Y.
 
-config RD_LZMA
-	bool "Support initial ramdisk/ramfs compressed using LZMA"
-	default y
-	depends on BLK_DEV_INITRD
-	select DECOMPRESS_LZMA
-	help
-	  Support loading of a LZMA encoded initial ramdisk or cpio buffer
-	  If unsure, say N.
-
 config RD_XZ
 	bool "Support initial ramdisk/ramfs compressed using XZ"
 	depends on BLK_DEV_INITRD
@@ -118,8 +109,8 @@ choice
 	  when building a kernel.  Decompression speed is relevant at
 	  each boot. Also the memory usage during decompression may become
 	  relevant on memory constrained systems. This is usually based on the
-	  dictionary size of the algorithm with algorithms like XZ and LZMA
-	  featuring large dictionary sizes.
+	  dictionary size of the algorithm with algorithms like XZ featuring
+	  large dictionary sizes.
 
 	  High compression options are mostly useful for users who are
 	  low on RAM, since it reduces the memory consumption during
@@ -152,19 +143,6 @@ config INITRAMFS_COMPRESSION_GZIP
 	  supported by your build system as the gzip tool is present by default
 	  on most distros.
 
-config INITRAMFS_COMPRESSION_LZMA
-	bool "LZMA"
-	depends on RD_LZMA
-	help
-	  This algorithm's compression ratio is best but has a large dictionary
-	  size which might cause issues in memory constrained systems.
-	  Decompression speed is between the other choices. Compression is
-	  slowest. The initramfs size is about 33% smaller with LZMA in
-	  comparison to gzip.
-
-	  If you choose this, keep in mind that you may need to install the xz
-	  or lzma tools to be able to compress the initram.
-
 config INITRAMFS_COMPRESSION_XZ
 	bool "XZ"
 	depends on RD_XZ
@@ -219,7 +197,6 @@ config INITRAMFS_COMPRESSION
 	string
 	default ""      if INITRAMFS_COMPRESSION_NONE
 	default ".gz"   if INITRAMFS_COMPRESSION_GZIP
-	default ".lzma" if INITRAMFS_COMPRESSION_LZMA
 	default ".xz"   if INITRAMFS_COMPRESSION_XZ
 	default ".lzo"  if INITRAMFS_COMPRESSION_LZO
 	default ".lz4"  if INITRAMFS_COMPRESSION_LZ4
@@ -228,6 +205,5 @@ config INITRAMFS_COMPRESSION
 	default ".lz4"  if RD_LZ4
 	default ".lzo"  if RD_LZO
 	default ".xz"   if RD_XZ
-	default ".lzma" if RD_LZMA
 	default ".zst"  if RD_ZSTD
 	default ""
-- 
2.19.1

