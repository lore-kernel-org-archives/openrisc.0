From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 19 Sep 2021 09:40:44 -0700
Subject: [OpenRISC] [PATCH v3 1/6] drm/vc4: select PM (openrisc)
In-Reply-To: <20210819135931.895976-2-maxime@cerno.tech>
References: <20210819135931.895976-1-maxime@cerno.tech>
 <20210819135931.895976-2-maxime@cerno.tech>
Message-ID: <8a5cdcf5-33ed-398f-243a-b8889fd754e3@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 8/19/21 6:59 AM, Maxime Ripard wrote:
> We already depend on runtime PM to get the power domains and clocks for
> most of the devices supported by the vc4 driver, so let's just select it
> to make sure it's there, and remove the ifdef.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>   drivers/gpu/drm/vc4/Kconfig    | 1 +
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> index 118e8a426b1a..f774ab340863 100644
> --- a/drivers/gpu/drm/vc4/Kconfig
> +++ b/drivers/gpu/drm/vc4/Kconfig
> @@ -9,6 +9,7 @@ config DRM_VC4
>   	select DRM_KMS_CMA_HELPER
>   	select DRM_GEM_CMA_HELPER
>   	select DRM_PANEL_BRIDGE
> +	select PM
>   	select SND_PCM
>   	select SND_PCM_ELD
>   	select SND_SOC_GENERIC_DMAENGINE_PCM
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index c2876731ee2d..602203b2d8e1 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -2107,7 +2107,6 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_PM
>   static int vc4_hdmi_runtime_suspend(struct device *dev)
>   {
>   	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
> @@ -2128,7 +2127,6 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
>   
>   	return 0;
>   }
> -#endif
>   
>   static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>   {
> 

Hi,

FYI.

This still causes a build error on arch/openrisc/ since it does not support
CONFIG_PM (it does not source "kernel/power/Kconfig" like some other arches do):

./arch/riscv/Kconfig:source "kernel/power/Kconfig"
./arch/x86/Kconfig:source "kernel/power/Kconfig"
./arch/nds32/Kconfig:source "kernel/power/Kconfig"
./arch/sh/Kconfig:source "kernel/power/Kconfig"
./arch/arc/Kconfig:source "kernel/power/Kconfig"
./arch/arm64/Kconfig:source "kernel/power/Kconfig"
./arch/xtensa/Kconfig:source "kernel/power/Kconfig"
./arch/sparc/Kconfig:source "kernel/power/Kconfig"
./arch/arm/Kconfig:source "kernel/power/Kconfig"
./arch/mips/Kconfig:source "kernel/power/Kconfig"
./arch/powerpc/Kconfig:source "kernel/power/Kconfig"
./arch/um/Kconfig:source "kernel/power/Kconfig"
./arch/ia64/Kconfig:source "kernel/power/Kconfig"

so with
CONFIG_DRM_VC4=y
# CONFIG_DRM_VC4_HDMI_CEC is not set

I still see
../drivers/gpu/drm/vc4/vc4_hdmi.c:2139:12: warning: 'vc4_hdmi_runtime_suspend' defined but not used [-Wunused-function]
  2139 | static int vc4_hdmi_runtime_suspend(struct device *dev)
       |            ^~~~~~~~~~~~~~~~~~~~~~~~


-- 
~Randy
