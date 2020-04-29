From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 29 Apr 2020 17:33:46 +0300
Subject: [OpenRISC] [PATCH v2 16/20] mm: remove early_pfn_in_nid() and
 CONFIG_NODES_SPAN_OTHER_NODES
In-Reply-To: <20200429141706.GA25142@infradead.org>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-17-rppt@kernel.org>
 <20200429141706.GA25142@infradead.org>
Message-ID: <20200429143346.GI14260@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Apr 29, 2020 at 07:17:06AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 29, 2020 at 03:11:22PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The commit f47ac088c406 ("mm: memmap_init: iterate over memblock regions
> > rather that check each PFN") made early_pfn_in_nid() obsolete and since
> > CONFIG_NODES_SPAN_OTHER_NODES is only used to pick a stub or a real
> > implementation of early_pfn_in_nid() it is also not needed anymore.
> 
> I don't think you can quote a commit id for something that hasn't been
> commited to mainline yet.i

Ouch, that was one of the things I've indented to fix in v2...

> Then again I would have just merged this
> patch into the one that obsoleted early_pfn_in_nid anyway.

I've kept these commits separate to preserve the authorship.
I'll update the changelog so that it won't mention commit id.

-- 
Sincerely yours,
Mike.
