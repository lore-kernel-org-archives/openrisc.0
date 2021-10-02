From: Stafford Horne <shorne@gmail.com>
Date: Sat, 2 Oct 2021 21:38:16 +0900
Subject: [OpenRISC] [PATCH] openrisc: time: don't mark comment as
 kernel-doc
In-Reply-To: <20211001021101.18225-1-rdunlap@infradead.org>
References: <20211001021101.18225-1-rdunlap@infradead.org>
Message-ID: <YVhSuFFMnlQm+x+8@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Sep 30, 2021 at 07:11:01PM -0700, Randy Dunlap wrote:
> Fix a kernel-doc warning by unmarking the comment as being in
> kernel-doc notation.
> 
> Fixes this warning:
> arch/openrisc/kernel/time.c:137: warning: expecting prototype for Clocksource(). Prototype was for openrisc_timer_read() instead
> 
> Fixes: b731fbbd246e ("OpenRISC: Timekeeping")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc at lists.librecores.org
> ---
>  arch/openrisc/kernel/time.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210930.orig/arch/openrisc/kernel/time.c
> +++ linux-next-20210930/arch/openrisc/kernel/time.c
> @@ -127,7 +127,7 @@ irqreturn_t __irq_entry timer_interrupt(
>  	return IRQ_HANDLED;
>  }
>  
> -/**
> +/*
>   * Clocksource: Based on OpenRISC timer/counter
>   *
>   * This sets up the OpenRISC Tick Timer as a clock source.  The tick timer

Hi Randy,

This looks good to me, thank you.  I am queuing it.

-Stafford
