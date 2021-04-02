From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 2 Apr 2021 17:36:12 +0200
Subject: [OpenRISC] [PATCH v3 12/17] sh: Convert to GENERIC_CMDLINE
In-Reply-To: <6b76649009943f2893fdfded22becd41db2fe1f7.1616765870.git.christophe.leroy@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <6b76649009943f2893fdfded22becd41db2fe1f7.1616765870.git.christophe.leroy@csgroup.eu>
Message-ID: <d672dec1-6fcb-d5dc-a551-2a99e6dd6976@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 26/03/2021 à 14:44, Christophe Leroy a écrit :
> This converts the architecture to GENERIC_CMDLINE.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---

> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index e798e55915c2..fab84f62448c 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -16,6 +16,7 @@ config SUPERH
>   	select CPU_NO_EFFICIENT_FFS
>   	select DMA_DECLARE_COHERENT
>   	select GENERIC_ATOMIC64
> +	select GENERIC_CMDLINE
>   	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
>   	select GENERIC_IDLE_POLL_SETUP
>   	select GENERIC_IRQ_SHOW
> @@ -742,35 +743,6 @@ config ROMIMAGE_MMCIF
>   	  first part of the romImage which in turn loads the rest the kernel
>   	  image to RAM using the MMCIF hardware block.
>   
> -choice
> -	prompt "Kernel command line"
> -	optional
> -	default CMDLINE_OVERWRITE
> -	help
> -	  Setting this option allows the kernel command line arguments
> -	  to be set.
> -
> -config CMDLINE_OVERWRITE
> -	bool "Overwrite bootloader kernel arguments"
> -	help
> -	  Given string will overwrite any arguments passed in by
> -	  a bootloader.
> -
> -config CMDLINE_EXTEND
> -	bool "Extend bootloader kernel arguments"
> -	help
> -	  Given string will be concatenated with arguments passed in
> -	  by a bootloader.
> -
> -endchoice
> -
> -config CMDLINE
> -	string "Kernel command line arguments string"
> -	depends on CMDLINE_OVERWRITE || CMDLINE_EXTEND
> -	default "console=ttySC1,115200"
> -
> -endmenu
> -

That "endmenu" shall not be removed.

Fixed in v4,

Thanks to Rob L. for the report.
Christophe

>   menu "Bus options"
>   
>   config SUPERHYWAY
