Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754F1B2194;
	Sat, 29 Mar 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241622; cv=none; b=o8fiDODghg0ihkAbNpChjluB//ewSBXHhiMYb0+kIQdxYJ0apWhcdG23eLKpRiMg1mPuxr84DY3QU0T8qzlm1C6JztoIteSscV8tFm6iHmnb5fZdp2/iaplQC7kWNTn9ethLs1sptr806CPmhYwhHBNvNnAq+pF4yuR0vhLzCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241622; c=relaxed/simple;
	bh=wQDzDPA+qW+Rg0Qk32WQ6KzPgriI/m9cGtZnihr/STw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKVcAGYt73lgFn9HcTMjrKoJtJhc5qlwVGiQIQQo9lbydHwleYq6Sy8sbfHUHlFc8/FMRjE209zSaWtPbRRk3XcqSO/z9xcMUts2PSBPDI96u7cgj8WAa9dE36dcpwcTcl0zLZ0E+/bF2yUTfqNuJW2DBJT/uvq/do13pL7gkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dflrB+4A; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dflrB+4A"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3031354f134so3981809a91.3;
        Sat, 29 Mar 2025 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743241619; x=1743846419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB//eABbA+sUDJU5vA5poS1PnshzB5aeueAsSvx051c=;
        b=dflrB+4A/QuFEzE8gRxJAlBHEB0gEi11/RLNttYuzmEP+4sKjPvqw1xixGO3KhyafU
         oTwkEng/2EWXPZ4k0WDJSWePb2SdnCa8/NrmqJec/tpAoTUyE0lWaEIJoYaNPERMBEGd
         rH5e7g4df3Go6oiXDqw08LIiFEAIFz/VKLKrzMb+fHNQzqhEr9IdkIf8zw+BqDYAkUsB
         YEVQ3fczbgUiBXGA2eIJBs3dvf/bfWTOnsKml8kC/S8M7cMRuFj5vXNCqAMD5R9TeXTH
         VhPNBbpkTz2UFbz0W9q4Tk85YceuuV8KIU/PZX6Vtajl1W5BWpAZFovcLeJT/SrhFHqi
         cRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743241619; x=1743846419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB//eABbA+sUDJU5vA5poS1PnshzB5aeueAsSvx051c=;
        b=aBNBcou/dToo4GNXHcjviNOwPEscH0M+mFDkvqg2nJcLFBpizouW3bAnRgPoUJYw26
         25X8X4Bd/l8zzxPGBEwUXebi2xpIce2NJrS9D9IXL5YYW2S3F1xUrtsVlGxeJaNCcafG
         1e2zcPWd2Y91Y/pb2ne9StXqxN7TifxSpvoZ1RbXziplsQWUaMeMZO0lX92gr7mupNd3
         OMpRP2ClI9FBSIOBcXlSRdp+SkSPFIQyuyAZ/zkIxU7pA5/lHyP3uT4uoKRx47E6OT2B
         JUZtil9DDGAooIJYnWssDB/GadaadkMLWBzbxVaXScz4PqD1EQMpESccf1o5xm2LXu6y
         N0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVsVsvGHs76jcRUsBqYovQzvppVPzQAlI3nIwyHlmXbBgdSB7vTBLxJoZ/RqPgB+ZGxQPRhTCxeb/ACfsg5JfI=@vger.kernel.org, AJvYcCXkSbta2EfRipoXh4T6056VN9WL1+IxfvHCi3cYCLCTTI2fK5ANOtj1dXZS51pLm5VP9ycYckf8Eu3YQAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAI9Rt2W/u1pTozYZT70Ydjj6QZnSyeOsOOVRi5JLh8CFe4118
	C7NNhl9Op9Jqvj8Hw+eB7uN0XmreeyTxhMkkILNKgWrye40QQ4B2OW3zzA==
X-Gm-Gg: ASbGncu+q4oyIy5KQfMeZolKuWAx9sZrhq2ag9yj8H04fjCkTjlPEuPA9Nu0aCA6qNW
	rwaRwJfLhMcYlVzfkw7I2y5ubXJqs4bGRpULLjYOjePum/9o/Qs12hs7gND1jLEvUqoSEvuD4kO
	BVQep+6kp61CoHAVgP/FcXzsqX+53aLVXty+TYJywZApY6Ugj8iaI7kNq1e5urRE8LM2uItIeQ/
	Ij2TomKgQP3SsRDsEukieQWAOpoTUh6M8LAvvTRck5C7bn1q1DR5zcD8ZbxWjw9rN8etGcrIgBY
	uLD9ad2d4va09K00uXRyN0ci4XzT/IyOnDlz
X-Google-Smtp-Source: AGHT+IFhiHEbEkkIPQFBMeCUjDSSg1wxyVGwnIeFvk8SxYJ8uNcnFZJ1JuTghes5dGWR+XcTMR+IfQ==
X-Received: by 2002:a17:90b:3c4f:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-30531f7c573mr3284391a91.5.1743241619525;
        Sat, 29 Mar 2025 02:46:59 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b31fbsm5680573a91.40.2025.03.29.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 02:46:59 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] openrisc: Add cacheinfo support
Date: Sat, 29 Mar 2025 15:16:22 +0530
Message-ID: <20250329094622.94919-4-sahilcdq@proton.me>
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

Add cacheinfo support for OpenRISC.

Currently, a few CPU cache attributes pertaining to OpenRISC processors
are exposed along with other unrelated CPU attributes in the procfs file
system (/proc/cpuinfo). However, a few cache attributes remain unexposed.

