Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667521C84D7
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299843; cv=none; b=aEKCqJ85Ya1EsOFviFnURjJh/Q8dg6P2tOeCK4G4OXkqFuUlZ2iQZaFbaKCdpOx/19teJJJZi+xpca30cm6dshnsYv+nXkjNlXfKzQBKS1TPDSs84ivbPtZhETzVpSJfNPTGppR4TTfNLZTcyYubDp0Z0yQNc3iK8pK7/ogXXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299843; c=relaxed/simple;
	bh=39NtxAeqpXvhawaLycQSgS8a7QXmm9U/xmb9EyW+PGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jzjYX4H/l+RshRxUhwSeJtdEhegdAf/9KhYGdtddJyy2Ya12BEvMoeXF8ujHwGZnEZWaRW7RNhJPn2MxK9mml2XJA818nsTGWDG0mGBdRMXiUBYN213y1ici0lwyTLqbq6QHBL2TvjHoblnf8bLRamCkf8ht7m9PV1UH9mCvTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex58O3iI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex58O3iI"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso50801221fa.0
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 02:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768299840; x=1768904640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=Ex58O3iIS1XEeiLViwNaB0n2KT+9nbqe/9oOvP7F9FlRjiY8Kiwofy7hH3rmq1AWUO
         PCtwRTdSSvaDFz58YiVE+Fnmp5yHnq4WsplTYXnp1mSV8EhY85PALURd5FzrzrQu28f3
         pgsQJra21VDZxuCwf+pWefaLIGihwWT9pTRQf27qABTZBq4BxtKv9Qnh5Zwc0OpITXyo
         3csUNSEKdMuVYVrf9WhJnBMlSXOs5HkrPj9SQTXgI6FVtFrbiUIz9dha8QiCJIX8z1Aw
         //q61HTLUaiA3F6vNZjR2BNmR4pY02bYyru6od4i1MQGhlA8aaA8o8120gKl33AKXtOV
         ArBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299840; x=1768904640;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=mq3R65d6pBMeiji2hfs/HC88C4U+v9US8mKprv2w6rvTtYD5OynPs83G9x0H3kEWbM
         Ge8NDbnNEzoUAP9MYnDHXm0CHI22Jx4HwMrJds0KtnqkItSXQgu/xDwOgLY2iVLkfy+j
         pVKg+3qwtQvTUzxNTXWuWk/PdDReEovsnVTOg730R6YaKIENKN0EQW6spQOxnEg+94OZ
         LM29ue7cT32htABGYu+vyls6h3iuBe9TwmAiQa6EUDFDAH4XzZW8fdcI8/qcSOGJ1tzN
         +85bACIdo9Np5u49p0HVALDo2zFdx+tDhI7UP75BEGraSIH0Uy2mFP+UlQUwpj7MdaZy
         AAwg==
X-Forwarded-Encrypted: i=1; AJvYcCX+lgsJoyN25wCgtM5J+vzByLQSYfA5+Uxyo+nDZPfNAJ256LglBawUkiONSIVeSW8uFdvCKbjoTWJsotZJlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2A0A3tjc4p8u3CdV3qbH1bahQYfTdpnUFg/1t0yXqiro0SPvP
	55ddUopQ+S4Upn1MjecLfHcRkyc3HYO21rcYXBvo/qPxQvCOH60qc8qA
X-Gm-Gg: AY/fxX6FcJnlPmi0WrsIO4y/p/dIBjfs3mfT0V6rW1R1fs1trnv2Kdu1IaVIzIU7jSq
	0lJxrOJYxwKFmeRu2nWQk5a6X9dvl12EQkLsRGUbAPYPheX7jaipC66cO+zoxGT7AYoqi27sXWQ
	iOfxSFklaCT31NnizQG14ShmszmYWCOzKkpmiYXHTpRSN4wjUAqPoHTDkjSEd7CVw/XojdQ9t5l
	XKOIRwWGmctcI8MuqTBTVJ2OPHp5jRluudaWIXlSxOL9c1AYJCTKkitXvSHETasq8075RxXCami
	95glvW4tQkIaXOtTKiWUuewLaxoepXHot8D4Bu68XWRgGFG2fEXyWPwHEh3H4PmuSFhaZ4vKUHw
	1SVe/EChgAOJ4n0ibWym8yCujnlVmnbvIGL4NQE33j+Voa/EJR9TNKhrxveVu0w8s0MIk84RJ6g
	F8eRPaNoIiX1lzyfyvzhxV0N7LNThxX7HRn4ivopRYxB5+YjIJ6qQ41nfZAQ==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle
