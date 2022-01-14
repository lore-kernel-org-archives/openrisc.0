From: Stafford Horne <shorne@gmail.com>
Date: Fri, 14 Jan 2022 22:07:18 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for 5.17
Message-ID: <YeF1hpMbYo5PMmkD@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 7f435e42fd6b65fd8759963156e1ef0fb7d213f8:

  openrisc: init: Add support for common clk (2022-01-12 06:13:22 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.17

A few fixups and enhancements for OpenRISC:
 - Fix to add proper wrapper for clone3 to save callee saved regs
 - Cleanups for clone, fork and switch
 - Add support for common clk so OpenRISC and use more drivers

----------------------------------------------------------------
Stafford Horne (4):
      openrisc: Cleanup switch code and comments
      openrisc: Use delay slot for clone and fork wrappers
      openrisc: Add clone3 ABI wrapper
      openrisc: init: Add support for common clk

 arch/openrisc/Kconfig                |  1 +
 arch/openrisc/include/asm/syscalls.h |  2 ++
 arch/openrisc/kernel/entry.S         | 27 +++++++++++++--------------
 arch/openrisc/kernel/time.c          |  4 ++++
 4 files changed, 20 insertions(+), 14 deletions(-)
