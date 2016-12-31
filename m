From: Stafford Horne <shorne@gmail.com>
Date: Sat, 31 Dec 2016 20:52:56 +0900
Subject: [OpenRISC] [PATCH 0/3] Openrisc 4.10 fixes
Message-ID: <cover.1483184705.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

These are a few small changes for openrisc I would like to include in 4.10.
The main change is a fix for building with alldefconfig to properly setup
then _text symbol.  Others are trivial.

If no complaints I will push to 4.10 for inclusion and start working on
4.11 changes.

Let me know if these are too minor to even post for review.

Stafford Horne (3):
  openrisc: Add _text symbol to fix ksym build error
  openrisc: Add .gitignore
  MAINTAINERS: Add the openrisc official repository

 MAINTAINERS                        | 1 +
 arch/openrisc/kernel/.gitignore    | 1 +
 arch/openrisc/kernel/vmlinux.lds.S | 2 ++
 3 files changed, 4 insertions(+)
 create mode 100644 arch/openrisc/kernel/.gitignore

-- 
2.9.3


