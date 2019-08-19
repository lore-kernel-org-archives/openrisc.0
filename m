From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Aug 2019 10:56:02 +0200
Subject: [OpenRISC] [PATCH 08/26] m68k: simplify ioremap_nocache
In-Reply-To: <20190817073253.27819-9-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-9-hch@lst.de>
Message-ID: <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Christoph,

On Sat, Aug 17, 2019 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> Just define ioremap_nocache to ioremap instead of duplicating the
> inline.  Also defined ioremap_uc in terms of ioremap instead of
> the using a double indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, shouldn't we get rid of the sole user of ioremap_uc(), too?
Seems to make a difference on x86 only, where it is "strongly uncached"
(whatever that may mean ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
