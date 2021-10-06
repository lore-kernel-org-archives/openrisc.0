From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:22 -0500
Subject: [OpenRISC] [PATCH 02/12] ARM: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-3-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Replace the open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

This change drops an error message for missing 'reg' property, but that
should not be necessary as the DT tools will ensure 'reg' is present.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/kernel/devtree.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 28311dd0fee6..02839d8b6202 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -84,33 +84,15 @@ void __init arm_dt_init_cpu_maps(void)
 		return;
 
 	for_each_of_cpu_node(cpu) {
-		const __be32 *cell;
-		int prop_bytes;
-		u32 hwid;
+		u32 hwid = of_get_cpu_hwid(cpu, 0);
 
 		pr_debug(" * %pOF...\n", cpu);
-		/*
-		 * A device tree containing CPU nodes with missing "reg"
-		 * properties is considered invalid to build the
-		 * cpu_logical_map.
-		 */
-		cell = of_get_property(cpu, "reg", &prop_bytes);
-		if (!cell || prop_bytes < sizeof(*cell)) {
-			pr_debug(" * %pOF missing reg property\n", cpu);
-			of_node_put(cpu);
-			return;
-		}
 
 		/*
 		 * Bits n:24 must be set to 0 in the DT since the reg property
 		 * defines the MPIDR[23:0].
 		 */
-		do {
-			hwid = be32_to_cpu(*cell++);
-			prop_bytes -= sizeof(*cell);
-		} while (!hwid && prop_bytes > 0);
-
-		if (prop_bytes || (hwid & ~MPIDR_HWID_BITMASK)) {
+		if (hwid & ~MPIDR_HWID_BITMASK) {
 			of_node_put(cpu);
 			return;
 		}
-- 
2.30.2

