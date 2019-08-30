From: Christoph Hellwig <hch@lst.de>
Date: Fri, 30 Aug 2019 18:04:04 +0200
Subject: [OpenRISC] [PATCH 14/26] asm-generic: don't provide __ioremap
In-Reply-To: <alpine.DEB.2.21.9999.1908171357180.4130@viisi.sifive.com>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-15-hch@lst.de>
 <alpine.DEB.2.21.9999.1908171357180.4130@viisi.sifive.com>
Message-ID: <20190830160404.GA26887@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Arnd, can you consider this patch for asm-generic for 5.4?  I don't
think I'll be able to feed the actual generic ioremap implementation
to Linus this merge window, but if we can get as many patches as
possible in through their maintainer trees that would make my life
much easier.
