Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D61A3168;
	Fri, 18 Apr 2025 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979680; cv=none; b=FGadbGmIR2zIscaYjQK3nnjHOPBx8HdVZS+Ov6PcABi6f4dDZWK2GAO+jLsEF+ewolGu3cbmWnU+nIREVhz0Z7lGnXUaz42DUEbiGBOl5cxiREYbDwA8RqLkLM1NXtSEf1x3gAk2t3YSY9WReZZqr+3fzt7vNCvx0LkrKSN8FnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979680; c=relaxed/simple;
	bh=EBOCjqnzKDn5KNNhu52mFgi297d2hKgnU7sjROgDKus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqODm7z1P6tL/wA4GtmYHuUN/aUreZPDJZvMaq0MIbTBO50EYwKxZ8cOJVk0dPM43KvWzlmY2KpYozOkbmCYrjXswItSVBYmbZJpwS7/dn0UgfQU6kgH1pH0GPM4ddkYtYem9GVG2R9KYqdyUcMYFbH4R4rQ7dWCUosfAqMlOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjxKT2Lc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjxKT2Lc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33ac23edso19937975ad.0;
        Fri, 18 Apr 2025 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744979678; x=1745584478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h/gTtHkZm4DcyAga3QLAmHjWTATKPBz8czS/VERcj6o=;
        b=LjxKT2Lcs7H1WtYfqXVF94PlGuuKiiwVlgc4f3CQSJgodlm3p3BqpWBRvJ6n7xMB6p
         t+F+yOT8N1IxBqWhsO9ZL9cU4FlX6Tu73BLM1r9bz78vv2qluRkMvL7d5GWz28CNf3N5
         AkFrOtB8Skw/VLjUlkfBwDTkTAjmq/w8sPH+87spWHLGJIsQ8PcDsEGDQ7D/QYqW6VwK
         47HfSbJWKFybBlYwQWuvdpPuwbPyySnS7/GPTDl4x/LmjkfFmePKjIfwo3Su+KS/sh8N
         /2JQ+o4ymIumpi1YaRGOZjWoheglvxj8/mXT0DrfA55KpBYhZRn1WU/B0Pm+cLkN3H6d
         T7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744979678; x=1745584478;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/gTtHkZm4DcyAga3QLAmHjWTATKPBz8czS/VERcj6o=;
        b=XhoHXq3PR+HvJtAxcE0DlVwNPHElVhtPl8IM7GsiWcbYSjY4vb9uBlUKCE1OhZOe4T
         LA2TrIz7bW00E/+n7Uez/SFVCt4Hl2TL3IVgVIVfoh8RvccYzlnyBu4jxclXMCbwYjyt
         W7TctbdKPex2t8cVje9T8/rITIRECmzVwL0e6cnfTB6bxOUDmPs/NeFEYDh0N6e4XZbh
         3BxQuYA+YgqlyaOccSxj7+cmnmPAo12br5NI6bNVCb76pRjbAIIvMbtRagQz7+4f+qtg
         11f8Y4STjsyGn7LViG7wmla9LVC1/io+H1jpz51MquMmvoZIHAxCYQbg0Cau8f+XcDHr
         RsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW29L/PdYIf7sJMnYlm0npNVVk3jmV2WG3Y0YZd9F2d87+0raHynKm+YIyS4oipLdI6+vI91KOjF/S+ZK5EZ+c=@vger.kernel.org, AJvYcCXq3utq39GLzwcVhawVgc+oi39d81lWIIkhkYmp5h4D32pCMPqZgYIabEqPxXTgx0exvWdxX2QR7mwHpKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1QmkAGeTZiBbvw8qEY4uFHQnmAHSlomNai3IFFFVHeO47R3N
	uDEriZEy2qxX6pWW59SqRCeN0Y0sJEAFEl0ZbvQlILX9JAaJ0QKuHNyJCA==
X-Gm-Gg: ASbGnctqNaqQZb0+0MNo0+xZb7OKnnzHYGfxZU3CcOiQe/mbSfdAI0VtP4yjYcE+xdz
	d2pK4xcM2zVO/zYl5DCu0BTj6trbztNbLzrrcKPdpWbeH5AFX5NiMmhWL6zXswN803fM97yB6oE
	pq0QBYNsN79kT7SBY5p3JiI3U76XjhzBlHMpNXDOmPVZyK9vU/OkQspAjKvhPfkihaDYM1hGP1D
	/EiBspUy+RuXOsKVo88MsBh0r7+ARkGU/q9qkyLxrEIsiOHRJFD8WiAw499Qd6DwdcR0sPM1ZZO
	aL77SpLjY6n5n1KVvqfKRVBR3qM68uAyIRfNNHhWni9rYF5BNO33fli947BE91fSB/cVSaxixUz
	eKs+qCh2i
