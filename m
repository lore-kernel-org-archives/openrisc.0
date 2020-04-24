From: Baoquan He <bhe@redhat.com>
Date: Fri, 24 Apr 2020 08:33:56 +0800
Subject: [OpenRISC] [PATCH 17/21] mm: free_area_init: allow defining
 max_zone_pfn in descending order
In-Reply-To: <20200423055559.GF14260@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-18-rppt@kernel.org>
 <20200423025311.GZ4247@MiWiFi-R3L-srv>
 <20200423025720.GA4247@MiWiFi-R3L-srv>
 <20200423055559.GF14260@kernel.org>
Message-ID: <20200424003356.GA10119@MiWiFi-R3L-srv>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/23/20 at 08:55am, Mike Rapoport wrote:
> On Thu, Apr 23, 2020 at 10:57:20AM +0800, Baoquan He wrote:
> > On 04/23/20 at 10:53am, Baoquan He wrote:
> > > On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > Some architectures (e.g. ARC) have the ZONE_HIGHMEM zone below the
> > > > ZONE_NORMAL. Allowing free_area_init() parse max_zone_pfn array even it is
> > > > sorted in descending order allows using free_area_init() on such
> > > > architectures.
> > > > 
> > > > Add top -> down traversal of max_zone_pfn array in free_area_init() and use
> > > > the latter in ARC node/zone initialization.
> > > 
> > > Or maybe leave ARC as is. The change in this patchset doesn't impact
> > > ARC's handling about zone initialization, leaving it as is can reduce
> > > the complication in implementation of free_area_init(), which is a
> > > common function. So I personally don't see a strong motivation to have
> > > this patch.
> > 
> > OK, seems this patch is prepared to simplify free_area_init_node(), so
> > take back what I said at above.
> > 
> > Then this looks necessary, even though it introduces special case into
> > common function free_area_init().
> 
> The idea is to have a single free_area_init() for all architectures
> without keeping two completely different ways of calculating the zone
> extents.
> Another thing, is that with this we could eventually switch ARC from
> DISCONTIGMEM.

Yeah, I think uniting them into a single free_area_init() is a great
idea. Even though I had been through this patchset, when looked into
each of them, still may forget the detail in later patch :)

