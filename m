Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D17083C
	for <linux-openrisc@vger.kernel.org>; Tue, 10 Jun 2025 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532666; cv=none; b=Cd4YXEXBForOj6pzToFrnmDbMSW7kqMLgBxCxnB48yVG/12KCvDb+i4Y7Cnad5PV6yB1OLw73GHFHFWfJvKKfpu7VlWlbrZmUb3l4O8zXwH8o/zixsQTfLLGT3GKVkM6D9kMsPHDwIR7luFF9NrOGLsR/+QSXM09yRnLFLCW80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532666; c=relaxed/simple;
	bh=e1NZk8H4fzNdnun+chXkufZvfs9S13vSXpDNcmYxWrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqE8aimIw5Xordd87yrE6ujcA/4UaIGQMMCMQqKG0CoeXquOn8i0MTFaTKf0Gm+WaZsuh+ygoUQji7TOG9Fp7l921y+F2qHD+zzWH7XpG/Z3UQnvGUrrYOX06cSwPvIRN+Fb+WK62etjEkIIBi4X+3QCT0qMSw4qVwYyohCV+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cktb0H6e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cktb0H6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749532662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BV/weg+UIxzyIy5YuYcXGIg5uLadDsxro49/jeAezIg=;
	b=Cktb0H6e4JGb1rP7j0g+mE41CEwfnlpm+fRwVKqJqix2wemAPmM/xX+vdkySBygzoY5LAN
	ee51J67QTS3bnQn6sKVBsDv8AZRU6oDZbKxPOOsAwgONA8d/PI0wnVQ29wKQVYQje+6odf
	vAveoLMgDqnXlRvQHFfEl338Zd7sMEA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-FFhSzGBaMgmgQqy0R_tgoA-1; Tue, 10 Jun 2025 01:17:41 -0400
X-MC-Unique: FFhSzGBaMgmgQqy0R_tgoA-1
X-Mimecast-MFC-AGG-ID: FFhSzGBaMgmgQqy0R_tgoA_1749532660
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade5013e0b9so136309466b.2
        for <linux-openrisc@vger.kernel.org>; Mon, 09 Jun 2025 22:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749532660; x=1750137460;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV/weg+UIxzyIy5YuYcXGIg5uLadDsxro49/jeAezIg=;
        b=NvDG5F3fb1QrrW4jrunM2BnfExV+dqq3uL/aihoEXODogFtpYMRSZ2DOKGyGHuKN1D
         1wn/0dcEqI5wiqB9kFtOlkPujxzzOLN5ApgTTP4LS+gUDsKu9ZsrqLPDrhjixDYH8xVv
         epJGjkZPXsLKnzOkwOjE/OlnUSnbMRWBKyfhbBOmQSVFUd/sCINGMi5oS+XQ7dWjTWY7
         wDcso0SQ0rWJfT9Sk3/tfn7Q+AmVHBCyq9XYYj6qhNyEnRT8X63b2lDeXtPi+WsVhoVt
         MpBpOQQEHpk4j3YJm8Z7CrB9xcksl8nngcXkQDRibnR+3mPQ0OEDKmtw0OSYwRPfJzc/
         a8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Y/CBPnBI8BZ8bgKEes47a+MBtxd+/k6LlWL5nQz6JIOBUYxq/dq5LMuiOPkpGRNnaRVqlkyUupv5HNxVqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywud2vUw5IIWhaKeu455/yoDYQ+sVmtTKs+gclvnSH79Ke1+C6b
	MYK/32rMVWXsq72x0y0kD0c0XGYa6Ya3og7/o2r1chX3A25fJDc47bFP4j+h+sX2jF6k1Ok2Qkt
	0peWQJjNyXYcxfVlnyAUzBK2jHBEAdFVbk98bXDsXqbsCkhFJIOI/XWS+j7ovAa5nP/kc
X-Gm-Gg: ASbGncvIw3VPEScYmJUFZWccLPCYgDNJYQTOVtmISGgxPqmWzDJP19nKTwWqiiAcFOB
	MKBltHfHzFlOvgAPpEz6hMhCweP5O2I3+2C3yvUuSwK6/FLdf7yFAlQvckidiFxgxxHCmyydtE/
	JI+cO7icL4s4WlkJ3sFeoeWrEX8CK8vT/vD8EdhFMFCLR+z6GuG/mq3w4tN34C06kwkNihSbCYZ
	vIQSOXIIqEIQ5P0bSAiBtnEWzGXjq4QBVdWM4KuWPLjOet8VwkK5LSLhCR7vv2vDxzTWrGneYSf
	gzu189K0DJkgvr3229LyamX4rUC8xC/jun9xfoXHrVAI6n6WFuqWwUD//b9N07g=
