Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C5EACE;
	Sat, 19 Apr 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745077738; cv=none; b=uq++1omqfL6VYdgpExTCl9+F4ptfUP0aC7N73p6/vpE7/xn+XLIJZPs1mod8Xt5ybJcH3jOsfm03/TkzYxwRFUGOr4A7XBiICUt2CvUuT0UFNn1SFZpXbrC81XmpyYU/rkm4anzzBH6YfHP+d4Y0iaq42oynmBwtQTNBVD/ghTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745077738; c=relaxed/simple;
	bh=k0HICjtWI1z2uubZWRjD+Ry7l7V7Wy0sn1EwK0ukH1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVs2aTLgxxqLJkTw8xJ1KjGRO6IbG586io8lGIVzYGvSJvziQMxIUIwf2KA/1SQ7ssot4EhieHOQ7umfVOpfCHay/3wosjRAoeByPnS9i2QRaljnYGusfQsfQL+F0XVjzbW66H/yqemv3uc+C59Ep+NHE+JCVVv9vi4kZBwNuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGt2k7S0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGt2k7S0"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c062b1f5so2173971b3a.0;
        Sat, 19 Apr 2025 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745077736; x=1745682536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQC7/bSrBoU8PcuIctY30o/NCyetfZalbf7EVOU0sRo=;
        b=JGt2k7S0HiEhLyZ2MK2WVEC29bNoElzXI0xtKMM3XDvnUsx5hXlumgTDQeN4m6k1Sc
         8oLgEO6yfRBQ8EVi1Mq6llKXCbnuc4q7mn2qxo/G9AXgZJiq7MPDHNWzq57BDMEGuWyh
         ErYpG3ttxSTbokO3mBAtwUgmrG5bn3o3CojcPiJMhwjbcrdFxW4+lYPKi/xwMR21uaZW
         gP2HBJDwBJLhQ4Up0uyM1JSmABMl4fnexrm99U1DPIJAYYwagDaO67kStlW8Ld1gkKv6
         kNbkY942ka0MaSOCIy4RHt6R1WWN2iPq4NvZV5CKz62363rpQ8qCuBYewDsAMg47JtMi
         ZJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745077736; x=1745682536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQC7/bSrBoU8PcuIctY30o/NCyetfZalbf7EVOU0sRo=;
        b=wlzOR05wZBDD+zq3GCoH2cb+vsbomP/oQ3lgqGEnAckEwy/qgsl0SJYSttgZkl4PSX
         p5arcoX8HOLBQoTM+4rWFoCIsYeW1AYzjA0pEPW7UV7QCnSgkUTrKpPymMmifNKNTTTW
         7RxxrL4dy/ABDBlLgGca7sGtton4WvEzzJqPQps7hI6+Hf2FaDMZEblZfeXfUEsyk4oR
         u/nGij9z/esxWaG+EOA6MW+lSOZXqPA2DcNTIG3UPxrO3Deb1F64UAVzv8XOwxwLqI0B
         fH4dU2aUaRWQrmLQiLpfKdXXYYSDXGFca4uug7xfcU+3xLH6KD3cXgZsmpDmsKgynGIs
         RTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmkEzee+OmirW46FGzsseLsY5UX0OXK2sKvocfMAum9ZtmVwv23IbNVUefpDfn3tbc+oc2XND/HAYRpr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGek2jPlYYtjflcR1g5SYEEnDNoLj5vnjPJ1URHeCC2qxwzDi
	yCfRnV6Qvi7/MWQLilB7t6Fr/RUSdR3M546nyVuCRcb2ZXw8jdm3
X-Gm-Gg: ASbGncuqmdORDiLl+v06oyAHrzqgQ9/NIZF02+Jo8I+jum8y2rEUNXHnTN5qUbpw4tR
	eMJcRMSbIJ9dQ+I67JAj2cyCwrJ87V+4nA85FsIQDCHDKKCKQ6uoAJdqTIW6OgMDETY8oO5ydKw
	LI3IfYdnOSfemWOc+k0g9SLcP+Oz8oK6x283WClYsIG+xhymiMJ3XMJmJoWIBcqiHlFZr2EjRRj
	KF6fvTCDika9/yLhipO8lQlZ62MOgQblxfQNH4RGcJk0X4Dzj+zfS2gfpGH+wHlKoGVaXOJmTj5
	qoR0jX3yU3C4cK+4Jo+rKR5vGncd0DXqaqW0
X-Google-Smtp-Source: AGHT+IEYf6Ay0PaXpewHKVEtBq9DZ8PyejrkNMV7HvtRveyKECJgpDr4FXsPZ9lhsDlcu9x91yrHcw==
X-Received: by 2002:a05:6a00:3a0a:b0:739:56c2:b661 with SMTP id d2e1a72fcca58-73dc14cdadcmr7328228b3a.12.1745077735642;
        Sat, 19 Apr 2025 08:48:55 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad42fsm3430658b3a.121.2025.04.19.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:48:55 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v6 1/3] openrisc: Refactor struct cpuinfo_or1k to reduce duplication
Date: Sat, 19 Apr 2025 21:18:17 +0530
Message-ID: <20250419154819.85063-2-sahilcdq0@gmail.com>
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

The "cpuinfo_or1k" structure currently has identical data members for
different cache components.

Remove these fields out of struct cpuinfo_or1k and into its own struct.
This reduces duplication while keeping cpuinfo_or1k extensible so more
cache descriptors can be added in the future.

Also add a new field "sets" to the new structure.

Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
Changes v5 -> v6:
- Changed 'From' and signed-off-by email addresses.

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

