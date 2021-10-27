From: Rich Felker <dalias@libc.org>
Date: Wed, 27 Oct 2021 10:26:54 -0400
Subject: [OpenRISC] [PATCH 09/12] sh: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-10-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-10-robh@kernel.org>
Message-ID: <20211027142651.GW7074@brightrain.aerifal.cx>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 06, 2021 at 11:43:29AM -0500, Rob Herring wrote:
> Replace open coded parsing of CPU nodes' 'reg' property with
> of_get_cpu_hwid().
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/sh/boards/of-generic.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> index 921d76fc3358..f7f3e618e85b 100644
> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c
> @@ -62,9 +62,8 @@ static void sh_of_smp_probe(void)
>  	init_cpu_possible(cpumask_of(0));
>  
>  	for_each_of_cpu_node(np) {
> -		const __be32 *cell = of_get_property(np, "reg", NULL);
> -		u64 id = -1;
> -		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
> +		u64 id = of_get_cpu_hwid(np, 0);
> +
>  		if (id < NR_CPUS) {
>  			if (!method)
>  				of_property_read_string(np, "enable-method", &method);
> -- 
> 2.30.2

Acked-by: Rich Felker <dalias@libc.org>
