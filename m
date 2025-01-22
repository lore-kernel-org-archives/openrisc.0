Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479421518B
	for <linux-openrisc@vger.kernel.org>; Wed, 22 Jan 2025 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572166; cv=none; b=PkOTHVXV6D0iRmthjgkBdZxgoTN7ogzdsuOfyydAkIgLoudCWj9MySGuxRhit/6mkOdFGO9PhmP5ij/MY25ijiT22zlAyOfUZ//sawWgbClkFMc6mrWmiwznJ/0QzxMTbJFX/F5KD4c199UxcTZcDZbfKdBN6AW3d1d2LEU+ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572166; c=relaxed/simple;
	bh=Yk3fpjF0boYiX2NUoOaXiAQ/De7Tj5nQSvNFUOqkQN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atirQEF8EvOtZQJpf2ESHC5rTCjZmL0AX2p4dtfHdBcPeXkUObF0s0CI43YVtuGgLHSEgGPIH3Y0vbFFfuBXW/eeKB5ApavZKrupw25OfBRmyWLdu16I/eDGlh+8K3QnKKgFjgBC2/izUTmM5udXGvWaCpARb1a8lDiN1t3k2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBt61Gpn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBt61Gpn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso693295ad.0
        for <linux-openrisc@vger.kernel.org>; Wed, 22 Jan 2025 10:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737572164; x=1738176964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mCEcqlKEPxvF1T68I0uxkxjoL9F9zskj4tXmrzB5QzM=;
        b=PBt61GpnR8OIECyTNV8gX9A0yfczRMce+sCMNw8Q693w59lOMOVzhjOu4fzvIcuYhE
         LnkYhuzfWmZyTuCjY5y4Vx9qhx938ef011BC08H1TkYpGHOQGB3LCee6ISw+drtw/07F
         FlGc18CRgNH50LgDIieawqYaKbCjWNj8pQngRyH1aMqfne9fVq366Y70onW+/BmM473G
         qirYOf8rYJzWyT1Degz0CrVVseNBj7s1J7nLYaoXBF+kgVcE7nDRbDKVjgYfSPpZkbtf
         OR6VEyjxMJmjw4WGRxmrRriDaf49wHRLZnU/MjhNafUPhalTeaufIEMKL+FNmZ1TjvQc
         1XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737572164; x=1738176964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCEcqlKEPxvF1T68I0uxkxjoL9F9zskj4tXmrzB5QzM=;
        b=MiUZKnLtyOx1iJX5f2WInbYVJHB0rvsBPOpA59lrwha2WUWLd7v7K1sseWSdq1iiBl
         M9r3cF6YA9QwFTs5gAcPaJWUS+C4SKAohd17MyClBbvm7FrTJ/HIMvtMWhtdpfdcDuyP
         kecFamlHiWEX8Mee09A5QragsZuVPIUhQr7PMC6arKPx0tzNlq36sT2TgVLOJFkeaqfJ
         V3QuUYiNG2e0kvzP/IMo8ZM8q3e4r0YaDFV2itgAB4J19HXtCj9mZlsoWv+EgFaFNnrl
         JmWj6btjLUrezxB29MqlXohfC0N9BFFUIRJwJYvVOkDNDQdrYLsIhSz5kPOE9sk06Rp5
         b0zA==
X-Gm-Message-State: AOJu0Yzcd0qPgnaoOgZV+4TlcU4WneATcpumjd+mYKrQN11+d4mPm/2I
	PO5e5GIeQJyeUKlem37et5vPr2e/VOugkWJMRLqLHfd3q6DhQC+KMO09MA==
X-Gm-Gg: ASbGncspjdzAPdBFTz6vZjw1Z2dwUjwdmnhjLyremrQVuzRodxtxbpv4s++EctDmXyA
	Pg6GX8UrtcDHi+caawE23fJwYJs1E+4Z+f8N/n/W8Zyiq4cRRnJzDIVeqrZMEkY4DCV41t3sIH0
	1ooQwo9Uaaj2NhqxvownI/o1XFlUaMvl6KmznK3G6prPDUEWEDG2Xt/fHrDgx60MsBbFoZWC6BJ
	7j6HQQ+eN3uQaIf+axGE7h1lvbalEBi+ObdFZI=
