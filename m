From: Stafford Horne <shorne@gmail.com>
Date: Fri, 15 May 2020 06:00:10 +0900
Subject: [OpenRISC] [PATCH 0/8] OpenRISC BFD fixups for Glibc
Message-ID: <20200514210018.2749462-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

I am currently working on the glibc port for openrisc and during testing
the glibc testsuite we uncovered several issues with the OpenRISC bfd
implementation relating to TLS relocations.  This series fixes them all.

-Stafford

Stafford Horne (8):
  or1k: Fix static linking when with .rela.got relocations
  or1k: Fix dynamic TLS symbol flag
  or1k: Add TLS mask to handle multiple model access
  or1k: Fix issue with multiple PCREL relocations
  or1k: TLS offset to use tcb size and section alignment
  or1k: refactor: Rename p to sec_relocs
  or1k: refactor: Rename s to sgot and splt
  or1k: Add dynamic flag to tpoff

 bfd/elf32-or1k.c | 368 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 236 insertions(+), 132 deletions(-)

-- 
2.26.2

