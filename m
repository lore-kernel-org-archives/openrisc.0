Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF91E521
	for <linux-openrisc@vger.kernel.org>; Tue, 10 Jun 2025 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532430; cv=none; b=QlfVenn9rjzC6ip481i+tF2ZTvr+WboIgWg1F4Xy5vWG8eOss4I640y4XqAL+dPrnslK0WbJXqdlHnAfOH2af49zeJDPUFAcQCPNn0p1RkDxjXNtcN9/FyZCZA7YvXXRnq+7oocfF5EbUe0YbftdLv1LImJUWKrQxmiEc1EJkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532430; c=relaxed/simple;
	bh=oKotk+S8tRO/XPFBEIL8SEQ2Pju/WaeyGJHdk+lj2IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqgkciQpBSka3bnStF+RQ8vnr7/AtlGOyJ2KWRwj9/xNoebvr0kEllWg/Cnu596bi0sMpfOoNZjJaWDqoy6v13jE6HS5nsYhVW2NiZUvRzzUMzPZSi3H4QExQb2RKmiykC+EH++e/JVugn5RM/+yazTm22EZoZQSh0VvEUf9LSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uuaorfby; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uuaorfby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749532427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e00FXR/t8ZOscuH4Uy5YAxKMTsNywT4U7XRo0p+QVgY=;
	b=Uuaorfby67yAr0li0EZRWXMFHJ77c2koKr41Tk2Nac9PyzBb3VEe3/xGtnv2XcsLxnQfQZ
	b4BPm7srSrpZ+iAJK3a6IsHvtaCxkX32P5rps4u3RXOulg3Kj2kECGXiNVaLB1Q/g+e8AU
	4xefAIa4UJqmAL6gLZPmYJqsS/EVLy0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-1FFqCAKXNymGeD98zQ_g_g-1; Tue, 10 Jun 2025 01:13:46 -0400
X-MC-Unique: 1FFqCAKXNymGeD98zQ_g_g-1
X-Mimecast-MFC-AGG-ID: 1FFqCAKXNymGeD98zQ_g_g_1749532425
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so700560f8f.2
        for <linux-openrisc@vger.kernel.org>; Mon, 09 Jun 2025 22:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749532425; x=1750137225;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e00FXR/t8ZOscuH4Uy5YAxKMTsNywT4U7XRo0p+QVgY=;
        b=BROFdU7euBeeiflpwFM6BvBRHZMBs+HI3/Ck35lsp6Xj5hSoUjltCzAnNVk2K962Kj
         Ntc97mEeKUpFUwA2q+dLYl6ELhpq7acBeOQZBvx/YkNP+9YL168+MeP0DEnDPKihmyUU
         cQn04Uxh7mlgh+MXp8NI8ulQb3CZK+f2tK9P3HWzGs1EsUJICl1vTiXFHr2YqWuoXo3i
         1Ez/uZUZ/UUOOTuCEZY+nCYXpA62+zTZzS/jDyBezW/b9kOG4khU8ZLxdWKykc1CIthr
         chEUX2NMCcpUucGt2xlXYcrImuDWuwweGzKs4RCkzFn+1wBm7Ec79sxgpk3zYg/eZ/We
         iyZg==
X-Forwarded-Encrypted: i=1; AJvYcCXMCH5y2SlSNBT1TwvB1s09RiXc059n9LshlCQ9hU51HL8J61jVDWwB/SABlCESa6nIshqcLG0BRWXLUcQXLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsCSrbpCnn+FDaH2ORx5b0odmGvcnzGHqUmKpa131n1ArlMnD
	N9M8EN8uSEOGKMKmhY03MVLx913tks7H9UwAb7YZblwnlaEGf53225ieZNNslaIRiKqf7HAeRQ7
	97N5xsqK1Ji8B1EKnQoLqn+nfbp4Wvvs0TpkROupTQ/G+6eL1Whsc4ztTRbW4CBe2EJIU
X-Gm-Gg: ASbGncvSylDHvOCeBIR1uabOVit/MmbEj+qgI2DjUL+ruokOyxSdY+3QvV9jcViKg3m
	5YTXvMP1mNntdtekHTkRayeg9QzAUIxPdO9Z69y3bTotdyqTwMfN/K6agbwkAX90mkYBzPjUf3f
	uIAxe/shszNhGD9HjF0M4l332CVN7bNNNYtMe6om7KMHeYl9AcRok4BHxm1tl7Op+OcxuH2itKf
	nFXWjCdGKLPA/oKgF3Qe9UCdCgxnA489pUpGW0+lgQvB42aLi2tW/NCXRQYVCo9LnPaRLXSHcv+
	+xOajMzHHsXnsCgmSsbL+FwOujzjTp/nvkBeuXZuWbP4JtF9Cz/5PQd55LD6UVA=
