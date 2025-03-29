Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6D1B6CE5;
	Sat, 29 Mar 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241617; cv=none; b=G60c8wymy515dLyI9N4ZqeMcThkldbMweRiagOeVLS4jCeVWq/7dvxQtz2qIL0Xp4L6UxtBOBklZxvrRVpzcWGYLg2VaZh/Fqdva5N0lLiYH5Ejs81Ln7gk03dQni2djJlqdbHWN9QDDATLHusQ/6+8rtJvZ8zsU7Yh3ne+l9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241617; c=relaxed/simple;
	bh=rTVPWsX3Qowb9ZaDN5A7csWAl3V+PvDzkzd33zr1nOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WztPj4tBjnxXjTEjf8nk+KCkkaiAM/RbSdzFaRKTtonzipV6M1gY+cZsmp5JwsHqX1nqVlaE445YPbEvg3BWyjxMovQ+l4/kD3h2rwfkuZ32FOOh0ucHVgj6hNULKYGXI8Y7vzctRW6vCj2gLq8t1bkiuRNyHtOTirgzF4lV5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9r8xYdr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9r8xYdr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso4697601a91.3;
        Sat, 29 Mar 2025 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743241615; x=1743846415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYyBFOZ/eRDHZzTnt9tAVXYoVvRY1rvI0I9fOEyba5I=;
        b=F9r8xYdrJ3odtvwXI1BMF8qQjsvKeCScNMzLQbwp2XCYyPM7DJsK2SujiL98ZFqwwe
         XJKXCvJrrIc8M2LmGnZOggYOIecJYHZ84PM/HXaGV6tnkKrERPxB9wcHEqXmU+Hsfa1S
         QmYTcsAr/D/RPA5vszeVe+9MOGmh6iopGV/cSnYt+QEf5MOB2zunEPGE79f/NWa+GS8x
         QDU2t9277hvzdk3rNYlBNd/AYLrkS5MsGFeGc46CqXLqGLGyC9zY794DjQHShhO6O+dg
         KL4F5qwKsg07EhegbiE1eW3VmUR+VIBNBQ8KFPUQSjUUOFXezebHc//Wo9QKJDPO8NB3
         vGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743241615; x=1743846415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYyBFOZ/eRDHZzTnt9tAVXYoVvRY1rvI0I9fOEyba5I=;
        b=kDuS0tClqI95sP9bvhHRZpbhIfCbEH9hRIcFK15z9uHmfpSbAQNfM38HHX4l2or0ia
         u5uZWmjVu4Ud1/PR17LJzP5Y2aaTpjI9qCcxmsngE+mL2B6xSHuvI8looD1A/onNQ2fE
         ZYMAhRfjQcgBMEhJ3I2rjFKoxYCa3avLRg82XJaWBpqIQz6tIGZA4M0FutdIDlPfmW7b
         SxEc/IPOD7ryT3/MH/MlmBzU8sTZoqPE1OfVfydOVHCybU/99Zh8OuP+eWumMQHyZpmv
         nXNIXiGAq/G5/r4MW6mCygZKjQKEmzJycrzZgZ7vA89IJqajpTZuIwmDT3j3ttBsji3y
         9z3A==
X-Forwarded-Encrypted: i=1; AJvYcCVsJArA42NrVuxzlSs/lkVFsqTqUv/Y1K+jyjtglk7PdS3rvvT3DNCW6LOe7QlcPpjcy8+8JmkD/oBXgec=@vger.kernel.org, AJvYcCWMayCp7fgrmgDF1FsVopr1BLKAH1V8nmXqN79DPiihz/WOOrErmoHgvKufOWVbxw5rfgYY04NEiw2zqHD1Eos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VBFzQ1zwEwvztlmDYb5j25IYiimGxPJi3QDGhRLydsw/8Ztv
	FS5k5aHk28e4bjoXy+B+0spO73rg4fX5nuaSF7LHBpZSlbrheeDy
X-Gm-Gg: ASbGnctqR6D5VCw0ILW6st3nr1arN+yBA5fL8ISxH9DRJyZy/J7+6ZPuVfJ0Xh+0Gtz
	SrP12M9ADDsKXahtKgRzipZdH++Uz6rA/mJPBwGSfIB8tykWLUbffJrkOVXljtGFk6N05lttcLU
	qwYcgwP8YKIxMsU1auGNTgRXyWt8Ufo9cP9XVpR7pR9egoBRZTj2DJRqtQFsj0TNWYC/V18BWVt
	KClJ63rN9YbVpEQDfbLOQBMFSKtDVbfJc1dW7lETPCVasI0DlRkSeuvthiuLMR7XdVDz8WsGkjZ
	HF/lzoA/u5x6oWiZrawE0DCCSGa6hKPqzalr
