From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 May 2020 16:36:38 +0200
Subject: [OpenRISC] [PATCH 21/29] sh: implement flush_icache_user_range
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Message-ID: <20200515143646.3857579-22-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The SuperH implementation of flush_icache_range seems to be able to
cope with user addresses.  Just define flush_icache_user_range to
flush_icache_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/cacheflush.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index b932e42ef0284..fe7400079b97b 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -46,6 +46,7 @@ extern void flush_cache_range(struct vm_area_struct *vma,
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *page);
 extern void flush_icache_range(unsigned long start, unsigned long end);
+#define flush_icache_user_range flush_icache_range
 extern void flush_icache_page(struct vm_area_struct *vma,
 				 struct page *page);
 extern void flush_cache_sigtramp(unsigned long address);
-- 
2.26.2

