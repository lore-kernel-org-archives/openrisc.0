From: Jakob Viketoft <jakob.viketoft@aacmicrotec.com>
Date: Thu, 20 Oct 2016 07:35:08 +0000
Subject: [OpenRISC] GCC-optimizations/weirdness...
In-Reply-To: <ae185e23-3459-13f5-9a77-fcbd7d6b1d72@twiddle.net>
References: <D90E780DD5090A4F9AEBC859615CED77EE1CEE69@OXYGEN.aacmicrotec.local>,
 <ae185e23-3459-13f5-9a77-fcbd7d6b1d72@twiddle.net>
Message-ID: <D90E780DD5090A4F9AEBC859615CED77EE1CF0AC@OXYGEN.aacmicrotec.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Richard Henderson [rth7680 at gmail.com] on behalf of Richard Henderson [rth at twiddle.net]
Sent: Wednesday, October 19, 2016 23:22
To: Jakob Viketoft; openrisc at lists.librecores.org
Subject: Re: [OpenRISC] GCC-optimizations/weirdness...

> Please have a look at

>   git://github.com/rth7680/gcc.git or1k-6
>   git://github/com/rth7680/binutils-gdb.git or1k-0

> I did some work on cleaning up the or1k port a year or two ago.  The branch is
> based on (probably pre-release) gcc 6.

Thank you, this sounds very interesting, I'll definitely take a look.

> > I've hit a major performance obstacle on 64-bit mul/div which is used by
> > default in the RTEMS kernel. I feel this should be able to speed up
> > considerably using some clever maths and the (possibly) defined hardware
> > instructions for 32 bits.

> It wouldn't be difficult to add support to gcc for the madd extension.  But
> without that, the clever arithmetic is all buried inside __muldi3 (and is too
> large to replicate inline).

> There is no proposed extension that would help with 64-bit division.  So that
> too is buried in __udivdi3.

What I meant was to make clever arithmetic that replaces the __muldi3/__udivdi3 or at least improves it using the available 32-bit hardware instructions. I.e. how to replace a given operation with a given set of assembler instructions, just as the add64 does, not adding more custom instructions. The __muldi3 is quite close, but no cigar in terms of optimality for this CPU. I don't necessarily intend to have it inline, but it still can be optimized even if it's a separate call.

> > I also consistently see unnecessary stack operations which might be quite a
> > bummer in terms of performance as well, please see the same code snippets
> > below.

> This is definitely cleaned up in my branch.
> Output of my gc -O2 intermixed below.

That sounds great as well. Will definitely take a look into using this instead.

> 00000000 <add64>:
>    0:  e1 84 30 00     l.add r12,r4,r6
>    4:  44 00 48 00     l.jr r9
>    8:  e1 63 28 01     l.addc r11,r3,r5

This looks really good.

> 0000000c <mul64>:
>    c:  d7 e1 4f fc     l.sw -4(r1),r9
>   10:  04 00 00 00     l.jal 10 <mul64+0x4>
>   14:  9c 21 ff fc     l.addi r1,r1,-4
>   18:  9c 21 00 04     l.addi r1,r1,4
>   1c:  85 21 ff fc     l.lwz r9,-4(r1)
>   20:  44 00 48 00     l.jr r9
>   24:  15 00 00 00     l.nop 0x0

I assume it's a simple linker mistake setting the l.jal to mul64, right? I assume you still call __muldi3?

> 00000028 <div64>:
>   28:  d7 e1 4f fc     l.sw -4(r1),r9
>   2c:  04 00 00 00     l.jal 2c <div64+0x4>
>   30:  9c 21 ff fc     l.addi r1,r1,-4
>   34:  9c 21 00 04     l.addi r1,r1,4
>   38:  85 21 ff fc     l.lwz r9,-4(r1)
>   3c:  44 00 48 00     l.jr r9
>   40:  15 00 00 00     l.nop 0x0

Ditto with the linker, I assume?

> 00000044 <add32>:
>   44:  44 00 48 00     l.jr r9
>   48:  e1 63 20 00     l.add r11,r3,r4

> 0000004c <mul32>:
>   4c:  44 00 48 00     l.jr r9
>   50:  e1 63 23 06     l.mul r11,r3,r4

> 00000054 <div32>:
>   54:  44 00 48 00     l.jr r9
>   58:  e1 63 23 0a     l.divu r11,r3,r4

Yes, this is exactly what I wanted! Btw, any guess to why it's making l.mul (and not l.mulu) on unsigneds?

      /Jakob
