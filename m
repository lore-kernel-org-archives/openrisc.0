From: Jakob Viketoft <jakob.viketoft@aacmicrotec.com>
Date: Wed, 19 Oct 2016 16:39:02 +0000
Subject: [OpenRISC] GCC-optimizations/weirdness...
Message-ID: <D90E780DD5090A4F9AEBC859615CED77EE1CEE69@OXYGEN.aacmicrotec.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello any gcc-gurus out there!

I've hit a major performance obstacle on 64-bit mul/div which is used by default in the RTEMS kernel. I feel this should be able to speed up considerably using some clever maths and the (possibly) defined hardware instructions for 32 bits. However, I'm not quite sure how the translation in gcc is made. Looking into the or1k-port of gcc, I have yet to see a way of defining 64-bit mul/div operations as compared to the 32-bit which are implemented. Please see my test code and a dump of it's assembler below which shows how these are implemented today.

I also consistently see unnecessary stack operations which might be quite a bummer in terms of performance as well, please see the same code snippets below.

Any help or pointers are more than welcome!

     /Jakob

---------------------------8<--------------------------

uint64_t add64(uint64_t a, uint64_t b)
{
  return a + b;
}

uint64_t mul64(uint64_t a, uint64_t b)
{
  return a * b;
}

uint64_t div64(uint64_t a, uint64_t b)
{
  return a / b;
}

uint32_t add32(uint32_t a, uint32_t b)
{
  return a + b;
}

uint32_t mul32(uint32_t a, uint32_t b)
{
  return a * b;
}

uint32_t div32(uint32_t a, uint32_t b)
{
  return a / b;
}


00002df4 <add64>:
    2df4:       e1 84 30 00      l.add r12,r4,r6
    2df8:       d7 e1 0f fc      l.sw -4(r1),r1
    2dfc:       e4 8c 20 00      l.sfltu r12,r4
    2e00:       9c 21 ff fc      l.addi r1,r1,-4
    2e04:       10 00 00 03      l.bf 2e10 <add64+0x1c>
    2e08:       9c 80 00 01      l.addi r4,r0,1
    2e0c:       9c 80 00 00      l.addi r4,r0,0
    2e10:       e1 63 28 00      l.add r11,r3,r5
    2e14:       9c 21 00 04      l.addi r1,r1,4
    2e18:       e1 64 58 00      l.add r11,r4,r11
    2e1c:       44 00 48 00      l.jr r9
    2e20:       84 21 ff fc      l.lwz r1,-4(r1)

00002e24 <mul64>:
    2e24:       d7 e1 4f fc      l.sw -4(r1),r9
    2e28:       d7 e1 0f f8      l.sw -8(r1),r1
    2e2c:       04 00 03 96      l.jal 3c84 <__muldi3>
    2e30:       9c 21 ff f8      l.addi r1,r1,-8
    2e34:       9c 21 00 08      l.addi r1,r1,8
    2e38:       85 21 ff fc      l.lwz r9,-4(r1)
    2e3c:       44 00 48 00      l.jr r9
    2e40:       84 21 ff f8      l.lwz r1,-8(r1)

00002e44 <div64>:
    2e44:       d7 e1 4f fc      l.sw -4(r1),r9
    2e48:       d7 e1 0f f8      l.sw -8(r1),r1
    2e4c:       04 00 03 ad      l.jal 3d00 <__udivdi3>
    2e50:       9c 21 ff f8      l.addi r1,r1,-8
    2e54:       9c 21 00 08      l.addi r1,r1,8
    2e58:       85 21 ff fc      l.lwz r9,-4(r1)
    2e5c:       44 00 48 00      l.jr r9
    2e60:       84 21 ff f8      l.lwz r1,-8(r1)

00002e64 <add32>:
    2e64:       d7 e1 0f fc      l.sw -4(r1),r1
    2e68:       9c 21 ff fc      l.addi r1,r1,-4
    2e6c:       e1 63 20 00      l.add r11,r3,r4
    2e70:       9c 21 00 04      l.addi r1,r1,4
    2e74:       44 00 48 00      l.jr r9
    2e78:       84 21 ff fc      l.lwz r1,-4(r1)

00002e7c <mul32>:
    2e7c:       d7 e1 0f fc      l.sw -4(r1),r1
    2e80:       9c 21 ff fc      l.addi r1,r1,-4
    2e84:       e1 63 23 06      l.mul r11,r3,r4
    2e88:       9c 21 00 04      l.addi r1,r1,4
    2e8c:       44 00 48 00      l.jr r9
    2e90:       84 21 ff fc      l.lwz r1,-4(r1)

00002e94 <div32>:
    2e94:       d7 e1 0f fc      l.sw -4(r1),r1
    2e98:       9c 21 ff fc      l.addi r1,r1,-4
    2e9c:       e1 63 23 0a      l.divu r11,r3,r4
    2ea0:       9c 21 00 04      l.addi r1,r1,4
    2ea4:       44 00 48 00      l.jr r9
    2ea8:       84 21 ff fc      l.lwz r1,-4(r1)



Jakob Viketoft
Senior Engineer in RTL and embedded software

ÅAC Microtec AB
Dag Hammarskjölds väg 48
SE-751 83 Uppsala, Sweden

T: +46 702 80 95 97
http://www.aacmicrotec.com

