From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 08:07:57 +0900
Subject: [OpenRISC] [PATCH 00/22] Openrisc patchees from backlog for 4.11
Message-ID: <cover.1484432596.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

This is another set of patches which I have been pulling out of the
openrisc backlogs. Its a bit of a process since I need to cleanup commit
messages, review and test the patches.

The interesting things here are:
 - optimized memset and memcpy routines, ~20% boot time saving
 - support for cpu idling
 - adding support for l.swa and l.lwa atomic operations (in spec from 2014)
 - use atomics to implement: bitops, cmpxchg, futex, spinlocks
 - the atomics are in preparation for SMP support

Testing:
I have used the kselftests to validate the changes especially the futex
operations with the futex test. Other atomic operations are common so no
explicit testing.

Note for testers:
The l.swa and l.lwa emulation is broken in qemu openrisc port. I have sent
patches [1] to qemu-devel to fix the qemu issues.

 [1] lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02764.html

Jonas Bonn (1):
  openrisc: use SPARSE_IRQ

Olof Kindgren (1):
  openrisc: Add optimized memset

Sebastian Macke (2):
  openrisc: Fix the bitmask for the unit present register
  openrisc: Initial support for the idle state

Stafford Horne (7):
  openrisc: Add optimized memcpy routine
  openrisc: Add .gitignore
  MAINTAINERS: Add the openrisc official repository
  scripts/checkstack.pl: Add openrisc support
  openrisc: entry: Whitespace and comment cleanups
  openrisc: entry: Fix delay slot detection
  openrisc: head: Move init strings to rodata section

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

 MAINTAINERS                                |   1 +
 arch/openrisc/Kconfig                      |   1 +
 arch/openrisc/TODO.openrisc                |   1 -
 arch/openrisc/include/asm/Kbuild           |   5 +-
 arch/openrisc/include/asm/atomic.h         |  53 +++++++
 arch/openrisc/include/asm/bitops.h         |   2 +-
 arch/openrisc/include/asm/bitops/atomic.h  | 103 +++++++++++++
 arch/openrisc/include/asm/cmpxchg.h        |  82 ++++++++++
 arch/openrisc/include/asm/cpuinfo.h        |   2 +
 arch/openrisc/include/asm/futex.h          | 135 +++++++++++++++++
 arch/openrisc/include/asm/spinlock.h       | 232 ++++++++++++++++++++++++++++-
 arch/openrisc/include/asm/spinlock_types.h |  28 ++++
 arch/openrisc/include/asm/spr_defs.h       |   4 +-
 arch/openrisc/include/asm/string.h         |  10 ++
 arch/openrisc/kernel/.gitignore            |   1 +
 arch/openrisc/kernel/entry.S               |  60 +++++---
 arch/openrisc/kernel/head.S                | 195 +++++++++---------------
 arch/openrisc/kernel/or32_ksyms.c          |   1 +
 arch/openrisc/kernel/process.c             |  17 +++
 arch/openrisc/kernel/ptrace.c              |   1 -
 arch/openrisc/kernel/setup.c               |  67 +++++----
 arch/openrisc/kernel/traps.c               | 183 +++++++++++++++++++++++
 arch/openrisc/lib/Makefile                 |   2 +-
 arch/openrisc/lib/memcpy.c                 | 124 +++++++++++++++
 arch/openrisc/lib/memset.S                 |  98 ++++++++++++
 scripts/checkstack.pl                      |   3 +
 26 files changed, 1224 insertions(+), 187 deletions(-)
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

