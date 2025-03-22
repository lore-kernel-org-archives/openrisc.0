Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108701922E7;
	Sat, 22 Mar 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742670254; cv=none; b=BZ4rGz1mK63HNXJWPNfpWXBZgeWfO4zdMSf35RNhHSz/b5w6XX64zd+GhfDODXJY9GRhlnoPV9uN2xw8PzOJycUrfvT57yqyKRPTVTvPKdPyX0D9AwRZAfBOJ187eq876Da/F6WXU+jsll21jDDzdmYSioHd3Pe3Xa+/nQRer6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742670254; c=relaxed/simple;
	bh=akUtIh4fJ/NTloDbJE5X/4fCQR0gEfzJhOxmWP0OaG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSJcIKToGV/N+wMEEyzJaxnk1ZyWVjCp8M1mK1fDc4dbC+oeH4JcqZmdgA5tYzdAfHfAL1Ur2MGsViIMzwf2ottQ5IinhpdXHOanhvpzX3A8CQYMuB7PuWaUD73SXaeXrf2jyOwwNbOWaglvsr1ZECGojSbtJwuyWPvb7Nh0EJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJQExcOf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJQExcOf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240b4de12bso37052785ad.2;
        Sat, 22 Mar 2025 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742670252; x=1743275052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hjfS2J9/6jaC+LhxfaVAJBnn4qRMz60NNh1Gzm5/iZ8=;
        b=RJQExcOfWI8tTRPCOhhWi7QYmePILO/ZEMf+RHo9dTYvsv3t+djgfDDfr7oSxNg56U
         9n6zWcxvcGsHmSzdqSBRc2ELTtSAN0ZVHTkV2N4d0Oju+/P5coN0AlAo9Yi/kiuNHfEG
         qIYF3/yHPuazYQp0YzAsaNR7c1dQHsmb+nJ4LIn/tfbEtedKdGoJoPbghSbPYK+lPNAr
         YRCOzgh7U2btHRWnnGQW3UozFbINlWKlU+ufb06SJeM+WEJDInW6g639r6iQ6ogphDKp
         0t7u63kFQy1dLHWl9rAJJdC601aGZt2CdgdnQLC2QlqOfJ9mrL9VtzjxTOd0vKV0zZlL
         Bmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742670252; x=1743275052;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjfS2J9/6jaC+LhxfaVAJBnn4qRMz60NNh1Gzm5/iZ8=;
        b=e/VZauD4+xiwOxMV8KP9ULxJgJEtbvSNkUAT7D28IGGy9v94bSs9bOyt7KWJLzDyAP
         PQ2Rpdpfg3iJFOZZK/biv7MBi+WawrZk0fzv01POdhN+mE0y1+CpI1SuKSYDRtxpsfq3
         00WdUM4D3ksTTc08eQdr/0J2XypxdTsLBKoi3Tb+a1Kjcih/V3p2R7ySFcwxWFEr93wk
         38G4A5eng6wSBqzZ5oKz/iCgjZODQRqSnUKS+s9Se/94jzLXjFpjrqCp+smy+yQySCPL
         4SmyKXWdF7L8IMVppLoWl21gItyvd40ab7pfxSRGYugoY/QM+cqgyoxUFJK4g/TQ9BYa
         Tvsw==
X-Forwarded-Encrypted: i=1; AJvYcCVui1LJFSeB/Xpt2SPHHVRkxdDwEpPnmH3MfnCGRKodeUcylaJ1F+crwbef7i3m7gAb+0R2qAlrz9hwrSDZQmA=@vger.kernel.org, AJvYcCWbeejxL0S3I+i4mIldYLOHZaOnP9nXA3cnVdtkG/QmeUaytCsdAbezm6Enp3bx1K5Le3rjbGuRuuFnIhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhbWWMRpiZcOaad5w4LloJ30c5TBXhsG90d9tmlUf1Q8oJWC3
	Mz2VbOWnqacDwjQnEq8CGQ9CfHYa8BTeivjyhc3dy2BSCYdshSYZX8K7RQ==
