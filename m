From: Stafford Horne <shorne@gmail.com>
Date: Sat, 21 Jan 2017 12:03:49 +0900
Subject: [OpenRISC] [PATCH v2 0/6] sim: Port for OpenRISC
Message-ID: <cover.1484967575.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Please find attached the sim patches that allow to get a basic OpenRISC
system running.  This was used to verify the OpenRISC gdb port.

The main author is Peter Gavin who should have his FSF copyright in place.

Also some new tests were added specifically for openrisc. Please see the
details of running the testsuite for sim below:

=== sim Summary ===

# of expected passes            17
/home/shorne/work/openrisc/build-gdb/sim/or1k/run 0.5

Thanks,
-Stafford

--

Changes since v1
 * Squashed sim patches into single sim patch
 * Put Generated files in separate patch
 * I have my sim/gdb copyright assignment complete

Peter Gavin (4):
  sim: cgen: add rem (remainder) function (needed for OR1K lf.rem.[sd])
  sim: cgen: add mul-o1flag, mul-o2flag RTL functions to CGEN
  sim: cgen: allow suffix on generated arch.[ch] and cpuall.h
  sim: testsuite: add testsuite for or1k sim

Stafford Horne (2):
  sim: or1k: add or1k target to sim
  sim: or1k: Add generated files.

 sim/common/Make-common.in                      |     2 +-
 sim/common/cgen-accfp.c                        |    40 +
 sim/common/cgen-fpu.h                          |     4 +
 sim/common/cgen-ops.h                          |    18 +
 sim/common/cgen.sh                             |     6 +-
 sim/common/sim-fpu.c                           |    66 +
 sim/common/sim-fpu.h                           |     3 +
 sim/configure                                  |     9 +
 sim/configure.tgt                              |     4 +
 sim/or1k/Makefile.in                           |   232 +
 sim/or1k/aclocal.m4                            |   119 +
 sim/or1k/arch.h                                |     5 +
 sim/or1k/arch32.c                              |    38 +
 sim/or1k/arch32.h                              |    50 +
 sim/or1k/arch64.c                              |    38 +
 sim/or1k/arch64.h                              |    50 +
 sim/or1k/config.in                             |   248 +
 sim/or1k/configure                             | 16071 +++++++++++++++++++++++
 sim/or1k/configure.ac                          |    41 +
 sim/or1k/cpu.h                                 |     5 +
 sim/or1k/cpu32.c                               | 10181 ++++++++++++++
 sim/or1k/cpu32.h                               |  5018 +++++++
 sim/or1k/cpu64.c                               | 10197 ++++++++++++++
 sim/or1k/cpu64.h                               |  5068 +++++++
 sim/or1k/cpuall.h                              |     5 +
 sim/or1k/cpuall32.h                            |    66 +
 sim/or1k/cpuall64.h                            |    66 +
 sim/or1k/decode.h                              |     5 +
 sim/or1k/decode32.c                            |  2559 ++++
 sim/or1k/decode32.h                            |    94 +
 sim/or1k/decode64.c                            |  2723 ++++
 sim/or1k/decode64.h                            |    97 +
 sim/or1k/eng.h                                 |     5 +
 sim/or1k/mloop.in                              |   244 +
 sim/or1k/model32.c                             |  3809 ++++++
 sim/or1k/model64.c                             |   135 +
 sim/or1k/or1k-sim.h                            |    21 +
 sim/or1k/or1k.c                                |   271 +
 sim/or1k/or1k.h                                |    38 +
 sim/or1k/sem32-switch.c                        |  2748 ++++
 sim/or1k/sem32.c                               |  2953 +++++
 sim/or1k/sem64-switch.c                        |  3044 +++++
 sim/or1k/sem64.c                               |  3279 +++++
 sim/or1k/sim-if.c                              |   318 +
 sim/or1k/sim-main.h                            |    78 +
 sim/or1k/traps-linux.c                         |    32 +
 sim/or1k/traps.c                               |   181 +
 sim/testsuite/configure                        |     4 +
 sim/testsuite/sim/or1k/add.S                   |   546 +
 sim/testsuite/sim/or1k/alltests.exp            |    19 +
 sim/testsuite/sim/or1k/and.S                   |   208 +
 sim/testsuite/sim/or1k/basic.S                 |   535 +
 sim/testsuite/sim/or1k/div.S                   |   198 +
 sim/testsuite/sim/or1k/ext.S                   |   251 +
 sim/testsuite/sim/or1k/find.S                  |   119 +
 sim/testsuite/sim/or1k/flag.S                  |   405 +
 sim/testsuite/sim/or1k/jump.S                  |   121 +
 sim/testsuite/sim/or1k/load.S                  |   373 +
 sim/testsuite/sim/or1k/mac.S                   |   785 ++
 sim/testsuite/sim/or1k/mfspr.S                 |   196 +
 sim/testsuite/sim/or1k/mul.S                   |   277 +
 sim/testsuite/sim/or1k/or.S                    |   207 +
 sim/testsuite/sim/or1k/or1k-asm-test-env.h     |    61 +
 sim/testsuite/sim/or1k/or1k-asm-test-helpers.h |   134 +
 sim/testsuite/sim/or1k/or1k-asm-test.h         |   258 +
 sim/testsuite/sim/or1k/or1k-asm.h              |    20 +
 sim/testsuite/sim/or1k/or1k-test.ld            |    57 +
 sim/testsuite/sim/or1k/ror.S                   |   186 +
 sim/testsuite/sim/or1k/shift.S                 |   572 +
 sim/testsuite/sim/or1k/spr-defs.h              |   590 +
 sim/testsuite/sim/or1k/sub.S                   |   176 +
 sim/testsuite/sim/or1k/xor.S                   |   210 +
 72 files changed, 76788 insertions(+), 4 deletions(-)
 create mode 100644 sim/or1k/Makefile.in
 create mode 100644 sim/or1k/aclocal.m4
 create mode 100644 sim/or1k/arch.h
 create mode 100644 sim/or1k/arch32.c
 create mode 100644 sim/or1k/arch32.h
 create mode 100644 sim/or1k/arch64.c
 create mode 100644 sim/or1k/arch64.h
 create mode 100644 sim/or1k/config.in
 create mode 100644 sim/or1k/configure
 create mode 100644 sim/or1k/configure.ac
 create mode 100644 sim/or1k/cpu.h
 create mode 100644 sim/or1k/cpu32.c
 create mode 100644 sim/or1k/cpu32.h
 create mode 100644 sim/or1k/cpu64.c
 create mode 100644 sim/or1k/cpu64.h
 create mode 100644 sim/or1k/cpuall.h
 create mode 100644 sim/or1k/cpuall32.h
 create mode 100644 sim/or1k/cpuall64.h
 create mode 100644 sim/or1k/decode.h
 create mode 100644 sim/or1k/decode32.c
 create mode 100644 sim/or1k/decode32.h
 create mode 100644 sim/or1k/decode64.c
 create mode 100644 sim/or1k/decode64.h
 create mode 100644 sim/or1k/eng.h
 create mode 100644 sim/or1k/mloop.in
 create mode 100644 sim/or1k/model32.c
 create mode 100644 sim/or1k/model64.c
 create mode 100644 sim/or1k/or1k-sim.h
 create mode 100644 sim/or1k/or1k.c
 create mode 100644 sim/or1k/or1k.h
 create mode 100644 sim/or1k/sem32-switch.c
 create mode 100644 sim/or1k/sem32.c
 create mode 100644 sim/or1k/sem64-switch.c
 create mode 100644 sim/or1k/sem64.c
 create mode 100644 sim/or1k/sim-if.c
 create mode 100644 sim/or1k/sim-main.h
 create mode 100644 sim/or1k/traps-linux.c
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
2.9.3

