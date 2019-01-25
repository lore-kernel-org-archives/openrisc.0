From: Mike Rapoport <rppt@linux.ibm.com>
Date: Fri, 25 Jan 2019 21:32:52 +0200
Subject: [OpenRISC] [PATCH v2 06/21] memblock:
 memblock_phys_alloc_try_nid(): don't panic
In-Reply-To: <20190125174502.GL25901@arrakis.emea.arm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-7-git-send-email-rppt@linux.ibm.com>
 <20190125174502.GL25901@arrakis.emea.arm.com>
Message-ID: <20190125193252.GH31519@rapoport-lnx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jan 25, 2019 at 05:45:02PM +0000, Catalin Marinas wrote:
> On Mon, Jan 21, 2019 at 10:03:53AM +0200, Mike Rapoport wrote:
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > index ae34e3a..2c61ea4 100644
> > --- a/arch/arm64/mm/numa.c
> > +++ b/arch/arm64/mm/numa.c
> > @@ -237,6 +237,10 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
> >  		pr_info("Initmem setup node %d [<memory-less node>]\n", nid);
> >  
> >  	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> > +	if (!nd_pa)
> > +		panic("Cannot allocate %zu bytes for node %d data\n",
> > +		      nd_size, nid);
> > +
> >  	nd = __va(nd_pa);
> >  
> >  	/* report and initialize */
> 
> Does it mean that memblock_phys_alloc_try_nid() never returns valid
> physical memory starting at 0?

Yes, it does.
memblock_find_in_range_node() that is used by all allocation methods
skips the first page [1].
 
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memblock.c#n257

> -- 
> Catalin
> 

-- 
Sincerely yours,
Mike.

