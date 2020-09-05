From: Stafford Horne <shorne@gmail.com>
Date: Sat,  5 Sep 2020 22:19:34 +0900
Subject: [OpenRISC] [PATCH v2 2/3] openrisc: Fix cache API compile issue
 when not inlining
In-Reply-To: <20200905131935.972386-1-shorne@gmail.com>
References: <20200905131935.972386-1-shorne@gmail.com>
Message-ID: <20200905131935.972386-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I found this when compiling a kbuild random config with GCC 11.  The
config enables CONFIG_DEBUG_SECTION_MISMATCH, which sets CFLAGS
-fno-inline-functions-called-once. This causes the call to cache_loop in
cache.c to not be inlined causing the below compile error.

    In file included from arch/openrisc/mm/cache.c:13:
    arch/openrisc/mm/cache.c: In function 'cache_loop':
    ./arch/openrisc/include/asm/spr.h:16:27: warning: 'asm' operand 0 probably does not match constraints
       16 | #define mtspr(_spr, _val) __asm__ __volatile__ (  \
	  |                           ^~~~~~~
    arch/openrisc/mm/cache.c:25:3: note: in expansion of macro 'mtspr'
       25 |   mtspr(reg, line);
	  |   ^~~~~
    ./arch/openrisc/include/asm/spr.h:16:27: error: impossible constraint in 'asm'
       16 | #define mtspr(_spr, _val) __asm__ __volatile__ (  \
	  |                           ^~~~~~~
    arch/openrisc/mm/cache.c:25:3: note: in expansion of macro 'mtspr'
       25 |   mtspr(reg, line);
	  |   ^~~~~
    make[1]: *** [scripts/Makefile.build:283: arch/openrisc/mm/cache.o] Error 1

The asm constraint "K" requires a immediate constant argument to mtspr,
however because of no inlining a register argument is passed causing a
failure.  Fix this by using __always_inline.

Link: https://lore.kernel.org/lkml/202008200453.ohnhqkjQ%25lkp at intel.com/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index 08f56af387ac..534a52ec5e66 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -16,7 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static void cache_loop(struct page *page, const unsigned int reg)
+static __always_inline void cache_loop(struct page *page, const unsigned int reg)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
 	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
-- 
2.26.2