X-Google-Smtp-Source: AGHT+IEda430lRdi29svW1p0wlcx0R8WG/gpsfz3XB9vH9WfmKXL46wfp1ScVoCGnzPM3l5KSpo6Uw==
X-Received: by 2002:a17:903:2392:b0:21b:bc95:e8d4 with SMTP id d9443c01a7336-21c355bf8c2mr377740015ad.35.1737572163619;
        Wed, 22 Jan 2025 10:56:03 -0800 (PST)
Received: from [192.168.1.18] ([223.233.82.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac658sm97697845ad.127.2025.01.22.10.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 10:56:03 -0800 (PST)
Message-ID: <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
Date: Thu, 23 Jan 2025 00:25:59 +0530
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
 <Z4SzVtTIuVN7gsX8@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z4SzVtTIuVN7gsX8@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/13/25 12:01 PM, Stafford Horne wrote:
> On Mon, Jan 13, 2025 at 11:42:08AM +0530, Sahil Siddiq wrote:
>> Hi,
>>
>> Thank you for your reply.
>>
>> On 1/12/25 12:58 PM, Stafford Horne wrote:
>>> Hi Sunil,
>>>
>>> +CC List
>>>
>>> yes, the cacheinfo task is still open.  There are many things that are still not
>>> implemented in OpenRISC, you can always just look under the kernel
>>> Documentation/features.
>>>
>>> For example:
>>>
>>>       < shorne@antec ~/work/linux > grep -r -e openrisc.*TODO Documentation/features | column -t
>>>       Documentation/features/vm/huge-vmap/arch-support.txt:                |  openrisc:  |  TODO  |
>>>       Documentation/features/vm/ELF-ASLR/arch-support.txt:                 |  openrisc:  |  TODO  |
>>>       Documentation/features/vm/ioremap_prot/arch-support.txt:             |  openrisc:  |  TODO  |
>>>       Documentation/features/vm/pte_special/arch-support.txt:              |  openrisc:  |  TODO  |
>>>       Documentation/features/perf/kprobes-event/arch-support.txt:          |  openrisc:  |  TODO  |
>>>       ...
>>
>> Got it. I did find this list in the online documentation [1] but I couldn't find
>> the cacheinfo task listed there.
> 
> Right, not all features have config flags that are documented.
> 

Understood. Do you know how one finds these flags? I wasn't able
to find much related to cpu or caches in arch/openrisc/Kconfig [1].
I did find the usage of ARCH_HAS_CPU_CACHE_ALIASING in
include/linux/cacheinfo.h [2]. I am not sure if this is relevant.

>>> How far have you come with OpenRISC so far?  If you haven't already I suggest
>>> working through:
>>>
>>>    - Get a simulator, I use QEMU for most development as it's faster and supports
>>>      more memory than most FPGA.  Final verification can be done on an FPGA.
>>>    - Get a working compiler toolchain.
>>>    - Compile and boot the openrisc kernel.
>>>    - Build a userspace environment, either buildroot, toybox or busybox.
>>>
>>> I have some tools to help with this in or1k-utils [1], also there are prebuilt
>>> environments and docs in the linux kernel [2] and qemu [3].
>>
>> I don't have an environment set up yet. I'll start with the steps above. I'll use
>> QEMU for development. I don't have an FPGA with me currently.

I have set up a fairly basic environment. I built both QEMU and
openrisc-linux from the master branch. I used a prebuilt compiler
toolchain to build openrisc-linux and busybox, and manually
created an initramfs image. I used the default configuration
options to build linux.

The userspace environment only has utilities that are provided
by busybox. Only the following filesystems have been mounted -
rootfs, devtmpfs, sys, proc and tmpfs.

I tried to understand the workings of some of the scripts in
or1k-utils. There were a few things that I didn't understand
and I'll need some more time to wrap my head around them. I
don't think this should hinder the cacheinfo task though.

Is there anything else that I'll need to set up in the environment
before progressing?

I don't see any cache-related info in /sys. Based on what I have
understood, it'll be possible to fetch these details once cacheinfo
is supported.

>>> At the momoment, I am also thinking of what to work on next for OpenRISC, there is:
>>>
>>>     - kexec
>>>     - jump_label
>>>     - kprobes
>>>     - perf_events
>>>     - ftrace
>>
>> Is the virtio task [2] also still a part of the roadmap? I can't find that either
>> in the TODO list.
> 
> The virtio task is still possible but will be more advanced and may need some
> architecture changes to support hypervisors.

Got it.

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/arch/openrisc/Kconfig
[2] https://github.com/torvalds/linux/blob/master/include/linux/cacheinfo.h#L156

