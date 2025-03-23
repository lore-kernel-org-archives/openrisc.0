Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982F5BAF0;
	Sun, 23 Mar 2025 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759807; cv=none; b=hy0NB2iG9ORFtGJGc8k8d+2FUMbmikI4UbG6ZVPTn4dVFYC8f2Kg8D0j9znHn22LsQ6zDiETQEAzR7BaJlSGwi/ajiL5nmxhtVMwgHPhcO4kkNtuTUe8vi7ZoVNewRgTu4XQM4nqAwgzdNGRkF8AZzvNZ3pDf/LiaUJOscSfHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759807; c=relaxed/simple;
	bh=/tuvBDoYBoODPZ9otJ9lqBlVvRSKuUAnXBsxnGQkXX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhWxLCjQg82bY6MzhWNZqXpr9SY5AHYPgRJP8DBWb5QxN8jLB4xisBn6+eZp+/fIPoaW34oCsD1xvNE7YN0EBFUewD6leoishNZZCfGJYCOD1xyvBkFPzOnvFVX0a1VnCUGqLYZmgpZhs2Gyg1rEBGS+IwEm3sC1hOcbmNsTBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4qZD1og; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4qZD1og"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so62540035ad.1;
        Sun, 23 Mar 2025 12:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742759805; x=1743364605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKRQmWFVI7/S9BoD1LHaFkf6R1ry6+yM4G5vBFGlLOk=;
        b=S4qZD1og4k5WhXVaIp6U7cAh+6QF/5jm2ibhi8bVwkBHQYdE17gpZwI36G9E+ZPWIU
         dlD30wXp9c4UpTSO3b8i1w76MThDEUxXzro9OwggpODq9TyUOWSn/zkggN2Ra4opko0W
         rVwIbcXV+gTjl2JLB9ecFeK5ZG/OP3WpxFGWElgRNP3awFK50SRhHAf4OPK291PSkMOJ
         SmXcG50IsqHXHig31UslEhya9zMkMkzdtmXviNO6LSBFMUuTcWusD7ZFQv0APF3Mbbup
         JJoOJ0d5WrPuqzgb05DawtV6C8SK4S1N/2ssOHQoychJhh0rdV9KLYZCwtRo4PNJ/xrT
         cqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742759805; x=1743364605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKRQmWFVI7/S9BoD1LHaFkf6R1ry6+yM4G5vBFGlLOk=;
        b=FLiLwCuCPsdnAbpPc5py1hZiajKid/rVnrEZJZNgypHPTqOjMkFyiHAq2OAdPxhBjm
         XBI/JH8855EKNXhoPWV+PsjwOpsp48mJhkw7Hvqiuy8QCRgZcDTP7LuMmPuufj6eA4FE
         kgKi8AizLKq3/iQ1HqJiu7RVsC8qghK5UopUSog0qGmx87Ab6prjMju27I0NQt76HVrI
         1dBcLAoEN2ov8aXOISIIjB5oIDPMQfWLOgOfsDT7Hd+Tjh1pm3E4IVQE+xvfYaSOSJqH
         j9oV66xBBo1hiFVnc8/GfuSuWwlpJfRJjYJN1jT49W+MqK/8p/B0Ys9Ba3oSeOdR+FeN
         y/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU5OD6tVeKKmW/KnMh9uCetbro7R7/xNgMAL7qlNg5BRT/bLwQMKJnlvpoh3/VsE6taRevOayvcgMJzpQg=@vger.kernel.org, AJvYcCUbh7jQudekily9J1akx8dODBFjunKTQg8r2AQlT0bXsP1LiEsJQkiP8LIQPpzb3qXKSv3DO10GJbtfR23lYzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFeBOL2Fod1E6nyHpRLPSsgMkaQOInWT5ZRWKOhu5TuT6LFbj
	bevqa5/V0dPnUJF9iiKQVN4ogvnNq85VXO9C+ucMAf2GYUaIFK0G
X-Gm-Gg: ASbGncuPelabKUxYaWyWzrj5KvP3ggk0hj8DnsXHATUNRI2t8AJQuFgNp0tpzq8skAI
	KLb3PJHixPhWS4u4iE+Ls2KDvD6OtqfLAFtrCF6XQvcMkdBGXlMF5akjfDIegdR/m7YovTX9+E8
	3B8t2On9kfUsGomHTI4HuUPn1wUqTx1lhWs2eTiJCuJ1M2LSRasydz5CEYrr/SIvjbkQUdGnU6i
	T96GLILhXDs/Jqc9A8mWiXoalkEN4QKfuPBT/dE4knYiz5SoXVpMqRTA+VErMcE0yr63RfYboPO
	63QaBVOAvmxfSl9nzIPj7rUgRXUTW3J9/8+qYrI=
