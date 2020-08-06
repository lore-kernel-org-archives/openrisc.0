From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 6 Aug 2020 21:04:49 +0200
Subject: [OpenRISC] [PATCH v2 5/6] openrisc: signal: Fix sparse address
 space warnings
In-Reply-To: <20200805210725.310301-6-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-6-shorne@gmail.com>
Message-ID: <20200806190449.xqflhmbiiv5btusf@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 06, 2020 at 06:07:24AM +0900, Stafford Horne wrote:
> ---
>  arch/openrisc/kernel/signal.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> index 4f0754874d78..7ce0728412f6 100644
> --- a/arch/openrisc/kernel/signal.c
> +++ b/arch/openrisc/kernel/signal.c
> @@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
>  	 * then frame should be dword aligned here.  If it's
>  	 * not, then the user is trying to mess with us.
>  	 */
> -	if (((long)frame) & 3)
> +	if (((__force unsigned long)frame) & 3)
>  		goto badframe;

Same as patch 6, the __force is not needed.
  
-- Luc
