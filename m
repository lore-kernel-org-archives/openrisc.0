From: Stafford Horne <shorne@gmail.com>
Date: Thu, 21 Oct 2021 05:38:53 +0900
Subject: [OpenRISC] [PATCH] openrisc: signal: remove unused DEBUG_SIG
 macro
In-Reply-To: <20211020121637.6629-1-kda@linux-powerpc.org>
References: <20211020121637.6629-1-kda@linux-powerpc.org>
Message-ID: <YXB+XVb/mBlI5fWo@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Oct 20, 2021 at 03:16:37PM +0300, Denis Kirjanov wrote:
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> ---
>  arch/openrisc/kernel/signal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> index 1ebcff271096..99516c9191c7 100644
> --- a/arch/openrisc/kernel/signal.c
> +++ b/arch/openrisc/kernel/signal.c
> @@ -28,8 +28,6 @@
>  #include <asm/ucontext.h>
>  #include <linux/uaccess.h>
>  
> -#define DEBUG_SIG 0
> -
>  struct rt_sigframe {
>  	struct siginfo info;
>  	struct ucontext uc;

This looks ok to me.  I will queue it.

Thanks.

-Stafford
