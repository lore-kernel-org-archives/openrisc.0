From: Stafford Horne <shorne@gmail.com>
Date: Fri, 11 Sep 2020 08:39:38 +0900
Subject: [OpenRISC] [PATCH v3 1/3] openrisc: Reserve memblock for initrd
In-Reply-To: <20200910233940.2132107-1-shorne@gmail.com>
References: <20200910233940.2132107-1-shorne@gmail.com>
Message-ID: <20200910233940.2132107-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Recently OpenRISC added support for external initrd images, but I found
some instability when using larger buildroot initrd images. It turned
out that I forgot to reserve the memblock space for the initrd image.

This patch fixes the instability issue by reserving memblock space.

Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
Changes since v2:
 - None

Changes since v1:
 - Updated to use separate variables as suggested by Mike.

 arch/openrisc/kernel/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index b18e775f8be3..13c87f1f872b 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -80,6 +80,16 @@ static void __init setup_memory(void)
 	 */
 	memblock_reserve(__pa(_stext), _end - _stext);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* Then reserve the initrd, if any */
+	if (initrd_start && (initrd_end > initrd_start)) {
+		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
+		unsigned long aligned_end = ALIGN(initrd_end, PAGE_SIZE);
+
+		memblock_reserve(__pa(aligned_start), aligned_end - aligned_start);
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.26.2

