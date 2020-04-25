From: Mike Rapoport <rppt@kernel.org>
Date: Sat, 25 Apr 2020 19:49:47 +0300
Subject: [OpenRISC] [PATCH 15/21] mm: memmap_init: iterate over memblock
 regions rather that check each PFN
In-Reply-To: <9143538a-4aaa-ca1d-9c8f-72ac949cf593@redhat.com>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-16-rppt@kernel.org>
 <9143538a-4aaa-ca1d-9c8f-72ac949cf593@redhat.com>
Message-ID: <20200425164947.GH14260@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Apr 24, 2020 at 09:22:32AM +0200, David Hildenbrand wrote:
> On 12.04.20 21:48, Mike Rapoport wrote:
> > From: Baoquan He <bhe@redhat.com>
> > 
> > When called during boot the memmap_init_zone() function checks if each PFN
> > is valid and actually belongs to the node being initialized using
> > early_pfn_valid() and early_pfn_in_nid().
> > 
> > Each such check may cost up to O(log(n)) where n is the number of memory
> > banks, so for large amount of memory overall time spent in early_pfn*()
> > becomes substantial.
> > 
> > Since the information is anyway present in memblock, we can iterate over
> > memblock memory regions in memmap_init() and only call memmap_init_zone()
> > for PFN ranges that are know to be valid and in the appropriate node.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  mm/page_alloc.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 7f6a3081edb8..c43ce8709457 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5995,14 +5995,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >  		 * function.  They do not exist on hotplugged memory.
> >  		 */
> 
> After this change, the comment above is stale. the "holes in boot-time
> mem_map" are handled by the caller now AFAIKs.

Right, will update in v2.
Thanks!

> >  		if (context == MEMMAP_EARLY) {
> > -			if (!early_pfn_valid(pfn)) {
> > -				pfn = next_pfn(pfn);
> > -				continue;
> > -			}
> > -			if (!early_pfn_in_nid(pfn, nid)) {
> > -				pfn++;
> > -				continue;
> > -			}
> >  			if (overlap_memmap_init(zone, &pfn))
> >  				continue;
> >  			if (defer_init(nid, pfn, end_pfn))
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
