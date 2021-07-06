From: Stafford Horne <shorne@gmail.com>
Date: Tue, 6 Jul 2021 15:40:07 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for 5.14
Message-ID: <YOP6x0Mz8aBv9x18@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to ad4e600cbf897f47525b342cd4b02e88ed300a83:

  drivers/soc/litex: remove 8-bit subregister option (2021-06-11 04:35:40 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.14

One change to simplify Litex CSR (MMIO register) access by limiting them
to 32-bit offsets.  Now this is agreed among Litex hardware and kernel
developers it will allow us to start upstreaming other Litex peripheral
drivers.

----------------------------------------------------------------
Gabriel Somlo (1):
      drivers/soc/litex: remove 8-bit subregister option

 drivers/soc/litex/Kconfig          |  12 -----
 drivers/soc/litex/litex_soc_ctrl.c |   3 +-
 include/linux/litex.h              | 103 ++++++-------------------------------
 3 files changed, 16 insertions(+), 102 deletions(-)
