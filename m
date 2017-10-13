From: Stafford Horne <shorne@gmail.com>
Date: Fri, 13 Oct 2017 21:36:40 +0900
Subject: [OpenRISC] [PATCH v6 0/6] sim port for OpenRISC
Message-ID: <20171013123646.8206-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Please find attached the sim patches that allow to get a basic OpenRISC
system running.  This was used to verify the OpenRISC gdb port.

The main author is Peter Gavin who should have his FSF copyright in place.

Request for comments on:
 - The testcase has a few tests commented out. I do not plan to fix now,
   but hopefully be addressed after upstreaming.

                        # Test Results #

Sim dejagnu tests were added specifically for openrisc and used to test
this.  Please see the details of running the testsuite for sim below:

=== sim Summary ===

# of expected passes            18
/home/shorne/work/openrisc/build-gdb/sim/or1k/run 0.5


Thanks,
-Stafford

Changes since v5
 * Moved the cover letter docs into a README as suggested by Doug
 * Fixes in sim-fpu suggested by Simon
   - removed some spurious comments
   - added a missing changelog entry for sim_fpu_print_status
   - fixed an indent issue
 * Fixed changelog of MUL2OFSI and MUL1OFSI
   - comment was flipped
   - switched from saying macro to function
 * Fixes to sim & testsuite patch
   - removed 1996 copyrights throughout
   - fixed 80 char column issues
   - fixed comment typos
   - fixed issue with '* current_cpu' vs '*current_cpu' throughout
   - added comments about SR[LEE]

Changes since v4
 * Added comments to most of the functions
 * Implemented remainder fpu function
 * Actually wire in fpu and error handling logic
 * Added fpu test case

Changes since v3
 * Cleaned up indentation and style of sim testsuite
 * Cleaned up TODOs in testsuite
 * Implemented range exception

Changes since v2
 * Removed 64-bit implementation (reduced files)
 * Removed cgen suffix patch
 * Removed different builds for linux
 * Removed unused macros
 * Fixed gnu style issues pointed out by Mike
 * Fixed copyrights (not Cygnus, added to each file)

Changes since v1
 * Squashed sim patches into single sim patch
 * Put Generated files in separate patch
 * I have my sim/gdb copyright assignment complete

Peter Gavin (3):
  sim: cgen: add remainder functions (needed for OR1K lf.rem.[sd])
  sim: cgen: add MUL2OFSI and MUL1OFSI functions (needed for OR1K
    l.mul[u])
  sim: testsuite: add testsuite for or1k sim

