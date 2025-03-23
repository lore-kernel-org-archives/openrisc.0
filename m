Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180A1411DE;
	Sun, 23 Mar 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759799; cv=none; b=g2BXg23tgZzJkahDHeaS9nymT5mcjRZB0v3aa0dhqNOvu8hr6gCtWYZOl5MibGBtYGmPKJdln2iSK0JZ8zouaQEzxx0+BTPDm911Mg2zJgb3X22mYouSmcMnOr7ptRERYNWMh/x9UemYlBUO8PXcTanpJ004RG/Yd7QkR7FJcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759799; c=relaxed/simple;
	bh=X2zRyDxr5oovyho+K2d7djaWGMj44SXo1AJ0g8roYNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvfzPDtTVlHDmIaWS41Qofow7OrQ5fzLzoLV+wBB0+42cB2mPI8/vh1gAgENO7nnqvcGKwjwsU580+Xy/yt1uFa0OJZIevlbX1gf+jNBgHDiNoEWA5cC9tudL4K5qILDRNYI2ElLyj7kbKGFDM3+qwqD5EnhT1gUx1DyVHY1IGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgOzS9Yp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgOzS9Yp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2279915e06eso14583845ad.1;
        Sun, 23 Mar 2025 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742759797; x=1743364597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kNDiX1C+lauA3w4zpQAJ6knHAZUeVvPlmwox8RqN3U=;
        b=CgOzS9Yp62lnAbGLOS7ftsThq3SeiZ2BuqVV1HHPv6va6e6wMnPrJ7tNq4XyXCWIdK
         L6BeGR6nle6GM10DefY7C2FR/1B4Tr7K6Td469+cYnzoi5vNVMNpowqXfY9EZvk3NKKy
         a9y30D5I2vVZLVdlU9RlT7nX9eSfg/5Ylw7zB4dyJeWUbAnX16plyU3oL+hXHitwM00C
         lRElBK/DXXtcnfzH5J8HSwDDW0XJ7/kmTRlufEic9bq9moEWpDU3SJMumB3R8kfLmkMm
         5o2w4iWX+/+tk40BseztVuJrA0LQforoiJ50pdT4WNtWQwUVYSVOstO+6Fu8LD5WMFU3
         nO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742759797; x=1743364597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kNDiX1C+lauA3w4zpQAJ6knHAZUeVvPlmwox8RqN3U=;
        b=e6dx1ZYr9DjoGRe5liRziEYQgSwi0UkST3ge2Kx6S8WBbMbfGkdlLzY5fzS0jiRelt
         iKf1Bp3Zo1lHLQbU+e8oRuOW3XrllHTsEggvfPQyYnp68YzH+3baZ1RYIjhAoQH81d3B
         0hxqLwrJkVKN8Rb2w6nR1sa7ZkHKIqwR4HdCHNtaHZSiCau9VmWAF1cb/7TcKuJIslvH
         1i44HRZKzXtjec8syq8fmwaBRVonD3K7+ceAJY5Xfa8jO6e38F2xCb8OGIuUk0g9npbz
         uMpYZSoB0W2iWoQNh5gyLIpUGvl0RKbt/MbpIZerqTPHgABZ0Wh71IsP1fq3hVQt5/h7
         qpQg==
X-Forwarded-Encrypted: i=1; AJvYcCWALW/3kStNWIiJzNexGLbQpidGpUP5hSyzbwF0Ow+FAQR3dFVE1O/9ymCEzDz/SMhxK0a4vR78eONm9P0WKy4=@vger.kernel.org, AJvYcCX3FnqMZGyIzqqW4+Udl+ROOylhWuGFUC/Oiy+cBhVV7ixEW8tliNTbzngliWxOjY2aFQeHziV3znWDTrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxobRqNbkTxfC0qIDnu4V+syQpRd/x3x2gPsmpF4h7G7eUMP1hw
	jq2NyzVnL4BEKGxxEaESTCkK9ItZ5m990A7MZhKUj2IyRDLwDqtJ
X-Gm-Gg: ASbGncvkQAT79U4VNgQYzKeDi2yrL2HBwofaR/9qqwY63iwfh0EoBZaWj8o2QY4kfI6
	w7kJj7o9MeV+8qM58VVurvFYvlopl14UNMphuDdD1/5+dQOjXP9PPvj9P0zl++W+Dw71SV0sqgr
	NM2PIK5Rqn0Esv/bhsoFggl4IQMZ7/jvkBpMDGs7p5/bBfAMfix/YbGytjXlonvYPkObS9VeX/7
	Va+IA+nrYA+KcTMqvp61CGiB+crDI9fJHoR3nsy4sMDuMEt74VuLvj3BFJVgxFix1TBYF2YN6g8
	w8wf6/GnY9KMX+Ns/URVjTQdfu/YwszIq4nbaM0=
