From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Fri, 26 Jul 2019 09:51:24 -0300
Subject: [OpenRISC] [PATCH v2 14/26] docs: openrisc: convert to ReST and add
 to documentation body
In-Reply-To: <cover.1564145354.git.mchehab+samsung@kernel.org>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
Message-ID: <02484db055b58d76ef62cb42fd3e9a4e701b49c8.1564145354.git.mchehab+samsung@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Manually convert the two openRisc documents to ReST, adding them
to the Linux documentation body.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Stafford Horne <shorne@gmail.com>
---
 Documentation/index.rst                       |  1 +
 Documentation/openrisc/index.rst              | 18 +++++++++++++
 .../openrisc/{README => openrisc_port.rst}    | 25 +++++++++++++------
 Documentation/openrisc/{TODO => todo.rst}     |  9 ++++---
 4 files changed, 43 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/openrisc/index.rst
 rename Documentation/openrisc/{README => openrisc_port.rst} (80%)
 rename Documentation/openrisc/{TODO => todo.rst} (78%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 25e080664050..6402f62ac90f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -148,6 +148,7 @@ implementation.
    ia64/index
    m68k/index
    powerpc/index
+   openrisc/index
    parisc/index
    riscv/index
    s390/index
diff --git a/Documentation/openrisc/index.rst b/Documentation/openrisc/index.rst
new file mode 100644
index 000000000000..748b3eea1707
--- /dev/null
+++ b/Documentation/openrisc/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+OpenRISC Architecture
+=====================
+
+.. toctree::
+   :maxdepth: 2
+
+   openrisc_port
+   todo
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/openrisc/README b/Documentation/openrisc/openrisc_port.rst
similarity index 80%
rename from Documentation/openrisc/README
rename to Documentation/openrisc/openrisc_port.rst
index 777a893d533d..a18747a8d191 100644
--- a/Documentation/openrisc/README
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -1,3 +1,4 @@
+==============
 OpenRISC Linux
 ==============
 
@@ -6,8 +7,10 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
 
 For information about OpenRISC processors and ongoing development:
 
+	=======		=============================
 	website		http://openrisc.io
 	email		openrisc at lists.librecores.org
+	=======		=============================
 
 ---------------------------------------------------------------------
 
@@ -24,13 +27,15 @@ Toolchain binaries can be obtained from openrisc.io or our github releases page.
 Instructions for building the different toolchains can be found on openrisc.io
 or Stafford's toolchain build and release scripts.
 
+	==========	=================================================
 	binaries	https://github.com/openrisc/or1k-gcc/releases
 	toolchains	https://openrisc.io/software
 	building	https://github.com/stffrdhrn/or1k-toolchain-build
+	==========	=================================================
 
 2) Building
 
-Build the Linux kernel as usual
+Build the Linux kernel as usual::
 
 	make ARCH=openrisc defconfig
 	make ARCH=openrisc
@@ -43,6 +48,8 @@ development board with the OpenRISC SoC.  During the build FPGA RTL is code
 downloaded from the FuseSoC IP cores repository and built using the FPGA vendor
 tools.  Binaries are loaded onto the board with openocd.
 
+::
+
 	git clone https://github.com/olofk/fusesoc
 	cd fusesoc
 	sudo pip install -e .
@@ -65,7 +72,9 @@ platform.  Please follow the OpenRISC instructions on the QEMU website to get
 Linux running on QEMU.  You can build QEMU yourself, but your Linux distribution
 likely provides binary packages to support OpenRISC.
 
+	=============	======================================================
 	qemu openrisc	https://wiki.qemu.org/Documentation/Platforms/OpenRISC
+	=============	======================================================
 
 ---------------------------------------------------------------------
 
@@ -75,36 +84,38 @@ Terminology
 In the code, the following particles are used on symbols to limit the scope
 to more or less specific processor implementations:
 
+========= =======================================
 openrisc: the OpenRISC class of processors
 or1k:     the OpenRISC 1000 family of processors
 or1200:   the OpenRISC 1200 processor
+========= =======================================
 
 ---------------------------------------------------------------------
 
 History
 ========
 
-18. 11. 2003	Matjaz Breskvar (phoenix at bsemi.com)
+18-11-2003	Matjaz Breskvar (phoenix at bsemi.com)
 	initial port of linux to OpenRISC/or32 architecture.
         all the core stuff is implemented and seams usable.
 
-08. 12. 2003	Matjaz Breskvar (phoenix at bsemi.com)
+08-12-2003	Matjaz Breskvar (phoenix at bsemi.com)
 	complete change of TLB miss handling.
 	rewrite of exceptions handling.
 	fully functional sash-3.6 in default initrd.
 	a much improved version with changes all around.
 
-10. 04. 2004	Matjaz Breskvar (phoenix at bsemi.com)
+10-04-2004	Matjaz Breskvar (phoenix at bsemi.com)
 	alot of bugfixes all over.
 	ethernet support, functional http and telnet servers.
 	running many standard linux apps.
 
-26. 06. 2004	Matjaz Breskvar (phoenix at bsemi.com)
+26-06-2004	Matjaz Breskvar (phoenix at bsemi.com)
 	port to 2.6.x
 
-30. 11. 2004	Matjaz Breskvar (phoenix at bsemi.com)
+30-11-2004	Matjaz Breskvar (phoenix at bsemi.com)
 	lots of bugfixes and enhancments.
 	added opencores framebuffer driver.
 
-09. 10. 2010    Jonas Bonn (jonas at southpole.se)
+09-10-2010    Jonas Bonn (jonas at southpole.se)
 	major rewrite to bring up to par with upstream Linux 2.6.36
diff --git a/Documentation/openrisc/TODO b/Documentation/openrisc/todo.rst
similarity index 78%
rename from Documentation/openrisc/TODO
rename to Documentation/openrisc/todo.rst
index c43d4e1d14eb..420b18b87eda 100644
--- a/Documentation/openrisc/TODO
+++ b/Documentation/openrisc/todo.rst
@@ -1,12 +1,15 @@
+====
+TODO
+====
+
 The OpenRISC Linux port is fully functional and has been tracking upstream
 since 2.6.35.  There are, however, remaining items to be completed within
 the coming months.  Here's a list of known-to-be-less-than-stellar items
 that are due for investigation shortly, i.e. our TODO list:
 
--- Implement the rest of the DMA API... dma_map_sg, etc.
+-  Implement the rest of the DMA API... dma_map_sg, etc.
 
--- Finish the renaming cleanup... there are references to or32 in the code
+-  Finish the renaming cleanup... there are references to or32 in the code
    which was an older name for the architecture.  The name we've settled on is
    or1k and this change is slowly trickling through the stack.  For the time
    being, or32 is equivalent to or1k.
-
-- 
2.21.0

