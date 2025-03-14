Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981518E756;
	Fri, 14 Mar 2025 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985781; cv=none; b=WTvf25TaBzTOUWaSp6cLM1aoJ+B7nW6zslydcwR53sx2q2Dc2BxWTI3hi2rDas2FyV8iPgRJ1y2PwVqArHFY0ST4UrGjP/45Y2KKiCHwkfqjg32PnIklEg0f1nSpR9armbCbajFy/ztTzC7x80JzGkPB2OFcWTS1R2iZOJDL19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985781; c=relaxed/simple;
	bh=iMSgarGi3krQEJm++0O0SbMFE13iiQP7gPT7GMX+qiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W15VUe/awdlPp1ikloSiQo+nhlPs8kNgISocYLrF2R+P4bHbE0snQAkk1eXTjeEp17ioHgOwXFE7Yl0NBC+cyt57miIDPtRDS7u0+VM/gq1jE4tWwS7TtJTUMW4hiLuR+Nz2nYph88o7tirIMuzp77VzRvTpfIjLjNCm4rz+xAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJe26a6f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJe26a6f"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-394780e98easo1650680f8f.1;
        Fri, 14 Mar 2025 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741985777; x=1742590577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XvA72KRtE9ykA6OaKpXZqUYJNmXiecakc7nsFpYupQ=;
        b=JJe26a6fdcpCyTMk5UnsWiBofNdVmkxE7j969YIoqoQyizRgsdOcvt5bKuy16nihK7
         fTgqIDBQyoy+Cvdx3pvzknLdKfHJyi7pjp1Jh/z+K6QD6PnaZXV8oMZQjsuwEal+OnPS
         xQbwMiTtAHJgh3vS+tOtquIFMqbSsJclY6sIMNllECm9gNuLM17e0ShkGjUgpquo+bRt
         56RdruRQO6T1lqvwn/FPi7S9QLmEq0ZD4A8zHHxLVtgs/ijJcGgNadW9gnSknlKW0QiX
         NbYmUHFSD2tdmShAOQ0QTh4luKQTxb9njDwu4kURj3XexibLD3f2tIueMtWg7HR99hn/
         NzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985777; x=1742590577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XvA72KRtE9ykA6OaKpXZqUYJNmXiecakc7nsFpYupQ=;
        b=sF4PMzsFx5mVFfsw5IGbLJrB0YrqVb+REKSb4h7b2uQD7qfAG1gNYR48PV1IOnOYW3
         MfQVFn3f1sd2gkj2KG6W4W77g1tpzhKgvDePQAfqvdL6aSRonh7oQ3u/Fb53Umfba/hS
         NzpgK8so+MwOBBfrPP3WwDD/fiVQNZkCC7PXRGX94IvcwztValrWQVugpkG0/5m4U/Nn
         0WW/PXd1e1fe9eOBBJrTJDhhm6NcaTP0MVfDzbT6KzDsyoklD8tdk/PqmHHPtARTD0Fz
         xeYkX5FceRGcy8hW5IZApU4y79G42tlyUA6LKc1xO5igIId4MVX9zaiFWz93jaatNMzW
         orfA==
X-Forwarded-Encrypted: i=1; AJvYcCULi8Sa9Gv1xtCezOZAJbPvvir880J3dT8PR63TQFVU09WtPq6+lpylu426ooCP9pVbxpU9gOCp5w0Bgy8=@vger.kernel.org, AJvYcCXImdYltrWoYsnm9DqKMh0E7XS0dXaXKlagaEiLxGm7N0IDWl5aJOr7u1WmATYsbsS6QrFvb5wBilcl9Piu/60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7kw91VaOpDWQEMcUBZgxx8myuw9mNQZ6aJTteKC+L7oWM7rw
	sBLRk9w6x1GLTYXdPx+aYTwf2InWOJgnZ9UL7SisXqf4SvE5aVgV
X-Gm-Gg: ASbGncvGtTP/7BCMzLe5lnIRjK0+e4io1IBow6CMutRSdpDiWlNHXytrANG3FBQALWQ
	pwgQ1ZXXm3PySZO+F6O8Pv7dv0BYSz407aWDBFeduDLGGch+fk9O78Ag0d0p/zmS7KmIJknEvl8
	y8RxJ31IWzosAwykF24zOUIeoCLb4IalSQo57T1JadMFj+HSHr3VyysnLh0DzI/0vxLys9RPorI
	EVZU1QSUb3UD/Rj3ZVWeRloD3TtFZFSrOQ6FuYdgfy6HIhow0p90CJzOGpBa292HKViusXMcjQ5
	Pogo12fwY+HzCHNwLDi1USQ7moEl/LWhsjfg/7N/HiEI0UkEmH8g/X6T+rUVgKjntRWBbpC2pej
	TOiaR9+blsKsDOXvaiVU=
X-Google-Smtp-Source: AGHT+IEs/WKOQPjFGV0aoNdB2WhHlKZBgSHJIoJwuaamm+ZJDpLpBtCL4BNxsqmU82Oa3Ao/u1kxMQ==
X-Received: by 2002:a5d:6484:0:b0:38f:23f4:2d7a with SMTP id ffacd0b85a97d-3971f9e79fcmr5636583f8f.40.1741985776438;
        Fri, 14 Mar 2025 13:56:16 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe609a2sm27733215e9.30.2025.03.14.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:56:15 -0700 (PDT)
