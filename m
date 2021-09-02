From: Stafford Horne <shorne@gmail.com>
Date: Fri, 3 Sep 2021 06:12:01 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for 5.15
Message-ID: <YTE+IdUiJ+k+bpDR@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull:

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 1955d843efc3b5cf3ab4878986a87ad4972ff4e1:

  openrisc/litex: Update defconfig (2021-08-31 22:41:46 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.15

A few cleanups and compiler warning fixes for OpenRISC.  Also, this
includes dts and defconfig updates to enable Ethernet on OpenRISC/Litex
FPGA SoC's now that the LiteEth driver has gone upstream.

----------------------------------------------------------------
Joel Stanley (3):
      openrisc/litex: Update uart address
      openrisc/litex: Add ethernet device
      openrisc/litex: Update defconfig

Randy Dunlap (2):
      openrisc: don't printk() unconditionally
      openrisc: rename or32 code & comments to or1k

Stafford Horne (1):
      openrisc: Fix compiler warnings in setup

 arch/openrisc/boot/dts/or1klitex.dts      | 13 +++++++++++--
 arch/openrisc/configs/or1klitex_defconfig | 26 ++++++++++++++++----------
 arch/openrisc/include/asm/pgtable.h       |  6 +++---
 arch/openrisc/include/asm/setup.h         | 15 +++++++++++++++
 arch/openrisc/include/asm/thread_info.h   |  2 +-
 arch/openrisc/kernel/entry.S              |  6 ++++--
 arch/openrisc/kernel/head.S               |  6 +++---
 arch/openrisc/kernel/setup.c              | 20 +++-----------------
 arch/openrisc/lib/Makefile                |  2 +-
 arch/openrisc/mm/fault.c                  |  2 +-
 10 files changed, 58 insertions(+), 40 deletions(-)
 create mode 100644 arch/openrisc/include/asm/setup.h
