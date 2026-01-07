Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DD2561AE
	for <linux-openrisc@vger.kernel.org>; Wed,  7 Jan 2026 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767761905; cv=none; b=DXiIcwrI5rfOQmLQWlNL+ikWi9mDUfHWzzLU9HZ8S4jpq9yt5o4nvIa2bbsNVJP8bh5n9vJm4z8u9ckIZQMa/r4lBKPBMKRU8deDVcm8qc90w6UlrJTm15lpaYD32RZK1qqhhYHTdRWupYsPF38nO7K+BGqR50MOjtwE8sU8Ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767761905; c=relaxed/simple;
	bh=u52IYXtkIGi8sisrJ2GXaZQiFovGjOBhfJtTiCU+FIM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=f3ClpozWFVypuJGp/HFpMLtPNkR3UXEVdB2GY9eNlddcPSqOFxI/GjuxxqiEJ8BlDa8XoUbx6MdAOLodSZ5kyvae81t8noyRxW68h8EV9WRISFbaRy39/d3dgCt460HLJ22CgQtR813LX5wYoxiJH5BTBCS6zgV9YgQjybin/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE9OHB7K; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE9OHB7K"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso1468104a91.2
        for <linux-openrisc@vger.kernel.org>; Tue, 06 Jan 2026 20:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767761902; x=1768366702; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nurUXHNs091EaceKYt0jtxQiBJ2IaAdTDr7CGJ+zWBU=;
        b=XE9OHB7Kl+IegOavGwsCniq7IfH569pyWSwOB3GH4IFakEzMoVU0qTAM99Htm/LTZa
         oIrdXqofABAYlYf0vbgd+n0GUNiJzVIPiyO8CScU6yhPMURk/UDM/RVMGFEztgjtLPNS
         WRPiIEJnD0Ff9/Z8WNMKc7Anw6/nMx8MAbq3s3xv9xn+5m1oNJCX1ktobB6O3+C+tCKf
         0dT43+gSNEm71HVEC9CZgI8klLsPbgoiQqrHQwigH/O6I0GQ3Ti8owh0piXgvhZN4xe2
         1m7D9Rr/nZ33sxwqrbUB/YINiEIurizt1znhUcLNHdGYLs9ErvXCDeFUGjhnGu4pVoK6
         wLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767761902; x=1768366702;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nurUXHNs091EaceKYt0jtxQiBJ2IaAdTDr7CGJ+zWBU=;
        b=UffAVCM6x2Cnl38BHHQE8f9Ij3EjaJdOgX/rQcae7jYaiO2i8TavmveIXwLZLw9ySN
         rY9RTrBeN7ftY74QHvjoVJ//ZPfQEbIfmzOWk91/Ogiyw6KDRJ2ulFV9rcmI8+Ma1ULl
         8KQrdkZpEjfg9Np0AAUljkSSdWwkUPyOdvSS+VPaK2edKbQKQLXTEszfXHCTkmbxMLnb
         b2z8raiMCwLh36aKUUpYiGTIOYdfN82fNqWdG1z7wtO81d8FgJc1Rzo+YcxabmnvPNKc
         FWcqZ8NCybzHGxD8JtN/yi6srkDDAh7SyIjWzQoe51PA7LDAEVV0mxduCHqFBgtQuw4j
         Jqog==
X-Forwarded-Encrypted: i=1; AJvYcCWDU+WXT4auMY4PCtX9N8OzXAuRR+hfqgaaKERq6hXBObuM1Uyla2vnX2rSn7t94W68mXwfl+1D6YoxdDkXww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAa+tsTmJtM3CdusdfxFQFzS3CHk1u2AdFw+VnbVVqfAlHyQjO
	IStDmih2g9xJF4DnpNOWupmuD/7k9y+7jUB+vRQEa8PMFRc1yFGBEe0q
X-Gm-Gg: AY/fxX7D3YekEKjSuXflkikX/Ln3yFYjVdQL7bka3yNBFIC4EGsDwufZA6Y6sY5j6Ys
	Xtl/B9TSFuh9s36N74XwaWvU6bhnIujuHDNzfeQJPYP6gaI7cmhcnPXF6Gjvin2vgrGzsreTkLB
	t9NphD5gVj/qQiTb5iEihHEqJTjX8hDmlb/w4y4DPGlGdQN96JHxkgrzbQFSH/DV/tAFuwlgISw
	gYp4C577Z35MyVX6nlng0Io5i7eCtDiNS++x0M1+tO2faHQoDyN6dO9flFN4GTLTXabdopOiweZ
	e3vuN7W02SfPMjnc/w/m3wwai0DAIrvnieHIZ5p9yHCbCOfEwqfYik4ZRBZ/81TDXnkodgKZ6H8
	4VTF01RP7DrnBlpqUko49gjRnb0eivOiZDQqaEaM6Vgrn87Nauu7XIy4wD4O2MCItTAZuvAbpDq
	fAL8qh7A==
X-Google-Smtp-Source: AGHT+IE3iEJ4twso46GOnqJPDopUox2qFLaKHiDPKI95vlPPxjV/F7mxvaI/CeOE2s8GrRHRScEd6Q==
X-Received: by 2002:a17:90b:6c7:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-34f68d3b4a4mr1191743a91.33.1767761901762;
        Tue, 06 Jan 2026 20:58:21 -0800 (PST)
Received: from dw-tp ([49.207.192.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb75902sm3622895a91.16.2026.01.06.20.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 20:58:20 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 14/28] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260102070005.65328-15-rppt@kernel.org>
Date: Wed, 07 Jan 2026 09:57:34 +0530
Message-ID: <87ldia9he1.ritesh.list@gmail.com>
References: <20260102070005.65328-1-rppt@kernel.org> <20260102070005.65328-15-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 3ddbfdbfa941..32c496bfab4f 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -221,13 +221,23 @@ static int __init mark_nonram_nosave(void)
>   * anyway) will take a first dip into ZONE_NORMAL and get otherwise served by
>   * ZONE_DMA.
>   */
> -static unsigned long max_zone_pfns[MAX_NR_ZONES];
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
> +{
> +#ifdef CONFIG_ZONE_DMA
> +	max_zone_pfns[ZONE_DMA]	= min(zone_dma_limit, max_low_pfn - 1) + 1;

Hi Mike, 

This doesn't look correct. Isn't the zone_dma_limit value in bytes actually?
Shouldn't it be -

     max_zone_pfns[ZONE_DMA] = min((zone_dma_limit >> PAGE_SHIFT) + 1, max_low_pfn);


-ritesh


> +#endif
> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +#ifdef CONFIG_HIGHMEM
> +	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
> +#endif
> +}
>  
>  /*
>   * paging_init() sets up the page tables - in fact we've already done this.
>   */
>  void __init paging_init(void)
>  {
> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
>  	unsigned long long total_ram = memblock_phys_mem_size();
>  	phys_addr_t top_of_ram = memblock_end_of_DRAM();
>  	int zone_dma_bits;
> @@ -259,15 +269,7 @@ void __init paging_init(void)
>  
>  	zone_dma_limit = DMA_BIT_MASK(zone_dma_bits);
>  
> -#ifdef CONFIG_ZONE_DMA
> -	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> -				      1UL << (zone_dma_bits - PAGE_SHIFT));
> -#endif
> -	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> -#ifdef CONFIG_HIGHMEM
> -	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
> -#endif
> -
> +	arch_zone_limits_init(max_zone_pfns);
>  	free_area_init(max_zone_pfns);
>  
>  	mark_nonram_nosave();
> -- 
> 2.51.0

