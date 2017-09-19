From: Stafford Horne <shorne@gmail.com>
Date: Tue, 19 Sep 2017 21:14:01 +0900
Subject: [OpenRISC] [PATCH v2 06/14] irqchip: add initial support for
	ompic
In-Reply-To: <20170918202958.sayo3t7xnok3do72@rob-hp-laptop>
References: <20170910064926.5874-1-shorne@gmail.com>
 <20170910064926.5874-7-shorne@gmail.com> <86h8w6see4.fsf@arm.com>
 <20170914065402.GU2609@lianli.shorne-pla.net>
 <20170918202958.sayo3t7xnok3do72@rob-hp-laptop>
Message-ID: <20170919121401.GX2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Sep 18, 2017 at 03:29:58PM -0500, Rob Herring wrote:
> On Thu, Sep 14, 2017 at 03:54:02PM +0900, Stafford Horne wrote:
> > On Wed, Sep 13, 2017 at 06:21:39PM +0100, Marc Zyngier wrote:
> > > On Sun, Sep 10 2017 at  3:49:18 pm BST, Stafford Horne <shorne@gmail.com> wrote:
> > > > From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > > >
[..]
> > > > diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
> > > > new file mode 100644
> > > > index 000000000000..cd2616b6639b
> > > > --- /dev/null
> > > > +++ b/drivers/irqchip/irq-ompic.c
> > > > @@ -0,0 +1,205 @@
> > > > +/*
> > > > + * Open Multi-Processor Interrupt Controller driver
> > > > + *
> > > > + * Copyright (C) 2014 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > > > + * Copyright (C) 2017 Stafford Horne <shorne@gmail.com>
> > > > + *
> > > > + * This file is licensed under the terms of the GNU General Public License
> > > > + * version 2.  This program is licensed "as is" without any warranty of any
> > > > + * kind, whether express or implied.
> > > > + *
> > > > + * The ompic device handles IPI communication because cores in mulicore
> > > > + * OpenRISC systems.
> > > 
> > > Should the above read "between cores"?
> > 
> > Yes, it should be, I am bad with these kind of typos.
> 
> And "multi-core"

Thanks, and I have many s/multicore/multi-core/ issues throughout the patch
series as well.

-Stafford
