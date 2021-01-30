From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Date: Sat, 30 Jan 2021 12:00:10 +0100
Subject: [OpenRISC] [PATCH] openrisc: use device tree to determine
 present cpus
In-Reply-To: <20210129221643.GZ2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
Message-ID: <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford, Geert,

thanks for your feedback. I have made the following changes to the patch:

1. use for_each_of_cpu_node
2. possible_cpus is now what is in the devicetree, up to NR_CPUS
3. present_cpus is now all possible cpus, up to max_cpus

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---
  arch/openrisc/kernel/smp.c | 23 +++++++++++++++++------
  1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 29c82ef2e..83cbf43d4 100644
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
+	struct device_node* cpu;
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
2.17.1


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5316 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210130/0e05546d/attachment.bin>
