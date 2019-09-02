From: BAndViG <bandvig@mail.ru>
Date: Mon, 2 Sep 2019 21:01:39 +0300
Subject: [OpenRISC] [PATCH 2/2] or1k: dts: Add ethoc device to SMP
 devicetree
In-Reply-To: <20190831030348.6920-3-shorne@gmail.com>
References: <20190831030348.6920-1-shorne@gmail.com>
 <20190831030348.6920-3-shorne@gmail.com>
Message-ID: <28B006D9DDD5477CB7AA012671DB30F8@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello All.
I've ported these ethernet description for my Atlys-based SoC. Prior to it 
Linux were not able even to detect Marvell's PHY. With the modifications 
Marvell's PHY is detected correctly. However, I still can not  use ethernet 
connection. For example, If I try to execute "ping {ip-of-my-pc}" it reports 
"net eth0: TX: carrier sense lost". Perhaps, I have to configure correctly MDIO 
bus and PHY itself. Have anybody got an recommendation?

WBR
Andrey

-----Исходное сообщение----- 
From: Stafford Horne
Sent: Saturday, August 31, 2019 6:03 AM
To: LKML
Cc: Mark Rutland ; Jonas Bonn ; devicetree at vger.kernel.org ; Rob Herring ; 
openrisc at lists.librecores.org
Subject: [OpenRISC] [PATCH 2/2] or1k: dts: Add ethoc device to SMP devicetree

This patch adds the ethoc device configuration to the OpenRISC basic SMP
device tree config.  This was tested with qemu.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
arch/openrisc/boot/dts/simple_smp.dts | 6 ++++++
1 file changed, 6 insertions(+)

diff --git a/arch/openrisc/boot/dts/simple_smp.dts 
b/arch/openrisc/boot/dts/simple_smp.dts
index defbb92714ec..71af0e117bfe 100644
--- a/arch/openrisc/boot/dts/simple_smp.dts
+++ b/arch/openrisc/boot/dts/simple_smp.dts
@@ -60,4 +60,10 @@
  clock-frequency = <20000000>;
  };

+ enet0: ethoc at 92000000 {
+ compatible = "opencores,ethoc";
+ reg = <0x92000000 0x800>;
+ interrupts = <4>;
+ big-endian;
+ };
};
-- 
2.21.0

_______________________________________________
OpenRISC mailing list
OpenRISC at lists.librecores.org
https://lists.librecores.org/listinfo/openrisc

