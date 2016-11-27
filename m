From: Stafford Horne <shorne@gmail.com>
Date: Sun, 27 Nov 2016 15:16:42 +0900
Subject: [OpenRISC] [PATCH v2 0/4] gdb: Port for OpenRISC
Message-ID: <cover.1480216015.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This is the openrisc port of GDB that has been in openrisc
repositories for a very long time. The main original author
was Jeremy Bennett as can be seen in file copyrights. Other
are willing to do what it takes for FSF copyright assignment.

This along with the sim patches are the last of what has not
made its way upstream. The patches are based on current gdb
git master branch.

I have run the testsuite and results are as follows:

--
Changes from v1
 * Merged or1k-tdep.[ch] changes into a single commit
 * Futher fixes to change log bringing in history back to 2008
 * Fix doc issue on sw_breakpoint_from_kind 

Franck Jullien (2):
  gdb: Add tdesc_find_register functions
  gdb: Add OpenRISC or1k and or1knd target support

Stafford Horne (1):
  gdb: testsuite: Add or1k l.nop inscruction

Stefan Wallentowitz (1):
  Add gdb for or1k build

 configure                             |    7 -
 configure.ac                          |    7 -
 gdb/configure.tgt                     |   26 +
 gdb/doc/gdb.texinfo                   |  103 ++
 gdb/or1k-tdep.c                       | 3285 +++++++++++++++++++++++++++++++++
 gdb/or1k-tdep.h                       |  434 +++++
 gdb/target-descriptions.c             |   46 +-
 gdb/target-descriptions.h             |   12 +
 gdb/testsuite/gdb.base/bp-permanent.c |    2 +
 9 files changed, 3902 insertions(+), 20 deletions(-)
 create mode 100644 gdb/or1k-tdep.c
 create mode 100644 gdb/or1k-tdep.h

-- 
2.7.4


