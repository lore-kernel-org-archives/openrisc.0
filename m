Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9276192B90;
	Sun, 23 Mar 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759817; cv=none; b=o462sWRWVxcqMX1C+tIbV6Ivlyz3Lnl5k7GEkyRf+vRVY6RmTgvIicL4lpw0MQODXJ0Q1eY5pmkK3eMoSd2mSXSqvAs6FT3IExP3D3rtmaJH+8a7lVWQhzfYTxm3NCTJOPUl/TYB6JPjw+kZP9dc9FhVSg7u6rESWwKLRqM5VVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759817; c=relaxed/simple;
	bh=GFt2rBiHPd+JysI9OZcM/AYLcfoHEvBpP/XoB2s/CPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvPKnj38Zm6sgFHVEsZGXhmIz0GMe84bTxUY0dFrA6wJGtWHEhUz51nO8fMVXEVaZQ7MCJPeIZJ+fSQMSATlDlivqD4iEOBBwr26EzVTSDzz989pjLvMFTD9brfntPBFBAGSvqgt+QMXXbg2sFEQRkwgk/z4JKU4ShV1lG4R3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrZPMpt4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrZPMpt4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22622ddcc35so56736165ad.2;
        Sun, 23 Mar 2025 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742759815; x=1743364615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ9B8838YijBqDxCpSfKxj0+AV6H94i0lBv0c2sHg+U=;
        b=hrZPMpt41M1IGkd2iNWpK4OTbBbIasLs43SnMb3tEKH+B5JbIIMJJrobYwW5T4hdFO
         X58eQHh3tGiqjQGarH0WM47CXRe3Bpyh0J1PfNTsqdDEQpTui5WwwTZfVLjSQJ9wEdX5
         oPZ2ORqzMQJ3z/A/3SUX+mmWJ4Z6inay93MdP42kzhXIKZfJvD/f8qc71Ddcry6jy76K
         5QsF1+OkyCOfbdNVuemGQqht3H12gElEV+PvcfJsQGQDp2t3ocQcbtupciWv3FMr+07Y
         XbGz1bM8a0dqf0lVi6uXH/YM5LD5gh/6Av02DLj8CVHD5eFRi2+RUv9IMg22c+ph6fVT
         GsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742759815; x=1743364615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ9B8838YijBqDxCpSfKxj0+AV6H94i0lBv0c2sHg+U=;
        b=QLqijTMwbSC10Bu/uXL5QvEAOj2busS0lfexFgEK+c24jpNpg31twdcMocXAmENgvI
         2hhJxj9zu9xz66IDFgepu5hHp9htjwhkPg6zrG/zRraX5WEpT+WVxKvNu3O9/U4J1qzU
         mo8fNpKjXH0zH2AOZHWsXeMDXnozKbX8CRfolJiQpM3IN5WrAs+2XfuXYTPu2duTgfuT
         mJYfqv8wJNaZKKMOu8ijJwhZt15vjEtB/S7UTlhw465HSpmRsFwDLnqpAHsVnKY/IoU/
         e0chN0AcCtCIxSzzXOWJ4ajfM8x2ia+NIR3nULIIAvrsjEcG6XfVGLgje7s3A6jGoqMd
         /DxA==
X-Forwarded-Encrypted: i=1; AJvYcCWIRZy0DrBQha/Vxx0Oj8tQj/iJnNobeoyjHNga68DLAIpkB9NeAkfRKAhy4AJ0O6A0Cpsr19B7lkj3knk=@vger.kernel.org, AJvYcCWaP5akq1BFJwik7Q6XBk9YLQvO1orUvsDvw5B8avGJin6Fh2msF5FKA2gIfD1FU6g05fnMfqyjv8UTCLoHk7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lKIk7O2HobvYmKkGV9tRl2MGwEghHx4hBHoa6QP8PTH9GB5J
	HlWDC58NQE8p630Af9A9ibbjiOruaKvcFglM3qaW/L7wOOXIjl6QyXl6ig==
X-Gm-Gg: ASbGncsDrY7ONS9ejaVnCoW+tlaIXa8oStURTSvc6V65sDK7WpgjQY6L8pRYfIOxU7S
	ZnAb/cNTejVlIqMQEcuhfy44yKxkHWIMnRrjY+Yy0GVu/7ksM0xj+wCSGvnA9A7Z8UmE4OPEdEf
	Djod00FEN7de8MGVKwMdOUd5d1EBJNOR+wK3HQ9dbbHPhVtV88qDTdAyJZ8zIb48uQJqWP2lex9
	h41XQADip39I7o2kTqbFmyOXuIN2HMQHkHDbTm5QnSXWzPhxPHqdDfg0URnknCrotm/4UgUIsEz
	0qkwF3kWPj5nhSAMPhFHIe9RG0CrMvMEnOpkDEs=
X-Google-Smtp-Source: AGHT+IHsMIxu5WuL046jkLORqerJOmu9ONKRYPMRT3zxXi26kEKrs9Spxn+uETrnMlQ7oESht66B3g==
X-Received: by 2002:a17:903:182:b0:223:501c:7581 with SMTP id d9443c01a7336-22780c7599cmr129759365ad.16.1742759814964;
        Sun, 23 Mar 2025 12:56:54 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f5047csm55582875ad.99.2025.03.23.12.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:56:54 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] openrisc: Add cacheinfo support
Date: Mon, 24 Mar 2025 01:25:44 +0530
Message-ID: <20250323195544.152948-4-sahilcdq@proton.me>
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
Changes from v2 -> v3:
- arch/openrisc/kernel/cacheinfo.c:
  1. Use new functions introduced in patch #2.
  2. Address review comments regarding coding style.
- arch/openrisc/kernel/setup.c:
  (print_cpuinfo): Don't remove detection of UPR register.

 arch/openrisc/kernel/Makefile    |   2 +-
 arch/openrisc/kernel/cacheinfo.c | 104 +++++++++++++++++++++++++++++++
 arch/openrisc/kernel/setup.c     |  38 -----------
 3 files changed, 105 insertions(+), 39 deletions(-)
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
index 66207cd7bb9e..caac492d045e 100644
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

