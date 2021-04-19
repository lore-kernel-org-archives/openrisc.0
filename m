From: Stafford Horne <shorne@gmail.com>
Date: Mon, 19 Apr 2021 09:05:20 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC large binary fixes
Message-ID: <20210419000524.3625897-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

These are several fixes to OpenRISC BFD to handle issues mostly related to
linking large files.

There will be a GCC patch then depends on this, a new -mcmodel=large argument is
added to GCC to allow creating GOT relocation values larger than 64k.

The series fixes 3 issues:

 * PR 27624 - Assertion failure when dynamic symol is localized
 * PR 21464 - GOT relocation truncation.
 * PR 27746 - Issue with silent overlows in PLT code.

Stafford Horne (4):
  or1k: Fix issue with plt link failure for local calls
  or1k: Implement relocation R_OR1K_GOT_AHI16 for gotha()
  or1k: Support cmodel=large when generating plt code
  or1k: Fail link if the PLT relocation overflows

 bfd/bfd-in2.h                     |   1 +
 bfd/elf32-or1k.c                  | 182 ++++++++++++++++++++++--------
 bfd/libbfd.h                      |   1 +
 bfd/reloc.c                       |   2 +
 cpu/or1k.opc                      |   7 +-
 gas/testsuite/gas/or1k/reloc-1.d  |   4 +-
 gas/testsuite/gas/or1k/reloc-1.s  |   4 +
 include/elf/or1k.h                |   1 +
 ld/testsuite/ld-or1k/or1k.exp     |   8 ++
 ld/testsuite/ld-or1k/pltlarge1.dd |  38 +++++++
 ld/testsuite/ld-or1k/pltlarge1.s  |  24 ++++
 ld/testsuite/ld-or1k/pltlarge2.dd |  39 +++++++
 ld/testsuite/ld-or1k/pltlarge2.s  |  25 ++++
 ld/testsuite/ld-or1k/pltlib.s     |   1 +
 opcodes/or1k-asm.c                |   7 +-
 15 files changed, 296 insertions(+), 48 deletions(-)
 create mode 100644 ld/testsuite/ld-or1k/pltlarge1.dd
 create mode 100644 ld/testsuite/ld-or1k/pltlarge1.s
 create mode 100644 ld/testsuite/ld-or1k/pltlarge2.dd
 create mode 100644 ld/testsuite/ld-or1k/pltlarge2.s

-- 
2.26.2

