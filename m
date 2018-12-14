From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Dec 2018 09:25:13 +0100
Subject: [OpenRISC] ensure dma_alloc_coherent always returns zeroed memory
Message-ID: <20181214082515.14835-1-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

For security reasons we already returned zeroed memory from
dma_alloc_coherent on most common platforms, but some implementation
missed out.  Make sure we provide a consistent behavior.
