Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6001C5D7E;
	Mon, 10 Mar 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634074; cv=none; b=ZvtL9TqgB3HTF/2KjAbH2wHK+HqmSF9vLR7c7RtLc76dXUbUCP1IHZpWDkTnWZvPnJtxydcNACdtAP0PmIE3PN2cIdw56nCBAhZtOkSsa59pVxdOYRPmU0elBw8y+61HEaRuIPNzp1220OBB0IPE6f0SrjhayDQeoDmf+RJc7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634074; c=relaxed/simple;
	bh=xAbdviyCTnrJI8oYgkNiX9nx2BM+3z515w0KQa+KSfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J6lhGSN5Eb+cZd0BPhxpCKVa0IzAcJm7D4zotCaw27eC/Y7KMUgULK6LXLCuer+xM5Js4buo33ROJ437AGK2hWLUEf6RWNtQk1N7POj+R2zxfrFD0TZK4hOqZr5WqrYIkdHGgMw1FKTLnn+kuW30CtFCr2CqKybtKP5vBnnl83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB7+1Sfd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB7+1Sfd"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22423adf751so66183135ad.2;
        Mon, 10 Mar 2025 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741634072; x=1742238872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0NMGp+ecLFACTytolGrBr8tNdW01XGL37Z6gQqEImg=;
        b=JB7+1Sfduj2Spf14mLtxrKLDvnHcjV7UrQXkzHC5fdYh6ApwT8PQLPZtYuuLpQgzTJ
         /tAHp7sMqVq192/w70OJ58htNnA9YKCdc0jh3cw58ODFINt71XbJ+TI1HU0f+c/Zntfd
         3wrufu2oTNqrVzv0fXXnbseYOXI8/ncdbYF11ggArWY/pQH1B8dSjDe6jxeARtDDeLkJ
         dMI4VfLH0PIguHx+CFiRNmLewAHQYbsbQy6tZUuE9KyEV/8m7lB+AE0PZfB3OkNoynUS
         zuAPNFgTpA/DTwbTMkGe2gpV6Nq9iPC23H2t+7MueM6llzP6IApi0B3T7Vxt2BCm8E+x
         1INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741634072; x=1742238872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0NMGp+ecLFACTytolGrBr8tNdW01XGL37Z6gQqEImg=;
        b=FwEEw4c7n/4/9SAkdur2I0DG2FbSeXZnEDrZKavXQTsF/S0s7mz1tp2U93xPcYbDbN
         2VefWseQPyxg2F7171Qz+YI3VxmQM2BkLVzPvtZwJPNZP09iBcSUt86G3HPwNbxYwVLZ
         VV7YxGgJh8XRt6+3ndhjSgPc4102FHQbv+nPWEQjKOtxipdx9YwIZNU6ljTBAeepq0+V
         HjDPnCjJwi0g+TBK/26rxVn3paP8CwxMZ3rzaLZtvofqo8CYzc5KMf5CnkVjA9cWFYKu
         HVEAnboPmg9MaOs8wRNa69T7UJvjNEv2Veomh6KpGkZw41i/HWStTlkdQl+GaD12S7+j
         emTg==
X-Forwarded-Encrypted: i=1; AJvYcCUXytMcVWJQXbU+lPjyqUq82qw8+qGSE2Z2zaZzbSuNvHEv7fNEI/UVdj9bg1e9tloDM2DzF6b0K3WrGc6JXRM=@vger.kernel.org, AJvYcCW2wmUWRQLrF+r+hnF2i5vJ3D1xDicDbtHPL5ximxyWiohOBFCb98mR628tRj9riDLvgNUEs7l5bUFc9aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHAqCFjnEGvsA0HiBVBgOCmsBGs5J+HiM4mT4bDiaIKYe++b3
	0bhWNbmJjELsc9nwNR4QWiGAF9OAJAbUiWEvqr5A3Qt8b+S5tm/3
X-Gm-Gg: ASbGncvVkFYQbvzB2pbjTlSN7pcq47p+ZYWLPur4YzVXrGbJcvgi13v0nyACI3W6VV/
	mB1E0oLpOcyPULqW40/LlISaUPkmDUFEM5wGE3Jm3WM1KYwyGXkVmhO2JX3OqbA6u0cI0iwsqgT
	piOzjxW312a9Y0D/rS01/6Ah58NuuNycwdMh2ZTG/zeESZC1C7UklZEizEEYDjiLOzuXvQfrTN1
	fjLGqc48iOd5mnKkMnCU9tQyblhfngsj8i2zy6Sqvynb3JlKnkgHfL3cycGMbaqJT5Ho6x/fC0p
	LnbuTd4W0cZ7WPNDc1mUiEyIAGigkE8Bx1pLTo8=
