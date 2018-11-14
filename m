From: Changbin Du <changbin.du@gmail.com>
Date: Thu, 15 Nov 2018 07:08:56 +0800
Subject: [OpenRISC] [PATCH v2] openrisc: make function cache_loop() inline
Message-ID: <20181114230856.30143-1-changbin.du@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The third operand of mtspr instruction must be a constant. To guarantee
this condition, function cache_loop() which uses macro mtspr() must be
inlined. So let's force it as 'inline'. This is to fix compiling error with
new option CONFIG_NO_AUTO_INLINE.

In file included from arch/openrisc/mm/cache.c:17:0:
arch/openrisc/mm/cache.c: In function 'cache_loop':
arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
                              ^
arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
      mtspr(reg, line);
      ^~~~~
arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index b747bf1fc1b6..4a4b2b6e006b 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -20,7 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static void cache_loop(struct page *page, const unsigned int reg)
+static inline void cache_loop(struct page *page, const unsigned int reg)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
 	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
-- 
2.17.1

