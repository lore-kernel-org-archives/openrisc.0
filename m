From: Stafford Horne <shorne@gmail.com>
Date: Sat,  4 Feb 2017 00:48:30 +0900
Subject: [OpenRISC] [PATCH v2 06/23] openrisc: add l.lwa/l.swa emulation
In-Reply-To: <cover.1486135912.git.shorne@gmail.com>
References: <cover.1486135912.git.shorne@gmail.com>
Message-ID: <6b717dc4c704195dae19d6db49e8ae032c91c4a4.1486135912.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

This adds an emulation layer for implementations
that lack the l.lwa and l.swa instructions.
It handles these instructions both in kernel space and
user space.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: Added delay slot pc adjust logic]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S   |  22 ++++-
 arch/openrisc/kernel/process.c |   3 +
 arch/openrisc/kernel/traps.c   | 183 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index aac0bde..ba1a361 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -173,6 +173,11 @@ handler:							;\
 	l.j	_ret_from_exception				;\
 	 l.nop
 
+/* clobbers 'reg' */
+#define CLEAR_LWA_FLAG(reg)		\
+	l.movhi	reg,hi(lwa_flag)	;\
+	l.ori	reg,reg,lo(lwa_flag)	;\
+	l.sw	0(reg),r0
 /*
  * NOTE: one should never assume that SPR_EPC, SPR_ESR, SPR_EEAR
  *       contain the same values as when exception we're handling
@@ -193,6 +198,7 @@ EXCEPTION_ENTRY(_tng_kernel_start)
 /* ---[ 0x200: BUS exception ]------------------------------------------- */
 
 EXCEPTION_ENTRY(_bus_fault_handler)
+	CLEAR_LWA_FLAG(r3)
 	/* r4: EA of fault (set by EXCEPTION_HANDLE) */
 	l.jal   do_bus_fault
 	 l.addi  r3,r1,0 /* pt_regs */
@@ -202,11 +208,13 @@ EXCEPTION_ENTRY(_bus_fault_handler)
 
 /* ---[ 0x300: Data Page Fault exception ]------------------------------- */
 EXCEPTION_ENTRY(_dtlb_miss_page_fault_handler)
+	CLEAR_LWA_FLAG(r3)
 	l.and	r5,r5,r0
 	l.j	1f
 	 l.nop
 
 EXCEPTION_ENTRY(_data_page_fault_handler)
+	CLEAR_LWA_FLAG(r3)
 	/* set up parameters for do_page_fault */
 	l.ori	r5,r0,0x300		   // exception vector
 1:
@@ -282,11 +290,13 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 
 /* ---[ 0x400: Insn Page Fault exception ]------------------------------- */
 EXCEPTION_ENTRY(_itlb_miss_page_fault_handler)
+	CLEAR_LWA_FLAG(r3)
 	l.and	r5,r5,r0
 	l.j	1f
 	 l.nop
 
 EXCEPTION_ENTRY(_insn_page_fault_handler)
+	CLEAR_LWA_FLAG(r3)
 	/* set up parameters for do_page_fault */
 	l.ori	r5,r0,0x400		   // exception vector
 1:
@@ -304,6 +314,7 @@ EXCEPTION_ENTRY(_insn_page_fault_handler)
 /* ---[ 0x500: Timer exception ]----------------------------------------- */
 
 EXCEPTION_ENTRY(_timer_handler)
+	CLEAR_LWA_FLAG(r3)
 	l.jal	timer_interrupt
 	 l.addi r3,r1,0 /* pt_regs */
 
@@ -313,6 +324,7 @@ EXCEPTION_ENTRY(_timer_handler)
 /* ---[ 0x600: Aligment exception ]-------------------------------------- */
 
 EXCEPTION_ENTRY(_alignment_handler)
+	CLEAR_LWA_FLAG(r3)
 	/* r4: EA of fault (set by EXCEPTION_HANDLE) */
 	l.jal   do_unaligned_access
 	 l.addi  r3,r1,0 /* pt_regs */
