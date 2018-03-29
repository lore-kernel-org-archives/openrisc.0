From: Rob Landley <rob@landley.net>
Date: Thu, 29 Mar 2018 11:39:24 -0500
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <20180328221401.GA14084@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
Message-ID: <c91e8781-5f31-70e8-e7ef-1a80bd5d9454@landley.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 03/28/2018 05:14 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
>>
>>
>> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
>>> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>>>> On 03/28/2018 10:26 AM, Shea Levy wrote:
>>>>> Now only those architectures that have custom initrd free requirements
>>>>> need to define free_initrd_mem.
>>>> ...
>>>>> --- a/arch/arc/mm/init.c
>>>>> +++ b/arch/arc/mm/init.c
>>>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>>>>  {
>>>>>  	free_initmem_default(-1);
>>>>>  }
>>>>> -
>>>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>>>> -{
>>>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>>>> -}
>>>>> -#endif
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index 3f972e83909b..19d1c5594e2d 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -47,6 +47,7 @@ config ARM
>>>>>  	select HARDIRQS_SW_RESEND
>>>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>>>>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>>>
>>>> Isn't this why weak symbols were invented?
>>>
>>> Weak symbols means that we end up with both the weakly-referenced code
>>> and the arch code in the kernel image.  That's fine if the weak code
>>> is small.
>>
>> The kernel's been able to build with link time garbage collection since 2016:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
>>
>> Wouldn't that remove the unused one?
> 
> Probably, if anyone bothered to use that, which they don't.
> 
> LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> what I can see, nothing selects it.  Therefore, the symbol is always
> disabled, and so the feature never gets used in mainline kernels.

It looks like there are per-architecture linker scripts that need to be updated?
So if an architecture supports it, it's always done (well, it probes for the
toolchain supporting the flag). And if the architecture doesn't support it, the
linker script needs to be updated to mark sections with "I know nothing seems to
reference this at the ELF level but keep it anyway, we're pulling an assembly
trick".

> Brings up the obvious question - why is it there if it's completely
> unused?  (Maybe to cause confusion, and allowing a justification
> for __weak ?)

Presumably it will become the default on architectures as their linker scripts
are converted. Once they're all converted the config symbol can go away. (Given
the move to requiring gcc 4.7 or whatever it is, there can't be an architecture
depending on a toolchain that _doesn't_ support it after that point. I doubt you
can pair gcc 4.7 with a >12 year old binutils and expect good things...)

Rob
