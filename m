From: Stafford Horne <shorne@gmail.com>
Date: Fri, 1 Sep 2017 22:59:24 +0900
Subject: [OpenRISC] [PATCH 05/13] irqchip: add initial support for ompic
In-Reply-To: <20170831105940.GE15031@leverpostej>
References: <cover.1504129273.git.shorne@gmail.com>
 <538699c64b5601e8800b77da29f7951bf23f57ce.1504129273.git.shorne@gmail.com>
 <20170831105940.GE15031@leverpostej>
Message-ID: <20170901135924.GK2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 31, 2017 at 11:59:40AM +0100, Mark Rutland wrote:
> On Thu, Aug 31, 2017 at 06:58:36AM +0900, Stafford Horne wrote:
> > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > 
> > IPI driver for OpenRISC Multicore programmable interrupt controller as
> > described in the Multicore support section of the OpenRISC 1.2
> > proposed architecture specification:
> > 
> >   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
> > 
> > Each OpenRISC core contains a full interrupt controller which is used in
> > the SMP architecture for interrupt balancing.  This IPI device is the
> > only external device required for enabling SMP on OpenRISC.
> 
> I'm a little confused. Is this device the whole "ompic", a sub-device
> thereof, or an independent IP block connected to it?

This device *is* the ompic, it currently just handles IPI communication,
but was originally thought it should do more, i.e. distribute device
interrupts, hence the name.  For now, the ompic device only handles IPI.

Perhaps we can change the name?  If you think that's needed I can discuss
with Stefan (the creator).

This is documented in the pdf, but here is an ascii diagram to help.

Notes

 o The ompic generates a level interrupt to the CPU PIC when a message is
   ready.  Messages are delivered via the memory bus.
 o The ompic does not have any interrupt input lines.
 o The ompic must be wired to the same irq line on each core.
 o Devices must be wired to the same irq line on each core.
 o This seems strange, but in the end very little extra hardware is needed
   to enable smp.

  +---------+                         +---------+
  | CPU     |                         | CPU     |
  |  Core 0 |<==\ (memory access) /==>|  Core 1 |
  |  [ PIC ]|   |                 |   |  [ PIC ]|
  +----^-^--+   |                 |   +----^-^--+
       | |      v                 v        | |
  <====|=|=================================|=|==> (memory bus)
       | |      ^                  ^       | |
 (ipi  | +------|---------+--------|-------|-+ (device irq)
  irq  |        |         |        |       |
 core0)| +------|---------|--------|-------+ (ipi irq core1)
       | |      |         |        |
  +----o-o-+    |    +--------+    |
  | ompic  |<===/    | Device |<===/
  |  IPI   |         +--------+
  +--------+

> > Pending ops are stored in a memory bit mask which can allow multiple
> > pending operations to be set and serviced at a time. This is mostly
> > borrowed from the alpha IPI implementation.
> > 
> > Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > [shorne at gmail.com: converted ops to bitmask, wrote commit message]
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  .../bindings/interrupt-controller/ompic.txt        |  22 ++++
> >  arch/openrisc/Kconfig                              |   1 +
> >  drivers/irqchip/Kconfig                            |   4 +
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-ompic.c                        | 117 +++++++++++++++++++++
> >  5 files changed, 145 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ompic.txt
> >  create mode 100644 drivers/irqchip/irq-ompic.c
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ompic.txt b/Documentation/devicetree/bindings/interrupt-controller/ompic.txt
> > new file mode 100644
> > index 000000000000..4176ecc3366d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/ompic.txt
> > @@ -0,0 +1,22 @@
> > +OpenRISC Multicore Programmable Interrupt Controller
> > +
> > +Required properties:
> > +
> > +- compatible : This should be "ompic"
> 
> This needs a vendor prefix.
> 
> Presumably, this should be "opencores,ompic"? (pending whether this is
> actually the whole ompic, as above).

As discussed above this is the ompic.

In terms of vendor, this and further openrisc development is no longer
associated with opencores, that company just hosts the old opencores.org
website but is not assisting in openrisc development any longer.  Perhaps
"openrisc,ompic" or "openrisc,ipi".

This also I would like to get final say from Stefan, but any suggestions
are welcome.

