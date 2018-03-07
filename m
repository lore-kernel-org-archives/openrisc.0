From: Palmer Dabbelt <palmer@sifive.com>
Date: Wed,  7 Mar 2018 15:57:31 -0800
Subject: [OpenRISC] [PATCH v3 5/5] openrisc: Use the new
	GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <20180307235731.22627-1-palmer@sifive.com>
References: <20180307235731.22627-1-palmer@sifive.com>
Message-ID: <20180307235731.22627-6-palmer@sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

It appears that openrisc copied arm64's GENERIC_IRQ_MULTI_HANDLER code
(which came from arm).  I wanted to make this generic so I could use it
in the RISC-V port.  This patch converts the openrisc code to use the
generic version.

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/openrisc/Kconfig      | 1 +
 arch/openrisc/kernel/irq.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 339df7324e9c..dfb6a79ba7ff 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -35,6 +35,7 @@ config OPENRISC
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index 35e478a93116..5f9445effaf8 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -41,13 +41,6 @@ void __init init_IRQ(void)
 	irqchip_init();
 }
 
-static void (*handle_arch_irq)(struct pt_regs *);
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	handle_arch_irq = handle_irq;
-}
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	handle_arch_irq(regs);
-- 
2.16.1

