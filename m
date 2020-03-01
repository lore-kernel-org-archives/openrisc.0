From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Mar 2020 06:38:51 +0900
Subject: [OpenRISC] [PATCH v2 3/3] openrisc: Cleanup copy_thread_tls docs
 and comments
In-Reply-To: <20200301213851.8096-1-shorne@gmail.com>
References: <20200301213851.8096-1-shorne@gmail.com>
Message-ID: <20200301213851.8096-4-shorne@gmail.com>
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
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/openrisc/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 5caa47f7de4f..6bcdca424e11 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -122,7 +122,6 @@ extern asmlinkage void ret_from_fork(void);
  * @usp: user stack pointer or fn for kernel thread
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
- * @regs: CPU context to copy for userspace thread; always NULL for kthread
  * @tls: the Thread Local Storage pointer for the new process
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
-- 
2.21.0

