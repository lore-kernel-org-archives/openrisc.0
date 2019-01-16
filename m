From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 16 Jan 2019 15:44:03 +0200
Subject: [OpenRISC] [PATCH 03/21] memblock: replace
	memblock_alloc_base(ANYWHERE) with memblock_phys_alloc
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1547646261-32535-4-git-send-email-rppt@linux.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The calls to memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE) and
memblock_phys_alloc(size, align) are equivalent as both try to allocate
'size' bytes with 'align' alignment anywhere in the memory and panic if hte
allocation fails.

The conversion is done using the following semantic patch:

@@
expression size, align;
@@
- memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE)
+ memblock_phys_alloc(size, align)

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c                   | 2 +-
 arch/sh/boards/mach-ap325rxa/setup.c | 2 +-
 arch/sh/boards/mach-ecovec24/setup.c | 4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c  | 2 +-
 arch/sh/boards/mach-migor/setup.c    | 2 +-
 arch/sh/boards/mach-se/7724/setup.c  | 4 ++--
 arch/xtensa/mm/kasan_init.c          | 3 +--
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 478ea8b..b76b90e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -205,7 +205,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 
 	BUG_ON(!arm_memblock_steal_permitted);
 
-	phys = memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, align);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 8f234d04..d7ceab6 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -557,7 +557,7 @@ static void __init ap325rxa_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 22b4106..a3901806 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1480,12 +1480,12 @@ static void __init ecovec_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 203d249..55bdf4a 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -631,7 +631,7 @@ static void __init kfr2r09_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index f4ad33c..ba7eee6 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -630,7 +630,7 @@ static void __init migor_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index fdbec22a..4696e10 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -965,12 +965,12 @@ static void __init ms7724se_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index 1734cda..48dbb03 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -52,8 +52,7 @@ static void __init populate(void *start, void *end)
 
 		for (k = 0; k < PTRS_PER_PTE; ++k, ++j) {
 			phys_addr_t phys =
-				memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
-						    MEMBLOCK_ALLOC_ANYWHERE);
+				memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 
 			set_pte(pte + j, pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
 		}
-- 
2.7.4

