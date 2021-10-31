From: Stafford Horne <shorne@gmail.com>
Date: Mon, 1 Nov 2021 06:46:58 +0900
Subject: [OpenRISC] OpenRISC SMP kernels broken after 5.8?
In-Reply-To: <e35018e8-a15b-550d-cc3e-6b6d045f1b52@rwth-aachen.de>
References: <e35018e8-a15b-550d-cc3e-6b6d045f1b52@rwth-aachen.de>
Message-ID: <YX8O0ix3MyOGQnqq@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 26, 2021 at 10:43:45PM +0200, Jan Henrik Weinstock wrote:
> Hi all,
> 
> I recently tried to update the kernel my simulator[1] is running to 5.10,
> but I noticed the newer kernels (>5.8) all panic in flush_tlb_page[2],
> because it is called with vma == NULL from flush_tlb_kernel_range[3].
> Looking at the code, I do not see how this could work for any SMP kernel
> (however, for non-SMP, we call local_tlb_flush_page[4], where we do not use
> vma, so I guess its fine there). Any ideas?

Hi Jan,

(sorry for late reply, I need to fix my filters)

Are you running on a SMP machine or are you running SMP kernel on a single CPU
with no ompic device?

I haven't had issues when running the SMP kernels on single CPU devices,
however, I can't recall how recent that is.

I did make a patch to this around 5.10, so I am pretty user it was working at
this point.  The reason added this patch was because I noticed simulators were
spending a lot of time, ~90%+, in TLB flushes I figured that reducing the work
done for TLB flushes would improve performance, and it did.

The patch:

 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=c28b27416da9

But it looks like this is what introduced the issue.  Somehow this slipped
through.  I think a patch like the following would help for now, I cannot easily
test now due to my environment being occupied by some long running tests.  Any
suggestions?

Basically the idea is, we only need the VMA to figure out which CPU's to flush
the range on.  When we pass in NULL it means its a kernel flush and we should
flush on all CPU's.  There may be something more efficient (maybe using
init_mm), but this is all I can think of that is safe.

-Stafford

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 415e209732a3..cf5079bd8f43 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -320,7 +320,9 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned
long uaddr)
 void flush_tlb_range(struct vm_area_struct *vma,
                     unsigned long start, unsigned long end)
 {
-       smp_flush_tlb_range(mm_cpumask(vma->vm_mm), start, end);
+       struct cpumask *cmask = (vma == NULL) ? cpu_online_mask
+                                             : mm_cpumask(vma->vm_mm);
+       smp_flush_tlb_range(cmask, start, end);
 }
 
 /* Instruction cache invalidate - performed on each cpu */

