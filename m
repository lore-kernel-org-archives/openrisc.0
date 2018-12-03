From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 3 Dec 2018 18:49:21 +0200
Subject: [OpenRISC] [PATCH v2 5/6] arch: simplify several early memory
	allocations
In-Reply-To: <20181203162908.GB4244@ravnborg.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
 <20181203162908.GB4244@ravnborg.org>
Message-ID: <20181203164920.GB26700@rapoport-lnx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 03, 2018 at 05:29:08PM +0100, Sam Ravnborg wrote:
> Hi Mike.
> 
> > index c37955d..2a17665 100644
> > --- a/arch/sparc/kernel/prom_64.c
> > +++ b/arch/sparc/kernel/prom_64.c
> > @@ -34,16 +34,13 @@
> >  
> >  void * __init prom_early_alloc(unsigned long size)
> >  {
> > -	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
> > -	void *ret;
> > +	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
> >  
> > -	if (!paddr) {
> > +	if (!ret) {
> >  		prom_printf("prom_early_alloc(%lu) failed\n", size);
> >  		prom_halt();
> >  	}
> >  
> > -	ret = __va(paddr);
> > -	memset(ret, 0, size);
> >  	prom_early_allocated += size;
> >  
> >  	return ret;
> 
> memblock_alloc() calls memblock_alloc_try_nid().
> And if allocation fails then memblock_alloc_try_nid() calls panic().
> So will we ever hit the prom_halt() code?

memblock_phys_alloc_try_nid() also calls panic if an allocation fails. So
in either case we never reach prom_halt() code.

Actually, sparc is rather an exception from the general practice to rely on
panic() inside the early allocator rather than to check the return value.
 
> Do we have a panic() implementation that actually returns?
> 
> 
> > diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> > index 3c8aac2..52884f4 100644
> > --- a/arch/sparc/mm/init_64.c
> > +++ b/arch/sparc/mm/init_64.c
> > @@ -1089,16 +1089,13 @@ static void __init allocate_node_data(int nid)
> >  	struct pglist_data *p;
> >  	unsigned long start_pfn, end_pfn;
> >  #ifdef CONFIG_NEED_MULTIPLE_NODES
> > -	unsigned long paddr;
> >  
> > -	paddr = memblock_phys_alloc_try_nid(sizeof(struct pglist_data),
> > -					    SMP_CACHE_BYTES, nid);
> > -	if (!paddr) {
> > +	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
> > +					     SMP_CACHE_BYTES, nid);
> > +	if (!NODE_DATA(nid)) {
> >  		prom_printf("Cannot allocate pglist_data for nid[%d]\n", nid);
> >  		prom_halt();
> >  	}
> > -	NODE_DATA(nid) = __va(paddr);
> > -	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
> >  
> >  	NODE_DATA(nid)->node_id = nid;
> >  #endif
> 
> Same here.
> 
> I did not look at the other cases.

I really tried to be careful and did the replacements only for the calls
that do panic if an allocation fails.
 
> 	Sam
> 

-- 
Sincerely yours,
Mike.

