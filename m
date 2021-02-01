From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Date: Mon, 1 Feb 2021 12:49:31 +0100
Subject: [OpenRISC] [PATCH v2] openrisc: use device tree to determine
 present cpus
In-Reply-To: <20210131212752.GG2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net>
Message-ID: <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Use the device tree to determine the present cpus instead of assuming 
all CONFIG_NRCPUS are actually present in the system.

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---
Changes since v1:
  1. use for_each_of_cpu_node
  2. possible_cpus is now what is in the devicetree, up to NR_CPUS
  3. present_cpus is now all possible cpus, up to max_cpus

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

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5316 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210201/0e1d6181/attachment.bin>
