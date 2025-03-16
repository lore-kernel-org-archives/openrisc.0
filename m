Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91C15575C;
	Sun, 16 Mar 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108345; cv=none; b=QoJ8KNq3vz8OgL93j0yEJ3HTTPeDsoImHlxyuhT8/e79jXrhVL8mcS1F7SjxbnMwduuLrEB0887g8p63g7LHRZdcXggAPXmVjtZL9PxfMVMXSEGjsA39cFnzg9kaqszZfWM+WDhyFBjNV2+InPmV9ha9ow4Aa6SmhDsn3pJJdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108345; c=relaxed/simple;
	bh=qMI/QQ18a/SxoxMSXvL8etcvxK6efVYeLHZfmnfv0AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXe46+7JWFZqRBZDggWZi1Yb/t8CtVN7HZxJuu+I41QFhnibRCXVY/Onutu0xxduB0ls5NAbQEjPpM8Jv4WCDDSTCK27IF6P+Ls0wsUMk5X9ylxxad98StGXEHfPyA0XWzg8fiwO9T9njNOuVXd/GRLHDYm4B5rfFa19YZKWEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiK7YWtX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiK7YWtX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so11493265e9.3;
        Sat, 15 Mar 2025 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108342; x=1742713142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e43maAx4js+WFUA+tPLEZXyGF6SaVvhiSTOWIkWYeEg=;
        b=kiK7YWtXI4Fr+H5uiBktSUuGEt9lw1tOtE9xQTvAzmR5jdnMdsmcUCVjUr5EkxmYdN
         B0fw15nArSojobu6HnPdqd+q3TyoYU77BZTZE7nZfu0jYDuZcGTQYsGn5AR/zOpIw+/a
         DqeA0dOpCh1u8p4G9fP1xxabVflks2xdnoaUZJ1lMtXQgJ2IpLO4jVRaH4osORaEIUGj
         U7ZGmEyE5hV7p4JEw+8jLDzjaWa3cInMsWeo9qcGPq1sCQWp3FAVdXRcZ9rzFUSnhKqJ
         OG5jX1DUwVzpiufAoibGtdwkrm52TrUWBk2YTKIeCZSNlikfMUDhrhXePUP41H5+5zRv
         Pi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108342; x=1742713142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e43maAx4js+WFUA+tPLEZXyGF6SaVvhiSTOWIkWYeEg=;
        b=a06hX2QYGBhIfFdMwsOhi3fNH3ci5x4YMCqcO5q1pxNDYkox3TAnLyBOHiPs/VGbQr
         m8YCno7kjzbe7g6vfV+paMP0ZQMBakAOsj2/OqFKFSjvhW6tE8QhIaKcruP1Dn1Z8Rn/
         woAy8koYQ7KO9kUSzfIdroxokVq+5XUxF3KWC1Mt7+PBKXjvwewrwfLapez7fW96iXkR
         yxnsCwS/xcXE/c19L2EzlWiZAnUlIGNkvfqPBjEBDf7pbm9l1Ij0sA3+dAxhpKk2YYRt
         yotz1DT4IknhQO/X0zUEOoPdWmRPTGbHXl/ZKdgJkvgHwdnHws3kt9HfELiBgzxEyx92
         r5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUE69u2l2fNlSO+JEJZFsAbE/g20lmuoA3sTeA9PXODWJh5lRwITBLnZAV2ASCoNRGmqWV6iNCk3Lr7MJmIpek=@vger.kernel.org, AJvYcCUs2/1VXrulJUaHW4m9XkY761JbErORYn9MOIWX++LTGLvUHrKzkqtMGKRwbxXM9mFitPSO6kpxy73v9/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1K1+wPPo+r1b9v7QxGg87KNl3/hzb4gkGf9elLm0gCnAPHj2q
	yzjRxgY265QzgFj9pncFNv8O8C2yaZ11nLy9K92vIVUfmHi+ZakK
