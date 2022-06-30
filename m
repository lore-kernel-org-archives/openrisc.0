Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4160CCA486
	for <openrisc@archiver.kernel.org>; Thu, 30 Jun 2022 05:17:05 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C68EB211D5;
	Thu, 30 Jun 2022 07:17:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mail.librecores.org (Postfix) with ESMTP id 9B144248D5
 for <openrisc@lists.librecores.org>; Thu, 30 Jun 2022 07:17:03 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A42114BF;
 Wed, 29 Jun 2022 22:17:03 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.8])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48C723F66F;
 Wed, 29 Jun 2022 22:16:55 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: [PATCH V6 02/26] mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
Date: Thu, 30 Jun 2022 10:46:06 +0530
Message-Id: <20220630051630.1718927-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630051630.1718927-1-anshuman.khandual@arm.com>
References: <20220630051630.1718927-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 christophe.leroy@csgroup.eu, hch@infradead.org,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This just converts the generic vm_get_page_prot() implementation into a new
macro i.e DECLARE_VM_GET_PAGE_PROT which later can be used across platforms
when enabling them with ARCH_HAS_VM_GET_PAGE_PROT. This does not create any
functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pgtable.h | 28 ++++++++++++++++++++++++++++
 mm/mmap.c               | 26 +-------------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3cdc16cfd867..014ee8f0fbaa 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1689,4 +1689,32 @@ typedef unsigned int pgtbl_mod_mask;
 #define MAX_PTRS_PER_P4D PTRS_PER_P4D
 #endif
 
+/* description of effects of mapping type and prot in current implementation.
+ * this is due to the limited x86 page protection hardware.  The expected
+ * behavior is in parens:
+ *
+ * map_type	prot
+ *		PROT_NONE	PROT_READ	PROT_WRITE	PROT_EXEC
+ * MAP_SHARED	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
+ *		w: (no) no	w: (no) no	w: (yes) yes	w: (no) no
+ *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
+ *
+ * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
+ *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
+ *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
+ *
+ * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
+ * MAP_PRIVATE (with Enhanced PAN supported):
+ *								r: (no) no
+ *								w: (no) no
+ *								x: (yes) yes
+ */
+#define DECLARE_VM_GET_PAGE_PROT					\
+pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
+{									\
+		return protection_map[vm_flags &			\
+			(VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)];	\
+}									\
+EXPORT_SYMBOL(vm_get_page_prot);
+
 #endif /* _LINUX_PGTABLE_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index b01f0280bda2..b46d5e931bb3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -81,26 +81,6 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end);
 
-/* description of effects of mapping type and prot in current implementation.
- * this is due to the limited x86 page protection hardware.  The expected
- * behavior is in parens:
- *
- * map_type	prot
- *		PROT_NONE	PROT_READ	PROT_WRITE	PROT_EXEC
- * MAP_SHARED	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
- *		w: (no) no	w: (no) no	w: (yes) yes	w: (no) no
- *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
- *
- * MAP_PRIVATE	r: (no) no	r: (yes) yes	r: (no) yes	r: (no) yes
- *		w: (no) no	w: (no) no	w: (copy) copy	w: (no) no
- *		x: (no) no	x: (no) yes	x: (no) yes	x: (yes) yes
- *
- * On arm64, PROT_EXEC has the following behaviour for both MAP_SHARED and
- * MAP_PRIVATE (with Enhanced PAN supported):
- *								r: (no) no
- *								w: (no) no
- *								x: (yes) yes
- */
 #ifdef __P000
 pgprot_t protection_map[16] __ro_after_init = {
 	[VM_NONE]					= __P000,
@@ -123,11 +103,7 @@ pgprot_t protection_map[16] __ro_after_init = {
 #endif
 
 #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
-{
-	return protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
-}
-EXPORT_SYMBOL(vm_get_page_prot);
+DECLARE_VM_GET_PAGE_PROT
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
-- 
2.25.1

