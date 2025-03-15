Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE3197A8E;
	Sat, 15 Mar 2025 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742071244; cv=none; b=fVDquV9V3jelvTRjjtbomJ52084jzWXu7zS/iCyJc9mZccHPsatxotdTe4S8VNsd1+kt1xZJhQCVh5NRlZvOxxNnRSYepxlhutsQfvwYoVsxKLNJpS4eKYx2CEpv1IZOKS3010XJyNDxV0oaFAo5p5mJ5cUz59J1HoXoZCJrivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742071244; c=relaxed/simple;
	bh=JQbHKVr3AZ3SqxNPzfMQushUce0ISxSq4kKUlnmpm48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=broCwP2w9Dte5f9WgxgGsaa7EUmB3+abFDj4+7eu6apt1yTCyTMuIEDVZo7qCSIcDFMPyNyRXhoAm5yetTraNlrdaM744NOSZ+ZxeFFPAzIG+KbrKUplHWp9QNSB2bmdTb4wW1J4OXkOWTnfUrng0PROSuKsStK0hacQUajTseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFP5DUuN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFP5DUuN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so1184609a91.1;
        Sat, 15 Mar 2025 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742071242; x=1742676042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=guYFr3umoeFA05qXG+H+HwzgmpLD5P6sWBSoolE/CcI=;
        b=OFP5DUuNcb9HZc4bBfG/efyYAHCl18Ks/SU5kAR+RRmWq1USJ7MLAdUsQV+rb0XPY6
         IEVc4DEkbX2eQwc0es4hlAOxc1yf7FCPeAhmopyOrYA0hjWSSWb/BTgibj8WypfBXUfv
         MkxUOEdkTO3yW2PJ/htT9yXQ5HPVcG6ddbe9lPYY6Sg1vFwynBN3m0P0PyoDyRE43n7C
         wlLtMew52fAVR94RlQIdtmMk40QaaKBjl6SHl2UVleODVlxoNyOHh9Rwvw5AANnh1RVZ
         lpjkp8iNbfEueq76CFy5jqaS73K6Z7pJR8WVsQbuOPxrWJcy/J7HGpPTf2BRuRHURZE+
         qZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742071242; x=1742676042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guYFr3umoeFA05qXG+H+HwzgmpLD5P6sWBSoolE/CcI=;
        b=w4V4VOqItoEpR5XwWytJva27Xm0TJSjDRjnxPlRU6NysOnT1N6zXzq2HveqiOtWNZq
         0db/8yYtS3I7meGTCi4hCj+TaoZf4vqusPyAUfGMh2lO0kGXjaMRh3x4tK6KraM1cVun
         tV/dTrUqxtm20Igb3cUY+toB+szVFg8IiLKJdfEDRVYXr7v6el6VGe5h+/mYzthz4EyW
         dFqV3F2ST2LvnmhKkZYaQAszrQm6DtR6J+9N8MeQ9RRMNNwlse7/rbkrLUOGEnQe95B0
         yHOentHg0RVcvMMN6eobzOTxKLVQENZGwzgqtfiV0B8d54uLKrd8K/JBYPEOcI1HugNU
         MWBg==
X-Forwarded-Encrypted: i=1; AJvYcCWolm8IWilkjwksc0uZHfRvQ7Doye00j8zaw6a9StJyMg/QVHO8tyOFJ8zRGUrEONLYJZLLiZ+FzYqOA6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWboTDlCmot1WhXhTQ/Do8VyXHeIB2j3Pe4aftPB+0cL7bgLO6
	lBJHTiSrh29G7gQuEXPzfx6qa1XCXWnr7obMpDami1qYmBNA40dl
X-Gm-Gg: ASbGnctYfRFh1w4KJwD1ML+e90Bi51RjKtqGPH9da94jm3e21Kzz6Hmbx2Mn07Fh9JY
	DCkX28mnCwkvXc/4g1IcgqAHsj3iFlZrE85gDs91kxKKAoeFsAnBJNyuQ3oCNvRdtIEARp0gdub
	BJkJo4z7PImJb7Kkk6jf4AclukoBxZLdGtIn/M2vrkuwKQF+quf+9fOP1Zl6ZHsPWiOuPVl1393
	r4HQU2fwnb0d+cxBnhnglQ2e8KWbsjCfD1Mps904qloH1tritJoQGTgm0bvd3Z+xI5TBojlVmFd
	3h5B/js=
