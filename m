From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 5 Aug 2021 20:41:23 +0200
Subject: [OpenRISC] [PATCH 1/3] arch: Export machine_restart() instances
 so they can be called from modules
In-Reply-To: <20210805173625.GH6719@arm.com>
References: <20210805075032.723037-1-lee.jones@linaro.org>
 <20210805075032.723037-2-lee.jones@linaro.org>
 <20210805173625.GH6719@arm.com>
Message-ID: <YQww08x2whx/LIIT@kroah.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 05, 2021 at 06:36:25PM +0100, Catalin Marinas wrote:
> On Thu, Aug 05, 2021 at 08:50:30AM +0100, Lee Jones wrote:
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index b4bb67f17a2ca..cf89ce91d7145 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -212,6 +212,7 @@ void machine_restart(char *cmd)
> >  	printk("Reboot failed -- System halted\n");
> >  	while (1);
> >  }
> > +EXPORT_SYMBOL(machine_restart);
> 
> Should we make this EXPORT_SYMBOL_GPL? I suppose it's not for general
> use by out of tree drivers and it matches the other pm_power_off symbol
> we export in this file.

Yes please.