X-Google-Smtp-Source: AGHT+IGdTCi9sikzAO1ApDHXMnuSueMHJB9dcz8BsiC/DBVSKjqmER4SDsyP6PvNYbpt9ejFYk1M9A==
X-Received: by 2002:a17:902:fc50:b0:224:23ab:b88b with SMTP id d9443c01a7336-22c535734c2mr31775145ad.8.1744979678113;
        Fri, 18 Apr 2025 05:34:38 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:45a3:affe:4635:b6b6:1a76? ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13e1sm1487974b3a.46.2025.04.18.05.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 05:34:37 -0700 (PDT)
Message-ID: <64beb3b4-a8fa-4acd-a139-6c19de0e37f4@gmail.com>
Date: Fri, 18 Apr 2025 18:04:29 +0530
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
 <aAIDfcZ4XD5f6mA4@antec> <f6f4f410-4a0a-4ce3-bf41-413af39fd50e@gmail.com>
 <aAIivK7NDG-6_aIU@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <aAIivK7NDG-6_aIU@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/18/25 3:30 PM, Stafford Horne wrote:
> On Fri, Apr 18, 2025 at 02:42:20PM +0530, Sahil Siddiq wrote:
>> On 4/18/25 1:17 PM, Stafford Horne wrote:
>>> On Fri, Apr 04, 2025 at 10:39:22AM +0530, Sahil Siddiq wrote:
>>> [...]
>>> I was working on getting this patches ready for upstreaming and noticed one
>>> thing:
>>>
>>>       ---------------------------------------------------------------------------------------
>>>       ./patches/or1k-20250418/0001-openrisc-Refactor-struct-cpuinfo_or1k-to-reduce-dupl.patch
>>>       ---------------------------------------------------------------------------------------
>>>       WARNING: From:/Signed-off-by: email address mismatch: 'From: Sahil Siddiq <icegambit91@gmail.com>' != 'Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>'
>>>
>>>       total: 0 errors, 1 warnings, 102 lines checked
>>>
>>> As you can see above the scripts/checkpatch.pl is failing with the warning
>>> about your email and signed-off-by not matching.  You can see more about it
>>> in the FROM_SIGN_OFF_MISMATCH section of the checkpatch[0] docs.
>>
>> Ok, this makes sense. I configured git-send-email to use gmail because
>> protonmail does not work with git-send-email without a paid account.
>>
>>> How would you like to resolve this?
>>
>> Is this a warning that cannot be ignored? I can:
>>
>> 1. submit the patch series with another email address that won't have issues
>>     with git-send-email, or
>> 2. submit the patch series using protonmail's web client (which might not be
>>     the best option).
>>
>> I would prefer not to use "icegambit91" in the signed-off-by tag.
>>
>> What are your thoughts on this?
> 
> I could rewrite the from header to match sahilcdq@proton.me.
> 
> But if I do that you should find a way to get proton.me to work with
> gi-send-email [0] for future commits.  It seems this can work using the
> Protonmail Bridge[1], though this site also says proton.me is not so good for
> using with git send email.

Right. Also, protonmail bridge requires a paid proton account.

> Maybe using another email in signed-off-by would be better.  The current
> patches are on linux-next[2] where we can see the From/Signed-off-by mismatch.
> For example:
> 
>      author	Sahil Siddiq <icegambit91@gmail.com>	2025-03-29 15:16:22 +0530
>      committer	Stafford Horne <shorne@gmail.com>	2025-03-29 10:22:21 +0000
>      commit	af83ece87a1ef5097434b7c3c1fc0e9e7b83b192 (patch)
> 
>      ...
> 
>      Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>      Signed-off-by: Stafford Horne <shorne@gmail.com>
> 

I agree. I have another email id (sahilcdq0@gmail.com). I can configure git
to use this and this can also be used in the signed-off-by tag. So, this id
shouldn't cause an issue.

Let me know if I should send the series using this email id.

Thanks,
Sahil