X-Gm-Gg: ASbGncu/ifp46zkuS/K9YgpDKlIkARvZYEmYwv9YNNxtCsIueuv4UjIezykRpEq5fNY
	cTBYFdrBtruVeElrSyCA3RN8MTE0OoFwziCNK7g0vtITdKluYaDHeIeNKp8Ks0KtFN+7Skl9vfn
	21UU+8qdezTNiK6DN3JE4NSNmODPHq7QiuoAkpsx6KmO2ePEn2cYcWVzV8FRZqEE/IcYh9TU/nd
	xS52g4SThN8Oy0v/wrZ8Bu99fSIG4zCIhInitLunvqtym4fFLfq+PdXsK5xNbn9/ObJSsY9FZCB
	NgOUBe2kHQ2Sjv1MzVP+RtfNHyuk3tzC3HSwlxcUT1UnT3kV0mcr9dh+8rI35kceD9PY5RbAWiz
	pKoWZ5XsWbvPj
X-Google-Smtp-Source: AGHT+IGNBne868F6ZrgKdD9z9yU5M6G0K2giARvuwBrovY/nxaUuPjc7rgwwLnI7xaHp1DDNmFNJuw==
X-Received: by 2002:a17:902:cec4:b0:220:c143:90a0 with SMTP id d9443c01a7336-22780d96ac7mr126763515ad.24.1742670252016;
        Sat, 22 Mar 2025 12:04:12 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b? ([2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f443asm38859295ad.228.2025.03.22.12.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 12:04:11 -0700 (PDT)
Message-ID: <1838f997-f3ec-4df2-bee2-20e1dbe35b3d@gmail.com>
Date: Sun, 23 Mar 2025 00:34:08 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
To: Stafford Horne <shorne@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sahil Siddiq <sahilcdq@proton.me>
References: <20250315203937.77017-1-sahilcdq@proton.me>
 <Z9Z2sjWQHKgGJyGo@antec>
 <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
 <Z9gOwYl6kmoPY9-C@antec> <d54849db-956b-4c1a-ab93-4705394af637@gmail.com>
 <Z9kkE3uQru_VxLqA@antec> <10b01724-d47f-4f0f-87ea-2793e67b18b9@gmail.com>
 <Z97lUpoTXVccaCeN@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 xsDNBGcgaYEBDADpKUSKbchLCMdCuZGkuF50/7BiraKc8Ch+mk4T+2+E2/6qXAkalvCkFoqx
 3/sa35rconZAFzB/r19e7i3UajIQjATvENrGxqe/IFqcJxo2Jr1HQBwCrsmlQoUCilSC6nDi
 ejcEIAFytJORDkCcZwLXPjdf5/4pbqVAW5823LB5j5F0TqHAnGY1RhS2V1eBPdRqjAA3xecT
 zTmLHlkqAXgM2DOot1KbycedZSieCwEykTXMaLC0/3Gyo2Cp1WTWOIyD0hsXpLyFioV4FaX2
 Lm+z45Zc4PoNXeC6+l4PdDxixs+saAbadknP+9omwlb+PkMd3esq2wkowTwTJVJK8FCCNTo5
 2OArA/ddxcyXY25JHN7vzGooFNW6Bb9YV+lbX6y95ytE3KcAmid73tQrcjlebIpgNAvOMyyZ
 BgQJY0HSu3DGNZuKtbNM3iTl82TFj7MVgkEffgF83N6XyBqDztIz2lN47/q5wyRi3jda9NDt
 geI+Nv145HjulO7bI3NT048AEQEAAc0kU2FoaWwgU2lkZGlxIDxpY2VnYW1iaXQ5MUBnbWFp
 bC5jb20+wsENBBMBCAA3FiEERtYfQYWFu+uAZjYrrzGlXdb6f1cFAmcgaYEFCQWjmoACGwME
 CwkIBwUVCAkKCwUWAgMBAAAKCRCvMaVd1vp/V/nnC/9KnNIr4a3JW3E/snxv1+XIyUmHBDLn
 PKBmLDYxO9RJe1xKo/sNmLEno4c8G1F/y12TLV086cpBYGKkE8mPMBABqxuiPG8srwoKc2HW
 bvoC2Zfeu/WeQ0YqeI9ZEwRhsDGQZ7vc8PnKnEUaPZn6iWW4GeX7dXWeGNrK0wU2B04l2d+M
 FIKaoPHk8w5Ff++QNcn0YRkm//nYlukHUrMxhNcuc18jaLLftOh7BH/4EbKtTN75KAFePQBi
 I2CbuC41fchTt12QrPB3yz1GKfudsEMLFHBNeComJNnuolPOq0YSyuKdRO8Jubn5ZqWQeTwj
 XbG7wTonDc8xe46irOhz36VcjsjSY+PYhVZSeDWeDUZgpaJkBjQDDodIN2eoMwVEyUByos9H
 mKrqrpBMmylOspAZzqjb5FtOqM0BCxQINdKKiMwRelSb6pHYCrbS0XzpwDUEpp7RWCbHgg+6
 Ot72kQCEFxj2LzX9VxF24GGQy9inlUfN51IV04klSibtBuuz/NbOwM0EZyBpgQEMAJelVX4k
 CtCxD4Ji3FQ8LZs22z7VoUvqIb7Gj2lNvhPeijlqqBkSMIgnSCLxlH4ahqKnEV58IrfVriV0
 92zb94Az2nl0r+bZYfvev1qCcVIYxk+pYYcRl5qPXX8XGalrkcBBWmkgTSwzNK9rV4850iVI
 hsJNel49qen9JwiFYMSKa2MYgdYSbeuuwXwUp0ZHeVFc5RnPK2wxws1xcnsdb9hRXs2UeTEE
 0klG3HuXqJ96DzKrCieKHLjs330h+16gDWAFZSEoT7Mh3HFGI2dscVuBstQNgnwUMnsJv8jx
 c005CfLCjCBnJEhMd2/QFuLwCZv4IdoghKwYw18e61UbX2bFovo9dduD527pD4sFqi7U7ofv
 aO3yf+ulL6jiKypGvnbiBP3KY3aKxx6pHHH3aDc9eOqCUgrtS3+xt1du4+qxrYqEnrywFoJy
 5zqSzbnTTjFpdTbY5SS52fIOktLlAKzEg6V9hkg2r08hC3/L4NVj6I4tsGZlqb2neRlHFmCr
 bQARAQABwsD8BBgBCAAmFiEERtYfQYWFu+uAZjYrrzGlXdb6f1cFAmcgaYIFCQWjmoACGwwA
 CgkQrzGlXdb6f1fDIgwAmpB7eL3XNSx3F+gbmksOPMqCU5rEswRedjEt6tBzFTXhdNFfhZTb
 vCddUNePZnzddgxAnDBcTqI1jx6Go6Hkti/mxJqXSczMYBsImD/lEm47axsADvpnNaEM+tmu
 m/cMKfpILUpy2Ey7CKXUA1vpzYeUD29EQWi0fxM0arplrVt/uzUdFRFQRn2hCqeDLBLONX1F
 Adq+re6M0dhKl4a2+erzZRIXh3vIGiDmpJEGrajrhqEnMXFp6toSiMGian94m8H3NT6rB64E
 JmdHgyjXADFbn2G5Mb6Pwa8KnnK1kYcZ+Pwu9LfMXfgI01Sh/k01hjUVmnpYep4nHUfwXA8r
 kn6WekD80DYbAfKyFAXQCO/nclZ82RNmJbDRi3AeMFrxKi6KgdGCp1Izhj9USaMOVqcuV2p0
 Rsoq+sFqWOKaHWnQHCM9RkynQVqrgUaSawEbGlCP1KIhVmjfjVsmsCaKkUb9T6VeO+ZNe+Pn
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z97lUpoTXVccaCeN@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/22/25 9:59 PM, Stafford Horne wrote:
> On Sat, Mar 22, 2025 at 07:21:18PM +0530, Sahil Siddiq wrote:
>> On 3/18/25 1:13 PM, Stafford Horne wrote:
>>> On Tue, Mar 18, 2025 at 12:06:30AM +0530, Sahil Siddiq wrote:
>>>> On 3/17/25 1:55 PM, Geert Uytterhoeven wrote:
>>>>> On Sun, 16 Mar 2025 at 07:59, Stafford Horne <shorne@gmail.com> wrote:
>>>>> [...]
>>>>>> @@ -176,8 +177,11 @@ void __init paging_init(void)
>>>>>>     	barrier();
>>>>>>     	/* Invalidate instruction caches after code modification */
>>>>>> -	mtspr(SPR_ICBIR, 0x900);
>>>>>> -	mtspr(SPR_ICBIR, 0xa00);
>>>>>> +	upr = mfspr(SPR_UPR);
>>>>>> +	if (upr & SPR_UPR_UP & SPR_UPR_ICP) {
>>>>>> +		mtspr(SPR_ICBIR, 0x900);
>>>>>> +		mtspr(SPR_ICBIR, 0xa00);
>>>>>> +	}
>>>>> Here we could use new utilities such as local_icache_range_inv(0x900,
>>>>> L1_CACHE_BYTES);
>>>>>
>>>>> Or something like local_icache_block_inv(0x900).  This only needs to flush a
>>>>> single block as the code it is invalidating is just 2 instructions 8 bytes:
>>>>>
>>>>>        .org 0x900
>>>>> 	l.j     boot_dtlb_miss_handler
>>>>> 	 l.nop
>>>>>
>>>>>        .org 0xa00
>>>>> 	l.j     boot_itlb_miss_handler
>>>>> 	 l.nop
>>>>
>>>> Given that there'll be generic local_(i|d)cache_range_inv(start, stop) utility
>>>> functions, would it make sense to simply have a macro defined as:
>>>>
>>>> #define local_icache_block_inv(addr) local_icache_range_inv(start, L1_CACHE_BYTES)
>>>>
>>>> instead of having a separate function for invalidating a single cache line? This would
>>>> still use cache_loop() under the hood. The alternative would be to use
>>>> local_icache_range_inv(start, L1_CACHE_BYTES) directly but using the macro might be
>>>> more readable.
>>>
>>> Yes, I think a macro would be fine.  Should we use cache_desc.block_size or
>>> L1_CACHE_BYTES?  It doesn't make much difference as L1_CACHE_BYTES is defined as
>>> 16 bytes which is the minimum block size and using that will always invalidate a
>>> whole block.  It would be good to have a comment explaining why using
>>> L1_CACHE_BYTES is enough.
>>>
>>
>> While working on the patch's v3, I realized I am a bit unclear here. Is the ".org"
>> macro used to set the address at which the instructions are stored in memory? If so,
>> the first two instructions should occupy the memory area 0x900 through 0x907, right?
>> Similarly, the next two instructions will occupy 0xa00-0xa07.
>>
>> Since the two instructions are 256 bytes apart, they shouldn't be cached in the same
>> cache line, right? Maybe one cache line will have 16 bytes starting from 0x900 while
>> another cache line will have 16 bytes starting from 0xa00.
> 
> Yes, to invalidate the cache we will need to do:
> 
> 	local_icache_block_inv(0x900);
> 	local_icache_block_inv(0xa00);
> 
> This will then compile down to the pretty much same as, (but with checks to
> validate the caches exist first):
> 
> 	mtspr(0x900);
> 	mtspr(0xa00);

Ok, this makes sense. I misunderstood the comments in the previous email.

>> If the above is true, I think it'll be better to simply call mtspr() for each address
>> individually.
> 
> Thats right, but I figured the local_icache_block_inv function/macro would be
> more useful other than just this block.
> 

Right, I'll replace this with a macro.

Thanks,
Sahil
