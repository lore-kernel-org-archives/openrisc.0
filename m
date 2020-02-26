From: Stafford Horne <shorne@gmail.com>
Date: Thu, 27 Feb 2020 07:56:25 +0900
Subject: [OpenRISC] [PATCH 3/3] openrisc: Cleanup copy_thread_tls docs and
 comments
In-Reply-To: <20200226225625.28935-1-shorne@gmail.com>
References: <20200226225625.28935-1-shorne@gmail.com>
Message-ID: <20200226225625.28935-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Previously copy_thread_tls was copy_thread and before that something
else.  Remove the documentation about the regs parameter that didn't
exist in either version.

Next, fix comment wrapping and details about how TLS pointer gets to the
copy_thread_tls function.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 6695f167e126..b442e7b59e17 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -122,7 +122,6 @@ extern asmlinkage void ret_from_fork(void);
  * @usp: user stack pointer or fn for kernel thread
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
- * @regs: CPU context to copy for userspace thread; always NULL for kthread
  * @tls: the Thread Local Storate pointer for the new process
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
@@ -180,7 +179,8 @@ copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 			userregs->sp = usp;
 
 		/*
-		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
+		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed
+		 * in clone_args to sys_clone3.
 		 */
 		if (clone_flags & CLONE_SETTLS)
 			userregs->gpr[10] = tls;
-- 
2.21.0

