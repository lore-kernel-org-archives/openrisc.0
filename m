From: Stafford Horne <shorne@gmail.com>
Date: Sat, 20 Jan 2018 23:34:41 +0900
Subject: [OpenRISC] OpenRISC GCC upstream plan
In-Reply-To: <4614CB00-1324-4236-96D6-E4283C4D473C@wallentowitz.de>
References: <20180101125546.GH32243@lianli.shorne-pla.net>
 <c6104ef7-0dba-fcd7-e57e-f925b85fc553@twiddle.net>
 <20180103153211.GK32243@lianli.shorne-pla.net>
 <c800d6ef-bfea-7c1d-5237-b373fd085422@twiddle.net>
 <20180120133654.GH13019@lianli.shorne-pla.net>
 <4614CB00-1324-4236-96D6-E4283C4D473C@wallentowitz.de>
Message-ID: <CAAfxs74nP_7JBMKwFbiAn9b69LCYzmtzkMUMW-Lxi5kKUwie0A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stefan,

My plan is to start with the core parts the matjaz touched, any
concerns there?  The features we would need:
  - Alu instructions
  - Memory instructions (load, store, register moves)
  - Calling conventions
  - Stack frames
  - Branching

Those are in these files:
  - or1k.h - target macro definitions, configuration
  - or1k.md - mostly instruction and expander defines
  - or1k.c - instruction helpers and target macro implementations

I found the moxie architecture is a simple architecture to start from.
If others have better suggestions let me know.

The things I think are independent I mentioned before, I think we can
use as is as they are modular in nature, but we should consult with
gcc devs before we do:
  - Atomics support
  - plt/got support (PIC relocation support)
  - Floating point support
  - Thread local storage support

Sources I have been looking at:
  - https://kristerw.blogspot.jp/2017/08/writing-gcc-backend_4.html -
a good blog series
  - https://github.com/gcc-mirror/gcc/tree/master/gcc/config/moxie -
the moxie implementation very simple
  - https://gcc.gnu.org/onlinedocs/gccint/  - gcc internals
documentation dense but good, key parts for backend
     - https://gcc.gnu.org/onlinedocs/gccint/#toc-Machine-Descriptions
 - details on the .md file
     - https://gcc.gnu.org/onlinedocs/gccint/Standard-Names.html#Standard-Names
- list of instruction names (not all need to be defined).
     - https://gcc.gnu.org/onlinedocs/gccint/Target-Macros.html#Target-Macros
- details on the target macros (.h and .c file)


-Stafford

