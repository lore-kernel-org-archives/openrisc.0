From: Stafford Horne <shorne@gmail.com>
Date: Mon, 12 Sep 2016 19:40:33 +0900 (JST)
Subject: [OpenRISC] [PATCH] openrisc: remove the redundant
	of_platform_populate
In-Reply-To: <20160830151059.23353-1-robh@kernel.org>
References: <20160830151059.23353-1-robh@kernel.org>
Message-ID: <alpine.LFD.2.20.1609121936080.2354@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Tue, 30 Aug 2016, Rob Herring wrote:

> The of_platform_populate call in the openrisc arch code is now redundant
> as the DT core provides a default call. Openrisc has a NULL match table
> which means only top level nodes with compatible strings will have
> devices creates. The default version will also descend nodes in the
> match table such as "simple-bus" which should be fine as openrisc
> doesn't have any of these (though it is preferred that memory-mapped
> peripherals be grouped under a bus node(s)).

This looks fine to me.  I am not sure if you got a reply from Jonas, but 
he hasn't been active maintainer for a while.

We are working on getting this sorted out.

-Stafford

> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> ---
> arch/openrisc/kernel/setup.c | 10 ----------
> 1 file changed, 10 deletions(-)
>
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index b4ed8b3..d2f78cf7 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -38,7 +38,6 @@
> #include <linux/of.h>
> #include <linux/memblock.h>
> #include <linux/device.h>
> -#include <linux/of_platform.h>
>
> #include <asm/sections.h>
> #include <asm/segment.h>
> @@ -219,15 +218,6 @@ void __init or32_early_setup(void *fdt)
> 	early_init_devtree(fdt);
> }
>
> -static int __init openrisc_device_probe(void)
> -{
> -	of_platform_populate(NULL, NULL, NULL, NULL);
> -
> -	return 0;
> -}
> -
> -device_initcall(openrisc_device_probe);
> -
> static inline unsigned long extract_value_bits(unsigned long reg,
> 					       short bit_nr, short width)
> {
> -- 
> 2.9.3



