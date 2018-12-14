From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Dec 2018 14:33:18 +0100
Subject: [OpenRISC] ensure dma_alloc_coherent always returns zeroed
	memory
In-Reply-To: <20181214082515.14835-1-hch@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
Message-ID: <20181214133318.GA13968@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

And in various places this used GFP_ZERO instead of __GFP_ZERO,
so won't compile.

The fixed version is available here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-alloc-always-zero

