From: Calvin Zhang <calvinzhang.cool@gmail.com>
Date: Fri, 19 Nov 2021 15:58:17 +0800
Subject: [OpenRISC] [PATCH 0/2] of: remove reserved regions count restriction
Message-ID: <20211119075844.2902592-1-calvinzhang.cool@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The count of reserved regions in /reserved-memory was limited because
the struct reserved_mem array was defined statically. This series sorts
out reserved memory code and allocates that array from early allocator.

Note: reserved region with fixed location must be reserved before any
memory allocation. While struct reserved_mem array should be allocated
after allocator is activated. We make early_init_fdt_scan_reserved_mem()
do reservation only and add another call to initialize reserved memory.
So arch code have to change for it.

I'm only familiar with arm and arm64 architectures. Approvals from arch
maintainers are required. Thank you all.

Calvin Zhang (2):
  of: Sort reserved_mem related code
  of: reserved_mem: Remove reserved regions count restriction

 arch/arc/mm/init.c                 |   3 +
 arch/arm/kernel/setup.c            |   2 +
 arch/arm64/kernel/setup.c          |   3 +
 arch/csky/kernel/setup.c           |   3 +
 arch/h8300/kernel/setup.c          |   2 +
 arch/mips/kernel/setup.c           |   3 +
 arch/nds32/kernel/setup.c          |   3 +
 arch/nios2/kernel/setup.c          |   2 +
 arch/openrisc/kernel/setup.c       |   3 +
 arch/powerpc/kernel/setup-common.c |   3 +
 arch/riscv/kernel/setup.c          |   2 +
 arch/sh/kernel/setup.c             |   3 +
 arch/xtensa/kernel/setup.c         |   2 +
 drivers/of/fdt.c                   | 107 +---------------
 drivers/of/of_private.h            |  12 +-
 drivers/of/of_reserved_mem.c       | 189 ++++++++++++++++++++++++-----
 include/linux/of_reserved_mem.h    |   4 +
 17 files changed, 207 insertions(+), 139 deletions(-)

-- 
2.30.2

