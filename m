Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AA1DFFD;
	Fri, 18 Apr 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967547; cv=none; b=DuEtt3BMq3spv5QbSUcFs6cySCH6REhaI9ywz1ShfDz03dYLQ6XkYG+DLNpiMTSo1LmU/PWvIsqgxxU8HU3LYyxYdUUS3hIIdZf5x3J5bx10uzUGGZp655qRa6qSXIBR3+VrcI+Oqg8HMCP1AWlAf6bYJyQK2HcgFzDJn/I0Sjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967547; c=relaxed/simple;
	bh=DLuU0+GY4jJSfkUe/qOlorsGAfKsreCqXb9TSenefvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DT9VSaoljGdchS9VeD+cp+bvqrHfwjYGoKAwdQiDNDTloGgxtw9K+L9TwCxsqmAwuYJEUaiCJwDFf/Me7CKT4nQJYs6gfqoycj5wJkpARrYS8lnzgiOzEJBEkV1X9gK9ywRgrlcSc9sNTy6gfcwo931TjvoCUGb5WWSDUtx9rrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWUcALgf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWUcALgf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c277331eso2609311b3a.1;
        Fri, 18 Apr 2025 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744967545; x=1745572345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sN/nWsZBcn5hLz1mgBDSjRyDT6g+wbCQ0ZxSl8IYKbc=;
        b=HWUcALgfTaK2hmfbcEzO3L0XeCGr2MkW+Dv+XrVc0tB/twxiQBv8ZvgY5l1cuDEqBK
         yz6Bs87DwThWc1m2khIF0kMi5xu74N56NuREFbveJsAYB8MDUf/VjpapCgw/JPxSsCJr
         WzIrIq/le0dgtfYgbP7eJvgZqW/ZpvUk9B9QqlkiBAR+RDM52MFrIARW/ai0csBe2KrI
         YVv+YkGoT7GmhjzVkQiJrTfVJXLZnxC1yPYPPW5iLgfjMa+LNVQ95lOwv74fVMfsRRFk
         i3NW4BGMk5i8AY0VtzDNiJ0lBO72wgrNK3p04Z7TXc4LeNRmU8ZrNu4e7LUYcxOzkmLH
         utDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744967545; x=1745572345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN/nWsZBcn5hLz1mgBDSjRyDT6g+wbCQ0ZxSl8IYKbc=;
        b=BMuYEEy1rUSqG5wNOKKjyczAQvv+kcJkxZc8K408oIRcAShVOlHpV43xil2t37iwH7
         2VQTTNrfgj/0oBzUD8MXEuuPqXDB9t3hXX5lBL4dbvuz02BqR4knW1zecsYn30LENYrJ
         yIDcXK+7g2n1Do7wNWi5cyY/lEK1nvxzyeLz/HwMNpbwAluZnGeOyertBiYQYUGHXOLL
         /YhMnK6EguUrPYbmuh4BMrLFnf3HO2ArymxY+wvtYZpjLDaujy3ztbNdxYz5YEC5tJV8
         woHayavJ9t51BIRjH+D3Tu4qSBePcHbWyD8byFQGRErJ0ECykBP/xnoAUEJcw2ZcdOnu
         9niw==
X-Forwarded-Encrypted: i=1; AJvYcCVKVBTOjbGiRYzRUcyF6C7GkE0H1V6l+YDodiM85sasE5VmfZTiqrskL/CybZ2Wowy89PjY+B+7wcJK5ZY=@vger.kernel.org, AJvYcCXoLSoMCxJnuRpr81XfauyI6GUJEGHqGGfTCr9BIg7ehiL4+s6X+8yR8ZVKgqHCC6dTW8CGp5xK1+5LL3AwE7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykancI6LjeU+U3qlKRNNB7TCmQmOD+SJswxUtsbMwuxYk/nYT
	ZhQmLvwsxPlQSnpSsFO6RC28JIOLFCWBIBExk7MtYsEnGYTtyZNo
X-Gm-Gg: ASbGncv8rt4FfWOazYGDbYAQAj89ZQqAxHRHYT/XgeXXKbeHifw/rDNhdAvee19InAq
	t641EB7n8S88IghxvxomszG3Xrk59cdXyFxiydB/w5N8yWQMUA1Atgn1aSPmaNeWq7r9luZ3JvL
	fBiPv4JJp1lIyRL6+uqwQzHragf+dA7YUuyy3lIl4KT/hY03yJ9s0BBsVBJIqtUvnUgv/1bbfTo
	ULQLlMI96GAcww8xndZq3lIo5Mq9pYDW2zZZalSoDPPw5ZIKAu3N6Iy1Q3PRg0o5Rb21MvkQcAZ
	zNImhe5IPUPqismH2T8QW6DU8Vx3Yrzh6Zh4eBQDW7C+xjJf+nClhaoLDx9uATnPLmDDcABCjyV
	F7JjcIqUb
X-Google-Smtp-Source: AGHT+IEHYK2Tj7bpmH+DkAtQkOOWyOkg1WAwHZ51iYjZ07uvJG32ewsYfPtIVx7cavpYQAFq80RUdg==
X-Received: by 2002:aa7:9318:0:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-73dc1828d91mr3109954b3a.5.1744967545382;
        Fri, 18 Apr 2025 02:12:25 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:45a3:affe:4635:b6b6:1a76? ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaab92esm1166402b3a.127.2025.04.18.02.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:12:24 -0700 (PDT)
Message-ID: <f6f4f410-4a0a-4ce3-bf41-413af39fd50e@gmail.com>
Date: Fri, 18 Apr 2025 14:42:20 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] openrisc: Fix build warning in cache.c
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250401200129.287769-1-sahilcdq@proton.me>
 <Z-6VyRhGdInVidsw@antec> <af85b465-13e5-44e5-a0af-c7c68af7d43e@gmail.com>
 <aAIDfcZ4XD5f6mA4@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <aAIDfcZ4XD5f6mA4@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stafford,

On 4/18/25 1:17 PM, Stafford Horne wrote:
> On Fri, Apr 04, 2025 at 10:39:22AM +0530, Sahil Siddiq wrote:
> [...]
> Hi Sahil,
> 
> Sorry for delay in getting back on this.

No worries :)

> I was working on getting this patches ready for upstreaming and noticed one
> thing:
> 
>      ---------------------------------------------------------------------------------------
>      ./patches/or1k-20250418/0001-openrisc-Refactor-struct-cpuinfo_or1k-to-reduce-dupl.patch
>      ---------------------------------------------------------------------------------------
>      WARNING: From:/Signed-off-by: email address mismatch: 'From: Sahil Siddiq <icegambit91@gmail.com>' != 'Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>'
> 
>      total: 0 errors, 1 warnings, 102 lines checked
> 
> As you can see above the scripts/checkpatch.pl is failing with the warning
> about your email and signed-off-by not matching.  You can see more about it
> in the FROM_SIGN_OFF_MISMATCH section of the checkpatch[0] docs.

Ok, this makes sense. I configured git-send-email to use gmail because
protonmail does not work with git-send-email without a paid account.

> How would you like to resolve this?

Is this a warning that cannot be ignored? I can:

1. submit the patch series with another email address that won't have issues
    with git-send-email, or
2. submit the patch series using protonmail's web client (which might not be
    the best option).

I would prefer not to use "icegambit91" in the signed-off-by tag.

What are your thoughts on this?

Thanks,
Sahil
