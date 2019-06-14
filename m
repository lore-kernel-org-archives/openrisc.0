From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Jun 2019 16:44:24 +0200
Subject: [OpenRISC] handle "special" dma allocation in common code
Message-ID: <20190614144431.21760-1-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,,

this series ensures that the common dma-direct code handles the somewhat
special allocation types requested by the DMA_ATTR_NON_CONSISTENT and
DMA_ATTR_NO_KERNEL_MAPPING flags directly.  To do so it also removes three
partial and thus broken implementations of DMA_ATTR_NON_CONSISTENT.  Last
but not least it switches arc to use the generic dma remapping code now
that arc doesn't implement any special behavior.

