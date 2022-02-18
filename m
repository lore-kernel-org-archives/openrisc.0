From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Feb 2022 10:00:39 +0100
Subject: [OpenRISC] [PATCH v2 10/18] m68k: fix access_ok for coldfire
In-Reply-To: <20220216131332.1489939-11-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-11-arnd@kernel.org>
Message-ID: <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Arnd,

On Wed, Feb 16, 2022 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> While most m68k platforms use separate address spaces for user
> and kernel space, at least coldfire does not, and the other
> ones have a TASK_SIZE that is less than the entire 4GB address
> range.
>
> Using the default implementation of __access_ok() stops coldfire
> user space from trivially accessing kernel memory.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/m68k/include/asm/uaccess.h
> +++ b/arch/m68k/include/asm/uaccess.h
> @@ -12,14 +12,21 @@
>  #include <asm/extable.h>
>
>  /* We let the MMU do all checking */
> -static inline int access_ok(const void __user *addr,
> +static inline int access_ok(const void __user *ptr,
>                             unsigned long size)
>  {
> +       unsigned long limit = TASK_SIZE;
> +       unsigned long addr = (unsigned long)ptr;
> +
>         /*
>          * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
>          * for TASK_SIZE!
> +        * Removing this helper is probably sufficient.
>          */

Shouldn't the above comment block be removed completely,
as this is now implemented below?

> -       return 1;
> +       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES))
> +               return 1;
> +
> +       return (size <= limit) && (addr <= (limit - size));
>  }

Any pesky compilers that warn (or worse with -Werror) about
"condition always true" for TASK_SIZE = 0xFFFFFFFFUL?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
