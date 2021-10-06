From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:24 -0500
Subject: [OpenRISC] [PATCH 04/12] arm64: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-5-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Replace the open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

This change drops an error message for missing 'reg' property, but that
should not be necessary as the DT tools will ensure 'reg' is present.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/smp.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6f6ff072acbd..c5cebc406d24 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -466,33 +466,6 @@ void __init smp_prepare_boot_cpu(void)
 	kasan_init_hw_tags();
 }
 
-static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-{
-	const __be32 *cell;
-	u64 hwid;
-
-	/*
-	 * A cpu node with missing "reg" property is
-	 * considered invalid to build a cpu_logical_map
-	 * entry.
-	 */
-	cell = of_get_property(dn, "reg", NULL);
-	if (!cell) {
-		pr_err("%pOF: missing reg property\n", dn);
-		return INVALID_HWID;
-	}
-
-	hwid = of_read_number(cell, of_n_addr_cells(dn));
-	/*
-	 * Non affinity bits must be set to 0 in the DT
-	 */
-	if (hwid & ~MPIDR_HWID_BITMASK) {
-		pr_err("%pOF: invalid reg property\n", dn);
-		return INVALID_HWID;
-	}
-	return hwid;
-}
-
 /*
  * Duplicate MPIDRs are a recipe for disaster. Scan all initialized
  * entries and check for duplicates. If any is found just ignore the
@@ -656,9 +629,9 @@ static void __init of_parse_and_init_cpus(void)
 	struct device_node *dn;
 
 	for_each_of_cpu_node(dn) {
-		u64 hwid = of_get_cpu_mpidr(dn);
+		u64 hwid = of_get_cpu_hwid(dn, 0);
 
-		if (hwid == INVALID_HWID)
+		if (hwid & ~MPIDR_HWID_BITMASK)
 			goto next;
 
 		if (is_mpidr_duplicate(cpu_count, hwid)) {
-- 
2.30.2

