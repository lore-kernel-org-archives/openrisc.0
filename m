From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jul 2019 17:35:15 -0500
Subject: [OpenRISC] [PATCH v2 4/5] or1k: Initial support for FPU
In-Reply-To: <20190703221956.GE2601@lianli.shorne-pla.net>
References: <20190703033351.11924-1-shorne@gmail.com>
 <20190703033351.11924-5-shorne@gmail.com>
 <20190703154301.GY18316@gate.crashing.org>
 <64def15b-f701-4a5e-2724-6fb1e859be9a@twiddle.net>
 <20190703221956.GE2601@lianli.shorne-pla.net>
Message-ID: <20190703223515.GE18316@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jul 04, 2019 at 07:19:56AM +0900, Stafford Horne wrote:
> On Wed, Jul 03, 2019 at 09:09:51PM +0200, Richard Henderson wrote:
> > On 7/3/19 5:43 PM, Segher Boessenkool wrote:
> > >> @@ -212,6 +214,7 @@ enum reg_class
> > >>  #define REG_CLASS_CONTENTS      \
> > >>  { { 0x00000000, 0x00000000 },	\
> > >>    { SIBCALL_REGS_MASK,   0 },	\
> > >> +  { 0x7ffffefe, 0x00000000 },	\
> > > 
> > > Above you said r0, r30, r31 are excluded, but this is r0, r8, r30, or
> > > in GCC register numbers, 0, 8, and 31?  You probably should mention r8
> > > somewhere (it's because it is the last arg, this avoid problems, I guess?),
> > > and the 30/31 thing is confused some way.  Maybe it is all just that one
> > > documentation line :-)
> > 
> > ... and if r8 is excluded because of arguments, I suspect that this is the
> > wrong fix, as there's nothing inherently wrong with r7:r8 or r8:r9 as a pair,
> > at least that I can see.
> > 
> > Perhaps function_arg and/or function_arg_advance is the right place for a fix?
> > The calling convention says that 64-bit arguments are not split across
> > registers+stack, so you already shouldn't have seen (r8, [sp+0]) as a pair.
> 
> I will double check, the mask may be wrong.  It should not matter about the
> function args.
> 
> I didn't see any issue that caused me to add r8.  So I may have just masked thw
> rong bit thinking it's r31.  Is there something worng with what I did?
> 
> The mask is 0x7ffffefe, and names should corresbond to this name list?
> 
> #define REGISTER_NAMES {
>   "r0",   "r1",   "r2",   "r3",   "r4",   "r5",   "r6",   "r7",  # 7e, excl r0
>   "r8",   "r9",   "r10",  "r11",  "r12",  "r13",  "r14",  "r15", # ff, excl none
>   "r17",  "r19",  "r21",  "r23",  "r25",  "r27",  "r29",  "r31", # fe, excl r31
>   "r16",  "r18",  "r20",  "r22",  "r24",  "r26",  "r28",  "r30", # fe, excl r30
>   "?ap",  "?fp",  "?sr_f" }
> 
> Do I have it backwards?  With an endian issue?

Yes :-)  0x00000001 is reg 0 (r0), 0x80000000 is reg 31 (r30).


Segher
