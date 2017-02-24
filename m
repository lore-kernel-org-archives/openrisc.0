From: Jonas Bonn <jonas@southpole.se>
Date: Fri, 24 Feb 2017 10:24:31 +0100
Subject: [OpenRISC] [PATCH v4 22/24] arch/openrisc/lib/memcpy.c: use
 correct OR1200 option
In-Reply-To: <7ec3096414795682d3540c4b8020ff52b12b34a6.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
 <7ec3096414795682d3540c4b8020ff52b12b34a6.1487910170.git.shorne@gmail.com>
Message-ID: <a1ff0eac-c9a9-3019-2bff-fc0bb2bef9d7@southpole.se>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

Squash this patch into the memcpy patch in order to prevent surprises 
for anyone doing a git bisection through here.

/Jonas

On 02/24/2017 05:32 AM, Stafford Horne wrote:
> From: Valentin Rothberg <valentinrothberg@gmail.com>
>
> The Kconfig option for OR12000 is OR1K_1200.
>
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   arch/openrisc/lib/memcpy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
> index 4706f01..669887a 100644
> --- a/arch/openrisc/lib/memcpy.c
> +++ b/arch/openrisc/lib/memcpy.c
> @@ -17,7 +17,7 @@
>   
>   #include <linux/string.h>
>   
> -#ifdef CONFIG_OR1200
> +#ifdef CONFIG_OR1K_1200
>   /*
>    * Do memcpy with word copies and loop unrolling. This gives the
>    * best performance on the OR1200 and MOR1KX archirectures


