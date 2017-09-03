From: Stafford Horne <shorne@gmail.com>
Date: Mon, 4 Sep 2017 07:12:36 +0900
Subject: [OpenRISC] [PATCH 05/13] irqchip: add initial support for ompic
In-Reply-To: <97879c84-3ce8-b2bf-d438-679a69b60774@arm.com>
References: <cover.1504129273.git.shorne@gmail.com>
 <538699c64b5601e8800b77da29f7951bf23f57ce.1504129273.git.shorne@gmail.com>
 <1b062d84-7335-8553-39c7-2e60973b4396@arm.com>
 <20170901012449.GG2609@lianli.shorne-pla.net>
 <97879c84-3ce8-b2bf-d438-679a69b60774@arm.com>
Message-ID: <20170903221236.GM2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 01, 2017 at 06:25:01PM +0100, Marc Zyngier wrote:
> On 01/09/17 02:24, Stafford Horne wrote:
> > On Thu, Aug 31, 2017 at 10:28:01AM +0100, Marc Zyngier wrote:
> >> On 30/08/17 22:58, Stafford Horne wrote:
> >>> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >>>
> >>> IPI driver for OpenRISC Multicore programmable interrupt controller as
> >>> described in the Multicore support section of the OpenRISC 1.2
> >>> proposed architecture specification:
> >>>
> >>>   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
> >>>
> >>> Each OpenRISC core contains a full interrupt controller which is used in
> >>> the SMP architecture for interrupt balancing.  This IPI device is the
> >>> only external device required for enabling SMP on OpenRISC.
> >>>
> >>> Pending ops are stored in a memory bit mask which can allow multiple
> >>> pending operations to be set and serviced at a time. This is mostly
> >>> borrowed from the alpha IPI implementation.
> >>>
> >>> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >>> [shorne at gmail.com: converted ops to bitmask, wrote commit message]
> >>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> >>> ---
> >>>  .../bindings/interrupt-controller/ompic.txt        |  22 ++++
> >>>  arch/openrisc/Kconfig                              |   1 +
> >>>  drivers/irqchip/Kconfig                            |   4 +
> >>>  drivers/irqchip/Makefile                           |   1 +
> >>>  drivers/irqchip/irq-ompic.c                        | 117 +++++++++++++++++++++
> >>>  5 files changed, 145 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ompic.txt
> >>>  create mode 100644 drivers/irqchip/irq-ompic.c
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ompic.txt b/Documentation/devicetree/bindings/interrupt-controller/ompic.txt
> >>> new file mode 100644
> >>> index 000000000000..4176ecc3366d
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ompic.txt
> >>> @@ -0,0 +1,22 @@
> >>> +OpenRISC Multicore Programmable Interrupt Controller
> >>> +
> >>> +Required properties:
> >>> +
> >>> +- compatible : This should be "ompic"
> >>> +- reg : Specifies base physical address and size of the register space. The
> >>> +  size can be arbitrary based on the number of cores the controller has
> >>> +  been configured to handle, typically 8 bytes per core.
> >>> +- interrupt-controller : Identifies the node as an interrupt controller
> >>> +- #interrupt-cells : Specifies the number of cells needed to encode an
> >>> +  interrupt source. The value shall be 1.
> >>> +- interrupts : Specifies the interrupt line to which the ompic is wired.
> >>> +
> >>> +Example:
> >>> +
> >>> +ompic: ompic {
> >>> +	compatible = "ompic";
> >>> +	reg = <0x98000000 16>;
> >>> +	#interrupt-cells = <1>;
> >>> +	interrupt-controller;
> >>> +	interrupts = <1>;
> >>> +};
> >>> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> >>> index 214c837ce597..dd7e55e7e42d 100644
> >>> --- a/arch/openrisc/Kconfig
> >>> +++ b/arch/openrisc/Kconfig
> >>> @@ -30,6 +30,7 @@ config OPENRISC
> >>>  	select NO_BOOTMEM
> >>>  	select ARCH_USE_QUEUED_SPINLOCKS
> >>>  	select ARCH_USE_QUEUED_RWLOCKS
> >>> +	select OMPIC if SMP
> >>>  
> >>>  config CPU_BIG_ENDIAN
> >>>  	def_bool y
> >>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> >>> index f1fd5f44d1d4..3fa60e6667a7 100644
> >>> --- a/drivers/irqchip/Kconfig
> >>> +++ b/drivers/irqchip/Kconfig
> >>> @@ -145,6 +145,10 @@ config CLPS711X_IRQCHIP
> >>>  	select SPARSE_IRQ
> >>>  	default y
> >>>  
> >>> +config OMPIC
> >>> +	bool
> >>> +	select IRQ_DOMAIN
> >>
> >> Why do you need to select IRQ_DOMAIN? This driver doesn't seem to use any...
> > 
> > Right, I will look to remove that.
> > 
> >>> +
> >>>  config OR1K_PIC
> >>>  	bool
> >>>  	select IRQ_DOMAIN
> >>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >>> index e88d856cc09c..123047d7a20d 100644
> >>> --- a/drivers/irqchip/Makefile
> >>> +++ b/drivers/irqchip/Makefile
> >>> @@ -17,6 +17,7 @@ obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
> >>>  obj-$(CONFIG_METAG)			+= irq-metag-ext.o
> >>>  obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
> >>>  obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
> >>> +obj-$(CONFIG_OMPIC)			+= irq-ompic.o
> >>>  obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
> >>>  obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
> >>>  obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
> >>> diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
> >>> new file mode 100644
> >>> index 000000000000..438819f8a5a7
> >>> --- /dev/null
> >>> +++ b/drivers/irqchip/irq-ompic.c
> >>> @@ -0,0 +1,117 @@
> >>> +/*
> >>> + * Open Multi-Processor Interrupt Controller driver
> >>> + *
> >>> + * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >>> + *
> >>> + * This file is licensed under the terms of the GNU General Public License
> >>> + * version 2.  This program is licensed "as is" without any warranty of any
> >>> + * kind, whether express or implied.
> >>> + */
> >>> +
> >>> +#include <linux/io.h>
> >>> +#include <linux/interrupt.h>
> >>> +#include <linux/smp.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/of_irq.h>
> >>> +#include <linux/of_address.h>
> >>> +#include <linux/irqchip/chained_irq.h>
> >>
> >> Don't think you need this.
> >>
> >>> +#include <linux/delay.h>
> >>
> >> Nor this.
> > 
> > OK on both.
> > 
> >>> +
> >>> +#include <linux/irqchip.h>
> >>> +
> >>> +#define OMPIC_IPI_BASE			0x0
> >>> +#define OMPIC_IPI_CTRL(cpu)		(OMPIC_IPI_BASE + 0x0 + (cpu)*8)
> >>> +#define OMPIC_IPI_STAT(cpu)		(OMPIC_IPI_BASE + 0x4 + (cpu)*8)
> >>
> >> In the DT binding you say that "size can be arbitrary based on the
> >> number of cores the controller has been configured to handle, typically
> >> 8 bytes per core". Here, this is 8 bytes, always, which is not exactly
> >> the same. What is the architectural value, if any? If there is none,
> >> then the per-core size should either come from DT or some other mean
> >> (register?).
> > 
> > I mean the address space is 8 bytes x number-of-cores.  Thats what I meant
> > by arbitrary, I guess its better for me to be explicit. There is no
> > register that we can check to confirm the configuration of ompic.  But I
> > guess we can check the CPU NUMCORES register and compare it to the DT
> > address space to do a sanity check.
> 
> Thanks for the explanation. So the code is OK, but the DT should be more
> rigorous in saying that there is 8 bytes per CPU. And yes to the check
> if that can be done at this stage.

