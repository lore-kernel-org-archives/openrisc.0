From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Wed, 2 Mar 2022 07:05:31 +0000
Subject: [OpenRISC] [PATCH V3 09/30] arm/mm: Enable
 ARCH_HAS_VM_GET_PAGE_PROT
In-Reply-To: <c3b60de0-38cd-160a-aa15-831349e07e23@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
 <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
 <542fa048-131e-240b-cc3a-fd4fff7ce4ba@arm.com>
 <Yh1pYAOiskEQes3p@shell.armlinux.org.uk>
 <dc3c95a4-de06-9889-ce1e-f660fc9fbb95@csgroup.eu>
 <c3b60de0-38cd-160a-aa15-831349e07e23@arm.com>
Message-ID: <52866c88-59f9-2d1c-6f5a-5afcaf23f2bb@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 02/03/2022 à 04:22, Anshuman Khandual a écrit :
> 
> 
> On 3/1/22 1:46 PM, Christophe Leroy wrote:
>>
>>
>> Le 01/03/2022 à 01:31, Russell King (Oracle) a écrit :
>>> On Tue, Mar 01, 2022 at 05:30:41AM +0530, Anshuman Khandual wrote:
>>>> On 2/28/22 4:27 PM, Russell King (Oracle) wrote:
>>>>> On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
>>>>>> This defines and exports a platform specific custom vm_get_page_prot() via
>>>>>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>>>>>> macros can be dropped which are no longer needed.
>>>>>
>>>>> What I would really like to know is why having to run _code_ to work out
>>>>> what the page protections need to be is better than looking it up in a
>>>>> table.
>>>>>
>>>>> Not only is this more expensive in terms of CPU cycles, it also brings
>>>>> additional code size with it.
>>>>>
>>>>> I'm struggling to see what the benefit is.
>>>>
>>>> Currently vm_get_page_prot() is also being _run_ to fetch required page
>>>> protection values. Although that is being run in the core MM and from a
>>>> platform perspective __SXXX, __PXXX are just being exported for a table.
>>>> Looking it up in a table (and applying more constructs there after) is
>>>> not much different than a clean switch case statement in terms of CPU
>>>> usage. So this is not more expensive in terms of CPU cycles.
>>>
>>> I disagree.
>>
>> So do I.
>>
>>>
>>> However, let's base this disagreement on some evidence. Here is the
>>> present 32-bit ARM implementation:
>>>
>>> 00000048 <vm_get_page_prot>:
>>>         48:       e200000f        and     r0, r0, #15
>>>         4c:       e3003000        movw    r3, #0
>>>                           4c: R_ARM_MOVW_ABS_NC   .LANCHOR1
>>>         50:       e3403000        movt    r3, #0
>>>                           50: R_ARM_MOVT_ABS      .LANCHOR1
>>>         54:       e7930100        ldr     r0, [r3, r0, lsl #2]
>>>         58:       e12fff1e        bx      lr
>>>
>>> That is five instructions long.
>>
>> On ppc32 I get:
>>
>> 00000094 <vm_get_page_prot>:
>>         94:	3d 20 00 00 	lis     r9,0
>> 			96: R_PPC_ADDR16_HA	.data..ro_after_init
>>         98:	54 84 16 ba 	rlwinm  r4,r4,2,26,29
>>         9c:	39 29 00 00 	addi    r9,r9,0
>> 			9e: R_PPC_ADDR16_LO	.data..ro_after_init
>>         a0:	7d 29 20 2e 	lwzx    r9,r9,r4
>>         a4:	91 23 00 00 	stw     r9,0(r3)
>>         a8:	4e 80 00 20 	blr
>>
>>
>>>
>>> Please show that your new implementation is not more expensive on
>>> 32-bit ARM. Please do so by building a 32-bit kernel, and providing
>>> the disassembly.
>>
>> With your series I get:
>>
>> 00000000 <vm_get_page_prot>:
>>      0:	3d 20 00 00 	lis     r9,0
>> 			2: R_PPC_ADDR16_HA	.rodata
>>      4:	39 29 00 00 	addi    r9,r9,0
>> 			6: R_PPC_ADDR16_LO	.rodata
>>      8:	54 84 16 ba 	rlwinm  r4,r4,2,26,29
>>      c:	7d 49 20 2e 	lwzx    r10,r9,r4
>>     10:	7d 4a 4a 14 	add     r10,r10,r9
>>     14:	7d 49 03 a6 	mtctr   r10
>>     18:	4e 80 04 20 	bctr
>>     1c:	39 20 03 15 	li      r9,789
>>     20:	91 23 00 00 	stw     r9,0(r3)
>>     24:	4e 80 00 20 	blr
>>     28:	39 20 01 15 	li      r9,277
>>     2c:	91 23 00 00 	stw     r9,0(r3)
>>     30:	4e 80 00 20 	blr
>>     34:	39 20 07 15 	li      r9,1813
>>     38:	91 23 00 00 	stw     r9,0(r3)
>>     3c:	4e 80 00 20 	blr
>>     40:	39 20 05 15 	li      r9,1301
>>     44:	91 23 00 00 	stw     r9,0(r3)
>>     48:	4e 80 00 20 	blr
>>     4c:	39 20 01 11 	li      r9,273
>>     50:	4b ff ff d0 	b       20 <vm_get_page_prot+0x20>
>>
>>
>> That is definitely more expensive, it implements a table of branches.
> 
> Okay, will split out the PPC32 implementation that retains existing
> table look up method. Also planning to keep that inside same file
> (arch/powerpc/mm/mmap.c), unless you have a difference preference.

My point was not to get something specific for PPC32, but to amplify on 
Russell's objection.

As this is bad for ARM and bad for PPC32, do we have any evidence that 
your change is good for any other architecture ?

I checked PPC64 and there is exactly the same drawback. With the current 
implementation it is a small function performing table read then a few 
adjustment. After your change it is a bigger function implementing a 
table of branches.

So, as requested by Russell, could you look at the disassembly for other 
architectures and show us that ARM and POWERPC are the only ones for 
which your change is not optimal ?

See below the difference for POWERPC64.

Current implementation:

0000000000000a60 <.vm_get_page_prot>:
      a60:	3d 42 00 00 	addis   r10,r2,0
			a62: R_PPC64_TOC16_HA	.data..ro_after_init
      a64:	78 89 1e 68 	rldic   r9,r4,3,57
      a68:	39 4a 00 00 	addi    r10,r10,0
			a6a: R_PPC64_TOC16_LO	.data..ro_after_init
      a6c:	74 88 01 00 	andis.  r8,r4,256
      a70:	7d 2a 48 2a 	ldx     r9,r10,r9
      a74:	41 82 00 1c 	beq     a90 <.vm_get_page_prot+0x30>
      a78:	60 00 00 00 	nop
      a7c:	60 00 00 00 	nop
      a80:	48 00 00 18 	b       a98 <.vm_get_page_prot+0x38>
      a84:	60 00 00 00 	nop
      a88:	60 00 00 00 	nop
      a8c:	60 00 00 00 	nop
      a90:	60 00 00 00 	nop
      a94:	60 00 00 00 	nop
      a98:	0f e0 00 00 	twui    r0,0
      a9c:	60 00 00 00 	nop
      aa0:	38 80 00 10 	li      r4,16
      aa4:	7d 29 23 78 	or      r9,r9,r4
      aa8:	f9 23 00 00 	std     r9,0(r3)
      aac:	4e 80 00 20 	blr
      ab0:	78 84 d9 04 	rldicr  r4,r4,27,4
      ab4:	78 84 e8 c2 	rldicl  r4,r4,61,3
      ab8:	60 84 00 10 	ori     r4,r4,16
      abc:	4b ff ff e8 	b       aa4 <.vm_get_page_prot+0x44>
      ac0:	78 84 d9 04 	rldicr  r4,r4,27,4
      ac4:	78 84 e8 c2 	rldicl  r4,r4,61,3
      ac8:	4b ff ff dc 	b       aa4 <.vm_get_page_prot+0x44>


With your series:

00000000000005b0 <.vm_get_page_prot>:
  5b0:	3d 22 00 00 	addis   r9,r2,0
			5b2: R_PPC64_TOC16_HA	.toc+0x10
  5b4:	e9 49 00 00 	ld      r10,0(r9)
			5b6: R_PPC64_TOC16_LO_DS	.toc+0x10
  5b8:	78 89 16 a8 	rldic   r9,r4,2,58
  5bc:	7d 2a 4a aa 	lwax    r9,r10,r9
  5c0:	7d 29 52 14 	add     r9,r9,r10
  5c4:	7d 29 03 a6 	mtctr   r9
  5c8:	3d 20 80 00 	lis     r9,-32768
  5cc:	79 29 07 c6 	rldicr  r9,r9,32,31
  5d0:	4e 80 04 20 	bctr
  5d4:	00 00 00 ec 	.long 0xec
  5d8:	00 00 00 6c 	.long 0x6c
  5dc:	00 00 00 6c 	.long 0x6c
  5e0:	00 00 00 6c 	.long 0x6c
  5e4:	00 00 00 4c 	.long 0x4c
  5e8:	00 00 00 4c 	.long 0x4c
  5ec:	00 00 00 4c 	.long 0x4c
  5f0:	00 00 00 4c 	.long 0x4c
  5f4:	00 00 00 ec 	.long 0xec
  5f8:	00 00 00 6c 	.long 0x6c
  5fc:	00 00 00 cc 	.long 0xcc
  600:	00 00 00 cc 	.long 0xcc
  604:	00 00 00 4c 	.long 0x4c
  608:	00 00 00 4c 	.long 0x4c
  60c:	00 00 00 dc 	.long 0xdc
  610:	00 00 00 dc 	.long 0xdc
  614:	60 00 00 00 	nop
  618:	60 00 00 00 	nop
  61c:	60 00 00 00 	nop
  620:	61 29 01 05 	ori     r9,r9,261
  624:	74 8a 01 00 	andis.  r10,r4,256
  628:	41 82 00 24 	beq     64c <.vm_get_page_prot+0x9c>
  62c:	60 00 00 00 	nop
  630:	60 00 00 00 	nop
  634:	0f e0 00 00 	twui    r0,0
  638:	60 00 00 00 	nop
  63c:	60 00 00 00 	nop
  640:	74 8a 01 00 	andis.  r10,r4,256
  644:	61 29 01 04 	ori     r9,r9,260
  648:	40 82 ff e4 	bne     62c <.vm_get_page_prot+0x7c>
  64c:	60 00 00 00 	nop
  650:	60 00 00 00 	nop
  654:	4b ff ff e0 	b       634 <.vm_get_page_prot+0x84>
  658:	60 00 00 00 	nop
  65c:	60 00 00 00 	nop
  660:	78 84 d9 04 	rldicr  r4,r4,27,4
  664:	78 84 e8 c2 	rldicl  r4,r4,61,3
  668:	7d 29 23 78 	or      r9,r9,r4
  66c:	f9 23 00 00 	std     r9,0(r3)
  670:	4e 80 00 20 	blr
  674:	60 00 00 00 	nop
  678:	60 00 00 00 	nop
  67c:	60 00 00 00 	nop
  680:	38 80 00 10 	li      r4,16
  684:	4b ff ff e4 	b       668 <.vm_get_page_prot+0xb8>
  688:	60 00 00 00 	nop
  68c:	60 00 00 00 	nop
  690:	78 84 d9 04 	rldicr  r4,r4,27,4
  694:	78 84 e8 c2 	rldicl  r4,r4,61,3
  698:	60 84 00 10 	ori     r4,r4,16
  69c:	4b ff ff cc 	b       668 <.vm_get_page_prot+0xb8>
  6a0:	61 29 01 06 	ori     r9,r9,262
  6a4:	4b ff ff 80 	b       624 <.vm_get_page_prot+0x74>
  6a8:	60 00 00 00 	nop
  6ac:	60 00 00 00 	nop
  6b0:	61 29 01 07 	ori     r9,r9,263
  6b4:	4b ff ff 70 	b       624 <.vm_get_page_prot+0x74>
  6b8:	60 00 00 00 	nop
  6bc:	60 00 00 00 	nop
  6c0:	61 29 01 08 	ori     r9,r9,264
  6c4:	4b ff ff 60 	b       624 <.vm_get_page_prot+0x74>

Thanks
Christophe
