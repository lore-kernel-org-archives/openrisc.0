From: Stafford Horne <shorne@gmail.com>
Date: Fri, 1 Sep 2017 17:28:03 +0900
Subject: [OpenRISC] [PATCH 02/13] openrisc: define CPU_BIG_ENDIAN as true
In-Reply-To: <CAMuHMdUyW+ZBTb=bJp+ZwmUO0bc3rEyJMS19rmQrqmiDQL15=Q@mail.gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
 <65f12040f262906af8a599a85090f8482ef553cb.1504129273.git.shorne@gmail.com>
 <CAMuHMdUyW+ZBTb=bJp+ZwmUO0bc3rEyJMS19rmQrqmiDQL15=Q@mail.gmail.com>
Message-ID: <20170901082803.GI2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 01, 2017 at 10:06:49AM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 30, 2017 at 11:58 PM, Stafford Horne <shorne@gmail.com> wrote:
> > While working on SMP for OpenRISC I found this is needed for qrwlocks to
> > work correctly.  OpenRISC is big endian so this should have been here
> > already.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index ba8ae92ec5fb..8ddfc92ab813 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -29,6 +29,9 @@ config OPENRISC
> >         select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> >         select NO_BOOTMEM
> >
> > +config CPU_BIG_ENDIAN
> > +       def_bool y
> > +
> 
> This is already in Andrew's tree and linux-next, as part of commit
> 410ae809fee6c792 ("arch: define CPU_BIG_ENDIAN for all fixed big endian
> archs").

Thank you,  Yes I am cc'd on those patches.  I had added this patch myself
some time before 10ae809fee6c792 ("arch: define CPU_BIG_ENDIAN for all
fixed big endian archs") appeared.

Once that gets merged I will rebase and this will disappear.

-Stafford

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
