From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Dec 2020 19:54:48 +0100
Subject: [OpenRISC] [PATCH] arch: consolidate pm_power_off callback
In-Reply-To: <20201222184510.19415-1-info@metux.net>
References: <20201222184510.19415-1-info@metux.net>
Message-ID: <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Enrico,

On Tue, Dec 22, 2020 at 7:46 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> Move the pm_power_off callback into one global place and also add an
> function for conditionally calling it (when not NULL), in order to remove
> code duplication in all individual archs.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Thanks for your patch!

> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -43,12 +43,6 @@
>  #include "proto.h"
>  #include "pci_impl.h"
>
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void) = machine_power_off;

Assignments like these are lost in the conversion.

> -EXPORT_SYMBOL(pm_power_off);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
