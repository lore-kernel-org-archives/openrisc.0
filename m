From: Eric W. Biederman <ebiederm@xmission.com>
Date: Wed, 20 Oct 2021 12:43:48 -0500
Subject: [OpenRISC] [PATCH 02/20] exit: Remove calls of do_exit after
 noreturn versions of die
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
Message-ID: <20211020174406.17889-2-ebiederm@xmission.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On nds32, openrisc, s390, sh, and xtensa the function die never
returns.  Mark die __noreturn so that no one expects die to return.
Remove the do_exit calls after die as they will never be reached.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc at lists.librecores.org
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 at vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh at vger.kernel.org
Cc: linux-xtensa at linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Fixes: 2.3.16
Fixes: 2.3.99-pre8
Fixes: 3f65ce4d141e ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 5")
Fixes: 664eec400bf8 ("nds32: MMU fault handling and page table management")
Fixes: 61e85e367535 ("OpenRISC: Memory management")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nds32/kernel/traps.c      | 2 +-
 arch/nds32/mm/fault.c          | 6 +-----
 arch/openrisc/kernel/traps.c   | 2 +-
 arch/openrisc/mm/fault.c       | 4 +---
 arch/s390/include/asm/kdebug.h | 2 +-
 arch/s390/kernel/dumpstack.c   | 2 +-
 arch/s390/mm/fault.c           | 2 --
 arch/sh/kernel/traps.c         | 2 +-
 arch/sh/mm/fault.c             | 2 --
 arch/xtensa/kernel/traps.c     | 2 +-
 arch/xtensa/mm/fault.c         | 3 +--
 11 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index f06421c645af..ca75d475eda4 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -118,7 +118,7 @@ DEFINE_SPINLOCK(die_lock);
 /*
  * This function is protected against re-entrancy.
  */
-void die(const char *str, struct pt_regs *regs, int err)
+void __noreturn die(const char *str, struct pt_regs *regs, int err)
 {
 	struct task_struct *tsk = current;
 	static int die_counter;
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index f02524eb6d56..1d139b117168 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -13,7 +13,7 @@
 
 #include <asm/tlbflush.h>
 
-extern void die(const char *str, struct pt_regs *regs, long err);
+extern void __noreturn die(const char *str, struct pt_regs *regs, long err);
 
 /*
  * This is useful to dump out the page tables associated with
@@ -299,10 +299,6 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 
 	show_pte(mm, addr);
 	die("Oops", regs, error_code);
-	bust_spinlocks(0);
-	do_exit(SIGKILL);
-
-	return;
 
 	/*
 	 * We ran out of memory, or some other thing happened to us that made
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index aa1e709405ac..0898cb159fac 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -197,7 +197,7 @@ void nommu_dump_state(struct pt_regs *regs,
 }
 
 /* This is normally the 'Oops' routine */
-void die(const char *str, struct pt_regs *regs, long err)
+void __noreturn die(const char *str, struct pt_regs *regs, long err)
 {
 
 	console_verbose();
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index c730d1a51686..f0fa6394a58e 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -32,7 +32,7 @@ unsigned long pte_errors;	/* updated by do_page_fault() */
  */
 volatile pgd_t *current_pgd[NR_CPUS];
 
-extern void die(char *, struct pt_regs *, long);
+extern void __noreturn die(char *, struct pt_regs *, long);
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -248,8 +248,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	die("Oops", regs, write_acc);
 
-	do_exit(SIGKILL);
-
 	/*
 	 * We ran out of memory, or some other thing happened to us that made
 	 * us unable to handle the page fault gracefully.
diff --git a/arch/s390/include/asm/kdebug.h b/arch/s390/include/asm/kdebug.h
index d5327f064799..4377238e4752 100644
--- a/arch/s390/include/asm/kdebug.h
+++ b/arch/s390/include/asm/kdebug.h
@@ -23,6 +23,6 @@ enum die_val {
 	DIE_NMI_IPI,
 };
 
-extern void die(struct pt_regs *, const char *);
+extern void __noreturn die(struct pt_regs *, const char *);
 
 #endif
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index db1bc00229ca..f45e66b8bed6 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -192,7 +192,7 @@ void show_regs(struct pt_regs *regs)
 
 static DEFINE_SPINLOCK(die_lock);
 
-void die(struct pt_regs *regs, const char *str)
+void __noreturn die(struct pt_regs *regs, const char *str)
 {
 	static int die_counter;
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 212632d57db9..d30f5986fa85 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -260,7 +260,6 @@ static noinline void do_no_context(struct pt_regs *regs)
 		       " in virtual user address space\n");
 	dump_fault_info(regs);
 	die(regs, "Oops");
-	do_exit(SIGKILL);
 }
 
 static noinline void do_low_address(struct pt_regs *regs)
@@ -270,7 +269,6 @@ static noinline void do_low_address(struct pt_regs *regs)
 	if (regs->psw.mask & PSW_MASK_PSTATE) {
 		/* Low-address protection hit in user mode 'cannot happen'. */
 		die (regs, "Low-address protection");
-		do_exit(SIGKILL);
 	}
 
 	do_no_context(regs);
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index e76b22157099..cbe3201d4f21 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -20,7 +20,7 @@
 
 static DEFINE_SPINLOCK(die_lock);
 
-void die(const char *str, struct pt_regs *regs, long err)
+void __noreturn die(const char *str, struct pt_regs *regs, long err)
 {
 	static int die_counter;
 
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 88a1f453d73e..1e1aa75df3ca 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -238,8 +238,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	show_fault_oops(regs, address);
 
 	die("Oops", regs, error_code);
-	bust_spinlocks(0);
-	do_exit(SIGKILL);
 }
 
 static void
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 874b6efc6fb3..fb056a191339 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -527,7 +527,7 @@ void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 
 DEFINE_SPINLOCK(die_lock);
 
-void die(const char * str, struct pt_regs * regs, long err)
+void __noreturn die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
 	const char *pr = "";
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 95a74890c7e9..fd6a70635962 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -238,7 +238,7 @@ void do_page_fault(struct pt_regs *regs)
 void
 bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
-	extern void die(const char*, struct pt_regs*, long);
+	extern void __noreturn die(const char*, struct pt_regs*, long);
 	const struct exception_table_entry *entry;
 
 	/* Are we prepared to handle this kernel fault?  */
@@ -257,5 +257,4 @@ bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 		 "address %08lx\n pc = %08lx, ra = %08lx\n",
 		 address, regs->pc, regs->areg[0]);
 	die("Oops", regs, sig);
-	do_exit(sig);
 }
-- 
2.20.1

