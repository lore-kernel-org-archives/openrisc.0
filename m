Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DF1DF251;
	Tue, 18 Mar 2025 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283801; cv=none; b=gOjz1kctn+6ock6KARcq0Svg8W2YpjjHSzW3YooL7CvedlPcdoSUyVsdp0TjzKJIkEMNz0RcZ/5DmsrcuX70NyK5wNoNvaGxZSA+XEhvbvGvMyUQee6pDf7AtlD+OMVUn0STDT5zceH1HdgYP91YQRHp8egBOnRu8yeU9xXwtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283801; c=relaxed/simple;
	bh=VPuVewoYablVgAphA0vv0LY+PV8u6MAmma+F1UDvD2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z18yCOKxS4tWBr+uWzE95z5+2B8SmaOxrTIfqt4aikkuu1Sou9LAipdVDgUGr4chZwIRa+VRvsBmlM8RGaLQAekHTu9x18YqtRcvvtxRAOxxguTNGEfCrr9aJtdt/Jgb/zYzOwjPu+7c8ru5LoE/Kx+c5lNyU6Jaup6srSpNOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEtuuy2/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEtuuy2/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe574976so18100185e9.1;
        Tue, 18 Mar 2025 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742283798; x=1742888598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZNwHaHixbC+cUUu67Lf9scX3ZU1hYDWujVQA3YP9LY=;
        b=GEtuuy2/34ZE1SQ8UbOg64i40PzPba+SZVNdNRRJGneuQ+dsExsfzr3JX4V06S54+D
         o2EUW/TojNl3TEPYX11aK8oWJIHmVhjToKRhx7PFVp3RgympEM64tkr89qFamJopqcKe
         F2279gzVAiLbdKgqIp5ALOFqdoCGVy+0mdAWuuVKgW1ox+j72oGCM6peRuSWLL8BjTO4
         jkSyJF3dYS0r6n5K9no8vfFk0q31XAaQ+7eAUB+9ieNPO6Cri5EJ9Yp3hvow17HTGZdx
         A7/gWgfhfwb3WZ3K3awRLVAOkmcMsYYLFgM6Di/a82w8YdOx8uovHzaYue2Xv0LNVM06
         59Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283798; x=1742888598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZNwHaHixbC+cUUu67Lf9scX3ZU1hYDWujVQA3YP9LY=;
        b=CQAP93uAYMXFRqBY0yemRrz+t9hdlSGa3NXsN5Vy5IsJphcjRCDlbSgIZ7UGWma7na
         FNHs/jZnQiN5tBMrNqUNQ9Yk1fP5zg3XMnRVKKoCYls8MGLu3XR1BAeGJrghtr6xMCgr
         w4zw+3nOCO14bi/ilFNmumM+h08nlK3OL6D2IHH7TEImD9xB9rPhABkNMVnBaeqe3vP8
         LTxZJI7mj1y3YraGgjxvnxxW4DsRK4q8yVh0gVfueogfhmxU8aeZmjbU5Vhojs1fx7bE
         ZDp5OiRuNTnAofwbVt9pbRwpC29WbA+FF74pdde/1SXWcOvQzEwXF6F3NuzIMG3brJ9/
         ZMYg==
X-Forwarded-Encrypted: i=1; AJvYcCVpUx0XCsZte47XIvorvkZZtFuFYOkNo5MKzZ/S5yLiuOd2nVH99fg4U3uNtnd6RjARXK8eHVQZtcwH+jY=@vger.kernel.org, AJvYcCVqSlB9d+y/0FuW+7DmDQmYFk87Froh8Z5DsJRKeNmqv/XwFjU/mb0eRWMS1Kgd+HntxzLQK2a84np71EphZaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjay6a91/32wOS03q29onzb086ULJcAvwEY+VTLVKPKACagf02
	cd+bv50xOqd8MjCPkQsdeC6D4X6DZpjT6CwKrr7f/WCxxJ6LkhYNW+5wPQ==
