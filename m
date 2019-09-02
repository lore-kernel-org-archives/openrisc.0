From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Sep 2019 09:53:01 +0200
Subject: [OpenRISC] [PATCH 08/26] m68k: simplify ioremap_nocache
In-Reply-To: <20190830160620.GD26887@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-9-hch@lst.de>
 <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
 <20190830160620.GD26887@lst.de>
Message-ID: <CAMuHMdXB=DWyu=Y25gih5poeanVnhLEP2MXoozvxdEY6op32FA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Christoph,

On Fri, Aug 30, 2019 at 6:06 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Aug 19, 2019 at 10:56:02AM +0200, Geert Uytterhoeven wrote:
> > On Sat, Aug 17, 2019 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> > > Just define ioremap_nocache to ioremap instead of duplicating the
> > > inline.  Also defined ioremap_uc in terms of ioremap instead of
> > > the using a double indirection.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Do you mind picking this up through the m68k tree?

Sure. Applied and queued for v5.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
