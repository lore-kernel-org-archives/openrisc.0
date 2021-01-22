From: Stafford Horne <shorne@gmail.com>
Date: Fri, 22 Jan 2021 09:29:02 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC fixes for 5.11
Message-ID: <20210122002902.GP2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull:

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 031c7a8cd6fc565e90320bf08f22ee6e70f9d969:

  openrisc: io: Add missing __iomem annotation to iounmap() (2021-01-20 06:14:26 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.11

Fixes include:
 * Compiler warning fixup for new Litex SoC driver
 * Sparse warning fixup for iounmap

----------------------------------------------------------------
Geert Uytterhoeven (1):
      openrisc: io: Add missing __iomem annotation to iounmap()

Stafford Horne (1):
      soc: litex: Fix compile warning when device tree is not configured

 arch/openrisc/include/asm/io.h     | 2 +-
 arch/openrisc/mm/ioremap.c         | 2 +-
 drivers/soc/litex/litex_soc_ctrl.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

-Stafford
