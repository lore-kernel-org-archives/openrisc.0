From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 14 Feb 2022 17:34:49 +0100
Subject: [OpenRISC] [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
Message-ID: <20220214163452.1568807-12-arnd@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann <arnd@arndb.de>

sparc64 uses address space identifiers to differentiate between kernel
and user space, using ASI_P for kernel threads but ASI_AIUS for normal
user space, with the option of changing between them.

As nothing really changes the ASI any more, just hardcode ASI_AIUS
everywhere. Kernel threads are not allowed to access __user pointers
anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/Kconfig                      |  1 -
 arch/sparc/include/asm/processor_64.h   |  4 ----
 arch/sparc/include/asm/switch_to_64.h   |  4 +---
 arch/sparc/include/asm/thread_info_64.h |  4 +---
 arch/sparc/include/asm/uaccess_64.h     | 24 ------------------------
 arch/sparc/kernel/process_64.c          | 12 ------------
 arch/sparc/kernel/traps_64.c            |  2 --
 arch/sparc/lib/NGmemcpy.S               |  3 +--
 arch/sparc/mm/init_64.c                 |  3 ---
 9 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 875388835a58..5f08e4d16ad8 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -99,7 +99,6 @@ config SPARC64
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
-	select SET_FS
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index ae851e8fce4c..89850dff6b03 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -47,10 +47,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef struct {
-	unsigned char seg;
-} mm_segment_t;
-
 /* The Sparc processor specific thread struct. */
 /* XXX This should die, everything can go into thread_info now. */
 struct thread_struct {
diff --git a/arch/sparc/include/asm/switch_to_64.h b/arch/sparc/include/asm/switch_to_64.h
index b1d4e2e3210f..14f3c49bfdbc 100644
--- a/arch/sparc/include/asm/switch_to_64.h
+++ b/arch/sparc/include/asm/switch_to_64.h
@@ -20,10 +20,8 @@ do {						\
 	 */
 #define switch_to(prev, next, last)					\
 do {	save_and_clear_fpu();						\
-	/* If you are tempted to conditionalize the following */	\
-	/* so that ASI is only written if it changes, think again. */	\
 	__asm__ __volatile__("wr %%g0, %0, %%asi"			\
-	: : "r" (task_thread_info(next)->current_ds));\
+	: : "r" (ASI_AIUS));						\
 	trap_block[current_thread_info()->cpu].thread =			\
 		task_thread_info(next);					\
 	__asm__ __volatile__(						\
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 8047a9caab2f..1a44372e2bc0 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -46,7 +46,7 @@ struct thread_info {
 	struct pt_regs		*kregs;
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u8			new_child;
-	__u8			current_ds;
+	__u8			__pad;
 	__u16			cpu;
 
 	unsigned long		*utraps;
@@ -81,7 +81,6 @@ struct thread_info {
 #define TI_KREGS	0x00000028
 #define TI_PRE_COUNT	0x00000030
 #define TI_NEW_CHILD	0x00000034
-#define TI_CURRENT_DS	0x00000035
 #define TI_CPU		0x00000036
 #define TI_UTRAPS	0x00000038
 #define TI_REG_WINDOW	0x00000040
@@ -116,7 +115,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)				\
 {							\
 	.task		=	&tsk,			\
-	.current_ds	=	ASI_P,			\
 	.preempt_count	=	INIT_PREEMPT_COUNT,	\
 	.kregs		=	(struct pt_regs *)(init_stack+THREAD_SIZE)-1 \
 }
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 000bac67cf31..617a462d1f56 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -13,24 +13,6 @@
 
 #include <asm/processor.h>
 
-/*
- * Sparc64 is segmented, though more like the M68K than the I386.
- * We use the secondary ASI to address user memory, which references a
- * completely different VM map, thus there is zero chance of the user
- * doing something queer and tricking us into poking kernel memory.
- *
- * What is left here is basically what is needed for the other parts of
- * the kernel that expect to be able to manipulate, erum, "segments".
- * Or perhaps more properly, permissions.
- *
- * "For historical reasons, these macros are grossly misnamed." -Linus
- */
-
-#define KERNEL_DS   ((mm_segment_t) { ASI_P })
-#define USER_DS     ((mm_segment_t) { ASI_AIUS })	/* har har har */
-
-#define get_fs() ((mm_segment_t){(current_thread_info()->current_ds)})
-
 static inline int __access_ok(const void __user *addr, unsigned long size)
 {
 	return 1;
@@ -38,12 +20,6 @@ static inline int __access_ok(const void __user *addr, unsigned long size)
 #define __access_ok __access_ok
 #include <asm-generic/access_ok.h>
 
-#define set_fs(val)								\
-do {										\
-	current_thread_info()->current_ds = (val).seg;				\
-	__asm__ __volatile__ ("wr %%g0, %0, %%asi" : : "r" ((val).seg));	\
-} while(0)
-
 /*
  * Test whether a block of memory is a valid user space address.
  * Returns 0 if the range is valid, nonzero otherwise.
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index f5b2cac8669f..9a2ceb080ac9 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -106,18 +106,13 @@ static void show_regwindow32(struct pt_regs *regs)
 {
 	struct reg_window32 __user *rw;
 	struct reg_window32 r_w;
-	mm_segment_t old_fs;
 	
 	__asm__ __volatile__ ("flushw");
 	rw = compat_ptr((unsigned int)regs->u_regs[14]);
-	old_fs = get_fs();
-	set_fs (USER_DS);
 	if (copy_from_user (&r_w, rw, sizeof(r_w))) {
-		set_fs (old_fs);
 		return;
 	}
 
-	set_fs (old_fs);			
 	printk("l0: %08x l1: %08x l2: %08x l3: %08x "
 	       "l4: %08x l5: %08x l6: %08x l7: %08x\n",
 	       r_w.locals[0], r_w.locals[1], r_w.locals[2], r_w.locals[3],
@@ -136,7 +131,6 @@ static void show_regwindow(struct pt_regs *regs)
 	struct reg_window __user *rw;
 	struct reg_window *rwk;
 	struct reg_window r_w;
-	mm_segment_t old_fs;
 
 	if ((regs->tstate & TSTATE_PRIV) || !(test_thread_flag(TIF_32BIT))) {
 		__asm__ __volatile__ ("flushw");
@@ -145,14 +139,10 @@ static void show_regwindow(struct pt_regs *regs)
 		rwk = (struct reg_window *)
 			(regs->u_regs[14] + STACK_BIAS);
 		if (!(regs->tstate & TSTATE_PRIV)) {
-			old_fs = get_fs();
-			set_fs (USER_DS);
 			if (copy_from_user (&r_w, rw, sizeof(r_w))) {
-				set_fs (old_fs);
 				return;
 			}
 			rwk = &r_w;
-			set_fs (old_fs);			
 		}
 	} else {
 		show_regwindow32(regs);
@@ -598,7 +588,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
-		t->current_ds = ASI_P;
 		t->kregs->u_regs[UREG_G1] = sp; /* function */
 		t->kregs->u_regs[UREG_G2] = arg;
 		return 0;
@@ -613,7 +602,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	t->kregs->u_regs[UREG_FP] = sp;
 	__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 		(regs->tstate + 1) & TSTATE_CWP;
-	t->current_ds = ASI_AIUS;
 	if (sp != regs->u_regs[UREG_FP]) {
 		unsigned long csp;
 
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 21077821f427..5b4de4a89dec 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2857,8 +2857,6 @@ void __init trap_init(void)
 		     TI_PRE_COUNT != offsetof(struct thread_info,
 					      preempt_count) ||
 		     TI_NEW_CHILD != offsetof(struct thread_info, new_child) ||
-		     TI_CURRENT_DS != offsetof(struct thread_info,
-						current_ds) ||
 		     TI_KUNA_REGS != offsetof(struct thread_info,
 					      kern_una_regs) ||
 		     TI_KUNA_INSN != offsetof(struct thread_info,
diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index 8e4d22a6ba0b..ee51c1230689 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -10,8 +10,7 @@
 #include <asm/thread_info.h>
 #define GLOBAL_SPARE	%g7
 #define RESTORE_ASI(TMP)	\
-	ldub	[%g6 + TI_CURRENT_DS], TMP;  \
-	wr	TMP, 0x0, %asi;
+	wr	%g0, ASI_AIUS, %asi
 #else
 #define GLOBAL_SPARE	%g5
 #define RESTORE_ASI(TMP)	\
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1b23639e2fcd..ee08c279d67c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -709,9 +709,6 @@ static void __init inherit_prom_mappings(void)
 
 void prom_world(int enter)
 {
-	if (!enter)
-		set_fs(get_fs());
-
 	__asm__ __volatile__("flushw");
 }
 
-- 
2.29.2

