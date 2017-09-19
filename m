From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Sep 2017 18:49:48 +0200
Subject: [OpenRISC] [PATCH] openrisc: dts: or1ksim: Add stdout-path
In-Reply-To: <20170919140024.32563-1-shorne@gmail.com>
References: <20170919140024.32563-1-shorne@gmail.com>
Message-ID: <CAMuHMdWwJ0VWCOfvLW9rWRq445XB3iPgk3VfHN_f9_eU4Lrjeg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Tue, Sep 19, 2017 at 4:00 PM, Stafford Horne <shorne@gmail.com> wrote:
> During reviews of the OpenRISC SMP patch series it was suggested to add
> stdout-path to the SMP dts file.  Add stdout-path to our other dts files
> to be a good example.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/boot/dts/or1ksim.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/dts/or1ksim.dts
> index 5d4f9027afaf..ecc30968cbcb 100644
> --- a/arch/openrisc/boot/dts/or1ksim.dts
> +++ b/arch/openrisc/boot/dts/or1ksim.dts
> @@ -7,6 +7,7 @@
>
>         chosen {
>                 bootargs = "console=uart,mmio,0x90000000,115200";
> +               stdout-path = &serial0;

I think that should be:

-               bootargs = "console=uart,mmio,0x90000000,115200";
+               stdout-path = "serial0:115200";

If stdout-path is present, it will become the default console.
All other UART parameters except for the serial speed are derived from
the serial0 node (= serial at 90000000) in DT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