X-Google-Smtp-Source: AGHT+IFv6jmMUddVsWN6oteEsmJpZ6KB6MAgHWa3Y/TIAGbULB/Q8laKhXlpMhmc43QkY+m+wB8OQg==
X-Received: by 2002:a17:90b:1b0f:b0:2ff:5e4e:861 with SMTP id 98e67ed59e1d1-305321653f4mr3395586a91.24.1743241614755;
        Sat, 29 Mar 2025 02:46:54 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b31fbsm5680573a91.40.2025.03.29.02.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 02:46:54 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] openrisc: Introduce new utility functions to flush and invalidate caches
Date: Sat, 29 Mar 2025 15:16:21 +0530
Message-ID: <20250329094622.94919-3-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329094622.94919-1-sahilcdq@proton.me>
References: <20250329094622.94919-1-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the OpenRISC architecture manual, the dcache and icache may
not be present. When these caches are present, the invalidate and flush
registers may be absent. The current implementation does not perform
checks to verify their presence before utilizing cache registers, or
invalidating and flushing cache blocks.

Introduce new functions to detect the presence of cache components and
related special-purpose registers.

There are a few places where a range of addresses have to be flushed or
invalidated and the implementation is duplicated. Introduce new utility
functions and macros that generalize this implementation and reduce
duplication.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v4 -> v5:
- arch/openrisc/include/asm/cpuinfo.h: Remove cb_inv_flush_is_implemented.
- arch/openrisc/mm/cache.c:
  (cpu_cache_is_present): Shift definition to the top.
  (cb_inv_flush_is_implemented): Remove function.
- arch/openrisc/mm/cache.c:
 (cpu_cache_is_present): Fix condition.

Changes from v3 -> v4:
- arch/openrisc/include/asm/cpuinfo.h: Move new definitions to cache.c.
- arch/openrisc/mm/cache.c:
  (cache_loop): Split function.
  (cache_loop_page): New function.
  (cpu_cache_is_present): Move definition here.
  (cb_inv_flush_is_implemented): Move definition here.

Changes from v2 -> v3:
- arch/openrisc/include/asm/cacheflush.h: Declare new functions and macros.
- arch/openrisc/include/asm/cpuinfo.h: Implement new functions.
  (cpu_cache_is_present):
  1. The implementation of this function was strewn all over the place in
     the previous versions.
  2. Fix condition. The condition in the previous version was incorrect.
  (cb_inv_flush_is_implemented): New function.
- arch/openrisc/kernel/dma.c: Use new functions.
- arch/openrisc/mm/cache.c:
  (cache_loop): Extend function.
  (local_*_page_*): Use new cache_loop interface.
  (local_*_range_*): Implement new functions.
- arch/openrisc/mm/init.c: Use new functions.

 arch/openrisc/include/asm/cacheflush.h | 17 ++++++++
 arch/openrisc/include/asm/cpuinfo.h    |  8 ++++
 arch/openrisc/kernel/dma.c             | 18 ++-------
 arch/openrisc/mm/cache.c               | 56 +++++++++++++++++++++-----
 arch/openrisc/mm/init.c                |  5 ++-
 5 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
index 984c331ff5f4..0e60af486ec1 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -23,6 +23,9 @@
  */
 extern void local_dcache_page_flush(struct page *page);
 extern void local_icache_page_inv(struct page *page);
+extern void local_dcache_range_flush(unsigned long start, unsigned long end);
+extern void local_dcache_range_inv(unsigned long start, unsigned long end);
+extern void local_icache_range_inv(unsigned long start, unsigned long end);
 
 /*
  * Data cache flushing always happen on the local cpu. Instruction cache
@@ -38,6 +41,20 @@ extern void local_icache_page_inv(struct page *page);
 extern void smp_icache_page_inv(struct page *page);
 #endif /* CONFIG_SMP */
 
+/*
+ * Even if the actual block size is larger than L1_CACHE_BYTES, paddr
+ * can be incremented by L1_CACHE_BYTES. When paddr is written to the
+ * invalidate register, the entire cache line encompassing this address
+ * is invalidated. Each subsequent reference to the same cache line will
+ * not affect the invalidation process.
+ */
+#define local_dcache_block_flush(addr) \
+	local_dcache_range_flush(addr, addr + L1_CACHE_BYTES)
+#define local_dcache_block_inv(addr) \
+	local_dcache_range_inv(addr, addr + L1_CACHE_BYTES)
+#define local_icache_block_inv(addr) \
+	local_icache_range_inv(addr, addr + L1_CACHE_BYTES)
+
 /*
  * Synchronizes caches. Whenever a cpu writes executable code to memory, this
  * should be called to make sure the processor sees the newly written code.
diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
index 82f5d4c06314..3cfc4cf0b019 100644
--- a/arch/openrisc/include/asm/cpuinfo.h
+++ b/arch/openrisc/include/asm/cpuinfo.h
@@ -15,6 +15,9 @@
 #ifndef __ASM_OPENRISC_CPUINFO_H
 #define __ASM_OPENRISC_CPUINFO_H
 
+#include <asm/spr.h>
+#include <asm/spr_defs.h>
+
 struct cache_desc {
 	u32 size;
 	u32 sets;
@@ -34,4 +37,9 @@ struct cpuinfo_or1k {
 extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
 extern void setup_cpuinfo(void);
 
+/*
+ * Check if the cache component exists.
+ */
+extern bool cpu_cache_is_present(const unsigned int cache_type);
+
 #endif /* __ASM_OPENRISC_CPUINFO_H */
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index b3edbb33b621..3a7b5baaa450 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -17,6 +17,7 @@
 #include <linux/pagewalk.h>
 
 #include <asm/cpuinfo.h>
