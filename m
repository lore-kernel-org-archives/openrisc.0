From: Stafford Horne <shorne@gmail.com>
Date: Wed, 10 Apr 2019 06:39:19 +0900
Subject: [OpenRISC] [PATCH v2 0/6] OpenRISC orfpx64a32 support
Message-ID: <20190409213925.32699-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

This is basically a resend, but properly including binutils list.

Changes from v1:

 - Rebased
 - Note Andrey is working on doing his FSF copyright assignment for binutils, sim

This is a set of patches to the OpenRISC assembler and simulator to support
64-bit floating point operations on 32-bit cores using register pairs, see
orfpx64a32 [0].

The original patches were written by Andrey Bacherov and I have made some
updates to get the simulator working and to match ABI updates from GCC 9.  The
main GCC 9 ABI change is to have r16 and above pair with an n+2 register rather
than n+1.  This is done because openrisc callee saved registers are r14-r30
(even).  If a 64-bit value was stored in {r16,r17}, it would always need to be
spilled across function calls as r17 is volatile.  Therefore, values of 64-bits
and greater are stored in even reg pairs, such as {r16,r18}.

Example of orfpx64a32 operations:

	lf.add.d r4, r6, r8    ; {r3,r4}   <= {r5,r6} + {r7,r8}
	lf.add.d r16, r20, r24 ; {r16,r18} <= {r20,r22} + {r24,r26}

These binutil patches have been used along with the GCC FPU patches [1] on the
OpenRISC GCC 9 toolchain to test single and double precision floating point
support.  The main 'real' implementation of this hardware is Andrey's
or1k_marocchino [2] core implementation which we have been using along with
simulators for verification.

This whole patch series can be found on my github repo [3] as well.

[0] https://openrisc.io/proposals/orfpx64a32
[1] git at github.com:stffrdhrn/gcc.git or1k-fpu-1
[2] https://github.com/openrisc/or1k_marocchino
[3] git@github.com:stffrdhrn/binutils-gdb.git orfpx64a32-2


Stafford Horne (6):
  cpu: Add support for orfp64a32 spec
  opcodes: Regenerate opcodes for orfp64a32 spec
  sim/or1k: Regenerate sim for orfp64a32 spec
  sim/common: Wire in df/di conversion
  sim/or1k: Add test for 64-bit fpu operations
  sim/common: Fix issue with wrong byte order on BE targets

 cpu/or1k.cpu                      |  15 +-
 cpu/or1kcommon.cpu                | 103 ++++--
 cpu/or1korfpx.cpu                 | 113 +++++--
 opcodes/or1k-asm.c                |  19 +-
 opcodes/or1k-desc.c               | 227 +++++++++++--
 opcodes/or1k-desc.h               | 330 +++++++++----------
 opcodes/or1k-dis.c                |  19 +-
 opcodes/or1k-ibld.c               | 114 ++++++-
 opcodes/or1k-opc.c                | 166 ++++++++--
 opcodes/or1k-opc.h                |  21 +-
 opcodes/or1k-opinst.c             |  51 +++
 sim/common/cgen-accfp.c           |  24 ++
 sim/common/cgen-ops.h             |   8 +-
 sim/or1k/cpu.c                    |  60 +++-
 sim/or1k/cpu.h                    | 115 ++++++-
 sim/or1k/decode.c                 | 302 ++++++++++++++----
 sim/or1k/decode.h                 |  16 +-
 sim/or1k/model.c                  | 510 ++++++++++++++++++++++++++++++
 sim/or1k/sem-switch.c             | 296 +++++++++++++++++
 sim/or1k/sem.c                    | 326 +++++++++++++++++++
 sim/testsuite/sim/or1k/fpu64a32.S | 172 ++++++++++
 21 files changed, 2637 insertions(+), 370 deletions(-)
 create mode 100644 sim/testsuite/sim/or1k/fpu64a32.S

-- 
2.19.1

