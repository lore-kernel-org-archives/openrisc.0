From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Oct 2021 08:59:03 +0200
Subject: [OpenRISC] [PATCH 2/2] kbuild: use more subdir- for visiting
 subdirectories while cleaning
In-Reply-To: <20211013063622.548590-2-masahiroy@kernel.org>
References: <20211013063622.548590-1-masahiroy@kernel.org>
 <20211013063622.548590-2-masahiroy@kernel.org>
Message-ID: <CAMuHMdUQVpvvq=ZqjL97gV6AxS5eGm4mRS=gL4PPwWiBS-v5AA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 13, 2021 at 8:43 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Documentation/kbuild/makefiles.rst suggests to use "archclean" for
> cleaning arch/$(SRCARCH)/boot/.
>
> Since commit d92cc4d51643 ("kbuild: require all architectures to have
> arch/$(SRCARCH)/Kbuild"), we can use the "subdir- += boot" trick for
> all architectures. This can take advantage of the parallel option (-j)
> for "make clean".
>
> I also cleaned up the comments. The "archdep" target does not exist.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

>  arch/m68k/Makefile                 |  4 +---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
