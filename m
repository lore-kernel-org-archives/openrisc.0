Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A327456;
	Wed, 26 Mar 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007814; cv=none; b=V4aghV+Lu5VdJNx81tfQxpT+xJEvUHPBCEXd07/6rJ1CM3b7of7JdcF0qeNjlGW1wUH91/l9cKlsmLl+7tmsgTZLgC1DO7qvoM57yQn0mh+wIpggIlsphM9vN0EQ5hPpKb42dZ9aVZw/9dacOAr3AAJKcRLxRhkTJV+hbHooFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007814; c=relaxed/simple;
	bh=etAZqQaYWkqjzASZ23KNQtAEL0J4RY8rLP3GIsBFF9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTjrQCgADNnw+y8FYfdY0KIefLzv2waLtwVTdId+hpFtmvq6aWKy4gvNqpDPp/yeLnxAZGif/x8rvj8sfi13G2bYldGshHZpI00T+hMdfKfJFFlbfUxjPU1Epxi3kC/YjZvsISw521RDPXPoQ1Ug5bjmDSYDZ/SBnktoPq+aoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcewaUdw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcewaUdw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so395395e9.1;
        Wed, 26 Mar 2025 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743007811; x=1743612611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cT3szQVg53z3x7cQIma2mQu5F2nUuvb/9P0dqPLOAJE=;
        b=NcewaUdwxmcgTG8tmSdapvZJT/PyTvXGOEotM+Fori5kFMQMEThxJTxUDSrTHOJuM3
         uyAePSrC9eUOzRuhMdbLxYM6CQkjcNOY6DpAxm2LA6Jb4i6v0Iyjl29tEVZ3BS2/NIH6
         jVJpKutV0vYpQAlp8ZOEP39HkpIQgU5Nyh1LMJdXOIsJJh3DyMvR6C0Vx1qitXrrNzRE
         muNzbJ+s04hrwYajfHHHx9RTb/pRJAvuwNsw1ZRgeC06xK+18Q69/6ZtrgurXsN4zuRo
         UQYG83JACq4lJAShV4odONj1uwLq096WJCi3g1UT/GTTymltOQEDydpKoTAxyWOBHlJY
         J4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007811; x=1743612611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT3szQVg53z3x7cQIma2mQu5F2nUuvb/9P0dqPLOAJE=;
        b=EL/LEF+gJ7TM6mIHGq8y1+qQxvphulL7W/L3d5OtuaM3xjJJgyrqo8d/uBaam8V0OK
         0X+keVbGVkAo+Stg1BHQpyfjDkfkEtEkaB8BQcIR5AeVN0+FbUNx0h3EZcND7yCnIEv5
         fFPuEAI60icemExIc31oRJQxfQ5RVsZjSxEkiG4vPdBk5x2a2qYVgBm6h7lMlHjxRKSp
         MPCwlPQVWHqLSNqRr2B+cNEJlwX54yUSCtxvHlBqOA2YBtU5OlwIlZxCorpnoPmfMuPT
         pV1HqEJhAfdvQHL5rE02k20wiHkjKyIZevOLw8gsOmpHx4XWJxtBOYV0LBEKBDdEx6AR
         6eqw==
X-Forwarded-Encrypted: i=1; AJvYcCUDuVRBfOiHz8HsbcGik7rP0oE4Utet9x/YCkgTDoK+hV1OEdihv4QsuPinvyU7roO81Ps9oRBwpJ2yMitC8j8=@vger.kernel.org, AJvYcCXitYdUmALRq33hHdk4yKPt1/6OiIVIPUZXK+0TopQCGzp2hrrk/7m8Pe37a5qqmDWB5hU8PvKmiQAW2mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYzM+Y6bs+ff7IJ54yX+Towri5FyI+E41qR1AbMh6ZsRp406m
	XRVm3tFAuxwpk5fijOWmdNWhqj1UpvnsoVBDDZycchkr5pXfz9r3
X-Gm-Gg: ASbGncv9gTmQAuBOCrKMuJnTALnPbA6clVy1NRbsM5llrt4CdhJkcDrkQCcXq2GmG8s
	JaF1y4GselfPPmZ+dqJAMAqQp8tKVY79vfdjBdKfYPXykkG/6j12oPBPrsNBazcdW0yqYv8DM/7
	tOFZVSt4Ffqk/AL94CiSH3CziLqDhafOUICb0Ibauz2qauHzw0byiKQ2XxKuzaTK1cAaoDPDhn3
	ymjNuEl9G0i4gGwoOz+2ZJqSDFBigdcP9+OjeiST1/+fQN/SEBjx6pz0p5VaDNAWsZ60d6+/iGh
	nvkxAgjGsgh5qJQU0vnwelt+K3GVUhaO9fT25KDFA4PsyHr+fGoUXzlmCACG7CQG/hR460q4WZ0
	WCIzaqerT
