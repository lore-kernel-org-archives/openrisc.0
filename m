Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8C3597B;
	Sat, 29 Mar 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241613; cv=none; b=mK2HPVbj36VWosFWFeaFb38NGFBLffBWPRdj1pD57oMunkp5APVPTjn15fM/rMeqL+RnPy1Um+Pt/35OqdSifUPuWjYJ+ipHUW85eyzTqfRo13ngrG3FkHZY30rZEyy9X7FhPQSMU0JmTSTpY16UIsW6UQ8fT5MyW25LIoLKJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241613; c=relaxed/simple;
	bh=fx0U0BsVwzUnXIltjtVO8GJ3KTNVCue7/7UDg0FwFOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv/zfH8c+Vekz1ZylphNm4btDbPY36Znkm7E0c1OoJM1/lOk9YD5e+xMdZ3eK7CGPNt71zt3zU1xetpMzz2Y4hM/ZC27Xvs5Og/r45gv06QrIcc/dsC5uwhS3rYadDodZ1BYrPxIDCO16p70PqbVmDdI53L+5hjgEBR1CCXHa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwN3Qs8N; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwN3Qs8N"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30332dfc820so5192941a91.2;
        Sat, 29 Mar 2025 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743241611; x=1743846411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTiQ/wKhfqa/xxuKIhOYw+HDs40Fp85msPOPKWuOVwM=;
        b=hwN3Qs8NWSmApUvBmv8a9/MmiPdJy48c34KETSv3AJxadK6qDTHvgfuI/jfG2ZrU6D
         peVELVkix3Rygi9vYyKnJp/ZdX3p4ehuWm2pnGaKnia8XsK7GDcRMozfUnmIlmIPXfPR
         0wNeo7/3nSPcVXJt4/QN0kxcarcweFlHpZ4tiURWicPwJTg7HK8XaOpXvopEPDyIeWZ8
         cxAx7+HtLKam3SkMEUzONbde/1/9WABbeXro0XdPMtFTkbqBHXgOBhCngPbS+Haa1ZZY
         sYiAatjqisQC2B24p5WUb2F88W/H8ztcMnQOtxe8PczK++8wINzrzqiAKrhGAarADirp
         sNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743241611; x=1743846411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTiQ/wKhfqa/xxuKIhOYw+HDs40Fp85msPOPKWuOVwM=;
        b=c3jBpRGJKPQhwTmc2LeWbWfPfiYFGQyn9ysWzTLVzPXPlpa4Sd9cb77rEU9hxY4SwV
         BlwhOXXMWWq9r4t1FAcuM/TpIcGmoK0TfSHHxnYPITp6no1lGJb9ZDgNz8vwTVxPQsTU
         9h8RV1BS+fjIThXalHTCx+ZIXJVR7t8AUcFfAIvRIQojdpKlq8B2M3qOSF4krGeD9XXw
         Mu1wgq7XmpAGMZSi5iwXeQUS/EU0GMbpdmmPjUrV6vwJ8RpGr5wRHFiPm4Y2+AYFjnvr
         +OIOacAdlPm55m/2FHdLVYQfyRCcSXgp582FDf4MrAATrHaWPc0tvaLeJSn2STt/EtQX
         /XLw==
X-Forwarded-Encrypted: i=1; AJvYcCVDf+v9BgVOL3EfVWpqLJYVe9Ew7ltaTtocEn16aCIEO44roCiuZI6faqmHR6fdd60h6+QdV8BU8rwzF10=@vger.kernel.org, AJvYcCWlzvwyvtt3cWxzhLAd51u6sH68mM0aollKultpjUouuCWzZ+3gs6Fq/7k4xAB8H/SXmCLwKQNOrAc/mVxtBlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxqhGUv/YMVgJJ/HlHjKWxbCL8eld5ladftgBDHGn0iC2y/hJ
	ehB3ipYE5YT/YSv9yOXaH2CNDoX8k2ciRTPODxR176yP+gXd/T5vunWWpQ==
X-Gm-Gg: ASbGncsfJgxaoB2vQc0qa6MedNS6duMtYsMSg+om/pntC/K6O047u2+ipL2+t9QoGya
	ebEr4h2pUIC6Shfj1epwKoEq/YKCo07XjMvRwhubg4TYij6RjosYKVwp8Uhg0bLBtzKDxyZswnS
	YqgnuslozF5IwJdob4z3gEJ0cVC+Dow/ZEgsVrVvVh2g7GI0RrmeXdils+5LANuRkp4V53xQM8Q
	gUdV1ls0YaMOZg0xRnMymamnJjsk1MsLrTPgP5lqsCr3q6+qXGORjeVLPeoQCzfEI2pMx/1SR6F
	QcAqgg0lBNXVH+3WOew8fimBfxO7TRmIcYTN
X-Google-Smtp-Source: AGHT+IEIEHlYMKuidHwWa1Dt4UO/BKZih2t+w67XaBoqkzGVVw6EpCmXTv3JTT3ij2BczqTlkE15ng==
X-Received: by 2002:a17:90b:1d48:b0:2fe:b774:3ec8 with SMTP id 98e67ed59e1d1-305321471fcmr3165962a91.23.1743241610661;
        Sat, 29 Mar 2025 02:46:50 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b31fbsm5680573a91.40.2025.03.29.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 02:46:50 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] openrisc: Refactor struct cpuinfo_or1k to reduce duplication
Date: Sat, 29 Mar 2025 15:16:20 +0530
Message-ID: <20250329094622.94919-2-sahilcdq@proton.me>
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

The "cpuinfo_or1k" structure currently has identical data members for
different cache components.

Remove these fields out of struct cpuinfo_or1k and into its own struct.
This reduces duplication while keeping cpuinfo_or1k extensible so more
cache descriptors can be added in the future.

Also add a new field "sets" to the new structure.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
No change from v3 -> v4/v5.

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

