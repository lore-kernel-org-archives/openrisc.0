From: Guo Ren <guoren@kernel.org>
Date: Fri, 18 Mar 2022 16:40:18 +0800
Subject: [OpenRISC] [PATCH 0/5] Generic Ticket Spinlocks
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
Message-ID: <CAJF2gTQdhnxJ3gaJDCnd7-boz83GMxaW7tTNaA9hSHs92L_Zig@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Palmer,

Tested-by: Guo Ren <guoren@kernel.org>

Could help involve the below patch in your series?

https://lore.kernel.org/linux-arch/20220318083421.2062259-1-guoren at kernel.org/T/#u

On Thu, Mar 17, 2022 at 1:14 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
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



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