On Sat, Jan 20, 2018 at 10:54 PM, Stefan Wallentowitz
<stefan@wallentowitz.de> wrote:
> Hi Stafford,
>
> What is your plan about the rewrite? Entirely from scratch or only the parts
> that Matjaz touched?
>
> I am happy to help where possible, I finally get some free time again this
> year.
>
> Cheers,
> Stefan
>
> On January 20, 2018 2:36:54 PM GMT+01:00, Stafford Horne <shorne@gmail.com>
> wrote:
>>
>> On Wed, Jan 03, 2018 at 09:11:52AM -0800, Richard Henderson wrote:
>>>
>>>  On 01/03/2018 07:32 AM, Stafford Horne wrote:
>>>>
>>>>  On Mon, Jan 01, 2018 at 02:48:02PM -0800, Richard Henderson wrote:
>>>>>
>>>>>  On 01/01/2018 04:55 AM, Stafford Horne wrote:
>>>>>  There's also my to-do list that I never finished: primarily, support
>>>>> Sparcv9
>>>>>  style double-offset relocations.
>>>>>
>>>>>  This takes advantage of the fact that the page-offset relocation
>>>>> requires 13
>>>>>  bits, but the load/store instructions that use the page-offset
>>>>> relocation have
>>>>>  16 bits.  Thus one can be certain that an addend between -32768 and
>>>>> 24576
>>>>>  cannot overflow the field.  That is quite a significant range and can
>>>>> easily be
>>>>>  combined with the section anchor support to minimize the number of
>>>>> l.adrp
>>>>>  instructions required to address lots of local variables.
>>>>
>>>>
>>>>  Sorry, I don't follow 100%
>>>>
>>>>  How is this different from the l.adrp supported relocations added for
>>>> this
>>>>  series?  Which relocations are these on sparcv9 R_SPARC_??
>>>
>>>
>>>  The sparc relocation is R_SPARC_OLO10.
>>>
>>>  The l.adrp relocations I have added allow only for an "inner" offset.
>>>  That is,
>>>
>>>  	l.lb	po(foo+100000)(r3), r1
>>>
>>>  will install the 13 low bits of the address of foo+100000 into the
>>> instruction.
>>>
>>>  If the relocations allow both "inner" and "outer" offsets, then one
>>> could write
>>>
>>>  	l.lb	po(foo+100000)+1000(r3), r1
>>>
>>>  which would take the low 13 bits of foo+100000, and then add 1000, and
>>> then
>>>  install the (bounds-checked) 16-bit value into the instruction.
>>>
>>>  Now, normally one doesn't write foo+100000, but one does use local
>>> labels like
>>>  .LC100, which in order to save space in the symbol table are normally
>>>  decomposed into .rodata+offset.
>>>
>>>  As I recall, the R_SPARC_OLO10 relocation uses some otherwise unused
>>> space
>>>  within Elf64_Rela.r_info.  That's not an option for Elf32, so there are
>>> two
>>>  alternatives: pairs of relocations (like R_MIPS_ADD_IMMEDIATE,
>>> deprecated), or
>>>  by dropping the "inner" offset so that
>>>
>>>  	l.lb	po(.LC100)+1000(r3), r1
>>>
>>>  is assembled with the local label retained undecomposed and 1000
>>> installed as
>>>  the Elf32_Rela.r_addend.
>>>
>>>  One would have to experiment with these options to see how the tradeoffs
>>> balance.
>>>
>>>  Once gcc has been taught about this trick, I would hope that one would
>>> see one
>>>
>>>  	l.adrp	pa(.LC100), r16
>>>
>>>  near the top of the function and then that single base used for all
>>> static
>>>  variables.
>>
>>
>> Hi Richard,
>>
>> Sorry, for the late reply I have been spending the last few weeks
>> reviewing your
>> binutils patches.  Also, honestly I didn't understand much of what you
>> meant
>> above until I read through the code and learned more about relocations and
>> ld.
>> Thank you, it is more clear now.
>>
>> I have done a few things.
>>
>>  - Reviewed the binutils (and lightly gcc) patches.
>>  - Spent a lot of time reading GCC internals and backend code to get ready
>> for
>>    the rewrite.
>>  - Created some test release binaries with binutils (2.29) and gcc (7.2.0)
>> [0]
>>  - Rebased binutils-gdb on the latest upstream (pulling in the upstream
>> or1k and
>>    sim support) [1]
>>  - Started to work on proper change logs for the commits for sending
>> upstream.
>>
>> Rebasing binutils-gdb patches on the latest upstream/master was a bit
>> troublesome as Alan Morda did a white space cleanup of elf32-or1k.c.  I
>> think I
>> got it patched up fine.  The sim and tests are working well.
>>
>> Some comments on the binutils patches:
>>
>>  - There was one issue with your l.maci fixes which I patched here [2]
>>  - The summary of changes (for others) are
>>   1 Add relocations for Adjusted High (signed) and Split Low (store isns)
>>   2 Add relocations for l.adrp page relative types (new instruction)
>>   3 Add missing (l.muld, l.muldu, l.macu, l.msbu) instructions
>>   4 Add 64-bit Relocations
>>   5 Add 64-bit Load/Store instructions
>>  - If we are currently not supporting 64 bit cores, do we need 4 and 5?
>> Do
>>    maybe other people have a say.  I am considering dropping them for
>>    simplicity.
>>
>> Next steps:
>>  - Get started on the GCC rewrite.
>>  - Send the binutils patches upstream.
>>  - Get your l.adrp patches in the mor1kx and tested.
>>  - Update the architecture specification:
>>    * adding l.adrp
>>    * document the relocations we have
>>
>> I might not get to all of them any time soon, as I want to make progress
>> on the
>> rewrite.
>>
>> -Stafford
>>
>> [0] https://github.com/stffrdhrn/or1k-gcc/releases/tag/or1k-7.2.0-20180112
>> [1]
>> https://github.com/stffrdhrn/binutils-gdb/commits/or1k-3-rebase-20180120
>> [2]
>> https://github.com/stffrdhrn/binutils-gdb/commit/06eca91e233d0e15bcb06170bca19426d31ba103
>> ________________________________
>>
>> OpenRISC mailing list
>> OpenRISC at lists.librecores.org
>> https://lists.librecores.org/listinfo/openrisc
