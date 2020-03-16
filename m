From: Dmitry Safonov <dima@arista.com>
Date: Mon, 16 Mar 2020 14:38:50 +0000
Subject: [OpenRISC] [PATCHv2 24/50] openrisc: Add show_stack_loglvl()
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
Message-ID: <20200316143916.195608-25-dima@arista.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc at lists.librecores.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima at arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/openrisc/kernel/traps.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 932a8ec2b520..9d5a85dd1992 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -41,18 +41,26 @@ unsigned long __user *lwa_addr;
 
 void print_trace(void *data, unsigned long addr, int reliable)
 {
-	pr_emerg("[<%p>] %s%pS\n", (void *) addr, reliable ? "" : "? ",
+	const char *loglvl = data;
+
+	printk("%s[<%p>] %s%pS\n", loglvl, (void *) addr, reliable ? "" : "? ",
 	       (void *) addr);
 }
 
 /* displays a short stack trace */
-void show_stack(struct task_struct *task, unsigned long *esp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
+		const char *loglvl)
 {
 	if (esp == NULL)
 		esp = (unsigned long *)&esp;
 
-	pr_emerg("Call trace:\n");
-	unwind_stack(NULL, esp, print_trace);
+	printk("%sCall trace:\n", loglvl);
+	unwind_stack((void *)loglvl, esp, print_trace);
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	show_stack_loglvl(task, esp, KERN_EMERG);
 }
 
 void show_trace_task(struct task_struct *tsk)
-- 
2.25.1

