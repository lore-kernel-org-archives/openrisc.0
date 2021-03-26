From: Andreas Schwab <schwab@linux-m68k.org>
Date: Fri, 26 Mar 2021 15:08:22 +0100
Subject: [OpenRISC] [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
In-Reply-To: <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 (Christophe Leroy's message of "Fri, 26 Mar 2021 13:44:58 +0000
 (UTC)")
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
Message-ID: <87zgyqdn3d.fsf@igel.home>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Mär 26 2021, Christophe Leroy wrote:

> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f8f15332caa2..e7c91ee478d1 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -20,6 +20,7 @@
>  #include <linux/swiotlb.h>
>  #include <linux/smp.h>
>  #include <linux/efi.h>
> +#include <linux/cmdline.h>
>  
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
>  	}
>  
>  	pr_err("No DTB passed to the kernel\n");
> -#ifdef CONFIG_CMDLINE_FORCE
> -	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +	cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
>  	pr_info("Forcing kernel command line to: %s\n", boot_command_line);

Shouldn't that message become conditional in some way?

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
