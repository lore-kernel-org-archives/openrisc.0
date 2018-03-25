From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:20:02 -0400
Subject: [OpenRISC] [PATCH 01/16] initrd: Add generic code path for
	common initrd unloading logic.
In-Reply-To: <20180325191740.Horde.Cymi0yr0xcQQV1s42wkNkg2@messagerie.si.c-s.fr>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180324174458.26423-2-shea@shealevy.com>
 <20180325191740.Horde.Cymi0yr0xcQQV1s42wkNkg2@messagerie.si.c-s.fr>
Message-ID: <87r2o7u7al.fsf@xps13.shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi Christophe,

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Shea Levy <shea@shealevy.com> a écrit :
>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>  init/initramfs.c | 7 +++++++
>>  usr/Kconfig      | 4 ++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/init/initramfs.c b/init/initramfs.c
>> index 7e99a0038942..de5ce873eb5a 100644
>> --- a/init/initramfs.c
>> +++ b/init/initramfs.c
>> @@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
>>  #include <linux/initrd.h>
>>  #include <linux/kexec.h>
>>
>> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
>> +void free_initrd_mem(unsigned long start, unsigned long end)
>> +{
>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> +}
>> +#endif
>
> In powerpc this was an __init function. Why not also put the generic  
> one in __init section ?
>

v2 series sent, thanks!

>
> Christophe
>
>
>> +
>>  static void __init free_initrd(void)
>>  {
>>  #ifdef CONFIG_KEXEC_CORE
>> diff --git a/usr/Kconfig b/usr/Kconfig
>> index 43658b8a975e..fd79d4d6fa26 100644
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>  	default ".lzma" if RD_LZMA
>>  	default ".bz2"  if RD_BZIP2
>>  	default ""
>> +
>> +# Arches can select this for a generic initrd unloading codepath
>> +config INITRAMFS_GENERIC_UNLOAD
>> +	bool
>> --
>> 2.16.2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180325/e9ef1b66/attachment.sig>