@@ -509,6 +521,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 //	l.sw	PT_SR(r1),r4
 1:
 #endif
+	CLEAR_LWA_FLAG(r3)
 	l.addi	r3,r1,0
 	l.movhi	r8,hi(do_IRQ)
 	l.ori	r8,r8,lo(do_IRQ)
@@ -556,8 +569,12 @@ ENTRY(_sys_call_handler)
 	 * they should be clobbered, otherwise
 	 */
 	l.sw    PT_GPR3(r1),r3
-	/* r4 already saved */
-	/* r4 holds the EEAR address of the fault, load the original r4 */
+	/*
+	 * r4 already saved
+	 * r4 holds the EEAR address of the fault, use it as screatch reg and
+	 * then load the original r4
+	 */
+	CLEAR_LWA_FLAG(r4)
 	l.lwz	r4,PT_GPR4(r1)
 	l.sw    PT_GPR5(r1),r5
 	l.sw    PT_GPR6(r1),r6
@@ -776,6 +793,7 @@ UNHANDLED_EXCEPTION(_vector_0xd00,0xd00)
 /* ---[ 0xe00: Trap exception ]------------------------------------------ */
 
 EXCEPTION_ENTRY(_trap_handler)
+	CLEAR_LWA_FLAG(r3)
 	/* r4: EA of fault (set by EXCEPTION_HANDLE) */
 	l.jal   do_trap
 	 l.addi  r3,r1,0 /* pt_regs */
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index d7990df..c49350b 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -226,6 +226,7 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t * fpu)
 
 extern struct thread_info *_switch(struct thread_info *old_ti,
 				   struct thread_info *new_ti);
+extern int lwa_flag;
 
 struct task_struct *__switch_to(struct task_struct *old,
 				struct task_struct *new)
@@ -243,6 +244,8 @@ struct task_struct *__switch_to(struct task_struct *old,
 	new_ti = new->stack;
 	old_ti = old->stack;
 
+	lwa_flag = 0;
+
 	current_thread_info_set[smp_processor_id()] = new_ti;
 	last = (_switch(old_ti, new_ti))->task;
 
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index a4574cb..7907b6c 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -40,6 +40,8 @@
 extern char _etext, _stext;
 
 int kstack_depth_to_print = 0x180;
+int lwa_flag;
+unsigned long __user *lwa_addr;
 
 static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
@@ -334,10 +336,191 @@ asmlinkage void do_bus_fault(struct pt_regs *regs, unsigned long address)
 	}
 }
 
