Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476D134BD;
	Sat, 29 Mar 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743275614; cv=none; b=ZqV5+AAj5tipPNqbaPDoE/+VlpuQ8sMiuHoYi/zn83v8JUntdKAiR0Vzu95P1vc1h0Skijp+JMFtvXmvxFQ01iN6dAkEzsTZK4fcDJa/wIdEbe0h8NDvxMpLTABhHNmrk2DVjbNAMzQqH+5FqwGwKEkvped/DnjrmXTI5tReWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743275614; c=relaxed/simple;
	bh=wGg8na7dTv8XnD4kZJKan/VRjynT7s83ckCx/R1Pts8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQqXRVJHYh/FFb9pL312ofNnnL56S/6tI5QY5T2wglK1ntj4aiIbnn4q6G4K9Ij2UP21DyWle7ag8/tDxWCHbVJNZV+YDfn03yV7NZ8vghB3KLpiyXKa3TDOnb01OXMWzEypKjDsXRHdtKR3tLDAsgA5LmGOaAqhcOD1rJTNif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhUNRS/u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhUNRS/u"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so30040725ad.3;
        Sat, 29 Mar 2025 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743275612; x=1743880412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nJcGnPcqe3iN7N1I+Go0o0oWDdL9OLHD+1UStBOXd2c=;
        b=NhUNRS/u2lcHKhJqGLNX/EsfPYMZ4N5lntijCRkFRJl+MPQLdMsTLhSIxkfHDComnH
         965l9h6emjGUUBPA50SnDsT0wr4GDnVWxZORP0frDDMcDa/IGfgi2UFyNIBHC4IOtVQe
         ewSes1shsw4HuhTX4jGGQYSj8cf70+55D26trvtEdu0Ga1+5vi/2vlkrQZm5MoRuyZy8
         +Ai/HCeZeScBq4gIveQWGiIhCz5oTc45frzL/oKwTMEWSGhkaY8s/mvPFO6GNhchRV5s
         SlOly8T2JbdRWcbWXB1dilohyTUaRyAt8L8MR2yY2o8hMLhuj7OlY9GuHaTBtRab0bxD
         2Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743275612; x=1743880412;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJcGnPcqe3iN7N1I+Go0o0oWDdL9OLHD+1UStBOXd2c=;
        b=eSE3GBl/wPyaMjlS978WxnrUgd7wgy4V4hhR+GxuT/jvVvHfQerOSVfR6MRUdvCL4u
         UAyyy6skZWBR1edvfZV5iYtbQIQT/D2gj2cO4+/gJg6BgRCtHUIA7FFbs8Mv+lUNQZQm
         0OotkoPh1H2VGnZlalCt71jvqVlvbosC5ir/hAq3pyM11+TRGEj1Tq7d41uP9RKm8mUo
         2Kt4y/5rD0Yb+poQXN4y9cuCVPj+1q3AJQnzUW/g9A+HNRZnbBhCbbfhD0KhO7ZoRUic
         WdV/9HikxpxQnWyRutKvOiDiuIjk8P//mWsqc3fy+SyvI+yy7GJl96miLcTjHjli0BD0
         F2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk/QsX5W3vQXejcLWL4hzqHtCXY7XVfrM7W8p/kL9o4Me3uwQks+t9fsQuglpApS7XpZI+PLXnjSycqNg=@vger.kernel.org, AJvYcCV8uO0f2kVfr5bbQA7fwOx54hfHO/mtpfVFszz6/CaU9Zr34qE3j/Y1UiqWoBAihbQxehZMnuyBJJTxwpHPZp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eeV8hOa29Zzg1gaLVCNrDaPWrrT/9V/3GMd8jhhl6eyRoN1q
	kYOnjUteCYMz8E1aw4/UK5zV08oZ76vECsAigDXDWaOFV9RHxNjp
