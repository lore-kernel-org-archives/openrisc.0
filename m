From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Jun 2019 06:32:16 +0900
Subject: [OpenRISC] [PATCH v3 0/11] OpenRISC orfpx64a32 and openrisc spec
 1.3 support
Message-ID: <20190608213225.3230-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Its been a while since v2, but we have been busy changing direction a bit.
Instead of just adding the orfpx64a32 extension support we have created a new
architecture specification [0] and this series includes some of those changes.

Changes from v2:

 - Use explicit register pairs in orfpx64a32 extension instead of implicit
   suggestioned by rth.
 - Add unordered FPU comparison instructions.
 - Add test for the previously added l.adrp instruction.
 - A few non material cgen comment/symbol updates.

Changes from v1:

 - Rebased
 - Note Andrey is working on doing his FSF copyright assignment for binutils,
   sim

The orfpx64a32 extension patches are to the OpenRISC assembler and simulator to
support 64-bit floating point operations on 32-bit cores using register pairs,
see orfpx64a32 [1].

The original patches were written by Andrey Bacherov and I have made some
updates to get the simulator working and to match ABI updates for the final
architecture 1.3 specification.

Example of orfpx64a32 operations:

	lf.add.d r3,r4, r5,r6, r7,r8       ; {r3,r4}   <= {r5,r6} + {r7,r8}
	lf.add.d r16,r18, r20,r22, r24,r26 ; {r16,r18} <= {r20,r22} + {r24,r26}

Note, on 64-bit architectures the instructions will be written with 64-bit
registers.

	lf.add.d r3, r5, r7   ; r3  <= r5 + r7
	lf.add.d r16, r20 r24 ; r16 <= r20 + r24

The new unordered comparison instructions allow the OpenRISC FPU to do
comparisons where input may include NaNs [2]

These binutil patches have been used along with the GCC FPU patches [3] on the
OpenRISC GCC 9 toolchain to test single and double precision floating point
support including unordered comparisons.  The main 'real' implementation of this
hardware is Andrey's or1k_marocchino [4] core implementation which we have been
using along with simulators for verification.

This whole patch series can be found on my github repo [5] as well.

[0] https://github.com/openrisc/doc/blob/master/openrisc-arch-1.3-rev1.pdf
[1] https://openrisc.io/proposals/orfpx64a32
[2] https://openrisc.io/proposals/lfsf
[3] git at github.com:stffrdhrn/gcc.git or1k-fpu-2
[4] https://github.com/openrisc/or1k_marocchino
[5] git@github.com:stffrdhrn/binutils-gdb.git orfpx64a32-3

-Stafford

Stafford Horne (11):
  cpu/or1k: Add support for orfp64a32 spec
  cpu/or1k: Define unordered comparisons
  cpu/or1k: Document no branch delay slot architectures and l.adrp
  cpu/or1k: Update fpu compare symbols to imply set flag
  opcodes/or1k: Regenerate opcodes
  sim/or1k: Regenerate sim
  sim/common: Wire in df/di conversion
  sim/common: wire up new unordered comparisons
  sim/testsuite/or1k: Add test for 64-bit fpu operations
  sim/testsuite/or1k: Add test case for l.adrp instruction
  sim/testsuite/or1k: Add tests for unordered compares

 cpu/or1k.cpu                                |   21 +-
 cpu/or1k.opc                                |   92 ++
 cpu/or1kcommon.cpu                          |  113 +-
 cpu/or1korbis.cpu                           |    3 +-
 cpu/or1korfpx.cpu                           |  214 ++-
 opcodes/or1k-asm.c                          |   72 +-
 opcodes/or1k-desc.c                         |  309 +++-
 opcodes/or1k-desc.h                         |  341 ++---
 opcodes/or1k-dis.c                          |   43 +-
 opcodes/or1k-ibld.c                         |  234 ++-
 opcodes/or1k-opc.c                          |  319 +++-
 opcodes/or1k-opc.h                          |   39 +-
 opcodes/or1k-opinst.c                       |  100 +-
 sim/common/cgen-accfp.c                     |   49 +
 sim/common/cgen-fpu.h                       |    2 +
 sim/or1k/arch.c                             |    2 +-
 sim/or1k/arch.h                             |    2 +-
 sim/or1k/cpu.c                              |   78 +-
 sim/or1k/cpu.h                              |  174 ++-
 sim/or1k/cpuall.h                           |    2 +-
 sim/or1k/decode.c                           |  568 ++++++--
 sim/or1k/decode.h                           |   21 +-
 sim/or1k/model.c                            | 1456 ++++++++++++++++---
 sim/or1k/sem-switch.c                       |  602 +++++++-
 sim/or1k/sem.c                              |  672 ++++++++-
 sim/testsuite/sim/or1k/adrp.S               |   73 +
 sim/testsuite/sim/or1k/fpu-unordered.S      |   97 ++
 sim/testsuite/sim/or1k/fpu64a32-unordered.S |  100 ++
 sim/testsuite/sim/or1k/fpu64a32.S           |  172 +++
 29 files changed, 5253 insertions(+), 717 deletions(-)
 create mode 100644 sim/testsuite/sim/or1k/adrp.S
 create mode 100644 sim/testsuite/sim/or1k/fpu-unordered.S
 create mode 100644 sim/testsuite/sim/or1k/fpu64a32-unordered.S
 create mode 100644 sim/testsuite/sim/or1k/fpu64a32.S

-- 
2.21.0

