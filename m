From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 16:02:32 +0200
Subject: [OpenRISC] dma-debug cleanups, including removing the arch hook
Message-ID: <20180424140235.9125-1-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

this series has a few dma-debug cleanups, most notably removing the need
for architectures to explicitly initialize dma-debug.
