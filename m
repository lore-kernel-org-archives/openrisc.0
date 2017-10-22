From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Oct 2017 11:46:40 +0900
Subject: [OpenRISC] [PATCH 2/3] Documentation: openrisc: Updates to README
In-Reply-To: <20171022024641.28478-1-shorne@gmail.com>
References: <20171022024641.28478-1-shorne@gmail.com>
Message-ID: <20171022024641.28478-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Update the OpenRISC readme to provide some more up-to-date information
on how to get started with OpenRISC.  This includes:

 - remove references to southpole who no longer are consulting for
   OpenRISC (confirmed with Jonas)
 - suggested QEMU instead of the old or1ksim as QEMU is well supported
 - include instructions on how to get an FPGA board running

Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 Documentation/openrisc/README | 65 +++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/Documentation/openrisc/README b/Documentation/openrisc/README
index 072069ab5100..777a893d533d 100644
--- a/Documentation/openrisc/README
+++ b/Documentation/openrisc/README
@@ -7,13 +7,7 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
 For information about OpenRISC processors and ongoing development:
 
 	website		http://openrisc.io
-
-For more information about Linux on OpenRISC, please contact South Pole AB.
-
-	email:		info at southpole.se
-
-	website:	http://southpole.se
-			http://southpoleconsulting.com
+	email		openrisc at lists.librecores.org
 
 ---------------------------------------------------------------------
 
@@ -24,37 +18,54 @@ In order to build and run Linux for OpenRISC, you'll need at least a basic
 toolchain and, perhaps, the architectural simulator.  Steps to get these bits
 in place are outlined here.
 
-1)  The toolchain can be obtained from openrisc.io.  Instructions for building
-a toolchain can be found at:
+1) Toolchain
+
+Toolchain binaries can be obtained from openrisc.io or our github releases page.
+Instructions for building the different toolchains can be found on openrisc.io
+or Stafford's toolchain build and release scripts.
+
+	binaries	https://github.com/openrisc/or1k-gcc/releases
+	toolchains	https://openrisc.io/software
+	building	https://github.com/stffrdhrn/or1k-toolchain-build
 
-https://github.com/openrisc/tutorials
+2) Building
 
-2) or1ksim (optional)
+Build the Linux kernel as usual
 
-or1ksim is the architectural simulator which will allow you to actually run
-your OpenRISC Linux kernel if you don't have an OpenRISC processor at hand.
+	make ARCH=openrisc defconfig
+	make ARCH=openrisc
 
-	git clone https://github.com/openrisc/or1ksim.git
+3) Running on FPGA (optional)
 
-	cd or1ksim
-	./configure --prefix=$OPENRISC_PREFIX
-	make
-	make install
+The OpenRISC community typically uses FuseSoC to manage building and programming
+an SoC into an FPGA.  The below is an example of programming a De0 Nano
+development board with the OpenRISC SoC.  During the build FPGA RTL is code
+downloaded from the FuseSoC IP cores repository and built using the FPGA vendor
+tools.  Binaries are loaded onto the board with openocd.
 
-3)  Linux kernel
+	git clone https://github.com/olofk/fusesoc
+	cd fusesoc
+	sudo pip install -e .
 
-Build the kernel as usual
+	fusesoc init
+	fusesoc build de0_nano
+	fusesoc pgm de0_nano
 
-	make ARCH=openrisc defconfig
-	make ARCH=openrisc
+	openocd -f interface/altera-usb-blaster.cfg \
+		-f board/or1k_generic.cfg
+
+	telnet localhost 4444
+	> init
+	> halt; load_image vmlinux ; reset
 
-4)  Run in architectural simulator
+4) Running on a Simulator (optional)
 
-Grab the or1ksim platform configuration file (from the or1ksim source) and
-together with your freshly built vmlinux, run your kernel with the following
-incantation:
+QEMU is a processor emulator which we recommend for simulating the OpenRISC
+platform.  Please follow the OpenRISC instructions on the QEMU website to get
+Linux running on QEMU.  You can build QEMU yourself, but your Linux distribution
+likely provides binary packages to support OpenRISC.
 
-	sim -f arch/openrisc/or1ksim.cfg vmlinux
+	qemu openrisc	https://wiki.qemu.org/Documentation/Platforms/OpenRISC
 
 ---------------------------------------------------------------------
 
-- 
2.13.6

