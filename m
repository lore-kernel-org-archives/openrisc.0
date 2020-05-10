From: Christoph Hellwig <hch@lst.de>
Date: Sun, 10 May 2020 09:55:03 +0200
Subject: [OpenRISC] [PATCH 24/31] xtensa: implement flush_icache_user_range
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Message-ID: <20200510075510.987823-25-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The Xtensa implementation of flush_icache_range seems to be able to
cope with user addresses.  Just define flush_icache_user_range to
flush_icache_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/cacheflush.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index a0d50be5a8cb1..460e666ad0761 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -107,6 +107,8 @@ void flush_cache_page(struct vm_area_struct*,
 #define flush_cache_page  local_flush_cache_page
 #endif
 
+#define flush_icache_user_range flush_icache_range
+
 #define local_flush_cache_all()						\
 	do {								\
 		__flush_invalidate_dcache_all();			\
-- 
2.26.2

