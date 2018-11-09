From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:02:52 +0100
Subject: [OpenRISC] [PATCH 05/17] mips: Remove support for BZIP2 and LZMA
	compressed kernel
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
Message-ID: <20181109190304.8573-5-kilobyte@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Made redundant by newer choices.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/mips/Kconfig                      |  2 --
 arch/mips/boot/Makefile                | 27 --------------------------
 arch/mips/boot/compressed/Makefile     |  2 --
 arch/mips/boot/compressed/decompress.c |  8 --------
 4 files changed, 39 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..8f774bb9d22f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1834,9 +1834,7 @@ endif # CPU_LOONGSON2F
 config SYS_SUPPORTS_ZBOOT
 	bool
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 35704c28a28b..9c5f380a6c20 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -24,9 +24,7 @@ strip-flags   := $(addprefix --remove-section=,$(drop-sections))
 hostprogs-y := elf2ecoff
 
 suffix-y			:= bin
-suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
-suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
 suffix-$(CONFIG_KERNEL_LZO)	:= lzo
 
 targets := vmlinux.ecoff
@@ -54,20 +52,12 @@ UIMAGE_ENTRYADDR = $(VMLINUX_ENTRY_ADDRESS)
 # Compressed vmlinux images
 #
 
-extra-y += vmlinux.bin.bz2
 extra-y += vmlinux.bin.gz
-extra-y += vmlinux.bin.lzma
 extra-y += vmlinux.bin.lzo
 
-$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,bzip2)
-
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
-$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,lzma)
-
 $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo)
 
@@ -77,23 +67,15 @@ $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 
 targets += uImage
 targets += uImage.bin
-targets += uImage.bz2
 targets += uImage.gz
-targets += uImage.lzma
 targets += uImage.lzo
 
 $(obj)/uImage.bin: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,uimage,none)
 
-$(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2 FORCE
-	$(call if_changed,uimage,bzip2)
-
 $(obj)/uImage.gz: $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,uimage,gzip)
 
-$(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma FORCE
-	$(call if_changed,uimage,lzma)
-
 $(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo FORCE
 	$(call if_changed,uimage,lzo)
 
@@ -122,7 +104,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 
 targets += vmlinux.its
 targets += vmlinux.gz.its
-targets += vmlinux.bz2.its
 targets += vmlinux.lzmo.its
 targets += vmlinux.lzo.its
 
@@ -142,19 +123,11 @@ $(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 $(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed,cpp_its_S,gzip,vmlinux.bin.gz)
 
-$(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(VMLINUX)  FORCE
-	$(call if_changed,cpp_its_S,bzip2,vmlinux.bin.bz2)
-
-$(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
-	$(call if_changed,cpp_its_S,lzma,vmlinux.bin.lzma)
-
 $(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 targets += vmlinux.itb
 targets += vmlinux.gz.itb
-targets += vmlinux.bz2.itb
-targets += vmlinux.lzma.itb
 targets += vmlinux.lzo.itb
 
 quiet_cmd_itb-image = ITB     $@
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 3c453a1f1ff1..a7448d74fe7b 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -62,9 +62,7 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
 	$(call if_changed,objcopy)
 
 tool_$(CONFIG_KERNEL_GZIP)    = gzip
-tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
 tool_$(CONFIG_KERNEL_LZ4)     = lz4
-tool_$(CONFIG_KERNEL_LZMA)    = lzma
 tool_$(CONFIG_KERNEL_LZO)     = lzo
 tool_$(CONFIG_KERNEL_XZ)      = xzkern
 
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 81df9047e110..ac6978d210e6 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -56,18 +56,10 @@ void error(char *x)
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
-#include "../../../../lib/decompress_bunzip2.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZ4
 #include "../../../../lib/decompress_unlz4.c"
 #endif
 
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZO
 #include "../../../../lib/decompress_unlzo.c"
 #endif
-- 
2.19.1

