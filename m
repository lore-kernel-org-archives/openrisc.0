From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 16 Feb 2022 14:13:14 +0100
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
Message-ID: <20220216131332.1489939-1-arnd@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann <arnd@arndb.de>

Christoph Hellwig and a few others spent a huge effort on removing
set_fs() from most of the important architectures, but about half the
other architectures were never completed even though most of them don't
actually use set_fs() at all.

I did a patch for microblaze at some point, which turned out to be fairly
generic, and now ported it to most other architectures, using new generic
implementations of access_ok() and __{get,put}_kernel_nocheck().

Three architectures (sparc64, ia64, and sh) needed some extra work,
which I also completed.

The final series contains extra cleanup changes that touch all
architectures. Please review and test these, so we can merge them
for v5.18.

The series is available at
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs-2
for testing.

Changes in v2:
 - add fixes for more nios2 and microblaze bugs found in the process
 - do final cleanup in a single patch
 - fix sparc64 regression
 - introduce CONFIG_ALTERNATE_USER_ADDRESS_SPACE
 - fix access_ok() in lib/test_lockup.c

Arnd Bergmann (18):
  uaccess: fix integer overflow on access_ok()
  uaccess: fix nios2 and microblaze get_user_8()
  nds32: fix access_ok() checks in get/put_user
  sparc64: add __{get,put}_kernel_nocheck()
  x86: remove __range_not_ok()
  x86: use more conventional access_ok() definition
  nios2: drop access_ok() check from __put_user()
  uaccess: add generic __{get,put}_kernel_nofault
  mips: use simpler access_ok()
  m68k: fix access_ok for coldfire
  arm64: simplify access_ok()
  uaccess: fix type mismatch warnings from access_ok()
  uaccess: generalize access_ok()
  lib/test_lockup: fix kernel pointer check for separate address spaces
  sparc64: remove CONFIG_SET_FS support
  sh: remove CONFIG_SET_FS support
  ia64: remove CONFIG_SET_FS support
  uaccess: drop maining CONFIG_SET_FS users

 arch/Kconfig                              |  10 +-
 arch/alpha/Kconfig                        |   1 -
 arch/alpha/include/asm/processor.h        |   4 -
 arch/alpha/include/asm/thread_info.h      |   2 -
 arch/alpha/include/asm/uaccess.h          |  53 +---------
 arch/arc/Kconfig                          |   1 -
 arch/arc/include/asm/segment.h            |  20 ----
 arch/arc/include/asm/thread_info.h        |   3 -
 arch/arc/include/asm/uaccess.h            |  30 ------
 arch/arc/kernel/process.c                 |   2 +-
 arch/arm/include/asm/uaccess.h            |  22 +---
 arch/arm/kernel/swp_emulate.c             |   2 +-
 arch/arm/kernel/traps.c                   |   2 +-
 arch/arm/lib/uaccess_with_memcpy.c        |  10 --
 arch/arm64/include/asm/uaccess.h          |  29 +-----
 arch/csky/Kconfig                         |   1 -
 arch/csky/include/asm/processor.h         |   2 -
 arch/csky/include/asm/segment.h           |  10 --
 arch/csky/include/asm/thread_info.h       |   2 -
 arch/csky/include/asm/uaccess.h           |  12 ---
 arch/csky/kernel/asm-offsets.c            |   1 -
 arch/csky/kernel/signal.c                 |   2 +-
 arch/h8300/Kconfig                        |   1 -
 arch/h8300/include/asm/processor.h        |   1 -
 arch/h8300/include/asm/segment.h          |  40 --------
 arch/h8300/include/asm/thread_info.h      |   3 -
 arch/h8300/kernel/entry.S                 |   1 -
 arch/h8300/kernel/head_ram.S              |   1 -
 arch/h8300/mm/init.c                      |   6 --
 arch/h8300/mm/memory.c                    |   1 -
 arch/hexagon/Kconfig                      |   1 -
 arch/hexagon/include/asm/thread_info.h    |   6 --
 arch/hexagon/include/asm/uaccess.h        |  25 -----
 arch/hexagon/kernel/process.c             |   1 -
 arch/ia64/Kconfig                         |   1 -
 arch/ia64/include/asm/processor.h         |   4 -
 arch/ia64/include/asm/thread_info.h       |   2 -
 arch/ia64/include/asm/uaccess.h           |  26 ++---
 arch/ia64/kernel/unaligned.c              |  60 +++++++----
 arch/m68k/Kconfig.cpu                     |   1 +
 arch/m68k/include/asm/uaccess.h           |  14 +--
 arch/microblaze/Kconfig                   |   1 -
 arch/microblaze/include/asm/thread_info.h |   6 --
 arch/microblaze/include/asm/uaccess.h     |  61 ++---------
 arch/microblaze/kernel/asm-offsets.c      |   1 -
 arch/microblaze/kernel/process.c          |   1 -
 arch/mips/include/asm/uaccess.h           |  49 +--------
 arch/mips/sibyte/common/sb_tbprof.c       |   6 +-
 arch/nds32/Kconfig                        |   1 -
 arch/nds32/include/asm/thread_info.h      |   4 -
 arch/nds32/include/asm/uaccess.h          |  40 ++++----
 arch/nds32/kernel/process.c               |   5 +-
 arch/nds32/mm/alignment.c                 |   3 -
 arch/nios2/Kconfig                        |   1 -
 arch/nios2/include/asm/thread_info.h      |   9 --
 arch/nios2/include/asm/uaccess.h          | 105 +++++++++----------
 arch/nios2/kernel/signal.c                |  20 ++--
 arch/openrisc/Kconfig                     |   1 -
 arch/openrisc/include/asm/thread_info.h   |   7 --
 arch/openrisc/include/asm/uaccess.h       |  42 +-------
 arch/parisc/Kconfig                       |   1 +
 arch/parisc/include/asm/futex.h           |   6 --
 arch/parisc/include/asm/uaccess.h         |  13 +--
 arch/parisc/lib/memcpy.c                  |   2 +-
 arch/powerpc/include/asm/uaccess.h        |  13 +--
 arch/powerpc/lib/sstep.c                  |   4 +-
 arch/riscv/include/asm/uaccess.h          |  33 +-----
 arch/riscv/kernel/perf_callchain.c        |   2 +-
 arch/s390/Kconfig                         |   1 +
 arch/s390/include/asm/uaccess.h           |  16 +--
 arch/sh/Kconfig                           |   1 -
 arch/sh/include/asm/processor.h           |   1 -
 arch/sh/include/asm/segment.h             |  33 ------
 arch/sh/include/asm/thread_info.h         |   2 -
 arch/sh/include/asm/uaccess.h             |  24 +----
 arch/sh/kernel/io_trapped.c               |   9 +-
 arch/sh/kernel/process_32.c               |   2 -
 arch/sh/kernel/traps_32.c                 |  30 ++++--
 arch/sparc/Kconfig                        |   3 +-
 arch/sparc/include/asm/processor_32.h     |   6 --
 arch/sparc/include/asm/processor_64.h     |   4 -
 arch/sparc/include/asm/switch_to_64.h     |   4 +-
 arch/sparc/include/asm/thread_info_64.h   |   4 +-
 arch/sparc/include/asm/uaccess.h          |   3 -
 arch/sparc/include/asm/uaccess_32.h       |  31 +-----
 arch/sparc/include/asm/uaccess_64.h       | 113 +++++++++++++-------
 arch/sparc/kernel/process_32.c            |   2 -
 arch/sparc/kernel/process_64.c            |  12 ---
 arch/sparc/kernel/signal_32.c             |   2 +-
 arch/sparc/kernel/traps_64.c              |   2 -
 arch/sparc/lib/NGmemcpy.S                 |   3 +-
 arch/sparc/mm/init_64.c                   |   7 +-
 arch/um/include/asm/uaccess.h             |   7 +-
 arch/x86/events/core.c                    |   2 +-
 arch/x86/include/asm/uaccess.h            |  35 +------
 arch/x86/kernel/dumpstack.c               |   2 +-
 arch/x86/kernel/stacktrace.c              |   2 +-
 arch/x86/lib/usercopy.c                   |   2 +-
 arch/xtensa/Kconfig                       |   1 -
 arch/xtensa/include/asm/asm-uaccess.h     |  71 -------------
 arch/xtensa/include/asm/processor.h       |   7 --
 arch/xtensa/include/asm/thread_info.h     |   3 -
 arch/xtensa/include/asm/uaccess.h         |  26 +----
 arch/xtensa/kernel/asm-offsets.c          |   3 -
 drivers/hid/uhid.c                        |   2 +-
 drivers/scsi/sg.c                         |   5 -
 fs/exec.c                                 |   6 --
 include/asm-generic/access_ok.h           |  51 ++++++++++
 include/asm-generic/uaccess.h             |  46 +--------
 include/linux/syscalls.h                  |   4 -
 include/linux/uaccess.h                   |  59 ++++-------
 include/rdma/ib.h                         |   2 +-
 kernel/events/callchain.c                 |   4 -
 kernel/events/core.c                      |   3 -
 kernel/exit.c                             |  14 ---
 kernel/kthread.c                          |   5 -
 kernel/stacktrace.c                       |   3 -
 kernel/trace/bpf_trace.c                  |   4 -
 lib/test_lockup.c                         |  11 +-
 mm/maccess.c                              | 119 ----------------------
 mm/memory.c                               |   8 --
 net/bpfilter/bpfilter_kern.c              |   2 +-
 122 files changed, 387 insertions(+), 1290 deletions(-)
 delete mode 100644 arch/arc/include/asm/segment.h
 delete mode 100644 arch/csky/include/asm/segment.h
 delete mode 100644 arch/h8300/include/asm/segment.h
 delete mode 100644 arch/sh/include/asm/segment.h
 create mode 100644 include/asm-generic/access_ok.h

