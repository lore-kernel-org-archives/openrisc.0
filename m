From: Richard Henderson <rth@twiddle.net>
Date: Fri, 30 Aug 2019 08:21:56 -0700
Subject: [OpenRISC] [PATCH] or1k: Fix issue with set_got clobbering r9
In-Reply-To: <20190830093101.GU24874@lianli.shorne-pla.net>
References: <20190822114404.1318-1-shorne@gmail.com>
 <20190830093101.GU24874@lianli.shorne-pla.net>
Message-ID: <796f2b6f-e81f-6150-0349-d6ee3c884981@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

LGTM.

On 8/30/19 2:31 AM, Stafford Horne wrote:
> Hello, any comments on this?
> 
> If nothing I will commit in a few days.
> 
> On Thu, Aug 22, 2019 at 08:44:04PM +0900, Stafford Horne wrote:
>> When compiling glibc we found that the GOT register was being allocated
>> r9 when the instruction was still set_got_tmp.  That caused set_got to
>> clobber r9.  We cannot simply say set_got_tmp clobbers r9 as this is the
>> reason for having the temporary set_got_tmp.
>>
>> Fix by using a register class constraint that does not allow r9 during
>> register allocation.
>>
>> gcc/ChangeLog:
>>
>> 	* config/or1k/constraints.md (t): New constraint.
>> 	* config/or1k/or1k.h (GOT_REGS): New register class.
>> 	* config/or1k/or1k.md (set_got_tmp, set_got): Use t contraint.
>> ---
>>  gcc/config/or1k/constraints.md | 4 ++++
>>  gcc/config/or1k/or1k.h         | 3 +++
>>  gcc/config/or1k/or1k.md        | 4 ++--
>>  3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/gcc/config/or1k/constraints.md b/gcc/config/or1k/constraints.md
>> index 8cac7eb5329..ba330c6b8c2 100644
>> --- a/gcc/config/or1k/constraints.md
>> +++ b/gcc/config/or1k/constraints.md
>> @@ -25,6 +25,7 @@
>>  ; We use:
>>  ;  c - sibcall registers
>>  ;  d - double pair base registers (excludes r0, r30 and r31 which overflow)
>> +;  t - got address registers (excludes r9 is clobbered by set_got)
> 
> I will changee this to (... r9 which is clobbered ...)
> 
>>  ;  I - constant signed 16-bit
>>  ;  K - constant unsigned 16-bit
>>  ;  M - constant signed 16-bit shifted left 16-bits (l.movhi)
>> @@ -36,6 +37,9 @@
>>  (define_register_constraint "d" "DOUBLE_REGS"
>>    "Registers which can be used for double reg pairs.")
>>  
>> +(define_register_constraint "t" "GOT_REGS"
>> +  "Registers which can be used to store the Global Offset Table (GOT) address.")
>> +
>>  ;; Immediates
>>  (define_constraint "I"
>>    "A signed 16-bit immediate in the range -32768 to 32767."
>> diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
>> index 2b29e62fdd3..4c32607bac1 100644
>> --- a/gcc/config/or1k/or1k.h
>> +++ b/gcc/config/or1k/or1k.h
>> @@ -190,6 +190,7 @@ enum reg_class
>>    NO_REGS,
>>    SIBCALL_REGS,
>>    DOUBLE_REGS,
>> +  GOT_REGS,
>>    GENERAL_REGS,
>>    FLAG_REGS,
>>    ALL_REGS,
>> @@ -202,6 +203,7 @@ enum reg_class
>>    "NO_REGS", 			\
>>    "SIBCALL_REGS",		\
>>    "DOUBLE_REGS",		\
>> +  "GOT_REGS",			\
>>    "GENERAL_REGS",		\
>>    "FLAG_REGS",			\
>>    "ALL_REGS" }
>> @@ -215,6 +217,7 @@ enum reg_class
>>  { { 0x00000000, 0x00000000 },	\
>>    { SIBCALL_REGS_MASK,   0 },	\
>>    { 0x7f7ffffe, 0x00000000 },	\
>> +  { 0xfffffdff, 0x00000000 },	\
>>    { 0xffffffff, 0x00000003 },	\
>>    { 0x00000000, 0x00000004 },	\
>>    { 0xffffffff, 0x00000007 }	\
>> diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
>> index cee11d078cc..36bcee336ab 100644
>> --- a/gcc/config/or1k/or1k.md
>> +++ b/gcc/config/or1k/or1k.md
>> @@ -706,7 +706,7 @@
>>  ;; set_got pattern below.  This works because the set_got_tmp insn is the
>>  ;; first insn in the stream and that it isn't moved during RA.
>>  (define_insn "set_got_tmp"
>> -  [(set (match_operand:SI 0 "register_operand" "=r")
>> +  [(set (match_operand:SI 0 "register_operand" "=t")
>>  	(unspec_volatile:SI [(const_int 0)] UNSPECV_SET_GOT))]
>>    ""
>>  {
>> @@ -715,7 +715,7 @@
>>  
>>  ;; The insn to initialize the GOT.
>>  (define_insn "set_got"
>> -  [(set (match_operand:SI 0 "register_operand" "=r")
>> +  [(set (match_operand:SI 0 "register_operand" "=t")
>>  	(unspec:SI [(const_int 0)] UNSPEC_SET_GOT))
>>     (clobber (reg:SI LR_REGNUM))]
>>    ""
>> -- 
>> 2.21.0
>>

