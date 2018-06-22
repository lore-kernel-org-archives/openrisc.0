From: Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 22 Jun 2018 10:01:25 -0700
Subject: [OpenRISC] [PATCH 4/5] openrisc: Use the new
	GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <20180622170126.6308-1-palmer@sifive.com>
References: <20180621181756.12493-1-palmer@sifive.com>
 <20180622170126.6308-1-palmer@sifive.com>
Message-ID: <20180622170126.6308-5-palmer@sifive.com>
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
 arch/openrisc/Kconfig           | 5 +----
 arch/openrisc/include/asm/irq.h | 2 --
 arch/openrisc/kernel/irq.c      | 7 -------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9ecad05bfc73..dfb6a79ba7ff 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -27,7 +27,6 @@ config OPENRISC
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select MODULES_USE_ELF_RELA
-	select MULTI_IRQ_HANDLER
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
@@ -36,6 +35,7 @@ config OPENRISC
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -69,9 +69,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool  y
 
-config MULTI_IRQ_HANDLER
-	def_bool y
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/openrisc/include/asm/irq.h b/arch/openrisc/include/asm/irq.h
index d9eee0a2b7b4..eb612b1865d2 100644
--- a/arch/openrisc/include/asm/irq.h
+++ b/arch/openrisc/include/asm/irq.h
@@ -24,6 +24,4 @@
 
 #define NO_IRQ		(-1)
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 #endif /* __ASM_OPENRISC_IRQ_H__ */
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
2.16.4

