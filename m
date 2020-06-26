From: Peter Xu <peterx@redhat.com>
Date: Fri, 26 Jun 2020 18:36:17 -0400
Subject: [OpenRISC] [PATCH 14/26] mm/openrisc: Use general page fault
 accounting
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
Message-ID: <20200626223617.199669-1-peterx@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Jonas Bonn <jonas@southpole.se>
CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
CC: Stafford Horne <shorne@gmail.com>
CC: openrisc at lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/openrisc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 45aedc572361..5255d73ce180 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/extable.h>
 #include <linux/sched/signal.h>
+#include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
 #include <asm/siginfo.h>
@@ -103,6 +104,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (in_interrupt() || !mm)
 		goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -159,7 +162,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * the fault.
 	 */
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -176,10 +179,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
 		/*RGD modeled on Cris */
-		if (fault & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

