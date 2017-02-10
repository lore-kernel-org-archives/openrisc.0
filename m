From: Stafford Horne <shorne@gmail.com>
Date: Fri, 10 Feb 2017 09:44:04 +0900
Subject: [OpenRISC] [PATCH 23/22] linux-user: Honor CLONE_SETTLS for
	openrisc
In-Reply-To: <20170210000122.4173-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
 <20170210000122.4173-1-rth@twiddle.net>
Message-ID: <20170210004404.GM32144@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

23/22 ?

:)

On Fri, Feb 10, 2017 at 10:01:22AM +1000, Richard Henderson wrote:
> Threads work much better when you set the TLS register.
> This was fixed in the upstream kernel for Linux 4.9.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/openrisc/target_cpu.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
> index a21ed1a..f283d96 100644
> --- a/linux-user/openrisc/target_cpu.h
> +++ b/linux-user/openrisc/target_cpu.h
> @@ -30,9 +30,7 @@ static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
>  
>  static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
>  {
> -    /* Linux kernel 3.10 does not pay any attention to CLONE_SETTLS
> -     * in copy_thread(), so QEMU need not do so either.
> -     */
> +    env->gpr[10] = newtls;
>  }
>  
>  #endif
> -- 
> 2.9.3
> 

Reviewed-by: Stafford Horne <shorne@gmail.com>
