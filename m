From: Stafford Horne <shorne@gmail.com>
Date: Wed,  3 Jul 2019 12:33:46 +0900
Subject: [OpenRISC] [PATCH v2 0/5] OpenRISC updates for 10 (fpu, fixes)
Message-ID: <20190703033351.11924-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

It's been about 2 months since I last sent these patches.  Sorry for the delay
I ended up getting side tracked finishing the new OpenRISC architecture spec
revision.

New since v1:
 - Changed 64-bit FPU operations to use explicit register pairs as per spec
   revision suggested by Richard Henderson.
 - Added patch for new -mrori option
 - Added patch for msoft-div fix from other series (no changes)
 - Fixed volatile spelling pointed out by Bernhard 
   Reutner-Fischer <rep.dot.nop@gmail.com>

This is a set of patches to bring FPU support to the OpenRISC backend.  The
backend also add support for 64-bit floating point operations on 32-bit cores
using register pairs, see orfpx64a32 [0].

This binutils patches are already upstream.

The toolchain has been tested using the gcc and binutils testsuites as well as
floating point test suites running on sim and an fpga soft core or1k_marocchino.
[1]

I have also included a few fixes to PRs:

 - 90362 or1k: Soft divide does not work correctly
 - 90363 or1k: Extra mask insn after load from memory

This whole patch series can be found on my github repo [2] as well.

If all is OK, I plan to commit these to master (gcc 10).  Then back port the PR
fixes to the GCC 9 branch, I will ask for guidance when I start to do the
backporting.

-Stafford

[0] https://openrisc.io/proposals/orfpx64a32
[1] https://github.com/openrisc/or1k_marocchino
[2] git at github.com:stffrdhrn/gcc.git or1k-fpu-2

Stafford Horne (5):
  or1k: Fix code quality for volatile memory loads
  or1k: Fix issues with msoft-div
  or1k: Add mrori option, fix option docs
  or1k: Initial support for FPU
  or1k: only force reg for immediates

 gcc/config.gcc                            |   2 +
 gcc/config/or1k/constraints.md            |   4 +
 gcc/config/or1k/elf.opt                   |   6 +-
 gcc/config/or1k/or1k.c                    |  48 ++++++--
 gcc/config/or1k/or1k.h                    |   3 +
 gcc/config/or1k/or1k.md                   | 129 ++++++++++++++++++++--
 gcc/config/or1k/or1k.opt                  |  78 +++++++++----
 gcc/config/or1k/predicates.md             |  23 ++++
 gcc/doc/invoke.texi                       |  77 ++++++++-----
 gcc/testsuite/gcc.target/or1k/div-mul-3.c |  31 ++++++
 gcc/testsuite/gcc.target/or1k/ror-4.c     |   8 ++
 gcc/testsuite/gcc.target/or1k/shftimm-1.c |   8 +-
 gcc/testsuite/gcc.target/or1k/swap-1.c    |  70 ++++++++++++
 gcc/testsuite/gcc.target/or1k/swap-2.c    |  47 ++++++++
 libgcc/config/or1k/lib1funcs.S            |   6 +-
 15 files changed, 465 insertions(+), 75 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/div-mul-3.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/ror-4.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/swap-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/swap-2.c

-- 
2.21.0

