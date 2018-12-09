From: David Miller <davem@davemloft.net>
Date: Sat, 08 Dec 2018 20:57:33 -0800 (PST)
Subject: [OpenRISC] [PATCH 1/6] sparc: remove no needed sbus_dma_ops
	methods
In-Reply-To: <20181208174115.16237-2-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-2-hch@lst.de>
Message-ID: <20181208.205733.639997534873546175.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:10 -0800

> No need to BUG_ON() on the cache maintainance ops - they are no-ops
> by default, and there is nothing in the DMA API contract that prohibits
> calling them on sbus devices (even if such drivers are unlikely to
> ever appear).
> 
> Similarly a dma_supported method that always returns 0 is rather
> pointless.  The only thing that indicates is that no one ever calls
> the method on sbus devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
