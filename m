From: Stafford Horne <shorne@gmail.com>
Date: Sat, 10 Jun 2017 17:13:54 +0900
Subject: [OpenRISC] [PATCH 20/35] openrisc: defconfig: Cleanup from old
 Kconfig options
In-Reply-To: <20170608161049.12421-20-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
 <20170608161049.12421-20-krzk@kernel.org>
Message-ID: <20170610081354.GA6190@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jun 08, 2017 at 06:10:31PM +0200, Krzysztof Kozlowski wrote:
> Remove old, dead Kconfig option INET_LRO. It is gone since
> commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/openrisc/configs/or1ksim_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index eb3fc581cf20..a73aa90501be 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -23,7 +23,6 @@ CONFIG_INET=y
>  # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
>  # CONFIG_INET_XFRM_MODE_TUNNEL is not set
>  # CONFIG_INET_XFRM_MODE_BEET is not set
> -# CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set

Thanks, please let me know if you want me to take this, but it looks like
you plan to push the whole series in via another route.

Acked-by: Stafford Horne <shorne@gmail.com>
