From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 27 Feb 2017 14:40:52 +0900
Subject: [OpenRISC] [PATCH] kbuild: avoid unrecognized option error for
	external DTC
Message-ID: <1488174052-2530-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Since commit 6b22b3d1614a ("kbuild: Allow using host dtc instead of
kernel's copy"), it is possible to use an external dtc.  In this
case, we do not know which options are supported on it.

Commit bc553986a2f7 ("dtc: turn off dtc unit address warnings by
default") gives -Wno-unit_address_vs_reg, but this options is only
recognized by v1.4.2 or later.

If an older version is specified, the build fails:

$ dtc --version
Version: DTC 1.4.0
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- DTC=dtc dtbs
  [ snip ]
  DTC     arch/arm64/boot/dts/al/alpine-v2-evp.dtb
FATAL ERROR: Unrecognized check name "unit_address_vs_reg"
make[2]: *** [arch/arm64/boot/dts/al/alpine-v2-evp.dtb] Error 1
make[1]: *** [arch/arm64/boot/dts/al] Error 2
make: *** [dtbs] Error 2

This commit adds a new helper dtc-option to check if the given
option is supported, like cc-option, ld-option, etc.

The check for the -Wno-unit_address_vs_reg has been moved from
Makefile.lib to Makefile.extrawarn.  Since Makefile.lib is included
recursively, it is not efficient to evaluate the $(call dtc-option)
at every descend.  On the other hand, Makefile.extrawarn is included
just once from the top Makefile.  Besides, it seems more suitable to
collect extra warning things into the Makefile.extrawarn.

The variable, DTC, has also been moved to the top Makefile so that
the Makefile.extrawarn can reference it.

Here is one problem for the dtc-option helper; the kernel's copy
(scripts/dtc/dtc) is not compiled until Kbuild descends into the
scripts/dtc/ directory.  This happens later after Makefile.extrawarn
is evaluated.  So, dtc-options should its job only when DTC is
overridden from the command line (i.e. pre-built dtc is used).
If the kernel's copy is used, dtc-option falls back to a fixed option
because we know which options are supported on the internal one.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                          |  4 +++-
 arch/c6x/boot/dts/Makefile        |  2 +-
 arch/microblaze/boot/dts/Makefile |  2 +-
 arch/openrisc/boot/dts/Makefile   |  2 +-
 arch/powerpc/boot/Makefile        |  2 +-
 scripts/Kbuild.include            | 14 ++++++++++++++
 scripts/Makefile.extrawarn        |  4 ++++
 scripts/Makefile.lib              |  6 ------
 8 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index b83109b..4c4647a 100644
--- a/Makefile
+++ b/Makefile
@@ -356,6 +356,7 @@ STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
+DTC		= scripts/dtc/dtc
 GENKSYMS	= scripts/genksyms/genksyms
 INSTALLKERNEL  := installkernel
 DEPMOD		= /sbin/depmod
@@ -365,6 +366,7 @@ CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
 		  -Wbitwise -Wno-return-void $(CF)
+DTC_FLAGS      :=
 NOSTDINC_FLAGS  =
 CFLAGS_MODULE   =
 AFLAGS_MODULE   =
@@ -419,7 +421,7 @@ export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP
 export MAKE AWK GENKSYMS INSTALLKERNEL PERL PYTHON UTS_MACHINE
-export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS DTC DTC_FLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE CFLAGS_GCOV CFLAGS_KCOV CFLAGS_KASAN CFLAGS_UBSAN
diff --git a/arch/c6x/boot/dts/Makefile b/arch/c6x/boot/dts/Makefile
index c7528b0..459955b 100644
--- a/arch/c6x/boot/dts/Makefile
+++ b/arch/c6x/boot/dts/Makefile
@@ -2,7 +2,7 @@
 # Makefile for device trees
 #
 
-DTC_FLAGS ?= -p 1024
+DTC_FLAGS += -p 1024
 
 ifneq ($(DTB),)
 obj-y += linked_dtb.o
diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index a3d2e42..5addb5b 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -15,4 +15,4 @@ quiet_cmd_cp = CP      $< $@$2
 	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
 
 # Rule to build device tree blobs
-DTC_FLAGS := -p 1024
+DTC_FLAGS += -p 1024
diff --git a/arch/openrisc/boot/dts/Makefile b/arch/openrisc/boot/dts/Makefile
index b092d30..f4048d1 100644
--- a/arch/openrisc/boot/dts/Makefile
+++ b/arch/openrisc/boot/dts/Makefile
@@ -7,4 +7,4 @@ obj-y += $(BUILTIN_DTB)
 
 clean-files := *.dtb.S
 
-#DTC_FLAGS ?= -p 1024
+#DTC_FLAGS += -p 1024
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e82f333..5350b67 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -50,7 +50,7 @@ endif
 
 BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
 
-DTC_FLAGS	?= -p 1024
+DTC_FLAGS	+= -p 1024
 
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index d6ca649..adabbb5 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -171,6 +171,20 @@ ld-version = $(shell $(LD) --version | $(srctree)/scripts/ld-version.sh)
 # Usage:  $(call ld-ifversion, -ge, 22252, y)
 ld-ifversion = $(shell [ $(ld-version) $(1) $(2) ] && echo $(3) || echo $(4))
 
+# dtc-option
+# Usage:  DTC_FLAGS += $(call dtc-option,-Wno-unit_address_vs_reg)
+#
+# When we use the external dtc, check if the desired options are supported.
+# When we use the kernel's copy (scripts/dtc/dtc), just use the fixed option.
+# Until Kbuild descends into the scripts/dtc/ directory, scripts/dtc/dtc may
+# not exist, i.e. $(call try-run,...) may not work.
+ifeq ("$(origin DTC)", "command line")
+dtc-option = $(call try-run,\
+	echo '/dts-v1/; / {};' | $(DTC) $(1),$(1),$(2))
+else
+dtc-option = $(1)
+endif
+
 ######
 
 ###
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 7c321a6..17d4030 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -69,4 +69,8 @@ KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
 KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
 endif
+
+# Disable noisy checks by default
+DTC_FLAGS += $(call dtc-option,-Wno-unit_address_vs_reg)
+
 endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0a07f90..6228c9b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -276,12 +276,6 @@ cmd_gzip = (cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@) || \
 
 # DTC
 # ---------------------------------------------------------------------------
-DTC ?= $(objtree)/scripts/dtc/dtc
-
-# Disable noisy checks by default
-ifeq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
-DTC_FLAGS += -Wno-unit_address_vs_reg
-endif
 
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTB     $@
-- 
2.7.4

