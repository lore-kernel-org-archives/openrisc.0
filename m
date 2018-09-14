From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Fri, 14 Sep 2018 15:10:26 +0300
Subject: [OpenRISC] [PATCH 11/30] memblock: replace
	alloc_bootmem_pages_nopanic with memblock_alloc_nopanic
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <1536927045-23536-12-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The alloc_bootmem_pages_nopanic(size) is a shortcut for
__alloc_bootmem_nopanic(size, PAGE_SIZE, BOOTMEM_LOW_LIMIT) which allocates
PAGE_SIZE aligned memory. Since BOOTMEM_LOW_LIMIT is hardwired to 0 there
is no restrictions on where the allocated memory should reside.

The memblock_alloc_nopanic(size, PAGE_SIZE) also allocates PAGE_SIZE
aligned memory without any restrictions and thus can be used as a
replacement for alloc_bootmem_pages_nopanic()

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 drivers/usb/early/xhci-dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index e15e896..16df968 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -94,7 +94,7 @@ static void * __init xdbc_get_page(dma_addr_t *dma_addr)
 {
 	void *virt;
 
-	virt = alloc_bootmem_pages_nopanic(PAGE_SIZE);
+	virt = memblock_alloc_nopanic(PAGE_SIZE, PAGE_SIZE);
 	if (!virt)
 		return NULL;
 
-- 
2.7.4

