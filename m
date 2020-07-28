From: Baoquan He <bhe@redhat.com>
Date: Tue, 28 Jul 2020 14:24:08 -0000
Subject: [OpenRISC] [PATCH 14/15] x86/numa: remove redundant iteration
 over memblock.reserved
In-Reply-To: <20200728141504.GC3655207@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-15-rppt@kernel.org>
 <20200728110254.GA14854@MiWiFi-R3L-srv>
 <20200728141504.GC3655207@kernel.org>
Message-ID: <20200728142348.GE10792@MiWiFi-R3L-srv>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 07/28/20 at 05:15pm, Mike Rapoport wrote:
> On Tue, Jul 28, 2020 at 07:02:54PM +0800, Baoquan He wrote:
> > On 07/28/20 at 08:11am, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > numa_clear_kernel_node_hotplug() function first traverses numa_meminfo
> > > regions to set node ID in memblock.reserved and than traverses
> > > memblock.reserved to update reserved_nodemask to include node IDs that were
> > > set in the first loop.
> > > 
> > > Remove redundant traversal over memblock.reserved and update
> > > reserved_nodemask while iterating over numa_meminfo.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  arch/x86/mm/numa.c | 26 ++++++++++----------------
> > >  1 file changed, 10 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 8ee952038c80..4078abd33938 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -498,31 +498,25 @@ static void __init numa_clear_kernel_node_hotplug(void)
> > >  	 * and use those ranges to set the nid in memblock.reserved.
> > >  	 * This will split up the memblock regions along node
> > >  	 * boundaries and will set the node IDs as well.
> > > +	 *
> > > +	 * The nid will also be set in reserved_nodemask which is later
> > > +	 * used to clear MEMBLOCK_HOTPLUG flag.
> > > +	 *
> > > +	 * [ Note, when booting with mem=nn[kMG] or in a kdump kernel,
> > > +	 *   numa_meminfo might not include all memblock.reserved
> > > +	 *   memory ranges, because quirks such as trim_snb_memory()
> > > +	 *   reserve specific pages for Sandy Bridge graphics.
> > > +	 *   These ranges will remain with nid == MAX_NUMNODES. ]
> > >  	 */
> > >  	for (i = 0; i < numa_meminfo.nr_blks; i++) {
> > >  		struct numa_memblk *mb = numa_meminfo.blk + i;
> > >  		int ret;
> > >  
> > >  		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
> > > +		node_set(mb->nid, reserved_nodemask);
> > 
> > Really? This will set all node id into reserved_nodemask. But in the
> > current code, it's setting nid into memblock reserved region which
> > interleaves with numa_memoinfo, then get those nid and set it in
> > reserved_nodemask. This is so different, with my understanding. Please
> > correct me if I am wrong.
> 
> You are right, I've missed the intersections of numa_meminfo with
> memblock.reserved.
> 
> x86 interaction with membock is so, hmm, interesting...

Yeah, numa_clear_kernel_node_hotplug() intends to find out any memory node
which has reserved memory, then make it as unmovable. Setting all node
id into reserved_nodemask will break the use case of hot removing hotpluggable
boot memory after system bootup.

