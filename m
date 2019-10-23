From: Mateusz Holenko <mholenko@antmicro.com>
Date: Wed, 23 Oct 2019 11:54:33 +0200
Subject: [OpenRISC] [PATCH 0/1]  openrisc: LiteX+mor1kx platform
Message-ID: <20191023115427.23684-0-mholenko@antmicro.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This patchset adds a new LiteX SoC-based platform
configured for mor1kx (OpenRISC) CPU coupled with
LiteUART serial device.

Details about LiteX can be found at
https://github.com/enjoy-digital/litex.

This platform is intended for further extension
once drivers for other LiteX devices are merged
to the kernel.

NOTE:
This requires another patchset to be merged first:
https://lore.kernel.org/patchwork/cover/1143352/

Filip Kokosinski (1):
  openrisc: add support for LiteX

 MAINTAINERS                               |  1 +
 arch/openrisc/boot/dts/or1klitex.dts      | 49 +++++++++++++++++++++++
 arch/openrisc/configs/or1klitex_defconfig | 18 +++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 arch/openrisc/boot/dts/or1klitex.dts
 create mode 100644 arch/openrisc/configs/or1klitex_defconfig

-- 
2.23.0

