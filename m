From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Mon, 21 Feb 2022 14:24:56 +0100
Subject: [OpenRISC] [PATCH v2 09/18] mips: use simpler access_ok()
In-Reply-To: <20220216131332.1489939-10-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-10-arnd@kernel.org>
Message-ID: <20220221132456.GA7139@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> 
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> index db9a8e002b62..d7c89dc3426c 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -19,6 +19,7 @@
>  #ifdef CONFIG_32BIT
>  
>  #define __UA_LIMIT 0x80000000UL
> +#define TASK_SIZE_MAX	__UA_LIMIT
>  
>  #define __UA_ADDR	".word"
>  #define __UA_LA		"la"
> @@ -33,6 +34,7 @@
>  extern u64 __ua_limit;
>  
>  #define __UA_LIMIT	__ua_limit
> +#define TASK_SIZE_MAX	XKSSEG

this doesn't work. For every access above maximum implemented virtual address
space of the CPU an address error will be issued, but not a TLB miss.
And address error isn't able to handle this situation.

With this patch

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index df4b708c04a9..3911f1481f3d 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -1480,6 +1480,13 @@ asmlinkage void do_ade(struct pt_regs *regs)
 	prev_state = exception_enter();
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
 			1, regs, regs->cp0_badvaddr);
+
+	/* Are we prepared to handle this kernel fault?	 */
+	if (fixup_exception(regs)) {
+		current->thread.cp0_baduaddr = regs->cp0_badvaddr;
+		return;
+	}
+
 	/*
 	 * Did we catch a fault trying to load an instruction?
 	 */

I at least get my simple test cases fixed, but I'm not sure this is
correct.

Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
for the 32bit case ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
