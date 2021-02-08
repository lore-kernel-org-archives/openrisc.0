From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Date: Mon, 8 Feb 2021 15:28:32 +0100
Subject: [OpenRISC] [PATCH v2] Use devicetree to determine present cpus
 (v2)
Message-ID: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---
 arch/openrisc/kernel/smp.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 75be7e34f..83cbf43d4 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -61,32 +61,31 @@ void __init smp_prepare_boot_cpu(void)
 
 void __init smp_init_cpus(void)
 {
-	int i;
+	struct device_node* cpu;
+	u32 cpu_id;
+
+	for_each_of_cpu_node(cpu) {
+		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
+			pr_warn("%s missing reg property", cpu->full_name);
+			continue;
+		}
 
-	for (i = 0; i < NR_CPUS; i++)
-		set_cpu_possible(i, true);
+		if (cpu_id < NR_CPUS)
+			set_cpu_possible(cpu_id, true);
+	}
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	u32 cpu_id;
-	struct device_node *cpu, *cpus;
+	unsigned int cpu;
 
 	/*
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated@the present time.
 	 */
-	cpus = of_find_node_by_path("/cpus");
-	for_each_child_of_node(cpus, cpu) {
-		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
-			pr_warn("%s missing reg property", cpu->full_name);
-			continue;
-		}
-
-		if (cpu_id >= max_cpus)
-			continue;
-
-		set_cpu_present(cpu_id, true);
+	for_each_possible_cpu(cpu) {
+		if (cpu < max_cpus)
+			set_cpu_present(cpu, true);
 	}
 }
 
-- 
2.17.1

