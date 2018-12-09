From: David Miller <davem@davemloft.net>
Date: Sat, 08 Dec 2018 20:58:55 -0800 (PST)
Subject: [OpenRISC] [PATCH 08/10] sparc64/pci_sun4v: implement
 DMA_ATTR_NON_CONSISTENT
In-Reply-To: <20181208173702.15158-9-hch@lst.de>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-9-hch@lst.de>
Message-ID: <20181208.205855.1922834726608485490.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:37:00 -0800

> Just allocate the memory and use map_page to map the memory.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
