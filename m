From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, 4 Jun 2021 15:06:18 +0800
Subject: [OpenRISC] [PATCH v2 00/15] init_mm: cleanup ARCH's text/data/brk
 setup code
Message-ID: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add setup_initial_init_mm() helper, then use it
to cleanup the text, data and brk setup code.

v2:
- change argument from "char *" to "void *" setup_initial_init_mm()
  suggested by Geert Uytterhoeven
- use NULL instead of (void *)0 on h8300 and m68k
- collect ACKs

Cc: linux-snps-arc at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-csky at vger.kernel.org
Cc: uclinux-h8-devel at lists.sourceforge.jp
Cc: linux-m68k at lists.linux-m68k.org
Cc: openrisc at lists.librecores.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-riscv at lists.infradead.org
Cc: linux-sh at vger.kernel.org
Cc: linux-s390 at vger.kernel.org
Kefeng Wang (15):
  mm: add setup_initial_init_mm() helper
  arc: convert to setup_initial_init_mm()
  arm: convert to setup_initial_init_mm()
  arm64: convert to setup_initial_init_mm()
  csky: convert to setup_initial_init_mm()
  h8300: convert to setup_initial_init_mm()
  m68k: convert to setup_initial_init_mm()
  nds32: convert to setup_initial_init_mm()
  nios2: convert to setup_initial_init_mm()
  openrisc: convert to setup_initial_init_mm()
  powerpc: convert to setup_initial_init_mm()
  riscv: convert to setup_initial_init_mm()
  s390: convert to setup_initial_init_mm()
  sh: convert to setup_initial_init_mm()
  x86: convert to setup_initial_init_mm()

 arch/arc/mm/init.c                 | 5 +----
 arch/arm/kernel/setup.c            | 5 +----
 arch/arm64/kernel/setup.c          | 5 +----
 arch/csky/kernel/setup.c           | 5 +----
 arch/h8300/kernel/setup.c          | 5 +----
 arch/m68k/kernel/setup_mm.c        | 5 +----
 arch/m68k/kernel/setup_no.c        | 5 +----
 arch/nds32/kernel/setup.c          | 5 +----
 arch/nios2/kernel/setup.c          | 5 +----
 arch/openrisc/kernel/setup.c       | 5 +----
 arch/powerpc/kernel/setup-common.c | 5 +----
 arch/riscv/kernel/setup.c          | 5 +----
 arch/s390/kernel/setup.c           | 5 +----
 arch/sh/kernel/setup.c             | 5 +----
 arch/x86/kernel/setup.c            | 5 +----
 include/linux/mm_types.h           | 8 ++++++++
 16 files changed, 23 insertions(+), 60 deletions(-)

-- 
2.26.2

