From: Stafford Horne <shorne@gmail.com>
Date: Fri, 13 Oct 2017 22:49:25 +0900
Subject: [OpenRISC] [PATCH v2 0/5] OpenRISC SMP Support
Message-ID: <20171013134930.32547-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This series adds SMP support for OpenRISC.  The platform is based on the
work that Stefan Kristiansson did around 2012 implemented in Verilog and
run on FPGAs.  I have been working to upstream this work, these are my QEMU
patches I have been used to help with testing.

I have documented the platform in the OpenRISC 1.2 specification proposal
available here:
  https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf

My latest kernel patches are available here:
  https://github.com/stffrdhrn/linux.git openrisc-4.14-smp-qspinlock-v3

-Stafford

Changes since v1
 * Don't numcores and coreid to state suggested by Richard

Stafford Horne (5):
  openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
  target/openrisc: Make coreid and numcores variable
  openrisc/cputimer: Perparation for Multicore
  openrisc: Initial SMP support
  openrisc: Only kick cpu on timeout, not on update

 default-configs/or1k-softmmu.mak |   1 +
 hw/intc/Makefile.objs            |   1 +
 hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
 hw/openrisc/cputimer.c           |  64 ++++++++++----
 hw/openrisc/openrisc_sim.c       |  84 +++++++++++++-----
 target/openrisc/cpu.c            |   1 -
 target/openrisc/cpu.h            |   4 +-
 target/openrisc/machine.c        |   1 -
 target/openrisc/sys_helper.c     |   9 +-
 9 files changed, 298 insertions(+), 46 deletions(-)
 create mode 100644 hw/intc/ompic.c

-- 
2.13.6

