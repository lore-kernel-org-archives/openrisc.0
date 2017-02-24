From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Feb 2017 08:29:50 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for 4.11 merge
Message-ID: <20170224232950.GW2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

(notes there may me minor conflicts for this merge, if its anything bad
let me know)
 - scripts/checkstack.pl - nios and openrisc seem to have came in at the
   same time
 - arch/openrisc/include/asm/Kbuild - Ingo's PULL of the cputime changes
   removed headers in the same place

Please cosider the below, highlights include:
 - optimized memset and memcpy routines, ~20% boot time saving
 - support for cpu idling
 - adding support for l.swa and l.lwa atomic operations (in spec from
   2014)
 - use atomics to implement: bitops, cmpxchg, futex
 - the atomics are in preparation for SMP support



The following changes since commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c:

  Linux 4.10-rc7 (2017-02-05 15:10:58 -0800)

are available in the git repository at:

  https://github.com/openrisc/linux.git tags/openrisc-for-linus

for you to fetch changes up to a4d4426635804379d618dd28e29f574a2bc11184:

  openrisc: head: Init r0 to 0 on start (2017-02-25 05:08:47 +0900)

----------------------------------------------------------------
OpenRISC updates for 4.11

----------------------------------------------------------------
Jonas Bonn (1):
      openrisc: use SPARSE_IRQ

Olof Kindgren (1):
      openrisc: Add optimized memset

Sebastian Macke (2):
      openrisc: Fix the bitmask for the unit present register
      openrisc: Initial support for the idle state

Stafford Horne (10):
      openrisc: Add optimized memcpy routine
      openrisc: Add .gitignore
      MAINTAINERS: Add the openrisc official repository
      scripts/checkstack.pl: Add openrisc support
      openrisc: entry: Whitespace and comment cleanups
      openrisc: entry: Fix delay slot detection
      openrisc: head: Move init strings to rodata section
      openrisc: head: Remove unused strings
      openrisc: Export ioremap symbols used by modules
      openrisc: head: Init r0 to 0 on start

Stefan Kristiansson (10):
      openrisc: add cache way information to cpuinfo
      openrisc: tlb miss handler optimizations
      openrisc: head: use THREAD_SIZE instead of magic constant
      openrisc: head: refactor out tlb flush into it's own function
      openrisc: add l.lwa/l.swa emulation
      openrisc: add atomic bitops
      openrisc: add cmpxchg and xchg implementations
      openrisc: add optimized atomic operations
      openrisc: add futex_atomic_* implementations
      openrisc: remove unnecessary stddef.h include

Valentin Rothberg (1):
      arch/openrisc/lib/memcpy.c: use correct OR1200 option

 MAINTAINERS                               |   1 +
 arch/openrisc/Kconfig                     |   1 +
 arch/openrisc/TODO.openrisc               |   1 -
 arch/openrisc/include/asm/Kbuild          |   5 +-
 arch/openrisc/include/asm/atomic.h        | 126 +++++++++++++++++++
 arch/openrisc/include/asm/bitops.h        |   2 +-
 arch/openrisc/include/asm/bitops/atomic.h | 123 ++++++++++++++++++
 arch/openrisc/include/asm/cmpxchg.h       |  83 +++++++++++++
 arch/openrisc/include/asm/cpuinfo.h       |   2 +
 arch/openrisc/include/asm/futex.h         | 135 ++++++++++++++++++++
 arch/openrisc/include/asm/spr_defs.h      |   4 +-
 arch/openrisc/include/asm/string.h        |  10 ++
 arch/openrisc/kernel/.gitignore           |   1 +
 arch/openrisc/kernel/entry.S              |  60 +++++----
 arch/openrisc/kernel/head.S               | 200 ++++++++++++------------------
 arch/openrisc/kernel/or32_ksyms.c         |   1 +
 arch/openrisc/kernel/process.c            |  14 +++
 arch/openrisc/kernel/ptrace.c             |   1 -
 arch/openrisc/kernel/setup.c              |  67 +++++-----
 arch/openrisc/kernel/traps.c              | 183 +++++++++++++++++++++++++++
 arch/openrisc/lib/Makefile                |   2 +-
 arch/openrisc/lib/memcpy.c                | 124 ++++++++++++++++++
 arch/openrisc/lib/memset.S                |  98 +++++++++++++++
 arch/openrisc/mm/ioremap.c                |   2 +
 include/asm-generic/atomic.h              |   2 +
 scripts/checkstack.pl                     |   3 +
 26 files changed, 1064 insertions(+), 187 deletions(-)
 create mode 100644 arch/openrisc/include/asm/atomic.h
 create mode 100644 arch/openrisc/include/asm/bitops/atomic.h
 create mode 100644 arch/openrisc/include/asm/cmpxchg.h
 create mode 100644 arch/openrisc/include/asm/futex.h
 create mode 100644 arch/openrisc/include/asm/string.h
 create mode 100644 arch/openrisc/kernel/.gitignore
 create mode 100644 arch/openrisc/lib/memcpy.c
 create mode 100644 arch/openrisc/lib/memset.S
