Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3462156C74
	for <linux-openrisc@vger.kernel.org>; Sun, 26 Jan 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737921286; cv=none; b=q1DReY2GvYdwZm/F+kdci1ysYiYD8rroLRhD5cV39C8F2HGUjHynK3H8nu3TQ6U4tibt1SyXU97ZeFJOkqmf2ced5P3bn8CULmgf/Ctpo4+vNLRIISqt6eeYoyAAhOKXW33itqsDJJFtr+zcdC2gWQxOcv6OFJzXVFxwzq8LVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737921286; c=relaxed/simple;
	bh=EyXmhJaM/PmzZSbO1TLSnIcB1JvV7CWR0qN9LeB7axY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F05v4V1y6nroKpRZiPcv4bSpk9VJqAjTagilLvb1fgM8GUsRCiKEJZn0IBrEb2rlBZEzTuQdR+sr2AeWwNM0i0IEpPFcIU/uLXCeKPSKuUVfCWOhC4pVHwOGHmvCz2lWCDnd7zTHvd3aUSrhFidxNYHhGPT/Ji3FOUTx5+b9Hs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgl00dLP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgl00dLP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2165cb60719so64075785ad.0
        for <linux-openrisc@vger.kernel.org>; Sun, 26 Jan 2025 11:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737921284; x=1738526084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bvDA9Bj9gNaM2PDIXB1uuS3cEw3XMzywHkjDqAMlqdk=;
        b=dgl00dLPp5Gkao0BuHW2W+0buCh0eqNzywu5MF1tuDMf60NyqZ5E0f9hNubbZtIRon
         6iFOrPT6tZCY8negEMtO0ZNdzmtZYXJjKjkZy2nmFX31S3Joud0P437xyhG0WvqgIqdQ
         hZ1lwLcCTQYXwItFRUEf4kkbkrhR28Y6s7HqJOfQtK7F2wKSEZI9u7fRyI4vsz4QwuXc
         cDvvxYAUDYeMp5uIjHStzld/APmuHBpTY0xRfmeV+/VFtGAzgL/BgG8TviLM1jwxuqA8
         c41N98y8oQVHaS4y1uy+h0TCQGj3mdbBRGR8lrG0NGIe5/bsyFveTp16jp2FlQVpgLaz
         a1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737921284; x=1738526084;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvDA9Bj9gNaM2PDIXB1uuS3cEw3XMzywHkjDqAMlqdk=;
        b=fyj0hx/XxQ3lsojZ7No4gV6wouDmU6YbGuqXDmTv4y+gbU+ig4syR6rJ8qYTKfHH4d
         QV8pGYBtdhx6W4r21mrijAPaINsnHRWfa76Za/CT8SXDlWeMwKYo3WvTB8W9YmFAKwxT
         fWQxrsnkBGrqeXG+uIwbfBVF9ZKDJfwLKrca5wjjAIX1G1/2N1+CslWXd1Nvp+ipKOco
         gVf42+cslZk4OySXOpgeEBn4Z1seJq/3ioUsET7J9/meOHGnlQ5xXVPb8gSg1/2DRq1z
         K9FHHJp2wcwG8zxYuONvujfvaPd5SjZ7odgLQFVJrD5S2RdkxIC5MjFAkqDVa+LrWt02
         f2NQ==
X-Gm-Message-State: AOJu0YwfoRaq6XEOuKJXpJUBpT6yimoekfdD84mIfAK/1ftPKYvXH522
	eYZN7/vonfx/bVT5pvfxve9NP8jOny+SIB9f9hbqVbwvT0f2yGQldpGYHQ==
X-Gm-Gg: ASbGncv3ZbTtMl8l976Ix2C5yOB7cqJilaM8yLiELTTIjfppRVh8kYo66EVNxyI+4yW
	2CefUspBGhevCu8cg2BFwtXNn8PIta34jeVTwk/3kIxWnsqgeX90/LYSeLmMb6cTpi1r2Fkue7s
	3rFqFZN+DnEaJeegWnCIrPBX0uggPMbvJ6S1TPSaaIQIQ41MlV0M20JXvwyDKObgdl5MjvcG3nt
	rSZz7jzsHism8UKthYcOqLZWnmEbHqmiJuRO5J9o/hQd44I708=
