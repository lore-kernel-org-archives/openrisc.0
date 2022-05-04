From: Stafford Horne <shorne@gmail.com>
Date: Thu, 5 May 2022 07:24:50 +0900
Subject: [PATCH] openrisc: remove bogus nops and shutdowns
In-Reply-To: <20220504110911.283525-1-Jason@zx2c4.com>
References: <20220504110911.283525-1-Jason@zx2c4.com>
Message-ID: <YnL9MuVLtiGWD2EV@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, May 04, 2022 at 01:09:11PM +0200, Jason A. Donenfeld wrote:
> Nop 42 is some leftover debugging thing by the looks of it. Nop 1 will
> shut down the simulator, which isn't what we want, since it makes it
> possible to handle errors.

Do you mean impossible to handler errors?

> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

This looks good to me, I didn't add these debug's I think we can remove them.

-Stafford

> ---
>  arch/openrisc/mm/fault.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index 80bb66ad42f6..860da58d7509 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -223,8 +223,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>  	{
>  		const struct exception_table_entry *entry;
>  
> -		__asm__ __volatile__("l.nop 42");
> -
>  		if ((entry = search_exception_tables(regs->pc)) != NULL) {
>  			/* Adjust the instruction pointer in the stackframe */
>  			regs->pc = entry->fixup;
> @@ -252,9 +250,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 */
>  
>  out_of_memory:
> -	__asm__ __volatile__("l.nop 42");
> -	__asm__ __volatile__("l.nop 1");
> -
>  	mmap_read_unlock(mm);
>  	if (!user_mode(regs))
>  		goto no_context;
> -- 
> 2.35.1
> 
