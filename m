From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri,  8 Sep 2017 10:25:08 +0200
Subject: [OpenRISC] [PATCH] openrisc: add forward declaration for struct
	vm_area_struct
In-Reply-To: <201709080345.bk1IOlp7%fengguang.wu@intel.com>
References: <201709080345.bk1IOlp7%fengguang.wu@intel.com>
Message-ID: <20170908082508.14325-1-tklauser@distanz.ch>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

After removing linux/vmalloc.h from asm-generic/io.h, the following
warning occurs on openrisc:

   In file included from arch/openrisc/include/asm/io.h:33:0,
                    from include/linux/io.h:25,
                    from drivers/tty/serial/earlycon.c:19:
   arch/openrisc/include/asm/pgtable.h:424:2: warning: 'struct vm_area_struct' declared inside parameter list
     unsigned long address, pte_t *pte)
     ^
   arch/openrisc/include/asm/pgtable.h:424:2: warning: its scope is only this definition or declaration, which is probably not what you want

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/openrisc/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index ff97374ca069..71a6f08de8f2 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -414,6 +414,8 @@ static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD]; /* defined in head.S */
 
+struct vm_area_struct;
+
 /*
  * or32 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
-- 
2.13.0


