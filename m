Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE251DED4A
	for <linux-openrisc@vger.kernel.org>; Thu, 20 Feb 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031971; cv=none; b=f4HbtQ6giGWcNnV2K35H/QQuUrJ1Xyw1YlmjZrhuVUSlZxW5Wqc7qsN9pw8vvR4Hte/fyqhRi/LwhA+/Xd7KAYkxNEYGcZ8/vjgtUmc/P9Qgj21PBOXVTYjpKZfzCpCOrWef7rov+JDqfV/4DDiiglUSJMU579Knu641c1yBLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031971; c=relaxed/simple;
	bh=LmzqBEK0Q1x8v5yacxrS0dshRj+fdiujgzMPCZW6hyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJOxwWovB2zV2JlSEnfKMXXMHnp2/9TYZlmupSa9IZPVsrKsirDi/sHdXEZEcIRA48fS5HGpcJaYU92JF30hP7rP3AXbsJezhwYjFSgXrBILUCYaqzl4vhd+OfKfxXz+QqiC3WQGa35/ca9HOFfAvJ1ZEWIinZe5VFwQpo6Pv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/3kkBvq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/3kkBvq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439a2780b44so2940495e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 19 Feb 2025 22:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740031968; x=1740636768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FQ7BWf4pHPMX2iAcfE/zPia3wZ3fZsAvLWmh2mWAICE=;
        b=k/3kkBvq/KtnnVaImuCp9mUehaYqESwW/MvgP9XCCMg5hwU+4lu6G10mDviQehjevA
         RUzB5f7mCv9c2tkwCle0ryjUNIZOMWDaM59IntPQzGgzhdh9+hHppx6jVIKOMFA5tLr1
         0uOtLEGG2sqcZLmz/wwNYBWDk6aVVcEbi6N3WL8kn5t+YZaMiPowL7DjFIFmkXtMtaSu
         lBoteGubPWARmM/3hdeI/ijIkmTt41mkaR8n0B2M8CGFvrPCijqRl2vbddVqxsso6V2o
         EE/e1fIxkEb4HIExzWIOJuD3ZGtPWWE0XIk7f+cKtA1zd4U6U77yErVZsFBX92sld/Zn
         JQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031968; x=1740636768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ7BWf4pHPMX2iAcfE/zPia3wZ3fZsAvLWmh2mWAICE=;
        b=FZJW7TRTG39MGxyOuGbnyV4YJtElc1ol+X+D/ZS5HnUvhm7rAoFDBn5NQEgtuVeYcL
         Ff+7q97eNRUjebLt9VW9+xN5FrP0dUeerPI0efoomFWatASGse8nZ79MlAqOgxXWC8Yk
         Dkqv0QPINZYE5N+CSUleuzR3WK8bSiPU7B10ewqjoQZ6mMHrw9ztIZ/fASTiWdz0108i
         +4cjFQkISnE+YOtwX/04gOPpqLPyHRDPVXKLZitASL7LK5/LQylchB/CZ9jJqoq8MNUl
         ZxpqQk4FJb2vqPcnJ4bai7MwTJkLFJ2OcHMqboZAd9lZCNu/Ertd0g08AFJI8C/GvJMX
         LhgQ==
X-Gm-Message-State: AOJu0YyUwReTZiInXRBQU8MJm4UigTghlxtI1HLAtUXHBS5ZrxYd2eLU
	XxF/9U/+yv14sI5/C+rkajRVGredEaeaSWqbMdXUBy1OeI+qzMZLRQHdtLzC
X-Gm-Gg: ASbGncuV1f5D6GQx/BXM37yanPjdU9Ixxrr4KmvPoJnbHxV6GMt7ut9vHYD4Aneh05K
	yPBaet21siPJlT4y8jN4MnyVfIoqdmKOJ9n+5SVMiNBRzs9aa4/LDqiX0DAqr9f81gKU7v5o7PT
	uQlKyis2zanv4caWBf+MpEIv/Qkr0SqcAPDB2L8aoyTT16ZWfQ4KuMdDmifsKMThfRBGG4K0xbS
	Mx/VBK9GDUBQOUY3JGZgikUuvxoxpb53+38L2GUyY+vKrFEF5BRzjB67oa39Oegx2ICfRj9dxCR
	STzgh/zTorYgUh83n7Xv2Lvt3dKBTMoCoo7EJ4+XwPeKNcAZ19E2rhA=
X-Google-Smtp-Source: AGHT+IGCuqkNCTJva+uRvlCdCxEqZNsb2lqm8Cnvho7C80BAlKR73+Uu2biQntX9u/VDDJYclPXALQ==
X-Received: by 2002:a05:600c:450b:b0:439:9225:2f50 with SMTP id 5b1f17b1804b1-43999db0139mr60844075e9.16.1740031967858;
        Wed, 19 Feb 2025 22:12:47 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm102607825e9.3.2025.02.19.22.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:12:44 -0800 (PST)
Date: Thu, 20 Feb 2025 06:12:43 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: Queries regarding OpenRISC CPU cache
Message-ID: <Z7bH2zKIi6GHsqm9@antec>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec>
 <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
 <Z4SzVtTIuVN7gsX8@antec>
 <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
 <Z5STI5WUqCXPwcNF@antec>
 <ae00d43a-f8bb-4919-8ee1-079a30bc6f42@gmail.com>
 <d789bca7-0266-44e1-bc36-966a70adcf26@gmail.com>
 <b6ba7708-6c4d-41df-b057-9f92b4e938f9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ba7708-6c4d-41df-b057-9f92b4e938f9@gmail.com>