+static inline int in_delay_slot(struct pt_regs *regs)
+{
+#ifdef CONFIG_OPENRISC_NO_SPR_SR_DSX
+	/* No delay slot flag, do the old way */
+	unsigned int op, insn;
+
+	insn = *((unsigned int *)regs->pc);
+	op = insn >> 26;
+	switch (op) {
+	case 0x00: /* l.j */
+	case 0x01: /* l.jal */
+	case 0x03: /* l.bnf */
+	case 0x04: /* l.bf */
+	case 0x11: /* l.jr */
+	case 0x12: /* l.jalr */
+		return 1;
+	default:
+		return 0;
+	}
+#else
+	return regs->sr & SPR_SR_DSX;
+#endif
+}
+
+static inline void adjust_pc(struct pt_regs *regs, unsigned long address)
+{
+	int displacement;
+	unsigned int rb, op, jmp;
+
+	if (unlikely(in_delay_slot(regs))) {
+		/* In delay slot, instruction at pc is a branch, simulate it */
+		jmp = *((unsigned int *)regs->pc);
+
+		displacement = sign_extend32(((jmp) & 0x3ffffff) << 2, 27);
+		rb = (jmp & 0x0000ffff) >> 11;
+		op = jmp >> 26;
+
+		switch (op) {
+		case 0x00: /* l.j */
+			regs->pc += displacement;
+			return;
+		case 0x01: /* l.jal */
+			regs->pc += displacement;
+			regs->gpr[9] = regs->pc + 8;
+			return;
+		case 0x03: /* l.bnf */
+			if (regs->sr & SPR_SR_F)
+				regs->pc += 8;
+			else
+				regs->pc += displacement;
+			return;
+		case 0x04: /* l.bf */
+			if (regs->sr & SPR_SR_F)
+				regs->pc += displacement;
+			else
+				regs->pc += 8;
+			return;
+		case 0x11: /* l.jr */
+			regs->pc = regs->gpr[rb];
+			return;
+		case 0x12: /* l.jalr */
+			regs->pc = regs->gpr[rb];
+			regs->gpr[9] = regs->pc + 8;
+			return;
+		default:
+			break;
+		}
+	} else {
+		regs->pc += 4;
+	}
+}
+
+static inline void simulate_lwa(struct pt_regs *regs, unsigned long address,
+				unsigned int insn)
+{
+	unsigned int ra, rd;
+	unsigned long value;
+	unsigned long orig_pc;
+	long imm;
+
+	const struct exception_table_entry *entry;
+
+	orig_pc = regs->pc;
+	adjust_pc(regs, address);
+
+	ra = (insn >> 16) & 0x1f;
+	rd = (insn >> 21) & 0x1f;
+	imm = (short)insn;
+	lwa_addr = (unsigned long __user *)(regs->gpr[ra] + imm);
+
+	if ((unsigned long)lwa_addr & 0x3) {
+		do_unaligned_access(regs, address);
+		return;
+	}
+
+	if (get_user(value, lwa_addr)) {
+		if (user_mode(regs)) {
+			force_sig(SIGSEGV, current);
+			return;
+		}
+
+		if ((entry = search_exception_tables(orig_pc))) {
+			regs->pc = entry->fixup;
+			return;
+		}
+
+		/* kernel access in kernel space, load it directly */
+		value = *((unsigned long *)lwa_addr);
+	}
+
+	lwa_flag = 1;
+	regs->gpr[rd] = value;
+}
+
+static inline void simulate_swa(struct pt_regs *regs, unsigned long address,
+				unsigned int insn)
+{
+	unsigned long __user *vaddr;
+	unsigned long orig_pc;
+	unsigned int ra, rb;
+	long imm;
+
+	const struct exception_table_entry *entry;
+
+	orig_pc = regs->pc;
+	adjust_pc(regs, address);
+
+	ra = (insn >> 16) & 0x1f;
+	rb = (insn >> 11) & 0x1f;
+	imm = (short)(((insn & 0x2200000) >> 10) | (insn & 0x7ff));
+	vaddr = (unsigned long __user *)(regs->gpr[ra] + imm);
+
+	if (!lwa_flag || vaddr != lwa_addr) {
+		regs->sr &= ~SPR_SR_F;
+		return;
+	}
+
+	if ((unsigned long)vaddr & 0x3) {
+		do_unaligned_access(regs, address);
+		return;
+	}
+
+	if (put_user(regs->gpr[rb], vaddr)) {
+		if (user_mode(regs)) {
+			force_sig(SIGSEGV, current);
+			return;
+		}
+
+		if ((entry = search_exception_tables(orig_pc))) {
+			regs->pc = entry->fixup;
+			return;
+		}
+
+		/* kernel access in kernel space, store it directly */
+		*((unsigned long *)vaddr) = regs->gpr[rb];
+	}
+
+	lwa_flag = 0;
+	regs->sr |= SPR_SR_F;
+}
+
+#define INSN_LWA	0x1b
+#define INSN_SWA	0x33
+
 asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 				       unsigned long address)
 {
 	siginfo_t info;
+	unsigned int op;
+	unsigned int insn = *((unsigned int *)address);
+
+	op = insn >> 26;
+
+	switch (op) {
+	case INSN_LWA:
+		simulate_lwa(regs, address, insn);
+		return;
+
+	case INSN_SWA:
+		simulate_swa(regs, address, insn);
+		return;
+
+	default:
+		break;
+	}
 
 	if (user_mode(regs)) {
 		/* Send a SIGILL */
-- 
2.9.3

