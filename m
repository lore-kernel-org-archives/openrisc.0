From: guoren@kernel.org <guoren@kernel.org>
Date: Sat, 19 Mar 2022 11:54:52 +0800
Subject: [OpenRISC] [PATCH V2 0/5] Generic Ticket Spinlocks
Message-ID: <20220319035457.2214979-1-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Guo Ren <guoren@linux.alibaba.com>

Palmer:
Peter sent an RFC out about a year ago
<https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>,
but after a spirited discussion it looks like we lost track of things.
IIRC there was broad consensus on this being the way to go, but there
was a lot of discussion so I wasn't sure.  Given that it's been a year,
I figured it'd be best to just send this out again formatted a bit more
explicitly as a patch.

This has had almost no testing (just a build test on RISC-V defconfig),
but I wanted to send it out largely as-is because I didn't have a SOB
from Peter on the code.  I had sent around something sort of similar in
spirit, but this looks completely re-written.  Just to play it safe I
wanted to send out almost exactly as it was posted.  I'd probably rename
this tspinlock and tspinlock_types, as the mis-match kind of makes my
eyes go funny, but I don't really care that much.  I'll also go through
the other ports and see if there's any more candidates, I seem to
remember there having been more than just OpenRISC but it's been a
while.

I'm in no big rush for this and given the complex HW dependencies I
think it's best to target it for 5.19, that'd give us a full merge
window for folks to test/benchmark it on their systems to make sure it's
OK.  RISC-V has a forward progress guarantee so we should be safe, but
these can always trip things up.

Guo:
Update V2 with Arnd's suggestion [1].

[1] https://lore.kernel.org/linux-arch/CAK8P3a0NMPVGVw7===uEOtNnu1hr1GqimMbZT+Kea1CUxRvPmw at mail.gmail.com/raw

Changes in V2:
 - Follow Arnd suggestion to make the patch series more generic.
 - Add csky in the series.
 - Combine RISC-V's two patches into one.
 - Modify openrisc's patch to suit the new generic version.

Guo Ren (1):
  csky: Move to generic ticket-spinlock

Palmer Dabbelt (1):
  RISC-V: Move to ticket-spinlocks & RW locks

Peter Zijlstra (3):
  asm-generic: ticket-lock: New generic ticket-based spinlock
  asm-generic: qspinlock: Indicate the use of mixed-size atomics
  openrisc: Move to ticket-spinlock

 arch/csky/include/asm/Kbuild               |   3 +-
 arch/csky/include/asm/spinlock.h           |  89 --------------
 arch/csky/include/asm/spinlock_types.h     |  27 -----
 arch/openrisc/Kconfig                      |   1 -
 arch/openrisc/include/asm/Kbuild           |   7 +-
 arch/openrisc/include/asm/spinlock.h       |  27 -----
 arch/openrisc/include/asm/spinlock_types.h |   7 --
 arch/riscv/Kconfig                         |   1 +
 arch/riscv/include/asm/Kbuild              |   2 +
 arch/riscv/include/asm/spinlock.h          | 135 ---------------------
 arch/riscv/include/asm/spinlock_types.h    |  25 ----
 include/asm-generic/qspinlock.h            |  30 +++++
 include/asm-generic/spinlock.h             |  11 +-
 include/asm-generic/spinlock_types.h       |  15 +++
 include/asm-generic/ticket-lock-types.h    |  11 ++
 include/asm-generic/ticket-lock.h          |  86 +++++++++++++
 16 files changed, 157 insertions(+), 320 deletions(-)
 delete mode 100644 arch/csky/include/asm/spinlock.h
 delete mode 100644 arch/csky/include/asm/spinlock_types.h
 delete mode 100644 arch/openrisc/include/asm/spinlock.h
 delete mode 100644 arch/openrisc/include/asm/spinlock_types.h
 delete mode 100644 arch/riscv/include/asm/spinlock.h
 delete mode 100644 arch/riscv/include/asm/spinlock_types.h
 create mode 100644 include/asm-generic/spinlock_types.h
 create mode 100644 include/asm-generic/ticket-lock-types.h
 create mode 100644 include/asm-generic/ticket-lock.h

-- 
2.25.1