X-Gm-Gg: ASbGncsdQf7YQYOs0uFSt89bJx3bdrgbWRhbWhHgdeimIZAfuhzCTIjdEzaYMxsyhtM
	88XcPVpBp1jaWjtssZ1XKR7F1iOdh3PEBP05+fqzueClF7VCyKzmp820gcsGqJPExdSv4fiXy+W
	rwUihrl4UlGnIUmjiWf5s3zDL8r6iZ0qw/dvbk0PHgO+HPln4WazOCsVM0kAxCm6ELqxfWtZKu4
	KCNOlMlJFT6037ljZUjI8KIZNu1ZGb4SPA5fjUBT86Wh4xibj+IgGrWctLG4/XND/kvGdSzT2Lh
	mm33aiTTOBeU8H6AIgMkrAiK1By1+lDLTYnfOENm03MazwEv/ssXDZm/gSTV5VXjjMeEFNh1Kqk
	ItGBrgDak
X-Google-Smtp-Source: AGHT+IEafBtR/JzGHoAv6tDhdiyaf1rh3bT40VE0ZTv3sXMIu4Lh5wxkzgvH0TjLcjyrsPskjlz0YA==
X-Received: by 2002:a05:600c:c0a:b0:43c:e8ba:e166 with SMTP id 5b1f17b1804b1-43d3b9bd029mr7346945e9.22.1742283797615;
        Tue, 18 Mar 2025 00:43:17 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc3e67sm126078465e9.17.2025.03.18.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:43:16 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:43:15 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
Message-ID: <Z9kkE3uQru_VxLqA@antec>
References: <20250315203937.77017-1-sahilcdq@proton.me>
 <Z9Z2sjWQHKgGJyGo@antec>
 <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
 <Z9gOwYl6kmoPY9-C@antec>
 <d54849db-956b-4c1a-ab93-4705394af637@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54849db-956b-4c1a-ab93-4705394af637@gmail.com>

Hi Sahil,

