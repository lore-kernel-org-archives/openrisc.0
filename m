From: Bart Van Assche <Bart.VanAssche@sandisk.com>
Date: Wed, 11 Jan 2017 18:03:15 +0000
Subject: [OpenRISC] [PATCH 2/9] Move dma_ops from archdata into struct
	device
In-Reply-To: <20170111064624.GA26893@kroah.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
 <20170111064624.GA26893@kroah.com>
Message-ID: <1484157772.2619.12.camel@sandisk.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Wed, 2017-01-11 at 07:46 +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 10, 2017 at 04:56:41PM -0800, Bart Van Assche wrote:
> > Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
> > transfer data between memory and PCIe adapter. Because of performance
> > reasons it is important that the CPU cache is not flushed when such
> > drivers transfer data. Make this possible by allowing these drivers to
> > override the dma_map_ops pointer. Additionally, introduce the function
> > set_dma_ops() that will be used by a later patch in this series.
> > 
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: [ ... ]
> 
> That's a crazy cc: list, you should break this up into smaller pieces,
> otherwise it's going to bounce...

That's a subset of what scripts/get_maintainer.pl came up with. Suggestions
for a more appropriate cc-list for a patch like this that touches all
architectures would be welcome.

> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 491b4c0ca633..c7cb225d36b0 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -885,6 +885,8 @@ struct dev_links_info {
> >   * a higher-level representation of the device.
> >   */
> >  struct device {
> > +	const struct dma_map_ops *dma_ops; /* See also get_dma_ops() */
> > +
> >  	struct device		*parent;
> >  
> >  	struct device_private	*p;
> 
> Why not put this new pointer down with the other dma fields in this
> structure?  Any specific reason it needs to be first?

Are there CPU architectures for which access to the first member of a
structure can be encoded and/or executed more efficiently than access to
other members of a structure? If not, I'm fine with moving the new pointer
further down.

Bart.