Stafford Horne (3):
  sim: or1k: add or1k target to sim
  sim: or1k: add cgen generated files
  sim: or1k: add autoconf generated files

 sim/common/cgen-accfp.c                        |    40 +
 sim/common/cgen-fpu.h                          |     4 +
 sim/common/cgen-ops.h                          |    18 +
 sim/common/sim-fpu.c                           |    86 +
 sim/common/sim-fpu.h                           |    13 +-
 sim/configure                                  |     9 +
 sim/configure.tgt                              |     3 +
 sim/or1k/Makefile.in                           |   147 +
 sim/or1k/README                                |   107 +
 sim/or1k/aclocal.m4                            |   119 +
 sim/or1k/arch.c                                |    38 +
 sim/or1k/arch.h                                |    50 +
 sim/or1k/config.in                             |   248 +
 sim/or1k/configure                             | 16043 +++++++++++++++++++++++
 sim/or1k/configure.ac                          |    17 +
 sim/or1k/cpu.c                                 | 10181 ++++++++++++++
 sim/or1k/cpu.h                                 |  5024 +++++++
 sim/or1k/cpuall.h                              |    66 +
 sim/or1k/decode.c                              |  2559 ++++
 sim/or1k/decode.h                              |    94 +
 sim/or1k/mloop.in                              |   241 +
 sim/or1k/model.c                               |  3809 ++++++
 sim/or1k/or1k-sim.h                            |    93 +
 sim/or1k/or1k.c                                |   356 +
 sim/or1k/sem-switch.c                          |  2748 ++++
 sim/or1k/sem.c                                 |  2953 +++++
 sim/or1k/sim-if.c                              |   279 +
 sim/or1k/sim-main.h                            |    81 +
 sim/or1k/traps.c                               |   299 +
 sim/testsuite/configure                        |     4 +
 sim/testsuite/sim/or1k/add.S                   |   639 +
 sim/testsuite/sim/or1k/alltests.exp            |    34 +
 sim/testsuite/sim/or1k/and.S                   |   198 +
 sim/testsuite/sim/or1k/basic.S                 |   522 +
 sim/testsuite/sim/or1k/div.S                   |   291 +
 sim/testsuite/sim/or1k/ext.S                   |   236 +
 sim/testsuite/sim/or1k/find.S                  |   100 +
 sim/testsuite/sim/or1k/flag.S                  |   386 +
 sim/testsuite/sim/or1k/fpu.S                   |   129 +
 sim/testsuite/sim/or1k/jump.S                  |   105 +
 sim/testsuite/sim/or1k/load.S                  |   358 +
 sim/testsuite/sim/or1k/mac.S                   |   778 ++
 sim/testsuite/sim/or1k/mfspr.S                 |   171 +
 sim/testsuite/sim/or1k/mul.S                   |   574 +
 sim/testsuite/sim/or1k/or.S                    |   199 +
 sim/testsuite/sim/or1k/or1k-asm-test-env.h     |    59 +
 sim/testsuite/sim/or1k/or1k-asm-test-helpers.h |   121 +
 sim/testsuite/sim/or1k/or1k-asm-test.h         |   226 +
 sim/testsuite/sim/or1k/or1k-asm.h              |    37 +
 sim/testsuite/sim/or1k/or1k-test.ld            |    75 +
 sim/testsuite/sim/or1k/ror.S                   |   159 +
 sim/testsuite/sim/or1k/shift.S                 |   541 +
 sim/testsuite/sim/or1k/spr-defs.h              |   120 +
 sim/testsuite/sim/or1k/sub.S                   |   215 +
 sim/testsuite/sim/or1k/xor.S                   |   200 +
 55 files changed, 52197 insertions(+), 5 deletions(-)
 create mode 100644 sim/or1k/Makefile.in
 create mode 100644 sim/or1k/README
 create mode 100644 sim/or1k/aclocal.m4
 create mode 100644 sim/or1k/arch.c
 create mode 100644 sim/or1k/arch.h
 create mode 100644 sim/or1k/config.in
 create mode 100755 sim/or1k/configure
 create mode 100644 sim/or1k/configure.ac
 create mode 100644 sim/or1k/cpu.c
 create mode 100644 sim/or1k/cpu.h
 create mode 100644 sim/or1k/cpuall.h
 create mode 100644 sim/or1k/decode.c
 create mode 100644 sim/or1k/decode.h
 create mode 100644 sim/or1k/mloop.in
 create mode 100644 sim/or1k/model.c
 create mode 100644 sim/or1k/or1k-sim.h
 create mode 100644 sim/or1k/or1k.c
 create mode 100644 sim/or1k/sem-switch.c
 create mode 100644 sim/or1k/sem.c
 create mode 100644 sim/or1k/sim-if.c
 create mode 100644 sim/or1k/sim-main.h
 create mode 100644 sim/or1k/traps.c
 create mode 100644 sim/testsuite/sim/or1k/add.S
 create mode 100644 sim/testsuite/sim/or1k/alltests.exp
 create mode 100644 sim/testsuite/sim/or1k/and.S
 create mode 100644 sim/testsuite/sim/or1k/basic.S
 create mode 100644 sim/testsuite/sim/or1k/div.S
 create mode 100644 sim/testsuite/sim/or1k/ext.S
 create mode 100644 sim/testsuite/sim/or1k/find.S
 create mode 100644 sim/testsuite/sim/or1k/flag.S
 create mode 100644 sim/testsuite/sim/or1k/fpu.S
 create mode 100644 sim/testsuite/sim/or1k/jump.S
 create mode 100644 sim/testsuite/sim/or1k/load.S
 create mode 100644 sim/testsuite/sim/or1k/mac.S
 create mode 100644 sim/testsuite/sim/or1k/mfspr.S
 create mode 100644 sim/testsuite/sim/or1k/mul.S
 create mode 100644 sim/testsuite/sim/or1k/or.S
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test-env.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test-helpers.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm-test.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-asm.h
 create mode 100644 sim/testsuite/sim/or1k/or1k-test.ld
 create mode 100644 sim/testsuite/sim/or1k/ror.S
 create mode 100644 sim/testsuite/sim/or1k/shift.S
 create mode 100644 sim/testsuite/sim/or1k/spr-defs.h
 create mode 100644 sim/testsuite/sim/or1k/sub.S
 create mode 100644 sim/testsuite/sim/or1k/xor.S

-- 
2.13.6

