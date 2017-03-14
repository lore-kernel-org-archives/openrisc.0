From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Mar 2017 16:25:30 +0100
Subject: [OpenRISC] [PATCH 3/3] openrisc: Export symbols needed by
	modules
In-Reply-To: <05e67e380f8a29ce479a180a3bbd145f30236b16.1489502779.git.shorne@gmail.com>
References: <cover.1489502779.git.shorne@gmail.com>
 <05e67e380f8a29ce479a180a3bbd145f30236b16.1489502779.git.shorne@gmail.com>
Message-ID: <CAMuHMdVR5xL4SDD7GTd5JdGfhHLGuVvM7v0m-k2iJAd6U21sUg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Tue, Mar 14, 2017 at 3:56 PM, Stafford Horne <shorne@gmail.com> wrote:
> This was detected by allmodconfig, errors reported:
>
>  ERROR: "empty_zero_page" [net/ceph/libceph.ko] undefined!
>  ERROR: "__ucmpdi2" [lib/842/842_decompress.ko] undefined!
>  ERROR: "empty_zero_page" [fs/nfs/objlayout/objlayoutdriver.ko] undefined!
>  ERROR: "empty_zero_page" [fs/exofs/exofs.ko] undefined!
>  ERROR: "empty_zero_page" [fs/crypto/fscrypto.ko] undefined!
>  ERROR: "__ucmpdi2" [fs/btrfs/btrfs.ko] undefined!
>  ERROR: "pm_power_off" [drivers/regulator/act8865-regulator.ko] undefined!
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

> --- a/arch/openrisc/kernel/or32_ksyms.c
> +++ b/arch/openrisc/kernel/or32_ksyms.c
> @@ -42,6 +42,11 @@ DECLARE_EXPORT(__muldi3);
>  DECLARE_EXPORT(__ashrdi3);
>  DECLARE_EXPORT(__ashldi3);
>  DECLARE_EXPORT(__lshrdi3);
> +DECLARE_EXPORT(__ucmpdi2);
> +
> +extern unsigned long empty_zero_page[2048];

Can't you #include <asm/pgtable.h> instead of adding a forward
declaration?

> +EXPORT_SYMBOL(empty_zero_page);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
