From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:28 -0500
Subject: [OpenRISC] [PATCH 08/12] riscv: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-9-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Replace open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/riscv/kernel/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 6d59e6906fdd..f13b2c9ea912 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -22,7 +22,8 @@ int riscv_of_processor_hartid(struct device_node *node)
 		return -ENODEV;
 	}
 
-	if (of_property_read_u32(node, "reg", &hart)) {
+	hart = of_get_cpu_hwid(node, 0);
+	if (hart == ~0U) {
 		pr_warn("Found CPU without hart ID\n");
 		return -ENODEV;
 	}
-- 
2.30.2

