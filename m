From: David Miller <davem@davemloft.net>
Date: Sat, 08 Dec 2018 20:57:53 -0800 (PST)
Subject: [OpenRISC] [PATCH 4/6] sparc: remove not required includes from
 dma-mapping.h
In-Reply-To: <20181208174115.16237-5-hch@lst.de>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-5-hch@lst.de>
Message-ID: <20181208.205753.909472854043389455.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:13 -0800

> The only thing we need to explicitly pull in is the defines for the
> CPU type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
