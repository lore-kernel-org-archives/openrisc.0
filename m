From: Stafford Horne <shorne@gmail.com>
Date: Sat, 27 Feb 2021 06:56:19 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for 5.12
Message-ID: <20210226215619.GC365039@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull.

Note the starting point shows up a bit strange as I had to merge in 5.11 fixes
to resolve some conflicts pointed out by linux-next.  The below are the changes
since v5.11.

The following changes since commit 031c7a8cd6fc565e90320bf08f22ee6e70f9d969:

  openrisc: io: Add missing __iomem annotation to iounmap() (2021-01-20 06:14:26 +0900)

are available in the Git repository at:

  git at github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 8f722f67452f4b28cd8d7acf1658daa5796437c2:

  openrisc: Use devicetree to determine present cpus (2021-02-09 05:38:50 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.12

Include:
 - Update for Litex SoC controller to support wider width registers as
   well as reset.
 - Refactor SMP code to use device tree to define possible cpus.
 - Updates build including generating vmlinux.bin

----------------------------------------------------------------
Gabriel Somlo (5):
      drivers/soc/litex: move generic accessors to litex.h
      drivers/soc/litex: separate MMIO from subregister offset calculation
      drivers/soc/litex: s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g
      drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
      drivers/soc/litex: make 'litex_[set|get]_reg()' methods private

Geert Uytterhoeven (1):
      drivers/soc/litex: Add restart handler

Jan Henrik Weinstock (1):
      openrisc: Use devicetree to determine present cpus

Joel Stanley (2):
      openrisc: Add vmlinux.bin target
      openrisc: restart: Call common handlers before hanging

Masahiro Yamada (1):
      openrisc: add arch/openrisc/Kbuild

Stafford Horne (1):
      Merge remote-tracking branch 'openrisc/or1k-5.11-fixes' into or1k-5.12-updates

 arch/openrisc/Kbuild               |   3 +
 arch/openrisc/Makefile             |  21 +++---
 arch/openrisc/boot/.gitignore      |   2 +
 arch/openrisc/boot/Makefile        |  10 +++
 arch/openrisc/kernel/process.c     |  13 +++-
 arch/openrisc/kernel/smp.c         |  23 ++++--
 drivers/soc/litex/Kconfig          |  14 +++-
 drivers/soc/litex/litex_soc_ctrl.c | 116 +++++++++++-----------------
 include/linux/litex.h              | 150 +++++++++++++++++++++++++------------
 9 files changed, 211 insertions(+), 141 deletions(-)
 create mode 100644 arch/openrisc/Kbuild
 create mode 100644 arch/openrisc/boot/.gitignore
 create mode 100644 arch/openrisc/boot/Makefile