X-Received: by 2002:a05:6000:288e:b0:3a4:e841:b236 with SMTP id ffacd0b85a97d-3a53188e4c2mr12946600f8f.33.1749532424699;
        Mon, 09 Jun 2025 22:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYv+UVg9SN8VrK+HWnrUNL3pRJudyYHexGeGmazwPRbTTj3ycR2HRI8/csrTbKixLzIOFj4g==
X-Received: by 2002:a05:6000:288e:b0:3a4:e841:b236 with SMTP id ffacd0b85a97d-3a53188e4c2mr12946580f8f.33.1749532424316;
        Mon, 09 Jun 2025 22:13:44 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net. [47.64.115.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229e0dcsm11505912f8f.15.2025.06.09.22.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 22:13:43 -0700 (PDT)
Message-ID: <3f833371-bfae-4ee0-bd76-016054630844@redhat.com>
Date: Tue, 10 Jun 2025 07:13:42 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/41] openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__
 in non-uapi headers
To: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 linux-openrisc@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-24-thuth@redhat.com>
 <389d8e93-0dbf-4b69-a80c-bf1e9c93b0ff@redhat.com> <aENFPqbFFLOh3uSZ@antec>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aENFPqbFFLOh3uSZ@antec>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CZz3fwf6lXLQopLn6oQGXAyPtCwFFf_TW3EIEyfcKD0_1749532425
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2025 21.45, Stafford Horne wrote:
> On Fri, Jun 06, 2025 at 08:42:28AM +0200, Thomas Huth wrote:
>> On 14/03/2025 08.09, Thomas Huth wrote:
>>> While the GCC and Clang compilers already define __ASSEMBLER__
>>> automatically when compiling assembly code, __ASSEMBLY__ is a
>>> macro that only gets defined by the Makefiles in the kernel.
>>> This can be very confusing when switching between userspace
>>> and kernelspace coding, or when dealing with uapi headers that
>>> rather should use __ASSEMBLER__ instead. So let's standardize on
>>> the __ASSEMBLER__ macro that is provided by the compilers now.
>>>
>>> This is a completely mechanical patch (done with a simple "sed -i"
>>> statement).
>>>
>>> Cc: Jonas Bonn<jonas@southpole.se>
>>> Cc: Stefan Kristiansson<stefan.kristiansson@saunalahti.fi>
>>> Cc: Stafford Horne<shorne@gmail.com>
>>> Cc:linux-openrisc@vger.kernel.org
>>> Signed-off-by: Thomas Huth<thuth@redhat.com>
>>> ---
>>>    arch/openrisc/include/asm/mmu.h         | 2 +-
>>>    arch/openrisc/include/asm/page.h        | 8 ++++----
>>>    arch/openrisc/include/asm/pgtable.h     | 4 ++--
>>>    arch/openrisc/include/asm/processor.h   | 4 ++--
>>>    arch/openrisc/include/asm/ptrace.h      | 4 ++--
>>>    arch/openrisc/include/asm/setup.h       | 2 +-
>>>    arch/openrisc/include/asm/thread_info.h | 8 ++++----
>>>    7 files changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/openrisc/include/asm/mmu.h b/arch/openrisc/include/asm/mmu.h
>>> index eb720110f3a20..e7826a681bc4a 100644
>>> --- a/arch/openrisc/include/asm/mmu.h
>>> +++ b/arch/openrisc/include/asm/mmu.h
>>> @@ -15,7 +15,7 @@
>>>    #ifndef __ASM_OPENRISC_MMU_H
>>>    #define __ASM_OPENRISC_MMU_H
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    typedef unsigned long mm_context_t;
>>>    #endif
>>> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
>>> index c589e96035e15..85797f94d1d74 100644
>>> --- a/arch/openrisc/include/asm/page.h
>>> +++ b/arch/openrisc/include/asm/page.h
>>> @@ -25,7 +25,7 @@
>>>     */
>>>    #include <asm/setup.h>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>>>    #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
>>> @@ -55,10 +55,10 @@ typedef struct page *pgtable_t;
>>>    #define __pgd(x)	((pgd_t) { (x) })
>>>    #define __pgprot(x)	((pgprot_t) { (x) })
>>> -#endif /* !__ASSEMBLY__ */
>>> +#endif /* !__ASSEMBLER__ */
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
>>>    #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
>>> @@ -73,7 +73,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>>>    #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
>>> -#endif /* __ASSEMBLY__ */
>>> +#endif /* __ASSEMBLER__ */
>>>    #include <asm-generic/memory_model.h>
>>>    #include <asm-generic/getorder.h>
>>> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
>>> index 60c6ce7ff2dcf..cd979bd28ab3b 100644
>>> --- a/arch/openrisc/include/asm/pgtable.h
>>> +++ b/arch/openrisc/include/asm/pgtable.h
>>> @@ -23,7 +23,7 @@
>>>    #include <asm-generic/pgtable-nopmd.h>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    #include <asm/mmu.h>
>>>    #include <asm/fixmap.h>
>>> @@ -432,5 +432,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>>    typedef pte_t *pte_addr_t;
>>> -#endif /* __ASSEMBLY__ */
>>> +#endif /* __ASSEMBLER__ */
>>>    #endif /* __ASM_OPENRISC_PGTABLE_H */
>>> diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
>>> index e05d1b59e24e1..3ff893a67c13b 100644
>>> --- a/arch/openrisc/include/asm/processor.h
>>> +++ b/arch/openrisc/include/asm/processor.h
>>> @@ -39,7 +39,7 @@
>>>     */
>>>    #define TASK_UNMAPPED_BASE      (TASK_SIZE / 8 * 3)
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    struct task_struct;
>>> @@ -78,5 +78,5 @@ void show_registers(struct pt_regs *regs);
>>>    #define cpu_relax()     barrier()
>>> -#endif /* __ASSEMBLY__ */
>>> +#endif /* __ASSEMBLER__ */
>>>    #endif /* __ASM_OPENRISC_PROCESSOR_H */
>>> diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
>>> index e5a282b670757..28facf2f3e00c 100644
>>> --- a/arch/openrisc/include/asm/ptrace.h
>>> +++ b/arch/openrisc/include/asm/ptrace.h
>>> @@ -27,7 +27,7 @@
>>>     * they share a cacheline (not done yet, though... future optimization).
>>>     */
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    /*
>>>     * This struct describes how the registers are laid out on the kernel stack
>>>     * during a syscall or other kernel entry.
>>> @@ -147,7 +147,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
>>>    	return *(unsigned long *)((unsigned long)regs + offset);
>>>    }
>>> -#endif /* __ASSEMBLY__ */
>>> +#endif /* __ASSEMBLER__ */
>>>    /*
>>>     * Offsets used by 'ptrace' system call interface.
>>> diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
>>> index 9acbc5deda691..dce9f4d3b378f 100644
>>> --- a/arch/openrisc/include/asm/setup.h
>>> +++ b/arch/openrisc/include/asm/setup.h
>>> @@ -8,7 +8,7 @@
>>>    #include <linux/init.h>
>>>    #include <asm-generic/setup.h>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    void __init or1k_early_setup(void *fdt);
>>>    #endif
>>> diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
>>> index 4af3049c34c21..e338fff7efb0e 100644
>>> --- a/arch/openrisc/include/asm/thread_info.h
>>> +++ b/arch/openrisc/include/asm/thread_info.h
>>> @@ -17,7 +17,7 @@
>>>    #ifdef __KERNEL__
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    #include <asm/types.h>
>>>    #include <asm/processor.h>
>>>    #endif
>>> @@ -38,7 +38,7 @@
>>>     * - if the contents of this structure are changed, the assembly constants
>>>     *   must also be changed
>>>     */
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    struct thread_info {
>>>    	struct task_struct	*task;		/* main task structure */
>>> @@ -58,7 +58,7 @@ struct thread_info {
>>>     *
>>>     * preempt_count needs to be 1 initially, until the scheduler is functional.
>>>     */
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    #define INIT_THREAD_INFO(tsk)				\
>>>    {							\
>>>    	.task		= &tsk,				\
>>> @@ -75,7 +75,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
>>>    #define get_thread_info(ti) get_task_struct((ti)->task)
>>>    #define put_thread_info(ti) put_task_struct((ti)->task)
>>> -#endif /* !__ASSEMBLY__ */
>>> +#endif /* !__ASSEMBLER__ */
>>>    /*
>>>     * thread information flags
>>> -- 2.48.1
>>>
>>
>> Friendly ping!
>>
>> Jonas, Stefan, Stafford, could you maybe pick this (and the previous patch)
>> up via your openrisc tree? (x86 and parisc already got merge via their
>> respective architecture trees, so I guess the same should happen for this
>> patch here, too).
> 
> Hi Thomas,
> 
> Sure, this might not make it for the 6.16 merge window as we may not have time
> for it to have a cycle in linux-next.  Is that ok?

  Hi Stafford,

yes, that's fine, there is no hurry for these patches.

  Thanks,
   Thomas

