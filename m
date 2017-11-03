From: Stafford Horne <shorne@gmail.com>
Date: Fri,  3 Nov 2017 13:33:22 +0900
Subject: [OpenRISC] [PATCH for-next] openrisc: fix possible deadlock
	scenario during timer sync
Message-ID: <20171103043325.20646-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

OpenRISC borrows its timer sync logic from MIPS, Matt helped to review
the OpenRISC implementation and noted that we may suffer the same
deadlock case that MIPS has faced. The case being:

  "the MIPS timer synchronization code contained the possibility of
  deadlock. If you mark a CPU online before it goes into the synchronize
  loop, then the boot CPU can schedule a different thread and send IPIs to
  all "online" CPUs. It gets stuck waiting for the secondary to ack it's
  IPI, since this secondary CPU has not enabled IRQs yet, and is stuck
  waiting for the master to synchronise with it.  The system then
  deadlocks."

Fix this by moving set_cpu_online() to after timer sync.

Reported-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 4d80ce6fa045..7d518ee8bddc 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -127,10 +127,10 @@ asmlinkage __init void secondary_start_kernel(void)
 	/*
 	 * OK, now it's safe to let the boot CPU continue
 	 */
-	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
 	synchronise_count_slave(cpu);
+	set_cpu_online(cpu, true);
 
 	local_irq_enable();
 
-- 
2.13.6

