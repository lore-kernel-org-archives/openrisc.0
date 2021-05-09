From: Mike Rapoport <rppt@kernel.org>
Date: Sun,  9 May 2021 12:11:01 +0300
Subject: [OpenRISC] [PATCH 0/2] openrisc: mm/init.c: fix compilation warnings
Message-ID: <20210509091103.7985-1-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Kbuld test bot reported an unused in map_ram() and while on it I've found
another compilation warning about unused variable in paging_init().

Here are the fixes for both.
The patches are vs 5.12.

Mike Rapoport (2):
  openrisc: mm/init.c: remove unused memblock_region variable in map_ram()
  openrisc: mm/init.c: remove unused variable 'end' in paging_init()

 arch/openrisc/mm/init.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)


base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.28.0

