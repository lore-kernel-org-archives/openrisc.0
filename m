From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 28 Feb 2022 16:17:50 +0530
Subject: [OpenRISC] [PATCH V3 27/30] nds32/mm: Enable
 ARCH_HAS_VM_GET_PAGE_PROT
In-Reply-To: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1646045273-9343-28-git-send-email-anshuman.khandual@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Nick Hu <nickhu@andestech.com>
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/nds32/Kconfig               |  1 +
 arch/nds32/include/asm/pgtable.h | 17 ---------------
 arch/nds32/mm/mmap.c             | 37 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 4d1421b18734..576e05479925 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -10,6 +10,7 @@ config NDS32
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 419f984eef70..79f64ed734cb 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -152,23 +152,6 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 #endif /* __ASSEMBLY__ */
 
 /*         xwr */
-#define __P000  (PAGE_NONE | _PAGE_CACHE_SHRD)
-#define __P001  (PAGE_READ | _PAGE_CACHE_SHRD)
-#define __P010  (PAGE_COPY | _PAGE_CACHE_SHRD)
-#define __P011  (PAGE_COPY | _PAGE_CACHE_SHRD)
-#define __P100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
-#define __P101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __P110  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __P111  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
-
-#define __S000  (PAGE_NONE | _PAGE_CACHE_SHRD)
-#define __S001  (PAGE_READ | _PAGE_CACHE_SHRD)
-#define __S010  (PAGE_RDWR | _PAGE_CACHE_SHRD)
-#define __S011  (PAGE_RDWR | _PAGE_CACHE_SHRD)
-#define __S100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
-#define __S101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __S110  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __S111  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/nds32/mm/mmap.c b/arch/nds32/mm/mmap.c
index 1bdf5e7d1b43..0399b928948d 100644
--- a/arch/nds32/mm/mmap.c
+++ b/arch/nds32/mm/mmap.c
@@ -71,3 +71,40 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return (PAGE_NONE | _PAGE_CACHE_SHRD);
+	case VM_READ:
+		return (PAGE_READ | _PAGE_CACHE_SHRD);
+	case VM_WRITE:
+	case VM_WRITE | VM_READ:
+		return (PAGE_COPY | _PAGE_CACHE_SHRD);
+	case VM_EXEC:
+		return (PAGE_EXEC | _PAGE_CACHE_SHRD);
+	case VM_EXEC | VM_READ:
+		return (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_SHARED:
+		return (PAGE_NONE | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_READ:
+		return (PAGE_READ | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return (PAGE_RDWR | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_EXEC:
+		return (PAGE_EXEC | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

