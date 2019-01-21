From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 21 Jan 2019 10:04:00 +0200
Subject: [OpenRISC] [PATCH v2 13/21] arch: don't memset(0) memory returned
	by memblock_alloc()
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1548057848-15136-14-git-send-email-rppt@linux.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

memblock_alloc() already clears the allocated memory, no point in doing it
twice.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
---
 arch/c6x/mm/init.c          | 1 -
 arch/h8300/mm/init.c        | 1 -
 arch/ia64/kernel/mca.c      | 2 --
 arch/m68k/mm/mcfmmu.c       | 1 -
 arch/microblaze/mm/init.c   | 6 ++----
 arch/sparc/kernel/prom_32.c | 2 --
 6 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index af5ada0..e83c046 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -40,7 +40,6 @@ void __init paging_init(void)
 
 	empty_zero_page      = (unsigned long) memblock_alloc(PAGE_SIZE,
 							      PAGE_SIZE);
-	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	/*
 	 * Set up user data space
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 6519252..a157890 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -68,7 +68,6 @@ void __init paging_init(void)
 	 * to a couple of allocated pages.
 	 */
 	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	/*
 	 * Set up SFC/DFC registers (user data space).
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 74d148b..370bc34 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -400,8 +400,6 @@ ia64_log_init(int sal_info_type)
 
 	// set up OS data structures to hold error info
 	IA64_LOG_ALLOCATE(sal_info_type, max_size);
-	memset(IA64_LOG_CURR_BUFFER(sal_info_type), 0, max_size);
-	memset(IA64_LOG_NEXT_BUFFER(sal_info_type), 0, max_size);
 }
 
 /*
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 0de4999..492f953 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -44,7 +44,6 @@ void __init paging_init(void)
 	int i;
 
 	empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	memset((void *) empty_zero_page, 0, PAGE_SIZE);
 
 	pg_dir = swapper_pg_dir;
 	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 44f4b89..bd1cd4b 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -376,10 +376,8 @@ void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
 
 	if (mem_init_done)
 		p = kzalloc(size, mask);
-	else {
+	else
 		p = memblock_alloc(size, SMP_CACHE_BYTES);
-		if (p)
-			memset(p, 0, size);
-	}
+
 	return p;
 }
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 38940af..e7126ca 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -33,8 +33,6 @@ void * __init prom_early_alloc(unsigned long size)
 	void *ret;
 
 	ret = memblock_alloc(size, SMP_CACHE_BYTES);
-	if (ret != NULL)
-		memset(ret, 0, size);
 
 	prom_early_allocated += size;
 
-- 
2.7.4

