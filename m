From: Stafford Horne <shorne@gmail.com>
Date: Fri, 1 Jan 2021 15:11:35 +0900
Subject: [OpenRISC] [PATCH] openrisc: restart: Call common handlers
 before hanging
In-Reply-To: <20201227091446.118437-1-joel@jms.id.au>
References: <20201227091446.118437-1-joel@jms.id.au>
Message-ID: <20210101061135.GA3106870@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Dec 27, 2020 at 07:44:46PM +1030, Joel Stanley wrote:
> Currently openrisc will print a message and then hang in an infinite
> loop when rebooting.
> 
> This patch adopts some code from ARM, which calls the common restart
> infrastructure and hangs after a small delay if the restart infra
> doesn't do anything.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Geert has a patch[1] for the litex soc code that adds a restart hander.
> Openrisc doesn't hit that code path, this patch fixes that.
> 
> [1] https://github.com/geertu/linux/commit/7d09dc0797a8208a11eb7c0c2156c1a4c120180f
> 
>  arch/openrisc/kernel/process.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index 3c98728cce24..181448f74316 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -34,6 +34,7 @@
>  #include <linux/init_task.h>
>  #include <linux/mqueue.h>
>  #include <linux/fs.h>
> +#include <linux/reboot.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/io.h>
> @@ -49,10 +50,16 @@
>   */
>  struct thread_info *current_thread_info_set[NR_CPUS] = { &init_thread_info, };
>  
> -void machine_restart(void)
> +void machine_restart(char *cmd)
>  {
> -	printk(KERN_INFO "*** MACHINE RESTART ***\n");
> -	__asm__("l.nop 1");
Just a note, this nop with argument 1, is used by the simulators to shutdown.  I
am happy to get rid of this though.  The simulator should be simulating how real
hardware is shut down not doing these tricks.

> +	do_kernel_restart(cmd);
As you mentioned this depends on Geert's patch.  Does he plan to submit it soon?

Geert is CCed.

> +
> +	/* Give a grace period for failure to restart of 1s */
> +	mdelay(1000);
> +
> +	/* Whoops - the platform was unable to reboot. Tell the user! */
> +	pr_emerg("Reboot failed -- System halted\n");
> +	while (1);
>  }
>  
>  /*
> -- 
> 2.29.2

I am queing this for 5.11 anyway is it hurt's nothing without Geert's patch.

-Stafford

