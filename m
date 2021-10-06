From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:21 -0500
Subject: [OpenRISC] [PATCH 01/12] of: Add of_get_cpu_hwid() to read hardware
 ID from CPU nodes
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-2-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

There are various open coded implementions parsing the CPU node 'reg'
property which contains the CPU's hardware ID. Introduce a new function,
of_get_cpu_hwid(), to read the hardware ID.

All the callers should be DT only code, so no need for an empty
function.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 22 ++++++++++++++++++++++
 include/linux/of.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f720c0d246f2..e587ab44be22 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -286,6 +286,28 @@ const void *of_get_property(const struct device_node *np, const char *name,
 }
 EXPORT_SYMBOL(of_get_property);
 
+/**
+ * of_get_cpu_hwid - Get the hardware ID from a CPU device node
+ *
+ * @cpun: CPU number(logical index) for which device node is required
+ * @thread: The local thread number to get the hardware ID for.
+ *
+ * Return: The hardware ID for the CPU node or ~0ULL if not found.
+ */
+u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thread)
+{
+	const __be32 *cell;
+	int ac, len;
+
+	ac = of_n_addr_cells(cpun);
+	cell = of_get_property(cpun, "reg", &len);
+	if (!cell || !ac || ((sizeof(*cell) * ac * (thread + 1)) > len))
+		return ~0ULL;
+
+	cell += ac * thread;
+	return of_read_number(cell, ac);
+}
+
 /*
  * arch_match_cpu_phys_id - Match the given logical CPU and physical id
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 6f1c41f109bb..807f8168dad9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -353,6 +353,7 @@ extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
 extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
 						 int index);
+extern u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thread);
 
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
-- 
2.30.2

