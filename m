From: BAndViG <bandvig@mail.ru>
Date: Sat, 29 Oct 2016 19:12:07 +0300
Subject: [OpenRISC] Question on float64 instructions support
Message-ID: <6948BA87F3F14F5B98FFD6E33A2D518B@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello all,
I'm trying to implement double arithmetic support as I proposed here: 
http://openrisc.io/proposals/orfpx64a32
Verilog models are done. If somebody is interested in source code it could 
be found here https://github.com/bandvig/mor1kx/tree/mar
The functionality isn't tested yet (the reason I haven't pushed it in 
community's repository), but it is synthesizable.
In fact I found that even so compiler has got "double-float" option, the 
disassembled code looks quite strange. For example:

/* try_dbl.cpp begin */

extern "C" double f64_add(double a, double b)
{
  double z;
  z = a + b;
  return (z);
}

/* try_dbl.cpp end */


compile with -O0 and disassemble:

$ 
or1k-elf-gcc -pipe -c -O0 -mhard-mul -mhard-div -mhard-float -mdouble-float  
-mboard=atlys try_dbl.cpp -o try_dbl.elf
$ or1k-elf-objdump -d try_dbl.elf > try_dbl.dis

Disassembling result:

00000000 <f64_add>:
   0:    d7 e1 17 fc     l.sw -4(r1),r2
   4:    9c 41 00 00     l.addi r2,r1,0
   8:    9c 21 ff e4     l.addi r1,r1,-28
   c:    d7 e2 1f ec     l.sw -20(r2),r3
  10:    d7 e2 27 f0     l.sw -16(r2),r4
  14:    d7 e2 2f e4     l.sw -28(r2),r5
  18:    d7 e2 37 e8     l.sw -24(r2),r6
  1c:    84 a2 ff ec     l.lwz r5,-20(r2)
  20:    84 c2 ff f0     l.lwz r6,-16(r2)
  24:    84 62 ff e4     l.lwz r3,-28(r2)
  28:    84 82 ff e8     l.lwz r4,-24(r2)
  2c:    c8 60 00 10     lf.add.d r3,r3,r3
  30:    d7 e2 1f f4     l.sw -12(r2),r3
  34:    d7 e2 27 f8     l.sw -8(r2),r4
  38:    84 62 ff f4     l.lwz r3,-12(r2)
  3c:    84 82 ff f8     l.lwz r4,-8(r2)
  40:    e1 63 00 04     l.or r11,r3,r0
  44:    e1 84 00 04     l.or r12,r4,r0
  48:    a8 22 00 00     l.ori r1,r2,0x0
  4c:    84 41 ff fc     l.lwz r2,-4(r1)
  50:    44 00 48 00     l.jr r9
  54:    15 00 00 00     l.nop 0x0


Compiling with -O2. Disassembling result:

00000000 <f64_add>:
   0:    d7 e1 0f fc     l.sw -4(r1),r1
   4:    9c 21 ff fc     l.addi r1,r1,-4
   8:    c8 a0 00 10     lf.add.d r5,r5,r5
   c:    9c 21 00 04     l.addi r1,r1,4
  10:    44 00 48 00     l.jr r9
  14:    84 21 ff fc     l.lwz r1,-4(r1)


I think the best result should look like:

  lf.add.d r11,r3,r5  /* {r11,r12} <- {r3,r4} + {r5,r6} */
  l.jr r9
  l.nop 0x0

Any case lf.add.d arguments look incorrectly.

Could anybody make some comments on double instruction implementation status 
in OR1K gcc port?

Andrey 


