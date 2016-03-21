From: Stafford Horne <shorne@gmail.com>
Date: Tue, 22 Mar 2016 06:36:56 +0900
Subject: [OpenRISC] [RFC PATCH 0/1 ] Optimized memcpy routine
Message-ID: <1458596217-14337-1-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

(resending as there were some reported issues on the mail server)

Hello,

This patch is to show what I have been doing and what methods I have tried in
providing an optimized memcpy routine.  As you can see from the results in the
commit details the numbers are promising and there are 2 word copy optimization
options which both perform well. If no opposition for a few days I will update
the patch to remove the Kconfig stuff and only use the
`word copies + loop unrolls` implementation.

The final patch will be made as a pull request to Stefan's github repo.

Thanks
 -Stafford

Stafford Horne (1):
  openrisc: Add optimized memcpy routine

 arch/openrisc/Kconfig              |  61 ++++++
 arch/openrisc/TODO.openrisc        |   1 -
 arch/openrisc/include/asm/string.h |   5 +
 arch/openrisc/lib/Makefile         |   3 +-
 arch/openrisc/lib/memcpy.c         | 377 +++++++++++++++++++++++++++++++++++++
 5 files changed, 445 insertions(+), 2 deletions(-)
 create mode 100644 arch/openrisc/lib/memcpy.c

-- 
2.5.0


