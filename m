From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Date: Wed, 11 Jan 2017 21:31:00 +0100
Subject: [OpenRISC] [PATCH 2/9] Move dma_ops from archdata into struct
	device
In-Reply-To: <1484158589.2619.14.camel@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
 <20170111064803.GB26893@kroah.com>
 <1484158589.2619.14.camel@sandisk.com>
Message-ID: <20170111203100.GB17895@kroah.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Wed, Jan 11, 2017 at 06:17:03PM +0000, Bart Van Assche wrote:
> On Wed, 2017-01-11 at 07:48 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 10, 2017 at 04:56:41PM -0800, Bart Van Assche wrote:
> > > Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
> > > transfer data between memory and PCIe adapter. Because of performance
> > > reasons it is important that the CPU cache is not flushed when such
> > > drivers transfer data. Make this possible by allowing these drivers to
> > > override the dma_map_ops pointer. Additionally, introduce the function
> > > set_dma_ops() that will be used by a later patch in this series.
> > 
> > When you say things like "additionally", that's a huge flag that this
> > needs to be split up into multiple patches.  No need to add
> > set_dma_ops() here in this patch.
> 
> Hello Greg,
> 
> Some architectures already define a set_dma_ops() function. So what this
> patch does is to move both the dma_ops pointer and the set_dma_ops()
> function from architecture-specific to architecture independent code. I
> don't think that it is possible to separate these two changes. But I
> understand that how I formulated the patch description caused confusion. I
> will rewrite the patch description to make it more clear before I repost
> this patch series.

I think you should separate it out into multiple patches, this is a
mess, as you say below:

> > And I'd argue that it should be dma_ops_set(), and dma_ops_get(), just
> > to keep the namespace sane, but that's probably a different set of
> > patches...
> 
> Every time I rebase and retest this patch series on top of a new kernel
> version I have to modify some of the patches to compensate for changes in
> the architecture code. So I expect that once Linus merges these patches that
> he will have to resolve one or more merge conflicts. Including a rename of
> the functions that query and set the dma_ops pointer in this patch series
> would increase the number of merge conflicts triggered by this patch series
> and would make Linus' job harder. So I hope that you will allow me to
> postpone that rename until a later time ...

That's a big sign that your patch series needs work.  Break it up into
smaller pieces, it should be possible, which will make merges easier
(well, different in a way.)

Good luck, tree-wide changes are not simple.

greg k-h