Hi Sahil,

Sorry I missed replying to your last mail.  I hope the below answers help.

On Wed, Feb 19, 2025 at 01:08:18AM +0530, Sahil Siddiq wrote:
> Hi,
> 
> On 2/12/25 8:59 PM, Sahil Siddiq wrote:
> > Hi,
> > 
> > I have started working on implementing cacheinfo support for OpenRISC, and
> > I have got a few queries.
> > 
> > Q1.
> > Does OpenRISC support multilevel cache hierarchy? I couldn't find anything
> > in the architecture manual [1] mentioning the possibility of a multilevel
> > cache hierarchy. I wasn't able to find anything in the verilog implementation
> > either [2].

Currently all implementations support only a single level of cache.  I think if
we would support multiple levels ever we could use device tree to define L2
caches, etc.

See for example:

  Documentation/devicetree/bindings/cache/freescale-l2cache.txt

These are the device tree bindings for a freescale l2cache.

> > Q2.
> > In /sys/devices/system/cpu/cpuX/cache, each indexY directory corresponds
> > to a CPU cache. According to the OpenRISC 1000 Architecture specification [1],
> > it is possible to have a unified cache. In such a case, registers controlling
> > the instruction and data cache represent the same thing (section 9.1 of the
> > manual).
> > 
> > Consequently, should there be only one index (i.e. index0), or should there
> > be 2 index directories (index0 and index1) with identical content? If aunified
> > cache is used, will the DCP and ICP bits both be set in the UPR register?

If we have a unified cache, I think there is actually no way to tell its unified
from the configuration registers.  So I think we have to treat it as if we have
both iCache and dCache.

So we should have index0 and index1.

> > Q3.
> > Cache-related arithmetic performed in arch/openrisc/kernel/setup.c:setup_cpuinfo() [3]
> > cannot be avoided. But we can expose this info in sysfs instead of cpuinfo as
> > specified in this mail [4]. So, I was thinking of moving these calculations to
> > arch/openrisc/kernel/cacheinfo.c in init_cache_level().
> > 
> > What are your thoughts on this?

Yes, I think so too.

> > Another thing I noticed in the current implementation is that these calculations
> > are performed for icache and dcache before using the UPR register to check if
> > they even exist. Should these calculations instead be performed after determining
> > that they exist?
> > [...]

Yes, that would be better.

> Building on my previous mail, I noticed another thing:
> 
> On 1/25/25 1:00 PM, Stafford Horne wrote:
> > On my x86 machine I see:
> > 
> >      $ tree /sys/devices/system/cpu/cpu0/cache/
> >      /sys/devices/system/cpu/cpu0/cache/
> >      ├── index0
> >      │   ├── coherency_line_size
> >      │   ├── id
> >      │   ├── level
> >      │   ├── number_of_sets
> >      │   ├── physical_line_partition
> >      │   ├── shared_cpu_list
> > 
> > On or1k I only see (no cache info yet):
> > 
> >      $ tree /sys/devices/system/cpu/cpu0/
> >      /sys/devices/system/cpu/cpu0/
> >      |-- of_node -> ../../../../firmware/devicetree/base/cpus/cpu@0
> >      |-- subsystem -> ../../../../bus/cpu
> >      |-- topology
> >      |   |-- core_cpus
> >      |   |-- core_cpus_list
> >      |   |-- core_id
> >      |   |-- core_siblings
> >      |   |-- core_siblings_list
> >      |   |-- package_cpus
> >      |   |-- package_cpus_list
> >      |   |-- physical_package_id
> >      |   |-- thread_siblings
> >      |   `-- thread_siblings_list
> >      `-- uevent
> > 
> > But we do have some cache info available via cpuinfo:
> > 
> >      $ cat /proc/cpuinfo | head -n16
> >      processor               : 0
> >      cpu                     : OpenRISC-13
> >      revision                : 8
> >      frequency               : 20000000
> >      dcache size             : 256 bytes
> >      dcache block size       : 16 bytes
> >      dcache ways             : 1
> >      icache size             : 32 bytes
> >      icache block size       : 16 bytes
> >      icache ways             : 2
> >      immu                    : 128 entries, 1 ways
> >      dmmu                    : 128 entries, 1 ways
> >      bogomips                : 40.00
> >      features                : orbis32  orfpx32
> > 
> 
> While I can see icache and dcache info in /proc/cpuinfo, dmesg reports
> that the caches have been disabled.
> 
> OF: reserved mem: Reserved memory: No reserved-memory node in the DT
> CPU: OpenRISC-13 (revision 8) @20 MHz
> -- dcache disabled
> -- icache disabled
> -- dmmu:  128 entries, 1 way(s)
> -- immu:  128 entries, 1 way(s)
> -- additional features:
> -- power management
> -- PIC
> -- timer
> 
> This is because the value of upr is 0x719 and the value of SPR_UPR_DCP is
> 0x2. ANDing both values gives 0 which, according to the arch manual [1], means
> there's no dcache. The same thing applies to icache.

If you are using qemu this is correct.

  target/openrisc/cpu.c:    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;

There is no cache in qemu as we use the actual host cpu cache to speed up
memory operations.  You could modify qemu to help with testing your cacheinfo
changes though.

-Stafford

> Thanks,
> Sahil
> 
> [1] https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf (Section 16.3)
