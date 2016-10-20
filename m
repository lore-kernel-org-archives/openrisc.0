From: Richard Henderson <rth@twiddle.net>
Date: Thu, 20 Oct 2016 08:48:53 -0700
Subject: [OpenRISC] GCC-optimizations/weirdness...
In-Reply-To: <D90E780DD5090A4F9AEBC859615CED77EE1CF0AC@OXYGEN.aacmicrotec.local>
References: <D90E780DD5090A4F9AEBC859615CED77EE1CEE69@OXYGEN.aacmicrotec.local>
 <ae185e23-3459-13f5-9a77-fcbd7d6b1d72@twiddle.net>
 <D90E780DD5090A4F9AEBC859615CED77EE1CF0AC@OXYGEN.aacmicrotec.local>
Message-ID: <362afbd6-e548-0370-12c7-9e2b0d384cbe@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/20/2016 12:35 AM, Jakob Viketoft wrote:
>> There is no proposed extension that would help with 64-bit division.  So that
>> too is buried in __udivdi3.
>
> What I meant was to make clever arithmetic that replaces the
> __muldi3/__udivdi3 or at least improves it using the available 32-bit
> hardware instructions. I.e. how to replace a given operation with a given
> set of assembler instructions, just as the add64 does, not adding more
> custom instructions. The __muldi3 is quite close, but no cigar in terms of
> optimality for this CPU. I don't necessarily intend to have it inline, but
> it still can be optimized even if it's a separate call.

Having a look at __muldi3 closely, I see that we could in fact use carry 
arithmetic to reduce it's instruction count by 2 (if cmov is enabled).  I guess 
if cmov hadn't been enabled the intermediate branch would make thing much worse.

This gets me down to

00000000 <__muldi3>:
    0:   ba 64 00 50     l.srli r19,r4,0x10
    4:   b9 66 00 50     l.srli r11,r6,0x10
    8:   a5 84 ff ff     l.andi r12,r4,0xffff
    c:   a6 e6 ff ff     l.andi r23,r6,0xffff
   10:   e2 2c 5b 06     l.mul r17,r12,r11
   14:   e2 b3 bb 06     l.mul r21,r19,r23
   18:   e1 73 5b 06     l.mul r11,r19,r11
   1c:   e2 6c bb 06     l.mul r19,r12,r23
   20:   e0 84 2b 06     l.mul r4,r4,r5
   24:   e0 c6 1b 06     l.mul r6,r6,r3
   28:   19 80 ff ff     l.movhi r12,0xffff
   2c:   ba f1 00 50     l.srli r23,r17,0x10
   30:   e2 31 60 03     l.and r17,r17,r12
   34:   e1 95 60 03     l.and r12,r21,r12
   38:   b8 b5 00 50     l.srli r5,r21,0x10
   3c:   e1 8c 88 00     l.add r12,r12,r17
   40:   e2 37 28 01     l.addc r17,r23,r5
   44:   e1 8c 98 00     l.add r12,r12,r19
   48:   e2 71 58 01     l.addc r19,r17,r11
   4c:   e0 84 98 00     l.add r4,r4,r19
   50:   44 00 48 00     l.jr r9
   54:   e1 64 30 00     l.add r11,r4,r6

which is, I believe, optimal.

>> 0000000c <mul64>:
>>    c:  d7 e1 4f fc     l.sw -4(r1),r9
>>   10:  04 00 00 00     l.jal 10 <mul64+0x4>
>>   14:  9c 21 ff fc     l.addi r1,r1,-4
>>   18:  9c 21 00 04     l.addi r1,r1,4
>>   1c:  85 21 ff fc     l.lwz r9,-4(r1)
>>   20:  44 00 48 00     l.jr r9
>>   24:  15 00 00 00     l.nop 0x0
>
> I assume it's a simple linker mistake setting the l.jal to mul64, right? I assume you still call __muldi3?

This is objdump of a .o file, and not showing the relocations.  So, yes, the 
final linked executable would call __muldi3.

> Btw, any guess to why it's making l.mul (and not l.mulu) on unsigneds?

Becuase l.mul and l.mulu are (when you don't care about the overflow/carry 
bits) indistinguishable.  GCC itself doesn't retain the signedness of the 
operation throughout optimization.


r~

