From: Christoph Hellwig <hch@lst.de>
Date: Thu, 19 Jul 2018 06:02:28 -0700
Subject: [OpenRISC] use the generic dma-noncoherent code for openrisc
Message-ID: <20180719130232.1819-1-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Openrisc maintainers,

can you review these patches to switch openrisc to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
