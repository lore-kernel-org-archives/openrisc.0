From: Lee Jones <lee.jones@linaro.org>
Date: Thu,  9 Sep 2021 13:04:19 +0100
Subject: [OpenRISC] [PATCH v2 1/3] arch: Export machine_restart() instances
 so they can be called from modules
In-Reply-To: <20210909120421.1313908-1-lee.jones@linaro.org>
References: <20210909120421.1313908-1-lee.jones@linaro.org>
Message-ID: <20210909120421.1313908-2-lee.jones@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

A recent attempt to convert the Power Reset Restart driver to tristate
failed because of the following compile error (reported once merged by
Stephen Rothwell via Linux Next):

  ERROR: "machine_restart" [drivers/power/reset/restart-poweroff.ko] undefined!

This error occurs since some of the machine_restart() instances are
not currently exported for use in modules.  This patch aims to rectify
that.

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Will Deacon <will@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: John Crispin <john@phrozen.org>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Rich Felker <dalias@libc.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-snps-arc at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-csky at vger.kernel.org
Cc: uclinux-h8-devel at lists.sourceforge.jp
Cc: linux-hexagon at vger.kernel.org
Cc: linux-m68k at lists.linux-m68k.org
Cc: linux-mips at vger.kernel.org
Cc: openrisc at lists.librecores.org
Cc: linux-parisc at vger.kernel.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-riscv at lists.infradead.org
Cc: linux-s390 at vger.kernel.org
Cc: linux-sh at vger.kernel.org
Cc: sparclinux at vger.kernel.org
Cc: linux-um at lists.infradead.org
Cc: linux-xtensa at linux-xtensa.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/arc/kernel/reset.c            | 1 +
 arch/arm/kernel/reboot.c           | 1 +
 arch/arm64/kernel/process.c        | 1 +
 arch/csky/kernel/power.c           | 1 +
 arch/h8300/kernel/process.c        | 1 +
 arch/hexagon/kernel/reset.c        | 1 +
 arch/m68k/kernel/process.c         | 1 +
 arch/microblaze/kernel/reset.c     | 1 +
 arch/mips/kernel/reset.c           | 1 +
 arch/mips/lantiq/falcon/reset.c    | 1 +
 arch/mips/sgi-ip27/ip27-reset.c    | 1 +
 arch/nds32/kernel/process.c        | 2 +-
 arch/nios2/kernel/process.c        | 1 +
 arch/openrisc/kernel/process.c     | 1 +
 arch/parisc/kernel/process.c       | 1 +
 arch/powerpc/kernel/setup-common.c | 1 +
 arch/riscv/kernel/reset.c          | 1 +
 arch/s390/kernel/setup.c           | 1 +
 arch/sh/kernel/reboot.c            | 1 +
 arch/sparc/kernel/process_32.c     | 1 +
 arch/sparc/kernel/reboot.c         | 1 +
 arch/um/kernel/reboot.c            | 1 +
 arch/x86/kernel/reboot.c           | 1 +
 arch/xtensa/kernel/setup.c         | 1 +
 24 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arc/kernel/reset.c b/arch/arc/kernel/reset.c
