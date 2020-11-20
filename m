From: Stafford Horne <shorne@gmail.com>
Date: Sat, 21 Nov 2020 07:14:58 +0900
Subject: [OpenRISC] [PATCH] openrisc: add local64.h to fix blk-iocost build
Message-ID: <20201120221500.3097841-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

As of 5.10 OpenRISC allyesconfig builds fail with the following error.

    $ make ARCH=openrisc CROSS_COMPILE=or1k-elf- block/blk-iocost.o
      CALL    scripts/checksyscalls.sh
      CALL    scripts/atomic/check-atomics.sh
      CC      block/blk-iocost.o
    block/blk-iocost.c:183:10: fatal error: asm/local64.h: No such file or directory
      183 | #include <asm/local64.h>
	  |          ^~~~~~~~~~~~~~~
    compilation terminated.

The new include of local64.h was added in commit 5e124f74325d
("blk-iocost: use local[64]_t for percpu stat") by Tejun.

Adding the generic version of local64.h to OpenRISC fixes the build
issue.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index ca5987e11053..442f3d3bcd90 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
+generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += qspinlock_types.h
 generic-y += qspinlock.h
-- 
2.26.2

