Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6B17623F
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Oct 2024 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971074; cv=none; b=MoVbOAcrL5M1+HP1URT6/aGvDsCIYlbwZ4+P52jxy1LL0HQHSYV4NVXkbZUuV87tcKmFxdssl5uDFmiN2W/AiKGvDjAyotWWKSmQ0lULhkDRxyRkwulZS2/FIgtjPiy87ZATbYezLAnJUhugCEwy7fUxk+IaN7ODFrRqZL2yK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971074; c=relaxed/simple;
	bh=q/YuYoJtkGMscUSXLS8goVgt9nKzbq0PN/p0QP0L4oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcPMkcmn/FEE9nfrZygSsdD/U3SO7szNZ2tOwMhNNWPDei6EJoOkn+zeHv8f9o28HHneu8cOtVoFfVbIBUkM/hcJyZBekkEMbJ6CZFOMaOL1zTwSXSH6LvQQpSW/UaHeBUJHTnqCU5oqRLaPVIjpaCOFTU8dX1GP+Lo491GEiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEiYZMcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEiYZMcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728971070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rqDVypNeTlyROBtcFAcxa7fIkYW5RvLiVqxfFzE+jtk=;
	b=bEiYZMcf8orkE61PE6khv0yOejz3sTQoTbaDzuJtSrpfI0yqWG1Pxyae5Tl4idJju3POWI
	CClOaxEuenScdEepns39VZ+R/8HKqb1nDCOTKesV6qRJrfvNO4aKAYnn6vXZLm+IE+V3Co
	/L5ycIBv5reDj9kBQmZFtWGSjbwXfFE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-KIKW7qXYOQeOQXxkwNkzSg-1; Tue, 15 Oct 2024 01:44:29 -0400
X-MC-Unique: KIKW7qXYOQeOQXxkwNkzSg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c9217064f6so3841645a12.3
        for <linux-openrisc@vger.kernel.org>; Mon, 14 Oct 2024 22:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728971068; x=1729575868;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqDVypNeTlyROBtcFAcxa7fIkYW5RvLiVqxfFzE+jtk=;
        b=PvbBbOduRBYs7Pk64751aGOLAorbDNzN7DtbCTBHYxZKpGoMUIaNhX2kkm8AD2jqVz
         JuQfMn3q2RLsvdf1JUbhRRdC/pGUxtVj/KnINV0qsNrJFu1ZzBwOqR4g8JFlmUCc8sBf
         i0tMALDqCwFbjAMkCHf9oDp/QOZ5AmsnGrpj1uGzBD+zyvUqB6SnvEiY9c8tmqX9UlTN
         AGFku5k9yARXELKDulAN98RS3JSdLFQlPIM/834UBYFgIyGJagyvh9SS0t41l2OIo1f/
         gYvvA6ZXIrwqfu7TfzWROenmapL3YqJLQlLnG7pqGDq5dGZTnW27ofhjUxOTz5hizPv5
         Vezw==
X-Forwarded-Encrypted: i=1; AJvYcCVulzCz68jiQ8QM7oI6+08WCM2zY0O4I5PeoAKJ0Z/0bNPO2rSoJ8gB5kdkJgq2kBE2sx/8koDwQL9favOaLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JrxnNbdaWYz2RBkfnED62kI+xEFO6MVha20eqmzAXb8rDSCX
	yqERWe+zoeB7LiX4doVbFgdmq6ZeV5h9cI2pKg5IBJwhSq62gKU9Qfn2hZToTsPCfnnYdHkEBwm
	0G/LWKICRkXlgoPy1TO7vHlE0olxGXkf8+3+p12iqSrqNTSnw06bYLano13+EQlkm+nmEJ+cL3N
	Q=
X-Received: by 2002:a05:6402:2547:b0:5c9:5dff:c059 with SMTP id 4fb4d7f45d1cf-5c95dffc856mr6694739a12.33.1728971067795;
        Mon, 14 Oct 2024 22:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHphJL5D9sYrOvCoKG6zISeYBgA11R+H0fJZX97o5TSea54XK259kqw1/JPqXeoKRwu0LnFcw==
X-Received: by 2002:a05:6402:2547:b0:5c9:5dff:c059 with SMTP id 4fb4d7f45d1cf-5c95dffc856mr6694718a12.33.1728971067197;
        Mon, 14 Oct 2024 22:44:27 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-109.web.vodafone.de. [109.42.48.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d7b7a96sm283304a12.93.2024.10.14.22.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 22:44:26 -0700 (PDT)
Message-ID: <c5c5f85b-06aa-46c1-8a2f-439ae5e90f11@redhat.com>
Date: Tue, 15 Oct 2024 07:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] asm-generic: add an optional pfn_valid check to
 pfn_valid
To: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org
References: <20241014144506.51754-1-hch@lst.de>
 <20241014144506.51754-3-hch@lst.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241014144506.51754-3-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 16.44, Christoph Hellwig wrote:
> page_to_pfn is usually implemented by pointer arithmetics on the memory
> map, which means that bogus input can lead to even more bogus output.
> 
> Powerpc had a pfn_valid check on the regult to it's page_to_phys

s/regult/result/

> implementation when CONFIG_DEBUG_VIRTUAL is defined, which seems
> generally useful, so add that to the generic version.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/asm-generic/memory_model.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
> index a73a140cbecdd7..6d1fb6162ac1a6 100644
> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -64,7 +64,17 @@ static inline int pfn_valid(unsigned long pfn)
>   #define page_to_pfn __page_to_pfn
>   #define pfn_to_page __pfn_to_page
>   
> +#ifdef CONFIG_DEBUG_VIRTUAL
> +#define page_to_phys(page)						\
> +({									\
> +	unsigned long __pfn = page_to_pfn(page);			\
> +									\
> +	WARN_ON_ONCE(!pfn_valid(__pfn));				\
> +	PFN_PHYS(__pfn);						\
> +})
> +#else
>   #define page_to_phys(page)	PFN_PHYS(page_to_pfn(page))
> +#endif /* CONFIG_DEBUG_VIRTUAL */
>   #define phys_to_page(phys)	pfn_to_page(PHYS_PFN(phys))
>   
>   #endif /* __ASSEMBLY__ */

With the typo fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>

