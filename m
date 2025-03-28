Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFB1EB5D1;
	Fri, 28 Mar 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193620; cv=none; b=TXmBZ0JZDXID9ea7vFzxU3mj37FF5IRQ7W9l7q3+DJOfHd7H0skCHrvpoynN297QuKTxcRT+AUL8792/yzyGNly6B2IBFH/RVDO/lxWSL/ZpU2gWwUATK5/yPyTIIj7xc5a1WxC2982GOQrNrNg1Bskuy8Qa1PkKg/Z524KraaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193620; c=relaxed/simple;
	bh=cU49LllCR2c2J19/3QQQEpoEHMsFuSN4AL7e6oZg3+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4BVvjyN4gSCrNq7ZVIFDYzBrtSLH7JfTJW/r5GUjBZTLjtuBdE74NaBni7o38TqjfkLToFuUZmapdT7MxvxGMpl1uLrbL9fWHTnliwWT1it8h13eHP3iuIyNzC1hvbCNuNhLyL76mA720yGOB3jRjQSlN/cuBajq40HJo9eiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXazH8XJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXazH8XJ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30332dfc821so3923063a91.3;
        Fri, 28 Mar 2025 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743193618; x=1743798418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i62KwUTEJwwpzR5Bv3VSrTljN+UMWnhYxRXVWxNl3IM=;
        b=VXazH8XJNo66YtGX1mi/5LoYKFQMmhMVMAGo/Get0weSR3UIno/q8OvQA8cF1/ny3J
         Gz8ncp35RGV+5RvQfvBk4MFn0Tqwza0QrQbgL8yhts16JCHSGXeDIbLZLR1aem/PejDj
         Bp9OB/KPdCNYqDzbpSisX+r4PAN9GYmfXz8godSjuaDIBWcEzweEQIzVDiZv53iLL92S
         xRr6tomoUoNC15SpAYdDfONNHuGTatuEQ7XpbkLyLFupS7Bz2PUxZWlwrV27Pb4r1kDe
         6htxl7S4Owh4XAUHu4CNNv5TL7PreraYOnLXPBlnZehqm2Oe35wtIglL+zQv+hbwhp/s
         06JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743193618; x=1743798418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i62KwUTEJwwpzR5Bv3VSrTljN+UMWnhYxRXVWxNl3IM=;
        b=fYDCvxk6hORbY1YTKdgC4It0fe8gFwHEmt+pK21pn/UDmQh0D4J3siLpsdbWOLxCfN
         oJJ64Y0Dl17zMMmc7U4NsgildM83Ru4sCWXwOotzEzUqZJVH8eyKBdt2J6JTqSddTw0b
         byw79yNMElD3wJ/O1Ey5ZEDQRmRwlnvDfdZdrjYbqe+/soOxEOu2desJj+2gr4oc0Gop
         pfEKn4a658i07/aN6tZEzGnrqQyG+1fXVzVXTRM+zTShkck8OEcjhT+nkDme/1twE7Rf
         D6ZuipZUuTLQz6wmzaBxSYPkefN4okhy77DDhzyMq37T+V96quI+XrkzPKLm5K7opzKH
         YM9w==
X-Forwarded-Encrypted: i=1; AJvYcCWKhMsCLltLk6Vr5jP7wRusyTrJRCeNX17Z4ske+DdU7zJVU05XrKeOA63kHO0u8CJQUPe4UaDw0fpNGME=@vger.kernel.org, AJvYcCWtT2WWDmqwEDtRFIOtTp9fTM4PvhlD78SHOCx454kWR/aZD9QzV10t/ir1MpGDC4A8SpA7aScjfhIatzo46PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYU4cE3IvDN8/cD+DfO+VN70KWe9Runy8qjnbd1esHlb++p/eJ
	bZGPEkploYacyA5XlVQB0jG28lDyV4yijxHyq845NeOeLjxoR9wW