> > +- reg : Specifies base physical address and size of the register space. The
> > +  size can be arbitrary based on the number of cores the controller has
> > +  been configured to handle, typically 8 bytes per core.
> 
> How are those regions correlated with CPUs?
> 
> e.g. is there a fixed relationship with a physical CPU id, or some
> mechanism by which the relationship can be probed dynamically?

There should only be one region.

core id 0 is associated with registers at address 0x0 and 0x4
core id 1 is associated with registers at address 0x8 and 0xc
etc.

This is can't be probed.  Should this be documented here?  That seems more
of something that is internal to the driver. I think the only thing some
one would want to set in TD is the register space size which should be be 8
x number-of-cores.

> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- #interrupt-cells : Specifies the number of cells needed to encode an
> > +  interrupt source. The value shall be 1.
> 
> No flags? Does this not need edge/level configuration or active high/low
> configuration?

No flags, this maybe I am confused on, the ompic does not receive any
interrupts.  The input to the ompic are register writes which raise/clear
interrupts on the target CPUs.  So maybe it should not define an
'interrupt-controller' or '#interrupt-cells' tag.  But then should it be an
irqchip?  Since its facilitates the IPI I think this is the right place.

> > +- interrupts : Specifies the interrupt line to which the ompic is wired.
> 
> What is this interrupt used for?
> 
> Is this some percpu interrupt used to proxy the IPI? It feels very odd
> to assume such a thing from the parent irqchip. Surely this is
> intimately coupled with that?

This represents which IRQ line on each cpu the IPI is connected to (it must
be connected to the same IRQ line on each CPU.

i.e.
 interrupt-parent = <&pic>;

> > +
> > +Example:
> > +
> > +ompic: ompic {
> > +	compatible = "ompic";
> > +	reg = <0x98000000 16>;
> > +	#interrupt-cells = <1>;
> > +	interrupt-controller;
> > +	interrupts = <1>;
> > +};
> 
> [...]
> 
> > +static struct {
> > +	unsigned long ops;
> > +} ipi_data[NR_CPUS];
> > +
> > +static void __iomem *ompic_base;
> 
> Is there guaranteed to only be one of these system-wide?

Yes, that should be guaranteed, but I can look for moving this into a per
device structure.

> [...]
> 
> > +void ompic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> > +{
> > +	unsigned int dst_cpu;
> > +	unsigned int src_cpu = smp_processor_id();
> > +
> > +	for_each_cpu(dst_cpu, mask) {
> > +		set_bit(irq, &ipi_data[dst_cpu].ops);
> > +
> > +		ompic_writereg(ompic_base, OMPIC_IPI_CTRL(src_cpu),
> > +			       OMPIC_IPI_CTRL_IRQ_GEN |
> > +			       OMPIC_IPI_CTRL_DST(dst_cpu) |
> > +			       OMPIC_IPI_DATA(1));
> > +	}
> 
> Here you assume that the mapping is big enough to cover these registers,
> but the ompic_of_init() function didn't sanity-check the size, so this
> is not guaranteed.

OK, I will add some sanity checking.

> [...]
> 
> > +int __init ompic_of_init(struct device_node *node, struct device_node *parent)
> > +{
> > +	int irq;
> > +
> > +	if (WARN_ON(!node))
> > +		return -ENODEV;
> 
> Given this function is only invoked if the kernel found a node with a
> matching compatible string, how can this possibly happen?

Right, I think now.  Will fix.

> > +	memset(ipi_data, 0, sizeof(ipi_data));
> 
> As ipi_data was static, it is already zeroed.

Right, will fix.

> > +
> > +	ompic_base = of_iomap(node, 0);
> 
> What if this failed?

Right will fix.

> > +
> > +	irq = irq_of_parse_and_map(node, 0);
> 
> What if this is missing?

OK, I will do some error checking.

> 
> > +	setup_irq(irq, &ompi_ipi_irqaction);
> 
> As covered earlier, I;m confused by this. I'd expect that your root
> irqchip would handle the IPIs, and hence need to probe nothing from the
> DT for those.
> 
> Here we're assuming the IRQ is wired up to some per-cpu interrupt that
> we can treat as an IPI, and that the parent irqchip handles that
> appropriately, which seems very odd.

I hope the comments above help to clarify this.  By appropriately you mean
level/edge active high/low?  The ompic and openrisc internal pic have been
designed to be compatible.

Thanks for the review.  Between this and the comments from Marc I have a
bit of work to do.  Please let me know if you have any further questions.

-Stafford

