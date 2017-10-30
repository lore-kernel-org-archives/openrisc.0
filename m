From: Stafford Horne <shorne@gmail.com>
Date: Mon, 30 Oct 2017 13:18:06 +0900
Subject: [OpenRISC] [PATCH v4 05/13] irqchip: add initial support for
	ompic
In-Reply-To: <86mv4974ht.fsf@arm.com>
References: <20171029231123.27281-1-shorne@gmail.com>
 <20171029231123.27281-6-shorne@gmail.com> <86mv4974ht.fsf@arm.com>
Message-ID: <20171030041806.GA29237@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Oct 30, 2017 at 02:29:18AM +0000, Marc Zyngier wrote:
> On Mon, Oct 30 2017 at  8:11:15 am GMT, Stafford Horne <shorne@gmail.com> wrote:
> > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >
> > IPI driver for the Open Multi-Processor Interrupt Controller (ompic) as
> > described in the Multi-core support section of the OpenRISC 1.2
> > architecture specification:
> >
> >   https://github.com/openrisc/doc/raw/master/openrisc-arch-1.2-rev0.pdf
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
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > [shorne at gmail.com: converted ops to bitmask, wrote commit message]
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks

> Side question: what is your merge strategy for this? I can take it
> through the irqchip tree as it is standalone, but I'm open to other
> suggestions.

For me its easier if I just take it through the openrisc tree, as
there are dependencies between this series and the irqchip driver.
If you are ok with that I can make a note to Linus indicating so in
the pull request.

My plan is to send this series during the 4.15 merge window.

-Stafford
