From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Aug 2021 22:59:44 +0930
Subject: [OpenRISC] [PATCH 1/3] openrisc/litex: Update uart address
In-Reply-To: <20210826132946.3324593-1-joel@jms.id.au>
References: <20210826132946.3324593-1-joel@jms.id.au>
Message-ID: <20210826132946.3324593-2-joel@jms.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Recent litex socs will place the UART at 0xe0006800.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/openrisc/boot/dts/or1klitex.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
index 3f9867aa3844..baba4f49fa6b 100644
--- a/arch/openrisc/boot/dts/or1klitex.dts
+++ b/arch/openrisc/boot/dts/or1klitex.dts
@@ -41,10 +41,10 @@ pic: pic {
 		interrupt-controller;
 	};
 
-	serial0: serial at e0002000 {
+	serial0: serial at e0006800 {
 		device_type = "serial";
 		compatible = "litex,liteuart";
-		reg = <0xe0002000 0x100>;
+		reg = <0xe0006800 0x100>;
 	};
 
 	soc_ctrl0: soc_controller at e0000000 {
-- 
2.33.0

