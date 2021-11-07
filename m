From: Stafford Horne <shorne@gmail.com>
Date: Mon, 8 Nov 2021 06:03:34 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for 5.16
Message-ID: <YYg/JpmfY9/Z8qO1@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Please consider for pull,

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 27dff9a9c247d4e38d82c2e7234914cfe8499294:

  openrisc: fix SMP tlb flush NULL pointer dereference (2021-11-03 20:48:29 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.16

This includes 2 minor cleanups, plus a bug fix for OpenRISC TLB flush
code that allows the the SMP kernel to boot again.

----------------------------------------------------------------
Denis Kirjanov (1):
      openrisc: signal: remove unused DEBUG_SIG macro

Randy Dunlap (1):
      openrisc: time: don't mark comment as kernel-doc

Stafford Horne (1):
      openrisc: fix SMP tlb flush NULL pointer dereference

 arch/openrisc/kernel/dma.c    | 4 ++--
 arch/openrisc/kernel/signal.c | 2 --
 arch/openrisc/kernel/smp.c    | 6 ++++--
 arch/openrisc/kernel/time.c   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
