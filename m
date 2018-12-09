From: David Miller <davem@davemloft.net>
Date: Sat, 08 Dec 2018 20:57:47 -0800 (PST)
Subject: [OpenRISC] [PATCH 3/6] sparc: remove the sparc32_dma_ops
	indirection
In-Reply-To: <20181208174115.16237-4-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-4-hch@lst.de>
Message-ID: <20181208.205747.2007860478185366370.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:12 -0800

> There is no good reason to have a double indirection for the sparc32
> dma ops, so remove the sparc32_dma_ops and define separate dma_map_ops
> instance for the different IOMMU types.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
