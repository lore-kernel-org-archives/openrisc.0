From: Richard Henderson <rth@twiddle.net>
Date: Wed, 3 Jan 2018 09:11:52 -0800
Subject: [OpenRISC] OpenRISC GCC upstream plan
In-Reply-To: <20180103153211.GK32243@lianli.shorne-pla.net>
References: <20180101125546.GH32243@lianli.shorne-pla.net>
 <c6104ef7-0dba-fcd7-e57e-f925b85fc553@twiddle.net>
 <20180103153211.GK32243@lianli.shorne-pla.net>
Message-ID: <c800d6ef-bfea-7c1d-5237-b373fd085422@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 01/03/2018 07:32 AM, Stafford Horne wrote:
> On Mon, Jan 01, 2018 at 02:48:02PM -0800, Richard Henderson wrote:
>> On 01/01/2018 04:55 AM, Stafford Horne wrote:
>> There's also my to-do list that I never finished: primarily, support Sparcv9
>> style double-offset relocations.
>>
>> This takes advantage of the fact that the page-offset relocation requires 13
>> bits, but the load/store instructions that use the page-offset relocation have
>> 16 bits.  Thus one can be certain that an addend between -32768 and 24576
>> cannot overflow the field.  That is quite a significant range and can easily be
>> combined with the section anchor support to minimize the number of l.adrp
>> instructions required to address lots of local variables.
> 
> Sorry, I don't follow 100%
> 
> How is this different from the l.adrp supported relocations added for this
> series?  Which relocations are these on sparcv9 R_SPARC_??

The sparc relocation is R_SPARC_OLO10.

The l.adrp relocations I have added allow only for an "inner" offset.
That is,

	l.lb	po(foo+100000)(r3), r1

will install the 13 low bits of the address of foo+100000 into the instruction.

If the relocations allow both "inner" and "outer" offsets, then one could write

	l.lb	po(foo+100000)+1000(r3), r1

which would take the low 13 bits of foo+100000, and then add 1000, and then
install the (bounds-checked) 16-bit value into the instruction.

Now, normally one doesn't write foo+100000, but one does use local labels like
.LC100, which in order to save space in the symbol table are normally
decomposed into .rodata+offset.

As I recall, the R_SPARC_OLO10 relocation uses some otherwise unused space
within Elf64_Rela.r_info.  That's not an option for Elf32, so there are two
alternatives: pairs of relocations (like R_MIPS_ADD_IMMEDIATE, deprecated), or
by dropping the "inner" offset so that

	l.lb	po(.LC100)+1000(r3), r1

is assembled with the local label retained undecomposed and 1000 installed as
the Elf32_Rela.r_addend.

One would have to experiment with these options to see how the tradeoffs balance.

Once gcc has been taught about this trick, I would hope that one would see one

	l.adrp	pa(.LC100), r16

near the top of the function and then that single base used for all static
variables.


r~
