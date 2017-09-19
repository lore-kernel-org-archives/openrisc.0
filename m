From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Sep 2017 21:10:39 +0900
Subject: [OpenRISC] [PATCH v2 06/14] irqchip: add initial support for
	ompic
In-Reply-To: <20170918204339.gvfenavdi4frdnqe@rob-hp-laptop>
References: <20170910064926.5874-1-shorne@gmail.com>
 <20170910064926.5874-7-shorne@gmail.com>
 <20170918204339.gvfenavdi4frdnqe@rob-hp-laptop>
Message-ID: <20170919121039.GW2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Sep 18, 2017 at 03:43:39PM -0500, Rob Herring wrote:
> On Sun, Sep 10, 2017 at 03:49:18PM +0900, Stafford Horne wrote:
> > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > 
> > IPI driver for the Open Multi-Processor Interrupt Controller (ompic) as
> > described in the Multicore support section of the OpenRISC 1.2
> > proposed architecture specification:
> > 
> >   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
> > 
> > Each OpenRISC core contains a full interrupt controller which is used in
> > the SMP architecture for interrupt balancing.  This IPI device, the
> > ompic, is the only external device required for enabling SMP on
> > OpenRISC.
> > 
> > Pending ops are stored in a memory bit mask which can allow multiple
> > pending operations to be set and serviced at a time. This is mostly
> > borrowed from the alpha IPI implementation.
> > 
> > Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > [shorne at gmail.com: converted ops to bitmask, wrote commit message]
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > 
> > Changes since v1
> >  - Added openrisc, prefix
> >  - Clarified 8 bytes per cpu
> >  - Removed #interrupt-cells as this will not be an irq parent
> 
> You should still have #interrupt-cells as that is required with 
> "interrupt-controller". It could be 0 though.

Thanks, I didn't notice that from reading the code.  I will update it.

> >  - Changed ops to be percpu
> >  - Added DTS and intialization failure validations
> > 
> >  .../interrupt-controller/openrisc,ompic.txt        |  19 ++
> >  arch/openrisc/Kconfig                              |   1 +
> >  drivers/irqchip/Kconfig                            |   3 +
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-ompic.c                        | 205 +++++++++++++++++++++
> >  5 files changed, 229 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> >  create mode 100644 drivers/irqchip/irq-ompic.c
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt b/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> > new file mode 100644
> > index 000000000000..346e6042d62f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/openrisc,ompic.txt
> > @@ -0,0 +1,19 @@
> > +Open Multi-Processor Interrupt Controller
> > +
> > +Required properties:
> > +
> > +- compatible : This should be "openrisc,ompic"
> > +- reg : Specifies base physical address and size of the register space. The
> > +  size is based on the number of cores the controller has been configured
> > +  to handle, this should be set to 8 bytes per cpu core.
> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- interrupts : Specifies the interrupt line to which the ompic is wired.
> > +
> > +Example:
> > +
> > +ompic: ompic {
> 
> interrupt-controller at 98000000 {

OK, I will change to the format. But I notice many other docs like this:

  ompic: interrupt-controller at 98000000 {

> > +	compatible = "openrisc,ompic";
> > +	reg = <0x98000000 16>;
> > +	interrupt-controller;
> > +	interrupts = <1>;
> > +};

Thanks for the review.

-Stafford
