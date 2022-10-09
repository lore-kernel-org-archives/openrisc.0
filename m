Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75742C4332F
	for <openrisc@archiver.kernel.org>; Sun,  9 Oct 2022 10:32:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9B08324B69;
	Sun,  9 Oct 2022 12:32:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 7901D24B61
 for <openrisc@lists.librecores.org>; Sun,  9 Oct 2022 12:32:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665311555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxegBGCY4AqOzRwM7tNubdONObE84AmZTumb3T1RzAM=;
 b=bzUZ1rNXD/c+aBQk1tIuoC1kqf8+WMFQpB09eIDFFrzlsCo1C064GSSA9Zd4PI9SibvlUC
 WV9W2F5sJQDzY0Yr55KVlp/UjuiG27HsCJJ3ojiSHPB+uAXiBafzV71QggZEW9kYfnQcyJ
 Z4cQcO2pe0Gt+Xlx33gtW5HO/3s11q4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-HH8FxDx4OlGuEkOaYzjZFw-1; Sun, 09 Oct 2022 06:32:32 -0400
X-MC-Unique: HH8FxDx4OlGuEkOaYzjZFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CD85800186;
 Sun,  9 Oct 2022 10:32:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com
 [10.72.12.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 113DB40D298B;
 Sun,  9 Oct 2022 10:32:24 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Date: Sun,  9 Oct 2022 18:31:10 +0800
Message-Id: <20221009103114.149036-8-bhe@redhat.com>
In-Reply-To: <20221009103114.149036-1-bhe@redhat.com>
References: <20221009103114.149036-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, wangkefeng.wang@huawei.com, bhe@redhat.com,
 schnelle@linux.ibm.com, christophe.leroy@csgroup.eu, hch@infradead.org,
 linux-mm@kvack.org, David.Laight@ACULAB.COM, akpm@linux-foundation.org,
 agordeev@linux.ibm.com, openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
iounmap() are visible and available to arch. Arch only needs to
provide implementation of arch_ioremap() or arch_iounmap() if there's
arch specific handling needed in its ioremap() or iounmap(). This
change will simplify implementation by removing duplicated codes with
generic ioremap() and iounmap(), and has the equivalent functioality
as before.

For openrisc, the duplicated ioremap() can be perfectly removed, and no
arch_ioremap() is needed. Add arch_iounmap() to openrisc's special
operation when iounmap().

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Stafford Horne <shorne@gmail.com> 
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
---
v2->v3:
- Remove the early ioremap handling code in previous patch as Christoph
  and Stafford suggested. With this, arch_ioremap() is not needed in v3
  post.
- adjust the order of including  <asm/pgtable.h> and <asm/pgalloc.h>
  in <asm/io.h>, this fix an compiling error of virt_defconig building,
  Stafford suggested this.

 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/include/asm/io.h | 12 +++++---
 arch/openrisc/mm/ioremap.c     | 50 ++--------------------------------
 3 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index c7f282f60f64..fd9bb76a610b 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,6 +21,7 @@ config OPENRISC
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_CPU_DEVICES
 	select HAVE_PCI
 	select HAVE_UID16
diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index ee6043a03173..c2df089a10c4 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -15,6 +15,8 @@
 #define __ASM_OPENRISC_IO_H
 
 #include <linux/types.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
 
 /*
  * PCI: We do not use IO ports in OpenRISC
@@ -27,11 +29,13 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#define ioremap ioremap
-void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+/*
+ * I/O memory mapping functions.
+ */
+bool arch_iounmap(void __iomem *addr);
+#define arch_iounmap arch_iounmap
 
-#define iounmap iounmap
-extern void iounmap(volatile void __iomem *addr);
+#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index 90b59bc53c8c..bac2348b1737 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -22,50 +22,7 @@
 
 extern int mem_init_done;
 
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space. Needed when the kernel wants to access high addresses
- * directly.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
-{
-	phys_addr_t p;
-	unsigned long v;
-	unsigned long offset, last_addr;
-	struct vm_struct *area = NULL;
-
-	/* Don't allow wraparound or zero size */
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
-		return NULL;
-
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = addr & ~PAGE_MASK;
-	p = addr & PAGE_MASK;
-	size = PAGE_ALIGN(last_addr + 1) - p;
-
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-	v = (unsigned long)area->addr;
-
-	if (ioremap_page_range(v, v + size, p,
-			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
-		vfree(area->addr);
-		return NULL;
-	}
-
-	return (void __iomem *)(offset + (char *)v);
-}
-EXPORT_SYMBOL(ioremap);
-
-void iounmap(volatile void __iomem *addr)
+bool arch_iounmap(void __iomem *addr)
 {
 	/* If the page is from the fixmap pool then we just clear out
 	 * the fixmap mapping.
@@ -85,12 +42,11 @@ void iounmap(volatile void __iomem *addr)
 		 *   ii) invalid accesses to the freed areas aren't made
 		 */
 		flush_tlb_all();
-		return;
+		return false;
 	}
 
-	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
+	return true;
 }
-EXPORT_SYMBOL(iounmap);
 
 /**
  * OK, this one's a bit tricky... ioremap can get called before memory is
-- 
2.34.1