On Tue, Mar 18, 2025 at 12:06:30AM +0530, Sahil Siddiq wrote:
> Hello Stafford and Geert,
> 
> Thank you for the reviews.
> 
> On 3/17/25 1:55 PM, Geert Uytterhoeven wrote:
> > On Sun, 16 Mar 2025 at 07:59, Stafford Horne <shorne@gmail.com> wrote:
> > > [...]
> > > > +struct cache_desc {
> > > > +     u32 size;
> > > > +     u32 sets;
> > > > +     u32 block_size;
> > > > +     u32 ways;
> > > 
> > > Considering the changes below to add cache available checks, maybe we
> > > want to add a field here, such as `bool present`.  Or a flags field like
> > > is used in loongarch?
> > 
> > I assume cache_desc.size is zero when the cache is not present?
> 
> Yes, cache_desc.size will be zero when there's no cache component since
> cpuinfo_or1k[NR_CPUS] is declared as a global variable in setup.c. The
> cache attributes are stored in this struct.
> 
> On 3/17/25 5:30 PM, Stafford Horne wrote:
> > [...]
> > Yes, good point, would be clean too work too.  I was not too happy with using
> > cache_desc.ways as is done below.  Also there ended up bieng 2 different ways
> > that were used.
> > 
> > I am happy to use size too, but I think checking the SPR would be faster or just
> > as fast as using the struct.  I am not too fussed either way.
> 
> There are a few places (e.g. cache_loop() in cache.c) where
> cpuinfo_or1k[smp_processor_id()] is not being referenced. This will have to be
> referenced to access cache_desc. In these cases, I think it would be better to
> read from the SPR instead. For consistency, the SPR can also be read where
> cpuinfo_or1k[smp_processor_id()] is already being referenced.
> 
> On 3/16/25 12:28 PM, Stafford Horne wrote:
> > On Sun, Mar 16, 2025 at 02:09:37AM +0530, Sahil Siddiq wrote:
> > > Add cacheinfo support for OpenRISC.
> > > [...]
> > > diff --git a/arch/openrisc/kernel/cacheinfo.c b/arch/openrisc/kernel/cacheinfo.c
> > > new file mode 100644
> > > index 000000000000..6bb81e246f7e
> > > --- /dev/null
> > > +++ b/arch/openrisc/kernel/cacheinfo.c
> > > @@ -0,0 +1,106 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * OpenRISC cacheinfo support
> > > + *
> > > + * Based on work done for MIPS and LoongArch. All original copyrights
> > > + * apply as per the original source declaration.
> > > + *
> > > + * OpenRISC implementation:
> > > + * Copyright (C) 2025 Sahil Siddiq <sahilcdq@proton.me>
> > > + */
> > > +
> > > +#include <linux/cacheinfo.h>
> > > +#include <asm/cpuinfo.h>
> > > +#include <asm/spr.h>
> > > +#include <asm/spr_defs.h>
> > > +
> > > +static inline void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
> > > +				unsigned int level, struct cache_desc *cache, int cpu)
> > > +{
> > > +	this_leaf->type = type;
> > > +	this_leaf->level = level;
> > > +	this_leaf->coherency_line_size = cache->block_size;
> > > +	this_leaf->number_of_sets = cache->sets;
> > > +	this_leaf->ways_of_associativity = cache->ways;
> > > +	this_leaf->size = cache->size;
> > > +	cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
> > > +}
> > > +
> > > +int init_cache_level(unsigned int cpu)
> > > +{
> > > +	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
> > > +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> > > +	int leaves = 0, levels = 0;
> > > +	unsigned long upr = mfspr(SPR_UPR);
> > > +	unsigned long iccfgr, dccfgr;
> > > +
> > > +	if (!(upr & SPR_UPR_UP)) {
> > > +		printk(KERN_INFO
> > > +		       "-- no UPR register... unable to detect configuration\n");
> > > +		return -ENOENT;
> > > +	}
> > > +
> > > +	if (upr & SPR_UPR_DCP) {
> > > +		dccfgr = mfspr(SPR_DCCFGR);
> > > +		cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
> > > +		cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
> > > +		cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
> > > +		cpuinfo->dcache.size =
> > > +		    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
> > > +		leaves += 1;
> > > +		printk(KERN_INFO
> > > +		       "-- dcache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
> > > +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
> > > +			   cpuinfo->dcache.sets,
> > > +		       cpuinfo->dcache.ways);
> > 
> > The indentation of sets looks a bit off here.
> > 
> > > +	} else
> > > +		printk(KERN_INFO "-- dcache disabled\n");
> > > +
> > > +	if (upr & SPR_UPR_ICP) {
> > > +		iccfgr = mfspr(SPR_ICCFGR);
> > > +		cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
> > > +		cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
> > > +		cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
> > > +		cpuinfo->icache.size =
> > > +		    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
> > > +		leaves += 1;
> > > +		printk(KERN_INFO
> > > +		       "-- icache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
> > > +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
> > > +			   cpuinfo->icache.sets,
> > > +		       cpuinfo->icache.ways);
> > 
> > The indentation of sets looks a bit off here. Maybe its the others that are out
> > of line, but can you fix?  Also I think sets and ways could be on the same line.
> 
> Sorry, I must have missed this. I'll fix it.
> 
> > > [...]
> > > diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> > > index b3edbb33b621..ffb161e41e9d 100644
> > > --- a/arch/openrisc/kernel/dma.c
> > > +++ b/arch/openrisc/kernel/dma.c
> > > @@ -36,8 +36,10 @@ page_set_nocache(pte_t *pte, unsigned long addr,
> > >   	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > >   	/* Flush page out of dcache */
> > > -	for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache_block_size)
> > > -		mtspr(SPR_DCBFR, cl);
> > > +	if (cpuinfo->dcache.ways) {
> > > +		for (cl = __pa(addr); cl < __pa(next); cl += cpuinfo->dcache.block_size)
> > > +			mtspr(SPR_DCBFR, cl);
> > > +	}
> > 
> > I think it would be better to move this to cacheflush.h as a function like
> > flush_dcache_range() or local_dcache_range_flush().
> > 
> > >   	return 0;
> > >   }
> > > @@ -104,15 +106,19 @@ void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
> > >   	switch (dir) {
> > >   	case DMA_TO_DEVICE:
> > >   		/* Flush the dcache for the requested range */
> > > -		for (cl = addr; cl < addr + size;
> > > -		     cl += cpuinfo->dcache_block_size)
> > > -			mtspr(SPR_DCBFR, cl);
> > > +		if (cpuinfo->dcache.ways) {
> > > +			for (cl = addr; cl < addr + size;
> > > +			     cl += cpuinfo->dcache.block_size)
> > > +				mtspr(SPR_DCBFR, cl);
> > > +		}
> > 
> > Also here,I think it would be better to move this to cacheflush.h as a function like
> > flush_dcache_range().
> > 
> > Or, local_dcache_range_flush(), which seems to be the convention we use in
> > cacheflush.h/cache.c.
> > 
> > 
> > >   		break;
> > >   	case DMA_FROM_DEVICE:
> > >   		/* Invalidate the dcache for the requested range */
> > > -		for (cl = addr; cl < addr + size;
> > > -		     cl += cpuinfo->dcache_block_size)
> > > -			mtspr(SPR_DCBIR, cl);
> > > +		if (cpuinfo->dcache.ways) {
> > > +			for (cl = addr; cl < addr + size;
> > > +			     cl += cpuinfo->dcache.block_size)
> > > +				mtspr(SPR_DCBIR, cl);
> > > +		}
> > 
> > This one could be invalidate_dcache_range().   Note, this will also be useful
> > for the kexec patches that I am working on.
> > 
> > Or, local_dcache_range_inv(), which seems to be the convention we use in
> > cacheflush.h/cache.c.
> 
> Understood.
> 
> > > [...]
> > > @@ -29,13 +34,13 @@ static __always_inline void cache_loop(struct page *page, const unsigned int reg
> > >   void local_dcache_page_flush(struct page *page)
> > >   {
> > > -	cache_loop(page, SPR_DCBFR);
> > > +	cache_loop(page, SPR_DCBFR, SPR_UPR_DCP);
> > >   }
> > >   EXPORT_SYMBOL(local_dcache_page_flush);
> > >   void local_icache_page_inv(struct page *page)
> > >   {
> > > -	cache_loop(page, SPR_ICBIR);
> > > +	cache_loop(page, SPR_ICBIR, SPR_UPR_ICP);
> > >   }
> > >   EXPORT_SYMBOL(local_icache_page_inv);
> > 
> > OK, if we move the range flush and invalidate here we will need to add to this
> > cache_loop a bit more.
> 
> Right. I'll see what can be done to keep it concise.
> 
> > > diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> > > index d0cb1a0126f9..bbe16546c5b9 100644
> > > --- a/arch/openrisc/mm/init.c
> > > +++ b/arch/openrisc/mm/init.c
> > > @@ -124,6 +124,7 @@ static void __init map_ram(void)
> > >   void __init paging_init(void)
> > >   {
> > >   	int i;
> > > +	unsigned long upr;
> > >   	printk(KERN_INFO "Setting up paging and PTEs.\n");
> > > @@ -176,8 +177,11 @@ void __init paging_init(void)
> > >   	barrier();
> > >   	/* Invalidate instruction caches after code modification */
> > > -	mtspr(SPR_ICBIR, 0x900);
> > > -	mtspr(SPR_ICBIR, 0xa00);
> > > +	upr = mfspr(SPR_UPR);
> > > +	if (upr & SPR_UPR_UP & SPR_UPR_ICP) {
> > > +		mtspr(SPR_ICBIR, 0x900);
> > > +		mtspr(SPR_ICBIR, 0xa00);
> > > +	}
> > 
> > Here we could use new utilities such as local_icache_range_inv(0x900,
> > L1_CACHE_BYTES);
> > 
> > Or something like local_icache_block_inv(0x900).  This only needs to flush a
> > single block as the code it is invalidating is just 2 instructions 8 bytes:
> > 
> >      .org 0x900
> > 	l.j     boot_dtlb_miss_handler
> > 	 l.nop
> > 
> >      .org 0xa00
> > 	l.j     boot_itlb_miss_handler
> > 	 l.nop
> 
> Given that there'll be generic local_(i|d)cache_range_inv(start, stop) utility
> functions, would it make sense to simply have a macro defined as:
> 
> #define local_icache_block_inv(addr) local_icache_range_inv(start, L1_CACHE_BYTES)
> 
> instead of having a separate function for invalidating a single cache line? This would
> still use cache_loop() under the hood. The alternative would be to use
> local_icache_range_inv(start, L1_CACHE_BYTES) directly but using the macro might be
> more readable.

Yes, I think a macro would be fine.  Should we use cache_desc.block_size or
L1_CACHE_BYTES?  It doesn't make much difference as L1_CACHE_BYTES is defined as
16 bytes which is the minimum block size and using that will always invalidate a
whole block.  It would be good to have a comment explaining why using
L1_CACHE_BYTES is enough.

-Stafford
