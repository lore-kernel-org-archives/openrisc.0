From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 07:03:11 +0900
Subject: [OpenRISC] [PATCH 10/13] openrisc: add simple_smp dts and defconfig
	for simulators
In-Reply-To: <cover.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
Message-ID: <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Simple enough to be compatible with simulation environments,
such as verilated systems, QEMU and other targets supporting OpenRISC
SMP.  This also supports our base FPGA SoC's if the cpu frequency is
upped to 50Mhz.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: Added defconfig]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/boot/dts/simple_smp.dts      | 58 ++++++++++++++++++++++++++
 arch/openrisc/configs/simple_smp_defconfig | 66 ++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 arch/openrisc/boot/dts/simple_smp.dts
 create mode 100644 arch/openrisc/configs/simple_smp_defconfig

diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple_smp.dts
new file mode 100644
index 000000000000..47c54101baae
--- /dev/null
+++ b/arch/openrisc/boot/dts/simple_smp.dts
@@ -0,0 +1,58 @@
+/dts-v1/;
+/ {
+	compatible = "opencores,or1ksim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&pic>;
+
+	chosen {
+		bootargs = "console=uart,mmio,0x90000000,115200";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x00000000 0x02000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			compatible = "opencores,or1200-rtlsvn481";
+			reg = <0>;
+			clock-frequency = <20000000>;
+		};
+		cpu at 1 {
+			compatible = "opencores,or1200-rtlsvn481";
+			reg = <1>;
+			clock-frequency = <20000000>;
+		};
+	};
+
+	ompic: ompic {
+		compatible = "ompic";
+		reg = <0x98000000 16>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupts = <1>;
+	};
+
+	/*
+	 * OR1K PIC is built into CPU and accessed via special purpose
+	 * registers.  It is not addressable and, hence, has no 'reg'
+	 * property.
+	 */
+	pic: pic {
+		compatible = "opencores,or1k-pic-level";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	serial0: serial at 90000000 {
+		compatible = "opencores,uart16550-rtlsvn105", "ns16550a";
+		reg = <0x90000000 0x100>;
+		interrupts = <2>;
+		clock-frequency = <20000000>;
+	};
+
+};
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
new file mode 100644
index 000000000000..b6e3c7e158e7
--- /dev/null
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -0,0 +1,66 @@
+CONFIG_CROSS_COMPILE="or1k-linux-"
+CONFIG_LOCALVERSION="-simple-smp"
+CONFIG_NO_HZ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_EXPERT=y
+# CONFIG_KALLSYMS is not set
+# CONFIG_EPOLL is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLOB=y
+CONFIG_MODULES=y
+# CONFIG_BLOCK is not set
+CONFIG_OPENRISC_BUILTIN_DTB="simple_smp"
+CONFIG_SMP=y
+CONFIG_HZ_100=y
+CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_TCP_CONG_ADVANCED=y
+# CONFIG_TCP_CONG_BIC is not set
+# CONFIG_TCP_CONG_CUBIC is not set
+# CONFIG_TCP_CONG_WESTWOOD is not set
+# CONFIG_TCP_CONG_HTCP is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_NETDEVICES=y
+CONFIG_ETHOC=y
+CONFIG_MICREL_PHY=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_XZ_DEC=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_RCU_TRACE is not set
-- 
2.13.5

