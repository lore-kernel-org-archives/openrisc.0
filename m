From: Stafford Horne <shorne@gmail.com>
Date: Fri, 21 May 2021 16:16:52 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC fixes for 5.13
Message-ID: <YKdeZFKthTY31705@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 8b549c18ae81dbc36fb11e4aa08b8378c599ca95:

  openrisc: Define memory barrier mb (2021-05-15 16:00:10 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.13

A few fixes that came in around the time of the merge
window.

----------------------------------------------------------------
Christophe JAILLET (1):
      openrisc: Fix a memory leak

Mike Rapoport (2):
      openrisc: mm/init.c: remove unused memblock_region variable in map_ram()
      openrisc: mm/init.c: remove unused variable 'end' in paging_init()

Peter Zijlstra (1):
      openrisc: Define memory barrier mb

 arch/openrisc/include/asm/barrier.h | 9 +++++++++
 arch/openrisc/kernel/setup.c        | 2 ++
 arch/openrisc/mm/init.c             | 6 +-----
 3 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 arch/openrisc/include/asm/barrier.h
