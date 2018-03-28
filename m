From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Mar 2018 14:23:47 +0200
Subject: [OpenRISC] [PATCH 01/16] initrd: Add generic code path for
 common initrd unloading logic.
In-Reply-To: <20180328120440.GB1838@infradead.org>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180324174458.26423-2-shea@shealevy.com>
 <20180328120440.GB1838@infradead.org>
Message-ID: <CAMuHMdXwEL-gLxiVJwuxwRtkyhR=vEm3GP4dzJMpc1nS8AKxKQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 28, 2018 at 2:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
>> +void free_initrd_mem(unsigned long start, unsigned long end)
>> +{
>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> +}
>> +#endif
>
> Given how trivial this is and how many architectures can use it I'd
> reverse the polarity and add a CONFIG_HAVE_ARCH_FREE_INITRD_MEM
> instead.

And while adding "special" functionality to the generic version, more and more
users of CONFIG_HAVE_ARCH_FREE_INITRD_MEM will be removed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
