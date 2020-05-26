From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 26 May 2020 18:13:34 +0100
Subject: [OpenRISC] [PATCH v2 05/20] mm: use free_area_init() instead of
 free_area_init_nodes()
In-Reply-To: <20200429121126.17989-6-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-6-rppt@kernel.org>
Message-ID: <20200526171334.GK17051@gaia>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Apr 29, 2020 at 03:11:11PM +0300, Mike Rapoport wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e42727e3568e..a650adb358ee 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -206,7 +206,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  #endif
>  	max_zone_pfns[ZONE_NORMAL] = max;
>  
> -	free_area_init_nodes(max_zone_pfns);
> +	free_area_init(max_zone_pfns);
>  }

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