X-Gm-Gg: ASbGncu2Dn23C4UvQVycaH2Dnks9mFhUwT87yHdsZN7Fa5jXLLUTDsWkm6Ug5O+hb2T
	Ubd/MQW+OT3NMqGbeNBhj+dD9VSK3juBSeHZUtr8/FqekBA83Xmu0mynSzdiPKVSwQqNrsu73k+
	iXkmLqAKFKzskmVM9aH5Op0xzEmUjPebXlq3TIssmgNnMMRzzkz/8Ob8S6G0q07luWMZGUqqHt2
	lUJnpUgIvy/UAJNb+BbhC/tBgJCZuoHoRR4vxqEkaUU5azPChOMtIKu0fRnTk8b8eY3f0M7X3eC
	TduYmPQtfRPBAdaoR1pKYpCTvWo1FbVUP4tg1STIe2lPAUfGD1t7EOEehhpULY4j3bGEMxhGVHe
	hWyplflQ5
X-Google-Smtp-Source: AGHT+IGdlr9/7bjvtYyJRNWUQmECp9vh3pVFG5gNXoe8VhhhGzTXGHOM7R3SVBFvKN2OVd1HdoY7oA==
X-Received: by 2002:a05:600c:3b02:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43d1ecd2dbamr101018745e9.29.1742108341509;
        Sat, 15 Mar 2025 23:59:01 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe659d0sm69596175e9.35.2025.03.15.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:59:00 -0700 (PDT)
Date: Sun, 16 Mar 2025 06:58:58 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
Message-ID: <Z9Z2sjWQHKgGJyGo@antec>
References: <20250315203937.77017-1-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315203937.77017-1-sahilcdq@proton.me>

On Sun, Mar 16, 2025 at 02:09:37AM +0530, Sahil Siddiq wrote:
> Add cacheinfo support for OpenRISC.
> 
> Currently, a few CPU cache attributes pertaining to OpenRISC processors
> are exposed along with other unrelated CPU attributes in the procfs file
> system (/proc/cpuinfo). However, a few cache attributes remain unexposed.
> An attempt is also made to pull these CPU cache attributes without
> detecting if the relevant cache exists.
> 
> This patch provides a mechanism that the generic cacheinfo infrastructure
> can employ to expose these attributes via the sysfs file system. These
> attributes are exposed in /sys/devices/system/cpu/cpuX/cache/indexN.
> Cache attributes are pulled only when the cache component is detected.
> 
> The implementation to pull cache attributes from the processor's
> registers has been moved from arch/openrisc/kernel/setup.c with a few
> modifications.
> 
> The patch also moves cache-related fields out of struct cpuinfo_or1k and
> into its own struct to keep the implementation straightforward. This
> reduces duplication of cache-related fields while keeping cpuinfo_or1k
> extensible in case more cache descriptors are added in the future.
> 
> This implementation is based on similar work done for MIPS and LoongArch.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes from v1 -> v2:
> - Changed patch prefix from RFC to PATCH.
> - cacheinfo.c: Print number of sets. Remove integer padding.
> - dma.c
>   (page_set_nocache): Access cache attributes only if component exists.
>   (arch_sync_dma_for_device): Likewise.
> - cache.c: Likewise.
> - init.c: Likewise.

I think it may be better to split these cache op change out to a separate patch
which we can sequence in before cacheinfo and make your changes a series.

