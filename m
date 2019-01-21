From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 21 Jan 2019 10:03:48 +0200
Subject: [OpenRISC] [PATCH v2 01/21] openrisc: prefer memblock APIs
	returning virtual address
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The allocation of the page tables memory in openrics uses
memblock_phys_alloc() and then converts the returned physical address to
virtual one. Use memblock_alloc_raw() and add a panic() if the allocation
fails.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/openrisc/mm/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d157310..caeb418 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -105,7 +105,10 @@ static void __init map_ram(void)
 			}
 
 			/* Alloc one page for holding PTE's... */
-			pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
+			pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
+			if (!pte)
+				panic("%s: Failed to allocate page for PTEs\n",
+				      __func__);
 			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
 
 			/* Fill the newly allocated page with PTE'S */
-- 
2.7.4

