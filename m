From: Stafford Horne <shorne@gmail.com>
Date: Tue, 21 Aug 2018 23:38:19 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
Message-ID: <20180821143823.16985-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This series contains a lot of updates for OpenRISC binutils.  Including:
  - Definitions for missing instructions.
  - New relocations used in the new GCC OpenRISC port
  - A new instruction l.adrp

The patches were for the most part written by Richard Henderson, I have fixed a
few bugs, added additional tests and wrote the ChangeLogs.

These patches have been tested and used in the new OpenRISC GCC clean-room
rewrite done by Richard and Me.

  http://stffrdhrn.github.io/software/embedded/openrisc/2018/02/03/openrisc_gcc_rewrite.html

-Stafford

Richard Henderson (2):
  or1k: Add relocations for high-signed and low-stores
  or1k: Add the l.muld, l.muldu, l.macu, l.msbu insns

Stafford Horne (2):
  or1k: Fix messages for relocations in shared libraries
  or1k: Add the l.adrp insn and supporting relocations

 bfd/bfd-in2.h                                 |   19 +-
 bfd/elf32-or1k.c                              | 1002 +++++++++++++----
 bfd/libbfd.h                                  |   19 +-
 bfd/reloc.c                                   |   34 +-
 cpu/or1k.opc                                  |  582 +++++-----
 cpu/or1korbis.cpu                             |  300 +++--
 gas/config/tc-or1k.c                          |    6 +
 gas/testsuite/gas/or1k/allinsn.d              |   50 +-
 gas/testsuite/gas/or1k/allinsn.s              |   25 +
 .../gas/or1k/{allinsn.exp => or1k.exp}        |    1 +
 gas/testsuite/gas/or1k/reloc-1.d              |   72 ++
 gas/testsuite/gas/or1k/reloc-1.s              |   76 ++
 gas/testsuite/gas/or1k/reloc-2.l              |   11 +
 gas/testsuite/gas/or1k/reloc-2.s              |   13 +
 include/elf/or1k.h                            |   19 +
 ld/testsuite/ld-or1k/offsets1.d               |  212 ++++
 ld/testsuite/ld-or1k/offsets1.s               |   14 +
 ld/testsuite/ld-or1k/or1k.exp                 |   91 ++
 ld/testsuite/ld-or1k/plt1.dd                  |   27 +
 ld/testsuite/ld-or1k/plt1.s                   |   11 +
 ld/testsuite/ld-or1k/plt1.x.dd                |   27 +
 ld/testsuite/ld-or1k/plta1.dd                 |   27 +
 ld/testsuite/ld-or1k/plta1.s                  |   11 +
 ld/testsuite/ld-or1k/pltlib.s                 |   12 +
 opcodes/or1k-asm.c                            |  587 +++++-----
 opcodes/or1k-desc.c                           |   34 +-
 opcodes/or1k-desc.h                           |   48 +-
 opcodes/or1k-dis.c                            |    3 +
 opcodes/or1k-ibld.c                           |   29 +-
 opcodes/or1k-opc.c                            |   44 +-
 opcodes/or1k-opc.h                            |   65 +-
 opcodes/or1k-opinst.c                         |   98 +-
 sim/common/cgen-ops.h                         |   36 +
 sim/or1k/cpu.h                                |   32 +
 sim/or1k/decode.c                             |  239 +++-
 sim/or1k/decode.h                             |   82 +-
 sim/or1k/model.c                              |  186 ++-
 sim/or1k/sem-switch.c                         |  281 ++++-
 sim/or1k/sem.c                                |  293 ++++-
 sim/testsuite/sim/or1k/div.S                  |   12 +-
 sim/testsuite/sim/or1k/mul.S                  |  109 +-
 41 files changed, 3643 insertions(+), 1196 deletions(-)
 rename gas/testsuite/gas/or1k/{allinsn.exp => or1k.exp} (83%)
 create mode 100644 gas/testsuite/gas/or1k/reloc-1.d
 create mode 100644 gas/testsuite/gas/or1k/reloc-1.s
 create mode 100644 gas/testsuite/gas/or1k/reloc-2.l
 create mode 100644 gas/testsuite/gas/or1k/reloc-2.s
 create mode 100644 ld/testsuite/ld-or1k/offsets1.d
 create mode 100644 ld/testsuite/ld-or1k/offsets1.s
 create mode 100644 ld/testsuite/ld-or1k/or1k.exp
 create mode 100644 ld/testsuite/ld-or1k/plt1.dd
 create mode 100644 ld/testsuite/ld-or1k/plt1.s
 create mode 100644 ld/testsuite/ld-or1k/plt1.x.dd
 create mode 100644 ld/testsuite/ld-or1k/plta1.dd
 create mode 100644 ld/testsuite/ld-or1k/plta1.s
 create mode 100644 ld/testsuite/ld-or1k/pltlib.s

-- 
2.17.1

