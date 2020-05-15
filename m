From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 May 2020 16:36:25 +0200
Subject: [OpenRISC] [PATCH 08/29] alpha: use asm-generic/cacheflush.h
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Message-ID: <20200515143646.3857579-9-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Alpha needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/cacheflush.h | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/include/asm/cacheflush.h b/arch/alpha/include/asm/cacheflush.h
index 89128489cb598..636d7ca0d05f6 100644
--- a/arch/alpha/include/asm/cacheflush.h
+++ b/arch/alpha/include/asm/cacheflush.h
@@ -4,19 +4,6 @@
 
 #include <linux/mm.h>
 
-/* Caches aren't brain-dead on the Alpha. */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
-
 /* Note that the following two definitions are _highly_ dependent
    on the contexts in which they are used in the kernel.  I personally
    think it is criminal how loosely defined these macros are.  */
@@ -59,20 +46,17 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 			mm->context[smp_processor_id()] = 0;
 	}
 }
-#else
+#define flush_icache_user_range flush_icache_user_range
+#else /* CONFIG_SMP */
 extern void flush_icache_user_range(struct vm_area_struct *vma,
 		struct page *page, unsigned long addr, int len);
-#endif
+#define flush_icache_user_range flush_icache_user_range
+#endif /* CONFIG_SMP */
 
 /* This is used only in __do_fault and do_swap_page.  */
 #define flush_icache_page(vma, page) \
-  flush_icache_user_range((vma), (page), 0, 0)
+	flush_icache_user_range((vma), (page), 0, 0)
 
-#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-do { memcpy(dst, src, len); \
-     flush_icache_user_range(vma, page, vaddr, len); \
-} while (0)
-#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
 
 #endif /* _ALPHA_CACHEFLUSH_H */
-- 
2.26.2