X-Received: by 2002:a17:907:94c8:b0:ad8:91e4:a91c with SMTP id a640c23a62f3a-ade1aab9825mr1523829566b.29.1749532659831;
        Mon, 09 Jun 2025 22:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6ZlPqr8MXWJ6wmsuncd7kZ2DbA0mKNoz7HJxj/enKFPg8pax5TkHx2TqdqrVLDaRkoFuKUg==
X-Received: by 2002:a17:907:94c8:b0:ad8:91e4:a91c with SMTP id a640c23a62f3a-ade1aab9825mr1523827866b.29.1749532659354;
        Mon, 09 Jun 2025 22:17:39 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net. [47.64.115.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d754653sm656669366b.20.2025.06.09.22.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 22:17:38 -0700 (PDT)
Message-ID: <5acd86ce-fb63-41c7-9643-97cc88dba148@redhat.com>
Date: Tue, 10 Jun 2025 07:17:37 +0200
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
 <aEPWD-WOkVM3uO-b@antec>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <aEPWD-WOkVM3uO-b@antec>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GBi0MzKDtsT7SR-nUp3Or6k7btNBiOFrMEfQzoUxHAw_1749532660
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/06/2025 08.02, Stafford Horne wrote:
> On Fri, Jun 06, 2025 at 08:45:02PM +0100, Stafford Horne wrote:
>> On Fri, Jun 06, 2025 at 08:42:28AM +0200, Thomas Huth wrote:
>>> On 14/03/2025 08.09, Thomas Huth wrote:
>>>> While the GCC and Clang compilers already define __ASSEMBLER__
>>>> automatically when compiling assembly code, __ASSEMBLY__ is a
>>>> macro that only gets defined by the Makefiles in the kernel.
>>>> This can be very confusing when switching between userspace
>>>> and kernelspace coding, or when dealing with uapi headers that
>>>> rather should use __ASSEMBLER__ instead. So let's standardize on
>>>> the __ASSEMBLER__ macro that is provided by the compilers now.
>>>>
>>>> This is a completely mechanical patch (done with a simple "sed -i"
>>>> statement).
>>>>
>>>> Cc: Jonas Bonn<jonas@southpole.se>
>>>> Cc: Stefan Kristiansson<stefan.kristiansson@saunalahti.fi>
>>>> Cc: Stafford Horne<shorne@gmail.com>
>>>> Cc:linux-openrisc@vger.kernel.org
>>>> Signed-off-by: Thomas Huth<thuth@redhat.com>
>>>> ---
>>>>    arch/openrisc/include/asm/mmu.h         | 2 +-
>>>>    arch/openrisc/include/asm/page.h        | 8 ++++----
>>>>    arch/openrisc/include/asm/pgtable.h     | 4 ++--
>>>>    arch/openrisc/include/asm/processor.h   | 4 ++--
>>>>    arch/openrisc/include/asm/ptrace.h      | 4 ++--
>>>>    arch/openrisc/include/asm/setup.h       | 2 +-
>>>>    arch/openrisc/include/asm/thread_info.h | 8 ++++----
>>>>    7 files changed, 16 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/arch/openrisc/include/asm/mmu.h b/arch/openrisc/include/asm/mmu.h
>>>> index eb720110f3a20..e7826a681bc4a 100644
>>>> --- a/arch/openrisc/include/asm/mmu.h
>>>> +++ b/arch/openrisc/include/asm/mmu.h
>>>> @@ -15,7 +15,7 @@
>>>>    #ifndef __ASM_OPENRISC_MMU_H
>>>>    #define __ASM_OPENRISC_MMU_H
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    typedef unsigned long mm_context_t;
>>>>    #endif
>>>> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
>>>> index c589e96035e15..85797f94d1d74 100644
>>>> --- a/arch/openrisc/include/asm/page.h
>>>> +++ b/arch/openrisc/include/asm/page.h
>>>> @@ -25,7 +25,7 @@
>>>>     */
>>>>    #include <asm/setup.h>
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>>>>    #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
>>>> @@ -55,10 +55,10 @@ typedef struct page *pgtable_t;
>>>>    #define __pgd(x)	((pgd_t) { (x) })
>>>>    #define __pgprot(x)	((pgprot_t) { (x) })
>>>> -#endif /* !__ASSEMBLY__ */
>>>> +#endif /* !__ASSEMBLER__ */
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
>>>>    #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
>>>> @@ -73,7 +73,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>>>>    #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
>>>> -#endif /* __ASSEMBLY__ */
>>>> +#endif /* __ASSEMBLER__ */
>>>>    #include <asm-generic/memory_model.h>
>>>>    #include <asm-generic/getorder.h>
>>>> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
>>>> index 60c6ce7ff2dcf..cd979bd28ab3b 100644
>>>> --- a/arch/openrisc/include/asm/pgtable.h
>>>> +++ b/arch/openrisc/include/asm/pgtable.h
>>>> @@ -23,7 +23,7 @@
>>>>    #include <asm-generic/pgtable-nopmd.h>
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    #include <asm/mmu.h>
>>>>    #include <asm/fixmap.h>
>>>> @@ -432,5 +432,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>>>    typedef pte_t *pte_addr_t;
>>>> -#endif /* __ASSEMBLY__ */
>>>> +#endif /* __ASSEMBLER__ */
>>>>    #endif /* __ASM_OPENRISC_PGTABLE_H */
>>>> diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
>>>> index e05d1b59e24e1..3ff893a67c13b 100644
>>>> --- a/arch/openrisc/include/asm/processor.h
>>>> +++ b/arch/openrisc/include/asm/processor.h
>>>> @@ -39,7 +39,7 @@
>>>>     */
>>>>    #define TASK_UNMAPPED_BASE      (TASK_SIZE / 8 * 3)
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    struct task_struct;
>>>> @@ -78,5 +78,5 @@ void show_registers(struct pt_regs *regs);
>>>>    #define cpu_relax()     barrier()
>>>> -#endif /* __ASSEMBLY__ */
>>>> +#endif /* __ASSEMBLER__ */
>>>>    #endif /* __ASM_OPENRISC_PROCESSOR_H */
>>>> diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
>>>> index e5a282b670757..28facf2f3e00c 100644
>>>> --- a/arch/openrisc/include/asm/ptrace.h
>>>> +++ b/arch/openrisc/include/asm/ptrace.h
>>>> @@ -27,7 +27,7 @@
>>>>     * they share a cacheline (not done yet, though... future optimization).
>>>>     */
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    /*
>>>>     * This struct describes how the registers are laid out on the kernel stack
>>>>     * during a syscall or other kernel entry.
>>>> @@ -147,7 +147,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
>>>>    	return *(unsigned long *)((unsigned long)regs + offset);
>>>>    }
>>>> -#endif /* __ASSEMBLY__ */
>>>> +#endif /* __ASSEMBLER__ */
>>>>    /*
>>>>     * Offsets used by 'ptrace' system call interface.
>>>> diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
>>>> index 9acbc5deda691..dce9f4d3b378f 100644
>>>> --- a/arch/openrisc/include/asm/setup.h
>>>> +++ b/arch/openrisc/include/asm/setup.h
>>>> @@ -8,7 +8,7 @@
>>>>    #include <linux/init.h>
>>>>    #include <asm-generic/setup.h>
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    void __init or1k_early_setup(void *fdt);
>>>>    #endif
>>>> diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
>>>> index 4af3049c34c21..e338fff7efb0e 100644
>>>> --- a/arch/openrisc/include/asm/thread_info.h
>>>> +++ b/arch/openrisc/include/asm/thread_info.h
>>>> @@ -17,7 +17,7 @@
>>>>    #ifdef __KERNEL__
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    #include <asm/types.h>
>>>>    #include <asm/processor.h>
>>>>    #endif
>>>> @@ -38,7 +38,7 @@
>>>>     * - if the contents of this structure are changed, the assembly constants
>>>>     *   must also be changed
>>>>     */
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    struct thread_info {
>>>>    	struct task_struct	*task;		/* main task structure */
>>>> @@ -58,7 +58,7 @@ struct thread_info {
>>>>     *
>>>>     * preempt_count needs to be 1 initially, until the scheduler is functional.
>>>>     */
>>>> -#ifndef __ASSEMBLY__
>>>> +#ifndef __ASSEMBLER__
>>>>    #define INIT_THREAD_INFO(tsk)				\
>>>>    {							\
>>>>    	.task		= &tsk,				\
>>>> @@ -75,7 +75,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
>>>>    #define get_thread_info(ti) get_task_struct((ti)->task)
>>>>    #define put_thread_info(ti) put_task_struct((ti)->task)
>>>> -#endif /* !__ASSEMBLY__ */
>>>> +#endif /* !__ASSEMBLER__ */
>>>>    /*
>>>>     * thread information flags
>>>> -- 2.48.1
>>>>
>>>
>>> Friendly ping!
>>>
>>> Jonas, Stefan, Stafford, could you maybe pick this (and the previous patch)
>>> up via your openrisc tree? (x86 and parisc already got merge via their
>>> respective architecture trees, so I guess the same should happen for this
>>> patch here, too).
>>
>> Hi Thomas,
>>
>> Sure, this might not make it for the 6.16 merge window as we may not have time
>> for it to have a cycle in linux-next.  Is that ok?
> 
> I have now put this in the OpenRISC queue.  Note, I didn't pay much attention to
> this series as it seemed generally OK to me and usually I figured these trivial
> treewide patches should be merged via other means.
> 
> I expect it will take time to get all maintainers pick these up individually.
> 
> Do you have a plan for those?  In the past I think Arnd has helped.

I need to respin a couple of patches (s390x, powerpc, ...) since the headers 
have already changed in the related spots, so I'm going to send those to the 
respective maintainers when I'm done. Once those got merged, I guess I'm 
going to respin the remaining patches and ask Arnd for help...

  Thomas

