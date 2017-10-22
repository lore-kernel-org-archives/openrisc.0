From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Oct 2017 11:23:53 +0900
Subject: [OpenRISC] [PATCH v2] openrisc: dts: or1ksim: Add stdout-path
Message-ID: <20171022022353.27464-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

During reviews of the OpenRISC SMP patch series it was suggested to add
stdout-path to the SMP dts file.  Add stdout-path to our other dts files
to be a good example.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---

Changes since v1
 - Complete rewrite with input from Geert

 arch/openrisc/boot/dts/or1ksim.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/dts/or1ksim.dts
index 5d4f9027afaf..8f41bd8c9f84 100644
--- a/arch/openrisc/boot/dts/or1ksim.dts
+++ b/arch/openrisc/boot/dts/or1ksim.dts
@@ -5,8 +5,13 @@
 	#size-cells = <1>;
 	interrupt-parent = <&pic>;
 
+	aliases {
+		uart0 = &serial0;
+	};
+
 	chosen {
-		bootargs = "console=uart,mmio,0x90000000,115200";
+		bootargs = "earlycon";
+		stdout-path = "uart0:115200";
 	};
 
 	memory at 0 {
-- 
2.13.6

