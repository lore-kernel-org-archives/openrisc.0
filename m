From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 May 2020 16:36:37 +0200
Subject: [OpenRISC] [PATCH 20/29] asm-generic: add a flush_icache_user_range
 stub
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Message-ID: <20200515143646.3857579-21-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Define flush_icache_user_range to flush_icache_range unless the
architecture provides its own implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/cacheflush.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 2c9686fefb715..907fa5d164944 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -66,6 +66,10 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 }
 #endif
 
+#ifndef flush_icache_user_range
+#define flush_icache_user_range flush_icache_range
+#endif
+
 #ifndef flush_icache_page
 static inline void flush_icache_page(struct vm_area_struct *vma,
 				     struct page *page)
-- 
2.26.2

