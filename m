From: Stafford Horne <shorne@gmail.com>
Date: Mon, 23 Oct 2017 21:57:27 +0900
Subject: [OpenRISC] [PATCH v3 05/13] irqchip: add initial support for
	ompic
In-Reply-To: <86d15egupi.fsf@arm.com>
References: <20171022031600.29612-1-shorne@gmail.com>
 <20171022031600.29612-6-shorne@gmail.com> <86d15egupi.fsf@arm.com>
Message-ID: <20171023125727.GG2694@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Oct 23, 2017 at 09:00:09AM +0100, Marc Zyngier wrote:
> On Sun, Oct 22 2017 at 12:15:52 pm BST, Stafford Horne <shorne@gmail.com> wrote:
> > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >

[...]

> > +
> > +	ret = setup_irq(irq, &ompi_ipi_irqaction);
> > +	if (ret)
> > +		goto out_irq_disp;
> 
> Is there a particular reason why this cannot be turned request_irq()
> call? setup_irq is something we try to avoid these days...

No reason, its just an old patch and I didn't know we should be avoiding
setup_irq().

I have just removed ompic_ipi_irqaction and replaced setup_irq() with this:

	ret = request_irq(irq, ompic_ipi_handler, IRQF_PERCPU,
				"ompic_ipi", NULL);
	if (ret)
		goto out_irq_disp;

I did some testing and it looks to be working fine.

> > +
> > +	set_smp_cross_call(ompic_raise_softirq);
> > +
> > +	return 0;
> > +
> > +out_irq_disp:
> > +	irq_dispose_mapping(irq);
> > +out_unmap:
> > +	iounmap(ompic_base);
> > +	ompic_base = NULL;
> > +	return ret;
> > +}
> > +IRQCHIP_DECLARE(ompic, "openrisc,ompic", ompic_of_init);
> 
> Otherwise looks good to me.

Thank You,

I will send another V once I get a bit more feedback on the other parts of the
series.

-Stafford
