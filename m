From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:20 -0500
Subject: [OpenRISC] [PATCH 00/12] DT: CPU h/w id parsing clean-ups and
 cacheinfo id support
Message-ID: <20211006164332.1981454-1-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The first 10 patches add a new function, of_get_cpu_hwid(), which parses
CPU DT node 'reg' property, and then use it to replace all the open
coded versions of parsing CPU node 'reg' properties.

The last 2 patches add support for populating the cacheinfo 'id' on DT
platforms. The minimum associated CPU hwid is used for the id. The id is
optional, but necessary for resctrl which is being adapted for Arm MPAM.

Tested on arm64. Compile tested on arm, x86 and powerpc.

Rob

Rob Herring (12):
  of: Add of_get_cpu_hwid() to read hardware ID from CPU nodes
  ARM: Use of_get_cpu_hwid()
  ARM: broadcom: Use of_get_cpu_hwid()
  arm64: Use of_get_cpu_hwid()
  csky: Use of_get_cpu_hwid()
  openrisc: Use of_get_cpu_hwid()
  powerpc: Use of_get_cpu_hwid()
  riscv: Use of_get_cpu_hwid()
  sh: Use of_get_cpu_hwid()
  x86: dt: Use of_get_cpu_hwid()
  cacheinfo: Allow for >32-bit cache 'id'
  cacheinfo: Set cache 'id' based on DT data

 arch/arm/kernel/devtree.c       | 22 ++-------------------
 arch/arm/mach-bcm/bcm63xx_pmb.c |  6 +++---
 arch/arm64/kernel/smp.c         | 31 ++----------------------------
 arch/csky/kernel/smp.c          |  6 ++----
 arch/openrisc/kernel/smp.c      |  6 +-----
 arch/powerpc/kernel/smp.c       |  7 +------
 arch/riscv/kernel/cpu.c         |  3 ++-
 arch/sh/boards/of-generic.c     |  5 ++---
 arch/x86/kernel/devicetree.c    |  5 ++---
 drivers/base/cacheinfo.c        | 34 ++++++++++++++++++++++++++++++++-
 drivers/of/base.c               | 22 +++++++++++++++++++++
 include/linux/cacheinfo.h       |  2 +-
 include/linux/of.h              |  1 +
 13 files changed, 74 insertions(+), 76 deletions(-)

-- 
2.30.2

