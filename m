From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 May 2020 05:37:45 +0900
Subject: [OpenRISC] [PATCH 0/5] OpenRISC GCC Fixes for Glibc Support
Message-ID: <20200519203750.401593-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

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

