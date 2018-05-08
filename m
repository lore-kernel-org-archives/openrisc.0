From: Christoph Hellwig <hch@lst.de>
Date: Tue, 8 May 2018 12:45:56 +0200
Subject: [OpenRISC] [PATCH 3/3] dma-debug: unexport
	dma_debug_resize_entries and	debug_dma_dump_mappings
In-Reply-To: <bb5bb25f-24da-9729-a39b-3b88c65ef628@arm.com>
References: <20180424140235.9125-1-hch@lst.de>
 <20180424140235.9125-4-hch@lst.de>
 <bb5bb25f-24da-9729-a39b-3b88c65ef628@arm.com>
Message-ID: <20180508104556.GA26841@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 08, 2018 at 11:05:20AM +0100, Robin Murphy wrote:
> On 24/04/18 15:02, Christoph Hellwig wrote:
>> Only used by the AMD GART driver, which must be built in.
>
> FWIW debug_dma_dump_mappings() is also called by the Intel VT-d driver, but 
> the same reasoning still applies.

I'll update the changelog.

> This does rather beg the question of 
> whether it's right to have bits of low-level dma-debug internals *only* 
> called by a couple of IOMMU drivers, but that can wait for another day.

My gut feeling is that it is wrong, but I didn't have time to look into
the details and history of how this happened.
