From: Stafford Horne <shorne@gmail.com>
Date: Wed, 11 Dec 2019 06:49:04 +0900
Subject: [OpenRISC] [PATCH 0/2] OpenRISC Remove 64-bit support to fit 32-bit
 hosts (PR 25184)
Message-ID: <20191210214906.21465-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The issue was reported by Rich Felker, OpenRISC gas fails to calculate negative
offsets when running on 32-bit hosts.  I traced this back to having 64-bit
address space support in the CPU definitions.  It seems we could fix this by
either adding some fixes for cgen to support this case or by adding some custom
C to do the jump offset calculations.

However, realizing that OpenRISC 64-bit support is not tested, not used and no
hardware or simulators exist I am deciding removing it is easiest.

Stafford Horne (2):
  or1k: Remove 64-bit support, it's not used and it breaks 32-bit hosts
  or1k: Regnerate opcode files after removing 64-bit support

 cpu/or1k.cpu          |   35 +-
 cpu/or1kcommon.cpu    |   14 -
 cpu/or1korfpx.cpu     |   64 --
 opcodes/or1k-asm.c    |    9 -
 opcodes/or1k-desc.c   | 1811 +++++++++++++++++++----------------------
 opcodes/or1k-desc.h   |  332 ++++----
 opcodes/or1k-dis.c    |    9 -
 opcodes/or1k-ibld.c   |   60 +-
 opcodes/or1k-opc.c    |  152 ----
 opcodes/or1k-opc.h    |   28 +-
 opcodes/or1k-opinst.c |  428 +++++-----
 11 files changed, 1185 insertions(+), 1757 deletions(-)

-- 
2.21.0

