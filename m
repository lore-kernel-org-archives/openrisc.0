From: Stafford Horne <shorne@gmail.com>
Date: Thu, 11 Apr 2019 06:27:44 +0900
Subject: [OpenRISC] [PATCH 0/3] OpenRISC floating point support + fixes
Message-ID: <20190410212747.18377-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This is a set of patches to bring FPU support to the OpenRISC backend.  The
backend also add support for 64-bit floating point operations on 32-bit cores
using register pairs, see orfpx64a32 [0].

This depends on binutils patches which have also been submitted per review. [1]

The toolchain has been tested using the gcc and binutils testsuites as well as
floating point test suites running on sim and an fpga soft core or1k_marocchino.
[2]

There is also an unrelated, but trivial patch to fix a code quality issue with
volatile memory loads.

This whole patch series can be found on my github repo [3] as well.

-Stafford

[0] https://openrisc.io/proposals/orfpx64a32
[1] git at github.com:stffrdhrn/binutils-gdb.git orfpx64a32-2
[2] https://github.com/openrisc/or1k_marocchino
[3] git at github.com:stffrdhrn/gcc.git or1k-fpu-1a

Stafford Horne (3):
  or1k: Initial support for FPU
  or1k: Allow volatile memory for sign/zero extend loads
  or1k: only force reg for immediates

 gcc/config.gcc                |   1 +
 gcc/config/or1k/or1k.c        |  10 ++--
 gcc/config/or1k/or1k.md       | 109 ++++++++++++++++++++++++++++++++--
 gcc/config/or1k/or1k.opt      |  15 ++++-
 gcc/config/or1k/predicates.md |  16 +++++
 gcc/doc/invoke.texi           |  15 +++++
 6 files changed, 156 insertions(+), 10 deletions(-)

-- 
2.19.1

