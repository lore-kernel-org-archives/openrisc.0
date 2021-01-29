From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Date: Fri, 29 Jan 2021 19:29:31 +0100
Subject: [OpenRISC] [PATCH] openrisc: use device tree to determine present
 cpus
Message-ID: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This patch proposes to use the device tree to determine the present cpus 
instead of assuming all CONFIG_NRCPUS are actually present in the system.

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---
  arch/openrisc/kernel/smp.c | 18 +++++++++++++++---
  1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 29c82ef2e..75be7e34f 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -16,6 +16,7 @@
  #include <linux/sched.h>
  #include <linux/sched/mm.h>
  #include <linux/irq.h>
+#include <linux/of.h>
  #include <asm/cpuinfo.h>
  #include <asm/mmu_context.h>
  #include <asm/tlbflush.h>
@@ -68,14 +69,25 @@ void __init smp_init_cpus(void)

  void __init smp_prepare_cpus(unsigned int max_cpus)
  {
-	int i;
+	u32 cpu_id;
+	struct device_node *cpu, *cpus;

  	/*
  	 * Initialise the present map, which describes the set of CPUs
  	 * actually populated at the present time.
  	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
+	cpus = of_find_node_by_path("/cpus");
+	for_each_child_of_node(cpus, cpu) {
+		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
+			pr_warn("%s missing reg property", cpu->full_name);
+			continue;
+		}
+
+		if (cpu_id >= max_cpus)
+			continue;
+
+		set_cpu_present(cpu_id, true);
+	}
  }

  void __init smp_cpus_done(unsigned int max_cpus)
-- 
2.17.1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5316 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210129/5cfbcebd/attachment.bin>
