From: hch@lst.de <hch@lst.de>
Date: Thu, 20 Dec 2018 15:34:15 +0100
Subject: [OpenRISC] ensure dma_alloc_coherent always returns zeroed
	memory
In-Reply-To: <1545316369.14089.20.camel@synopsys.com>
References: <20181214082515.14835-1-hch@lst.de>
 <20181219165939.GA26087@lst.de> <1545316369.14089.20.camel@synopsys.com>
Message-ID: <20181220143415.GA17726@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Dec 20, 2018 at 02:32:52PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> I test kernel from your 'dma-alloc-always-zero' branch, and as
> I can see we have DMA peripherals (like USB) broken.

I would be really surprised if that is caused by the patch to add
the zeroing.  Can you check which commit caused the issue by bisecting
from a known good baseline?
