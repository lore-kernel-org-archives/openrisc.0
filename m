Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A034690;
	Sat, 19 Apr 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745077765; cv=none; b=Nmmd3HJ70GiRn7NaySv3ylYIEhVEd0PWakiJ8tHYkG02GfNQsI3F0mOm+x0OgAd0pKkg+VRO3UJd9P4KtQ+x9ynpSjFcOmORy08bvTS/aFYDdgx77JLZsEErrHCBveAtn3kN8RBvqH9FjSAq2gQSIJqZCcvgZ4X/MsU7HEZUVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745077765; c=relaxed/simple;
	bh=IR8WDV7gxXimOVT2bOGadIKeezwXiNZAf+HREoo39Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tomtveewTY34p9WXvKG2MiLvd2BRLjS64tKe7TizWux1k3lk/pW6mlGpdMIHVRBzcYXymEROeeWt2S8SqPQhQBLmceaedJy043eTiWAjHV+9zvp8I6RnAlfZx77zb9IokBux+/uKCciiGxX7cxdsgJKj00S/LNP8KaPE2n0utsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVOpQlPp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVOpQlPp"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739be717eddso2075912b3a.2;
        Sat, 19 Apr 2025 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745077763; x=1745682563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO+xwD1ck431u5h+EhxDb5MGidFRh6eyyfNB4shCLoc=;
        b=eVOpQlPpI6xNfsPrChGrNINt40Q49fBArc6AXAaWwA1/RoyOcdXvnUyAbFZ5Hbr+o6
         ebGxr8a3EVv5gWhdn8iyxum1tTyb2RNyY3GO+Y0nqb25FDtZF5+HrkC/INnglrYd6Hd6
         LixB3w0mAzCVcIDaEI5AUgwPsJ4yjeIS0s2ugkp27kdGnlBKrhvK2QBEEGJNyM8XU1Kj
         c+G6C9BIUTwb98fcVK6ELX6kYIGZaczA3VbKrkomoQfhWEPR0qcF0U3covGiBzpMBZqS
         trblyKOHWUQZPgAvlIXZqn5mAiltGgf+FJqxbqvlv0pil81F85z4D2c7YNpdzQTpg3t9
         JM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745077763; x=1745682563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO+xwD1ck431u5h+EhxDb5MGidFRh6eyyfNB4shCLoc=;
        b=O1mCk1Q00H3N5llJYvINKpWMmqvfGv4EHu8q7JTC/V8vQN7iN8ppezveipUVK8KPj7
         WnR197z228VBbkUr+4aJLYPN+vLheo20Gv74XPXuIxHK2sv4p26pjVx5g6ODKm0FD5hR
         NmWy8KT9BKqAcWLiCsrGezSeTXyfrbywfRzGJmvvylYTGqntyqsDtFCxsYocDoK9i1IK
         CjDEZwutS/XxeBHyzn7QXTQZ0feW2PnPbdMDTaMD2R7doi+IByAi7XfPTd2muDaH0HNR
         TgAs8xMPbYjAYzxMePHmCactXrSc8UKQLRo7jE6IBi99aSJaEU7BzVwLynj6HT4Qpmw8
         O7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV54AB9RMR7/xkASoTNlXEltATNkUsVfxrcwkEo6svJWNwVcq/WDsvdxsB/ObF0AC8P+O11rQBTXxYFs4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbo301owFSPIQUJUPIbhkQMmEoFOKt7cG91qCVRrjSuucqUZ7P
	aySCBfCkPHq5eFxMTGPiLALnr01ddNWKxRv0mTHMGVH3VpbbW+fq
X-Gm-Gg: ASbGncuqIVW6SlAlKTp+ZhY1ZtgUKx7B1KVlGXIV51whmu617tCJxEvPJxRx8wFvZ5f
	ku1Dngdy1fl9s5iv2E9Dh3+sRNEDIsoBG3e/ZWlvTTY37MkvLGjPKEELXUpS/H3/OEOHojzQQ16
	ZS61bfoizXB5gc90MkyeDw8RH6dyUt0hCJTaR7KGXpPWPsfr5NFwpo4PIM3j7dL/nTI7awmJpJ8
	3uviIKRnAH4OZBoo8W2KkygiZAjsDNUFxy8EfaJ6GazgoUB00TeGzLR1kQHe5A52BQlUoTGkXh6
	5x5z4wKLsVR0RAPImh3oGosf5cFBJI07SA1i
X-Google-Smtp-Source: AGHT+IFt2foi3WyhplRZC4yqLjl1pdTstBvZM+5xxRt6FiWMGIL8PDFQnlHdPbd9S34O6XF+mmx15Q==
X-Received: by 2002:a05:6a20:d50d:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-203cbc253e1mr9042183637.6.1745077763192;
        Sat, 19 Apr 2025 08:49:23 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad42fsm3430658b3a.121.2025.04.19.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:49:22 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v6 3/3] openrisc: Add cacheinfo support
Date: Sat, 19 Apr 2025 21:18:19 +0530
Message-ID: <20250419154819.85063-4-sahilcdq0@gmail.com>
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
Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
Changes v5 -> v6:
- Changed 'From' and signed-off-by email addresses.

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

