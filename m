From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Dec 2016 13:58:32 +0100
Subject: [OpenRISC] [PATCH] openrisc: Add _text symbol to fix ksym build
	error
In-Reply-To: <1481720102-20169-1-git-send-email-shorne@gmail.com>
References: <1481720102-20169-1-git-send-email-shorne@gmail.com>
Message-ID: <CAMuHMdX8fKxmWB60Wx-oi5bYu79X1brOHfDH-uN9nryidvk55w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Wed, Dec 14, 2016 at 1:55 PM, Stafford Horne <shorne@gmail.com> wrote:
> The build report reports:
>
>    .tmp_kallsyms1.o: In function `kallsyms_relative_base':
>>> (.rodata+0x8a18): undefined reference to `_text'
>
> This is when using 'make alldefconfig'. Adding this _text symbol to mark
> the start of the kernel as in other architecture fixes this.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/kernel/vmlinux.lds.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
> index ef31fc2..58eaca0 100644
> --- a/arch/openrisc/kernel/vmlinux.lds.S
> +++ b/arch/openrisc/kernel/vmlinux.lds.S
> @@ -44,6 +44,8 @@ SECTIONS
>          /* Read-only sections, merged into text segment: */
>          . = LOAD_BASE ;
>
> +       _text = .;
> +
>         /* _s_kernel_ro must be page aligned */
>         . = ALIGN(PAGE_SIZE);
>         _s_kernel_ro = .;
> @@ -66,6 +68,7 @@ SECTIONS
>          * fixup is definitely necessary
>          */
>
> +       _data = .;

This change is not mentioned in the patch description.
Is it required? Does it fix something different?

>         _sdata = .;
>
>         /* Page alignment required for RO_DATA_SECTION */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

