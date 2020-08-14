From: Stafford Horne <shorne@gmail.com>
Date: Sat, 15 Aug 2020 05:47:59 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for v5.9
Message-ID: <20200814204759.GT80756@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull:

The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 55b2662ec665cc8b592809a011fe807b05370ab8:

  openrisc: uaccess: Add user address space check to access_ok (2020-08-09 07:57:21 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.9

A few patches all over the place during this cycle, mostly bug and
sparse warning fixes for OpenRISC, but a few enhancements too.  Note,
there are 2 non OpenRISC specific fixups.

Non OpenRISC fixes:

 - In init we need to align the init_task correctly to fix an issue with
   MUTEX_FLAGS, reviewed by Peter Z.  No one picked this up so I kept it
   on my tree.
 - In asm-generic/io.h I fixed up some sparse warnings, OK'd by Arnd.
   Arnd asked to merge it via my tree.

OpenRISC fixes:

 - Many fixes for OpenRISC sprase warnings.
 - Add support OpenRISC SMP tlb flushing rather than always flushing the
   entire TLB on every CPU.
 - Fix bug when dumping stack via /proc/xxx/stack of user threads.

----------------------------------------------------------------
Luc Van Oostenryck (1):
      openrisc: fix __user in raw_copy_to_user()'s prototype

Stafford Horne (11):
      init: Align init_task to avoid conflict with MUTEX_FLAGS
      openrisc: Add support for external initrd images
      openrisc: Fix oops caused when dumping stack
      openrisc: Implement proper SMP tlb flushing
      asm-generic/io.h: Fix sparse warnings on big-endian architectures
      openrisc: io: Fixup defines and move include to the end
      openrisc: uaccess: Fix sparse address space warnings
      openrisc: uaccess: Use static inline function in access_ok
      openrisc: uaccess: Remove unused macro __addr_ok
      openrisc: signal: Fix sparse address space warnings
      openrisc: uaccess: Add user address space check to access_ok

 arch/openrisc/include/asm/io.h      |  9 +++-
 arch/openrisc/include/asm/uaccess.h | 23 +++++-----
 arch/openrisc/kernel/setup.c        |  8 ++--
 arch/openrisc/kernel/signal.c       | 14 +++---
 arch/openrisc/kernel/smp.c          | 85 +++++++++++++++++++++++++++++++++----
 arch/openrisc/kernel/stacktrace.c   | 18 +++++++-
 arch/openrisc/kernel/vmlinux.lds.S  | 12 ------
 arch/openrisc/mm/tlb.c              | 17 +++++---
 include/asm-generic/io.h            | 16 +++----
 init/init_task.c                    |  1 +
 10 files changed, 145 insertions(+), 58 deletions(-)
