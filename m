From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Feb 2021 17:07:51 +0100
Subject: [OpenRISC] [PATCH v2] openrisc: use device tree to determine
 present cpus
In-Reply-To: <20210205144317.GK2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net>
 <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
 <20210205144317.GK2002709@lianli.shorne-pla.net>
Message-ID: <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Fri, Feb 5, 2021 at 3:43 PM Stafford Horne <shorne@gmail.com> wrote:
> On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> > Use the device tree to determine the present cpus instead of assuming all
> > CONFIG_NRCPUS are actually present in the system.
> >
> > Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
>
> Hi Jan,
>
> I cannot apply this patch, it seems you somehow sent it signed as a multipart
> message via Thunderbird.
>
> This causes errors when trying to apply, even after I tried to manually fix the
> patch mail:
>
>     Applying: openrisc: use device tree to determine present cpus
>     error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
>     error: could not build fake ancestor
>     Patch failed at 0001 openrisc: use device tree to determine present cpus
>
> Can you send this using 'git send-email?'
>
> If not I can get it applied with some work, otherwise you can point me to a git
> repo which I can pull it from.

"b4 am 6dbc27f8-5261-59c5-acba-70f6c6a74ba1 at rwth-aachen.de" works
fine for me.

git://git.kernel.org/pub/scm/utils/b4/b4.git

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
