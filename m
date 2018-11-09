From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:02:56 +0100
Subject: [OpenRISC] [PATCH 09/17] unicore32: Remove support for BZIP2 and
	LZMA compressed kernel
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
Message-ID: <20181109190304.8573-9-kilobyte@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Made redundant by newer choices -- sort of, as no one enabled support
for XZ nor ZSTD for unicore yet...

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/unicore32/Kconfig                  | 2 --
 arch/unicore32/boot/compressed/Makefile | 4 +---
 arch/unicore32/boot/compressed/misc.c   | 8 --------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index a4c05159dca5..b7eb7e9fb0d2 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -7,10 +7,8 @@ config UNICORE32
 	select DMA_DIRECT_OPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_BZIP2
 	select GENERIC_ATOMIC64
 	select HAVE_KERNEL_LZO
-	select HAVE_KERNEL_LZMA
 	select VIRT_TO_BUS
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/unicore32/boot/compressed/Makefile b/arch/unicore32/boot/compressed/Makefile
index 9aecdd3ddc48..79ff908ad78c 100644
--- a/arch/unicore32/boot/compressed/Makefile
+++ b/arch/unicore32/boot/compressed/Makefile
@@ -22,9 +22,7 @@ $(obj)/font.c: $(srctree)/lib/fonts/font_8x8.c
 
 # piggy.S and piggy.o
 suffix_$(CONFIG_KERNEL_GZIP)	:= gzip
-suffix_$(CONFIG_KERNEL_BZIP2)	:= bz2
 suffix_$(CONFIG_KERNEL_LZO)	:= lzo
-suffix_$(CONFIG_KERNEL_LZMA)	:= lzma
 
 $(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
 	$(call if_changed,$(suffix_y))
@@ -39,7 +37,7 @@ targets		:= vmlinux vmlinux.lds font.o font.c head.o misc.o \
 			piggy.$(suffix_y) piggy.o piggy.S \
 
 # Make sure files are removed during clean
-extra-y		+= piggy.gzip piggy.bz2 piggy.lzo piggy.lzma
+extra-y		+= piggy.gzip piggy.lzo
 
 # ?
 LDFLAGS_vmlinux += -p
diff --git a/arch/unicore32/boot/compressed/misc.c b/arch/unicore32/boot/compressed/misc.c
index 5c65dfee278c..ab9b56cf6907 100644
--- a/arch/unicore32/boot/compressed/misc.c
+++ b/arch/unicore32/boot/compressed/misc.c
@@ -91,18 +91,10 @@ void error(char *x)
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
-#include "../../../../lib/decompress_bunzip2.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZO
 #include "../../../../lib/decompress_unlzo.c"
 #endif
 
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 unsigned long decompress_kernel(unsigned long output_start,
 		unsigned long free_mem_ptr_p,
 		unsigned long free_mem_ptr_end_p)
-- 
2.19.1

