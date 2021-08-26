From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Aug 2021 22:59:43 +0930
Subject: [OpenRISC] [PATCH 0/3] openrisc/litex: Add liteeth support
Message-ID: <20210826132946.3324593-1-joel@jms.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Stafford,

Here are some changes so that the openrisc kernel can boot with ethernet
support with the in-tree device tree.

I have also updated the address of the serial device to match recent
litex. I realise this may keep changing, but it does make it easier to
test upstream kernels if the basics work.

Joel Stanley (3):
  openrisc/litex: Update uart address
  openrisc/litex: Add ethernet device
  openrisc/litex: Update defconfig

 arch/openrisc/boot/dts/or1klitex.dts      | 13 ++++++++++--
 arch/openrisc/configs/or1klitex_defconfig | 26 ++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.33.0

