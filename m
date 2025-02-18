Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6921B9F6
	for <linux-openrisc@vger.kernel.org>; Tue, 18 Feb 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907504; cv=none; b=gsyuAliG7KafP8ZDC4EEWULB9jcWm5on3/lMmnUi+9q5C/vqWgWujcA7Xk4IndNtS5KxpUYtkQIu/D5Mi2oyK/UXW4Chyh0heHGvfAT11GndyA9Aur6xzTBDtuwitVyZUnxmozNEckMZxLmWLF7rQ8VfjrfH3xt1TAXQ4l5vYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907504; c=relaxed/simple;
	bh=3jikLlntcNc2kC3I0SNXSrgZ4VwDKJT2mGrxtvuopZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L0s4w3LjW9z51qk/ERy2xQKsDYugzs4p3dDYaVmybPZ/zBNIqF4p0YSII1hmWQvE/O2jJxJeDfUPgINWSe0b5kcjlvNK6yOyvaK9FEeJooWqJYknDFIfyBWukL7xoohZYcn4psyG51rQ88yWU15FUAM0mIfllllt4KXg87Zc7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJTEh9xm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJTEh9xm"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8cf98bbso119783805ad.1
        for <linux-openrisc@vger.kernel.org>; Tue, 18 Feb 2025 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907502; x=1740512302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+4trjz0NbWOm+KhCobvNX1N8QVXkCWujPPDfu/ya560=;
        b=PJTEh9xmI1uJojUnKHfb08DA0ZLQcwcOZx2kiX1mzmD++VuIOWz0HzMAYFZOKo573G
         ZKc5N4dQ29+HFCsup695icnW9jExe6rE5Xiri8dCUO5oEPdUjmrJcLl1iJfAPufPRWtG
         GV2W+UDy5rfvN7YjhlxROCCY37NFakMzHSk0rNJS8qP/A/ujwttO2Lo+bfKxBGTjaN0V
         2OzRfaxob0yyQL0cRQNgS1HHMQx9+FhLlgzX/RcU0W4X9RZ48Y8mBXFE9FnL+4jewVxN
         11bcccfWm7FItcIoaOcToFCzsriW5WPnIo7k6VWPyGR/XtPFxBDE9QIsoZ1KPSrJiX8F
         RdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907502; x=1740512302;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4trjz0NbWOm+KhCobvNX1N8QVXkCWujPPDfu/ya560=;
        b=qknEr9PIL98dMARxWW6bB/loH1Xn6NYjYUnNbDZiU/CFhzNXI95UQGBwsTGHBqRA9i
         y5HrpAqH78YWKu982iVfOWXG2GQ+32lUwnOIjgwXaPSe7wwUicjsbVXhS9fyT38P41Js
         EYuOjQS12PZc9G94KAUwlPGsD0tWQYi+CN3WVXEFwmXNi0/mp7lC5rxUBERbkPLcTRYI
         tZhIEhTXAUL5PsLr3oD5kafR0REXJKWRG5n+37x2QP1gQNez/pbnVZkXobDoTqTr+38Z
         DZszcRVPEE5L2iOy1hImdP/P0HnfR3DhP2k5yqXlc+z6hE9Acbb51GEVdlcWjpxjGe2s
         C64Q==
X-Gm-Message-State: AOJu0YzzCCI3nQixf/ZvVRY65GqZPHByrMdgBpN4B9hi56v4/j4NAtui
	g29jVJBy/swEK8CkUSV8DHIX7ODB52WkV0gPYfg0PO6GABjZpqkfMy2b0w==
X-Gm-Gg: ASbGncswAOLWx0fvXFmZJ9w2ZrROQnLCaBhUJjHXkXscxCT+EL1UXPb9XakOoi/kYYr
	4Kn0YDo/r71KeraPQX3TZDSJoXpYcOhxst/oLkFa2r+Ww1iILqRUjOYD0tl+uv1LlLXXJKPRV58
	nta9VgZvNVyuYH1KYNNs0s4l4y8b6HShDzIc0aPBPiZOhXgxWNiPI4ppEdi6ovqal0VzLTvBAow
	+TiE/kKwjk4sMDJUdkEBHXlja/IURbZ5JSuIWCGrYi+J6IS++t07XTc2z2MkbEoqAL+PQLnDur1
	yuIwrhsE2PnLdR4LZAOl2u2Nb/pGnIJX8hWc/b/LdrGwKowDw8qBTkT0
