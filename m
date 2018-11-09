From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:02:57 +0100
Subject: [OpenRISC] [PATCH 10/17] arm: Remove support for LZMA compressed
	kernel
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
Message-ID: <20181109190304.8573-10-kilobyte@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

You want XZ instead: newer version of same algorithm, has an optimized
filter for arm32 executables, uses a library shared with other uses of XZ
in the kernel.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/arm/Kconfig                      | 1 -
 arch/arm/boot/compressed/Makefile     | 1 -
 arch/arm/boot/compressed/decompress.c | 4 ----
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..637e100de6e3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -77,7 +77,6 @@ config ARM
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 1f5a5ffe7fcf..37e6097b7506 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -72,7 +72,6 @@ CPPFLAGS_vmlinux.lds := -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)"
 
 compress-$(CONFIG_KERNEL_GZIP) = gzip
 compress-$(CONFIG_KERNEL_LZO)  = lzo
-compress-$(CONFIG_KERNEL_LZMA) = lzma
 compress-$(CONFIG_KERNEL_XZ)   = xzkern
 compress-$(CONFIG_KERNEL_LZ4)  = lz4
 
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index c16c1829a5e4..350e7a96f6af 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -41,10 +41,6 @@ extern int memcmp(const void *cs, const void *ct, size_t count);
 #include "../../../../lib/decompress_unlzo.c"
 #endif
 
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 #ifdef CONFIG_KERNEL_XZ
 #define memmove memmove
 #define memcpy memcpy
-- 
2.19.1

