From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 06:58:31 +0900
Subject: [OpenRISC] [PATCH 00/13] OpenRISC SMP Support
Message-ID: <cover.1504129273.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This series adds SMP support for OpenRISC.  The OpenRISC multicore platform
and SMP Linux support is based on the work that Stefan Kristiansson did
around 2012. The platform was implemented in Verilog and run on FPGAs.  I
have been working to upstream this work. I have additionally tested this on
QEMU, which I patched for OpenRISC multicore support, as well as FPGA.

I have documented the architecture in the OpenRISC 1.2 specification
proposal available here:
  https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf

The QEMU patches are still under review but are available here for testers
and anyone interested:
  https://github.com/stffrdhrn/qemu.git openrisc-smp-v1

This series contains a bit of a mix of patches to get everything working.
 o First the "use shadow registers" and "define CPU_BIG_ENDIAN as true" get
   the architecture ready for SMP.
 o The "add 1 and 2 byte cmpxchg support" and "use qspinlocks and qrwlocks"
   add the SMP locking infrastructure as needed.  Using the qspinlocks and
   qrwlocks as suggested by Peter Z while reviewing the original spinlocks
   implementation which I posted to the list a few months back [0].
 o The "support for ompic" adds a new irqchip device which is used for IPI
   communication to support SMP.  (Perhaps this patch should go via another
   route but included here for completeness)
 o The "initial SMP support" adds smp.c and makes changes to all of the
   necessary data-structures to be per-cpu.
 o The remaining patches are bug fixes and debug helpers which I wanted
   to keep separate from the "initial SMP support" in order to allow them
   to be reviewed on their own. This includes:
    - add cacheflush support to fix icache aliasing
    - fix initial preempt state for secondary cpu tasks
    - sleep instead of spin on secondary wait
    - support framepointers and STACKTRACE_SUPPORT
    - enable LOCKDEP_SUPPORT and irqflags tracing
    - timer sync: Add tick timer sync logic


[0] https://lkml.org/lkml/2017/2/21/659

-Stafford



Jan Henrik Weinstock (1):
  openrisc: add cacheflush support to fix icache aliasing

Stafford Horne (8):
  openrisc: define CPU_BIG_ENDIAN as true
  openrisc: add 1 and 2 byte cmpxchg support
  openrisc: use qspinlocks and qrwlocks
  openrisc: fix initial preempt state for secondary cpu tasks
  openrisc: sleep instead of spin on secondary wait
  openrisc: support framepointers and STACKTRACE_SUPPORT
  openrisc: enable LOCKDEP_SUPPORT and irqflags tracing
  openrisc: add tick timer multicore sync logic

Stefan Kristiansson (4):
  openrisc: use shadow registers to save regs on exception
  irqchip: add initial support for ompic
  openrisc: initial SMP support
  openrisc: add simple_smp dts and defconfig for simulators

 .../bindings/interrupt-controller/ompic.txt        |  22 ++
 arch/openrisc/Kconfig                              |  51 +++-
 arch/openrisc/boot/dts/simple_smp.dts              |  58 +++++
 arch/openrisc/configs/simple_smp_defconfig         |  66 ++++++
 arch/openrisc/include/asm/Kbuild                   |   5 +-
 arch/openrisc/include/asm/cacheflush.h             |  96 ++++++++
 arch/openrisc/include/asm/cmpxchg.h                | 147 +++++++++---
 arch/openrisc/include/asm/cpuinfo.h                |   5 +-
 arch/openrisc/include/asm/mmu_context.h            |   2 +-
 arch/openrisc/include/asm/or1k-timer.h             |  27 +++
 arch/openrisc/include/asm/pgtable.h                |  18 +-
 arch/openrisc/include/asm/serial.h                 |   2 +-
 arch/openrisc/include/asm/smp.h                    |  26 +++
 arch/openrisc/include/asm/spinlock.h               |  12 +-
 arch/openrisc/include/asm/spinlock_types.h         |   7 +
 arch/openrisc/include/asm/spr_defs.h               |  14 ++
 arch/openrisc/include/asm/thread_info.h            |   2 +-
 arch/openrisc/include/asm/tlbflush.h               |  25 +-
 arch/openrisc/include/asm/unwinder.h               |  20 ++
 arch/openrisc/kernel/Makefile                      |   4 +-
 arch/openrisc/kernel/dma.c                         |  14 +-
 arch/openrisc/kernel/entry.S                       |  74 +++++-
 arch/openrisc/kernel/head.S                        | 232 +++++++++++++++---
 arch/openrisc/kernel/setup.c                       | 155 +++++++-----
 arch/openrisc/kernel/smp.c                         | 260 +++++++++++++++++++++
 arch/openrisc/kernel/stacktrace.c                  |  86 +++++++
 arch/openrisc/kernel/sync-timer.c                  | 120 ++++++++++
 arch/openrisc/kernel/time.c                        |  66 ++++--
 arch/openrisc/kernel/traps.c                       |  54 +----
 arch/openrisc/kernel/unwinder.c                    | 105 +++++++++
 arch/openrisc/lib/delay.c                          |   2 +-
 arch/openrisc/mm/Makefile                          |   2 +-
 arch/openrisc/mm/cache.c                           |  61 +++++
 arch/openrisc/mm/fault.c                           |   4 +-
 arch/openrisc/mm/init.c                            |   2 +-
 arch/openrisc/mm/tlb.c                             |  16 +-
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-ompic.c                        | 117 ++++++++++
 39 files changed, 1754 insertions(+), 230 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ompic.txt
 create mode 100644 arch/openrisc/boot/dts/simple_smp.dts
 create mode 100644 arch/openrisc/configs/simple_smp_defconfig
 create mode 100644 arch/openrisc/include/asm/cacheflush.h
 create mode 100644 arch/openrisc/include/asm/or1k-timer.h
 create mode 100644 arch/openrisc/include/asm/smp.h
 create mode 100644 arch/openrisc/include/asm/spinlock_types.h
 create mode 100644 arch/openrisc/include/asm/unwinder.h
 create mode 100644 arch/openrisc/kernel/smp.c
 create mode 100644 arch/openrisc/kernel/stacktrace.c
 create mode 100644 arch/openrisc/kernel/sync-timer.c
 create mode 100644 arch/openrisc/kernel/unwinder.c
 create mode 100644 arch/openrisc/mm/cache.c
 create mode 100644 drivers/irqchip/irq-ompic.c

-- 
2.13.5

