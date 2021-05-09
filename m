From: Mike Rapoport <rppt@kernel.org>
Date: Sun,  9 May 2021 12:11:03 +0300
Subject: [OpenRISC] [PATCH 2/2] openrisc: mm/init.c: remove unused variable
 'end' in paging_init()
In-Reply-To: <20210509091103.7985-1-rppt@kernel.org>
References: <20210509091103.7985-1-rppt@kernel.org>
Message-ID: <20210509091103.7985-3-rppt@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Mike Rapoport <rppt@linux.ibm.com>

A build with W=1 enabled produces the following warning:

  CC      arch/openrisc/mm/init.o
arch/openrisc/mm/init.c: In function 'paging_init':
arch/openrisc/mm/init.c:131:16: warning: variable 'end' set but not used [-Wunused-but-set-variable]
  131 |  unsigned long end;
      |                ^~~

Remove the unused variable 'end'.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/openrisc/mm/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index f3fa02b8838a..6e38ec96cab8 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -128,7 +128,6 @@ void __init paging_init(void)
 {
 	extern void tlb_init(void);
 
-	unsigned long end;
 	int i;
 
 	printk(KERN_INFO "Setting up paging and PTEs.\n");
@@ -144,8 +143,6 @@ void __init paging_init(void)
 	 */
 	current_pgd[smp_processor_id()] = init_mm.pgd;
 
-	end = (unsigned long)__va(max_low_pfn * PAGE_SIZE);
-
 	map_ram();
 
 	zone_sizes_init();
-- 
2.28.0

