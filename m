From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 20 Sep 2021 18:42:05 +0200
Subject: [OpenRISC] [PATCH 4.19 163/293] openrisc: dont printk()
 unconditionally
In-Reply-To: <20210920163933.258815435@linuxfoundation.org>
References: <20210920163933.258815435@linuxfoundation.org>
Message-ID: <20210920163938.864152614@linuxfoundation.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 946e1052cdcc7e585ee5d1e72528ca49fb295243 ]

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
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 01b59d2ce174..c2c3ce8a0f84 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -551,6 +551,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 	l.bnf	1f			// ext irq enabled, all ok.
 	l.nop
 
+#ifdef CONFIG_PRINTK
 	l.addi  r1,r1,-0x8
 	l.movhi r3,hi(42f)
 	l.ori	r3,r3,lo(42f)
@@ -564,6 +565,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 		.string "\n\rESR interrupt bug: in _external_irq_handler (ESR %x)\n\r"
 		.align 4
 	.previous
+#endif
 
 	l.ori	r4,r4,SPR_SR_IEE	// fix the bug
 //	l.sw	PT_SR(r1),r4
-- 
2.30.2



