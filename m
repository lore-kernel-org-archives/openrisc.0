From: Stafford Horne <shorne@gmail.com>
Date: Sat, 20 Jan 2018 22:36:54 +0900
Subject: [OpenRISC] OpenRISC GCC upstream plan
In-Reply-To: <c800d6ef-bfea-7c1d-5237-b373fd085422@twiddle.net>
References: <20180101125546.GH32243@lianli.shorne-pla.net>
 <c6104ef7-0dba-fcd7-e57e-f925b85fc553@twiddle.net>
 <20180103153211.GK32243@lianli.shorne-pla.net>
 <c800d6ef-bfea-7c1d-5237-b373fd085422@twiddle.net>
Message-ID: <20180120133654.GH13019@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jan 03, 2018 at 09:11:52AM -0800, Richard Henderson wrote:
> On 01/03/2018 07:32 AM, Stafford Horne wrote:
> > On Mon, Jan 01, 2018 at 02:48:02PM -0800, Richard Henderson wrote:
> >> On 01/01/2018 04:55 AM, Stafford Horne wrote:
> >> There's also my to-do list that I never finished: primarily, support Sparcv9
> >> style double-offset relocations.
> >>
> >> This takes advantage of the fact that the page-offset relocation requires 13
> >> bits, but the load/store instructions that use the page-offset relocation have
> >> 16 bits.  Thus one can be certain that an addend between -32768 and 24576
> >> cannot overflow the field.  That is quite a significant range and can easily be
> >> combined with the section anchor support to minimize the number of l.adrp
> >> instructions required to address lots of local variables.
> > 
> > Sorry, I don't follow 100%
> > 
> > How is this different from the l.adrp supported relocations added for this
> > series?  Which relocations are these on sparcv9 R_SPARC_??
> 
> The sparc relocation is R_SPARC_OLO10.
> 
> The l.adrp relocations I have added allow only for an "inner" offset.
> That is,
> 
> 	l.lb	po(foo+100000)(r3), r1
> 
> will install the 13 low bits of the address of foo+100000 into the instruction.
> 
> If the relocations allow both "inner" and "outer" offsets, then one could write
> 
> 	l.lb	po(foo+100000)+1000(r3), r1
> 
> which would take the low 13 bits of foo+100000, and then add 1000, and then
> install the (bounds-checked) 16-bit value into the instruction.
> 
> Now, normally one doesn't write foo+100000, but one does use local labels like
> .LC100, which in order to save space in the symbol table are normally
> decomposed into .rodata+offset.
> 
> As I recall, the R_SPARC_OLO10 relocation uses some otherwise unused space
> within Elf64_Rela.r_info.  That's not an option for Elf32, so there are two
> alternatives: pairs of relocations (like R_MIPS_ADD_IMMEDIATE, deprecated), or
> by dropping the "inner" offset so that
> 
> 	l.lb	po(.LC100)+1000(r3), r1
> 
> is assembled with the local label retained undecomposed and 1000 installed as
> the Elf32_Rela.r_addend.
> 
> One would have to experiment with these options to see how the tradeoffs balance.
> 
> Once gcc has been taught about this trick, I would hope that one would see one
> 
> 	l.adrp	pa(.LC100), r16
> 
> near the top of the function and then that single base used for all static
> variables.

Hi Richard,

Sorry, for the late reply I have been spending the last few weeks reviewing your
binutils patches.  Also, honestly I didn't understand much of what you meant
above until I read through the code and learned more about relocations and ld.
Thank you, it is more clear now.

I have done a few things.

 - Reviewed the binutils (and lightly gcc) patches.
 - Spent a lot of time reading GCC internals and backend code to get ready for
   the rewrite.
 - Created some test release binaries with binutils (2.29) and gcc (7.2.0) [0]
 - Rebased binutils-gdb on the latest upstream (pulling in the upstream or1k and
   sim support) [1]
 - Started to work on proper change logs for the commits for sending upstream.

Rebasing binutils-gdb patches on the latest upstream/master was a bit
troublesome as Alan Morda did a white space cleanup of elf32-or1k.c.  I think I
got it patched up fine.  The sim and tests are working well.

Some comments on the binutils patches:

 - There was one issue with your l.maci fixes which I patched here [2]
 - The summary of changes (for others) are
  1 Add relocations for Adjusted High (signed) and Split Low (store isns)
  2 Add relocations for l.adrp page relative types (new instruction)
  3 Add missing (l.muld, l.muldu, l.macu, l.msbu) instructions
  4 Add 64-bit Relocations
  5 Add 64-bit Load/Store instructions
 - If we are currently not supporting 64 bit cores, do we need 4 and 5?  Do
   maybe other people have a say.  I am considering dropping them for
   simplicity.

Next steps:
 - Get started on the GCC rewrite.
 - Send the binutils patches upstream.
 - Get your l.adrp patches in the mor1kx and tested.
 - Update the architecture specification:
   * adding l.adrp
   * document the relocations we have

I might not get to all of them any time soon, as I want to make progress on the
rewrite.

-Stafford

[0] https://github.com/stffrdhrn/or1k-gcc/releases/tag/or1k-7.2.0-20180112
[1] https://github.com/stffrdhrn/binutils-gdb/commits/or1k-3-rebase-20180120
[2] https://github.com/stffrdhrn/binutils-gdb/commit/06eca91e233d0e15bcb06170bca19426d31ba103
