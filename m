From: Stafford Horne <shorne@gmail.com>
Date: Mon, 30 Oct 2017 08:11:17 +0900
Subject: [OpenRISC] [PATCH v4 07/13] openrisc: fix initial preempt state for
	secondary cpu tasks
In-Reply-To: <20171029231123.27281-1-shorne@gmail.com>
References: <20171029231123.27281-1-shorne@gmail.com>
Message-ID: <20171029231123.27281-8-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

During SMP testing we were getting the below warning after booting the
secondary cpu:

[    0.060000] BUG: scheduling while atomic: swapper/1/0/0x00000000

This change follows similar patterns from other architectures to start
the schduler with preempt disabled.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/thread_info.h | 2 +-
 arch/openrisc/kernel/smp.c              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index 6e619a79a401..c229aa6bb502 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -74,7 +74,7 @@ struct thread_info {
 	.task		= &tsk,				\
 	.flags		= 0,				\
 	.cpu		= 0,				\
-	.preempt_count	= 1,				\
+	.preempt_count	= INIT_PREEMPT_COUNT,		\
 	.addr_limit	= KERNEL_DS,			\
 	.ksp            = 0,                            \
 }
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index fd724123229a..154c94a0cfbc 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -128,6 +128,7 @@ asmlinkage __init void secondary_start_kernel(void)
 
 	local_irq_enable();
 
+	preempt_disable();
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
-- 
2.13.6

