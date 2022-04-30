From: Palmer Dabbelt <palmer@rivosinc.com>
Date: Sat, 30 Apr 2022 08:36:19 -0700
Subject: [OpenRISC] [PATCH v4 0/7] Generic Ticket Spinlocks
Message-ID: <20220430153626.30660-1-palmer@rivosinc.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Comments on the v3 looked pretty straight-forward, essentially just that
RCsc issue I'd missed from the v2 and some cleanups.  A part of the
discussion some additional possible cleanups came up related to the
qrwlock headers, but I hadn't looked at those yet and I had already
handled everything else.  This went on the back burner, but given that
LoongArch appears to want to use it for their new port I think it's best
to just run with this and defer the other cleanups until later.

I've placed the whole patch set at palmer/tspinlock-v4, and also tagged
the asm-generic bits as generic-ticket-spinlocks-v4.  Ideally I'd like
to take that, along with the RISC-V patches, into my tree as there's
some RISC-V specific testing before things land in linux-next.  This
passes all my testing, but I'll hold off until merging things anywhere
else to make sure everyone has time to look.  There's no rush on my end
for this one, but I don't want to block LoongArch so I'll try to stay a
bit more on top of this one.

Changes since v3 <20220414220214.24556-1-palmer@rivosinc.com>:
* Added a smp_mb() in the lock slow-path, to make sure that is RCsc.
* Fixed the header guards.

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


