From: Joel Stanley <joel@jms.id.au>
Date: Tue, 22 Dec 2020 17:37:31 +1030
Subject: [OpenRISC] [PATCH v2] openrisc: Add vmlinux.bin target
Message-ID: <20201222070731.491076-1-joel@jms.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Build it by default. This is commonly used by fpga targets.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Address review from Masahiro

 - Add vmlinux.bin to phony target
 - simplfy vmlinux.bin rule
 - add cleanup rule
 - add vmlinux.bin to targets
 - Add gitignore
---
 arch/openrisc/Makefile        | 12 ++++++++++++
 arch/openrisc/boot/.gitignore |  2 ++
 arch/openrisc/boot/Makefile   | 10 ++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 arch/openrisc/boot/.gitignore
 create mode 100644 arch/openrisc/boot/Makefile

diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index bf10141c7426..b13404f1f8bd 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -24,6 +24,10 @@ LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
 
+all: vmlinux.bin
+
+boot := arch/$(ARCH)/boot
+
 ifeq ($(CONFIG_OPENRISC_HAVE_INST_MUL),y)
 	KBUILD_CFLAGS += $(call cc-option,-mhard-mul)
 else
@@ -49,3 +53,11 @@ else
 BUILTIN_DTB := n
 endif
 core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
+
+PHONY += vmlinux.bin
+
+vmlinux.bin: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/openrisc/boot/.gitignore b/arch/openrisc/boot/.gitignore
new file mode 100644
index 000000000000..007d6fea3145
--- /dev/null
+++ b/arch/openrisc/boot/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+vmlinux.bin
diff --git a/arch/openrisc/boot/Makefile b/arch/openrisc/boot/Makefile
new file mode 100644
index 000000000000..5b28538f4dd1
--- /dev/null
+++ b/arch/openrisc/boot/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for bootable kernel images
+#
+
+targets += vmlinux.bin
+
+OBJCOPYFLAGS_vmlinux.bin := -O binary
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
-- 
2.29.2

