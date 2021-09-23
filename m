From: Maxime Ripard <maxime@cerno.tech>
Date: Thu, 23 Sep 2021 17:58:51 +0200
Subject: [OpenRISC] [PATCH v3 1/6] drm/vc4: select PM (openrisc)
In-Reply-To: <YUyVZCEeRPE8VJ7w@archlinux-ax161>
References: <20210819135931.895976-1-maxime@cerno.tech>
 <20210819135931.895976-2-maxime@cerno.tech>
 <8a5cdcf5-33ed-398f-243a-b8889fd754e3@infradead.org>
 <20210922084156.xqru5fdjkarbkyew@gilmour>
 <YUtQnml8FO8BC7sM@archlinux-ax161>
 <20210923145208.433zaqldird2vnxk@gilmour>
 <YUyVZCEeRPE8VJ7w@archlinux-ax161>
Message-ID: <20210923155851.dyttkomkza5pxqg3@gilmour>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Sep 23, 2021 at 07:55:32AM -0700, Nathan Chancellor wrote:
> On Thu, Sep 23, 2021 at 04:52:08PM +0200, Maxime Ripard wrote:
> > Hi Nathan,
> > 
> > On Wed, Sep 22, 2021 at 08:49:50AM -0700, Nathan Chancellor wrote:
> > > On Wed, Sep 22, 2021 at 10:41:56AM +0200, Maxime Ripard wrote:
> > > > Hi Randy,
> > > > 
> > > > On Sun, Sep 19, 2021 at 09:40:44AM -0700, Randy Dunlap wrote:
> > > > > On 8/19/21 6:59 AM, Maxime Ripard wrote:
> > > > > > We already depend on runtime PM to get the power domains and clocks for
> > > > > > most of the devices supported by the vc4 driver, so let's just select it
> > > > > > to make sure it's there, and remove the ifdef.
> > > > > > 
> > > > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > > > > ---
> > > > > >   drivers/gpu/drm/vc4/Kconfig    | 1 +
> > > > > >   drivers/gpu/drm/vc4/vc4_hdmi.c | 2 --
> > > > > >   2 files changed, 1 insertion(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> > > > > > index 118e8a426b1a..f774ab340863 100644
> > > > > > --- a/drivers/gpu/drm/vc4/Kconfig
> > > > > > +++ b/drivers/gpu/drm/vc4/Kconfig
> > > > > > @@ -9,6 +9,7 @@ config DRM_VC4
> > > > > >   	select DRM_KMS_CMA_HELPER
> > > > > >   	select DRM_GEM_CMA_HELPER
> > > > > >   	select DRM_PANEL_BRIDGE
> > > > > > +	select PM
> > > > > >   	select SND_PCM
> > > > > >   	select SND_PCM_ELD
> > > > > >   	select SND_SOC_GENERIC_DMAENGINE_PCM
> > > > > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > > > index c2876731ee2d..602203b2d8e1 100644
> > > > > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > > > @@ -2107,7 +2107,6 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
> > > > > >   	return 0;
> > > > > >   }
> > > > > > -#ifdef CONFIG_PM
> > > > > >   static int vc4_hdmi_runtime_suspend(struct device *dev)
> > > > > >   {
> > > > > >   	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
> > > > > > @@ -2128,7 +2127,6 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
> > > > > >   	return 0;
> > > > > >   }
> > > > > > -#endif
> > > > > >   static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
> > > > > >   {
> > > > > > 
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > FYI.
> > > > > 
> > > > > This still causes a build error on arch/openrisc/ since it does not support
> > > > > CONFIG_PM (it does not source "kernel/power/Kconfig" like some other arches do):
> > > > > 
> > > > > ./arch/riscv/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/x86/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/nds32/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/sh/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/arc/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/arm64/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/xtensa/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/sparc/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/arm/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/mips/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/powerpc/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/um/Kconfig:source "kernel/power/Kconfig"
> > > > > ./arch/ia64/Kconfig:source "kernel/power/Kconfig"
> > > > > 
> > > > > so with
> > > > > CONFIG_DRM_VC4=y
> > > > > # CONFIG_DRM_VC4_HDMI_CEC is not set
> > > > > 
> > > > > I still see
> > > > > ../drivers/gpu/drm/vc4/vc4_hdmi.c:2139:12: warning: 'vc4_hdmi_runtime_suspend' defined but not used [-Wunused-function]
> > > > >  2139 | static int vc4_hdmi_runtime_suspend(struct device *dev)
> > > > >       |            ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > With what version did you get that build error? -rc2 shouldn't have it
> > > > anymore since the runtime_pm hooks introduction got reverted.
> > > 
> > > -next still contains these patches as Stephen effectively reverted the
> > > changes in Linus' tree when merging in the drm-misc-fixes tree:
> > > 
> > > https://lore.kernel.org/r/20210920090729.19458953 at canb.auug.org.au/
> > 
> > Ah, indeed, thanks.
> > 
> > What's the typical fix for these errors?
> > 
> > I guess adding a depends on ARM || ARM64 || COMPILE_TEST would work?
> 
> I think the typical fix from most people is marking these functions as
> __maybe_unused so that they are always defined but the compiler does not
> warn. An alternative would be changing the "select PM" to be
> "depends on PM" I believe but that is less frequent.

Thanks for the suggestion. Since those functions are always going to be
used anyway (but on COMPILE_TEST), I've chosen the opposite approach of
dropping SET_RUNTIME_PM_OPS instead. You're in CC of that patch so feel
free to comment there if you think this is wrong.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210923/524a61a6/attachment.sig>
