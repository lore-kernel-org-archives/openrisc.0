From: Wei Yang <richard.weiyang@gmail.com>
Date: Thu, 29 Mar 2018 09:12:10 +0800
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
Message-ID: <20180329011210.GA4275@WeideMacBook-Pro.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 28, 2018 at 09:55:07AM -0700, Kees Cook wrote:
>On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
>>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
>Yay consolidation! :)
>
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>         default ".lzma" if RD_LZMA
>>         default ".bz2"  if RD_BZIP2
>>         default ""
>> +
>> +config HAVE_ARCH_FREE_INITRD_MEM
>> +       bool
>> +       default n
>
>If you keep the Kconfig, you can leave off "default n", and I'd
>suggest adding a help section just to describe what the per-arch
>responsibilities are when select-ing the config. (See
>HAVE_ARCH_SECCOMP_FILTER for an example.)
>

One question about this change.

The original code would "select" HAVE_ARCH_FREE_INITRD_MEM on those arch.
After this change, we need to manually "select" this?

>-Kees
>
>-- 
>Kees Cook
>Pixel Security

-- 
Wei Yang
Help you, Help me
