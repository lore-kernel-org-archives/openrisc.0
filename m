From: Christoph Hellwig <hch@lst.de>
Date: Sat, 17 Aug 2019 09:32:31 +0200
Subject: [OpenRISC] [PATCH 04/26] mips: remove ioremap_cachable
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
Message-ID: <20190817073253.27819-5-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Just define ioremap_cache directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/io.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 97a280640daf..c02db986ddf5 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -262,11 +262,11 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
 #define ioremap_uc ioremap_nocache
 
 /*
- * ioremap_cachable -	map bus memory into CPU space
+ * ioremap_cache -	map bus memory into CPU space
  * @offset:	    bus address of the memory
  * @size:	    size of the resource to map
  *
- * ioremap_nocache performs a platform specific sequence of operations to
+ * ioremap_cache performs a platform specific sequence of operations to
  * make bus memory CPU accessible via the readb/readw/readl/writeb/
  * writew/writel functions and the other mmio helpers. The returned
  * address is not guaranteed to be usable directly as a virtual
@@ -276,9 +276,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
  * the CPU.  Also enables full write-combining.	 Useful for some
  * memory-like regions on I/O busses.
  */
-#define ioremap_cachable(offset, size)					\
+#define ioremap_cache(offset, size)					\
 	__ioremap_mode((offset), (size), _page_cachable_default)
-#define ioremap_cache ioremap_cachable
 
 /*
  * ioremap_wc     -   map bus memory into CPU space
-- 
2.20.1

