From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Wed, 14 Apr 2021 16:58:08 +0800
Subject: [OpenRISC] [PATCH] init: consolidate trap_init()
Message-ID: <20210414165808.458a3d11@xhacker.debian>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Many architectures implement the trap_init() as NOP, since there is
no such default for trap_init(), this empty stub is duplicated among
these architectures. Provide a generic but weak NOP implementation
to drop the empty stubs of trap_init() in these architectures.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arc/kernel/traps.c      |  5 -----
 arch/arm/kernel/traps.c      |  5 -----
 arch/h8300/kernel/traps.c    | 13 -------------
 arch/hexagon/kernel/traps.c  |  4 ----
 arch/nds32/kernel/traps.c    |  5 -----
 arch/nios2/kernel/traps.c    |  5 -----
 arch/openrisc/kernel/traps.c |  5 -----
 arch/parisc/kernel/traps.c   |  4 ----
 arch/powerpc/kernel/traps.c  |  5 -----
 arch/riscv/kernel/traps.c    |  5 -----
 arch/um/kernel/trap.c        |  4 ----
 init/main.c                  |  2 ++
 12 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index 57235e5c0cea..6b83e3f2b41c 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -20,11 +20,6 @@
 #include <asm/unaligned.h>
 #include <asm/kprobes.h>
 
-void __init trap_init(void)
-{
-	return;
-}
-
 void die(const char *str, struct pt_regs *regs, unsigned long address)
 {
 	show_kernel_fault_diag(str, regs, address);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 17d5a785df28..9baccef20392 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -780,11 +780,6 @@ void abort(void)
 	panic("Oops failed to kill thread");
 }
 
-void __init trap_init(void)
-{
-	return;
-}
-
 #ifdef CONFIG_KUSER_HELPERS
 static void __init kuser_init(void *vectors)
 {
diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index 5d8b969cd8f3..c3a3ebf77fbb 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -30,19 +30,6 @@
 
 static DEFINE_SPINLOCK(die_lock);
 
-/*
- * this must be called very early as the kernel might
- * use some instruction that are emulated on the 060
- */
-
-void __init base_trap_init(void)
-{
-}
-
-void __init trap_init(void)
-{
-}
-
 asmlinkage void set_esp0(unsigned long ssp)
 {
 	current->thread.esp0 = ssp;
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 904134b37232..edfc35dafeb1 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -28,10 +28,6 @@
 #define TRAP_SYSCALL	1
 #define TRAP_DEBUG	0xdb
 
-void __init trap_init(void)
-{
-}
-
 #ifdef CONFIG_GENERIC_BUG
 /* Maybe should resemble arch/sh/kernel/traps.c ?? */
 int is_valid_bugaddr(unsigned long addr)
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index ee0d9ae192a5..f06421c645af 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -183,11 +183,6 @@ void __pgd_error(const char *file, int line, unsigned long val)
 }
 
 extern char *exception_vector, *exception_vector_end;
-void __init trap_init(void)
-{
-	return;
-}
-
 void __init early_trap_init(void)
 {
 	unsigned long ivb = 0;
diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index b172da4eb1a9..596986a74a26 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -105,11 +105,6 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 	printk("%s\n", loglvl);
 }
 
-void __init trap_init(void)
-{
-	/* Nothing to do here */
-}
-
 /* Breakpoint handler */
 asmlinkage void breakpoint_c(struct pt_regs *fp)
 {
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 4d61333c2623..aa1e709405ac 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -231,11 +231,6 @@ void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 	die("Oops", regs, 9);
 }
 
-void __init trap_init(void)
-{
-	/* Nothing needs to be done */
-}
-
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
 	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 8d8441d4562a..747c328fb886 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -859,7 +859,3 @@ void  __init early_trap_init(void)
 
 	initialize_ivt(&fault_vector_20);
 }
-
-void __init trap_init(void)
-{
-}
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a44a30b0688c..e952bee89684 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2207,11 +2207,6 @@ DEFINE_INTERRUPT_HANDLER(kernel_bad_stack)
 	die("Bad kernel stack pointer", regs, SIGABRT);
 }
 
-void __init trap_init(void)
-{
-}
-
-
 #ifdef CONFIG_PPC_EMULATED_STATS
 
 #define WARN_EMULATED_SETUP(type)	.type = { .name = #type }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0879b5df11b9..b3f3d84de779 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -194,8 +194,3 @@ int is_valid_bugaddr(unsigned long pc)
 		return ((insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16);
 }
 #endif /* CONFIG_GENERIC_BUG */
-
-/* stvec & scratch is already set from head.S */
-void trap_init(void)
-{
-}
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index ad12f78bda7e..3198c4767387 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -311,7 +311,3 @@ void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	do_IRQ(WINCH_IRQ, regs);
 }
-
-void trap_init(void)
-{
-}
diff --git a/init/main.c b/init/main.c
index 53b278845b88..4bdbe2928530 100644
--- a/init/main.c
+++ b/init/main.c
@@ -790,6 +790,8 @@ static inline void initcall_debug_enable(void)
 }
 #endif
 
+void __init __weak trap_init(void) { }
+
 /* Report memory auto-initialization states for this boot. */
 static void __init report_meminit(void)
 {
-- 
2.31.0

