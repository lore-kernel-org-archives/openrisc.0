From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 26 Nov 2018 10:47:20 +0200
Subject: [OpenRISC] [PATCH 5/5] arch: simplify several early memory
	allocations
In-Reply-To: <20181126082134.GA10530@infradead.org>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
 <20181126082134.GA10530@infradead.org>
Message-ID: <20181126084719.GC14863@rapoport-lnx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Nov 26, 2018 at 12:21:34AM -0800, Christoph Hellwig wrote:
> >  static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> >  {
> > -	void *ptr = __va(memblock_phys_alloc(sz, align));
> > -	memset(ptr, 0, sz);
> > -	return ptr;
> > +	return memblock_alloc(sz, align);
> >  }
> 
> What is the point of keeping this wrapper?

No point indeed. I'll remove it in v2.
 
> >  static void __init *early_alloc(unsigned long sz)
> >  {
> > -	void *ptr = __va(memblock_phys_alloc(sz, sz));
> > -	memset(ptr, 0, sz);
> > -	return ptr;
> > +	return memblock_alloc(sz, sz);
> >  }
> 
> Same here.
> 

Here it provides a shortcut for allocations with align == size, but can be
removed as well.

-- 
Sincerely yours,
Mike.

