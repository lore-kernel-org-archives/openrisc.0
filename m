From: Stafford Horne <shorne@gmail.com>
Date: Fri,  5 Mar 2021 06:07:47 +0900
Subject: [OpenRISC] [PATCH] Documentation: Add qemu instructions for OpenRISC
Message-ID: <20210304210747.3679483-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Most developers have qemu and rather not download and install the
or1ksim.  Also, this adds details on how to get a openrisc toolchain.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 Documentation/boards/openrisc.rst | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/boards/openrisc.rst b/Documentation/boards/openrisc.rst
index f9d67f965..34586b4a7 100644
--- a/Documentation/boards/openrisc.rst
+++ b/Documentation/boards/openrisc.rst
@@ -1,6 +1,74 @@
 OpenRISC
 ========
 
+Optaining an OpenRISC toolchain
+-------------------------------
+
+Toolchain binaries can be obtained from openrisc.io or our github releases page.
+Instructions for building the different toolchains can be found on openrisc.io
+or Stafford's toolchain build and release scripts.
+
+See:
+
+  * https://github.com/stffrdhrn/gcc/releases
+  * https://github.com/stffrdhrn/or1k-toolchain-build
+  * https://openrisc.io/software
+
+Example of downloading and installing a toolchain::
+
+  $ curl --remote-name --location \
+    https://github.com/stffrdhrn/gcc/releases/download/or1k-10.0.0-20190723/or1k-elf-10.0.0-20190723.tar.xz
+  $ tar -xf or1k-elf-10.0.0-20190723.tar.xz
+  $ export PATH=$PATH:$PWD/or1k-elf/bin
+
+Running OpenRISC barebox on qemu
+------------------------------
+
+Running barebox on qemu is similar to running linux on qemu see more details on
+the qemu wiki site at https://wiki.qemu.org/Documentation/Platforms/OpenRISC
+
+Compile the qemu emulator::
+
+  $ git clone https://gitlab.com/qemu-project/qemu.git
+  $ cd qemu
+  $ mkdir build ; cd build
+  $ ../configure \
+    --target-list="or1k-softmmu" \
+    --enable-fdt \
+    --disable-kvm \
+    --disable-xen \
+    --disable-xkbcommon \
+    --enable-debug \
+    --enable-debug-info
+  $ make
+
+Next compile barebox::
+
+  $ make ARCH=openrisc defconfig
+  ...
+  $ make ARCH=openrisc CROSS_COMPILE=or1k-elf-
+
+Run barebox::
+
+  $ <path to qemu source>/build/or1k-softmmu/qemu-system-or1k \
+    -cpu or1200 \
+    -M or1k-sim \
+    -kernel /home/shorne/work/openrisc/barebox/barebox \
+    -net nic -net tap,ifname=tap0,script=no,downscript=no \
+    -serial mon:stdio -nographic -gdb tcp::10001 \
+    -m 32
+
+
+  barebox 2021.02.0-00120-g763c6fee7-dirty #14 Thu Mar 4 05:13:51 JST 2021
+
+
+  Board: or1ksim
+  mdio_bus: miibus0: probed
+  malloc space: 0x01b80000 -> 0x01f7ffff (size 4 MiB)
+
+  Hit any to stop autoboot:    3
+  barebox at or1ksim:/
+
 or1ksim
 -------
 
-- 
2.26.2

