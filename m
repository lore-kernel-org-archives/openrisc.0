From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Aug 2019 10:50:41 +0200
Subject: [OpenRISC] [PATCH 03/26] m68k,
 microblaze: remove ioremap_fullcache
In-Reply-To: <20190817073253.27819-4-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-4-hch@lst.de>
Message-ID: <CAMuHMdVT3VSQ1S=YEoTjYzxwpavy+43XUWA-wzCO56FuHK6R-g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Aug 17, 2019 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
> No callers of this function.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/include/asm/kmap.h     | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
