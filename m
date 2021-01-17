From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 17 Jan 2021 17:03:32 +0900
Subject: [OpenRISC] [PATCH] openrisc: add arch/openrisc/Kbuild
Message-ID: <20210117080332.2289077-1-masahiroy@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Describe the subdirectories under arch/openrisc/ in arch/openrisc/Kbuild
so you can use the standard obj-y syntax.

I removed the CONFIG_OPENRISC_BUILTIN_DTB conditional because it is
already controlled by arch/openrisc/boot/dts/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/openrisc/Kbuild   |  3 +++
 arch/openrisc/Makefile | 11 +----------
 2 files changed, 4 insertions(+), 10 deletions(-)
 create mode 100644 arch/openrisc/Kbuild

diff --git a/arch/openrisc/Kbuild b/arch/openrisc/Kbuild
new file mode 100644
index 000000000000..4234b4c03e72
--- /dev/null
+++ b/arch/openrisc/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y += lib/ kernel/ mm/
+obj-y += boot/dts/
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index bf10141c7426..44e63fa35e04 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -38,14 +38,5 @@ endif
 
 head-y 		:= arch/openrisc/kernel/head.o
 
-core-y		+= arch/openrisc/lib/ \
-		   arch/openrisc/kernel/ \
-		   arch/openrisc/mm/
+core-y		+= arch/openrisc/
 libs-y		+= $(LIBGCC)
-
-ifneq '$(CONFIG_OPENRISC_BUILTIN_DTB)' '""'
-BUILTIN_DTB := y
-else
-BUILTIN_DTB := n
-endif
-core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
-- 
2.27.0

