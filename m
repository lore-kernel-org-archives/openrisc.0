From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Jan 2022 17:31:05 +0100
Subject: [OpenRISC] [PATCH] openrisc: init: Add support for common clk
In-Reply-To: <20220111030055.2043568-1-shorne@gmail.com>
References: <20220111030055.2043568-1-shorne@gmail.com>
Message-ID: <CAMuHMdUUShmJfRWUCS+CQ_OUW9cUHuZQS3aTPznt-i+TT0Tgtw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Tue, Jan 11, 2022 at 4:01 AM Stafford Horne <shorne@gmail.com> wrote:
> When testing the new litex_mmc driver it was found to not work on
> OpenRISC due to missing support for common clk.  This patch does the
> basic initialization to allow OpenRISC to use the common clk framework.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for your patch!

This matches what other architectures are doing, and is IMHO the way
forward for sharing FPGA drivers among architectures.
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
