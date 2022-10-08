Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A8C433FE
	for <openrisc@archiver.kernel.org>; Sat,  8 Oct 2022 05:07:39 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0D5B12488F;
	Sat,  8 Oct 2022 07:07:39 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mail.librecores.org (Postfix) with ESMTPS id DB8512490E
 for <openrisc@lists.librecores.org>; Sat,  8 Oct 2022 07:07:36 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id r13so9839979wrj.11
 for <openrisc@lists.librecores.org>; Fri, 07 Oct 2022 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3W0V9Lvp6JyEFIeTyCKRLPg4UP1sFJYY2e9mMECgn9s=;
 b=XYDOTqXcDFFXJVm439mYCJdcu020rpE2/ke8xpn9Bf1ClCYomiUcQlBjCC4HiRh7lN
 dugGVT2gF7TrgGIdyYZnG/HbCcB522ACPKkTSCO8QlZwXwqduVYharJAQ7d+h7b2oprK
 qLysk9lvXaoDZJOF86ad41A3X2QXyRGrvQ+TA7IojsORI88cquj4OEC1J5NYbH0kWal2
 b6LBbgy2RI2XdYepKrVP/qP7vP+U83MlW3iHmONQuRj7ALILGG/2nGVWkxxEkUF2I5LJ
 15kLGcaumnv656scTtf68q1oOXiOeQxsMr87ZCdPskcyj7nePVZnCkh8oxzG040u9Ovc
 CBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3W0V9Lvp6JyEFIeTyCKRLPg4UP1sFJYY2e9mMECgn9s=;
 b=PHhYFajxC6DYfo5RsVIEFnwtiS2JBf7dwsBoK6KarGf4Mvma5EKXZtQhoYtc23zTPl
 PVOG17YyXnJiJBRFgAIG7mUXnVZfIHQFQVEpvOnZqcyMrdrGEKpqhEuGGWvVCKDW8gvd
 StHjm1v25bS+CakEdfipq/Q5UrlZ32hu3bVDqKwjWKBENS2L9RN7QUoeujAqD7Ma8gzt
 lkBfym2gm1A8ylB4MtDEfYu5p60FEPqKJlZ2qYPR4fyfJTm8QP1LApewFJojCejsCzkC
 mylR+t6UIe/8bI79FNDJYWYmweL1+uYzw91Z/fxtSsgAwR7IuBUB9BZHx7C9uw1/SXJH
 xMUw==
X-Gm-Message-State: ACrzQf3C38t6ZsLxHJDMuOFLtglOoFFaVtK0sAr/5rbfm/QQtBAjYXgr
 rtdETTpnFSO2/9uS9z7BNew=
X-Google-Smtp-Source: AMsMyM5myXp2PJMzpKZCUQqGwF3Wq98VZGDgJjiyPUnI3j9hi+SK6RmAGzsSYfcL5i1XoQH+JXMx/w==
X-Received: by 2002:adf:edd1:0:b0:22e:5257:a19e with SMTP id
 v17-20020adfedd1000000b0022e5257a19emr4905173wro.180.1665205656287; 
 Fri, 07 Oct 2022 22:07:36 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a5d4303000000b0022e0580b7a9sm3604624wrq.17.2022.10.07.22.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Oct 2022 22:07:34 -0700 (PDT)
Date: Sat, 8 Oct 2022 05:07:34 +0000
From: Stafford Horne <shorne@gmail.com>
To: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] openrisc: Fix pagewalk usage in
 arch_dma_{clear,set}_uncached
Message-ID: <Y0EFllJ8uisQOWfv@oscomms1>
References: <20221006183301.1891131-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006183301.1891131-1-jannh@google.com>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Oct 06, 2022 at 08:33:01PM +0200, Jann Horn wrote:
> Since commit 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page
> walker"), walk_page_range() on kernel ranges won't work anymore,
> walk_page_range_novma() must be used instead.
> 
> Note: I don't have an openrisc development setup, so this is completely
> untested.
> 
> Fixes: 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker")
> Signed-off-by: Jann Horn <jannh@google.com>

This looks good to me, I will queue it for 6.1 fixes.

> ---
> Normally I would CC stable on a patch like this, but openrisc is mostly an
> in-development thing, so fixing stable kernels doesn't matter much, I assume?

In general we try to keep stable releases stable buy backporting OpenRISC patches
as well.  Just having the 'Fixes' tag should trigger to get this patched
backported to stable.  We should at least cc the LKML though.

-Stafford

>  arch/openrisc/kernel/dma.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index a82b2caaa560d..b3edbb33b621d 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -74,10 +74,10 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
>  	 * We need to iterate through the pages, clearing the dcache for
>  	 * them and setting the cache-inhibit bit.
>  	 */
> -	mmap_read_lock(&init_mm);
> -	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
> -			NULL);
> -	mmap_read_unlock(&init_mm);
> +	mmap_write_lock(&init_mm);
> +	error = walk_page_range_novma(&init_mm, va, va + size,
> +			&set_nocache_walk_ops, NULL, NULL);
> +	mmap_write_unlock(&init_mm);
>  
>  	if (error)
>  		return ERR_PTR(error);
> @@ -88,11 +88,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
>  {
>  	unsigned long va = (unsigned long)cpu_addr;
>  
> -	mmap_read_lock(&init_mm);
> +	mmap_write_lock(&init_mm);
>  	/* walk_page_range shouldn't be able to fail here */
> -	WARN_ON(walk_page_range(&init_mm, va, va + size,
> -			&clear_nocache_walk_ops, NULL));
> -	mmap_read_unlock(&init_mm);
> +	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
> +			&clear_nocache_walk_ops, NULL, NULL));
> +	mmap_write_unlock(&init_mm);
>  }
>  
>  void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
> 
> base-commit: 7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
