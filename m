From: David Miller <davem@davemloft.net>
Date: Sat, 08 Dec 2018 20:57:40 -0800 (PST)
Subject: [OpenRISC] [PATCH 2/6] sparc: factor the dma coherent mapping
	into helper
In-Reply-To: <20181208174115.16237-3-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-3-hch@lst.de>
Message-ID: <20181208.205740.890560451086576856.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:11 -0800

> Factor the code to remap memory returned from the DMA coherent allocator
> into two helpers that can be shared by the IOMMU and direct mapping code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