X-Google-Smtp-Source: AGHT+IGMp0LlCuUTF5+Hhr3JfKpkWIqH280534EM37rpGdpcoSAaFkQj5Kq/wSsK1jxBU6aGWIhJsQ==
X-Received: by 2002:a17:902:e891:b0:223:4d7e:e523 with SMTP id d9443c01a7336-22780e390eemr147118085ad.50.1742759804580;
        Sun, 23 Mar 2025 12:56:44 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f5047csm55582875ad.99.2025.03.23.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:56:44 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] openrisc: Introduce new utility functions to flush and invalidate caches
Date: Mon, 24 Mar 2025 01:25:43 +0530
Message-ID: <20250323195544.152948-3-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250323195544.152948-1-sahilcdq@proton.me>
References: <20250323195544.152948-1-sahilcdq@proton.me>
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

 arch/openrisc/include/asm/cacheflush.h | 17 +++++++++
 arch/openrisc/include/asm/cpuinfo.h    | 42 +++++++++++++++++++++
 arch/openrisc/kernel/dma.c             | 18 ++-------
 arch/openrisc/mm/cache.c               | 52 ++++++++++++++++++++++----
 arch/openrisc/mm/init.c                |  5 ++-
 5 files changed, 110 insertions(+), 24 deletions(-)

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
index 82f5d4c06314..7839c41152af 100644
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
@@ -34,4 +37,43 @@ struct cpuinfo_or1k {
 extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
 extern void setup_cpuinfo(void);
 
+/*
+ * Check if the cache component exists.
+ */
+static inline bool cpu_cache_is_present(const unsigned int cache_type)
+{
+	unsigned long upr = mfspr(SPR_UPR);
+
+	return !!(upr & (SPR_UPR_UP | cache_type));
+}
+
+/*
+ * Check if the cache block flush/invalidate register is implemented for the
+ * cache component.
+ */
+static inline bool cb_inv_flush_is_implemented(const unsigned int reg,
+					       const unsigned int cache_type)
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
+	 * The cache block flush register is not implemented for the instruction cache.
+	 */
+	if (cache_type == SPR_UPR_ICP) {
+		cfgr = mfspr(SPR_ICCFGR);
+		return !!(cfgr & SPR_ICCFGR_CBIRI);
+	}
+
+	return false;
+}
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
index eb43b73f3855..aca64c5a20b3 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -14,31 +14,67 @@
 #include <asm/spr_defs.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
+#include <asm/cpuinfo.h>
 #include <asm/tlbflush.h>
 
-static __always_inline void cache_loop(struct page *page, const unsigned int reg)
+static __always_inline void cache_loop(struct page *page, unsigned long *start,
+				       unsigned long *end, const unsigned int reg,
+				       const unsigned int cache_type)
 {
-	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
-	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
+	unsigned long paddr, next;
 
-	while (line < paddr + PAGE_SIZE) {
-		mtspr(reg, line);
-		line += L1_CACHE_BYTES;
+	if (!cpu_cache_is_present(cache_type))
+		return;
+
+	if (!cb_inv_flush_is_implemented(reg, cache_type))
+		return;
+
+	if (page) {
+		paddr = page_to_pfn(page) << PAGE_SHIFT;
+		next = paddr + PAGE_SIZE;
+		paddr &= ~(L1_CACHE_BYTES - 1);
+	} else if (start && end) {
+		paddr = *start;
+		next = *end;
+	} else {
+		printk(KERN_ERR "Missing start and/or end address.\n");
+		return;
+	}
+
+	while (paddr < next) {
+		mtspr(reg, paddr);
+		paddr += L1_CACHE_BYTES;
 	}
 }
 
 void local_dcache_page_flush(struct page *page)
 {
-	cache_loop(page, SPR_DCBFR);
+	cache_loop(page, NULL, NULL, SPR_DCBFR, SPR_UPR_DCP);
 }
 EXPORT_SYMBOL(local_dcache_page_flush);
 
 void local_icache_page_inv(struct page *page)
 {
-	cache_loop(page, SPR_ICBIR);
+	cache_loop(page, NULL, NULL, SPR_ICBIR, SPR_UPR_ICP);
 }
 EXPORT_SYMBOL(local_icache_page_inv);
 
+void local_dcache_range_flush(unsigned long start, unsigned long end)
+{
+	cache_loop(NULL, &start, &end, SPR_DCBFR, SPR_UPR_DCP);
+}
+
+void local_dcache_range_inv(unsigned long start, unsigned long end)
+{
+	cache_loop(NULL, &start, &end, SPR_DCBIR, SPR_UPR_DCP);
+}
+
+void local_icache_range_inv(unsigned long start, unsigned long end)
+{
+	cache_loop(NULL, &start, &end, SPR_ICBIR, SPR_UPR_ICP);
+}
+
+
 void update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t *pte)
 {
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

