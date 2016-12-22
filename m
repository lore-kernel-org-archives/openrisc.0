From: Stafford Horne <shorne@gmail.com>
Date: Fri, 23 Dec 2016 01:13:59 +0900
Subject: [OpenRISC] [PATCH v3 0/3] OpenRISC gdb port
Message-ID: <cover.1482413820.git.shorne@gmail.com>
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

# of expected passes            19241
# of unexpected failures        406
# of expected failures          29
# of known failures             57
# of unresolved testcases       2
# of untested testcases         190
# of unsupported tests          264

--
Changes from v2
 * Updates as per Yao's comments
  - Fix copyrights, jullien embecosm, remove embecosm
  - indentation to use gnu style (i.e. && and || on left)
  - Fix comments to use gnu style
  - Move some includes around
  - Remove constant variables, replace with constants
  - Remove doxygen on a few calls
  - Have only 1 space between type and var name
  - remove todo about 4 const
  - do fix *buf checks (use buf != NULL)
  - BP_MANIPULATION
  - Use the builtin types for reg register functions
  - or1k_iterate_over_regset_sections - remove no linux, no cores yet
 * Remove unimplements pseudo register functions
 * Remove spr commands as we can now get those via `info reg`

Changes from v1
 * Merged or1k-tdep.[ch] changes into a single commit
 * Futher fixes to change log bringing in history back to 2008
 * Fix doc issue on sw_breakpoint_from_kind


Franck Jullien (1):
  gdb: Add OpenRISC or1k and or1knd target support

Stafford Horne (1):
  gdb: testsuite: Add or1k l.nop inscruction

Stefan Wallentowitz (1):
  Add gdb for or1k build

 configure                             |    7 -
 configure.ac                          |    7 -
 gdb/configure.tgt                     |   12 +
 gdb/doc/gdb.texinfo                   |   68 ++
 gdb/or1k-tdep.c                       | 1436 +++++++++++++++++++++++++++++++++
 gdb/or1k-tdep.h                       |   57 ++
 gdb/testsuite/gdb.base/bp-permanent.c |    2 +
 7 files changed, 1575 insertions(+), 14 deletions(-)
 create mode 100644 gdb/or1k-tdep.c
 create mode 100644 gdb/or1k-tdep.h

-- 
2.7.4


