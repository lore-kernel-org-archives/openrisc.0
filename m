From: Stafford Horne <shorne@gmail.com>
Date: Sun, 10 Sep 2017 15:49:12 +0900
Subject: [OpenRISC] [PATCH v2 00/14] OpenRISC SMP Support
Message-ID: <20170910064926.5874-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Again,

This series adds SMP support for OpenRISC.  The OpenRISC multicore platform
and SMP linux support is based on the work that Stefan Kristiansson did
around 2012 implemented in Verilog and run on FPGAs.  I have been working
to upstream this work. I have additionally tested this on QEMU, which I
patched for OpenRISC multicore support, as well as FPGA.

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
   implementation.
 o The "support for ompic" adds a new irqchip device which is used for IPI
   communication to support SMP.  (Perhaps this patch should go via another
   route but included here for completeness - confirmed this is ok)
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

--

Changes since v1
  - refactor of timer headers to not require extern openrisc_timer_init()
    in smp.c
  - check for power management unit when sleeping on secondary cpu wait
  - fixed cpuinfo to print online CPUs only
  - cleanups for the ompic suggested by Marc Zyngier and Mark Rutland
    > don't say size is arbitrary, it's 8 bytes per CPU
    > validate register size vs cpus
    > add validations for all initialization failures
    > use percpu for percpu ipi ops
    > remove SMP and OF #ifdefs
    > document details about OpenRISC implied barriers
    > use vendor prefix openrisc,
    > removed #interrupt-cells as this will not be a parent
    > added some architecture documentation into the source
  - enforce shadow register usage for SMP as suggested by Geert
  - DTS updates suggested by Mark Rutland
    > Add and use vendor prefix openrisc, for ompic
    > Use stdout-path

-Stafford



Jan Henrik Weinstock (1):
  openrisc: add cacheflush support to fix icache aliasing

Stafford Horne (9):
  openrisc: define CPU_BIG_ENDIAN as true
  openrisc: add 1 and 2 byte cmpxchg support
  openrisc: use qspinlocks and qrwlocks
  dt-bindings: add openrisc to vendor prefixes list
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

 .../interrupt-controller/openrisc,ompic.txt        |  19 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/openrisc/Kconfig                              |  52 ++++-
 arch/openrisc/boot/dts/simple_smp.dts              |  58 +++++
 arch/openrisc/configs/simple_smp_defconfig         |  66 ++++++
 arch/openrisc/include/asm/Kbuild                   |   5 +-
 arch/openrisc/include/asm/cacheflush.h             |  96 ++++++++
 arch/openrisc/include/asm/cmpxchg.h                | 147 +++++++++---
 arch/openrisc/include/asm/cpuinfo.h                |   7 +-
 arch/openrisc/include/asm/mmu_context.h            |   2 +-
 arch/openrisc/include/asm/pgtable.h                |  18 +-
 arch/openrisc/include/asm/serial.h                 |   2 +-
 arch/openrisc/include/asm/smp.h                    |  26 +++
 arch/openrisc/include/asm/spinlock.h               |  12 +-
 arch/openrisc/include/asm/spinlock_types.h         |   7 +
 arch/openrisc/include/asm/spr_defs.h               |  14 ++
 arch/openrisc/include/asm/thread_info.h            |   2 +-
 arch/openrisc/include/asm/time.h                   |  23 ++
 arch/openrisc/include/asm/tlbflush.h               |  25 +-
 arch/openrisc/include/asm/unwinder.h               |  20 ++
 arch/openrisc/kernel/Makefile                      |   4 +-
 arch/openrisc/kernel/dma.c                         |  14 +-
 arch/openrisc/kernel/entry.S                       |  74 +++++-
 arch/openrisc/kernel/head.S                        | 239 ++++++++++++++++---
 arch/openrisc/kernel/setup.c                       | 165 ++++++++-----
 arch/openrisc/kernel/smp.c                         | 259 +++++++++++++++++++++
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
 drivers/irqchip/Kconfig                            |   3 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-ompic.c                        | 205 ++++++++++++++++
 40 files changed, 1850 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
 create mode 100644 arch/openrisc/boot/dts/simple_smp.dts
 create mode 100644 arch/openrisc/configs/simple_smp_defconfig
 create mode 100644 arch/openrisc/include/asm/cacheflush.h
 create mode 100644 arch/openrisc/include/asm/smp.h
 create mode 100644 arch/openrisc/include/asm/spinlock_types.h
 create mode 100644 arch/openrisc/include/asm/time.h
 create mode 100644 arch/openrisc/include/asm/unwinder.h
 create mode 100644 arch/openrisc/kernel/smp.c
 create mode 100644 arch/openrisc/kernel/stacktrace.c
 create mode 100644 arch/openrisc/kernel/sync-timer.c
 create mode 100644 arch/openrisc/kernel/unwinder.c
 create mode 100644 arch/openrisc/mm/cache.c
 create mode 100644 drivers/irqchip/irq-ompic.c

-- 
2.13.5

