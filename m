From: Christoph Hellwig <hch@lst.de>
Date: Sun, 10 May 2020 09:55:09 +0200
Subject: [OpenRISC] [PATCH 30/31] nommu: use flush_icache_user_range in brk
 and mmap
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Message-ID: <20200510075510.987823-31-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

These obviously operate on user addresses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/nommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 318df4e236c99..aed7acaed2383 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -443,7 +443,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	/*
 	 * Ok, looks good - let it rip.
 	 */
-	flush_icache_range(mm->brk, brk);
+	flush_icache_user_range(mm->brk, brk);
 	return mm->brk = brk;
 }
 
@@ -1287,7 +1287,7 @@ unsigned long do_mmap(struct file *file,
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
 	if (vma->vm_flags & VM_EXEC && !region->vm_icache_flushed) {
-		flush_icache_range(region->vm_start, region->vm_end);
+		flush_icache_user_range(region->vm_start, region->vm_end);
 		region->vm_icache_flushed = true;
 	}
 
-- 
2.26.2