X-Gm-Gg: ASbGnctlZilDZKsq57YfHlEy06WeNsrtg72YDQXRPWsyLYGFHV3aWYk2Rhnih99KKFf
	MU0XjrBaCLdHKAmAB4JODP2F9Svi/khHrnythciD+O3TnzO/xQfWYOjAFH39aBmgWSEmvdalxM3
	M9js7pEetxaH2ceu1lUwF3IKJp9bfax/iaHReywisL3hzrqUhMBiW0uI+swCIftPQXX4W++L/I5
	4LkHnZzwibKREplPJKpZUtQPX6HKFMG7dqyqNPF0/UlgH+hVNWzXv9Vd47AyBfPsVLt0Occzfdw
	ep5k27KI4UUVcQSvW0bX1EjgGyhDqRocRyOvLi4HL/7HKAAuHLcEEsS05fNNS1NSI21Pv88A8q+
	8dBFNsLM=
X-Google-Smtp-Source: AGHT+IExhS+UYM2t2Om26UAFOuIMtcC5jON9sZ2nZRoKA7uc+rWEkPuHhPHZdR3ob/+tcTS4xwYZ5Q==
X-Received: by 2002:a05:6a00:148a:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-7398033ad19mr4613230b3a.2.1743275612277;
        Sat, 29 Mar 2025 12:13:32 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6? ([2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710d796esm3948013b3a.168.2025.03.29.12.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 12:13:31 -0700 (PDT)
Message-ID: <564042d9-0645-4a0d-aac8-383b0c699b49@gmail.com>
Date: Sun, 30 Mar 2025 00:43:21 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] openrisc: Add cacheinfo support and introduce new
 utility functions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250329094622.94919-1-sahilcdq@proton.me>
 <Z-fHhT-0a-fEkPnD@antec>
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
In-Reply-To: <Z-fHhT-0a-fEkPnD@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/29/25 3:42 PM, Stafford Horne wrote:
> Thanks for the respin.
> 
> I will take this version and put it in linux next to see if any issues come up.
> 
> -Stafford

Sounds good. Let me know if any more changes are required.

> On Sat, Mar 29, 2025 at 03:16:19PM +0530, Sahil Siddiq wrote:
>> Hi,
>>
>> The main purpose of this series is to expose CPU cache attributes for
>> OpenRISC in sysfs using the cacheinfo API. The core implementation
>> to achieve this is in patch #3. Patch #1 and #2 add certain enhancements
>> to simplify the implementation of cacheinfo support.
>>
>> Patch #1 removes duplication of cache-related data members in struct
>> cpuinfo_or1k.
>>
>> Patch #2 introduces several utility functions. One set of functions is
>> used to check if the cache components and SPRs exist before attempting
>> to use them. The other set provides a convenient interface to flush or
>> invalidate a range of cache blocks.
>>
>> While testing these changes with QEMU, I realized that the check being
>> performed in cpu_cache_is_present() would always get evaluated to true
>> when the UPR_UP bit was set. This series fixes this check and addresses
>> v4's review comments.
>>
>> Thanks,
>> Sahil
>>
>> Sahil Siddiq (3):
>>    openrisc: Refactor struct cpuinfo_or1k to reduce duplication
>>    openrisc: Introduce new utility functions to flush and invalidate
>>      caches
>>    openrisc: Add cacheinfo support
>>
>>   arch/openrisc/include/asm/cacheflush.h |  17 ++++
>>   arch/openrisc/include/asm/cpuinfo.h    |  24 ++++--
>>   arch/openrisc/kernel/Makefile          |   2 +-
>>   arch/openrisc/kernel/cacheinfo.c       | 104 +++++++++++++++++++++++++
>>   arch/openrisc/kernel/dma.c             |  18 +----
>>   arch/openrisc/kernel/setup.c           |  45 +----------
>>   arch/openrisc/mm/cache.c               |  56 ++++++++++---
>>   arch/openrisc/mm/init.c                |   5 +-
>>   8 files changed, 196 insertions(+), 75 deletions(-)
>>   create mode 100644 arch/openrisc/kernel/cacheinfo.c
>>
>>
>> base-commit: ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e
>> -- 
>> 2.48.1
>>

Thanks,
Sahil
