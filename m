From: Christoph Hellwig <hch@lst.de>
Date: Wed, 19 Dec 2018 17:59:39 +0100
Subject: [OpenRISC] ensure dma_alloc_coherent always returns zeroed
	memory
In-Reply-To: <20181214082515.14835-1-hch@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
Message-ID: <20181219165939.GA26087@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

FYI, I've picked this up for dma-mapping for-next now.
