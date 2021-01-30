From: Stafford Horne <shorne@gmail.com>
Date: Sun, 31 Jan 2021 07:44:42 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC fixes for 5.11-rc6
Message-ID: <20210130224442.GB2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull:

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 1bea2a937dadd188de70198b0cf3915e05a506e4:

  soc: litex: Properly depend on HAS_IOMEM (2021-01-30 06:36:10 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.11-rc6

Fixes include:
 * Fix config dependencies for Litex SOC driver causing issues on um

----------------------------------------------------------------
David Gow (1):
      soc: litex: Properly depend on HAS_IOMEM

 drivers/soc/litex/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-Stafford
