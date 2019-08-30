From: Christoph Hellwig <hch@lst.de>
Date: Fri, 30 Aug 2019 18:07:05 +0200
Subject: [OpenRISC] [PATCH 05/26] openrisc: map as uncached in ioremap
In-Reply-To: <20190823135539.GC24874@lianli.shorne-pla.net>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-6-hch@lst.de>
 <20190823135539.GC24874@lianli.shorne-pla.net>
Message-ID: <20190830160705.GF26887@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Aug 23, 2019 at 10:55:39PM +0900, Stafford Horne wrote:
> On Sat, Aug 17, 2019 at 09:32:32AM +0200, Christoph Hellwig wrote:
> > Openrisc is the only architecture not mapping ioremap as uncached,
> > which has been the default since the Linux 2.6.x days.  Switch it
> > over to implement uncached semantics by default.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/openrisc/include/asm/io.h      | 20 +++-----------------
> >  arch/openrisc/include/asm/pgtable.h |  2 +-
> >  arch/openrisc/mm/ioremap.c          |  8 ++++----
> >  3 files changed, 8 insertions(+), 22 deletions(-)
> 
> Acked-by: Stafford Horne <shorne@gmail.com>

Can you send this one to Linus for 5.4?  That would help with the
possibility to remove ioremap_nocache after that.
