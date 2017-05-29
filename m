From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 May 2017 23:47:25 +0900
Subject: [OpenRISC] [PATCH v4 0/5] sim port for OpenRISC
Message-ID: <cover.1496066478.git.shorne@gmail.com>
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
 - Openrisc supports a l.rem instruction which has been implemented here
   using the remainder() function from libmath.  It seems no other
   functions use libmath now, I hope this is ok.

Sim dejagnu tests were added specifically for openrisc and used to test
this.  Please see the details of running the testsuite for sim below:

=== sim Summary ===

# of expected passes            17
/home/shorne/work/openrisc/build-gdb/sim/or1k/run 0.5

-Stafford

--

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

--

Peter Gavin (3):
  sim: cgen: add remainder functions (needed for OR1K lf.rem.[sd])
  sim: cgen: add MUL2OFSI and MUL1OFSI macros (needed for OR1K l.mul[u])
  sim: testsuite: add testsuite for or1k sim

Stafford Horne (2):
  sim: or1k: add or1k target to sim
  sim: or1k: Add generated files.

 sim/common/cgen-accfp.c                        |    40 +
 sim/common/cgen-fpu.h                          |     4 +
 sim/common/cgen-ops.h                          |    18 +
 sim/common/sim-fpu.c                           |    63 +
 sim/common/sim-fpu.h                           |     3 +
 sim/configure                                  |     9 +
 sim/configure.tgt                              |     4 +
 sim/or1k/Makefile.in                           |   142 +
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
 sim/or1k/eng.h                                 |    34 +
 sim/or1k/mloop.in                              |   242 +
 sim/or1k/model.c                               |  3809 ++++++
 sim/or1k/or1k-sim.h                            |    94 +
 sim/or1k/or1k.c                                |   328 +
 sim/or1k/sem-switch.c                          |  2748 ++++
 sim/or1k/sem.c                                 |  2953 +++++
 sim/or1k/sim-if.c                              |   270 +
 sim/or1k/sim-main.h                            |    80 +
 sim/or1k/traps.c                               |   209 +
 sim/testsuite/configure                        |     4 +
 sim/testsuite/sim/or1k/add.S                   |   606 +
 sim/testsuite/sim/or1k/alltests.exp            |    34 +
 sim/testsuite/sim/or1k/and.S                   |   198 +
 sim/testsuite/sim/or1k/basic.S                 |   522 +
 sim/testsuite/sim/or1k/div.S                   |   290 +
 sim/testsuite/sim/or1k/ext.S                   |   236 +
 sim/testsuite/sim/or1k/find.S                  |   100 +
 sim/testsuite/sim/or1k/flag.S                  |   378 +
 sim/testsuite/sim/or1k/jump.S                  |   104 +
 sim/testsuite/sim/or1k/load.S                  |   358 +
 sim/testsuite/sim/or1k/mac.S                   |   778 ++
 sim/testsuite/sim/or1k/mfspr.S                 |   171 +
 sim/testsuite/sim/or1k/mul.S                   |   573 +
 sim/testsuite/sim/or1k/or.S                    |   199 +
 sim/testsuite/sim/or1k/or1k-asm-test-env.h     |    59 +
 sim/testsuite/sim/or1k/or1k-asm-test-helpers.h |   121 +
 sim/testsuite/sim/or1k/or1k-asm-test.h         |   225 +
 sim/testsuite/sim/or1k/or1k-asm.h              |    37 +
 sim/testsuite/sim/or1k/or1k-test.ld            |    75 +
 sim/testsuite/sim/or1k/ror.S                   |   159 +
 sim/testsuite/sim/or1k/shift.S                 |   541 +
 sim/testsuite/sim/or1k/spr-defs.h              |   120 +
 sim/testsuite/sim/or1k/sub.S                   |   201 +
 sim/testsuite/sim/or1k/xor.S                   |   200 +
 54 files changed, 51778 insertions(+)
 create mode 100644 sim/or1k/Makefile.in
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
 create mode 100644 sim/or1k/eng.h
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
2.9.4

