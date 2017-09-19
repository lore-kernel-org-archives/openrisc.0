From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Sep 2017 23:00:24 +0900
Subject: [OpenRISC] [PATCH] openrisc: dts: or1ksim: Add stdout-path
Message-ID: <20170919140024.32563-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

During reviews of the OpenRISC SMP patch series it was suggested to add
stdout-path to the SMP dts file.  Add stdout-path to our other dts files
to be a good example.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/boot/dts/or1ksim.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/dts/or1ksim.dts
index 5d4f9027afaf..ecc30968cbcb 100644
--- a/arch/openrisc/boot/dts/or1ksim.dts
+++ b/arch/openrisc/boot/dts/or1ksim.dts
@@ -7,6 +7,7 @@
 
 	chosen {
 		bootargs = "console=uart,mmio,0x90000000,115200";
+		stdout-path = &serial0;
 	};
 
 	memory at 0 {
-- 
2.13.5

