From: David Miller <davem@davemloft.net>
Date: Sat, 08 Dec 2018 20:58:06 -0800 (PST)
Subject: [OpenRISC] [PATCH 6/6] sparc: merge 32-bit and 64-bit version
	of pci.h
In-Reply-To: <20181208174115.16237-7-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-7-hch@lst.de>
Message-ID: <20181208.205806.42785512174962944.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:15 -0800

> There are enough common defintions that a single header seems nicer.
> 
> Also drop the pointless <linux/dma-mapping.h> include.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David S. Miller <davem@davemloft.net>
