From: Rob Herring <robh@kernel.org>
Date: Wed,  5 Sep 2018 14:37:27 -0500
Subject: [OpenRISC] [PATCH 10/21] openrisc: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Message-ID: <20180905193738.19325-11-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

This also fixes a leaked reference for cpus node.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc at lists.librecores.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/openrisc/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 9d28ab14d139..e17fcd83120f 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -158,9 +158,8 @@ static struct device_node *setup_find_cpu_node(int cpu)
 {
 	u32 hwid;
 	struct device_node *cpun;
-	struct device_node *cpus = of_find_node_by_path("/cpus");

-	for_each_available_child_of_node(cpus, cpun) {
+	for_each_of_cpu_node(cpun) {
 		if (of_property_read_u32(cpun, "reg", &hwid))
 			continue;
 		if (hwid == cpu)
--
2.17.1
