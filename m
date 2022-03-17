From: Heiko =?unknown-8bit?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Thu, 17 Mar 2022 12:09:39 +0100
Subject: [OpenRISC] [PATCH 0/5] Generic Ticket Spinlocks
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
Message-ID: <11364105.8ZH9dyz9j6@diego>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi,

Am Donnerstag, 17. März 2022, 00:25:55 CET schrieb Palmer Dabbelt:
> Peter sent an RFC out about a year ago
> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>,
> but after a spirited discussion it looks like we lost track of things.
> IIRC there was broad consensus on this being the way to go, but there
> was a lot of discussion so I wasn't sure.  Given that it's been a year,
> I figured it'd be best to just send this out again formatted a bit more
> explicitly as a patch.
> 
> This has had almost no testing (just a build test on RISC-V defconfig),
> but I wanted to send it out largely as-is because I didn't have a SOB
> from Peter on the code.  I had sent around something sort of similar in
> spirit, but this looks completely re-written.  Just to play it safe I
> wanted to send out almost exactly as it was posted.  I'd probably rename
> this tspinlock and tspinlock_types, as the mis-match kind of makes my
> eyes go funny, but I don't really care that much.  I'll also go through
> the other ports and see if there's any more candidates, I seem to
> remember there having been more than just OpenRISC but it's been a
> while.
> 
> I'm in no big rush for this and given the complex HW dependencies I
> think it's best to target it for 5.19, that'd give us a full merge
> window for folks to test/benchmark it on their systems to make sure it's
> OK.  RISC-V has a forward progress guarantee so we should be safe, but
> these can always trip things up.

I've tested this on both the Qemu-Virt machine as well as the
Allwinner Nezha board (with a D1 SoC).

Both of those are of course not necessarily the best platforms
for benchmarks I guess, as from what I gathered before I'd need
need multiple cores to actually get interesting measurements when
comparing different implementations. But at least everything that
worked before still works with this series ;-)


So, Series
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko


