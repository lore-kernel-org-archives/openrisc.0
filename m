From: Richard Henderson <rth@twiddle.net>
Date: Wed, 3 Jul 2019 21:09:51 +0200
Subject: [OpenRISC] [PATCH v2 4/5] or1k: Initial support for FPU
In-Reply-To: <20190703154301.GY18316@gate.crashing.org>
References: <20190703033351.11924-1-shorne@gmail.com>
 <20190703033351.11924-5-shorne@gmail.com>
 <20190703154301.GY18316@gate.crashing.org>
Message-ID: <64def15b-f701-4a5e-2724-6fb1e859be9a@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 7/3/19 5:43 PM, Segher Boessenkool wrote:
>> @@ -212,6 +214,7 @@ enum reg_class
>>  #define REG_CLASS_CONTENTS      \
>>  { { 0x00000000, 0x00000000 },	\
>>    { SIBCALL_REGS_MASK,   0 },	\
>> +  { 0x7ffffefe, 0x00000000 },	\
> 
> Above you said r0, r30, r31 are excluded, but this is r0, r8, r30, or
> in GCC register numbers, 0, 8, and 31?  You probably should mention r8
> somewhere (it's because it is the last arg, this avoid problems, I guess?),
> and the 30/31 thing is confused some way.  Maybe it is all just that one
> documentation line :-)

... and if r8 is excluded because of arguments, I suspect that this is the
wrong fix, as there's nothing inherently wrong with r7:r8 or r8:r9 as a pair,
at least that I can see.

Perhaps function_arg and/or function_arg_advance is the right place for a fix?
The calling convention says that 64-bit arguments are not split across
registers+stack, so you already shouldn't have seen (r8, [sp+0]) as a pair.


r~
