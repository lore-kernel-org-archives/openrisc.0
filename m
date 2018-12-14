From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Dec 2018 10:54:32 +0100
Subject: [OpenRISC] [PATCH 1/2] dma-mapping: zero memory returned from
	dma_alloc_*
In-Reply-To: <20181214082515.14835-2-hch@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
 <20181214082515.14835-2-hch@lst.de>
Message-ID: <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Christoph,

On Fri, Dec 14, 2018 at 9:26 AM Christoph Hellwig <hch@lst.de> wrote:
> If we want to map memory from the DMA allocator to userspace it must be
> zeroed at allocation time to prevent stale data leaks.   We already do
> this on most common architectures, but some architectures don't do this
> yet, fix them up, either by passing GFP_ZERO when we use the normal page
> allocator or doing a manual memset otherwise.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/arch/m68k/kernel/dma.c
> +++ b/arch/m68k/kernel/dma.c
> @@ -32,7 +32,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>         size = PAGE_ALIGN(size);
>         order = get_order(size);
>
> -       page = alloc_pages(flag, order);
> +       page = alloc_pages(flag | GFP_ZERO, order);
>         if (!page)
>                 return NULL;

There's second implementation below, which calls __get_free_pages() and
does an explicit memset().  As __get_free_pages() calls alloc_pages(), perhaps
it makes sense to replace the memset() by GFP_ZERO, to increase consistency?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