X-Google-Smtp-Source: AGHT+IF8yGO7NFQidQ6FC90Rh3s1y++zEiBiYKT60nVfkl8l1shwg85K+QplzpjoaivJUaRKjmaYIg==
X-Received: by 2002:a17:90b:3804:b0:2fa:4926:d18d with SMTP id 98e67ed59e1d1-30135f4cf2bmr14744695a91.13.1742071241786;
        Sat, 15 Mar 2025 13:40:41 -0700 (PDT)
Received: from valdaarhun.. ([182.48.208.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153631fa8sm3141753a91.33.2025.03.15.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:40:41 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq@proton.me>
Subject: [PATCH v2] openrisc: Add cacheinfo support
Date: Sun, 16 Mar 2025 02:09:37 +0530
Message-ID: <20250315203937.77017-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cacheinfo support for OpenRISC.

Currently, a few CPU cache attributes pertaining to OpenRISC processors
are exposed along with other unrelated CPU attributes in the procfs file
system (/proc/cpuinfo). However, a few cache attributes remain unexposed.
An attempt is also made to pull these CPU cache attributes without
detecting if the relevant cache exists.

This patch provides a mechanism that the generic cacheinfo infrastructure
can employ to expose these attributes via the sysfs file system. These
attributes are exposed in /sys/devices/system/cpu/cpuX/cache/indexN.
Cache attributes are pulled only when the cache component is detected.

The implementation to pull cache attributes from the processor's
registers has been moved from arch/openrisc/kernel/setup.c with a few
modifications.

The patch also moves cache-related fields out of struct cpuinfo_or1k and
into its own struct to keep the implementation straightforward. This
reduces duplication of cache-related fields while keeping cpuinfo_or1k
extensible in case more cache descriptors are added in the future.

This implementation is based on similar work done for MIPS and LoongArch.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v1 -> v2:
- Changed patch prefix from RFC to PATCH.
- cacheinfo.c: Print number of sets. Remove integer padding.
- dma.c
  (page_set_nocache): Access cache attributes only if component exists.
  (arch_sync_dma_for_device): Likewise.
- cache.c: Likewise.
- init.c: Likewise.

 arch/openrisc/include/asm/cpuinfo.h |  16 +++--
 arch/openrisc/kernel/Makefile       |   2 +-
 arch/openrisc/kernel/cacheinfo.c    | 106 ++++++++++++++++++++++++++++
 arch/openrisc/kernel/dma.c          |  22 +++---
 arch/openrisc/kernel/setup.c        |  45 ------------
 arch/openrisc/mm/cache.c            |  11 ++-
 arch/openrisc/mm/init.c             |   8 ++-
 7 files changed, 144 insertions(+), 66 deletions(-)
 create mode 100644 arch/openrisc/kernel/cacheinfo.c

diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
index 5e4744153d0e..82f5d4c06314 100644
--- a/arch/openrisc/include/asm/cpuinfo.h
+++ b/arch/openrisc/include/asm/cpuinfo.h
@@ -15,16 +15,18 @@
 #ifndef __ASM_OPENRISC_CPUINFO_H
 #define __ASM_OPENRISC_CPUINFO_H
 
+struct cache_desc {
+	u32 size;
+	u32 sets;
+	u32 block_size;
+	u32 ways;
+};
+
 struct cpuinfo_or1k {
 	u32 clock_frequency;
 
-	u32 icache_size;
-	u32 icache_block_size;
-	u32 icache_ways;
-
-	u32 dcache_size;
-	u32 dcache_block_size;
-	u32 dcache_ways;
+	struct cache_desc icache;
+	struct cache_desc dcache;
 
 	u16 coreid;
 };
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 79129161f3e0..e4c7d9bdd598 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y	:= vmlinux.lds
 
 obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
-	   sys_call_table.o unwinder.o
+	   sys_call_table.o unwinder.o cacheinfo.o
 
 obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff --git a/arch/openrisc/kernel/cacheinfo.c b/arch/openrisc/kernel/cacheinfo.c
new file mode 100644
index 000000000000..6bb81e246f7e
--- /dev/null
+++ b/arch/openrisc/kernel/cacheinfo.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * OpenRISC cacheinfo support
+ *
+ * Based on work done for MIPS and LoongArch. All original copyrights
+ * apply as per the original source declaration.
+ *
+ * OpenRISC implementation:
+ * Copyright (C) 2025 Sahil Siddiq <sahilcdq@proton.me>
+ */
+
+#include <linux/cacheinfo.h>
+#include <asm/cpuinfo.h>
+#include <asm/spr.h>
+#include <asm/spr_defs.h>
+
+static inline void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
+				unsigned int level, struct cache_desc *cache, int cpu)
+{
+	this_leaf->type = type;
+	this_leaf->level = level;
+	this_leaf->coherency_line_size = cache->block_size;
+	this_leaf->number_of_sets = cache->sets;
+	this_leaf->ways_of_associativity = cache->ways;
+	this_leaf->size = cache->size;
+	cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
+}
+
+int init_cache_level(unsigned int cpu)
+{
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	int leaves = 0, levels = 0;
+	unsigned long upr = mfspr(SPR_UPR);
+	unsigned long iccfgr, dccfgr;
+
+	if (!(upr & SPR_UPR_UP)) {
+		printk(KERN_INFO
+		       "-- no UPR register... unable to detect configuration\n");
+		return -ENOENT;
+	}
+
+	if (upr & SPR_UPR_DCP) {
+		dccfgr = mfspr(SPR_DCCFGR);
+		cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
+		cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
+		cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
+		cpuinfo->dcache.size =
+		    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
+		leaves += 1;
+		printk(KERN_INFO
+		       "-- dcache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
+		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
+			   cpuinfo->dcache.sets,
+		       cpuinfo->dcache.ways);
+	} else
+		printk(KERN_INFO "-- dcache disabled\n");
+
+	if (upr & SPR_UPR_ICP) {
+		iccfgr = mfspr(SPR_ICCFGR);
+		cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
+		cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
+		cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
+		cpuinfo->icache.size =
+		    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
+		leaves += 1;
+		printk(KERN_INFO
+		       "-- icache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
+		       cpuinfo->icache.size, cpuinfo->icache.block_size,
+			   cpuinfo->icache.sets,
+		       cpuinfo->icache.ways);
+	} else
+		printk(KERN_INFO "-- icache disabled\n");
+
+	if (!leaves)
+		return -ENOENT;
+
+	levels = 1;
+
+	this_cpu_ci->num_leaves = leaves;
+	this_cpu_ci->num_levels = levels;
+
+	return 0;
+}
+
+int populate_cache_leaves(unsigned int cpu)
+{
+	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	int level = 1;
+
+	if (cpuinfo->dcache.ways) {
+		ci_leaf_init(this_leaf, CACHE_TYPE_DATA, level, &cpuinfo->dcache, cpu);
+		this_leaf->attributes = ((mfspr(SPR_DCCFGR) & SPR_DCCFGR_CWS) >> 8) ?
+					CACHE_WRITE_BACK : CACHE_WRITE_THROUGH;
+		this_leaf++;
+	}
+
+	if (cpuinfo->icache.ways)
+		ci_leaf_init(this_leaf, CACHE_TYPE_INST, level, &cpuinfo->icache, cpu);
+
+	this_cpu_ci->cpu_map_populated = true;
+
+	return 0;
+}
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index b3edbb33b621..ffb161e41e9d 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -36,8 +36,10 @@ page_set_nocache(pte_t *pte, unsigned long addr,
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
 	/* Flush page out of dcache */
-	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
-		mtspr(SPR_DCBFR, cl);
+	if (cpuinfo->dcache.ways) {
+		for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache.block_size)
+			mtspr(SPR_DCBFR, cl);
+	}
 
 	return 0;
 }
