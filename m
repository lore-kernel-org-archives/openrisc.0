From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 18 Jul 2021 19:33:09 -0700
Subject: [OpenRISC] [PATCH] openrisc: don't printk() unconditionally
Message-ID: <20210719023309.15808-1-rdunlap@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Don't call printk() when CONFIG_PRINTK is not set.
Fixes the following build errors:

or1k-linux-ld: arch/openrisc/kernel/entry.o: in function `_external_irq_handler':
(.text+0x804): undefined reference to `printk'
(.text+0x804): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `printk'

Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc at lists.librecores.org
---
 arch/openrisc/kernel/entry.S |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20210716.orig/arch/openrisc/kernel/entry.S
+++ linux-next-20210716/arch/openrisc/kernel/entry.S
@@ -547,6 +547,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 	l.bnf	1f			// ext irq enabled, all ok.
 	l.nop
 
+#ifdef CONFIG_PRINTK
 	l.addi  r1,r1,-0x8
 	l.movhi r3,hi(42f)
 	l.ori	r3,r3,lo(42f)
@@ -560,6 +561,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 		.string "\n\rESR interrupt bug: in _external_irq_handler (ESR %x)\n\r"
 		.align 4
 	.previous
+#endif
 
 	l.ori	r4,r4,SPR_SR_IEE	// fix the bug
 //	l.sw	PT_SR(r1),r4
