From: Joe Perches <joe@perches.com>
Date: Tue, 21 Feb 2017 12:24:41 -0800
Subject: [OpenRISC] [PATCH v3 14/25] openrisc: Initial support for the
	idle state
In-Reply-To: <705d104f39c66faddd1fda08fc7b04f2b2e6a840.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <705d104f39c66faddd1fda08fc7b04f2b2e6a840.1487702890.git.shorne@gmail.com>
Message-ID: <1487708681.2853.35.camel@perches.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 2017-02-22 at 04:11 +0900, Stafford Horne wrote:
> From: Sebastian Macke <sebastian@macke.de>
> 
> This patch adds basic support for the idle state of the cpu.
> The patch overrides the regular idle function, enables the interupts,
> checks for the power management unit and enables the cpu doze mode
> if available.

trivia:

> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
[]
> @@ -75,6 +75,20 @@ void machine_power_off(void)
>  	__asm__("l.nop 1");
>  }
>  
> +/*
> + * Send the doze signal to the cpu if available.
> + * Make sure, that all interrupts are enabled
> + */
> +void arch_cpu_idle(void)
> +{
> +	unsigned long upr;
> +
> +	local_irq_enable();
> +	upr = mfspr(SPR_UPR);
> +	if (upr & SPR_UPR_PMP)
> +		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
> +}

Perhaps this would be easier to read without the automatic

void arch_cpu_idle(void)
{
	local_irq_enable();
	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
}

