From: Rob Landley <rob@landley.net>
Date: Wed, 28 Mar 2018 14:04:22 -0500
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <20180328164813.GA3888@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
Message-ID: <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>> On 03/28/2018 10:26 AM, Shea Levy wrote:
>>> Now only those architectures that have custom initrd free requirements
>>> need to define free_initrd_mem.
>> ...
>>> --- a/arch/arc/mm/init.c
>>> +++ b/arch/arc/mm/init.c
>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>>  {
>>>  	free_initmem_default(-1);
>>>  }
>>> -
>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>> -{
>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>> -}
>>> -#endif
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 3f972e83909b..19d1c5594e2d 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -47,6 +47,7 @@ config ARM
>>>  	select HARDIRQS_SW_RESEND
>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>
>> Isn't this why weak symbols were invented?
> 
> Weak symbols means that we end up with both the weakly-referenced code
> and the arch code in the kernel image.  That's fine if the weak code
> is small.

The kernel's been able to build with link time garbage collection since 2016:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d

Wouldn't that remove the unused one?

Rob
