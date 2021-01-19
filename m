From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Jan 2021 08:37:59 +0100
Subject: [OpenRISC] Fwd: Re: [PATCH v5] net: can: Introduce MEN
 16Z192-00 CAN controller driver
In-Reply-To: <20210118212917.GI2002709@lianli.shorne-pla.net>
References: <81bbd71a-ff79-9f15-753a-d47b36b91756@pengutronix.de>
 <ea134d96-0856-62af-ea19-f6e0c2d80c90@duagon.com>
 <20210118212917.GI2002709@lianli.shorne-pla.net>
Message-ID: <CAMuHMdU+2oopABWih=-5t01gwaX-EQauMz7u=xFxiA62WJ4+8A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Mon, Jan 18, 2021 at 10:29 PM Stafford Horne <shorne@gmail.com> wrote:
> On Mon, Jan 18, 2021 at 09:09:04PM +0100, Abhijeet Badurkar wrote:
> > i am getting sparse warning regarding iounmap implementation of openrisc architecture for my CAN driver patch. Is there any specific reason why iounmap of openrisc doesn't have __iomem annnotation? Could you please suggest a fix for this?
>
> Hello,
>
> Sorry I missed this patch as I didn't recognize the subject.
>
> You could send a patch for iounmap if you like.  Otherwise I can get around to
> it in a few days.
>
> The patch would be something like:
>
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -77,7 +77,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long
> size)
>  }
>  EXPORT_SYMBOL(ioremap);
>
> -void iounmap(void *addr)
> +void iounmap(void __iomem *addr)
>  {
>         /* If the page is from the fixmap pool then we just clear out
>          * the fixmap mapping.

That is not sufficient.
Please check out the patch I submitted three weeks ago:
https://lore.kernel.org/lkml/20201228083328.3823431-1-geert+renesas at glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
