From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Sun, 29 Dec 2019 16:42:58 +0100
Subject: [OpenRISC] [PATCH 4/4] openrisc: use mmgrab
In-Reply-To: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
Message-ID: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
helper") and most of the kernel was updated to use it. Update a
remaining file.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ expression e; @@
- atomic_inc(&e->mm_count);
+ mmgrab(e);
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
I was not able to compile this file.

 arch/openrisc/kernel/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 7d518ee8bddc..7bd6e0fc7a6d 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -113,7 +113,7 @@ asmlinkage __init void secondary_start_kernel(void)
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
 	 */
-	atomic_inc(&mm->mm_count);
+	mmgrab(mm);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 

