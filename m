From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2020 17:41:43 +0200
Subject: [OpenRISC] [PATCH 1/8] mm: remove unneeded includes of
 <asm/pgalloc.h>
In-Reply-To: <20200627143453.31835-2-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-2-rppt@kernel.org>
Message-ID: <CAMuHMdUOrrrtKuhtWJvzKNNLXY1fx+Ym1oXGN2J_CZ7RqByGHQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jun 27, 2020 at 4:35 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> In the most cases <asm/pgalloc.h> header is required only for allocations
> of page table memory. Most of the .c files that include that header do not
> use symbols declared in <asm/pgalloc.h> and do not require that header.
>
> As for the other header files that used to include <asm/pgalloc.h>, it is
> possible to move that include into the .c file that actually uses symbols
> from <asm/pgalloc.h> and drop the include from the header file.
>
> The process was somewhat automated using
>
>         sed -i -E '/[<"]asm\/pgalloc\.h/d' \
>                 $(grep -L -w -f /tmp/xx \
>                         $(git grep -E -l '[<"]asm/pgalloc\.h'))
>
> where /tmp/xx contains all the symbols defined in
> arch/*/include/asm/pgalloc.h.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

For the m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
