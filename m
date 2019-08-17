From: Christoph Hellwig <hch@lst.de>
Date: Sat, 17 Aug 2019 09:32:35 +0200
Subject: [OpenRISC] [PATCH 08/26] m68k: simplify ioremap_nocache
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
Message-ID: <20190817073253.27819-9-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Just define ioremap_nocache to ioremap instead of duplicating the
inline.  Also defined ioremap_uc in terms of ioremap instead of
the using a double indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/include/asm/kmap.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 03d904fe6087..421b6c9c769d 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -28,14 +28,8 @@ static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-#define ioremap_nocache ioremap_nocache
-static inline void __iomem *ioremap_nocache(unsigned long physaddr,
-					    unsigned long size)
-{
-	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
-}
-
-#define ioremap_uc ioremap_nocache
+#define ioremap_nocache ioremap
+#define ioremap_uc ioremap
 #define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
-- 
2.20.1

