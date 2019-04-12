From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Apr 2019 06:48:43 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
Message-ID: <20190412214843.GB32284@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Richard,

On Fri, Apr 12, 2019 at 11:17:46AM -1000, Richard Henderson wrote:
> On 4/12/19 10:56 AM, Stafford Horne wrote:
> > P14 https://openrisc.io/proposals/orfpx64a32 - 64-bit fpu implemented in
> > marocchino (gcc/bintuils patches under review)
> 
> I don't see an encoding for this in the proposal.

Right, because it's proposing to just use the existing encodings.

> I'm a tad nervous about forcing the (weird) ABI into the ISA, by using reg+2
> when reg >= 16.  Are there 3 bits in the instruction that could be used to flag
> reg+1 vs reg+2?  Then it's a matter of using
> 
> 	lf.add.d rd1, rd2, ra1, ra2, rb1, rb2
> 
> in the assembler, and having the assembler enforce rx2 = rx1+{1,2}, and setting
> the appropriate bit in the instruction.

Thanks for your feedback, I think this can be done.  I looked through the
encodings and {10,9,8} look usable.

   31  26  21  16  11     8      0
  [ 0x32 | D | A | B | res | 0x10 ]    lf.add.d
  [ 0x32 | D | A | B | res | 0x11 ]    lf.sub.d
                      ...

   31  26    21  16  11     8      0
  [ 0x32 | res | A | B | res | 0x18 ]  lf.sfeq.d
  [ 0x32 | res | A | B | res | 0x19 ]  lf.sfne.d
                      ...

   31  26  21  16    11     8      0
  [ 0x32 | D | A | 0x0 | res | 0x15 ]  lf.ftoi.d
  [ 0x32 | D | A | 0x0 | res | 0x14 ]  lf.itof.d

I propose:

  bit-10 - 1 indicates if rd2 is +2
  bit-9  - 1 indicates if ra2 is +2
  bit-8  - 1 indicates if rb2 is +2

But, this does mean we can't us the register renaming trick in the verilog design.

> I realize this comment is coming in quite late to your development...

Its not too late if its before silicon ;)

-Stafford
