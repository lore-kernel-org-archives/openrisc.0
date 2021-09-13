From: Stafford Horne <shorne@gmail.com>
Date: Mon, 13 Sep 2021 21:47:55 +0900
Subject: [OpenRISC] [PATCH 0/5] OpenRISC Linux Native and GDBServer Support
Message-ID: <20210913124800.471680-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

As I have been working on the OpenRISC glibc port over the last few years now I
have had the need to have Linux native debugging.  At first I started with the
gdbserver, but quickly grew out of that and just settled on running gdb native
on the platform.

These are the patches I have been using.

Stafford Horne (5):
  gdb: or1k: implement gdb server
  gdb: or1k: fixup linux regcache comment
  gdb: or1k: add generated linux descriptor file
  gdb: or1k: add native linux support
  gdb: or1k: add single step for linux native debugging

 gdb/Makefile.in               |   2 +
 gdb/configure.host            |   2 +
 gdb/configure.nat             |   4 +
 gdb/features/Makefile         |   1 +
 gdb/features/or1k-linux.c     |  78 ++++++++++
 gdb/features/or1k-linux.xml   |  13 ++
 gdb/or1k-linux-nat.c          | 210 +++++++++++++++++++++++++++
 gdb/or1k-linux-tdep.c         |  14 +-
 gdb/or1k-linux-tdep.h         |  26 ++++
 gdb/or1k-tdep.c               |  66 ++++++---
 gdb/or1k-tdep.h               |   5 +
 gdb/regformats/or1k-linux.dat |  40 +++++
 gdbserver/Makefile.in         |   1 +
 gdbserver/configure.srv       |   8 +
 gdbserver/linux-or1k-low.cc   | 266 ++++++++++++++++++++++++++++++++++
 15 files changed, 714 insertions(+), 22 deletions(-)
 create mode 100644 gdb/features/or1k-linux.c
 create mode 100644 gdb/features/or1k-linux.xml
 create mode 100644 gdb/or1k-linux-nat.c
 create mode 100644 gdb/or1k-linux-tdep.h
 create mode 100644 gdb/regformats/or1k-linux.dat
 create mode 100644 gdbserver/linux-or1k-low.cc

-- 
2.31.1

