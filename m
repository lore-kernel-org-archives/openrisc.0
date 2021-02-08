From: Stafford Horne <shorne@gmail.com>
Date: Tue,  9 Feb 2021 05:53:05 +0900
Subject: [OpenRISC] [PATCH v3] openrisc: Use devicetree to determine present
 cpus
Message-ID: <20210208205307.4169579-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>

Use the device tree to determine the present cpus instead of assuming
all CONFIG_NRCPUS are actually present in the system.

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
[shorne: Squashed 2 email commits and added summary from email]
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/smp.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 29c82ef2e207..48e1092a64de 100644
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
@@ -60,22 +61,32 @@ void __init smp_prepare_boot_cpu(void)
 
 void __init smp_init_cpus(void)
 {
-	int i;
+	struct device_node *cpu;
+	u32 cpu_id;
 
-	for (i = 0; i < NR_CPUS; i++)
-		set_cpu_possible(i, true);
+	for_each_of_cpu_node(cpu) {
+		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
+			pr_warn("%s missing reg property", cpu->full_name);
+			continue;
+		}
+
+		if (cpu_id < NR_CPUS)
+			set_cpu_possible(cpu_id, true);
+	}
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
+	unsigned int cpu;
 
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated@the present time.
 	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
+	for_each_possible_cpu(cpu) {
+		if (cpu < max_cpus)
+			set_cpu_present(cpu, true);
+	}
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
-- 
2.26.2

