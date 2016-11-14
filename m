From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:31 +0900
Subject: [OpenRISC] [PATCH v2 1/9] openrisc: fix PTRS_PER_PGD define
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <80c23bdfab23b1939c3ab8e382d4cdb251a732e1.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

On OpenRISC, with its 8k pages, PAGE_SHIFT is defined to be 13.
That makes the expression (1UL << (PAGE_SHIFT-2)) evaluate
to 2048.
The correct value for PTRS_PER_PGD should be 256.

Correcting the PTRS_PER_PGD define unveiled a bug in map_ram(),
where PTRS_PER_PGD was used when the intent was to iterate
over a set of page table entries.
This patch corrects that issue as well.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Acked-by: Jonas Bonn <jonas@southpole.se>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/openrisc/include/asm/pgtable.h | 2 +-
 arch/openrisc/mm/init.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 69c7df0..3567aa7 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -69,7 +69,7 @@ extern void paging_init(void);
  */
 #define PTRS_PER_PTE	(1UL << (PAGE_SHIFT-2))
 
-#define PTRS_PER_PGD	(1UL << (PAGE_SHIFT-2))
+#define PTRS_PER_PGD	(1UL << (32-PGDIR_SHIFT))
 
 /* calculate how many PGD entries a user-level program can use
  * the first mappable virtual address is 0
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 7f94652..b782ce9 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -110,7 +110,7 @@ static void __init map_ram(void)
 			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
 
 			/* Fill the newly allocated page with PTE'S */
-			for (j = 0; p < e && j < PTRS_PER_PGD;
+			for (j = 0; p < e && j < PTRS_PER_PTE;
 			     v += PAGE_SIZE, p += PAGE_SIZE, j++, pte++) {
 				if (v >= (u32) _e_kernel_ro ||
 				    v < (u32) _s_kernel_ro)
-- 
2.7.4