Provide a mechanism that the generic cacheinfo infrastructure can employ
to expose these attributes via the sysfs file system. These attributes
can then be exposed in /sys/devices/system/cpu/cpuX/cache/indexN. Move
the implementation to pull cache attributes from the processor's
registers from arch/openrisc/kernel/setup.c with a few modifications.

This implementation is based on similar work done for MIPS and LoongArch.

Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
No change from v4 -> v5.

Changes from v3 -> v4:
- arch/openrisc/kernel/cacheinfo.c: Fix build warning detected by
  kernel test robot.

Changes from v2 -> v3:
- arch/openrisc/kernel/cacheinfo.c:
  1. Use new functions introduced in patch #2.
  2. Address review comments regarding coding style.
- arch/openrisc/kernel/setup.c:
  (print_cpuinfo): Don't remove detection of UPR register.

 arch/openrisc/kernel/Makefile    |   2 +-
 arch/openrisc/kernel/cacheinfo.c | 104 +++++++++++++++++++++++++++++++
 arch/openrisc/kernel/setup.c     |  44 +------------
 3 files changed, 108 insertions(+), 42 deletions(-)
 create mode 100644 arch/openrisc/kernel/cacheinfo.c

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
index 000000000000..61230545e4ff
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
+	if (cpu_cache_is_present(SPR_UPR_DCP)) {
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
+		       cpuinfo->dcache.sets, cpuinfo->dcache.ways);
+	} else
+		printk(KERN_INFO "-- dcache disabled\n");
+
+	if (cpu_cache_is_present(SPR_UPR_ICP)) {
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
+		       cpuinfo->icache.sets, cpuinfo->icache.ways);
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
+	if (cpu_cache_is_present(SPR_UPR_DCP)) {
+		ci_leaf_init(this_leaf, CACHE_TYPE_DATA, level, &cpuinfo->dcache, cpu);
+		this_leaf->attributes = ((mfspr(SPR_DCCFGR) & SPR_DCCFGR_CWS) >> 8) ?
+					CACHE_WRITE_BACK : CACHE_WRITE_THROUGH;
+		this_leaf++;
+	}
+
+	if (cpu_cache_is_present(SPR_UPR_ICP))
+		ci_leaf_init(this_leaf, CACHE_TYPE_INST, level, &cpuinfo->icache, cpu);
+
+	this_cpu_ci->cpu_map_populated = true;
+
+	return 0;
+}
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 66207cd7bb9e..a9fb9cc6779e 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -113,21 +113,6 @@ static void print_cpuinfo(void)
 		return;
 	}
 
-	if (upr & SPR_UPR_DCP)
-		printk(KERN_INFO
-		       "-- dcache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
-		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
-		       cpuinfo->dcache.sets, cpuinfo->dcache.ways);
-	else
-		printk(KERN_INFO "-- dcache disabled\n");
-	if (upr & SPR_UPR_ICP)
-		printk(KERN_INFO
-		       "-- icache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
-		       cpuinfo->icache.size, cpuinfo->icache.block_size,
-		       cpuinfo->icache.sets, cpuinfo->icache.ways);
-	else
-		printk(KERN_INFO "-- icache disabled\n");
-
 	if (upr & SPR_UPR_DMP)
 		printk(KERN_INFO "-- dmmu: %4d entries, %lu way(s)\n",
 		       1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
@@ -155,7 +140,6 @@ static void print_cpuinfo(void)
 void __init setup_cpuinfo(void)
 {
 	struct device_node *cpu;
-	unsigned long iccfgr, dccfgr;
 	int cpu_id = smp_processor_id();
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
 
@@ -163,20 +147,6 @@ void __init setup_cpuinfo(void)
 	if (!cpu)
 		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
 
-	iccfgr = mfspr(SPR_ICCFGR);
-	cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
-	cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
-	cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
-	cpuinfo->icache.size =
-	    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
-
-	dccfgr = mfspr(SPR_DCCFGR);
-	cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
-	cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
-	cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
-	cpuinfo->dcache.size =
-	    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
-
 	if (of_property_read_u32(cpu, "clock-frequency",
 				 &cpuinfo->clock_frequency)) {
 		printk(KERN_WARNING
@@ -293,14 +263,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned int vr, cpucfgr;
 	unsigned int avr;
 	unsigned int version;
+#ifdef CONFIG_SMP
 	struct cpuinfo_or1k *cpuinfo = v;
+	seq_printf(m, "processor\t\t: %d\n", cpuinfo->coreid);
+#endif
 
 	vr = mfspr(SPR_VR);
 	cpucfgr = mfspr(SPR_CPUCFGR);
 
-#ifdef CONFIG_SMP
-	seq_printf(m, "processor\t\t: %d\n", cpuinfo->coreid);
-#endif
 	if (vr & SPR_VR_UVRP) {
 		vr = mfspr(SPR_VR2);
 		version = vr & SPR_VR2_VER;
@@ -319,14 +289,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "revision\t\t: %d\n", vr & SPR_VR_REV);
 	}
 	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
-	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache.size);
-	seq_printf(m, "dcache block size\t: %d bytes\n",
-		   cpuinfo->dcache.block_size);
-	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache.ways);
-	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache.size);
-	seq_printf(m, "icache block size\t: %d bytes\n",
-		   cpuinfo->icache.block_size);
-	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache.ways);
 	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
 		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
 		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
-- 
2.48.1