-- 
2.29.2

Cc: linux at armlinux.org.uk
Cc: will at kernel.org
Cc: guoren at kernel.org
Cc: bcain at codeaurora.org
Cc: geert at linux-m68k.org
Cc: monstr at monstr.eu
Cc: tsbogend at alpha.franken.de
Cc: nickhu at andestech.com
Cc: green.hu at gmail.com
Cc: dinguyen at kernel.org
Cc: shorne at gmail.com
Cc: deller at gmx.de
Cc: mpe at ellerman.id.au
Cc: peterz at infradead.org
Cc: mingo at redhat.com
Cc: mark.rutland at arm.com
Cc: hca at linux.ibm.com
Cc: dalias at libc.org
Cc: davem at davemloft.net
Cc: richard at nod.at
Cc: x86 at kernel.org
Cc: jcmvbkbc at gmail.com
Cc: ebiederm at xmission.com
Cc: arnd at arndb.de
Cc: akpm at linux-foundation.org
Cc: ardb at kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-alpha at vger.kernel.org
Cc: linux-snps-arc at lists.infradead.org
Cc: linux-csky at vger.kernel.org
Cc: linux-hexagon at vger.kernel.org
Cc: linux-ia64 at vger.kernel.org
Cc: linux-m68k at lists.linux-m68k.org
Cc: linux-mips at vger.kernel.org
Cc: openrisc at lists.librecores.org
Cc: linux-parisc at vger.kernel.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-riscv at lists.infradead.org
Cc: linux-s390 at vger.kernel.org
Cc: linux-sh at vger.kernel.org
Cc: sparclinux at vger.kernel.org
Cc: linux-um at lists.infradead.org
Cc: linux-xtensa at linux-xtensa.org
Cc: linux-arch at vger.kernel.org
Cc: linux-mm at kvack.org
