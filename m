From: Jonas Bonn <jonas@southpole.se>
Date: Fri, 24 Feb 2017 10:21:50 +0100
Subject: [OpenRISC] [PATCH v4 24/24] openrisc: head: Init r0 to 0 on
	start
In-Reply-To: <77f7a25e10627b60b2553817f05b20ec2ec25a28.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
 <77f7a25e10627b60b2553817f05b20ec2ec25a28.1487910170.git.shorne@gmail.com>
Message-ID: <e134009d-67f4-fd37-e3bb-20b020760023@southpole.se>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/24/2017 05:32 AM, Stafford Horne wrote:
> Originally openrisc spec 0 specified that r0 would be wired to ground.
> This is no longer the case.  r0 is not guaranteed to be 0 at init, so we
> need to initialize it to 0 before using it.
>
> Also, if we are clearing r0 we cant use r0 to clear itself. Change the
> the CLEAR_GPR macro to use movhi for clearing.

Use the Reported-by: tag here since you are taking the time to mention 
him in the summary mail.

Reported-by:  Jakob...
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   arch/openrisc/kernel/head.S | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> index 573e131..e8a1784 100644
> --- a/arch/openrisc/kernel/head.S
> +++ b/arch/openrisc/kernel/head.S
> @@ -35,7 +35,7 @@
>   	l.add	rd,rd,rs
>   
>   #define CLEAR_GPR(gpr)				\
> -	l.or    gpr,r0,r0
> +	l.movhi	gpr,0x0
>   
>   #define LOAD_SYMBOL_2_GPR(gpr,symbol)		\
>   	l.movhi gpr,hi(symbol)			;\
> @@ -443,6 +443,9 @@ _dispatch_do_ipage_fault:
>   	__HEAD
>   	.global _start
>   _start:
> +	/* Init r0 to zero as per spec */
> +	CLEAR_GPR(r0)
> +
>   	/* save kernel parameters */
>   	l.or	r25,r0,r3	/* pointer to fdt */
>   


