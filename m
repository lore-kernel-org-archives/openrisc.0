From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Nov 2019 19:16:38 +0100
Subject: [OpenRISC] [PATCH 11/21] asm-generic: don't provide ioremap for
 CONFIG_MMU
In-Reply-To: <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
References: <20191029064834.23438-12-hch@lst.de>
 <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
Message-ID: <CAMuHMdVuDp_8UDeWv8tdPAH5JS84=-yfwZjOk-YQcoYKM9za+w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Palmer,

On Wed, Nov 6, 2019 at 7:11 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> It looks like the difference in prototype between the architectures is between
>
>     void __iomem *ioremap(resource_size_t, size_t)
>     void __iomem *ioremap(phys_addr_t, size_t)
>     void __iomem *ioremap(phys_addr_t, unsigned long)
>     void __iomem *ioremap(unsigned long, unsigned long)
>
> shouldn't they all just be that first one?  In other words, wouldn't it be
> better to always provide the generic ioremap prototype and unify the ports
> instead?

Agreed. But I'd go for the second one.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