X-Google-Smtp-Source: AGHT+IFfc08VZVdkMEzuHzdDdo/6wM+jZKHC7rGsPunIsyai+2aLRjdrVGz6myf3VCnJOvwZAYOpeQ==
X-Received: by 2002:a17:902:d552:b0:224:18b0:86a0 with SMTP id d9443c01a7336-22593185c4amr13264935ad.37.1741634071991;
        Mon, 10 Mar 2025 12:14:31 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c44:17c4:60cd:13a3:1039:5627])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e97d0sm82386695ad.79.2025.03.10.12.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:14:31 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] openrisc: Add cacheinfo support
Date: Tue, 11 Mar 2025 00:43:57 +0530
Message-ID: <20250310191358.67912-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Before applying these changes, there is no "cache" directory in
/sys/devices/system/cpu/cpu0. After applying these changes, the
cache directory is present and has the following hierarchy.

~ # tree /sys/devices/system/cpu/cpu0/cache/
/sys/devices/system/cpu/cpu0/cache/
├── index0
│   ├── coherency_line_size
│   ├── level
│   ├── number_of_sets
│   ├── shared_cpu_list
│   ├── shared_cpu_map
│   ├── size
│   ├── type
│   ├── uevent
│   ├── ways_of_associativity
│   └── write_policy
├── index1
│   ├── coherency_line_size
│   ├── level
│   ├── number_of_sets
│   ├── shared_cpu_list
│   ├── shared_cpu_map
│   ├── size
│   ├── type
│   ├── uevent
│   └── ways_of_associativity
└── uevent

The newly implemented "init_cache_level()" pulls the cache details by
reading the processor's special registers as it was being done in
setup.c.

None of the functions in drivers/base/cacheinfo.c that are capable of
pulling these details (e.g.: cache_size) have been used. This is because
they pull these details by reading properties present in the device tree
file. In setup.c, for example, the value of "clock-frequency" is pulled
from the device tree file.

Cache related properties are currently not present in OpenRISC's device
tree files.

Regarding the "shared_cpu_map" cache attribute, I wasn't able to find
anything in the OpenRISC architecture manual to indicate that processors
in a multi-processor system may share the same cache component. MIPS uses
"globalnumber" to detect siblings. LoongArch uses a "CACHE_PRIVATE" flag
to detect siblings sharing the same cache.

I am running with the assumption that every OpenRISC core has its own
icache and dcache. Given that OpenRISC does not support a multi-level
cache architecture and that icache and dcache are like L1 caches, I
think this assumption is reasonable. What are your thoughts on this?

Another issue I noticed is that the unit used in ...cache/indexN/size
is KB. The actual value of the size is right-shifted by 10 before being
reported. When testing these changes using QEMU (and without making any
modifications to the values stored in DCCFGR and ICCFGR), the cache size
is far smaller than 1KB. Consequently, this is reported as 0K. For cache
sizes smaller than 1KB, should something be done to report it in another
unit? Reporting 0K seems a little misleading.

Thanks,
Sahil

 arch/openrisc/include/asm/cpuinfo.h |  16 +++--
 arch/openrisc/kernel/Makefile       |   2 +-
 arch/openrisc/kernel/cacheinfo.c    | 104 ++++++++++++++++++++++++++++
 arch/openrisc/kernel/dma.c          |   6 +-
 arch/openrisc/kernel/setup.c        |  45 ------------
 5 files changed, 117 insertions(+), 56 deletions(-)
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
index 000000000000..515969896c20
--- /dev/null
+++ b/arch/openrisc/kernel/cacheinfo.c
@@ -0,0 +1,104 @@
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
+		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
+		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
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
+		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
+		       cpuinfo->icache.size, cpuinfo->icache.block_size,
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
index b3edbb33b621..5864c4c7a8b8 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -36,7 +36,7 @@ page_set_nocache(pte_t *pte, unsigned long addr,
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 
 	/* Flush page out of dcache */
-	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
+	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache.block_size)
 		mtspr(SPR_DCBFR, cl);
 
 	return 0;
@@ -105,13 +105,13 @@ void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
 	case DMA_TO_DEVICE:
 		/* Flush the dcache for the requested range */
 		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo->dcache_block_size)
+		     cl += cpuinfo->dcache.block_size)
 			mtspr(SPR_DCBFR, cl);
 		break;
 	case DMA_FROM_DEVICE:
 		/* Invalidate the dcache for the requested range */
 		for (cl = addr; cl < addr + size;
-		     cl += cpuinfo->dcache_block_size)
+		     cl += cpuinfo->dcache.block_size)
 			mtspr(SPR_DCBIR, cl);
 		break;
 	default:
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
-- 
2.48.1

