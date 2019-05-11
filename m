From: Stafford Horne <shorne@gmail.com>
Date: Sat, 11 May 2019 19:04:33 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <AED0C7019AE04A2F87CD0E432FA20A70@BAndViG>
References: <20190412214843.GB32284@lianli.shorne-pla.net>
 <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
 <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
 <20190425211702.GG32284@lianli.shorne-pla.net>
 <e441bb74-5cea-6002-c33e-4822f082265b@twiddle.net>
 <20190507211254.GD11006@lianli.shorne-pla.net>
 <6CFC558D2E0643BAA8C0CFCB1AEE95BB@BAndViG>
 <3ce42625-83fe-4ee2-b48f-23e6362ee616@twiddle.net>
 <AED0C7019AE04A2F87CD0E432FA20A70@BAndViG>
Message-ID: <20190511100433.GA20465@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, May 10, 2019 at 10:56:05AM +0300, BAndViG wrote:
> > From: Richard Henderson
> > Sent: Friday, May 10, 2019 12:47 AM
> > To: BAndViG ; Stafford Horne
> > Cc: Openrisc
> > Subject: Re: [OpenRISC] OpenRISC 1.3 spec
> 
> > > On 5/8/19 11:05 AM, BAndViG wrote:
> > > Ah, I implemented similar approach in MAROCCHINO independently :), see
> > > latest
> > > commit to fp_unordered_cmp branch:
> > > https://github.com/openrisc/or1k_marocchino/commit/313b256875c8b619f5b16db47d915e5dfaedfff7
> 
> > In the commit above, you say
> 
> > > If A1/B1/D1 address `> 30` than `invalid instruction` exception is raised.
> 
> Oh, it is just misprint. It should be `>= 30`.
> 
> > But that doesn't handle D1=30, D1P=1.
> > Since you are using a (5-bit?) add-with-carry circuit, is it easy to
> > raise the
> > invalid instruction if there is carry out of bit 4, instead of the hard-coded
> > comparison against 30?
> 
> A1/B1/D1 boundaries check is implemented in or1k_marocchino_decode.v, lines
> #348-351
> 
> //  # check legality of A1/B1/D1 addresses: they must be < r30
> wire op_fp64_rfa1_adr_l = ~(&fetch_rfa1_adr_i[OPTION_RF_ADDR_WIDTH-1:1]);
> wire op_fp64_rfb1_adr_l = ~(&fetch_rfb1_adr_i[OPTION_RF_ADDR_WIDTH-1:1]);
> wire op_fp64_rfd1_adr_l = ~(&fetch_rfd1_adr_i[OPTION_RF_ADDR_WIDTH-1:1]);
> 
> And here, commentary is correct :).
> `_l` suffix here means `legal`.
> I check that [4:1] bits must not be 4'b1111, because 5'd30 is 5'b11110 and
> 5'd31 is all ones.
> 
> > Otherwise, I'd drop the invalid instruction and let D2 wrap around.
> > D1=31,D1P=1 would be a valid (but silly) instruction clobbering the stack
> > pointer (R1).  As would D1=31,D1P=0, overwriting the
> > ought-to-have-been-hardwired-but-isn't R0.  Both are certainly user bugs, but
> > so what -- Don't Do That Then.
> 
> :) As you correctly mentioned, current GPRs implementation in MAROCCHINO
> (and in any pipe of mor1kx if I remember correctly) allows writing into R0
> just to simplify design. As a result a user have got enough room for bugs
> already.
> I've been thinking about a variants for R0 write protection. R0 could be
> zero initialized at cpu_rst by dedicated circuits. And `invalid instruction`
> exception should be raised if an instruction tries to write to R0. At the
> same time such behavior is incompatible with current run-time initialization
> sequences implemented in OR1K tool chains. The circle is closed.

We still have the option to drop the validation.  Just as we don't have
validation for writing to r0, I think its fine to say r31's pair register is
undefined and should be avoided. (i.e. on some machines it might go into the
shadow reg space)

On the other hand, I have finished the GCC updates for unordered comparisons.
You can see the patch here, I built newlib with this enabled and was able to
shake out a few bugs.  It seems to work:

  - https://github.com/stffrdhrn/gcc/commits/or1k-fpu-2

The new gcc argument is:

  -munordered-float

Example:

or1k-elf-gcc -o ordered ordered.c -Wall -pipe -O2 -munordered-float \
  -mdouble-float -mhard-float -mhard-mul -mhard-div -mcmov -msext -msfimm -l

#include <math.h>

int sfun(float a, float b) {
  return isunordered(a, b);
}
int sfult(float a, float b) {
  return !isgreaterequal(a, b);
}
int sfule(float a, float b) {
  return !isgreater(a, b);
}
int sfueq(float a, float b) {
  return !islessgreater(a, b);
}

/* the above outputs:
 *
000022c8 <sfun>:                                                                
    22c8:       c8 03 20 2e     lf.sfun.s r3,r4                                 
    22cc:       a9 60 00 01     l.ori r11,r0,0x1                                
    22d0:       44 00 48 00     l.jr r9                                         
    22d4:       e1 6b 00 0e     l.cmov r11,r11,r0                               
                                                                                
000022d8 <sfult>:                                                               
    22d8:       c8 03 20 2c     lf.sfult.s r3,r4                                
    22dc:       a9 60 00 01     l.ori r11,r0,0x1                                
    22e0:       44 00 48 00     l.jr r9                                         
    22e4:       e1 6b 00 0e     l.cmov r11,r11,r0                               
                                                                                
000022e8 <sfule>:                                                               
    22e8:       c8 03 20 2d     lf.sfule.s r3,r4                                
    22ec:       a9 60 00 01     l.ori r11,r0,0x1                                
    22f0:       44 00 48 00     l.jr r9                                         
    22f4:       e1 6b 00 0e     l.cmov r11,r11,r0                               
                                                                                
000022f8 <sfueq>:                                                               
    22f8:       c8 03 20 28     lf.sfueq.s r3,r4                                
    22fc:       a9 60 00 01     l.ori r11,r0,0x1                                
    2300:       44 00 48 00     l.jr r9                                         
    2304:       e1 6b 00 0e     l.cmov r11,r11,r0   
*/

int main() {
  return sfun (4.0, 4.2) ||
         sfult(4.2, 3.4) ||
         sfule(4.2, 3.4) ||
         sfueq(3.2, 3.2);
}

-Stafford
