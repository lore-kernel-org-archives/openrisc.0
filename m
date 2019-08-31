From: Stafford Horne <shorne@gmail.com>
Date: Sat, 31 Aug 2019 12:03:48 +0900
Subject: [OpenRISC] [PATCH 2/2] or1k: dts: Add ethoc device to SMP devicetree
In-Reply-To: <20190831030348.6920-1-shorne@gmail.com>
References: <20190831030348.6920-1-shorne@gmail.com>
Message-ID: <20190831030348.6920-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This patch adds the ethoc device configuration to the OpenRISC basic SMP
device tree config.  This was tested with qemu.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/boot/dts/simple_smp.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple_smp.dts
index defbb92714ec..71af0e117bfe 100644
--- a/arch/openrisc/boot/dts/simple_smp.dts
+++ b/arch/openrisc/boot/dts/simple_smp.dts
@@ -60,4 +60,10 @@
 		clock-frequency = <20000000>;
 	};
 
+	enet0: ethoc at 92000000 {
+		compatible = "opencores,ethoc";
+		reg = <0x92000000 0x800>;
+		interrupts = <4>;
+		big-endian;
+	};
 };
-- 
2.21.0

