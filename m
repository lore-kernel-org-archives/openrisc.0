From: Stafford Horne <shorne@gmail.com>
Date: Wed, 18 Mar 2020 22:17:02 +0900
Subject: [OpenRISC] [PATCH] openrisc: Remove obsolete show_trace_task
 function
Message-ID: <20200318131703.17601-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The function show_trace_task() was removed during linux 2.5 development
and replaced with show_stack().  This was never impemented for openrisc
but must have got in via copying from another architecture.  Just remove
it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 932a8ec2b520..c11aa2e17ce0 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -55,13 +55,6 @@ void show_stack(struct task_struct *task, unsigned long *esp)
 	unwind_stack(NULL, esp, print_trace);
 }
 
-void show_trace_task(struct task_struct *tsk)
-{
-	/*
-	 * TODO: SysRq-T trace dump...
-	 */
-}
-
 void show_registers(struct pt_regs *regs)
 {
 	int i;
-- 
2.21.0

