From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Mar 2020 06:38:49 +0900
Subject: [OpenRISC] [PATCH v2 1/3] openrisc: Convert copy_thread to
 copy_thread_tls
In-Reply-To: <20200301213851.8096-1-shorne@gmail.com>
References: <20200301213851.8096-1-shorne@gmail.com>
Message-ID: <20200301213851.8096-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is required for clone3 which passes the TLS value through a
struct rather than a register.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/kernel/process.c | 17 ++++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 1928e061ff96..5debdbe6fc35 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -14,6 +14,7 @@ config OPENRISC
 	select HANDLE_DOMAIN_IRQ
 	select GPIOLIB
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_COPY_THREAD_TLS
 	select SPARSE_IRQ
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index b06f84f6676f..5caa47f7de4f 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -117,12 +117,13 @@ void release_thread(struct task_struct *dead_task)
 extern asmlinkage void ret_from_fork(void);
 
 /*
- * copy_thread
+ * copy_thread_tls
  * @clone_flags: flags
  * @usp: user stack pointer or fn for kernel thread
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
  * @regs: CPU context to copy for userspace thread; always NULL for kthread
+ * @tls: the Thread Local Storage pointer for the new process
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
  * structures.  The first (topmost) is the userspace context of the thread.
@@ -148,8 +149,8 @@ extern asmlinkage void ret_from_fork(void);
  */
 
 int
-copy_thread(unsigned long clone_flags, unsigned long usp,
-	    unsigned long arg, struct task_struct *p)
+copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct pt_regs *userregs;
 	struct pt_regs *kregs;
@@ -179,16 +180,10 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 			userregs->sp = usp;
 
 		/*
-		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
-		 *
-		 * The kernel entry is:
-		 *	int clone (long flags, void *child_stack, int *parent_tid,
-		 *		int *child_tid, struct void *tls)
-		 *
-		 * This makes the source r7 in the kernel registers.
+		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer.
 		 */
 		if (clone_flags & CLONE_SETTLS)
-			userregs->gpr[10] = userregs->gpr[7];
+			userregs->gpr[10] = tls;
 
 		userregs->gpr[11] = 0;	/* Result from fork() */
 
-- 
2.21.0

