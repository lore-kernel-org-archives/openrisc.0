From: Eric W. Biederman <ebiederm@xmission.com>
Date: Wed, 20 Oct 2021 16:51:52 -0500
Subject: [OpenRISC] [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV)
 with force_fatal_sig(SIGSEGV)
In-Reply-To: <87y26nmwkb.fsf@disp2133> (Eric W. Biederman's message of "Wed,
 20 Oct 2021 12:32:20 -0500")
References: <87y26nmwkb.fsf@disp2133>
Message-ID: <877de7jrev.fsf@disp2133>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


Now that force_fatal_sig exists it is unnecessary and a bit confusing
to use force_sigsegv in cases where the simpler force_fatal_sig is
wanted.  So change every instance we can to make the code clearer.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/kernel/process.c       | 2 +-
 arch/m68k/kernel/traps.c        | 2 +-
 arch/powerpc/kernel/signal_32.c | 2 +-
 arch/powerpc/kernel/signal_64.c | 4 ++--
 arch/s390/kernel/traps.c        | 2 +-
 arch/um/kernel/trap.c           | 2 +-
 arch/x86/kernel/vm86_32.c       | 2 +-
 fs/exec.c                       | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 3793876f42d9..8e90052f6f05 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -294,7 +294,7 @@ int elf_check_arch(const struct elf32_hdr *x)
 	eflags = x->e_flags;
 	if ((eflags & EF_ARC_OSABI_MSK) != EF_ARC_OSABI_CURRENT) {
 		pr_err("ABI mismatch - you need newer toolchain\n");
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return 0;
 	}
 
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 5b19fcdcd69e..74045d164ddb 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1150,7 +1150,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	force_sigsegv(SIGSEGV);
+	force_fatal_sig(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 666f3da41232..933ab95805a6 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1063,7 +1063,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 	if (do_setcontext(new_ctx, regs, 0)) {
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return -EFAULT;
 	}
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index d8de622c9e4a..8ead9b3f47c6 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -704,7 +704,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 */
 
 	if (__get_user_sigset(&set, &new_ctx->uc_sigmask)) {
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return -EFAULT;
 	}
 	set_current_blocked(&set);
@@ -713,7 +713,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		return -EFAULT;
 	if (__unsafe_restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext)) {
 		user_read_access_end();
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 		return -EFAULT;
 	}
 	user_read_access_end();
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 51729ea2cf8e..01a7c68dcfb6 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		report_user_fault(regs, SIGSEGV, 0);
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 	} else
 		die(regs, "Unknown program exception");
 }
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 3198c4767387..c32efb09db21 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -158,7 +158,7 @@ static void bad_segv(struct faultinfo fi, unsigned long ip)
 
 void fatal_sigsegv(void)
 {
-	force_sigsegv(SIGSEGV);
+	force_fatal_sig(SIGSEGV);
 	do_signal(&current->thread.regs);
 	/*
 	 * This is to tell gcc that we're not returning - do_signal
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 040fd01be8b3..7ff0f622abd4 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -159,7 +159,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	user_access_end();
 Efault:
 	pr_alert("could not access userspace vm86 info\n");
-	force_sigsegv(SIGSEGV);
+	force_fatal_sig(SIGSEGV);
 }
 
 static int do_vm86_irq_handling(int subfunction, int irqnumber);
diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..ac7b51b51f38 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1852,7 +1852,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	 * SIGSEGV.
 	 */
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
-		force_sigsegv(SIGSEGV);
+		force_fatal_sig(SIGSEGV);
 
 out_unmark:
 	current->fs->in_exec = 0;
-- 
2.20.1