>  arch/openrisc/include/asm/cpuinfo.h |  16 +++--
>  arch/openrisc/kernel/Makefile       |   2 +-
>  arch/openrisc/kernel/cacheinfo.c    | 106 ++++++++++++++++++++++++++++
>  arch/openrisc/kernel/dma.c          |  22 +++---
>  arch/openrisc/kernel/setup.c        |  45 ------------
>  arch/openrisc/mm/cache.c            |  11 ++-
>  arch/openrisc/mm/init.c             |   8 ++-
>  7 files changed, 144 insertions(+), 66 deletions(-)
>  create mode 100644 arch/openrisc/kernel/cacheinfo.c
> 
> diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
> index 5e4744153d0e..82f5d4c06314 100644
> --- a/arch/openrisc/include/asm/cpuinfo.h
> +++ b/arch/openrisc/include/asm/cpuinfo.h
> @@ -15,16 +15,18 @@
>  #ifndef __ASM_OPENRISC_CPUINFO_H
>  #define __ASM_OPENRISC_CPUINFO_H
>  
> +struct cache_desc {
> +	u32 size;
> +	u32 sets;
> +	u32 block_size;
> +	u32 ways;

Considering the changes below to add cache available checks, maybe we
want to add a field here, such as `bool present`.  Or a flags field like
is used in loongarch?

Though just checking the UPR is probably faster in all cases, it may be good to
have a helper function for that.

> +};
> +
>  struct cpuinfo_or1k {
>  	u32 clock_frequency;
>  
> -	u32 icache_size;
> -	u32 icache_block_size;
> -	u32 icache_ways;
> -
> -	u32 dcache_size;
> -	u32 dcache_block_size;
> -	u32 dcache_ways;
> +	struct cache_desc icache;
> +	struct cache_desc dcache;
>  
>  	u16 coreid;
>  };
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 79129161f3e0..e4c7d9bdd598 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -7,7 +7,7 @@ extra-y	:= vmlinux.lds
>  
>  obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
>  	   traps.o time.o irq.o entry.o ptrace.o signal.o \
> -	   sys_call_table.o unwinder.o
> +	   sys_call_table.o unwinder.o cacheinfo.o
>  
>  obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
> diff --git a/arch/openrisc/kernel/cacheinfo.c b/arch/openrisc/kernel/cacheinfo.c
> new file mode 100644
> index 000000000000..6bb81e246f7e
> --- /dev/null
> +++ b/arch/openrisc/kernel/cacheinfo.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * OpenRISC cacheinfo support
> + *
> + * Based on work done for MIPS and LoongArch. All original copyrights
> + * apply as per the original source declaration.
> + *
> + * OpenRISC implementation:
> + * Copyright (C) 2025 Sahil Siddiq <sahilcdq@proton.me>
> + */
> +
> +#include <linux/cacheinfo.h>
> +#include <asm/cpuinfo.h>
> +#include <asm/spr.h>
> +#include <asm/spr_defs.h>
> +
> +static inline void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
> +				unsigned int level, struct cache_desc *cache, int cpu)
> +{
> +	this_leaf->type = type;
> +	this_leaf->level = level;
> +	this_leaf->coherency_line_size = cache->block_size;
> +	this_leaf->number_of_sets = cache->sets;
> +	this_leaf->ways_of_associativity = cache->ways;
> +	this_leaf->size = cache->size;
> +	cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
> +}
> +
> +int init_cache_level(unsigned int cpu)
> +{
> +	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	int leaves = 0, levels = 0;
> +	unsigned long upr = mfspr(SPR_UPR);
> +	unsigned long iccfgr, dccfgr;
> +
> +	if (!(upr & SPR_UPR_UP)) {
> +		printk(KERN_INFO
> +		       "-- no UPR register... unable to detect configuration\n");
> +		return -ENOENT;
> +	}
> +
> +	if (upr & SPR_UPR_DCP) {
> +		dccfgr = mfspr(SPR_DCCFGR);
> +		cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
> +		cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
> +		cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
> +		cpuinfo->dcache.size =
> +		    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
> +		leaves += 1;
> +		printk(KERN_INFO
> +		       "-- dcache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
> +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
> +			   cpuinfo->dcache.sets,
> +		       cpuinfo->dcache.ways);

The indentation of sets looks a bit off here.

> +	} else
> +		printk(KERN_INFO "-- dcache disabled\n");
> +
> +	if (upr & SPR_UPR_ICP) {
> +		iccfgr = mfspr(SPR_ICCFGR);
> +		cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
> +		cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
> +		cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
> +		cpuinfo->icache.size =
> +		    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
> +		leaves += 1;
> +		printk(KERN_INFO
> +		       "-- icache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
> +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
> +			   cpuinfo->icache.sets,
> +		       cpuinfo->icache.ways);

The indentation of sets looks a bit off here. Maybe its the others that are out
of line, but can you fix?  Also I think sets and ways could be on the same line.

> +	} else
> +		printk(KERN_INFO "-- icache disabled\n");
> +
> +	if (!leaves)
> +		return -ENOENT;
> +
> +	levels = 1;
> +
> +	this_cpu_ci->num_leaves = leaves;
> +	this_cpu_ci->num_levels = levels;
> +
> +	return 0;
> +}
> +
> +int populate_cache_leaves(unsigned int cpu)
> +{
> +	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> +	int level = 1;
> +
> +	if (cpuinfo->dcache.ways) {
> +		ci_leaf_init(this_leaf, CACHE_TYPE_DATA, level, &cpuinfo->dcache, cpu);
> +		this_leaf->attributes = ((mfspr(SPR_DCCFGR) & SPR_DCCFGR_CWS) >> 8) ?
> +					CACHE_WRITE_BACK : CACHE_WRITE_THROUGH;
> +		this_leaf++;
> +	}
> +
> +	if (cpuinfo->icache.ways)
> +		ci_leaf_init(this_leaf, CACHE_TYPE_INST, level, &cpuinfo->icache, cpu);
> +
> +	this_cpu_ci->cpu_map_populated = true;
> +
> +	return 0;
> +}
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index b3edbb33b621..ffb161e41e9d 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -36,8 +36,10 @@ page_set_nocache(pte_t *pte, unsigned long addr,
>  	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>  
>  	/* Flush page out of dcache */
> -	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
> -		mtspr(SPR_DCBFR, cl);
> +	if (cpuinfo->dcache.ways) {
> +		for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache.block_size)
> +			mtspr(SPR_DCBFR, cl);
> +	}

