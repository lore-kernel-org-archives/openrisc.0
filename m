From: Stafford Horne <shorne@gmail.com>
Date: Mon, 21 Mar 2016 23:29:26 +0900
Subject: [OpenRISC] [RFC PATCH] Optimized memcpy routine
Message-ID: <1458570567-11596-1-git-send-email-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This patch is to show what I have been doing and what methods I have tried to
provide an optimized memcpy routing.  As you can see from the results above the
numbers are promosing and working well. If no big opposition for a few days I
will update the patch to remove the Kconfig stuff only use the
`word copies + loop unrolls` implementation.

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


