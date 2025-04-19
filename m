Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9372AEFE;
	Sat, 19 Apr 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745077751; cv=none; b=RlaCvX6LRqT1U1yp9jKpxgVgomdvvmTGm+8wKwQCVhIVGK2i5O9u07VIVsnz9NVIRSeRnLysoPpApW6QXWZpykvxbW2rEOKf65uvKV2/EqbwSTlFqQKdC67RDWZMeITR00XtwMDnfcNG7chX2h3xD8upr/XR9TwwtbHTjcXaAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745077751; c=relaxed/simple;
	bh=XrFFM38YkZP59a98NvcqYT8xogSkXbadbY49qgxIENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7FSyNHLpdME7eSC4wPvq2w28oPLR0MbcfgEQcHmNqicHqGE5R7FAcKICROliSZNKy3E2ek3j7kAE3x75SoRTyId9hNTNx3DjZHzD/RbSTchxMibyDAL2yWQxZhHNs6VFVWCvHPaQBek7Ya6novxPIGfvOoPypFxkMZT8SNUqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4oCQYdN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4oCQYdN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so42856475ad.0;
        Sat, 19 Apr 2025 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745077749; x=1745682549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89ouSf5j74jcdMywOrcUFJcRcgIPNPoWQh8ZRj8rrkI=;
        b=C4oCQYdN3lb8QdvsGkHyVE/HzRiYxCDndVLD6AotCAWBmhZaXmfcYvUn5roZ4UixeD
         w/WLDWI28PqFkx91CySDQySJQ9NnwCw2Et20z9LhSBnw0vyOx1TLLDYvQlI4R7S0uh3z
         xLjmPnJkDUAk5/Rmm6P0vmqtmbiVbXQf8bvmuawsjdM5q+cjRjf8MpsLUsLhptb1czF0
         ViHb0npScVTYcSo4SM59XoagySabJhEXjslgyL4SgVNgxFTFebzDYIo2eK20NWx6RkW3
         yth05uIBnHhCIZI8wrEvfQqbZ6KjncrxkY35rlFow3HYgXeBQ+1oY5PVCkLGl9WWd+BF
         Gtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745077749; x=1745682549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89ouSf5j74jcdMywOrcUFJcRcgIPNPoWQh8ZRj8rrkI=;
        b=WP9wwKaSpqPHqh3LVONh+ZS5mBNj1s3XUtqkX4OUqkAMU04xPnujZWKJ+OKo8R0N31
         A76OMY59ljIeyNbvVmTk2zeThAqvWOqBLues82q1yt6wElRuVPq78W7x8s75lKdlzEPT
         1guv9qHGTQ1M784Dxcysi/rmhHR+e+Nq9O/RkVaQO/WY/vdpdVO1kX+3PAAb8jYBVVfT
         GOKOdm6Ejlww/jN+nj6d9VwvYdqsujwHkdUMx+kimjtt38N1mdwoYjBd8QY1yYH7kwcK
         EQQGGjMA+rHl7tGL6op/8+g4obOZ3gKbLNpyUIi5w8mGVlT+rO8NaH+h9S2nLHrdL5v/
         Odig==
X-Forwarded-Encrypted: i=1; AJvYcCUJqotvSlVU1n1H0kfWTZP0sCBTOykGWp0ZpcurxP2NxE3k385D6KNdP3redflkukiBV8YGd8QSOhsbka0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQ7bCtkcjXN9uyqqOjfjdLQxJROiGAVBcnSk7e81txvBlgri1
	FeGTkDELJ7Ubxwb6L42aPy61SvHWyhZzlEkipWj9tS3hFspQAHNW
X-Gm-Gg: ASbGncveQ4pYX5rF7hwnTbJUNsChYvl3/EBaXLOm7iQZegCdG+/c4gjBW6pLkNCTZOY
	K2r55Iwblh+meUrLrXXowfPpAAaubZJCGjCZOZ18oYZNHZ2Rq2jCCPJg4HmErn6JBLOZ5Rj5tEN
	y+12ExQLbEI6VUAp8stpDCzgR7mvdo0wdNRYSTNgx1TFQnGdMxJ/5WIpJD/MOPCWntT2NafeHwK
	P+0Sb1HecOi/8sb6LhRXo7TyaBp8Gdtef7InoVos7DIlSY/7auInMg1V5E8smJ0ohGCLAWeCblQ
	ocW5/vXcN49+QlLeDkHWo3sHAyNwQQdapJKl
X-Google-Smtp-Source: AGHT+IG+ZZ2uccDiofqr2ED/bN/g3MNLqpJgaPDmV0Rhm4aX9+wgLPW2w/3G/OQ61P8n4DqrhR7HAw==
X-Received: by 2002:a17:902:cec8:b0:215:a179:14ca with SMTP id d9443c01a7336-22c5357a118mr86074435ad.2.1745077749023;
        Sat, 19 Apr 2025 08:49:09 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad42fsm3430658b3a.121.2025.04.19.08.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:49:08 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v6 2/3] openrisc: Introduce new utility functions to flush and invalidate caches
Date: Sat, 19 Apr 2025 21:18:18 +0530
Message-ID: <20250419154819.85063-3-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250419154819.85063-1-sahilcdq0@gmail.com>
References: <20250419154819.85063-1-sahilcdq0@gmail.com>
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

Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
Changes v5 -> v6:
- Changed 'From' and signed-off-by email addresses.
- cache.c:
  (cache_loop): Make 'reg' unsigned short.
  (cache_loop_page): Use __always_inline and make 'reg' unsigned short.

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
index eb43b73f3855..0f265b8e73ec 100644
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
+				       const unsigned short reg, const unsigned int cache_type)
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
 
+static __always_inline void cache_loop_page(struct page *page, const unsigned short reg,
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