Date: Fri, 14 Mar 2025 20:56:14 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] openrisc: Add cacheinfo support
Message-ID: <Z9SX7thyConoDjLT@antec>
References: <20250310191358.67912-1-sahilcdq@proton.me>
 <Z9NM8K92M8kS6t4k@antec>
 <ee43f507-c0a2-45ed-818e-f24babf07d60@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee43f507-c0a2-45ed-818e-f24babf07d60@gmail.com>

On Sat, Mar 15, 2025 at 01:34:03AM +0530, Sahil Siddiq wrote:
> Hi,
> 
> On 3/14/25 2:54 AM, Stafford Horne wrote:
> > On Tue, Mar 11, 2025 at 12:43:57AM +0530, Sahil Siddiq wrote:
> > > Add cacheinfo support for OpenRISC.
> > > 
> > > [...]
> > > None of the functions in drivers/base/cacheinfo.c that are capable of
> > > pulling these details (e.g.: cache_size) have been used. This is because
> > > they pull these details by reading properties present in the device tree
> > > file. In setup.c, for example, the value of "clock-frequency" is pulled
> > > from the device tree file.
> > > 
> > > Cache related properties are currently not present in OpenRISC's device
> > > tree files.
> > 
> > If we want to add L2 caches and define them in the device tree would
> > it "just work" or is more work needed?
> > 
> 
> A little more work will have to be done. The implementation of "init_cache_level"
> and "populate_cache_leaves" will have to be extended. To pull L2 cache attributes,
> they'll need to make calls to the "of_get_property" family of functions similar to
> what's being done for RISC-V and PowerPC.
> 
> Shall I resubmit this patch with those extensions? I think I'll be able to test
> those changes with a modified device tree file that has an L2 cache component.

Since we don't have any such hardware now I don't think its needed.

> > > Regarding the "shared_cpu_map" cache attribute, I wasn't able to find
> > > anything in the OpenRISC architecture manual to indicate that processors
> > > in a multi-processor system may share the same cache component. MIPS uses
> > > "globalnumber" to detect siblings. LoongArch uses a "CACHE_PRIVATE" flag
> > > to detect siblings sharing the same cache.
> > 
> > In SMP environment the L1 caches are not shared they are specific to each CPU.
> > 
> > Also, we do not have hyperthreading in OpenRISC so shared_cpu_map should be a
> > 1-to-1 mapping with the cpu.  Do you need to do extra work to setup that
> > mapping?
> > 
> 
> No extra work has to be done to set up the 1-to-1 mapping. This is already being
> done in "ci_leaf_init()".

OK.

> > > I am running with the assumption that every OpenRISC core has its own
> > > icache and dcache. Given that OpenRISC does not support a multi-level
> > > cache architecture and that icache and dcache are like L1 caches, I
> > > think this assumption is reasonable. What are your thoughts on this?
> > 
> > Currently this is the case, but it could be possible to create an SoC with L2
> > caches.  I could imagine these would be outside of the CPU and we could define
> > them with the device tree.
> 
> In this case, some extra work will have to be done to set the "shared_cpu_map"
> appropriately. But I think the modifications will be quite small. If the L2 cache
> is external to all CPUs, then all online CPUs will have their corresponding bit
> set in the "shared_cpu_map".

Yes, it could be so.  For now, let's not do this as no such hardware exists.

> > > Another issue I noticed is that the unit used in ...cache/indexN/size
> > > is KB. The actual value of the size is right-shifted by 10 before being
> > > reported. When testing these changes using QEMU (and without making any
> > > modifications to the values stored in DCCFGR and ICCFGR), the cache size
> > > is far smaller than 1KB. Consequently, this is reported as 0K. For cache
> > > sizes smaller than 1KB, should something be done to report it in another
> > > unit? Reporting 0K seems a little misleading.
> > 
> > I think this is fine, as long as we pass in the correct size in bytes.
> 
> Understood.

OK.

> > > [...]
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
> > > +		       "-- dcache: %4d bytes total, %2d bytes/line, %d way(s)\n",
> > > +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
> > > +		       cpuinfo->dcache.ways);
> > 
> > Can we print the number of sets here too?  Also is there a reason to pad these
> > int's with 4 and 2 spaces? I am not sure the padding is needed.
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
> > > +		       "-- icache: %4d bytes total, %2d bytes/line, %d way(s)\n",
> > > +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
> > > +		       cpuinfo->icache.ways);
> > 
> > Same here.
> 
> 
> Sure, I'll print the number of sets as well.
> 
> I don't think there's any reason for the padding. It was part of the original
> implementation in setup.c. There shouldn't be any issues in removing them.

Right, it would be good to fix.

> > > [...]
> > >   	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
> > > -	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache_size);
> > > -	seq_printf(m, "dcache block size\t: %d bytes\n",
> > > -		   cpuinfo->dcache_block_size);
> > > -	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache_ways);
> > > -	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache_size);
> > > -	seq_printf(m, "icache block size\t: %d bytes\n",
> > > -		   cpuinfo->icache_block_size);
> > > -	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache_ways);
> > >   	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
> > >   		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
> > >   		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
> > > -- 
> > > 2.48.1
> > > 
> > 
> > This pretty much looks ok to me.
> > 
> 
> Thank you for the review.

Thank you.

-Stafford
