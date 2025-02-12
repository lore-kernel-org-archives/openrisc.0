Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C6214234
	for <linux-openrisc@vger.kernel.org>; Wed, 12 Feb 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374164; cv=none; b=MZF9HEjMCUtcR5BFogqZZtNOfGb/z0gLDxEZwrDz8O+p/v/9l38lvHX0V0oX8P1rrHo2+m+wTgJR8YAta2IBfMX5TtkgR0vkEZuOg0zk1U2vut4b+BLgel2oXXKkKoBgomIM/7+oiUOBxm0som+uQRGzdhpPFlXY5a8BxwQjrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374164; c=relaxed/simple;
	bh=//JVaIMaGK8MBEUu3Aux1bUj728w2d9+QMzQi7PsjgY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oRbyU/nHQ5YPhtnKN4sewDwIQ3kvFgmW2X52lRg/yVW9QWMoEBPUKrmkAnBvGbjp7hG0+X88RY84Eh0MMNO/dO5n9Izb5g9GJhSt7rteO6dSpeFzl3a1U5mFTniyNJ1keXUnKNkeYC428SlXYXh6pwgMxI4uN5PM/0aJ/i3FWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRiIFspP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRiIFspP"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so1146277a91.2
        for <linux-openrisc@vger.kernel.org>; Wed, 12 Feb 2025 07:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374162; x=1739978962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=//JVaIMaGK8MBEUu3Aux1bUj728w2d9+QMzQi7PsjgY=;
        b=DRiIFspP1VdFlfSOxYhnIiCdJKBfRTzHdf/T+KxCijzZZfG48myacGMwvKlJtz14mJ
         Q4B3FmFnawBgJexh0nXsltk6byFozPeHfNDuPBdekeSTm6l77VdRSQHGgfYRXBojF0ny
         1ov4ZWJWblY9cyFRgfajAGCvHAN+i6sqhcp7XCPIEfPw9D6qmDI2u4MGdClfqmx/g0YS
         /Pyc9A7rbiK34QdlQ/FZndTGq/cqcZA4NV2JTQBl0JsoseYRXFNX8r9ezCbi8jaFtaBp
         kE9dTr6YX/RFVpbrg4093txOGfbiV4TdEl17WeFoXLYVaSM6IEUC4q2hq5nQMItqzcuF
         Ul/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374162; x=1739978962;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//JVaIMaGK8MBEUu3Aux1bUj728w2d9+QMzQi7PsjgY=;
        b=fiNSHDdEjDQ32sLYe0zgmzxFUEiQMGVpY7FsBMTJa9ZTXmdgHNeEyQNhY2AkNxnJ65
         iC/z+2PeCra33qXJxy9Hpm0Nqsyf8mwTQmrkcDhk8NS1D2w++rERC+8QZ0MFaeF+LElW
         7fwMpwwGCGshONJM1dZ+6BH9ElcNIA2WdZZ70BLw51QeKP/3rI241rMhnzBkJmjsUsxt
         IVG6aZj/DSVrITusUrAp6QFG8LgU72EkiMLXXo7uRnDAboorW6DspmxwfENtUEazBAUj
         l418FFhqH9D1WDjcieDPKHnAnJ/Yf3MT56xolgbIit40NqhCbTLZ07hJqlPDXFU+3UQ0
         K3yQ==
X-Gm-Message-State: AOJu0YzphkV1Suvdv6mIlx/yYP90/hOwOFGrlu9YCJ8Qua22ygE3zqCt
	YcguTQaJfDgsq2iQFJSb7dlQenH7JjQwpHMWFbBpwykD70NHoeIiyDiOgg==
X-Gm-Gg: ASbGncvrU7CTt3gmPeC689g0IzFwqqQm5oeejhuDQXlrn5KIsMXS/BAMb26LQQoIY6a
	kbgCpX/mgnov9re+OWyczwCqi0CQ3PMH3Fwspqi29ESIB+4fQVQW8DwO2EG0wTF0iNFT+1+Vryr
	Z5C+M8rGdC9yGALlIPePzyQzPgUstxd+OynILq9rzNYhCLkHfSirPrcbu9u2yjxe5cH2/XWhz+4
	ShsWVXrZhzf7uxHr01YUJbvNUt/pnUXXyTNK+xVnKu9RLHjJVkGogA7/7Wm
X-Google-Smtp-Source: AGHT+IGyJNHbYAChwYEtqD2w7wess2XODmIF9iNOJtrJmjSItulzK/ITnHo/EWjvymiXGW+OwQfIDA==
X-Received: by 2002:a05:6a00:841:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-7322c371355mr5043903b3a.5.1739374161941;
        Wed, 12 Feb 2025 07:29:21 -0800 (PST)
Received: from [192.168.1.18] ([223.233.87.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-731737c81cesm3992961b3a.156.2025.02.12.07.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:29:21 -0800 (PST)
Message-ID: <d789bca7-0266-44e1-bc36-966a70adcf26@gmail.com>
Date: Wed, 12 Feb 2025 20:59:17 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil Siddiq <icegambit91@gmail.com>
Subject: Queries regarding OpenRISC CPU cache
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec> <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
 <Z4SzVtTIuVN7gsX8@antec> <1052b18b-7524-49b4-8ac2-22031bf90d4b@gmail.com>
 <Z5STI5WUqCXPwcNF@antec> <ae00d43a-f8bb-4919-8ee1-079a30bc6f42@gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <ae00d43a-f8bb-4919-8ee1-079a30bc6f42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have started working on implementing cacheinfo support for OpenRISC, and
I have got a few queries.

Q1.
Does OpenRISC support multilevel cache hierarchy? I couldn't find anything
in the architecture manual [1] mentioning the possibility of a multilevel
cache hierarchy. I wasn't able to find anything in the verilog implementation
either [2].

Q2.
In /sys/devices/system/cpu/cpuX/cache, each indexY directory corresponds
to a CPU cache. According to the OpenRISC 1000 Architecture specification [1],
it is possible to have a unified cache. In such a case, registers controlling
the instruction and data cache represent the same thing (section 9.1 of the
manual).

Consequently, should there be only one index (i.e. index0), or should there
be 2 index directories (index0 and index1) with identical content? If aunified
cache is used, will the DCP and ICP bits both be set in the UPR register?

Q3.
Cache-related arithmetic performed in arch/openrisc/kernel/setup.c:setup_cpuinfo() [3]
cannot be avoided. But we can expose this info in sysfs instead of cpuinfo as
specified in this mail [4]. So, I was thinking of moving these calculations to
arch/openrisc/kernel/cacheinfo.c in init_cache_level().

What are your thoughts on this?

Another thing I noticed in the current implementation is that these calculations
are performed for icache and dcache before using the UPR register to check if
they even exist. Should these calculations instead be performed after determining
that they exist?

Thanks,
Sahil

[1] https://openrisc.io/or1k.html
[2] https://github.com/openrisc/mor1kx
[3] https://github.com/openrisc/linux/blob/for-next/arch/openrisc/kernel/setup.c#L155
[4] https://lkml.org/lkml/2017/3/14/620
