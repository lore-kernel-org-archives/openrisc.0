From: Palmer Dabbelt <palmer@rivosinc.com>
Date: Thu, 14 Apr 2022 15:02:07 -0700
Subject: [OpenRISC] [PATCH v3 0/7] Generic Ticket Spinlocks
Message-ID: <20220414220214.24556-1-palmer@rivosinc.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Looks like feedback has been largely positive on this one.  I think I
got everything from the v1 and v2, but it was a bit mixed up so sorry if
I missed something.  I'm generally being conservative on the tags here,
as things have drifted around a bit.  Specifically I dropped the
Tested-bys, as this is all based on 5.18-rc1 now and there's been a
touch of diff.

I've put this at palmer/tspinlock-v3, in case that helps anyone.  This
generally looks good to me, but I'll wait for feedback before putting it
anywhere else.  I'd default to doing a shared tag for the asm-generic
stuff and then let other arch folks pull in that (with their arch
support), but if you want me to take it via my tree then feel free to
just say so explicitly.  What's on that branch right now definately
shouldn't be treated as stable, though, as I'll wait for at least an
official Ack/Review from the asm-generic folks (and of course there may
be more feedback).

This passes my standard tests, both as the whole thing and as just the
RISC-V spinlock change.  That's just QEMU, though, so it's not all that
exciting.

Changes since v2 <20220319035457.2214979-1-guoren@kernel.org>:
* Picked up Peter's SOBs, which were posted on the v1.
* Re-ordered the first two patches, as they
* Re-worded the RISC-V qrwlock patch, as it was a bit mushy.  I also
  added a blurb in the qrwlock's top comment about this dependency.
* Picked up Stafford's fix for big-endian systems, which I have not
  tested as I don't have one (at least easily availiable, I think the BE
  MIPS systems are still in that pile in my garage).
* Call the generic version <asm-genenic/spinlock{_types}.h>, as there's
  really no utility to the version that only errors out.

Changes since v1 <20220316232600.20419-1-palmer@rivosinc.com>:
* Follow Arnd suggestion to make the patch series more generic.
* Add csky in the series.
* Combine RISC-V's two patches into one.
* Modify openrisc's patch to suit the new generic version.
