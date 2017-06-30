From: Stafford Horne <shorne@gmail.com>
Date: Fri, 30 Jun 2017 22:04:34 +0900
Subject: [OpenRISC] [PATCH] irqchip: or1k-pic: Fix interrupt system.
In-Reply-To: <20170630113356.GA20194@gmail.com>
References: <20170630113356.GA20194@gmail.com>
Message-ID: <20170630130434.GB2589@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

+CC Kernel List

On Fri, Jun 30, 2017 at 08:33:56AM -0300, Pedro H. Penna wrote:
> Usually, hardware implicitly acknowledges interruts when
> reading them. However, if this is not the case, the IRQ
> gets fired over and over again in the current implementation.
> 
> This patch uses the right mask acknowledge function to handle the
> aforementioned situation on or1k processors that interact with
> such kind of hardware.
> 
> Signed-off-by: Pedro H. Penna <pedrohenriquepenna@gmail.com>

Acked-by: Stafford Horne

I am ok to take this patch into my tree if no one objects.  But if someone
wants to take it through the drive tree I am fine too.

> ---
>  drivers/irqchip/irq-or1k-pic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
> index 6a9a3e7..dd9d5d1 100644
> --- a/drivers/irqchip/irq-or1k-pic.c
> +++ b/drivers/irqchip/irq-or1k-pic.c
> @@ -70,7 +70,7 @@ static struct or1k_pic_dev or1k_pic_level = {
>  		.name = "or1k-PIC-level",
>  		.irq_unmask = or1k_pic_unmask,
>  		.irq_mask = or1k_pic_mask,
> -		.irq_mask_ack = or1k_pic_mask,
> +		.irq_mask_ack = or1k_pic_mask_ack,
>  	},
>  	.handle = handle_level_irq,
>  	.flags = IRQ_LEVEL | IRQ_NOPROBE,
> -- 
> 2.7.4
> 
