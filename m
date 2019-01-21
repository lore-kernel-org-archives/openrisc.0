From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 21 Jan 2019 10:04:05 +0200
Subject: [OpenRISC] [PATCH v2 18/21] swiotlb: add checks for the return
	value of memblock_alloc*()
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1548057848-15136-19-git-send-email-rppt@linux.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add panic() calls if memblock_alloc() returns NULL.

The panic() format duplicates the one used by memblock itself and in order
to avoid explosion with long parameters list replace open coded allocation
size calculations with a local variable.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 kernel/dma/swiotlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d636177..e78835c8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -191,6 +191,7 @@ void __init swiotlb_update_mem_attributes(void)
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 {
 	unsigned long i, bytes;
+	size_t alloc_size;
 
 	bytes = nslabs << IO_TLB_SHIFT;
 
@@ -203,12 +204,18 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
 	 * between io_tlb_start and io_tlb_end.
 	 */
-	io_tlb_list = memblock_alloc(
-				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
-				PAGE_SIZE);
-	io_tlb_orig_addr = memblock_alloc(
-				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
-				PAGE_SIZE);
+	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(int));
+	io_tlb_list = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!io_tlb_list)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, alloc_size, PAGE_SIZE);
+
+	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t));
+	io_tlb_orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!io_tlb_orig_addr)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, alloc_size, PAGE_SIZE);
+
 	for (i = 0; i < io_tlb_nslabs; i++) {
 		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
-- 
2.7.4

