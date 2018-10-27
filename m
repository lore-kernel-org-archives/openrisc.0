From: Stafford Horne <shorne@gmail.com>
Date: Sat, 27 Oct 2018 13:36:59 +0900
Subject: [OpenRISC] [PATCH v3 0/3] OpenRISC port
Message-ID: <20181027043702.18414-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Changes Since v2:
 - Add RTEMS patches from Joel Sherrill
 - Disable t-softfp-excl as suggsted by Joseph Myers
 - Add new architecture flags needed to run on real FPGA's found in testing
   * -mror - enable l.ror (rotate right)
   * -mshftimm - enable shift/rorate by immediate instructions
 - Binutils requirements are now in upstream git

Changes Since v1:
 - Document options in invoke.texi suggested by Joseph Myers
 - Remove obsolete/incorrect macros suggested by Joseph Myers
 - Documented or1k.c functions as requested by Jeff Law
 - Add epilogue barriers suggested by Jeff Law
 - Define SPECULATION_SAFE_VALUE suggested by Jeff Law
 - Switch to init/fini array suggested by Richard Henderson
 - Define and document multilib flags to enable disable instructions only
   available on some CPU cores as requested on OpenRISC mailing list.

Since February this year I have been working on an OpenRISC clean room rewrite.

  http://stffrdhrn.github.io/software/embedded/openrisc/2018/02/03/openrisc_gcc_rewrite.html

As per the article, the old port had issues with some of the owners signing over
FSF copyright.  To get around this I discussed options with the group and in the
end I opted for a clean room rewrite.

The new code base has been written by me with lots of help from Richard
Henderson.  I trust that both of us have our FSF GCC copyright's in place.

# Testing

We have been running the GCC testsuite with newlib and musl libc.  The results
are good.  See results published in a test build/release here:

 - https://github.com/stffrdhrn/gcc/releases/tag/or1k-9.0.0-20181027

# Building

To build this requires the latest binutils upstream master i.e. 2.31.52.

-Stafford

Stafford Horne (3):
  or1k: libgcc: initial support for openrisc
  or1k: testsuite: initial support for openrisc
  or1k: gcc: initial support for openrisc

 gcc/common/config/or1k/or1k-common.c          |   41 +
 gcc/config.gcc                                |   45 +
 gcc/config/or1k/constraints.md                |   55 +
 gcc/config/or1k/elf.h                         |   42 +
 gcc/config/or1k/elf.opt                       |   33 +
 gcc/config/or1k/linux.h                       |   44 +
 gcc/config/or1k/or1k-protos.h                 |   38 +
 gcc/config/or1k/or1k.c                        | 2186 +++++++++++++++++
 gcc/config/or1k/or1k.h                        |  392 +++
 gcc/config/or1k/or1k.md                       |  907 +++++++
 gcc/config/or1k/or1k.opt                      |   67 +
 gcc/config/or1k/predicates.md                 |   84 +
 gcc/config/or1k/rtems.h                       |   30 +
 gcc/config/or1k/t-or1k                        |   22 +
 gcc/config/or1k/t-rtems                       |    3 +
 gcc/configure                                 |   12 +
 gcc/configure.ac                              |   12 +
 gcc/doc/install.texi                          |   19 +
 gcc/doc/invoke.texi                           |   68 +
 gcc/doc/md.texi                               |   25 +
 .../gcc.c-torture/execute/20101011-1.c        |    3 +
 gcc/testsuite/gcc.dg/20020312-2.c             |    2 +
 gcc/testsuite/gcc.dg/attr-alloc_size-11.c     |    4 +-
 gcc/testsuite/gcc.dg/builtin-apply2.c         |    2 +-
 gcc/testsuite/gcc.dg/nop.h                    |    2 +
 .../torture/stackalign/builtin-apply-2.c      |    2 +-
 gcc/testsuite/gcc.dg/tree-ssa/20040204-1.c    |    2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-33.c    |    2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-34.c    |    2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-35.c    |    2 +-
 gcc/testsuite/gcc.dg/tree-ssa/reassoc-36.c    |    2 +-
 gcc/testsuite/gcc.target/or1k/args-1.c        |   19 +
 gcc/testsuite/gcc.target/or1k/args-2.c        |   15 +
 gcc/testsuite/gcc.target/or1k/cmov-1.c        |    8 +
 gcc/testsuite/gcc.target/or1k/cmov-2.c        |    9 +
 gcc/testsuite/gcc.target/or1k/div-mul-1.c     |    9 +
 gcc/testsuite/gcc.target/or1k/div-mul-2.c     |    9 +
 gcc/testsuite/gcc.target/or1k/or1k.exp        |   41 +
 gcc/testsuite/gcc.target/or1k/return-1.c      |   10 +
 gcc/testsuite/gcc.target/or1k/return-2.c      |   19 +
 gcc/testsuite/gcc.target/or1k/return-3.c      |   19 +
 gcc/testsuite/gcc.target/or1k/return-4.c      |   19 +
 gcc/testsuite/gcc.target/or1k/ror-1.c         |    8 +
 gcc/testsuite/gcc.target/or1k/ror-2.c         |    9 +
 gcc/testsuite/gcc.target/or1k/ror-3.c         |    8 +
 gcc/testsuite/gcc.target/or1k/shftimm-1.c     |    8 +
 gcc/testsuite/gcc.target/or1k/shftimm-2.c     |    8 +
 gcc/testsuite/gcc.target/or1k/sibcall-1.c     |   18 +
 gcc/testsuite/lib/target-supports.exp         |    1 +
 libgcc/config.host                            |   13 +
 libgcc/config/or1k/crti.S                     |   33 +
 libgcc/config/or1k/crtn.S                     |    1 +
 libgcc/config/or1k/lib1funcs.S                |  223 ++
 libgcc/config/or1k/linux-unwind.h             |   87 +
 libgcc/config/or1k/sfp-machine.h              |   54 +
 libgcc/config/or1k/t-or1k                     |   22 +
 56 files changed, 4811 insertions(+), 9 deletions(-)
 create mode 100644 gcc/common/config/or1k/or1k-common.c
 create mode 100644 gcc/config/or1k/constraints.md
 create mode 100644 gcc/config/or1k/elf.h
 create mode 100644 gcc/config/or1k/elf.opt
 create mode 100644 gcc/config/or1k/linux.h
 create mode 100644 gcc/config/or1k/or1k-protos.h
 create mode 100644 gcc/config/or1k/or1k.c
 create mode 100644 gcc/config/or1k/or1k.h
 create mode 100644 gcc/config/or1k/or1k.md
 create mode 100644 gcc/config/or1k/or1k.opt
 create mode 100644 gcc/config/or1k/predicates.md
 create mode 100644 gcc/config/or1k/rtems.h
 create mode 100644 gcc/config/or1k/t-or1k
 create mode 100644 gcc/config/or1k/t-rtems
 create mode 100644 gcc/testsuite/gcc.target/or1k/args-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/args-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/cmov-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/cmov-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/div-mul-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/div-mul-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/or1k.exp
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-3.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/return-4.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-3.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/shftimm-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/shftimm-2.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/sibcall-1.c
 create mode 100644 libgcc/config/or1k/crti.S
 create mode 100644 libgcc/config/or1k/crtn.S
 create mode 100644 libgcc/config/or1k/lib1funcs.S
 create mode 100644 libgcc/config/or1k/linux-unwind.h
 create mode 100644 libgcc/config/or1k/sfp-machine.h
 create mode 100644 libgcc/config/or1k/t-or1k

-- 
2.17.1

