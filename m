Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D244C32789
	for <openrisc@archiver.kernel.org>; Sat, 20 Aug 2022 00:32:18 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id F0E0F24A8A;
	Sat, 20 Aug 2022 02:32:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id CB53D24A57
 for <openrisc@lists.librecores.org>; Sat, 20 Aug 2022 02:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660955534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbVQC9n5EHI3Q19oreTxvS1jwCRKlt1Xm2HiNn8Pbvw=;
 b=gRdIjJk3HfsYgTm6HbPim+ZM0hvHn7l77xQdorZgcQKTMaY4Hj61wxYsL6toJBIBH+Vzs1
 m5+OeIjg29XE2lsVr8854tFfTfZpABiEYB1Ik/GKvZ4KP5oV6N9oUAtinMb6JqLKTjBqqi
 HZ7wCxSRpp+Zpjhr5BGUONkvD+VWSCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-JXbmH_XLOMqZeo5PESKY-Q-1; Fri, 19 Aug 2022 20:32:10 -0400
X-MC-Unique: JXbmH_XLOMqZeo5PESKY-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 848C980231E;
 Sat, 20 Aug 2022 00:32:09 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com
 [10.72.12.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5A324010D2A;
 Sat, 20 Aug 2022 00:32:03 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Date: Sat, 20 Aug 2022 08:31:21 +0800
Message-Id: <20220820003125.353570-8-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-1-bhe@redhat.com>
References: <20220820003125.353570-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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
Cc: Jonas Bonn <jonas@southpole.se>, wangkefeng.wang@huawei.com,
 Baoquan He <bhe@redhat.com>, hch@infradead.org, linux-mm@kvack.org,
 openrisc@lists.librecores.org, akpm@linux-foundation.org,
 agordeev@linux.ibm.com, linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Add hooks arch_ioremap() and arch_iounmap() for operisc's special
operation when ioremap() and iounmap.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
---
 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/include/asm/io.h | 16 ++++++++---
 arch/openrisc/mm/ioremap.c     | 51 +++++++++++-----------------------
 3 files changed, 29 insertions(+), 39 deletions(-)

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
index ee6043a03173..9db67938bfc4 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -15,6 +15,8 @@
 #define __ASM_OPENRISC_IO_H
 
 #include <linux/types.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 
 /*
  * PCI: We do not use IO ports in OpenRISC
@@ -27,11 +29,17 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#define ioremap ioremap
-void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+/*
+ * I/O memory mapping functions.
+ */
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
+
+int arch_iounmap(void __iomem *addr);
+#define arch_iounmap arch_iounmap
 
-#define iounmap iounmap
-extern void iounmap(volatile void __iomem *addr);
+#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index 8ec0dafecf25..bc41660e1fb0 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -24,26 +24,18 @@ extern int mem_init_done;
 
 static unsigned int fixmaps_used __initdata;
 
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
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
 	phys_addr_t p;
 	unsigned long v;
-	unsigned long offset, last_addr;
-	struct vm_struct *area = NULL;
+	unsigned long offset, last_addr, addr = *paddr;
+	int ret = -EINVAL;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = addr + size - 1;
 	if (!size || last_addr < addr)
-		return NULL;
+		return IOMEM_ERR_PTR(ret);
 
 	/*
 	 * Mappings have to be page-aligned
@@ -52,32 +44,24 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 	p = addr & PAGE_MASK;
 	size = PAGE_ALIGN(last_addr + 1) - p;
 
-	if (likely(mem_init_done)) {
-		area = get_vm_area(size, VM_IOREMAP);
-		if (!area)
-			return NULL;
-		v = (unsigned long)area->addr;
-	} else {
+	if (unlikely(!mem_init_done)) {
 		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
-			return NULL;
+			return IOMEM_ERR_PTR(ret);
 		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
 		fixmaps_used += (size >> PAGE_SHIFT);
-	}
 
-	if (ioremap_page_range(v, v + size, p,
-			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
-		if (likely(mem_init_done))
-			vfree(area->addr);
-		else
+		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
 			fixmaps_used -= (size >> PAGE_SHIFT);
-		return NULL;
+			return IOMEM_ERR_PTR(ret);
+		}
+
+		return (void __iomem *)(offset + (char *)v);
 	}
 
-	return (void __iomem *)(offset + (char *)v);
+	return NULL;
 }
-EXPORT_SYMBOL(ioremap);
 
-void iounmap(volatile void __iomem *addr)
+int arch_iounmap(void __iomem *addr)
 {
 	/* If the page is from the fixmap pool then we just clear out
 	 * the fixmap mapping.
@@ -97,13 +81,10 @@ void iounmap(volatile void __iomem *addr)
 		 *   ii) invalid accesses to the freed areas aren't made
 		 */
 		flush_tlb_all();
-		return;
+		return -EINVAL;
 	}
-
-	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
+	return 0;
 }
-EXPORT_SYMBOL(iounmap);
-
 /**
  * OK, this one's a bit tricky... ioremap can get called before memory is
  * initialized (early serial console does this) and will want to alloc a page
-- 
2.34.1