X-Gm-Gg: ASbGnct4QjmTD3pTJRZ/oKdUcqX8EMo8IbxbfHW+JKIup5LP7kZkmIc68bVe7UZ6dnr
	CPxEZiIzILxTmb9o/oKmrz1+CrLgjbqnfYhx3z3qBZ3UiPSiAS3RN79vREjLFeDEtS+kmrz9Qn7
	0D5sAr545X4DYZzw+k5pvompeRgKidDQmuEdDjv4w0dQw8o+IofuxnrqNBmaTEIcI7iej8vDoi5
	ofM//NhC+pSFg+mzRdy2t0dTDwAvpfHQ1EpR95ub3aVoyxa6aeYGoZ6pDsa2eKcOxnNjxAHkaIv
	KOexJAmO55K3yS3ypCL/8ahFuYfMctXGpe53QaI=
X-Google-Smtp-Source: AGHT+IEHfGkZE7Zy6W3sLVE72pb31CKXw4v3kI5wsgJC2jXrHywsmy5LRIYUebb1lVvvHewj4zEZUg==
X-Received: by 2002:a17:90a:c883:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-30531f94695mr982948a91.8.1743193617729;
        Fri, 28 Mar 2025 13:26:57 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d62c57sm2358889a91.28.2025.03.28.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:26:57 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] openrisc: Introduce new utility functions to flush and invalidate caches
Date: Sat, 29 Mar 2025 01:56:31 +0530
Message-ID: <20250328202632.72809-3-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328202632.72809-1-sahilcdq@proton.me>
References: <20250328202632.72809-1-sahilcdq@proton.me>
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

 arch/openrisc/include/asm/cacheflush.h | 17 +++++
 arch/openrisc/include/asm/cpuinfo.h    | 15 +++++
 arch/openrisc/kernel/dma.c             | 18 ++----
 arch/openrisc/mm/cache.c               | 87 +++++++++++++++++++++++---
 arch/openrisc/mm/init.c                |  5 +-
 5 files changed, 118 insertions(+), 24 deletions(-)

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
index 82f5d4c06314..e46afbfe9b5a 100644
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
@@ -34,4 +37,16 @@ struct cpuinfo_or1k {
 extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
 extern void setup_cpuinfo(void);
 
+/*
+ * Check if the cache component exists.
+ */
+extern bool cpu_cache_is_present(const unsigned int cache_type);
+
+/*
+ * Check if the cache block flush/invalidate register is implemented for the
+ * cache component.
+ */
+extern bool cb_inv_flush_is_implemented(const unsigned int reg,
+					const unsigned int cache_type);
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
index eb43b73f3855..3bf6d728d2d2 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -14,31 +14,63 @@
 #include <asm/spr_defs.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
+#include <asm/cpuinfo.h>
 #include <asm/tlbflush.h>
 
-static __always_inline void cache_loop(struct page *page, const unsigned int reg)
+static __always_inline void cache_loop(unsigned long paddr, unsigned long end,
+				       const unsigned int reg, const unsigned int cache_type)
 {
-	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
-	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
+	if (!cpu_cache_is_present(cache_type))
+		return;
+
+	if (!cb_inv_flush_is_implemented(reg, cache_type))
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
+
 void update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t *pte)
 {
@@ -59,3 +91,42 @@ void update_cache(struct vm_area_struct *vma, unsigned long address,
 	}
 }
 
+/*
+ * Check if the cache component exists.
+ */
+bool cpu_cache_is_present(const unsigned int cache_type)
+{
+	unsigned long upr = mfspr(SPR_UPR);
+
+	return !!(upr & (SPR_UPR_UP | cache_type));
+}
+
+ /*
+  * Check if the cache block flush/invalidate register is implemented for the
+  * cache component.
+  */
+bool cb_inv_flush_is_implemented(const unsigned int reg,
+				 const unsigned int cache_type)
+{
+	unsigned long cfgr;
+
+	if (cache_type == SPR_UPR_DCP) {
+		cfgr = mfspr(SPR_DCCFGR);
+		if (reg == SPR_DCBFR)
+			return !!(cfgr & SPR_DCCFGR_CBFRI);
+
+		if (reg == SPR_DCBIR)
+			return !!(cfgr & SPR_DCCFGR_CBIRI);
+	}
+
+	/*
+	 * The cache block flush register is not implemented for the instruction
+	 * cache.
+	 */
+	if (cache_type == SPR_UPR_ICP) {
+		cfgr = mfspr(SPR_ICCFGR);
+		return !!(cfgr & SPR_ICCFGR_CBIRI);
+	}
+
+	return false;
+}
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

