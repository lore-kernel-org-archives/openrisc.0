From: Stafford Horne <shorne@gmail.com>
Date: Wed, 11 Aug 2021 06:15:43 +0900
Subject: [OpenRISC] [PATCH v2] openrisc: Fix compiler warnings in setup
In-Reply-To: <8a830ab7-6b66-1ca9-bd73-fc1551def648@infradead.org>
References: <20210808135437.3640549-1-shorne@gmail.com>
 <8a830ab7-6b66-1ca9-bd73-fc1551def648@infradead.org>
Message-ID: <YRLsf2VyGTQVapuV@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Aug 09, 2021 at 10:51:01AM -0700, Randy Dunlap wrote:
> On 8/8/21 6:54 AM, Stafford Horne wrote:
> > This was pointed out with the recent name change of or32_early_setup to
> > or1k_early_setup.  Investigating the file I found a few other warnings
> > so cleaning them up here.
> > 
> >      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
> >        220 | void __init or1k_early_setup(void *fdt)
> > 	  |             ^~~~~~~~~~~~~~~~
> > 
> > Fix this the missing or1k_early_setup prototype warning by adding an
> > asm/setup.h file to define the prototype.
> > 
> >      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
> >        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> > 	  |             ^~~~~~~~~~~~~~~~~~
> > 
> > The function detect_unit_config is not used, just remove it.
> > 
> >      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> > 
> > Add @fdt docs to the function comment to suppress this warning.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you.

> > ---
> > 
> > Changes since v1:
> >   - Add #include <linux/init.h> to fix compile failure.  Pointed out by robot and
> >     randy.
> > 
> >   arch/openrisc/include/asm/setup.h | 15 +++++++++++++++
> >   arch/openrisc/kernel/setup.c      | 16 +---------------
> >   2 files changed, 16 insertions(+), 15 deletions(-)
> >   create mode 100644 arch/openrisc/include/asm/setup.h
> > 
> > diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
> > new file mode 100644
> > index 000000000000..9acbc5deda69
> > --- /dev/null
> > +++ b/arch/openrisc/include/asm/setup.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2021 Stafford Horne
> > + */
> > +#ifndef _ASM_OR1K_SETUP_H
> > +#define _ASM_OR1K_SETUP_H
> > +
> > +#include <linux/init.h>
> > +#include <asm-generic/setup.h>
> > +
> > +#ifndef __ASSEMBLY__
> > +void __init or1k_early_setup(void *fdt);
> > +#endif
> > +
> > +#endif /* _ASM_OR1K_SETUP_H */
> > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> > index 7eddcac0ef2f..0cd04d936a7a 100644
> > --- a/arch/openrisc/kernel/setup.c
> > +++ b/arch/openrisc/kernel/setup.c
> > @@ -210,6 +210,7 @@ void __init setup_cpuinfo(void)
> >   /**
> >    * or1k_early_setup
> > + * @fdt: pointer to the start of the device tree in memory or NULL
> >    *
> >    * Handles the pointer to the device tree that this kernel is to use
> >    * for establishing the available platform devices.
> > @@ -243,21 +244,6 @@ static inline unsigned long extract_value(unsigned long reg, unsigned long mask)
> >   	return mask & reg;
> >   }
> > -void __init detect_unit_config(unsigned long upr, unsigned long mask,
> > -			       char *text, void (*func) (void))
> > -{
> > -	if (text != NULL)
> > -		printk("%s", text);
> > -
> > -	if (upr & mask) {
> > -		if (func != NULL)
> > -			func();
> > -		else
> > -			printk("present\n");
> > -	} else
> > -		printk("not present\n");
> > -}
> > -
> >   /*
> >    * calibrate_delay
> >    *
> > 
> 
> 
> -- 
> ~Randy
> 
