From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 Apr 2019 11:17:46 -1000
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
Message-ID: <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 4/12/19 10:56 AM, Stafford Horne wrote:
> P14 https://openrisc.io/proposals/orfpx64a32 - 64-bit fpu implemented in
> marocchino (gcc/bintuils patches under review)

I don't see an encoding for this in the proposal.

I'm a tad nervous about forcing the (weird) ABI into the ISA, by using reg+2
when reg >= 16.  Are there 3 bits in the instruction that could be used to flag
reg+1 vs reg+2?  Then it's a matter of using

	lf.add.d rd1, rd2, ra1, ra2, rb1, rb2

in the assembler, and having the assembler enforce rx2 = rx1+{1,2}, and setting
the appropriate bit in the instruction.

I realize this comment is coming in quite late to your development...


r~
