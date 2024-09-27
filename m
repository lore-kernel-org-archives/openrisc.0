Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47058A920;
	Fri, 27 Sep 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460835; cv=none; b=Z+JZbw0SHdOk+gO4PMCrNSTAJenRLyBlwDwgg/yzqFS1yaIUXW93/+p4mUOusKxKWqNHRvLfoWhD9MWdOuZNze/LvDvhrpZP89zw22uajFHzbFfZIVr7y3fE87wyN/9u0m+abUGA5QF1rjN2XMCaPT5m2o8UMj/0FlcK1Ku6eSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460835; c=relaxed/simple;
	bh=Ua7Hr48tvw5jiMe2TCvC4ps3WxHz9R0/akpdNnbS+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcfjencAv4AFI+oIgqi2usrF6zkzYR7/6J9onH3bji0DGvcU0HsqK3H7YFwu5X48KI8tJ/zWFg7rbzLhYbP9jDzZw72LYqSHTOJhl7cTJIE8GwnbuysyOGC0aPOLPsqzTxSZPOQFq3HmGbGUrxyckSNi/oJba0AeL5AFEdzsse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVtxAHxt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVtxAHxt"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d24f98215so336304966b.1;
        Fri, 27 Sep 2024 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727460831; x=1728065631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMh1wsuBEnviiw/fMS3appjxywKHjPB2yLUQ8VlmSOg=;
        b=FVtxAHxt1ZFjhQX29aHR00S2LHj7ZRMqFyGQrHjCzrKYzK66bxTkYrX3/j0TVBy9HQ
         o9N1vwnLcBoI86NBfJKZNMzfxsuvTk0fYhSTt/qMsQqIuresEVUlrHuk5NQCUKyfaAhE
         YMOVUkQF6UhAdhG9Y5CoclNoQQYZ3MgN+FM4XHURpP7gCNHF2QnLR/BwcHhIQx5UARu2
         heIgAbVX5wuNutNJcQ7gydYGGWfGbEBa0M4q0kHa2HtbGBujnkHYilUd/hAmyhFMljkj
         eMBKqZLkufWgBQXeluVEMOOzbfoSqhHzq3JMnU+ylPJo5eVj0QXEaLWEakE0AOhBvQYI
         fd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727460831; x=1728065631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMh1wsuBEnviiw/fMS3appjxywKHjPB2yLUQ8VlmSOg=;
        b=xPYQiNl/1F8ji6+xuQH0R5kASr13AAq3Orx42HGio3TPeEQ9AvXRkRygRxPnXZByQk
         8bKnlfquqjzYq1jM1tE+d5H6LTbzgaMRaED99RdQJw1dYkfKGmRRvF3zvIFM0I97f6II
         uw2OLPxzRfNFqbyLiDf4z+pmmtbvnv/wZzo0hv5hraQIOTNASmtWXUjx5NvXYJcN/p/a
         ImZmnU3AAeI45SjmmtFjPnn+NEPqoncjpW+ZPQxLE8eRf5bCRAGEiMfJnKPH7sFh00RE
         AYqRmp5hX/ntxiHVl26l3EaOL4B6rVHwlfL07EAiSJ0IvmYWfLecizcgRe9W1nm0bQHP
         Mozg==
X-Forwarded-Encrypted: i=1; AJvYcCVk8v/oFUllhBK7HC8J7B64/39tKdQdtOKgM8XW1+yqON/KNVIaiJwpO4KQMQMB97LfeV1VWkmZLBYGTd2qFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHo5emqzeqSatD6aV8NK7WvguybjJ15tWW2n6wMgvfoaWGqX9U
	bcghggFR2jtMh9ZYDyUC/etMhaL6MpB6zo71mXl/5S4+KZmk7OIjRIAUlLckofo=
X-Google-Smtp-Source: AGHT+IG1+/yjBpMAE+af8roU4Y7m7NbdN4eH8KjLFEnE7KFYorjYj91etQorv4uEYKkOuthvza2ATg==
X-Received: by 2002:a17:907:6e9f:b0:a8d:f04:b19b with SMTP id a640c23a62f3a-a93c48e8f07mr430864066b.2.1727460830487;
        Fri, 27 Sep 2024 11:13:50 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2776dc6sm161142966b.6.2024.09.27.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 11:13:49 -0700 (PDT)
Date: Fri, 27 Sep 2024 19:13:48 +0100
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Dawei Li <set_pte_at@outlook.com>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH] openrisc: Implement fixmap to fix eralycon
Message-ID: <Zvb13DaEakOFD5UG@antec>
References: <20240927145700.1963518-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927145700.1963518-1-shorne@gmail.com>

