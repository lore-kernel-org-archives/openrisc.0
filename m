From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 13 Dec 2017 15:15:44 +0900
Subject: [OpenRISC] [PATCH] openrisc: Fix conflicting types for _exext
	and _stext
In-Reply-To: <20171213034212.25910-1-joel@jms.id.au>
References: <20171213034212.25910-1-joel@jms.id.au>
Message-ID: <20171213061544.GA738@jagdpanzerIV>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On (12/13/17 14:12), Joel Stanley wrote:
> The printk tree in linux-next has a patch "symbol lookup: introduce
> dereference_symbol_descriptor()" that includes sections.h in kallsyms.h,
> so arch/openrisc/kernel/traps.c gets a second extern definition for
> _etext and _stext.
> 
> Remove the local definitions and include sections.h directly in
> preparation for the kallsyms.h change.
> 
> This fixes the following (future) build error:
> 
>   CC      arch/openrisc/kernel/traps.o
> arch/openrisc/kernel/traps.c:43:13: error: conflicting types for ‘_etext’
>  extern char _etext, _stext;
>              ^
> In file included from ./arch/openrisc/include/generated/asm/sections.h:1:0,
>                  from ./include/linux/kallsyms.h:15,
>                  from arch/openrisc/kernel/traps.c:35:
> ./include/asm-generic/sections.h:35:32: note: previous declaration of ‘_etext’ was here
>  extern char _text[], _stext[], _etext[];
>                                 ^
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

FWIW, looks good to me,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

> ---
>  arch/openrisc/kernel/traps.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
> index 4085d72fa5ae..5fb6d512502d 100644
> --- a/arch/openrisc/kernel/traps.c
> +++ b/arch/openrisc/kernel/traps.c
> @@ -39,8 +39,7 @@
>  #include <asm/io.h>
>  #include <asm/pgtable.h>
>  #include <asm/unwinder.h>
> -
> -extern char _etext, _stext;
> +#include <asm/sections.h>
>  
>  int kstack_depth_to_print = 0x180;
>  int lwa_flag;
> -- 
> 2.14.1
> 
