From: Stafford Horne <shorne@gmail.com>
Date: Thu, 12 Nov 2020 06:23:46 +0900
Subject: [OpenRISC] [PATCH] openrisc: fix trap for debugger breakpoint
 signalling
Message-ID: <20201111212347.1504298-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I have been working on getting native Linux GDB support working for the
OpenRISC port.  The trap signal handler here was wrong in a few ways.
During trap handling address (from the EEAR register) is not set by the
CPU, so it is not correct to use here.  We want to use trap as a
break-point so use TRAP_BRKPT.  Adding 4 to the pc was incorrect and
causing GDB to think the breakpoint was not hit.

Fixing these allows GDB to work now.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 206e5325e61b..4d61333c2623 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -238,9 +238,7 @@ void __init trap_init(void)
 
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
-	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address);
-
-	regs->pc += 4;
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
 }
 
 asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
-- 
2.26.2

