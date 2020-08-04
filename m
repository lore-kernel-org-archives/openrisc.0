From: Stafford Horne <shorne@gmail.com>
Date: Tue,  4 Aug 2020 13:23:53 +0900
Subject: [OpenRISC] [PATCH 5/6] openrisc: signal: Fix sparse address space
 warnings
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
Message-ID: <20200804042354.3930694-6-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The __user annotations in signal.c were mostly missing.  The missing
annotations caused the warnings listed below.  This patch fixes them up
by adding the __user annotations.

arch/openrisc/kernel/signal.c:71:38: warning: incorrect type in initializer (different address spaces)
arch/openrisc/kernel/signal.c:71:38:    expected struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:71:38:    got struct rt_sigframe [noderef] __user *
arch/openrisc/kernel/signal.c:82:14: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:82:14:    expected void const volatile [noderef] __user *
arch/openrisc/kernel/signal.c:82:14:    got struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:84:37: warning: incorrect type in argument 2 (different address spaces)
arch/openrisc/kernel/signal.c:84:37:    expected void const [noderef] __user *from
arch/openrisc/kernel/signal.c:84:37:    got struct sigset_t *
arch/openrisc/kernel/signal.c:89:39: warning: incorrect type in argument 2 (different address spaces)
arch/openrisc/kernel/signal.c:89:39:    expected struct sigcontext [noderef] __user *sc
arch/openrisc/kernel/signal.c:89:39:    got struct sigcontext *
arch/openrisc/kernel/signal.c:92:31: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:92:31:    expected struct sigaltstack const [noderef] [usertype] __user *
arch/openrisc/kernel/signal.c:92:31:    got struct sigaltstack *
arch/openrisc/kernel/signal.c:158:15: warning: incorrect type in assignment (different address spaces)
arch/openrisc/kernel/signal.c:158:15:    expected struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:158:15:    got void [noderef] __user *
arch/openrisc/kernel/signal.c:160:14: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:160:14:    expected void const volatile [noderef] __user *
arch/openrisc/kernel/signal.c:160:14:    got struct rt_sigframe *frame
arch/openrisc/kernel/signal.c:165:46: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:165:46:    expected struct siginfo [noderef] [usertype] __user *to
arch/openrisc/kernel/signal.c:165:46:    got struct siginfo *
arch/openrisc/kernel/signal.c:170:33: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:170:33:    expected struct sigaltstack [noderef] [usertype] __user *
arch/openrisc/kernel/signal.c:170:33:    got struct sigaltstack *
arch/openrisc/kernel/signal.c:171:40: warning: incorrect type in argument 2 (different address spaces)
arch/openrisc/kernel/signal.c:171:40:    expected struct sigcontext [noderef] __user *sc
arch/openrisc/kernel/signal.c:171:40:    got struct sigcontext *
arch/openrisc/kernel/signal.c:173:32: warning: incorrect type in argument 1 (different address spaces)
arch/openrisc/kernel/signal.c:173:32:    expected void [noderef] __user *to
arch/openrisc/kernel/signal.c:173:32:    got struct sigset_t *

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/signal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 4f0754874d78..7ce0728412f6 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -68,7 +68,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 
 asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
 {
-	struct rt_sigframe *frame = (struct rt_sigframe __user *)regs->sp;
+	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)regs->sp;
 	sigset_t set;
 
 	/*
@@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
 	 * then frame should be dword aligned here.  If it's
 	 * not, then the user is trying to mess with us.
 	 */
-	if (((long)frame) & 3)
+	if (((__force unsigned long)frame) & 3)
 		goto badframe;
 
 	if (!access_ok(frame, sizeof(*frame)))
@@ -151,7 +151,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
 static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs)
 {
-	struct rt_sigframe *frame;
+	struct rt_sigframe __user *frame;
 	unsigned long return_ip;
 	int err = 0;
 
@@ -181,10 +181,10 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		l.ori r11,r0,__NR_sigreturn
 		l.sys 1
 	 */
-	err |= __put_user(0xa960,             (short *)(frame->retcode + 0));
-	err |= __put_user(__NR_rt_sigreturn,  (short *)(frame->retcode + 2));
-	err |= __put_user(0x20000001, (unsigned long *)(frame->retcode + 4));
-	err |= __put_user(0x15000000, (unsigned long *)(frame->retcode + 8));
+	err |= __put_user(0xa960,             (short __user *)(frame->retcode + 0));
+	err |= __put_user(__NR_rt_sigreturn,  (short __user *)(frame->retcode + 2));
+	err |= __put_user(0x20000001, (unsigned long __user *)(frame->retcode + 4));
+	err |= __put_user(0x15000000, (unsigned long __user *)(frame->retcode + 8));
 
 	if (err)
 		return -EFAULT;
-- 
2.26.2