index fd6c3eb930bad..1f5d8ce532e2f 100644
--- a/arch/arc/kernel/reset.c
+++ b/arch/arc/kernel/reset.c
@@ -20,6 +20,7 @@ void machine_restart(char *__unused)
 	pr_info("Put your restart handler here\n");
 	machine_halt();
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3044fcb8d0736..95cdcb17251af 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -146,3 +146,4 @@ void machine_restart(char *cmd)
 	printk("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c8989b999250d..d7557f649dbd6 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -148,6 +148,7 @@ void machine_restart(char *cmd)
 	printk("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 #define bstr(suffix, str) [PSR_BTYPE_ ## suffix >> PSR_BTYPE_SHIFT] = str
 static const char *const btypes[] = {
diff --git a/arch/csky/kernel/power.c b/arch/csky/kernel/power.c
index 923ee4e381b81..1787de5b13ba6 100644
--- a/arch/csky/kernel/power.c
+++ b/arch/csky/kernel/power.c
@@ -28,3 +28,4 @@ void machine_restart(char *cmd)
 	do_kernel_restart(cmd);
 	asm volatile ("bkpt");
 }
+EXPORT_SYMBOL_GPL(machine_restart);
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 2ac27e4248a46..f92f473a1934a 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -66,6 +66,7 @@ void machine_restart(char *__unused)
 	local_irq_disable();
 	__asm__("jmp @@0");
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/hexagon/kernel/reset.c b/arch/hexagon/kernel/reset.c
index da36114d928f0..ed79e0e5a0318 100644
--- a/arch/hexagon/kernel/reset.c
+++ b/arch/hexagon/kernel/reset.c
@@ -19,6 +19,7 @@ void machine_halt(void)
 void machine_restart(char *cmd)
 {
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void (*pm_power_off)(void) = NULL;
 EXPORT_SYMBOL(pm_power_off);
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index db49f90917112..f891d9b4bdf2f 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -57,6 +57,7 @@ void machine_restart(char * __unused)
 		mach_reset();
 	for (;;);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/reset.c
index 5f4722908164d..7f47e59914c0d 100644
--- a/arch/microblaze/kernel/reset.c
+++ b/arch/microblaze/kernel/reset.c
@@ -41,3 +41,4 @@ void machine_restart(char *cmd)
 	pr_emerg("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 6288780b779e7..4fe2edc2d06d6 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -99,6 +99,7 @@ void machine_restart(char *command)
 	pr_emerg("Reboot failed -- System halted\n");
 	machine_hang();
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
index 261996c230cf6..70259dd09aaea 100644
--- a/arch/mips/lantiq/falcon/reset.c
+++ b/arch/mips/lantiq/falcon/reset.c
@@ -51,6 +51,7 @@ static void machine_restart(char *command)
 		(void *)WDT_REG_BASE);
 	unreachable();
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 static void machine_halt(void)
 {
diff --git a/arch/mips/sgi-ip27/ip27-reset.c b/arch/mips/sgi-ip27/ip27-reset.c
index 5ac5ad6387343..35084653022ea 100644
--- a/arch/mips/sgi-ip27/ip27-reset.c
+++ b/arch/mips/sgi-ip27/ip27-reset.c
@@ -29,6 +29,7 @@
 #include "ip27-common.h"
 
 void machine_restart(char *command) __noreturn;
+EXPORT_SYMBOL_GPL(machine_restart);
 void machine_halt(void) __noreturn;
 void machine_power_off(void) __noreturn;
 
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 391895b54d13c..f60b70fcfaf3d 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -91,7 +91,7 @@ void machine_restart(char *cmd)
 	while (1) ;
 }
 
-EXPORT_SYMBOL(machine_restart);
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void show_regs(struct pt_regs *regs)
 {
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 9ff37ba2bb603..ebc4940059de5 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -51,6 +51,7 @@ void machine_restart(char *__unused)
 	: "r" (cpuinfo.reset_addr)
 	: "r4");
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index eb62429681fc8..fba2aa6ae8470 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -61,6 +61,7 @@ void machine_restart(char *cmd)
 	pr_emerg("Reboot failed -- System halted\n");
 	while (1);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 /*
  * Similar to machine_power_off, but don't shut off power.  Add code
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 184ec3c1eae44..f39f7620d715d 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -96,6 +96,7 @@ void machine_restart(char *cmd)
 	while (1) ;
 
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void (*chassis_power_off)(void);
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index aa9c2d01424af..dfd875d4f8478 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -158,6 +158,7 @@ void machine_restart(char *cmd)
 
 	machine_hang();
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index ee5878d968cc1..5fd0aa3e12766 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -20,6 +20,7 @@ void machine_restart(char *cmd)
 	do_kernel_restart(cmd);
 	while (1);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index ff0f9e8389162..ce8afa1cf8645 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -278,6 +278,7 @@ void machine_restart(char *command)
 		console_unblank();
 	_machine_restart(command);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 5c33f036418be..ea4b1bdada41a 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -83,6 +83,7 @@ void machine_restart(char *cmd)
 {
 	machine_ops.restart(cmd);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 93983d6d431de..de9106e386919 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -104,6 +104,7 @@ void machine_restart(char * cmd)
 	prom_feval ("reset");
 	panic("Reboot failed!");
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/sparc/kernel/reboot.c b/arch/sparc/kernel/reboot.c
index 69c1b6c047d53..faebf958c4b5a 100644
--- a/arch/sparc/kernel/reboot.c
+++ b/arch/sparc/kernel/reboot.c
@@ -52,4 +52,5 @@ void machine_restart(char *cmd)
 	prom_reboot("");
 	panic("Reboot failed!");
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 48c0610d506e0..7ca141cf4a0af 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -47,6 +47,7 @@ void machine_restart(char * __unused)
 	uml_cleanup();
 	reboot_skas();
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_power_off(void)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index ebfb911082326..d378e80a60a1b 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -733,6 +733,7 @@ static void native_machine_restart(char *__unused)
 		machine_shutdown();
 	__machine_emergency_restart(0);
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 static void native_machine_halt(void)
 {
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index ed184106e4cf9..a70c1351cd59e 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -564,6 +564,7 @@ void machine_restart(char * cmd)
 {
 	platform_restart();
 }
+EXPORT_SYMBOL_GPL(machine_restart);
 
 void machine_halt(void)
 {
-- 
2.33.0.153.gba50c8fa24-goog

