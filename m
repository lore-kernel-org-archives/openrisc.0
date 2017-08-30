From: Stafford Horne <shorne@gmail.com>
Date: Thu, 31 Aug 2017 07:02:11 +0900
Subject: [OpenRISC] [PATCH 07/13] openrisc: fix initial preempt state for
	secondary cpu tasks
In-Reply-To: <cover.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
Message-ID: <b717771fb3be766953bf1af3e8782b9a29472848.1504129273.git.shorne@gmail.com>
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
index ae93b84062ff..24f7aa45b0ba 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -125,6 +125,7 @@ asmlinkage __init void secondary_start_kernel(void)
 
 	local_irq_enable();
 
+	preempt_disable();
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
-- 
2.13.5

