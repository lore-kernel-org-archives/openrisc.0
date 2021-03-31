From: guoren@kernel.org <guoren@kernel.org>
Date: Wed, 31 Mar 2021 14:30:31 +0000
Subject: [OpenRISC] [PATCH v6 0/9] riscv: Add qspinlock/qrwlock
Message-ID: <1617201040-83905-1-git-send-email-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Guo Ren <guoren@linux.alibaba.com>

Current riscv is still using baby spinlock implementation. It'll cause
fairness and cache line bouncing problems. Many people are involved
and pay the efforts to improve it:

 - The first version of patch was made in 2019.1:
   https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark at mac.com/#r

 - The second version was made in 2020.11:
   https://lore.kernel.org/linux-riscv/1606225437-22948-2-git-send-email-guoren at kernel.org/

 - A good discussion at Platform HSC.2021-03-08:
   https://drive.google.com/drive/folders/1ooqdnIsYx7XKor5O1XTtM6D1CHp4hc0p

 - A good discussion on V4 in mailling list:
   https://lore.kernel.org/linux-riscv/1616868399-82848-1-git-send-email-guoren at kernel.org/T/#t

 - Openrisc's maintainer want to implement arch_cmpxchg infrastructure.
   https://lore.kernel.org/linux-riscv/1616868399-82848-1-git-send-email-guoren at kernel.org/T/#m11b712fb6a4fda043811b1f4c3d61446951ed65a

Hope your comments and Tested-by or Co-developed-by or Reviewed-by ...

Let's kick the qspinlock into riscv right now (Also for the
architecture which hasn't xchg16 atomic instruction.)

Change V6:
 - Add  ticket-lock for riscv, default is qspinlock
 - Keep ticket-lock for csky,  default is ticketlock
 - Using smp_cond_load for riscv ticket-lock
 - Optimize csky ticketlock with smp_cond_load, store_release
 - Add PPC_LBARX_LWARX for powerpc 

Change V5:
 - Fixup #endif comment typo by Waiman
 - Remove cmpxchg coding convention patches which will get into a
   separate patchset later by Arnd's advice
 - Try to involve more architectures in the discussion

Change V4:
 - Remove custom sub-word xchg implementation
 - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock

Change V3:
 - Coding convention by Peter Zijlstra's advices

Change V2:
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

Guo Ren (8):
  locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  riscv: locks: Introduce ticket-based spinlock implementation
  csky: locks: Optimize coding convention
  csky: Convert custom spinlock/rwlock to generic qspinlock/qrwlock
  openrisc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  sparc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  xtensa: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  powerpc/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32

Michael Clark (1):
  riscv: Convert custom spinlock/rwlock to generic qspinlock/qrwlock

 arch/csky/Kconfig                       |   8 ++
 arch/csky/include/asm/Kbuild            |   2 +
 arch/csky/include/asm/spinlock.h        |  15 +--
 arch/csky/include/asm/spinlock_types.h  |   4 +
 arch/openrisc/Kconfig                   |   1 +
 arch/powerpc/Kconfig                    |   1 +
 arch/riscv/Kconfig                      |   8 ++
 arch/riscv/include/asm/Kbuild           |   3 +
 arch/riscv/include/asm/spinlock.h       | 158 +++++++++---------------
 arch/riscv/include/asm/spinlock_types.h |  26 ++--
 arch/sparc/Kconfig                      |   1 +
 arch/xtensa/Kconfig                     |   1 +
 kernel/Kconfig.locks                    |   3 +
 kernel/locking/qspinlock.c              |  46 +++----
 14 files changed, 142 insertions(+), 135 deletions(-)

-- 
2.17.1

