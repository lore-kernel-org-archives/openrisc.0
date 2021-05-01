From: Stafford Horne <shorne@gmail.com>
Date: Sun,  2 May 2021 06:11:43 +0900
Subject: [OpenRISC] [PATCH v2 0/2] OpenRISC support for cmodel=large
Message-ID: <20210501211145.2980164-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Changes from v1:
 - Added patch to enabled cmodle=large on crtstuff

This series fixes some bugs found when linking large binaries, both in buildroot
and glibc testing.

Stafford Horne (2):
  or1k: Add mcmodel option to handle large GOTs
  or1k: Use cmodel=large when building crtstuff

 gcc/config/or1k/or1k-opts.h   | 30 ++++++++++++++++++++++++++++++
 gcc/config/or1k/or1k.c        | 11 +++++++++--
 gcc/config/or1k/or1k.h        |  7 +++++++
 gcc/config/or1k/or1k.opt      | 19 +++++++++++++++++++
 gcc/doc/invoke.texi           | 12 +++++++++++-
 libgcc/config.host            |  4 ++--
 libgcc/config/or1k/t-crtstuff |  2 ++
 7 files changed, 80 insertions(+), 5 deletions(-)
 create mode 100644 gcc/config/or1k/or1k-opts.h
 create mode 100644 libgcc/config/or1k/t-crtstuff

-- 
2.26.2

