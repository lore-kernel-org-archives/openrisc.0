From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:02:55 +0100
Subject: [OpenRISC] [PATCH 08/17] sh: Remove support for BZIP2 and LZMA
	compressed kernel
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
Message-ID: <20181109190304.8573-8-kilobyte@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Made redundant by newer choices.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/sh/Kconfig                  |  2 --
 arch/sh/Makefile                 |  4 +---
 arch/sh/boot/Makefile            | 19 ++-----------------
 arch/sh/boot/compressed/Makefile |  5 -----
 arch/sh/boot/compressed/misc.c   | 12 ------------
 5 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f82a4da7adf3..fbb2e17275d1 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -23,8 +23,6 @@ config SUPERH
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_KERNEL_GZIP
 	select CPU_NO_EFFICIENT_FFS
-	select HAVE_KERNEL_BZIP2
-	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_LZO
 	select HAVE_UID16
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index c521ade2557c..70925d0cd2a8 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -209,7 +209,7 @@ endif
 libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/	$(libs-y)
 libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
 
-BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.xz uImage.lzo \
+BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.xz uImage.lzo \
 	       uImage.srec uImage.bin zImage vmlinux.bin vmlinux.srec \
 	       romImage
 PHONY += $(BOOT_TARGETS)
@@ -237,8 +237,6 @@ define archhelp
 	@echo '  uImage.srec	           - Create an S-record for U-Boot'
 	@echo '  uImage.bin	           - Kernel-only image for U-Boot (bin)'
 	@echo '* uImage.gz	           - Kernel-only image for U-Boot (gzip)'
-	@echo '  uImage.bz2	           - Kernel-only image for U-Boot (bzip2)'
-	@echo '  uImage.lzma	           - Kernel-only image for U-Boot (lzma)'
 	@echo '  uImage.xz	           - Kernel-only image for U-Boot (xz)'
 	@echo '  uImage.lzo	           - Kernel-only image for U-Boot (lzo)'
 endef
diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 58592dfa5cb6..bf8cf598a5ab 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -21,15 +21,12 @@ CONFIG_PHYSICAL_START	?= $(CONFIG_MEMORY_START)
 
 suffix-y := bin
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
-suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
-suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
 suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO)	:= lzo
 
 targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
-	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin
-extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
-	   vmlinux.bin.xz vmlinux.bin.lzo
+	   uImage.xz uImage.lzo uImage.bin
+extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.xz vmlinux.bin.lzo
 subdir- := compressed romimage
 
 $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
@@ -68,27 +65,15 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,bzip2)
-
-$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,lzma)
-
 $(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,xzkern)
 
 $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo)
 
-$(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2
-	$(call if_changed,uimage,bzip2)
-
 $(obj)/uImage.gz: $(obj)/vmlinux.bin.gz
 	$(call if_changed,uimage,gzip)
 
-$(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma
-	$(call if_changed,uimage,lzma)
-
 $(obj)/uImage.xz: $(obj)/vmlinux.bin.xz
 	$(call if_changed,uimage,xz)
 
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index f5e1bd779789..abd33fd0d525 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -6,7 +6,6 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz \
-		   vmlinux.bin.bz2 vmlinux.bin.lzma \
 		   vmlinux.bin.xz vmlinux.bin.lzo \
 		   head_$(BITS).o misc.o piggy.o
 
@@ -64,10 +63,6 @@ vmlinux.bin.all-y := $(obj)/vmlinux.bin
 
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzma)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,xzkern)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index c15cac9251b9..c82402add51e 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -44,24 +44,12 @@ extern int _end;
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
 
-#ifdef CONFIG_HAVE_KERNEL_BZIP2
-#define HEAP_SIZE	0x400000
-#else
 #define HEAP_SIZE	0x10000
-#endif
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
-#include "../../../../lib/decompress_bunzip2.c"
-#endif
-
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 #ifdef CONFIG_KERNEL_XZ
 #include "../../../../lib/decompress_unxz.c"
 #endif
-- 
2.19.1

