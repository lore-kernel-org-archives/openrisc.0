From: Mateusz Holenko <mholenko@antmicro.com>
Date: Wed, 23 Oct 2019 11:54:44 +0200
Subject: [OpenRISC] [PATCH 1/1] openrisc: add support for LiteX
In-Reply-To: <20191023115427.23684-0-mholenko@antmicro.com>
References: <20191023115427.23684-0-mholenko@antmicro.com>
Message-ID: <20191023115427.23684-1-mholenko@antmicro.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

This adds support for a basic LiteX-based SoC with a mor1kx soft CPU.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
 MAINTAINERS                               |  1 +
 arch/openrisc/boot/dts/or1klitex.dts      | 49 +++++++++++++++++++++++
 arch/openrisc/configs/or1klitex_defconfig | 18 +++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 arch/openrisc/boot/dts/or1klitex.dts
 create mode 100644 arch/openrisc/configs/or1klitex_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index c24a37833e78..e84b2cb4c186 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9500,6 +9500,7 @@ S:	Maintained
 F:	include/linux/litex.h
 F:	Documentation/devicetree/bindings/*/litex,*.yaml
 F:	drivers/tty/serial/liteuart.c
+F:	arch/openrisc/boot/dts/or1klitex.dts
 
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
new file mode 100644
index 000000000000..63399398002d
--- /dev/null
+++ b/arch/openrisc/boot/dts/or1klitex.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LiteX-based System on Chip
+ *
+ * Copyright (C) 2019 Antmicro Ltd <www.antmicro.com>
+ */
+
+/dts-v1/;
+/ {
+	compatible = "opencores,or1ksim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&pic>;
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		bootargs = "console=liteuart";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			compatible = "opencores,or1200-rtlsvn481";
+			reg = <0>;
+			clock-frequency = <100000000>;
+		};
+	};
+
+	pic: pic {
+		compatible = "opencores,or1k-pic";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	serial0: serial at e0001800 {
+		device_type = "serial";
+		compatible = "litex,liteuart";
+		reg = <0xe0001800 0x100>;
+	};
+};
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
new file mode 100644
index 000000000000..0e4c2e74451c
--- /dev/null
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -0,0 +1,18 @@
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BUG_ON_DATA_CORRUPTION=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_CROSS_COMPILE="or32-linux-"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EMBEDDED=y
+CONFIG_HZ_100=y
+CONFIG_INITRAMFS_SOURCE="openrisc-rootfs.cpio.gz"
+CONFIG_OF_OVERLAY=y
+CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_SERIAL_LITEUART=y
+CONFIG_SERIAL_LITEUART_CONSOLE=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_TTY_PRINTK=y
-- 
2.23.0

