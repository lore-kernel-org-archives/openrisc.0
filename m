From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Aug 2021 22:59:45 +0930
Subject: [OpenRISC] [PATCH 2/3] openrisc/litex: Add ethernet device
In-Reply-To: <20210826132946.3324593-1-joel@jms.id.au>
References: <20210826132946.3324593-1-joel@jms.id.au>
Message-ID: <20210826132946.3324593-3-joel@jms.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add the liteeth ethernet device.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/openrisc/boot/dts/or1klitex.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
index baba4f49fa6b..91c7173c50e6 100644
--- a/arch/openrisc/boot/dts/or1klitex.dts
+++ b/arch/openrisc/boot/dts/or1klitex.dts
@@ -52,4 +52,13 @@ soc_ctrl0: soc_controller at e0000000 {
 			reg = <0xe0000000 0xc>;
 			status = "okay";
 	};
+
+	ethernet at e0001000 {
+		compatible = "litex,liteeth";
+		reg = <0xe0001000 0x7c>,
+		      <0xe0001800 0x0a>,
+		      <0x80000000 0x2000>;
+		reg-names = "mac", "mdio", "buffer";
+		interrupts = <2>;
+	};
 };
-- 
2.33.0

