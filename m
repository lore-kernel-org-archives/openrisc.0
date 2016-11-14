From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:32 +0900
Subject: [OpenRISC] [PATCH v2 2/9] openrisc: restore all regs on rt_sigreturn
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <5c3fa1c5a426801ddf8a31730c24b749b285fab4.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Jonas Bonn <jonas@southpole.se>

Fix signal handling for when signals are handled as the result of timers
or exceptions, previous code assumed syscalls. This was noticeable with X
crashing where it uses SIGALRM.

This patch restores all regs before returning to userspace via
_resume_userspace instead of via syscall return path.

The rt_sigreturn syscall is more like a context switch than a function
call; it entails a return from one context (the signal handler) to another
(the process in question).  For a context switch like this there are
effectively no call-saved regs that remain constant across the transition.

Reported-by: Sebastian Macke <sebastian@macke.de>
Signed-off-by: Jonas Bonn <jonas@southpole.se>
Tested-by: Guenter Roeck <linux@roeck-us.net>
[shorne at gmail.com: Updated comment better reflect change and issue]

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index fec8bf9..572d223 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1101,8 +1101,16 @@ ENTRY(__sys_fork)
 	 l.addi	r3,r1,0
 
 ENTRY(sys_rt_sigreturn)
-	l.j	_sys_rt_sigreturn
+	l.jal	_sys_rt_sigreturn
 	 l.addi	r3,r1,0
+	l.sfne	r30,r0
+	l.bnf	_no_syscall_trace
+	 l.nop
+	l.jal	do_syscall_trace_leave
+	 l.addi	r3,r1,0
+_no_syscall_trace:
+	l.j	_resume_userspace
+	 l.nop
 
 /* This is a catch-all syscall for atomic instructions for the OpenRISC 1000.
  * The functions takes a variable number of parameters depending on which
-- 
2.7.4


