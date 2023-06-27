Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E2FC0015E;
	Tue, 27 Jun 2023 16:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF0QIh (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 27 Jun 2023 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjF0QIg (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 27 Jun 2023 12:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD92E2D69
        for <linux-openrisc@vger.kernel.org>; Tue, 27 Jun 2023 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687882067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJDOCrbidQ6SQFQe4MgEFJjZ7UTNPrXFah4ZUMjVF/Y=;
        b=cHLQzf/baVLa3PFs+uOt0nvslid1TI9PIM04ed6bePP+ILxYbUc9cVcA8dIkE9LXhwjzN+
        96zsrYb9XYoix3wmlIuds3wzBcfHwgvMCLpH0+t+LRj1OYDPYNSC/AhtvBGt8bEvvKNi+s
        c9g5mnGYrrWVwJOwKKHh16e5N4D4cgs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-PyxeOjZSN_aYSm0Bt8vbIA-1; Tue, 27 Jun 2023 12:07:46 -0400
X-MC-Unique: PyxeOjZSN_aYSm0Bt8vbIA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765ad67e690so36465185a.1
        for <linux-openrisc@vger.kernel.org>; Tue, 27 Jun 2023 09:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882066; x=1690474066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJDOCrbidQ6SQFQe4MgEFJjZ7UTNPrXFah4ZUMjVF/Y=;
        b=KU5ME6lgHwDUIkLCGq6cBruIPBN0glKlQsy8y4IHHYYWO3cBDULfysrL5/e5dIhAf9
         HoblgN9Ab2LuZs2RuffcnRTWNnb9aaaOOr2KyX33ND2f5mR1hMvEbFq/07qX6fwPd8n2
         hpW/1zxHZ3gzmMGGBh1lPf0c/WKyuJuOo5XC/YW2whGgm9UzXRtB0EJhx0lcwu7Jnjb8
         wNbs0hti8HYBrvONYo9ppKw6XKFyDFNRKNXoL5hwl6NY/1fIt7/EsabJp1OrMKfXz+Bs
         cMvGHg9fN6t4oyCvyfcoiEuNUIwGtGnqaBNT+ZlEYu7SiTRFRNN1ycH77h4N/4KICKJh
         qbAg==
X-Gm-Message-State: AC+VfDxO8qkK3wUeXL6jjKpRON41TSX7CieHB+2jl84xyD7XL7VTaBS7
        /F3aMw4lZGM7EoTlzRuyaWUjeYI/6ft8b8wwVqW8piJRhDobsktT9o+NloKpNtnAaO0qe69gM2H
        RrIWGSZAzqJzuw1UgDD6prO0QkqQ=
X-Received: by 2002:a05:620a:4007:b0:765:7b61:46fc with SMTP id h7-20020a05620a400700b007657b6146fcmr12614183qko.7.1687882066189;
        Tue, 27 Jun 2023 09:07:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UY1eApNq4tXkhQSQVDzyCNrRRXMA0KLJ6oWun1WyljocOJD3jbWnq1iikbRngPAZ/IFjT9Q==
X-Received: by 2002:a05:620a:4007:b0:765:7b61:46fc with SMTP id h7-20020a05620a400700b007657b6146fcmr12614153qko.7.1687882065917;
        Tue, 27 Jun 2023 09:07:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id m21-20020a05620a13b500b0075ecdc937ffsm1342302qki.41.2023.06.27.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:07:45 -0700 (PDT)
Date:   Tue, 27 Jun 2023 12:07:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 03/33] pgtable: Create struct ptdesc
Message-ID: <ZJsJT9dLtxaKlxVb@x1n>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <20230627031431.29653-4-vishal.moola@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20230627031431.29653-4-vishal.moola@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Mon, Jun 26, 2023 at 08:14:01PM -0700, Vishal Moola (Oracle) wrote:
> Currently, page table information is stored within struct page. As part
> of simplifying struct page, create struct ptdesc for page table
> information.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  include/linux/pgtable.h | 68 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5063b482e34f..d46cb709ce08 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -987,6 +987,74 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
>  #endif /* CONFIG_MMU */
>  
> +
> +/**
> + * struct ptdesc -    Memory descriptor for page tables.
> + * @__page_flags:     Same as page flags. Unused for page tables.
> + * @pt_rcu_head:      For freeing page table pages.
> + * @pt_list:          List of used page tables. Used for s390 and x86.
> + * @_pt_pad_1:        Padding that aliases with page's compound head.
> + * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
> + * @_pt_s390_gaddr:   Aliases with page's mapping. Used for s390 gmap only.

Should some arch-specific bits (and a few others) always under some
#ifdefs, so it shouldn't appear on other archs?

> + * @pt_mm:            Used for x86 pgds.
> + * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
> + * @ptl:              Lock for the page table.
> + * @__page_type:      Same as page->page_type. Unused for page tables.
> + * @_refcount:        Same as page refcount. Used for s390 page tables.
> + * @pt_memcg_data:    Memcg data. Tracked for page tables here.
> + *
> + * This struct overlays struct page for now. Do not modify without a good
> + * understanding of the issues.
> + */
> +struct ptdesc {
> +	unsigned long __page_flags;
> +
> +	union {
> +		struct rcu_head pt_rcu_head;
> +		struct list_head pt_list;
> +		struct {
> +			unsigned long _pt_pad_1;
> +			pgtable_t pmd_huge_pte;
> +		};
> +	};
> +	unsigned long _pt_s390_gaddr;
> +
> +	union {
> +		struct mm_struct *pt_mm;
> +		atomic_t pt_frag_refcount;
> +	};
> +
> +	union {
> +		unsigned long _pt_pad_2;
> +#if ALLOC_SPLIT_PTLOCKS
> +		spinlock_t *ptl;
> +#else
> +		spinlock_t ptl;
> +#endif
> +	};
> +	unsigned int __page_type;
> +	atomic_t _refcount;
> +#ifdef CONFIG_MEMCG
> +	unsigned long pt_memcg_data;
> +#endif
> +};

-- 
Peter Xu

