From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 16:02:35 +0200
Subject: [OpenRISC] [PATCH 3/3] dma-debug: unexport dma_debug_resize_entries
	and debug_dma_dump_mappings
In-Reply-To: <20180424140235.9125-1-hch@lst.de>
References: <20180424140235.9125-1-hch@lst.de>
Message-ID: <20180424140235.9125-4-hch@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Only used by the AMD GART driver, which must be built in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 075253cb613b..6a1ebaa83623 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
 		spin_unlock_irqrestore(&bucket->lock, flags);
 	}
 }
-EXPORT_SYMBOL(debug_dma_dump_mappings);
 
 /*
  * For each mapping (initial cacheline in the case of
@@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
 
 	return ret;
 }
-EXPORT_SYMBOL(dma_debug_resize_entries);
 
 /*
  * DMA-API debugging init code
-- 
2.17.0

