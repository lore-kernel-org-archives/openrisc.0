From: Stafford Horne <shorne@gmail.com>
Date: Thu, 14 Jan 2021 08:50:27 +0900
Subject: [OpenRISC] [RESEND PATCH 0/5] OpenRISC GCC Fixes for Glibc Support
Message-ID: <20210113235032.2821155-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Changes since v1:
 - Rebase

This just a resend of v1 with no changes from when I sent it last year.  I
hadn't committed it because I had not completed all testing in glibc.  Now that
I have done that and it all seems to work I will commit it.

I am currently working on the glibc port for OpenRISC.  This is a series of
patches that fix issues and add features that were missing in GCC causing glibc
testsuite failures.

Pretty much all of these changes are just adding macros.

These changes have been tested via the glibc test suite.

-Stafford

Stafford Horne (5):
  or1k: Implement profile hook calling _mcount
  or1k: Add builtin define to detect hard float
  or1k: Support for softfloat to emulate hw exceptions
  or1k: Add note to indicate execstack
  or1k: Fixup exception header data encodings

 gcc/config/or1k/linux.h          |  2 ++
 gcc/config/or1k/or1k.h           | 21 ++++++++++++++--
 libgcc/config/or1k/sfp-machine.h | 41 +++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.26.2