X-Google-Smtp-Source: AGHT+IGyt+kMlykSA/xQNvC+hJzFtYtb1mRSFCF4M8qVnXrMCfl6TN6ZTCb7GsJe/NlXZKvGwFEaiQ==
X-Received: by 2002:a05:6a00:99a:b0:730:888a:251d with SMTP id d2e1a72fcca58-7326190c58emr24560078b3a.20.1739907502166;
        Tue, 18 Feb 2025 11:38:22 -0800 (PST)
Received: from ?IPV6:2401:4900:1c43:14e:b774:f226:fbad:d915? ([2401:4900:1c43:14e:b774:f226:fbad:d915])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm6153580b3a.94.2025.02.18.11.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:38:21 -0800 (PST)
Message-ID: <b6ba7708-6c4d-41df-b057-9f92b4e938f9@gmail.com>
Date: Wed, 19 Feb 2025 01:08:18 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Queries regarding OpenRISC CPU cache
From: Sahil Siddiq <icegambit91@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec> <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
 <Z4SzVtTIuVN7gsX8@antec> <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
 <Z5STI5WUqCXPwcNF@antec> <ae00d43a-f8bb-4919-8ee1-079a30bc6f42@gmail.com>
 <d789bca7-0266-44e1-bc36-966a70adcf26@gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <d789bca7-0266-44e1-bc36-966a70adcf26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2/12/25 8:59 PM, Sahil Siddiq wrote:
> Hi,
> 
> I have started working on implementing cacheinfo support for OpenRISC, and
> I have got a few queries.
> 
> Q1.
> Does OpenRISC support multilevel cache hierarchy? I couldn't find anything
> in the architecture manual [1] mentioning the possibility of a multilevel
> cache hierarchy. I wasn't able to find anything in the verilog implementation
> either [2].
> 
> Q2.
> In /sys/devices/system/cpu/cpuX/cache, each indexY directory corresponds
> to a CPU cache. According to the OpenRISC 1000 Architecture specification [1],
> it is possible to have a unified cache. In such a case, registers controlling
> the instruction and data cache represent the same thing (section 9.1 of the
> manual).
> 
> Consequently, should there be only one index (i.e. index0), or should there
> be 2 index directories (index0 and index1) with identical content? If aunified
> cache is used, will the DCP and ICP bits both be set in the UPR register?
> 
> Q3.
> Cache-related arithmetic performed in arch/openrisc/kernel/setup.c:setup_cpuinfo() [3]
> cannot be avoided. But we can expose this info in sysfs instead of cpuinfo as
> specified in this mail [4]. So, I was thinking of moving these calculations to
> arch/openrisc/kernel/cacheinfo.c in init_cache_level().
> 
> What are your thoughts on this?
> 
> Another thing I noticed in the current implementation is that these calculations
> are performed for icache and dcache before using the UPR register to check if
> they even exist. Should these calculations instead be performed after determining
> that they exist?
> [...]

Building on my previous mail, I noticed another thing:

On 1/25/25 1:00 PM, Stafford Horne wrote:
> On my x86 machine I see:
> 
>      $ tree /sys/devices/system/cpu/cpu0/cache/
>      /sys/devices/system/cpu/cpu0/cache/
>      ├── index0
>      │   ├── coherency_line_size
>      │   ├── id
>      │   ├── level
>      │   ├── number_of_sets
>      │   ├── physical_line_partition
>      │   ├── shared_cpu_list
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
> 

While I can see icache and dcache info in /proc/cpuinfo, dmesg reports
that the caches have been disabled.

OF: reserved mem: Reserved memory: No reserved-memory node in the DT
CPU: OpenRISC-13 (revision 8) @20 MHz
-- dcache disabled
-- icache disabled
-- dmmu:  128 entries, 1 way(s)
-- immu:  128 entries, 1 way(s)
-- additional features:
-- power management
-- PIC
-- timer

This is because the value of upr is 0x719 and the value of SPR_UPR_DCP is
0x2. ANDing both values gives 0 which, according to the arch manual [1], means
there's no dcache. The same thing applies to icache.

Thanks,
Sahil

[1] https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf (Section 16.3)
