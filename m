From: Stafford Horne <shorne@gmail.com>
Date: Mon, 15 May 2017 22:31:26 +0900
Subject: [OpenRISC] [PATCH] openrisc: explicitly include linux/bug.h in
	asm/fixmap.h
In-Reply-To: <20170515101451.27973-1-tklauser@distanz.ch>
References: <20170515101451.27973-1-tklauser@distanz.ch>
Message-ID: <20170515133126.GB2440@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, May 15, 2017 at 12:14:51PM +0200, Tobias Klauser wrote:
> openrisc's asm/fixmap.h uses the BUG() and BUG_ON() macros but relies on
> implict inclusion of linux/bug.h which means that changes in other
> headers could break the build. Thus, add an explicit include.

Thanks, I have applied it.

> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  arch/openrisc/include/asm/fixmap.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
> index 52733416c1f3..5a0159546f9e 100644
> --- a/arch/openrisc/include/asm/fixmap.h
> +++ b/arch/openrisc/include/asm/fixmap.h
> @@ -27,6 +27,7 @@
>  #define FIXADDR_TOP	((unsigned long) (-2*PAGE_SIZE))
>  
>  #include <linux/kernel.h>
> +#include <linux/bug.h>
>  #include <asm/page.h>
>  
>  /*
> -- 
> 2.13.0
> 
> 
