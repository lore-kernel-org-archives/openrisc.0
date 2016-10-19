From: Richard Henderson <rth@twiddle.net>
Date: Wed, 19 Oct 2016 14:22:07 -0700
Subject: [OpenRISC] GCC-optimizations/weirdness...
In-Reply-To: <D90E780DD5090A4F9AEBC859615CED77EE1CEE69@OXYGEN.aacmicrotec.local>
References: <D90E780DD5090A4F9AEBC859615CED77EE1CEE69@OXYGEN.aacmicrotec.local>
Message-ID: <ae185e23-3459-13f5-9a77-fcbd7d6b1d72@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/19/2016 09:39 AM, Jakob Viketoft wrote:
> Hello any gcc-gurus out there!

Please have a look at

   git://github.com/rth7680/gcc.git or1k-6
   git://github/com/rth7680/binutils-gdb.git or1k-0

I did some work on cleaning up the or1k port a year or two ago.  The branch is 
based on (probably pre-release) gcc 6.

In addition to basic cleanups, it also contains support for my l.adrp proposal 
from 2014.  It's enabled by default, for ease of testing, but easily disabled 
from the command-line (-mno-adrp), or by reverting the appropriately named 
"hack: Enable ADDRP by default" patch.

> I've hit a major performance obstacle on 64-bit mul/div which is used by
> default in the RTEMS kernel. I feel this should be able to speed up
> considerably using some clever maths and the (possibly) defined hardware
> instructions for 32 bits.

It wouldn't be difficult to add support to gcc for the madd extension.  But 
without that, the clever arithmetic is all buried inside __muldi3 (and is too 
large to replicate inline).

There is no proposed extension that would help with 64-bit division.  So that 
too is buried in __udivdi3.

> I also consistently see unnecessary stack operations which might be quite a
> bummer in terms of performance as well, please see the same code snippets
> below.

This is definitely cleaned up in my branch.
Output of my gc -O2 intermixed below.

> 00002df4 <add64>:
>     2df4:       e1 84 30 00      l.add r12,r4,r6
>     2df8:       d7 e1 0f fc      l.sw -4(r1),r1
>     2dfc:       e4 8c 20 00      l.sfltu r12,r4
>     2e00:       9c 21 ff fc      l.addi r1,r1,-4
>     2e04:       10 00 00 03      l.bf 2e10 <add64+0x1c>
>     2e08:       9c 80 00 01      l.addi r4,r0,1
>     2e0c:       9c 80 00 00      l.addi r4,r0,0
>     2e10:       e1 63 28 00      l.add r11,r3,r5
>     2e14:       9c 21 00 04      l.addi r1,r1,4
>     2e18:       e1 64 58 00      l.add r11,r4,r11
>     2e1c:       44 00 48 00      l.jr r9
>     2e20:       84 21 ff fc      l.lwz r1,-4(r1)

00000000 <add64>:
    0:	e1 84 30 00 	l.add r12,r4,r6
    4:	44 00 48 00 	l.jr r9
    8:	e1 63 28 01 	l.addc r11,r3,r5

> 00002e24 <mul64>:
>     2e24:       d7 e1 4f fc      l.sw -4(r1),r9
>     2e28:       d7 e1 0f f8      l.sw -8(r1),r1
>     2e2c:       04 00 03 96      l.jal 3c84 <__muldi3>
>     2e30:       9c 21 ff f8      l.addi r1,r1,-8
>     2e34:       9c 21 00 08      l.addi r1,r1,8
>     2e38:       85 21 ff fc      l.lwz r9,-4(r1)
>     2e3c:       44 00 48 00      l.jr r9
>     2e40:       84 21 ff f8      l.lwz r1,-8(r1)

0000000c <mul64>:
    c:	d7 e1 4f fc 	l.sw -4(r1),r9
   10:	04 00 00 00 	l.jal 10 <mul64+0x4>
   14:	9c 21 ff fc 	l.addi r1,r1,-4
   18:	9c 21 00 04 	l.addi r1,r1,4
   1c:	85 21 ff fc 	l.lwz r9,-4(r1)
   20:	44 00 48 00 	l.jr r9
   24:	15 00 00 00 	l.nop 0x0

> 00002e44 <div64>:
>     2e44:       d7 e1 4f fc      l.sw -4(r1),r9
>     2e48:       d7 e1 0f f8      l.sw -8(r1),r1
>     2e4c:       04 00 03 ad      l.jal 3d00 <__udivdi3>
>     2e50:       9c 21 ff f8      l.addi r1,r1,-8
>     2e54:       9c 21 00 08      l.addi r1,r1,8
>     2e58:       85 21 ff fc      l.lwz r9,-4(r1)
>     2e5c:       44 00 48 00      l.jr r9
>     2e60:       84 21 ff f8      l.lwz r1,-8(r1)

00000028 <div64>:
   28:	d7 e1 4f fc 	l.sw -4(r1),r9
   2c:	04 00 00 00 	l.jal 2c <div64+0x4>
   30:	9c 21 ff fc 	l.addi r1,r1,-4
   34:	9c 21 00 04 	l.addi r1,r1,4
   38:	85 21 ff fc 	l.lwz r9,-4(r1)
   3c:	44 00 48 00 	l.jr r9
   40:	15 00 00 00 	l.nop 0x0

> 00002e64 <add32>:
>     2e64:       d7 e1 0f fc      l.sw -4(r1),r1
>     2e68:       9c 21 ff fc      l.addi r1,r1,-4
>     2e6c:       e1 63 20 00      l.add r11,r3,r4
>     2e70:       9c 21 00 04      l.addi r1,r1,4
>     2e74:       44 00 48 00      l.jr r9
>     2e78:       84 21 ff fc      l.lwz r1,-4(r1)

00000044 <add32>:
   44:	44 00 48 00 	l.jr r9
   48:	e1 63 20 00 	l.add r11,r3,r4

> 00002e7c <mul32>:
>     2e7c:       d7 e1 0f fc      l.sw -4(r1),r1
>     2e80:       9c 21 ff fc      l.addi r1,r1,-4
>     2e84:       e1 63 23 06      l.mul r11,r3,r4
>     2e88:       9c 21 00 04      l.addi r1,r1,4
>     2e8c:       44 00 48 00      l.jr r9
>     2e90:       84 21 ff fc      l.lwz r1,-4(r1)

0000004c <mul32>:
   4c:	44 00 48 00 	l.jr r9
   50:	e1 63 23 06 	l.mul r11,r3,r4

> 00002e94 <div32>:
>     2e94:       d7 e1 0f fc      l.sw -4(r1),r1
>     2e98:       9c 21 ff fc      l.addi r1,r1,-4
>     2e9c:       e1 63 23 0a      l.divu r11,r3,r4
>     2ea0:       9c 21 00 04      l.addi r1,r1,4
>     2ea4:       44 00 48 00      l.jr r9
>     2ea8:       84 21 ff fc      l.lwz r1,-4(r1)

00000054 <div32>:
   54:	44 00 48 00 	l.jr r9
   58:	e1 63 23 0a 	l.divu r11,r3,r4



r~


