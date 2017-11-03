From: Stafford Horne <shorne@gmail.com>
Date: Fri, 3 Nov 2017 14:04:42 +0900
Subject: [OpenRISC] [PATCH 3/3] openrisc: dts: Add OpenRISC platform SoC
In-Reply-To: <20171022024641.28478-4-shorne@gmail.com>
References: <20171022024641.28478-1-shorne@gmail.com>
 <20171022024641.28478-4-shorne@gmail.com>
Message-ID: <20171103050442.GJ29237@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Oct 22, 2017 at 11:46:41AM +0900, Stafford Horne wrote:
> Add devicetree binding documentation for the OpenRISC platform
> opencores,or1ksim.  This is the main OpenRISC reference platform
> supporting multiple FPGA SoC's.
> 
> This format is based on some of the mips binding docs as we have
> similar requirements.
> 
> Also, update maintainers so openrisc related binding changes are visible
> to the openrisc team.
> 

[..]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a57d13cb414d..71e4f6762196 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10008,6 +10008,7 @@ T:	git git://github.com/openrisc/linux.git
>  L:	openrisc at lists.librecores.org
>  W:	http://openrisc.io
>  S:	Maintained
> +F;	Documentation/devicetree/bindings/openrisc/

FYI, I found this typo (; vs :) which I have fixed and am pushing to next.

>  F:	Documentation/openrisc/
>  F:	arch/openrisc/
>  F:	drivers/irqchip/irq-or1k-*
> -- 
> 2.13.6
> 