I will update that.

> > 
> >>> +
> >>> +#define OMPIC_IPI_CTRL_IRQ_ACK		(1 << 31)
> >>> +#define OMPIC_IPI_CTRL_IRQ_GEN		(1 << 30)
> >>> +#define OMPIC_IPI_CTRL_DST(cpu)		(((cpu) & 0x3fff) << 16)
> >>> +
> >>> +#define OMPIC_IPI_STAT_IRQ_PENDING	(1 << 30)
> >>> +
> >>> +#define OMPIC_IPI_DATA(x)		((x) & 0xffff)
> >>> +
> >>> +static struct {
> >>> +	unsigned long ops;
> >>> +} ipi_data[NR_CPUS];
> >>
> >> In general, a per cpu data structure is better expressed as a percpu
> >> data structure (yes, I'm in a funny mood this morning). Otherwise,
> >> you're going to thrash more than just the receiver and the sender, but
> >> also all the other CPUs that have their data in the same cache line.
> > 
> > Right, that makes sense, I am not sure why that was done this way. I think
> > I borrowed from alpha which has the extra __cacheline_aligned annotations.
> > I forgot to come back and fix this.  Ill do as you suggest, thank you.
> > 
> > Excerpt from alpha:
> > 
> > static struct {
> >         unsigned long bits ____cacheline_aligned;
> > } ipi_data[NR_CPUS] __cacheline_aligned;
> 
> Yup, __cacheline_aligned is key here, as it will have the same effect as
> the percpu stuff from that point of view.

Right, I think in this case I rather use the percpu API rather then
depending on how well our compiler implements the __cacheline_aligned
annotations.

> >>> +
> >>> +static void __iomem *ompic_base;
> >>> +
> >>> +static inline u32 ompic_readreg(void __iomem *base, loff_t offset)
> >>> +{
> >>> +	return ioread32be(base + offset);
> >>> +}
> >>> +
> >>> +static void ompic_writereg(void __iomem *base, loff_t offset, u32 data)
> >>> +{
> >>> +	iowrite32be(data, base + offset);
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_SMP
> >>
> >> This code is only selected when CONFIG_SMP=y.
> > 
> > Yes, that is right, as below:
> > 
> >   set_smp_cross_call(ompic_raise_softirq);
> > 
> > The set_smp_cross_call() function from smp.c is only defined for smp.  Do
> > you think thats wrong or needed extra comments?  This is similar to other
> > chips in irqchip/ for archs which use set_smp_cross_call().
> 
> Other irqchips can often be compiled for both SMP and !SMP, hence the
> need of a #ifdef. In your case, this driver is only compiled when SMP is
> selected, so you're pretty much guaranteed that this symbol is available.

Right, I'll remove it.

> > 
> >>> +void ompic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >>> +{
> >>
> >> What is "irq" here? How is it guaranteed to fit in an unsigned long?
> > 
> > Here irq is the `enum ipi_msg_type` which is guaranteed to fit in unsigned
> > long.  Porbably its better to rename as msg or ipi_msg?
> 
> You should certainly make sure your "enum ipi_msg_type" is capped at the
> number of bits of unsigned long. And yes to ipi_msg, which is a better
> name than irq. Also, you could change the types of ompic_raise_softirq
> and set_smp_cross_call, so that you use the enum instead of an int here.

OK.

I had a go at changing the type to the enum, but I realize that would
require moving the enum definition into our asm/smp.h which I rather not do
at the moment for sake of keeping it private inside of smp.c.  This follows
what other architectures do as well.

> > 
> >>> +	unsigned int dst_cpu;
> >>> +	unsigned int src_cpu = smp_processor_id();
> >>> +
> >>> +	for_each_cpu(dst_cpu, mask) {
> >>> +		set_bit(irq, &ipi_data[dst_cpu].ops);
> >>> +
> >>> +		ompic_writereg(ompic_base, OMPIC_IPI_CTRL(src_cpu),
> >>> +			       OMPIC_IPI_CTRL_IRQ_GEN |
> >>> +			       OMPIC_IPI_CTRL_DST(dst_cpu) |
> >>> +			       OMPIC_IPI_DATA(1));
> >>
> >> What guarantees that the action of set_bit can be observed by the target
> >> CPU? set-bit gives you atomicity, but no barrier.
> > 
> > The bit will not be read by target CPUs until after the ompic_writereg()
> > which will trigger the target CPU interrupt to be raised.  OpenRISC stores
> > are ordered.
> 
> Are they really ordered irrespective of the memory type (one is
> cacheable RAM, the other is a device...)?
> 
> And assuming they are (which I find a bit odd), that doesn't necessarily
> guarantee that the interrupt will only be delivered once the effect of
> set_bit can be seen on the target CPU...

OpenRISC might be a bit odd here, but I think this is correct.  On OpenRISC
the atomic instructions also imply a pipeline flush for stores and loads
(l.swa/l.lwa).  This is highlighted in the architecture spec section 7.3 [0].

[0] https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf

-Stafford

> > This will work on OpenRISC, but should I be thinking of other architectures
> > as well for all drivers?  Or do you think this will be an issue on
> > OpenRISC?
> 
> I definitely think this could be an issue with OpenRISC, but only
> someone familiar with the OpenRISC architecture can say whether I'm
> right or wrong. I'm just guessing at the moment.
> 
> [...]
> 
> > Thank you for the feedback, I will clean this up and resubmit with the
> > comments on the other thread.
> > 
> > In terms of commit path, do you think its ok for this to go in via the
> > OpenRISC arch path?
> 
> Sure, that's fine by me.
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
