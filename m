Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607D1A29A
	for <linux-openrisc@vger.kernel.org>; Fri, 24 Jan 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723858; cv=none; b=R8Dx78dMUPxq0cSoQTSCztYw9BdfqDAdD/655rjvTXg1YabK6+HenTtrKOcgYAxiYt38JDK99RlNsh3TPiKI7cCHTn+yUY+A6yb9YPtL7sBTTjolhHgZ8zqC1o2VbslYEAa7A2ihi2NG7afI2QMHdzGirdO0LF97LAP2b87aGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723858; c=relaxed/simple;
	bh=6DUwB+hCjWKh6+gmJpLDb9ZpCQfqoZDHN+wZTg6VGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGdDHQIXN+Y7yjCjkYWZiyqDWaJbBhqVzzqzd0qO0Fo4TFJaRJlGOUPcgVrY0l2Jm32wh7Nqu/p4AI6OsgcYuUA69kbzzmmX7Tunh4gFb/06VSSK2fx0JII+tg8Bzs9JUww2yUnXz/nQ3rwGoAe3/pHrukGSxHS7oj+SFTpWNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WcolCWBh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WcolCWBh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so3712273a91.3
        for <linux-openrisc@vger.kernel.org>; Fri, 24 Jan 2025 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737723855; x=1738328655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dId7b4yz8t9ytNzoIMZDzDyU9S5trP6VQ+ykZ7MFw3k=;
        b=WcolCWBh+lB0KK8J6dDDEpKKfAjF2Cm6vBH1qSPgHiLw2VU81OIi3krrtfSEFWD9yO
         AqbnVBZZnFSp0SPjfB+kIjYMWdslGMdkpPA8S5gjdvQI0f3VZiAJxhLNERNL31UgWYG1
         guI1Xi3e/gDfb11BNupzOJ66yAMX1m75bZ2tUhpWXuVS99UyoZF3GgEiASJS8eG+qVcR
         pXuFs342QbpqHYxe6z9BMnhI2d+BMUx/R6mfINhNwZUur1HPSJBAvu4z16axZqcOpgqq
         xgHgWHkOffIZbVLnZWBABUNqZkmDgkdZw0TrtFP+pM+6syIFaocruvc2yOk22b7S+9Pu
         8P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723855; x=1738328655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dId7b4yz8t9ytNzoIMZDzDyU9S5trP6VQ+ykZ7MFw3k=;
        b=iR0GXcIqrdPvUHSZVlPfCkOcszB5VjTgUp+3eqJ8dnA7E3e3zKFea3PO0HSZbkSgML
         XBJJbd1SJnXfqdyiXp9OxMo8g6qnDC1nBaef5lf0OhVpJmaqFmra89T+e2R/NgWUHcd7
         wAhc+RbV//+9UXuJIHsRyLB/XEJbDOPfCG2cPZnyqWi4ZANbg/+P9t0rNDJwTT7abUoh
         YyTddxJV21UPIwIbk2MOQWCeNmVljm6jWEoM3ll7s4Aq7uv5xRj+iylVIBBUlaoHEXIp
         P5HJlp2UZiCzZ+HIL29pR/ZAwUZsPZ9VmIrcrkw1k0wpRXoG3lzGv5vLHoudRq3JJ+wh
         uBuA==
X-Forwarded-Encrypted: i=1; AJvYcCWH/d6m6IN03/x+Nv3sjUj0vv2/TuZl2ACZKyqbWxzmeK6MAeaUGsvlVYwdx8IegiNoWcwWZYvGLFQk1q1JwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1BDVem/9SOM7qhal1YTd/0x/v9npeS+LLvy2AbRRlxOJQaU5
	/38lcFuz5r5zsHOHHkx4uTJicMJo2hesoZZxnlBFqPTGP1Cwmx7kftklBV5F1cY=
X-Gm-Gg: ASbGncv93bNK4Wz9Lmp9aAJbfzd0Ool7SX0p+O0XZY8K/x9MlqGKB8BpQxp2r2IUyLt
	cHNNjF7Ngr6nmpBj+s80aAXxSrNaz9WFECX+aU+VABp1KIlp0l0jsrCK4Gv5UUMB18676f5I8yq
	DWhhsqxX6m6Ir0FjpHLWFcmgctuCYVLVh4cqT4Sd4gR58H16Y9VsbX+qoKwptJoD/I+FGQuGXO1
	YtPDrG93hSQKSH3wlJbWwOst3xVXP4J+dRm8sIFww5hwD/rNaeGgk5n/6wpAXOA1EPLytEVVr3F
	bitCd8lyJSm3MkL3eZ6bpOmOusaAHeXw13Fvbp+lyAsd1Fx4UU7EmHmS1lhkSqFne6Exf6HzL59
	8zSr3
X-Google-Smtp-Source: AGHT+IGZTgGY31e/1k/dTmcJmo/YDWxdXL7RglCap7bUypXHuwXLFHjK5+LGZw2OAN+HVTY4hEX3Xw==
X-Received: by 2002:a17:90b:2d88:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-2f782c628bbmr47170073a91.2.1737723854887;
        Fri, 24 Jan 2025 05:04:14 -0800 (PST)
Received: from ?IPV6:240e:370:8b13:5250:f0b9:2326:6cb0:b423? ([240e:370:8b13:5250:f0b9:2326:6cb0:b423])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a975sm1776638a91.15.2025.01.24.05.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:04:13 -0800 (PST)
Message-ID: <65710478-4ee0-499e-9f66-dff81e226042@bytedance.com>
Date: Fri, 24 Jan 2025 21:04:02 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: kevin.brodsky@arm.com, riel@surriel.com, vishal.moola@gmail.com,
 david@redhat.com, jannh@google.com, hughd@google.com, willy@infradead.org,
 yuzhao@google.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
 <20250124114759.GB15996@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250124114759.GB15996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/24 19:47, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 09:26:13PM +0800, Qi Zheng wrote:
>> Hi all,
>>
>> As suggested by Peter Zijlstra below [1], this series aims to remove
>> tlb_remove_page_ptdesc().
>>
>> : Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
>> : there should not be a page-table anywhere near here *ever*.
>> :
>> : Yes, some architectures use tlb_remove_page() for page-tables too, but
>> : that is more or less an implementation detail that can be fixed.
>>
>> After this series, all architectures use tlb_remove_table() or tlb_remove_ptdesc()
>> to remove the page table pages. In the future, once all architectures using
>> tlb_remove_table() have also converted to using struct ptdesc (eg. powerpc), it
>> may be possible to use only tlb_remove_ptdesc().
> 
> Right, so I don't think Sparc and Power care to use ptdesc, they're
> using non page page-tables.
> 
> At the very least we should do something like this, the only point of
> having tlb_remove_ptdesc() is type safety, there really is no benefit
> from it in any other way.
> 
> ---
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index dec030cb1210..a6731328db6f 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -504,7 +504,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>   	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>   }
>   
> -static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> +static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
>   {
>   	tlb_remove_table(tlb, pt);
>   }

Ah, make sense. I think this can be added to the patch #1.

Thanks!

