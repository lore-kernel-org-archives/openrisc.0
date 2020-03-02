From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Mar 2020 09:22:41 +0100
Subject: [OpenRISC] [RFC 1/3] mm/vma: Define a default value for
 VM_DATA_DEFAULT_FLAGS
In-Reply-To: <1583131666-15531-2-git-send-email-anshuman.khandual@arm.com>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-2-git-send-email-anshuman.khandual@arm.com>
Message-ID: <CAMuHMdUfm0X3cgEDzzF6fs0HQj83OPR=xVjQaT7uVDi2WbtHog@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Mar 2, 2020 at 7:48 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> There are many platforms with exact same value for VM_DATA_DEFAULT_FLAGS
> This creates a default value for VM_DATA_DEFAULT_FLAGS in line with the
> existing VM_STACK_DEFAULT_FLAGS. While here, also define some more macros
> with standard VMA access flag combinations that are used frequently across
> many platforms. Apart from simplification, this reduces code duplication
> as well.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/page.h       |  3 ---

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
