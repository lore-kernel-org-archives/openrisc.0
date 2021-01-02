From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 2 Jan 2021 14:10:00 +0100
Subject: [OpenRISC] [PATCH] openrisc: restart: Call common handlers
 before hanging
In-Reply-To: <20210101061135.GA3106870@lianli.shorne-pla.net>
References: <20201227091446.118437-1-joel@jms.id.au>
 <20210101061135.GA3106870@lianli.shorne-pla.net>
Message-ID: <CAMuHMdU0HKLnmRdBqpfpZpse=SUFCSOS8TnZRgRSmqV0zEMBzQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Fri, Jan 1, 2021 at 7:11 AM Stafford Horne <shorne@gmail.com> wrote:
> On Sun, Dec 27, 2020 at 07:44:46PM +1030, Joel Stanley wrote:
> > Currently openrisc will print a message and then hang in an infinite
> > loop when rebooting.
> >
> > This patch adopts some code from ARM, which calls the common restart
> > infrastructure and hangs after a small delay if the restart infra
> > doesn't do anything.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > Geert has a patch[1] for the litex soc code that adds a restart hander.
> > Openrisc doesn't hit that code path, this patch fixes that.
> >
> > [1] https://github.com/geertu/linux/commit/7d09dc0797a8208a11eb7c0c2156c1a4c120180f

> > +     do_kernel_restart(cmd);
> As you mentioned this depends on Geert's patch.  Does he plan to submit it soon?

Will do, once I have managed to escape from Xmas-and-NY mode ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
