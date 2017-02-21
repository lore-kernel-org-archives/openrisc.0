From: Stafford Horne <shorne@gmail.com>
Date: Wed, 22 Feb 2017 04:11:29 +0900
Subject: [OpenRISC] [PATCH v3 00/25] OpenRISC patches for 4.11 final call
Message-ID: <cover.1487702890.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

Changes from v2
 o implemented all atomic ops pointed out by Peter Z
 o export ioremap symbols pointed out by allyesconfig
 o init r0 to 0 as per openrisc spec, suggested by Jakob Viketoft

Changes from v1
 o added change set from Valentin catching CONFIG issues
 o added missing test_and_change_bit atomic bitops patch

This is a attempt to get some final comments before I send the pull request
for this merge windot to Linus.  This comes up due to last minute findings
by Peter Zijlstra with the atomic operations patch.  If I get a bunch of
Nak's I will likely just skip this merge window, but lets hope that can be
avoided.

Any feedback is appreciated.

The interesting things here are:
 - optimized memset and memcpy routines, ~20% boot time saving
 - support for cpu idling
 - adding support for l.swa and l.lwa atomic operations (in spec from 2014)
 - use atomics to implement: bitops, cmpxchg, futex, spinlocks
 - the atomics are in preparation for SMP support

Testing:
I have used the kselftests to validate the changes especially the futex
operations with the futex test. Other atomic operations are common so no
explicit testing.  I have mainly done the tests on qemu.

Note for testers:
The l.swa and l.lwa emulation + native instruction support is NOW FIXED in
qemu upstream git.

I have send patches for get a recent openrisc toolchain added to the
lkp-tests make.cross script.  It should be up to date now I believe 
this is what most build sytems use. Let me know if different.

-Stafford


Jonas Bonn (1):
  openrisc: use SPARSE_IRQ

Olof Kindgren (1):
  openrisc: Add optimized memset

Sebastian Macke (2):
  openrisc: Fix the bitmask for the unit present register
  openrisc: Initial support for the idle state

Stafford Horne (9):
  openrisc: Add optimized memcpy routine
  openrisc: Add .gitignore
  MAINTAINERS: Add the openrisc official repository
  scripts/checkstack.pl: Add openrisc support
  openrisc: entry: Whitespace and comment cleanups
  openrisc: entry: Fix delay slot detection
  openrisc: head: Move init strings to rodata section
  openrisc: Export ioremap symbols used by modules
  openrisc: head: Init r0 to 0 on start

Stefan Kristiansson (11):
  openrisc: add cache way information to cpuinfo
  openrisc: tlb miss handler optimizations
  openrisc: head: use THREAD_SIZE instead of magic constant
  openrisc: head: refactor out tlb flush into it's own function
  openrisc: add l.lwa/l.swa emulation
  openrisc: add atomic bitops
  openrisc: add cmpxchg and xchg implementations
  openrisc: add optimized atomic operations
  openrisc: add spinlock implementation
  openrisc: add futex_atomic_* implementations
  openrisc: remove unnecessary stddef.h include

Valentin Rothberg (1):
  arch/openrisc/lib/memcpy.c: use correct OR1200 option

 MAINTAINERS                                |   1 +
 arch/openrisc/Kconfig                      |   1 +
 arch/openrisc/TODO.openrisc                |   1 -
 arch/openrisc/include/asm/Kbuild           |   5 +-
 arch/openrisc/include/asm/atomic.h         | 100 +++++++++++++
 arch/openrisc/include/asm/bitops.h         |   2 +-
 arch/openrisc/include/asm/bitops/atomic.h  | 123 +++++++++++++++
 arch/openrisc/include/asm/cmpxchg.h        |  82 ++++++++++
 arch/openrisc/include/asm/cpuinfo.h        |   2 +
 arch/openrisc/include/asm/futex.h          | 135 +++++++++++++++++
 arch/openrisc/include/asm/spinlock.h       | 232 ++++++++++++++++++++++++++++-
 arch/openrisc/include/asm/spinlock_types.h |  28 ++++
 arch/openrisc/include/asm/spr_defs.h       |   4 +-
 arch/openrisc/include/asm/string.h         |  10 ++
 arch/openrisc/kernel/.gitignore            |   1 +
 arch/openrisc/kernel/entry.S               |  60 +++++---
 arch/openrisc/kernel/head.S                | 200 ++++++++++---------------
 arch/openrisc/kernel/or32_ksyms.c          |   1 +
 arch/openrisc/kernel/process.c             |  17 +++
 arch/openrisc/kernel/ptrace.c              |   1 -
 arch/openrisc/kernel/setup.c               |  67 +++++----
 arch/openrisc/kernel/traps.c               | 183 +++++++++++++++++++++++
 arch/openrisc/lib/Makefile                 |   2 +-
 arch/openrisc/lib/memcpy.c                 | 124 +++++++++++++++
 arch/openrisc/lib/memset.S                 |  98 ++++++++++++
 arch/openrisc/mm/ioremap.c                 |   2 +
 scripts/checkstack.pl                      |   3 +
 27 files changed, 1297 insertions(+), 188 deletions(-)
 create mode 100644 arch/openrisc/include/asm/atomic.h
 create mode 100644 arch/openrisc/include/asm/bitops/atomic.h
 create mode 100644 arch/openrisc/include/asm/cmpxchg.h
 create mode 100644 arch/openrisc/include/asm/futex.h
 create mode 100644 arch/openrisc/include/asm/spinlock_types.h
 create mode 100644 arch/openrisc/include/asm/string.h
 create mode 100644 arch/openrisc/kernel/.gitignore
 create mode 100644 arch/openrisc/lib/memcpy.c
 create mode 100644 arch/openrisc/lib/memset.S

-- 
2.9.3