Review from myself, I sent this one out pretty quickly just to get some
conversation started.

In the subject if should be 'earlycon' no 'eralycon'.

On Fri, Sep 27, 2024 at 03:56:56PM +0100, Stafford Horne wrote:
> With commit 53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap
> code") it was commented that early ioremap was not used in OpenRISC.  I
> acked this but was wrong.  Earlycon now fails with the below trace:
..
>
> To fix this we could either implement early_ioremap or implement fixmap.
> In this patch we choose the later option of implementing basic fixmap
> support.
> 
> While fixing this we also remove the old FIX_IOREMAP slots that were
> used by early ioremap code.  That code was also removed by commit
> 53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap code") but
> these definitions were not cleaned up.
> 
> Fixes: 53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap code")
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/Kconfig              |  3 +++
>  arch/openrisc/include/asm/fixmap.h | 21 +++++-------------
>  arch/openrisc/mm/init.c            | 34 ++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 69c0258700b2..3279ef457c57 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -65,6 +65,9 @@ config STACKTRACE_SUPPORT
>  config LOCKDEP_SUPPORT
>  	def_bool  y
>  
> +config FIX_EARLYCON_MEM
> +	def_bool y
> +
>  menu "Processor type and features"
>  
>  choice
> diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
> index ecdb98a5839f..aaa6a26a3e92 100644
> --- a/arch/openrisc/include/asm/fixmap.h
> +++ b/arch/openrisc/include/asm/fixmap.h
> @@ -26,29 +26,18 @@
>  #include <linux/bug.h>
>  #include <asm/page.h>
>  
> -/*
> - * On OpenRISC we use these special fixed_addresses for doing ioremap
> - * early in the boot process before memory initialization is complete.
> - * This is used, in particular, by the early serial console code.
> - *
> - * It's not really 'fixmap', per se, but fits loosely into the same
> - * paradigm.
> - */
>  enum fixed_addresses {
> -	/*
> -	 * FIX_IOREMAP entries are useful for mapping physical address
> -	 * space before ioremap() is useable, e.g. really early in boot
> -	 * before kmalloc() is working.
> -	 */
> -#define FIX_N_IOREMAPS  32
> -	FIX_IOREMAP_BEGIN,
> -	FIX_IOREMAP_END = FIX_IOREMAP_BEGIN + FIX_N_IOREMAPS - 1,
> +	FIX_EARLYCON_MEM_BASE,
>  	__end_of_fixed_addresses
>  };
>  
>  #define FIXADDR_SIZE		(__end_of_fixed_addresses << PAGE_SHIFT)
>  /* FIXADDR_BOTTOM might be a better name here... */
>  #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
> +#define FIXMAP_PAGE_IO		PAGE_KERNEL_NOCACHE
> +
> +extern void __set_fixmap(enum fixed_addresses idx,
> +			 phys_addr_t phys, pgprot_t flags);
>  
>  #include <asm-generic/fixmap.h>
>  
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 1dcd78c8f0e9..7397d18c95d7 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -207,6 +207,40 @@ void __init mem_init(void)
>  	return;
>  }
>  
> +static int __init map_page(unsigned long va, phys_addr_t pa, int flags)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pd;
> +	pte_t *pg;
> +	int err = -ENOMEM;
> +
> +	p4d = p4d_offset(pgd_offset_k(va), va);
> +	pud = pud_offset(p4d, va);
> +	pd = pmd_offset(pud, va);
> +	pg = pte_alloc_kernel(pd, va);
> +
> +	if (pg != NULL) {
> +		err = 0;
> +		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
> +				__pgprot(flags)));

We maybe need to do something like flush tlb here, but since this is only used
by earlycon and before any io access is made it may be ok.

> +	}
> +	return err;
> +}
> +
> +void __init __set_fixmap(enum fixed_addresses idx,
> +			 phys_addr_t phys, pgprot_t prot)
> +{
> +	unsigned long address = __fix_to_virt(idx);
> +
> +	if (idx >= __end_of_fixed_addresses) {
> +		BUG();
> +		return;
> +	}
> +
> +	map_page(address, phys, pgprot_val(prot));
> +}
> +
>  static const pgprot_t protection_map[16] = {
>  	[VM_NONE]					= PAGE_NONE,
>  	[VM_READ]					= PAGE_READONLY_X,
> -- 
> 2.44.0
> 
