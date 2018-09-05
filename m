From: Rob Herring <robh@kernel.org>
Date: Wed,  5 Sep 2018 14:37:17 -0500
Subject: [OpenRISC] [PATCH 00/21] DT cpu node iterator
Message-ID: <20180905193738.19325-1-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This series adds an iterator for cpu nodes and converts users over to use
it or of_get_cpu_node in some cases. This allows us to remove the
dependency on device_type property for cpu nodes though removing that
from DTS files will have to wait for some time. In some cases, this makes
the DT search more strict by only looking in /cpus child nodes rather
than any node with the device_type == cpu. The iterator also honors the
status property which is often forgotten.

I've only tested on ARM under QEMU and compiled powerpc.

Rob

Rob Herring (21):
  of: Add cpu node iterator for_each_of_cpu_node()
  of: Support matching cpu nodes with no 'reg' property
  ARM: use for_each_of_cpu_node iterator
  ARM: topology: remove unneeded check for /cpus node
  ARM: shmobile: use for_each_of_cpu_node iterator
  arm64: use for_each_of_cpu_node iterator
  c6x: use for_each_of_cpu_node iterator
  microblaze: get cpu node with of_get_cpu_node
  nios2: get cpu node with of_get_cpu_node
  openrisc: use for_each_of_cpu_node iterator
  powerpc: use for_each_of_cpu_node iterator
  powerpc: 4xx: get cpu node with of_get_cpu_node
  powerpc: 8xx: get cpu node with of_get_cpu_node
  riscv: use for_each_of_cpu_node iterator
  SH: use for_each_of_cpu_node iterator
  x86: DT: use for_each_of_cpu_node iterator
  clk: mvebu: use for_each_of_cpu_node iterator
  edac: cpc925: use for_each_of_cpu_node iterator
  iommu: fsl_pamu: use for_each_of_cpu_node iterator
  of: use for_each_of_cpu_node iterator
  fbdev: fsl-diu: get cpu node with of_get_cpu_node

 arch/arm/kernel/devtree.c                 |  5 +--
 arch/arm/kernel/topology.c                |  6 ---
 arch/arm/mach-shmobile/pm-rcar-gen2.c     |  8 +---
 arch/arm/mach-shmobile/pm-rmobile.c       |  2 +-
 arch/arm/mach-shmobile/timer.c            | 10 +----
 arch/arm64/kernel/smp.c                   |  2 +-
 arch/c6x/kernel/setup.c                   | 11 ++---
 arch/microblaze/kernel/cpu/cpuinfo.c      |  4 +-
 arch/nios2/kernel/cpuinfo.c               |  4 +-
 arch/openrisc/kernel/setup.c              |  3 +-
 arch/powerpc/platforms/4xx/soc.c          |  2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c   |  5 ++-
 arch/powerpc/platforms/powermac/feature.c | 51 ++++++++---------------
 arch/powerpc/platforms/powermac/setup.c   | 15 +++----
 arch/riscv/kernel/smpboot.c               |  2 +-
 arch/sh/boards/of-generic.c               |  2 +-
 arch/x86/kernel/devicetree.c              |  2 +-
 drivers/clk/mvebu/clk-cpu.c               |  4 +-
 drivers/edac/cpc925_edac.c                | 20 +--------
 drivers/iommu/fsl_pamu.c                  |  2 +-
 drivers/of/base.c                         | 43 ++++++++++++++++++-
 drivers/of/of_numa.c                      | 15 +------
 drivers/video/fbdev/fsl-diu-fb.c          |  2 +-
 include/linux/of.h                        | 11 +++++
 24 files changed, 111 insertions(+), 120 deletions(-)

--
2.17.1
