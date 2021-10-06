From: Stafford Horne <shorne@gmail.com>
Date: Thu, 7 Oct 2021 06:25:09 +0900
Subject: [OpenRISC] [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
In-Reply-To: <CAL_JsqLv+Ym=hxxz2vm0H3pbx1FRkBpHs3V=8DKjG43n+gS+RA@mail.gmail.com>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-7-robh@kernel.org> <YV4KkAC2p9D4yCnH@antec>
 <CAL_JsqLv+Ym=hxxz2vm0H3pbx1FRkBpHs3V=8DKjG43n+gS+RA@mail.gmail.com>
Message-ID: <YV4UNQg3QROuTfQ/@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 06, 2021 at 04:08:38PM -0500, Rob Herring wrote:
> On Wed, Oct 6, 2021 at 3:44 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Wed, Oct 06, 2021 at 11:43:26AM -0500, Rob Herring wrote:
> > > Replace open coded parsing of CPU nodes' 'reg' property with
> > > of_get_cpu_hwid().
> > >
> > > Cc: Jonas Bonn <jonas@southpole.se>
> > > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > > Cc: Stafford Horne <shorne@gmail.com>
> > > Cc: openrisc at lists.librecores.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  arch/openrisc/kernel/smp.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> > > index 415e209732a3..7d5a4f303a5a 100644
> > > --- a/arch/openrisc/kernel/smp.c
> > > +++ b/arch/openrisc/kernel/smp.c
> > > @@ -65,11 +65,7 @@ void __init smp_init_cpus(void)
> > >       u32 cpu_id;
> > >
> > >       for_each_of_cpu_node(cpu) {
> > > -             if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> > > -                     pr_warn("%s missing reg property", cpu->full_name);
> > > -                     continue;
> > > -             }
> > > -
> > > +             cpu_id = of_get_cpu_hwid(cpu);
> 
> Oops, that should be: of_get_cpu_hwid(cpu, 0);

OK. I checked all other patches in the series, it seems OpenRISC was the only
one missing that.  Sorry I missed it initially.

> I thought I double checked all those...
> 
> > You have defined of_get_cpu_hwid to return u64, will this create compiler
> > warnings when since we are storing a u64 into a u32?
> 
> I'm counting on the caller to know the max size for their platform.

OK.

> >
> > It seems only if we make with W=3.
> >
> > I thought we usually warned on this.  Oh well, for the openrisc bits.
> 
> That's only on ptr truncation I think.

Right, that makes sense.

-Stafford
