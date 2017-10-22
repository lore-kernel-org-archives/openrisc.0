From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Oct 2017 11:46:41 +0900
Subject: [OpenRISC] [PATCH 3/3] openrisc: dts: Add OpenRISC platform SoC
In-Reply-To: <20171022024641.28478-1-shorne@gmail.com>
References: <20171022024641.28478-1-shorne@gmail.com>
Message-ID: <20171022024641.28478-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add devicetree binding documentation for the OpenRISC platform
opencores,or1ksim.  This is the main OpenRISC reference platform
supporting multiple FPGA SoC's.

This format is based on some of the mips binding docs as we have
similar requirements.

Also, update maintainers so openrisc related binding changes are visible
to the openrisc team.

Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 .../bindings/openrisc/opencores/or1ksim.txt        | 39 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/openrisc/opencores/or1ksim.txt

diff --git a/Documentation/devicetree/bindings/openrisc/opencores/or1ksim.txt b/Documentation/devicetree/bindings/openrisc/opencores/or1ksim.txt
new file mode 100644
index 000000000000..4950c794ecbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/openrisc/opencores/or1ksim.txt
@@ -0,0 +1,39 @@
+OpenRISC Generic SoC
+====================
+
+Boards and FPGA SoC's which support the OpenRISC standard platform.  The
+platform essentially follows the conventions of the OpenRISC architecture
+specification, however some aspects, such as the boot protocol have been defined
+by the Linux port.
+
+Required properties
+-------------------
+ - compatible: Must include "opencores,or1ksim"
+
+CPU nodes:
+----------
+A "cpus" node is required.  Required properties:
+ - #address-cells: Must be 1.
+ - #size-cells: Must be 0.
+A CPU sub-node is also required for at least CPU 0.  Since the topology may
+be probed via CPS, it is not necessary to specify secondary CPUs.  Required
+properties:
+ - compatible: Must be "opencores,or1200-rtlsvn481".
+ - reg: CPU number.
+ - clock-frequency: The CPU clock frequency in Hz.
+Example:
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			compatible = "opencores,or1200-rtlsvn481";
+			reg = <0>;
+			clock-frequency = <20000000>;
+		};
+	};
+
+
+Boot protocol
+-------------
+The bootloader may pass the following arguments to the kernel:
+ - r3:  address of a flattened device-tree blob or 0x0.
diff --git a/MAINTAINERS b/MAINTAINERS
index a57d13cb414d..71e4f6762196 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10008,6 +10008,7 @@ T:	git git://github.com/openrisc/linux.git
 L:	openrisc at lists.librecores.org
 W:	http://openrisc.io
 S:	Maintained
+F;	Documentation/devicetree/bindings/openrisc/
 F:	Documentation/openrisc/
 F:	arch/openrisc/
 F:	drivers/irqchip/irq-or1k-*
-- 
2.13.6

