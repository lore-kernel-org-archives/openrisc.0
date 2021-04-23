From: Stafford Horne <shorne@gmail.com>
Date: Sat, 24 Apr 2021 06:19:39 +0900
Subject: [OpenRISC] [PATCH] openrisc: Fix a memory leak
In-Reply-To: <c078439e31fd60e1617be8c17cc1ec57639e0586.1619190470.git.christophe.jaillet@wanadoo.fr>
References: <c078439e31fd60e1617be8c17cc1ec57639e0586.1619190470.git.christophe.jaillet@wanadoo.fr>
Message-ID: <20210423211939.GP3288043@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Apr 23, 2021 at 05:09:28PM +0200, Christophe JAILLET wrote:
> 'setup_find_cpu_node()' take a reference on the node it returns.
> This reference must be decremented when not needed anymore, or there will
> be a leak.
> 
> Add the missing 'of_node_put(cpu)'.
> 
> Note that 'setup_cpuinfo()' that also calls this function already has a
> correct 'of_node_put(cpu)' at its end.

Thanks, this looks good to me.  I will queue it up.

> Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/openrisc/kernel/setup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 2416a9f91533..c6f9e7b9f7cb 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -278,6 +278,8 @@ void calibrate_delay(void)
>  	pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
>  		loops_per_jiffy / (500000 / HZ),
>  		(loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
> +
> +	of_node_put(cpu);
>  }
>  
>  void __init setup_arch(char **cmdline_p)
> -- 
> 2.27.0
> 
