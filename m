From: Stafford Horne <shorne@gmail.com>
Date: Mon, 12 Dec 2016 23:38:56 +0900
Subject: [OpenRISC] [GIT PULL] Openrisc changes for 4.10 merge
Message-ID: <20161212143856.GA2650@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please pull the below, highlights include:
 _ This is my first pull request as the new OpenRISC architecture
   maintainer. I hope I have things in order.
 - Changes to MAINTAINER for openrisc
 - Probably biggest actual change is the move to memblock from bootmem
 - Plus several bug and build fixes

 
The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  https://github.com/openrisc/linux.git tags/openrisc-for-linus

for you to fetch changes up to 7c7808ce107d63e158dbbc3af085980985a0c3c4:

  openrisc: prevent VGA console, fix builds (2016-12-12 23:10:29 +0900)

----------------------------------------------------------------
Openrisc fixes for 4.10

----------------------------------------------------------------
Christian Svensson (1):
      openrisc: Add thread-local storage (TLS) support

Guenter Roeck (1):
      openrisc: Support both old (or32) and new (or1k) toolchain

Jonas Bonn (1):
      openrisc: restore all regs on rt_sigreturn

Randy Dunlap (1):
      openrisc: prevent VGA console, fix builds

Rob Herring (1):
      openrisc: remove the redundant of_platform_populate

Stafford Horne (3):
      openrisc: add NR_CPUS Kconfig default value
      openrisc: Consolidate setup to use memblock instead of bootmem
      openrisc: Updates after openrisc.net has been lost

Stefan Kristiansson (2):
      openrisc: fix PTRS_PER_PGD define
      openrisc: include l.swa in check for write data pagefault

 MAINTAINERS                         |  6 +++--
 arch/openrisc/Kconfig               |  4 ++++
 arch/openrisc/README.openrisc       |  8 +++----
 arch/openrisc/TODO.openrisc         |  3 ---
 arch/openrisc/include/asm/pgalloc.h |  1 -
 arch/openrisc/include/asm/pgtable.h |  2 +-
 arch/openrisc/kernel/entry.S        | 12 ++++++++--
 arch/openrisc/kernel/process.c      | 13 ++++++++++
 arch/openrisc/kernel/setup.c        | 48 ++++++++++---------------------------
 arch/openrisc/kernel/vmlinux.lds.S  |  8 ++++++-
 arch/openrisc/mm/init.c             |  4 ++--
 arch/openrisc/mm/ioremap.c          |  4 ----
 drivers/video/console/Kconfig       |  2 +-
 13 files changed, 59 insertions(+), 56 deletions(-)

