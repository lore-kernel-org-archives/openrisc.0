From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Sep 2017 15:29:58 -0500
Subject: [OpenRISC] [PATCH v2 06/14] irqchip: add initial support for
	ompic
In-Reply-To: <20170914065402.GU2609@lianli.shorne-pla.net>
References: <20170910064926.5874-1-shorne@gmail.com>
 <20170910064926.5874-7-shorne@gmail.com> <86h8w6see4.fsf@arm.com>
 <20170914065402.GU2609@lianli.shorne-pla.net>
Message-ID: <20170918202958.sayo3t7xnok3do72@rob-hp-laptop>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Sep 14, 2017 at 03:54:02PM +0900, Stafford Horne wrote:
> On Wed, Sep 13, 2017 at 06:21:39PM +0100, Marc Zyngier wrote:
> > On Sun, Sep 10 2017 at  3:49:18 pm BST, Stafford Horne <shorne@gmail.com> wrote:
> > > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > >
> > > IPI driver for the Open Multi-Processor Interrupt Controller (ompic) as
> > > described in the Multicore support section of the OpenRISC 1.2
> > > proposed architecture specification:
> > >
> > >   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
> > >
> > > Each OpenRISC core contains a full interrupt controller which is used in
> > > the SMP architecture for interrupt balancing.  This IPI device, the
> > > ompic, is the only external device required for enabling SMP on
> > > OpenRISC.
> > >
> > > Pending ops are stored in a memory bit mask which can allow multiple
> > > pending operations to be set and serviced at a time. This is mostly
> > > borrowed from the alpha IPI implementation.
> > >
> > > Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > > [shorne at gmail.com: converted ops to bitmask, wrote commit message]
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > ---
> > >
> > > Changes since v1
> > >  - Added openrisc, prefix
> > >  - Clarified 8 bytes per cpu
> > >  - Removed #interrupt-cells as this will not be an irq parent
> > >  - Changed ops to be percpu
> > >  - Added DTS and intialization failure validations
> > >
> > >  .../interrupt-controller/openrisc,ompic.txt        |  19 ++
> > >  arch/openrisc/Kconfig                              |   1 +
> > >  drivers/irqchip/Kconfig                            |   3 +
> > >  drivers/irqchip/Makefile                           |   1 +
> > >  drivers/irqchip/irq-ompic.c                        | 205 +++++++++++++++++++++
> > >  5 files changed, 229 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> > >  create mode 100644 drivers/irqchip/irq-ompic.c
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt b/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> > > new file mode 100644
> > > index 000000000000..346e6042d62f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> > > @@ -0,0 +1,19 @@
> > > +Open Multi-Processor Interrupt Controller
> > > +
> > > +Required properties:
> > > +
> > > +- compatible : This should be "openrisc,ompic"
> > > +- reg : Specifies base physical address and size of the register space. The
> > > +  size is based on the number of cores the controller has been configured
> > > +  to handle, this should be set to 8 bytes per cpu core.
> > > +- interrupt-controller : Identifies the node as an interrupt controller
> > > +- interrupts : Specifies the interrupt line to which the ompic is wired.
> > > +
> > > +Example:
> > > +
> > > +ompic: ompic {
> > > +	compatible = "openrisc,ompic";
> > > +	reg = <0x98000000 16>;
> > > +	interrupt-controller;
> > > +	interrupts = <1>;
> > > +};
> > > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > > index b49acda5e8f4..34eb4e90f56c 100644
> > > --- a/arch/openrisc/Kconfig
> > > +++ b/arch/openrisc/Kconfig
> > > @@ -30,6 +30,7 @@ config OPENRISC
> > >  	select NO_BOOTMEM
> > >  	select ARCH_USE_QUEUED_SPINLOCKS
> > >  	select ARCH_USE_QUEUED_RWLOCKS
> > > +	select OMPIC if SMP
> > >  
> > >  config CPU_BIG_ENDIAN
> > >  	def_bool y
> > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > > index f1fd5f44d1d4..0e4c96c90b86 100644
> > > --- a/drivers/irqchip/Kconfig
> > > +++ b/drivers/irqchip/Kconfig
> > > @@ -145,6 +145,9 @@ config CLPS711X_IRQCHIP
> > >  	select SPARSE_IRQ
> > >  	default y
> > >  
> > > +config OMPIC
> > > +	bool
> > > +
> > >  config OR1K_PIC
> > >  	bool
> > >  	select IRQ_DOMAIN
> > > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > > index e88d856cc09c..123047d7a20d 100644
> > > --- a/drivers/irqchip/Makefile
> > > +++ b/drivers/irqchip/Makefile
> > > @@ -17,6 +17,7 @@ obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
> > >  obj-$(CONFIG_METAG)			+= irq-metag-ext.o
> > >  obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
> > >  obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
> > > +obj-$(CONFIG_OMPIC)			+= irq-ompic.o
> > >  obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
> > >  obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
> > >  obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
> > > diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
> > > new file mode 100644
> > > index 000000000000..cd2616b6639b
> > > --- /dev/null
> > > +++ b/drivers/irqchip/irq-ompic.c
> > > @@ -0,0 +1,205 @@
> > > +/*
> > > + * Open Multi-Processor Interrupt Controller driver
> > > + *
> > > + * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > > + * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
> > > + *
> > > + * This file is licensed under the terms of the GNU General Public License
> > > + * version 2.  This program is licensed "as is" without any warranty of any
> > > + * kind, whether express or implied.
> > > + *
> > > + * The ompic device handles IPI communication because cores in mulicore
> > > + * OpenRISC systems.
> > 
> > Should the above read "between cores"?
> 
> Yes, it should be, I am bad with these kind of typos.

And "multi-core"
