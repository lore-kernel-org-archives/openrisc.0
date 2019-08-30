From: Christoph Hellwig <hch@lst.de>
Date: Fri, 30 Aug 2019 18:06:20 +0200
Subject: [OpenRISC] [PATCH 08/26] m68k: simplify ioremap_nocache
In-Reply-To: <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-9-hch@lst.de>
 <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
Message-ID: <20190830160620.GD26887@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Aug 19, 2019 at 10:56:02AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Sat, Aug 17, 2019 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > Just define ioremap_nocache to ioremap instead of duplicating the
> > inline.  Also defined ioremap_uc in terms of ioremap instead of
> > the using a double indirection.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Do you mind picking this up through the m68k tree?