X-Google-Smtp-Source: AGHT+IFvZkR/SpyivLcriNRHPQp1RL6AaVx/QNQJrWtg+aEL4Mb/iFs4OnFyFIGZuaVwiuMVuzNDqw==
X-Received: by 2002:a17:902:f690:b0:216:4348:149d with SMTP id d9443c01a7336-21c356228a8mr563782965ad.53.1737921284062;
        Sun, 26 Jan 2025 11:54:44 -0800 (PST)
Received: from [192.168.0.106] ([182.48.214.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424eea4sm49214785ad.238.2025.01.26.11.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 11:54:43 -0800 (PST)
Message-ID: <ae00d43a-f8bb-4919-8ee1-079a30bc6f42@gmail.com>
Date: Mon, 27 Jan 2025 01:24:41 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Contributing to OpenRISC Linux
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec> <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
 <Z4SzVtTIuVN7gsX8@antec> <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
 <Z5STI5WUqCXPwcNF@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z5STI5WUqCXPwcNF@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/25/25 1:00 PM, Stafford Horne wrote:
> On Thu, Jan 23, 2025 at 12:25:59AM +0530, Sahil Siddiq wrote:
> [...]
>>>> Got it. I did find this list in the online documentation [1] but I couldn't find
>>>> the cacheinfo task listed there.
>>>
>>> Right, not all features have config flags that are documented.
>>>
>>
>> Understood. Do you know how one finds these flags? I wasn't able
>> to find much related to cpu or caches in arch/openrisc/Kconfig [1].
>> I did find the usage of ARCH_HAS_CPU_CACHE_ALIASING in
>> include/linux/cacheinfo.h [2]. I am not sure if this is relevant.
> 
> Not all features are enabled using ARCH_ flags.  The cacheinfo apis are always
> enabled and compiled, even for or1k now.  But if we look, we see the default
> implementation is defined with __weak symbols:
> 
>    drivers/base/cacheinfo.c
>    include/linux/cacheinfo.h
> 
>      int __weak init_cache_level(unsigned int cpu)
>      {
> 	    return -ENOENT;
>      }
> 
>      int __weak populate_cache_leaves(unsigned int cpu)
>      {
> 	    return -ENOENT;
>      }
> 

Got it, this makes sense now.

> In order for us to add support I think all we will need to do is define these
> functions under arch/openrisc.
> 
> We can look to cpuinfo_or1k for how in openrisc we can pull cache details from
> the UPR registers in (we can maybe just get the info from the cpuinfo_or1k
> structure):
> 
>    arch/openrisc/kernel/setup.c
> 
> You can read about the background of the cacheinfo work and motivations in the
> original patch series:
> 
>    https://lore.kernel.org/all/1412084912-2767-1-git-send-email-sudeep.holla@arm.com/

Thank you for the link. I'll go through this patch series. I am beginning
to get an idea of how this has been implemented in other architectures as
well.

On 1/25/25 4:23 PM, Stafford Horne wrote:
> Hi Sahil,
> 
> Also please check these comments [0] from Sudeep Holla and Stefan Kristiansson.
> 
>      >> 14/03/17 13:11, Stefan Kristiansson wrote:
>      >>> On Tue, Mar 14, 2017 at 12:08:33PM +0000, Sudeep Holla wrote:
>      >>>> On Tue, Feb 21, 2017 at 7:11 PM, Stafford Horne <shorne@gmail.com> wrote:
>      >>>>> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>      >>>>>
>      >>>>> Motivation for this is to be able to print the way information
>      >>>>> properly in print_cpuinfo(), instead of hardcoding it to one.
>      >>>>>
>      >>>>
>      >>>> Any particular reason not to use generic cacheinfo sysfs infrastructure ?
>      >>>>
>      >>>
>      >>> No reason as far as I can see, the creation of this patch predates the
>      >>> generic cacheinfo sysfs infrastructure.
>      >>>
>      >>> The patch itself doesn't add cache information to cpuinfo though,
>      >>> only corrects a bug in the information that is already there.
>      >>>
>      >>> We should look into exposing the info in the generic cache info sysfs
>      >>> and potentially removing the information from cpuinfo.
> 
> -Stafford
> 
> [0[] https://lkml.org/lkml/2017/3/14/639
> 

Sure. I'll go through the aforementioned patch series and comments.

>> [...]
>> I have set up a fairly basic environment. I built both QEMU and
>> openrisc-linux from the master branch. I used a prebuilt compiler
>> toolchain to build openrisc-linux and busybox, and manually
>> created an initramfs image. I used the default configuration
>> options to build linux.
>>
>> The userspace environment only has utilities that are provided
>> by busybox. Only the following filesystems have been mounted -
>> rootfs, devtmpfs, sys, proc and tmpfs.
>>
>> I tried to understand the workings of some of the scripts in
>> or1k-utils. There were a few things that I didn't understand
>> and I'll need some more time to wrap my head around them. I
>> don't think this should hinder the cacheinfo task though.
>>
>> Is there anything else that I'll need to set up in the environment
>> before progressing?
> 
> I think its a good start.  As long as /sys is available in your environment
> it should be enough for you to test your changes.

Understood.

>> I don't see any cache-related info in /sys. Based on what I have
>> understood, it'll be possible to fetch these details once cacheinfo
>> is supported.
> 
> On my x86 machine I see:
> 
>      $ tree /sys/devices/system/cpu/cpu0/cache/
>      /sys/devices/system/cpu/cpu0/cache/
>      ├── index0
>      │   ├── coherency_line_size
>      │   ├── id
>      │   ├── level
>      │   ├── number_of_sets
>      │   ├── physical_line_partition
>      │   ├── shared_cpu_list
> 
> On or1k I only see (no cache info yet):
> 
>      $ tree /sys/devices/system/cpu/cpu0/
>      /sys/devices/system/cpu/cpu0/
>      |-- of_node -> ../../../../firmware/devicetree/base/cpus/cpu@0
>      |-- subsystem -> ../../../../bus/cpu
>      |-- topology
>      |   |-- core_cpus
>      |   |-- core_cpus_list
>      |   |-- core_id
>      |   |-- core_siblings
>      |   |-- core_siblings_list
>      |   |-- package_cpus
>      |   |-- package_cpus_list
>      |   |-- physical_package_id
>      |   |-- thread_siblings
>      |   `-- thread_siblings_list
>      `-- uevent
> 
> But we do have some cache info available via cpuinfo:
> 
>      $ cat /proc/cpuinfo | head -n16
>      processor               : 0
>      cpu                     : OpenRISC-13
>      revision                : 8
>      frequency               : 20000000
>      dcache size             : 256 bytes
>      dcache block size       : 16 bytes
>      dcache ways             : 1
>      icache size             : 32 bytes
>      icache block size       : 16 bytes
>      icache ways             : 2
>      immu                    : 128 entries, 1 ways
>      dmmu                    : 128 entries, 1 ways
>      bogomips                : 40.00
>      features                : orbis32  orfpx32

Ah yes. I missed this. I see this in my environment as well.

>>>>> At the momoment, I am also thinking of what to work on next for OpenRISC, there is:
>>>>>
>>>>>      - kexec
>>>>>      - jump_label
>>>>>      - kprobes
>>>>>      - perf_events
>>>>>      - ftrace
>>>>
>>>> Is the virtio task [2] also still a part of the roadmap? I can't find that either
>>>> in the TODO list.
>>>
>>> The virtio task is still possible but will be more advanced and may need some
>>> architecture changes to support hypervisors.
>>
>> Got it.
> 
> I am slowly working on kexec support right now.
> 

Understood. Once cacheinfo is implemented, I would like to pick one of the
other tasks as well :)

Thanks,
Sahil