I think it would be better to move this to cacheflush.h as a function like
flush_dcache_range() or local_dcache_range_flush().

>  	return 0;
>  }
> @@ -104,15 +106,19 @@ void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
>  	switch (dir) {
>  	case DMA_TO_DEVICE:
>  		/* Flush the dcache for the requested range */
> -		for (cl = addr; cl < addr + size;
> -		     cl += cpuinfo->dcache_block_size)
> -			mtspr(SPR_DCBFR, cl);
> +		if (cpuinfo->dcache.ways) {
> +			for (cl = addr; cl < addr + size;
> +			     cl += cpuinfo->dcache.block_size)
> +				mtspr(SPR_DCBFR, cl);
> +		}

Also here,I think it would be better to move this to cacheflush.h as a function like
flush_dcache_range().

Or, local_dcache_range_flush(), which seems to be the convention we use in
cacheflush.h/cache.c.


>  		break;
>  	case DMA_FROM_DEVICE:
>  		/* Invalidate the dcache for the requested range */
> -		for (cl = addr; cl < addr + size;
> -		     cl += cpuinfo->dcache_block_size)
> -			mtspr(SPR_DCBIR, cl);
> +		if (cpuinfo->dcache.ways) {
> +			for (cl = addr; cl < addr + size;
> +			     cl += cpuinfo->dcache.block_size)
> +				mtspr(SPR_DCBIR, cl);
> +		}

This one could be invalidate_dcache_range().   Note, this will also be useful
for the kexec patches that I am working on.

Or, local_dcache_range_inv(), which seems to be the convention we use in
cacheflush.h/cache.c.

>  		break;
>  	default:
>  		/*
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index be56eaafc8b9..38172c0989cf 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -107,27 +107,6 @@ static void print_cpuinfo(void)
>  	printk(KERN_INFO "CPU: OpenRISC-%x (revision %d) @%d MHz\n",
>  	       version, revision, cpuinfo->clock_frequency / 1000000);
>  
> -	if (!(upr & SPR_UPR_UP)) {
> -		printk(KERN_INFO
> -		       "-- no UPR register... unable to detect configuration\n");
> -		return;
> -	}
> -
> -	if (upr & SPR_UPR_DCP)
> -		printk(KERN_INFO
> -		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
> -		       cpuinfo->dcache_size, cpuinfo->dcache_block_size,
> -		       cpuinfo->dcache_ways);
> -	else
> -		printk(KERN_INFO "-- dcache disabled\n");
> -	if (upr & SPR_UPR_ICP)
> -		printk(KERN_INFO
> -		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
> -		       cpuinfo->icache_size, cpuinfo->icache_block_size,
> -		       cpuinfo->icache_ways);
> -	else
> -		printk(KERN_INFO "-- icache disabled\n");
> -
>  	if (upr & SPR_UPR_DMP)
>  		printk(KERN_INFO "-- dmmu: %4d entries, %lu way(s)\n",
>  		       1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
> @@ -155,8 +134,6 @@ static void print_cpuinfo(void)
>  void __init setup_cpuinfo(void)
>  {
>  	struct device_node *cpu;
> -	unsigned long iccfgr, dccfgr;
> -	unsigned long cache_set_size;
>  	int cpu_id = smp_processor_id();
>  	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
>  
> @@ -164,20 +141,6 @@ void __init setup_cpuinfo(void)
>  	if (!cpu)
>  		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
>  
> -	iccfgr = mfspr(SPR_ICCFGR);
> -	cpuinfo->icache_ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
> -	cache_set_size = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
> -	cpuinfo->icache_block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
> -	cpuinfo->icache_size =
> -	    cache_set_size * cpuinfo->icache_ways * cpuinfo->icache_block_size;
> -
> -	dccfgr = mfspr(SPR_DCCFGR);
> -	cpuinfo->dcache_ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
> -	cache_set_size = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
> -	cpuinfo->dcache_block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
> -	cpuinfo->dcache_size =
> -	    cache_set_size * cpuinfo->dcache_ways * cpuinfo->dcache_block_size;
> -
>  	if (of_property_read_u32(cpu, "clock-frequency",
>  				 &cpuinfo->clock_frequency)) {
>  		printk(KERN_WARNING
> @@ -320,14 +283,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  		seq_printf(m, "revision\t\t: %d\n", vr & SPR_VR_REV);
>  	}
>  	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
> -	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache_size);
> -	seq_printf(m, "dcache block size\t: %d bytes\n",
> -		   cpuinfo->dcache_block_size);
> -	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache_ways);
> -	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache_size);
> -	seq_printf(m, "icache block size\t: %d bytes\n",
> -		   cpuinfo->icache_block_size);
> -	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache_ways);
>  	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
>  		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
>  		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
> diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> index eb43b73f3855..acdf2dc256bf 100644
> --- a/arch/openrisc/mm/cache.c
> +++ b/arch/openrisc/mm/cache.c
> @@ -16,10 +16,15 @@
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  
> -static __always_inline void cache_loop(struct page *page, const unsigned int reg)
> +static __always_inline void cache_loop(struct page *page, const unsigned int reg,
> +				       const unsigned int cache_type)
>  {
>  	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
>  	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> +	unsigned long upr = mfspr(SPR_UPR);
> +
> +	if (!(upr & SPR_UPR_UP & cache_type))
> +		return;
>  
>  	while (line < paddr + PAGE_SIZE) {
>  		mtspr(reg, line);
> @@ -29,13 +34,13 @@ static __always_inline void cache_loop(struct page *page, const unsigned int reg
>  
>  void local_dcache_page_flush(struct page *page)
>  {
> -	cache_loop(page, SPR_DCBFR);
> +	cache_loop(page, SPR_DCBFR, SPR_UPR_DCP);
>  }
>  EXPORT_SYMBOL(local_dcache_page_flush);
>  
>  void local_icache_page_inv(struct page *page)
>  {
> -	cache_loop(page, SPR_ICBIR);
> +	cache_loop(page, SPR_ICBIR, SPR_UPR_ICP);
>  }
>  EXPORT_SYMBOL(local_icache_page_inv);

OK, if we move the range flush and invalidate here we will need to add to this
cache_loop a bit more.

> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index d0cb1a0126f9..bbe16546c5b9 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -124,6 +124,7 @@ static void __init map_ram(void)
>  void __init paging_init(void)
>  {
>  	int i;
> +	unsigned long upr;
>  
>  	printk(KERN_INFO "Setting up paging and PTEs.\n");
>  
> @@ -176,8 +177,11 @@ void __init paging_init(void)
>  	barrier();
>  
>  	/* Invalidate instruction caches after code modification */
> -	mtspr(SPR_ICBIR, 0x900);
> -	mtspr(SPR_ICBIR, 0xa00);
> +	upr = mfspr(SPR_UPR);
> +	if (upr & SPR_UPR_UP & SPR_UPR_ICP) {
> +		mtspr(SPR_ICBIR, 0x900);
> +		mtspr(SPR_ICBIR, 0xa00);
> +	}

Here we could use new utilities such as local_icache_range_inv(0x900,
L1_CACHE_BYTES);

Or something like local_icache_block_inv(0x900).  This only needs to flush a
single block as the code it is invalidating is just 2 instructions 8 bytes:

    .org 0x900
	l.j     boot_dtlb_miss_handler
	 l.nop

    .org 0xa00
	l.j     boot_itlb_miss_handler
	 l.nop
>
>  
>  	/* New TLB miss handlers and kernel page tables are in now place.
>  	 * Make sure that page flags get updated for all pages in TLB by
> -- 
> 2.48.1

-Stafford
