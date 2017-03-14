From: Stafford Horne <shorne@gmail.com>
Date: Tue, 14 Mar 2017 23:56:25 +0900
Subject: [OpenRISC] [PATCH 0/3] Openrisc fixes for 4.11
Message-ID: <cover.1489502779.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

These are a few compile error and warning fixes which were pointed out
after the 4.11 code was merged.

Most of these could be found at this kbuild failure here:

  https://lkml.org/lkml/2017/3/9/976

The rest I found with some local testing.

Stafford Horne (3):
  openrisc: xchg: fix `computed is not used` warning
  openrisc: fix issue handling 8 byte get_user calls
  openrisc: Export symbols needed by modules

 arch/openrisc/include/asm/cmpxchg.h | 8 ++++++--
 arch/openrisc/include/asm/uaccess.h | 2 +-
 arch/openrisc/kernel/or32_ksyms.c   | 5 +++++
 arch/openrisc/kernel/process.c      | 1 +
 4 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.9.3

