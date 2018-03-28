From: Shea Levy <shea@shealevy.com>
Date: Wed, 28 Mar 2018 12:04:12 -0400
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
Message-ID: <877epwtceb.fsf@xps13.shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Rob,

Rob Landley <rob@landley.net> writes:

> On 03/28/2018 10:26 AM, Shea Levy wrote:
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
> ...
>> --- a/arch/arc/mm/init.c
>> +++ b/arch/arc/mm/init.c
>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>  {
>>  	free_initmem_default(-1);
>>  }
>> -
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>> -{
>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> -}
>> -#endif
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 3f972e83909b..19d1c5594e2d 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -47,6 +47,7 @@ config ARM
>>  	select HARDIRQS_SW_RESEND
>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>
> Isn't this why weak symbols were invented?
>

This approach was suggested by Christoph Hellwig upthread, and seems to
have some precedent elsewhere (e.g. strncasecmp), but I agree weak
symbols seem appropriate here. I'm happy to implement either approach!

>
> Confused,
>
> Rob

Thanks,
Shea
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180328/fbee2bd2/attachment-0001.sig>