+#include <asm/cacheflush.h>
 #include <asm/spr_defs.h>
 #include <asm/tlbflush.h>
 
@@ -24,9 +25,6 @@ static int
 page_set_nocache(pte_t *pte, unsigned long addr,
 		 unsigned long next, struct mm_walk *walk)
 {
-	unsigned long cl;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
 	pte_val(*pte) |= _PAGE_CI;
 
 	/*
@@ -36,8 +34,7 @@ page_set_nocache(pte_t *pte, unsigned long addr,
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
 	/* Flush page out of dcache */
-	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBFR, cl);
+	local_dcache_range_flush(__pa(addr), __pa(next));
 
 	return 0;
 }
@@ -98,21 +95,14 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
 		enum dma_data_direction dir)
 {
-	unsigned long cl;
-	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
-
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
-		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo->dcache_block_size)
-			mtspr(SPR_DCBFR, cl);
+		local_dcache_range_flush(addr, addr + size);
 		break;
 	case DMA_FROM_DEVICE:
 		/* Invalidate the dcache for the requested range */
-		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo->dcache_block_size)
-			mtspr(SPR_DCBIR, cl);
+		local_dcache_range_inv(addr, addr + size);
 		break;
 	default:
 		/*
diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index eb43b73f3855..7bdd07cfca60 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -14,31 +14,70 @@
 #include <asm/spr_defs.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
+#include <asm/cpuinfo.h>
 #include <asm/tlbflush.h>
 
-static __always_inline void cache_loop(struct page *page, const unsigned int reg)
+/*
+ * Check if the cache component exists.
+ */
+bool cpu_cache_is_present(const unsigned int cache_type)
 {
-	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
-	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
+	unsigned long upr = mfspr(SPR_UPR);
+	unsigned long mask = SPR_UPR_UP | cache_type;
+
+	return !((upr & mask) ^ mask);
+}
+
+static __always_inline void cache_loop(unsigned long paddr, unsigned long end,
+				       const unsigned int reg, const unsigned int cache_type)
+{
+	if (!cpu_cache_is_present(cache_type))
+		return;
 
-	while (line < paddr + PAGE_SIZE) {
-		mtspr(reg, line);
-		line += L1_CACHE_BYTES;
+	while (paddr < end) {
+		mtspr(reg, paddr);
+		paddr += L1_CACHE_BYTES;
 	}
 }
 
+static void cache_loop_page(struct page *page, const unsigned int reg,
+					    const unsigned int cache_type)
+{
+	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
+	unsigned long end = paddr + PAGE_SIZE;
+
+	paddr &= ~(L1_CACHE_BYTES - 1);
+
+	cache_loop(paddr, end, reg, cache_type);
+}
+
 void local_dcache_page_flush(struct page *page)
 {
-	cache_loop(page, SPR_DCBFR);
+	cache_loop_page(page, SPR_DCBFR, SPR_UPR_DCP);
 }
 EXPORT_SYMBOL(local_dcache_page_flush);
 
 void local_icache_page_inv(struct page *page)
 {
-	cache_loop(page, SPR_ICBIR);
+	cache_loop_page(page, SPR_ICBIR, SPR_UPR_ICP);
 }
 EXPORT_SYMBOL(local_icache_page_inv);
 
+void local_dcache_range_flush(unsigned long start, unsigned long end)
+{
+	cache_loop(start, end, SPR_DCBFR, SPR_UPR_DCP);
+}
+
+void local_dcache_range_inv(unsigned long start, unsigned long end)
+{
+	cache_loop(start, end, SPR_DCBIR, SPR_UPR_DCP);
+}
+
+void local_icache_range_inv(unsigned long start, unsigned long end)
+{
+	cache_loop(start, end, SPR_ICBIR, SPR_UPR_ICP);
+}
+
 void update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t *pte)
 {
@@ -58,4 +97,3 @@ void update_cache(struct vm_area_struct *vma, unsigned long address,
 			sync_icache_dcache(folio_page(folio, nr));
 	}
 }
-
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d0cb1a0126f9..46b8720db08e 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -35,6 +35,7 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
+#include <asm/cacheflush.h>
 
 int mem_init_done;
 
@@ -176,8 +177,8 @@ void __init paging_init(void)
 	barrier();
 
 	/* Invalidate instruction caches after code modification */
-	mtspr(SPR_ICBIR, 0x900);
-	mtspr(SPR_ICBIR, 0xa00);
+	local_icache_block_inv(0x900);
+	local_icache_block_inv(0xa00);
 
 	/* New TLB miss handlers and kernel page tables are in now place.
 	 * Make sure that page flags get updated for all pages in TLB by
-- 
2.48.1

