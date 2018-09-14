From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Fri, 14 Sep 2018 15:10:24 +0300
Subject: [OpenRISC] [PATCH 09/30] memblock: replace alloc_bootmem_low with
	memblock_alloc_low
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <1536927045-23536-10-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The functions are equivalent, just the later does not require nobootmem
translation layer.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/x86/kernel/tce_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tce_64.c b/arch/x86/kernel/tce_64.c
index f386bad..54c9b5a 100644
--- a/arch/x86/kernel/tce_64.c
+++ b/arch/x86/kernel/tce_64.c
@@ -173,7 +173,7 @@ void * __init alloc_tce_table(void)
 	size = table_size_to_number_of_entries(specified_table_size);
 	size *= TCE_ENTRY_SIZE;
 
-	return __alloc_bootmem_low(size, size, 0);
+	return memblock_alloc_low(size, size);
 }
 
 void __init free_tce_table(void *tbl)
-- 
2.7.4

