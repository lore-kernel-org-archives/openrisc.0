Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B57602D
	for <linux-openrisc@vger.kernel.org>; Fri, 28 Feb 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710675; cv=none; b=T5oB+nBuNwhCXt334N8ALkdCGZTg8xAAb7bCK3uB1m5s2ZIipSew+Bjo6J08pHver+EgtL3PBbM1It4HXa9MiFFbk7mesPBWjHFBPYAY0w0nzaQGW/0yL4s1P32jKxTI8uOhOHMnTF71NnpNs9Wco5hDdnRxlvF32cUNr0lRBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710675; c=relaxed/simple;
	bh=0fz6H8dlUgf8ko9N18YypQHlBg79eNoT5rDDE25IBq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2eK1gOFczSOb6fn/hqV4bs6BW1qH5O7DwlDk1ypbI7HxPGEneimOwoCHy3KP2xEweib0TvvraN+uANKgTIelmZa5tZ40FTd/ZXZU/dx6NBFKr0Er+S7Y9rbZE3ZDJDPHmDmdFrC87I47jmX9CWEqtbKbZGKq0GmKZhQumhE0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cdGvg9LM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cdGvg9LM"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso2248162a91.1
        for <linux-openrisc@vger.kernel.org>; Thu, 27 Feb 2025 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740710673; x=1741315473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=cdGvg9LMCPgA86eF1veU8MttIzjFc4M9bOp1Q+ej90hvu2aZr7uyASxs7uRlr3D8kE
         YQQQANN+KG+nVURDCNJSv5gXBZoaa0W0i35WiZlp+mcBPmLoJfGx/iPTsUQgBx1Od+bK
         riOJ/vkAG14G2L8zko8aUF3QwPxJv+wmmzqITfAAwEEj6QVyvyt382VqOYTnBuj9KJAU
         HZNHwiMw671NsErHZxT6yRYWcQ8PvZzb/ikpwi5VOwlvOlu3HTNLh12KwEYvo2mJ8GYP
         PjXRKUtbafnl+V/PCk7t9Iw7EHZB8TYDo5psvQDupJbFjo70IVyq0wgSs20gO+qgyNoS
         eNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710673; x=1741315473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=VfzINqHoeX5Q2mzc5UfmypFfrMiBHbgBImw4cdWNdxTzdk1xXpSTjvvS+xs58g+26o
         MY5asFSId4WJ97DqorHeI8cRInjOel6YdADjQJUsxD9426Wc5Uqs2Jld6Z6qU9fzwetY
         gOb3stN/BLxS/gyf1F7PlDL6OVdEjGfezBvHC2eJP2gZ9t6ERxr0HC5Fcy+X+olkM9+D
         Rp4wUkx+0Gaz2gXmBQoa4zn0OfVRomb7t0QGo6Y2DrrdJmk7tPJ0JALy88n6fYvNOh+C
         e54t2NN4QpXRA5n8+VduhhUb5Qlnnzeia0SLHfkBUvlNEQCJviNt/0l6PnRIh0Quzebc
         qMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOkzes9wxQCyBNBjQ35t11KbVMrm7NFV3g0vhIyvEyDxCMw4q7nV4xmQmxa1eFdBNJa2F2i1Xf8D4YXpWt1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXwK72i2HaGdsgdFg+pt7fqfhf1AjmJoXehnG1EbOIIjpfBIr
	Z0yCis+pn4AsKFJ52l1lftzUMDJiQd3/cIh+y5Q0LQQMw2Hl5LVqNwExY1ydmPE=
X-Gm-Gg: ASbGnctkf/4aSX+tkYg4/IFXimjcDbDPhsgdxgXAlxS2U+Ie3nThb8eCcuexzZHXCf+
	AdopTykI5aqi2mExtcf3ROsEnNanpvDMLuqr/vGgmVGMTQmOoRpWibpU0xdAupI2HeR2hLLt2WI
	QiFlEA1TaW5VaVuPbkqhpcHl1KnlZfYlgrZYaXqB10HKH88RxF03FlzaQ4jqjKL10mga30Tn+ij
	U+37oepqyXdwkq0vORsv/oWXhN/FT1G6iaav6DF9aYoXodU1C5SALoSlwu3Rrb4NrHhk5LFAOKV
	uI1I+qaLBzsjT7y2/upU0V1yfQPBSJi2ZVMaTrkUu+20XDzo6Q==
X-Google-Smtp-Source: AGHT+IF4hsdZRiz/aSbemK655CZrsY9ZUuvu4Xu2ENST8y9hxHTSO7PJo35OmCgDgimYWycuvOakGg==
X-Received: by 2002:a05:6a20:1591:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1f2f3e11f86mr2902815637.19.1740710672736;
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe514besm2559832b3a.71.2025.02.27.18.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Message-ID: <e5f4e310-5bcd-4901-8ec3-757cf55dfa64@bytedance.com>
Date: Fri, 28 Feb 2025 10:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm: pgtable: convert some architectures to use
 tlb_remove_ptdesc()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/25 9:21 PM, Geert Uytterhoeven wrote:
> Hi Qi,
> 
> On Tue, 25 Feb 2025 at 04:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>> tlb_remove_page()). This is the same as the implementation of
>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>> convert these architectures to use tlb_remove_ptdesc().
>>
>> The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
>> or tlb_remove_table() for page table pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks for your patch!
> 
>>   arch/m68k/include/asm/sun3_pgalloc.h | 3 +--
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks for your review.

> 
>> --- a/arch/m68k/include/asm/sun3_pgalloc.h
>> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
>> @@ -19,8 +19,7 @@ extern const char bad_pmd_string[];
>>
>>   #define __pte_free_tlb(tlb, pte, addr)                         \
>>   do {                                                           \
>> -       pagetable_dtor(page_ptdesc(pte));                       \
>> -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
>> +       tlb_remove_ptdesc((tlb), page_ptdesc(pte));             \
>>   } while (0)
>>
> 
> With only a single statement remaining, you can remove the do { ... }
> while construct, too.

Ah, right. Will do in the next version.

Thanks!

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

