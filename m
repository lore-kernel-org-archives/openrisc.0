From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 31 Jan 2020 02:20:03 -0000
Subject: [OpenRISC] [PATCH] openrisc: configs: Cleanup
 CONFIG_CROSS_COMPILE
In-Reply-To: <20200130213839.GW24874@lianli.shorne-pla.net>
References: <20200130191938.2444-1-krzk@kernel.org>
 <20200130213839.GW24874@lianli.shorne-pla.net>
Message-ID: <CAK7LNATwE2My-kZZugH7L+6jteU4dosiDt8e-H03n_-VH8nT1Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,


On Fri, Jan 31, 2020 at 6:38 AM Stafford Horne <shorne@gmail.com> wrote:
>
> +cc: Masahiro,
>
> On Thu, Jan 30, 2020 at 08:19:38PM +0100, Krzysztof Kozlowski wrote:
> > CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> > CONFIG_CROSS_COMPILE support").
>
> I see this patch is already in, but does it break 0-day test tools that depend
> on this CONFIG_CROSS_COMPILE setup?  I guess its been in since 2018, so there
> should be no problem.


As far as I understand, the 0-day bot passes CROSS_COMPILE= from the
command line because I see it in "make.cross" script, which is
attached in reports.

I did not hear any complaint from 0-day bot maintainers.



> Can you also help to update "Documentation/openrisc/openrisc_port.rst"?  It
> mentions the build steps are:
>
>     Build the Linux kernel as usual::
>
>         make ARCH=openrisc defconfig
>         make ARCH=openrisc
>
> This now changes, I used to use `make ARCH=openrisc CROSS_COMPILE=or1k-linux-`
> is this still going to work?

Yes, it still works.



> -Stafford
>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/openrisc/configs/or1ksim_defconfig    | 1 -
> >  arch/openrisc/configs/simple_smp_defconfig | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> > index d8ff4f8ffb88..75f2da324d0e 100644
> > --- a/arch/openrisc/configs/or1ksim_defconfig
> > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > @@ -1,4 +1,3 @@
> > -CONFIG_CROSS_COMPILE="or1k-linux-"
> >  CONFIG_NO_HZ=y
> >  CONFIG_LOG_BUF_SHIFT=14
> >  CONFIG_BLK_DEV_INITRD=y
> > diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> > index 64278992df9c..ff49d868e040 100644
> > --- a/arch/openrisc/configs/simple_smp_defconfig
> > +++ b/arch/openrisc/configs/simple_smp_defconfig
> > @@ -1,4 +1,3 @@
> > -CONFIG_CROSS_COMPILE="or1k-linux-"
> >  CONFIG_LOCALVERSION="-simple-smp"
> >  CONFIG_NO_HZ=y
> >  CONFIG_LOG_BUF_SHIFT=14
> > --
> > 2.17.1
> >



-- 
Best Regards
Masahiro Yamada
