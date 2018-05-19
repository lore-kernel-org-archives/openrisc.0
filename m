From: hch@lst.de <hch@lst.de>
Date: Sat, 19 May 2018 08:38:57 +0200
Subject: [OpenRISC] [PATCH 02/20] dma-mapping: provide a generic
	dma-noncoherent	implementation
In-Reply-To: <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
 <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
Message-ID: <20180519063857.GA18076@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, May 18, 2018 at 10:05:51PM +0200, Helge Deller wrote:
> This patch seems to fix the dma issues I faced on my 32bit B160L parisc box.
> 
> So it leaves only one open issue on parisc:
> Now every 32 bit parisc system is unnecessarily non-coherent.

I diagree with those comments, let me resend the refactored patch
to make it more clear.
