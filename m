From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:33 +0900
Subject: [OpenRISC] [PATCH v2 3/9] openrisc: Add thread-local storage (TLS)
	support
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <36386b99c1c0aa9161b25602f0873116ed3adcf8.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Christian Svensson <blue@cmd.nu>

Historically OpenRISC GCC has reserved r10 which we now use to hold
the thread pointer for thread-local storage (TLS).

Signed-off-by: Christian Svensson <blue@cmd.nu>
Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/openrisc/kernel/process.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 7095dfe..277123b 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -173,6 +173,19 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 
 		if (usp)
 			userregs->sp = usp;
+
+		/*
+		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
+		 *
+		 * The kernel entry is:
+		 *	int clone (long flags, void *child_stack, int *parent_tid,
+		 *		int *child_tid, struct void *tls)
+		 *
+		 * This makes the source r7 in the kernel registers.
+		 */
+		if (clone_flags & CLONE_SETTLS)
+			userregs->gpr[10] = userregs->gpr[7];
+
 		userregs->gpr[11] = 0;	/* Result from fork() */
 
 		kregs->gpr[20] = 0;	/* Userspace thread */
-- 
2.7.4


