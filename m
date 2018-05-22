From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 13:53:20 +0200
Subject: [OpenRISC] [PATCH 04/20] arm-nommu: use generic
	dma_noncoherent_ops
In-Reply-To: <20180511091114.GA16141@n2100.armlinux.org.uk>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-5-hch@lst.de>
 <20180511091114.GA16141@n2100.armlinux.org.uk>
Message-ID: <20180522115320.GA14530@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, May 11, 2018 at 10:11:15AM +0100, Russell King - ARM Linux wrote:
> > +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> > +		size_t size, enum dma_data_direction dir)
> 
> Please no.  There is a lot of history of these (__dma_page_cpu_to_dev etc)
> functions being abused by out of tree drivers, because they think they
> know better.  This is stopped by making them static and ensuring that
> drivers have no access to these functions.
> 
> Please do not re-expose these to the global kernel.
> 
> While it may make things easier for a cross-architecture point of view,
> it makes it a lot easier for people to abuse these private APIs.

The point of this series, which isn't fully archived yet, is to
consolidate the direct mapping dma code, that is all dma_map_ops
instances except for iommus.  It is in fact in many ways modelled
after the ARM code.  For that we need the architectures to supply
the cache maintainance routines.

However, even if they now appear in dma-noncoherent.h they are NOT
and will NOT be exported, so using them directly from drivers won't
easily be possible.

I'll drop the arm-nommu patch for now, but I will pester your with this
again once arm is the last architecture not sharing the common code.

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
---end quoted text---
