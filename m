From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 12 Jul 2018 17:01:33 +0900
Subject: [OpenRISC] [PATCH 3/6] kbuild: remove redundant LDFLAGS clearing in
	arch/*/Makefile
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1531382496-3719-4-git-send-email-yamada.masahiro@socionext.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Since commit ce99d0bf312d ("kbuild: clear LDFLAGS in the top Makefile"),
the top-level Makefile caters to this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Makefile      | 3 ---
 arch/openrisc/Makefile | 1 -
 arch/riscv/Makefile    | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 62ebeae..e7d703d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,9 +10,6 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-# Ensure linker flags are correct
-LDFLAGS		:=
-
 LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 89076a6..70e06d3 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -19,7 +19,6 @@
 
 KBUILD_DEFCONFIG := or1ksim_defconfig
 
-LDFLAGS         :=
 OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=
 LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6d4a5f6c..2627e48 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -8,7 +8,6 @@
 # for more details.
 #
 
-LDFLAGS         :=
 OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux :=
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
-- 
2.7.4

