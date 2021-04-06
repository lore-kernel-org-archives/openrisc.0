From: Stafford Horne <shorne@gmail.com>
Date: Tue, 6 Apr 2021 17:56:59 +0900
Subject: [OpenRISC] [PATCH v6 6/9] openrisc: qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
In-Reply-To: <1617201040-83905-7-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-7-git-send-email-guoren@kernel.org>
Message-ID: <20210406085659.GF3288043@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 31, 2021 at 02:30:37PM +0000, guoren at kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> We don't have native hw xchg16 instruction, so let qspinlock
> generic code to deal with it.
> 
> Using the full-word atomic xchg instructions implement xchg16 has
> the semantic risk for atomic operations.
> 
> This patch cancels the dependency of on qspinlock generic code on
> architecture's xchg16.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc at lists.librecores.org

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 591acc5990dc..b299e409429f 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -33,6 +33,7 @@ config OPENRISC
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
>  	select ARCH_USE_QUEUED_SPINLOCKS
> +	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select OMPIC if SMP
>  	select ARCH_WANT_FRAME_POINTERS
> -- 
> 2.17.1
> 
