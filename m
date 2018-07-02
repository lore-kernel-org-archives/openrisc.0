From: Stafford Horne <shorne@gmail.com>
Date: Mon, 2 Jul 2018 23:12:44 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC fixes for 4.18
Message-ID: <20180702141244.GQ24595@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

I hope you enjoyed yourself in Japan, please consider for pull,


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://github.com/stffrdhrn/linux.git tags/for-linus

for you to fetch changes up to ae15a41a641449f536578b0d9ec0e4ade130deb5:

  openrisc: entry: Fix delay slot exception detection (2018-07-01 16:48:24 +0900)

----------------------------------------------------------------
OpenRISC fixes for 4.18

Two fixes here which were breaking OpenRISC boot.
 - Fix bug in __pte_free_tlb() exposed in 4.18 by Matthew Wilcox's page
   table flag addition.
 - Fix issue booting on real hardware if delay slot detection emulation
   is disabled.

----------------------------------------------------------------
Stafford Horne (2):
      openrisc: Call destructor during __pte_free_tlb
      openrisc: entry: Fix delay slot exception detection

 arch/openrisc/include/asm/pgalloc.h | 6 +++++-
 arch/openrisc/kernel/entry.S        | 8 +-------
 arch/openrisc/kernel/head.S         | 9 ++++++---
 arch/openrisc/kernel/traps.c        | 2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

-Stafford
