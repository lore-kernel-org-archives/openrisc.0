From: Stafford Horne <shorne@gmail.com>
Date: Wed, 17 Jun 2020 18:02:46 +0900
Subject: [OpenRISC] [PATCH] openrisc: Fix boot oops when DEBUG_VM is enabled
Message-ID: <20200617090247.1680188-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Since v5.8-rc1 OpenRISC Linux fails to boot when DEBUG_VM is enabled.
This has been bisected to commit 42fc541404f2 ("mmap locking API: add
mmap_assert_locked() and mmap_assert_write_locked()").

The added locking checks exposed the issue that OpenRISC was not taking
this mmap lock when during page walks for DMA operations.  This patch
locks and unlocks the mmap lock for page walking.

Fixes: 42fc541404f2 ("mmap locking API: add mmap_assert_locked() and mmap_assert_write_locked()"
Cc: Michel Lespinasse <walken@google.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index c152a68811dd..345727638d52 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -74,8 +74,11 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
+	mmap_read_lock(&init_mm);
 	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
 			NULL);
+	mmap_read_unlock(&init_mm);
+
 	if (error)
 		return ERR_PTR(error);
 	return cpu_addr;
@@ -85,9 +88,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 {
 	unsigned long va = (unsigned long)cpu_addr;
 
+	mmap_read_lock(&init_mm);
 	/* walk_page_range shouldn't be able to fail here */
 	WARN_ON(walk_page_range(&init_mm, va, va + size,
 			&clear_nocache_walk_ops, NULL));
+	mmap_read_unlock(&init_mm);
 }
 
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
-- 
2.26.2

