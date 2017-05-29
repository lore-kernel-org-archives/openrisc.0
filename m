From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 May 2017 23:48:22 +0900
Subject: [OpenRISC] [PATCH v7 0/4] OpenRISC gdb port
Message-ID: <cover.1496068645.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This is the openrisc port of GDB that has been in openrisc
repositories for a very long time. The main original author
was Jeremy Bennett as can be seen in file copyrights. Others
should also have copyright assignment in place.

This along with the sim patches are the last of what has not
made its way upstream. The patches are based on current gdb
git master branch.

I have run the testsuite and results are as follows:

   === gdb Summary ===

# of expected passes            19597
# of unexpected failures        394
# of expected failures          29
# of known failures             54
# of unresolved testcases       2
# of untested testcases         190
# of unsupported tests          290


-Stafford

--

Changes since v6
 * Removed the tdesc arbitrary groups patch (split to different series)
 * Removed docs suggested by Yao Qi:
   - No need to document `target remote` as all targets have this
   - No need to document reggroups as its available via `maint print`
 * Fixed Open vs Free suggestion from Eli

Changes since v5
 * Change from using frame_debug to or1k_debug
 * Change to use TYPE_*() macros rather than direct access to arg_type
   fields
 * Fixes to docs suggested by Eli
 * Fixes suggested by Yao Qi
   - Use target_read_code() vs target_read_memory()
   - use bool where possible instead of int
   - User error over throw_quit
   - Fix line widths to 80 characters for comments
   - Add some better comments on the analyse functions
   - Dynamically allocate arg buffers rather than hard coding size to 4, to
     allow for dynamic sizes.
   - Remote or1k_register_*() functions, handled all in tdesc now
   - Change way to define inline or1k_frame_unwind struct
 * Add test for gdb.xml/tdesc-regs.exp

Changes since v4
 * Fixed issue with gdb_assert causing prologue sniffer to abort gdb
 * Fixed issue with step through delay slot possible SEGV
 * Cleaned up a few more comments to be GNU style

Changes since v3
 * Updates as per Luis's comments
  - comment formatting issues (period then 2 spaces)
  - remove spurious newlines
  - merged configure.tgt clasues to single
  - Fixed typos and grammar in gdb.texinfo
  - Removed copyright names from source files (in docs)
  - Remove curly braces around single statement if's
  - (fyi) I left the casts as I think it keeps code readable
  - used XCNEW for tdep init
  - Added an example XML target descriptor
 * Removed newlines

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

--

Franck Jullien (1):
  gdb: Add OpenRISC or1k and or1knd target support

Stafford Horne (3):
  gdb: testsuite: Add or1k l.nop instruction
  gdb: testsuite: Add or1k tdesc-regs.exp test support
  Add gdb for or1k build

 configure                             |    7 -
 configure.ac                          |    7 -
 gdb/configure.tgt                     |    6 +
 gdb/doc/gdb.texinfo                   |   47 ++
 gdb/features/Makefile                 |    2 +
 gdb/features/or1k-core.xml            |   65 ++
 gdb/features/or1k.c                   |   77 ++
 gdb/features/or1k.xml                 |   12 +
 gdb/or1k-tdep.c                       | 1296 +++++++++++++++++++++++++++++++++
 gdb/or1k-tdep.h                       |   56 ++
 gdb/testsuite/gdb.base/bp-permanent.c |    2 +
 gdb/testsuite/gdb.xml/tdesc-regs.exp  |    3 +
 12 files changed, 1566 insertions(+), 14 deletions(-)
 create mode 100644 gdb/features/or1k-core.xml
 create mode 100644 gdb/features/or1k.c
 create mode 100644 gdb/features/or1k.xml
 create mode 100644 gdb/or1k-tdep.c
 create mode 100644 gdb/or1k-tdep.h

-- 
2.9.4

