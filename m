From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 May 2021 12:05:36 +0200
Subject: [OpenRISC] [PATCH] mm: update legacy flush_tlb_* to use vma
In-Reply-To: <87k0oaq311.wl-chenli@uniontech.com>
References: <87k0oaq311.wl-chenli@uniontech.com>
Message-ID: <CAMuHMdWapV4ZypzpC0gvS01BKRQvPjsiD2uS7odb78dEeP=63Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, May 7, 2021 at 11:58 AM Chen Li <chenli@uniontech.com> wrote:
> 1. These tlb flush functions  have been using vma instead mm long time ago, but there
> is still some coments use mm as parameter.
>
> 2. the actual struct we use is vm_area_struct instead of vma_struct.
>
> 3. remove unused flush_kern_tlb_page.
>
> Signed-off-by: Chen Li <chenli@uniontech.com>

>  arch/m68k/include/asm/tlbflush.h     |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
