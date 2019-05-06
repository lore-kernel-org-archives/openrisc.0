From: Stafford Horne <shorne@gmail.com>
Date: Mon,  6 May 2019 22:16:19 +0900
Subject: [OpenRISC] [PATCH 0/2] OpenRISC fixes
Message-ID: <20190506131621.29929-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I sent the fix for 90363 previously with the FPU patches.  Now, I have added
tests and another issue came up, so I am sending as a new series.  I planned to
commit the code before the 9.x release but missed that.

This is a series of fixes for the OpenRISC target found during recent testings.

PRs:

 - 90362 or1k: Soft divide does not work correctly
 - 90363 or1k: Extra mask insn after load from memory

Stafford Horne (2):
  or1k: Fix code quality for volatile memory loads
  or1k: Fix issues with msoft-div

 gcc/config/or1k/or1k.md                   |  6 +-
 gcc/config/or1k/predicates.md             | 18 +++++
 gcc/testsuite/gcc.target/or1k/div-mul-3.c | 31 ++++++++
 gcc/testsuite/gcc.target/or1k/swap-1.c    | 86 +++++++++++++++++++++++
 gcc/testsuite/gcc.target/or1k/swap-2.c    | 63 +++++++++++++++++
 libgcc/config/or1k/lib1funcs.S            |  6 +-
 6 files changed, 204 insertions(+), 6 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/div-mul-3.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/swap-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/swap-2.c

-- 
2.19.1

