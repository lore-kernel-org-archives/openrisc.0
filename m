Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0061531C5;
	Fri, 28 Mar 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193616; cv=none; b=mywz+tmFh8sqOiJeaB5s+5rz3L/N3sNroaS+sIvZ5T9VqMAOmQR9jASXJKWqTsa9lP9Lh14gytQD6ePyw830UU3q+wmZ8biz7h1tVvNWmsyFR1wNznVSr3SHKhiXdaWbHfLKlCaIEUgGSfStgPVeCMjtZGArLCGeaMj9ABCvLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193616; c=relaxed/simple;
	bh=H0GnJZUiOdYCVuRjJlNSV7d9A/CkV2Xc51MNWZWBcUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+hkheqwoCo1DDkUXd4mIyF2/XmkDK2rOHrkEeoLO43aHKGBONTd7GOt1P6BdVO0LzN9Knhj219paEYOhSBneSHFfTOFS3dL55wtscHYM7QuHznD3X0NXh6FnNZuSQROTA+3bJ8m5SKaldmB8am8SVgJYlvJHq0MjkyY9LVpipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNadhejx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNadhejx"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso4316167a91.0;
        Fri, 28 Mar 2025 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743193614; x=1743798414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+fqxrWIKAfeXnZwJGbJTvgKhTfNvmBZqW5qPhiO3YQ=;
        b=lNadhejxD5zvE+jpnM832LWeHOukW2725l0ZRQ3GzJ9nXaR+DsrWwjr2n3FT07OPU1
         PhqBatTUtZuXvDZJbDEUTnoAaxsm3u/fLxqgG1b/HwarllYmJvuA27aMjtOU+5uuv1hH
         MFmwWG3O26RAO/NMq6Xw8xNUs8O38xbTaKwrPC+B078eUCA235V9gYusKUSIBR0vKl+4
         pNDqaDyg4rZVAAJ/CM8OFqPdndgDhQ8iCqBtZtvUptmzmDF38kHyFisf9YHq2kZ9ckZ8
         dYOhsjL2WHbkwrWcRXmtU/8Pykx2hAMsqjPN6Xjkafu+fIgpFeGO2BzvdAdbnowUOXB9
         0+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743193614; x=1743798414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+fqxrWIKAfeXnZwJGbJTvgKhTfNvmBZqW5qPhiO3YQ=;
        b=v0l0utUs62CXsanHYQNcpgSIKrS7phO1r9ct4jQYWuTnMh/2nNorZ5RZDyeDwAvesk
         PF/8Vtvp1f4MsU1VRNM6kKy32i08apOJCeolrFZSkxGCm2ZPEqC5mqZUq6OVBwiiuzT/
         NOiWfmp3dt+Cn/lZ25mUviIY6A4fzAtRUJovZzne90LXDvmhS0YkyW5rengoCifxyVqN
         lBcVuej3Ihcc0UnhBCytlKCeB3cnE0RM9GlLUDmwOVI0g5rT38oV++4P6yeeLwX8IwHV
         QI+XDDRXeCVmQ9gtQDG5Y394hGZ347lubn7C52DskM1lkpQJ0kKm7uMssKOJPWe/r57F
         CcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSW7C5YYP5xCVC5x/I4fAESulkO7MicPJ0MH3l/3+lUGRabJSMEAyb3/KHnoGuYWq/x1MPAx+i++rohvwKtiY=@vger.kernel.org, AJvYcCX6gNsvh5Evf8z/AqFAu0T3h4p8AWxZZxi0fYCnU1TLPR5gM60Gf8HbiL9jGznr8xy4Ntz02Ui+FtVcdt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywISJVtmKTxyqAQ3WdMguce6L5WBdOxibHQu76qR1oFxM8ErcC
	F1Ug1u8grQtFH5ziXcULUm9yKRj07mPquhrzQLQTOKm/5Cxrp6V1
X-Gm-Gg: ASbGnctzHGXitiJ7n2TLDZdXXBkSQQ3ZrkCv1QpnVcCiXS6v1WIxwp+vc6PPmwzdypT
	zZsNZ+BEazdnom0CjV+Z5ALKb2ziRZgDxru5TqtIfdIvq4wom/c4Ob7PguFh/9dE5H42kIR8uHQ
	48Gmdrzm/pJdw+IvfS53eoIyz5j8sd1K3DWga6fn52KvJ8nYrb6SeTEV7PnS5SCM5BLum59/mWT
	CnpRuWCA3NdtxYsMqtmePMXmyP51Qfk2su99LJB2qQ9WVJK6X0bUTPg/nvx1/uFXAcveYxtpKb4
	u8loQvwHTC9JwSiCpr1zYglV6Zt6SQbCAtQ7LFQ=
X-Google-Smtp-Source: AGHT+IHq0o/BWtJ0RhyH+BegRrgzPMGNaTYBaLEkN0a5ojLcKSydcqq709hkgsISQZlGQ0A9LxG4rA==
X-Received: by 2002:a17:90a:dfc5:b0:2ff:5ed8:83d0 with SMTP id 98e67ed59e1d1-305320af194mr987808a91.16.1743193613759;
        Fri, 28 Mar 2025 13:26:53 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d62c57sm2358889a91.28.2025.03.28.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:26:53 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] openrisc: Refactor struct cpuinfo_or1k to reduce duplication
Date: Sat, 29 Mar 2025 01:56:30 +0530
Message-ID: <20250328202632.72809-2-sahilcdq@proton.me>
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

The "cpuinfo_or1k" structure currently has identical data members for
different cache components.

Remove these fields out of struct cpuinfo_or1k and into its own struct.
This reduces duplication while keeping cpuinfo_or1k extensible so more
cache descriptors can be added in the future.

Also add a new field "sets" to the new structure.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
No changes from v3 -> v4.

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