X-Google-Smtp-Source: AGHT+IH6NiB8XIrU1ijLe9eO4y2/TzJx8mk5rBdRofVLqr5lrS8RdsoCsaeLeYoC3Nj3VNUNQ/fRuw==
X-Received: by 2002:a05:600c:3506:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-43d8471df17mr5184255e9.8.1743007810338;
        Wed, 26 Mar 2025 09:50:10 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dedd1dsm8026015e9.8.2025.03.26.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:50:09 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:50:08 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] openrisc: Refactor struct cpuinfo_or1k to reduce
 duplication
Message-ID: <Z-QwQNmWPIRyVyPg@antec>
References: <20250323195544.152948-1-sahilcdq@proton.me>
 <20250323195544.152948-2-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323195544.152948-2-sahilcdq@proton.me>

On Mon, Mar 24, 2025 at 01:25:42AM +0530, Sahil Siddiq wrote:
> The "cpuinfo_or1k" structure currently has identical data members for
> different cache components.
> 
> Remove these fields out of struct cpuinfo_or1k and into its own struct.
> This reduces duplication while keeping cpuinfo_or1k extensible so more
> cache descriptors can be added in the future.
> 
> Also add a new field "sets" to the new structure.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>

This looks ok to me.

> ---
> Changes from v1/v2 -> v3:
> - arch/openrisc/kernel/setup.c:
>   (print_cpuinfo):
>   1. Cascade changes made to struct cpuinfo_or1k.
>   2. These lines are ultimately shifted to the new file created in
>      patch #3.
>   (setup_cpuinfo): Likewise.
>   (show_cpuinfo): Likewise.
> 
>  arch/openrisc/include/asm/cpuinfo.h | 16 +++++-----
>  arch/openrisc/kernel/setup.c        | 45 ++++++++++++++---------------
>  2 files changed, 31 insertions(+), 30 deletions(-)
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
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index be56eaafc8b9..66207cd7bb9e 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -115,16 +115,16 @@ static void print_cpuinfo(void)
>  
>  	if (upr & SPR_UPR_DCP)
>  		printk(KERN_INFO
> -		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
> -		       cpuinfo->dcache_size, cpuinfo->dcache_block_size,
> -		       cpuinfo->dcache_ways);
> +		       "-- dcache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
> +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
> +		       cpuinfo->dcache.sets, cpuinfo->dcache.ways);
>  	else
>  		printk(KERN_INFO "-- dcache disabled\n");
>  	if (upr & SPR_UPR_ICP)
>  		printk(KERN_INFO
> -		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
> -		       cpuinfo->icache_size, cpuinfo->icache_block_size,
> -		       cpuinfo->icache_ways);
> +		       "-- icache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
> +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
> +		       cpuinfo->icache.sets, cpuinfo->icache.ways);
>  	else
>  		printk(KERN_INFO "-- icache disabled\n");
>  
> @@ -156,7 +156,6 @@ void __init setup_cpuinfo(void)
>  {
>  	struct device_node *cpu;
>  	unsigned long iccfgr, dccfgr;
> -	unsigned long cache_set_size;
>  	int cpu_id = smp_processor_id();
>  	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
>  
> @@ -165,18 +164,18 @@ void __init setup_cpuinfo(void)
>  		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
>  
>  	iccfgr = mfspr(SPR_ICCFGR);
> -	cpuinfo->icache_ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
> -	cache_set_size = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
> -	cpuinfo->icache_block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
> -	cpuinfo->icache_size =
> -	    cache_set_size * cpuinfo->icache_ways * cpuinfo->icache_block_size;
> +	cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
> +	cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
> +	cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
> +	cpuinfo->icache.size =
> +	    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
>  
>  	dccfgr = mfspr(SPR_DCCFGR);
> -	cpuinfo->dcache_ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
> -	cache_set_size = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
> -	cpuinfo->dcache_block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
> -	cpuinfo->dcache_size =
> -	    cache_set_size * cpuinfo->dcache_ways * cpuinfo->dcache_block_size;
> +	cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
> +	cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
> +	cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
> +	cpuinfo->dcache.size =
> +	    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
>  
>  	if (of_property_read_u32(cpu, "clock-frequency",
>  				 &cpuinfo->clock_frequency)) {
> @@ -320,14 +319,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  		seq_printf(m, "revision\t\t: %d\n", vr & SPR_VR_REV);
>  	}
>  	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
> -	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache_size);
> +	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache.size);
>  	seq_printf(m, "dcache block size\t: %d bytes\n",
> -		   cpuinfo->dcache_block_size);
> -	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache_ways);
> -	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache_size);
> +		   cpuinfo->dcache.block_size);
> +	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache.ways);
> +	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache.size);
>  	seq_printf(m, "icache block size\t: %d bytes\n",
> -		   cpuinfo->icache_block_size);
> -	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache_ways);
> +		   cpuinfo->icache.block_size);
> +	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache.ways);
>  	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
>  		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
>  		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
> -- 
> 2.48.1
> 
