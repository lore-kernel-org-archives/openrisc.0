From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:25 -0500
Subject: [OpenRISC] [PATCH 05/12] csky: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-6-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Replace open coded parsing of CPU nodes 'reg' property with
of_get_cpu_hwid().

Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/csky/kernel/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index e2993539af8e..6bb38bc2f39b 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -180,15 +180,13 @@ void __init setup_smp_ipi(void)
 void __init setup_smp(void)
 {
 	struct device_node *node = NULL;
-	int cpu;
+	unsigned int cpu;
 
 	for_each_of_cpu_node(node) {
 		if (!of_device_is_available(node))
 			continue;
 
-		if (of_property_read_u32(node, "reg", &cpu))
-			continue;
-
+		cpu = of_get_cpu_hwid(node, 0);
 		if (cpu >= NR_CPUS)
 			continue;
 
-- 
2.30.2

