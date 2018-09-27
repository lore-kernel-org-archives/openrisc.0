From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Thu, 27 Sep 2018 07:50:20 +0300
Subject: [OpenRISC] [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
In-Reply-To: <CAKgT0UcC-GTtyPK9ynvj6r3YFqy8kE40iMJxzPowbNoXGf9iWg@mail.gmail.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com>
 <20180926183152.GA4597@rapoport-lnx>
 <CAKgT0UcC-GTtyPK9ynvj6r3YFqy8kE40iMJxzPowbNoXGf9iWg@mail.gmail.com>
Message-ID: <20180927045019.GA16740@rapoport-lnx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Sep 26, 2018 at 05:34:32PM -0700, Alexander Duyck wrote:
> On Wed, Sep 26, 2018 at 11:32 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 09:58:41AM -0700, Alexander Duyck wrote:
> > > On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > > >
> > > > All architecures use memblock for early memory management. There is no need
> > > > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > > >
> > > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > >
> > > <snip>
> > >
> > > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > > index 5169205..4ae91fc 100644
> > > > --- a/include/linux/memblock.h
> > > > +++ b/include/linux/memblock.h
> > > > @@ -2,7 +2,6 @@
> > > >  #define _LINUX_MEMBLOCK_H
> > > >  #ifdef __KERNEL__
> > > >
> > > > -#ifdef CONFIG_HAVE_MEMBLOCK
> > > >  /*
> > > >   * Logical memory blocks.
> > > >   *
> > > > @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
> > > >  {
> > > >         return 0;
> > > >  }
> > > > -#endif /* CONFIG_HAVE_MEMBLOCK */
> > > >
> > > >  #endif /* __KERNEL__ */
> > >
> > > There was an #else above this section and I believe it and the code
> > > after it needs to be stripped as well.
> >
> > Right, I've already sent the fix [1] and it's in mmots.
> >
> > [1] https://lkml.org/lkml/2018/9/19/416
> >
> 
> Are you sure? The patch you reference appears to be for
> drivers/of/fdt.c, and the bit I pointed out here is in
> include/linux/memblock.h.

Ah, sorry. You are right, will fix. Thanks for spotting it!
 
> - Alex
> 

-- 
Sincerely yours,
Mike.

