From: Stafford Horne <shorne@gmail.com>
Date: Sat, 31 Aug 2019 12:03:47 +0900
Subject: [OpenRISC] [PATCH 1/2] or1k: dts: Fix ethoc network configuration
 in or1ksim devicetree
In-Reply-To: <20190831030348.6920-1-shorne@gmail.com>
References: <20190831030348.6920-1-shorne@gmail.com>
Message-ID: <20190831030348.6920-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This fixes several issues with the ethoc network device config.

Fisrt off, the compatible property used an obsolete compatibility
string; this caused the initialization to be skipped.  Next, the
register map was not given enough space to allocate ring descriptors,
this caused module initialization to abort.  Finally, we need to mark
this device as big-endian as needed by openrisc.

This was tested by me in qemu, the setup is documented on the qemu wiki:

  https://wiki.qemu.org/Documentation/Platforms/OpenRISC

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/boot/dts/or1ksim.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/dts/or1ksim.dts
index d8aa8309c9d3..c0cb74e52f95 100644
--- a/arch/openrisc/boot/dts/or1ksim.dts
+++ b/arch/openrisc/boot/dts/or1ksim.dts
@@ -49,8 +49,9 @@
 	};
 
 	enet0: ethoc at 92000000 {
-		compatible = "opencores,ethmac-rtlsvn338";
-		reg = <0x92000000 0x100>;
+		compatible = "opencores,ethoc";
+		reg = <0x92000000 0x800>;
 		interrupts = <4>;
+		big-endian;
 	};
 };
-- 
2.21.0

