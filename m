From: Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 22 Jun 2018 10:01:24 -0700
Subject: [OpenRISC] [PATCH 3/5] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Message-ID: <20180622170126.6308-4-palmer@sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

It appears arm64 copied arm's GENERIC_IRQ_MULTI_HANDLER code, but made
it unconditional.  I wanted to make this generic so it could be used by
the RISC-V port.  This patch converts the arm64 code to use the new
generic code, which simply consists of deleting the arm64 code and
setting MULTI_IRQ_HANDLER instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/arm64/Kconfig           |  4 +---
 arch/arm64/include/asm/irq.h |  2 --
 arch/arm64/kernel/irq.c      | 10 ----------
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..3d1011957823 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -74,6 +74,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
@@ -264,9 +265,6 @@ config ARCH_SUPPORTS_UPROBES
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
-config MULTI_IRQ_HANDLER
-	def_bool y
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index a0fee6985e6a..b2b0c6405eb0 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -8,8 +8,6 @@
 
 struct pt_regs;
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 static inline int nr_legacy_irqs(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 60e5fc661f74..780a12f59a8f 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -42,16 +42,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-void (*handle_arch_irq)(struct pt_regs *) = NULL;
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	if (handle_arch_irq)
-		return;
-
-	handle_arch_irq = handle_irq;
-}
-
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
-- 
2.16.4

