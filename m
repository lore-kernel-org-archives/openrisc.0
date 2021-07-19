From: Stafford Horne <shorne@gmail.com>
Date: Mon, 19 Jul 2021 13:38:13 +0900
Subject: [OpenRISC] [PATCH] openrisc: don't printk() unconditionally
In-Reply-To: <20210719023309.15808-1-rdunlap@infradead.org>
References: <20210719023309.15808-1-rdunlap@infradead.org>
Message-ID: <YPUBtf2OvD9Y017n@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Jul 18, 2021 at 07:33:09PM -0700, Randy Dunlap wrote:
> Don't call printk() when CONFIG_PRINTK is not set.
> Fixes the following build errors:
> 
> or1k-linux-ld: arch/openrisc/kernel/entry.o: in function `_external_irq_handler':
> (.text+0x804): undefined reference to `printk'
> (.text+0x804): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `printk'
> 
> Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

This looks OK to me, I will queue it for 5.15 unless anyone thinks it should go
in now.

-Stafford

> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc at lists.librecores.org
> ---
>  arch/openrisc/kernel/entry.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20210716.orig/arch/openrisc/kernel/entry.S
> +++ linux-next-20210716/arch/openrisc/kernel/entry.S
> @@ -547,6 +547,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
>  	l.bnf	1f			// ext irq enabled, all ok.
>  	l.nop
>  
> +#ifdef CONFIG_PRINTK
>  	l.addi  r1,r1,-0x8
>  	l.movhi r3,hi(42f)
>  	l.ori	r3,r3,lo(42f)
> @@ -560,6 +561,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
>  		.string "\n\rESR interrupt bug: in _external_irq_handler (ESR %x)\n\r"
>  		.align 4
>  	.previous
> +#endif
>  
>  	l.ori	r4,r4,SPR_SR_IEE	// fix the bug
>  //	l.sw	PT_SR(r1),r4
