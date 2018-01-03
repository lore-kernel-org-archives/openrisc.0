From: Stafford Horne <shorne@gmail.com>
Date: Wed, 3 Jan 2018 23:41:29 +0900
Subject: [OpenRISC] [PATCH -next] irqchip/ompic: fix return value check
 in ompic_of_init()
In-Reply-To: <1514893639-70586-1-git-send-email-weiyongjun1@huawei.com>
References: <1514893639-70586-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180103144129.GJ32243@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 02, 2018 at 11:47:19AM +0000, Wei Yongjun wrote:
> In case of error, the function ioremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.

Thanks, I am not sure why I was using the *ERR*() macros.  2 questions:

 - How did you notice this?
 - Should I pull this in through my tree or do you have another route? i.e.
   Marc?

> Fixes: 9b54470afd83 ("irqchip: add initial support for ompic")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Stafford Horne <shorne@gmail.com>

-Stafford

> ---
>  drivers/irqchip/irq-ompic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
> index cf6d0c4..400b119 100644
> --- a/drivers/irqchip/irq-ompic.c
> +++ b/drivers/irqchip/irq-ompic.c
> @@ -171,9 +171,9 @@ static int __init ompic_of_init(struct device_node *node,
>  
>  	/* Setup the device */
>  	ompic_base = ioremap(res.start, resource_size(&res));
> -	if (IS_ERR(ompic_base)) {
> +	if (!ompic_base) {
>  		pr_err("ompic: unable to map registers");
> -		return PTR_ERR(ompic_base);
> +		return -ENOMEM;
>  	}
>  
>  	irq = irq_of_parse_and_map(node, 0);
> 