X-Google-Smtp-Source: AGHT+IFvEm/pQYsW+TdHByhhYD/gf9bDqoVQUQUPAITb6c9E80WxPDxaXieaWdi18aVqvsNJuFKMjw==
X-Received: by 2002:a17:902:ce89:b0:224:6ee:ad with SMTP id d9443c01a7336-22780e1f4dbmr145221225ad.44.1742759796947;
        Sun, 23 Mar 2025 12:56:36 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f5047csm55582875ad.99.2025.03.23.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:56:36 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] openrisc: Refactor struct cpuinfo_or1k to reduce duplication
Date: Mon, 24 Mar 2025 01:25:42 +0530
Message-ID: <20250323195544.152948-2-sahilcdq@proton.me>
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

The "cpuinfo_or1k" structure currently has identical data members for
different cache components.

Remove these fields out of struct cpuinfo_or1k and into its own struct.
This reduces duplication while keeping cpuinfo_or1k extensible so more
cache descriptors can be added in the future.

Also add a new field "sets" to the new structure.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v1/v2 -> v3:
- arch/openrisc/kernel/setup.c:
  (print_cpuinfo):
  1. Cascade changes made to struct cpuinfo_or1k.
  2. These lines are ultimately shifted to the new file created in
     patch #3.
  (setup_cpuinfo): Likewise.
  (show_cpuinfo): Likewise.

 arch/openrisc/include/asm/cpuinfo.h | 16 +++++-----
 arch/openrisc/kernel/setup.c        | 45 ++++++++++++++---------------
 2 files changed, 31 insertions(+), 30 deletions(-)

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
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index be56eaafc8b9..66207cd7bb9e 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -115,16 +115,16 @@ static void print_cpuinfo(void)
 
 	if (upr & SPR_UPR_DCP)
 		printk(KERN_INFO
-		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
-		       cpuinfo->dcache_size, cpuinfo->dcache_block_size,
-		       cpuinfo->dcache_ways);
+		       "-- dcache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
+		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
+		       cpuinfo->dcache.sets, cpuinfo->dcache.ways);
 	else
 		printk(KERN_INFO "-- dcache disabled\n");
 	if (upr & SPR_UPR_ICP)
 		printk(KERN_INFO
-		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
-		       cpuinfo->icache_size, cpuinfo->icache_block_size,
-		       cpuinfo->icache_ways);
+		       "-- icache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
+		       cpuinfo->icache.size, cpuinfo->icache.block_size,
+		       cpuinfo->icache.sets, cpuinfo->icache.ways);
 	else
 		printk(KERN_INFO "-- icache disabled\n");
 
@@ -156,7 +156,6 @@ void __init setup_cpuinfo(void)
 {
 	struct device_node *cpu;
 	unsigned long iccfgr, dccfgr;
-	unsigned long cache_set_size;
 	int cpu_id = smp_processor_id();
 	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
 
@@ -165,18 +164,18 @@ void __init setup_cpuinfo(void)
 		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
 
 	iccfgr = mfspr(SPR_ICCFGR);
-	cpuinfo->icache_ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
-	cache_set_size = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
-	cpuinfo->icache_block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
-	cpuinfo->icache_size =
-	    cache_set_size * cpuinfo->icache_ways * cpuinfo->icache_block_size;
+	cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
+	cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
+	cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
+	cpuinfo->icache.size =
+	    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
 
 	dccfgr = mfspr(SPR_DCCFGR);
-	cpuinfo->dcache_ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
-	cache_set_size = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
-	cpuinfo->dcache_block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
-	cpuinfo->dcache_size =
-	    cache_set_size * cpuinfo->dcache_ways * cpuinfo->dcache_block_size;
+	cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
+	cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
+	cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
+	cpuinfo->dcache.size =
+	    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
 
 	if (of_property_read_u32(cpu, "clock-frequency",
 				 &cpuinfo->clock_frequency)) {
@@ -320,14 +319,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "revision\t\t: %d\n", vr & SPR_VR_REV);
 	}
 	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
-	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache_size);
+	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache.size);
 	seq_printf(m, "dcache block size\t: %d bytes\n",
-		   cpuinfo->dcache_block_size);
-	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache_ways);
-	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache_size);
+		   cpuinfo->dcache.block_size);
+	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache.ways);
+	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache.size);
 	seq_printf(m, "icache block size\t: %d bytes\n",
-		   cpuinfo->icache_block_size);
-	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache_ways);
+		   cpuinfo->icache.block_size);
+	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache.ways);
 	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
 		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
 		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
-- 
2.48.1

