From: David Miller <davem@davemloft.net>
Date: Sat, 08 Dec 2018 20:58:28 -0800 (PST)
Subject: [OpenRISC] [PATCH 05/10] sparc64/iommu: move code around a bit
In-Reply-To: <20181208173702.15158-6-hch@lst.de>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-6-hch@lst.de>
Message-ID: <20181208.205828.975725504291400475.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:36:57 -0800

> Move the alloc / free routines down the file so that we can easily use
> the map / unmap helpers to implement non-consistent allocations.
> 
> Also drop the _coherent postfix to match the method name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