@@ -104,15 +106,19 @@ void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
-		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo->dcache_block_size)
-			mtspr(SPR_DCBFR, cl);
+		if (cpuinfo->dcache.ways) {
+			for (cl = addr; cl < addr + size;
+			     cl += cpuinfo->dcache.block_size)
+				mtspr(SPR_DCBFR, cl);
+		}
 		break;
 	case DMA_FROM_DEVICE:
 		/* Invalidate the dcache for the requested range */
-		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo->dcache_block_size)
-			mtspr(SPR_DCBIR, cl);
+		if (cpuinfo->dcache.ways) {
+			for (cl = addr; cl < addr + size;
+			     cl += cpuinfo->dcache.block_size)
+				mtspr(SPR_DCBIR, cl);
+		}
 		break;
 	default:
 		/*
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index be56eaafc8b9..38172c0989cf 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -107,27 +107,6 @@ static void print_cpuinfo(void)
 	printk(KERN_INFO "CPU: OpenRISC-%x (revision %d) @%d MHz\n",
 	       version, revision, cpuinfo->clock_frequency / 1000000);
 
-	if (!(upr & SPR_UPR_UP)) {
-		printk(KERN_INFO
-		       "-- no UPR register... unable to detect configuration\n");
-		return;
-	}
-
-	if (upr & SPR_UPR_DCP)
-		printk(KERN_INFO
-		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
-		       cpuinfo->dcache_size, cpuinfo->dcache_block_size,
-		       cpuinfo->dcache_ways);
-	else
-		printk(KERN_INFO "-- dcache disabled\n");
-	if (upr & SPR_UPR_ICP)
-		printk(KERN_INFO
-		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
-		       cpuinfo->icache_size, cpuinfo->icache_block_size,
-		       cpuinfo->icache_ways);
-	else
-		printk(KERN_INFO "-- icache disabled\n");
-
 	if (upr & SPR_UPR_DMP)
 		printk(KERN_INFO "-- dmmu: %4d entries, %lu way(s)\n",
 		       1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
@@ -155,8 +134,6 @@ static void print_cpuinfo(void)
 void __init setup_cpuinfo(void)
 {
 	struct device_node *cpu;
-	unsigned long iccfgr, dccfgr;
-	unsigned long cache_set_size;
 	int cpu_id = smp_processor_id();
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
 
@@ -164,20 +141,6 @@ void __init setup_cpuinfo(void)
 	if (!cpu)
 		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
 
-	iccfgr = mfspr(SPR_ICCFGR);
-	cpuinfo->icache_ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
-	cache_set_size = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
-	cpuinfo->icache_block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
-	cpuinfo->icache_size =
-	    cache_set_size * cpuinfo->icache_ways * cpuinfo->icache_block_size;
-
-	dccfgr = mfspr(SPR_DCCFGR);
-	cpuinfo->dcache_ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
-	cache_set_size = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
-	cpuinfo->dcache_block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
-	cpuinfo->dcache_size =
-	    cache_set_size * cpuinfo->dcache_ways * cpuinfo->dcache_block_size;
-
 	if (of_property_read_u32(cpu, "clock-frequency",
 				 &cpuinfo->clock_frequency)) {
 		printk(KERN_WARNING
@@ -320,14 +283,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "revision\t\t: %d\n", vr & SPR_VR_REV);
 	}
 	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
-	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache_size);
-	seq_printf(m, "dcache block size\t: %d bytes\n",
-		   cpuinfo->dcache_block_size);
-	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache_ways);
-	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache_size);
-	seq_printf(m, "icache block size\t: %d bytes\n",
-		   cpuinfo->icache_block_size);
-	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache_ways);
 	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
 		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
 		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index eb43b73f3855..acdf2dc256bf 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -16,10 +16,15 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-static __always_inline void cache_loop(struct page *page, const unsigned int reg)
+static __always_inline void cache_loop(struct page *page, const unsigned int reg,
+				       const unsigned int cache_type)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
 	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
+	unsigned long upr = mfspr(SPR_UPR);
+
+	if (!(upr & SPR_UPR_UP & cache_type))
+		return;
 
 	while (line < paddr + PAGE_SIZE) {
 		mtspr(reg, line);
@@ -29,13 +34,13 @@ static __always_inline void cache_loop(struct page *page, const unsigned int reg
 
 void local_dcache_page_flush(struct page *page)
 {
-	cache_loop(page, SPR_DCBFR);
+	cache_loop(page, SPR_DCBFR, SPR_UPR_DCP);
 }
 EXPORT_SYMBOL(local_dcache_page_flush);
 
 void local_icache_page_inv(struct page *page)
 {
-	cache_loop(page, SPR_ICBIR);
+	cache_loop(page, SPR_ICBIR, SPR_UPR_ICP);
 }
 EXPORT_SYMBOL(local_icache_page_inv);
 
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d0cb1a0126f9..bbe16546c5b9 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -124,6 +124,7 @@ static void __init map_ram(void)
 void __init paging_init(void)
 {
 	int i;
+	unsigned long upr;
 
 	printk(KERN_INFO "Setting up paging and PTEs.\n");
 
@@ -176,8 +177,11 @@ void __init paging_init(void)
 	barrier();
 
 	/* Invalidate instruction caches after code modification */
-	mtspr(SPR_ICBIR, 0x900);
-	mtspr(SPR_ICBIR, 0xa00);
+	upr = mfspr(SPR_UPR);
+	if (upr & SPR_UPR_UP & SPR_UPR_ICP) {
+		mtspr(SPR_ICBIR, 0x900);
+		mtspr(SPR_ICBIR, 0xa00);
+	}
 
 	/* New TLB miss handlers and kernel page tables are in now place.
 	 * Make sure that page flags get updated for all pages in TLB by
-- 
2.48.1

