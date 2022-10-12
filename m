Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B7C4332F
	for <openrisc@archiver.kernel.org>; Wed, 12 Oct 2022 16:47:47 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 198F524B2E;
	Wed, 12 Oct 2022 18:47:46 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mail.librecores.org (Postfix) with ESMTPS id 27E3B24B2A
 for <openrisc@lists.librecores.org>; Wed, 12 Oct 2022 18:47:45 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id j16so27078972wrh.5
 for <openrisc@lists.librecores.org>; Wed, 12 Oct 2022 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bkYwffHoTj+UGeb69vyYv3Vi6xsZterM+r8p4HSwk3k=;
 b=qt8qxQtSMmPSznXRe9pn8HRdFJaewZGwEj1d2XqeJIUx7fTdVWUet+16K0OFzpIWK6
 Zk5upGfpxB93/w9tOsCA58VK11SJPgjbhNfiqAMe9K5nBOeFP7FusCxGHEYKFmUke4b/
 tJRSixQsn1aCq2/YKwKNDqFFhAt4Xek2mA+DovqEa/pSJ4PqV0CNRLDTdYAol3bESito
 y+A4DoxRkyPPRL4gG+R3UHZhAkPHviiSgz6gRsD7K0aMdi4hn/ReQf9ke+vM6TW5GEuN
 wsHEWUBDeB5vZm1+IwtfJbyF4nfih/t790IREmOraOJFifaG+hVDFMpPjH/wX9142rvs
 XmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkYwffHoTj+UGeb69vyYv3Vi6xsZterM+r8p4HSwk3k=;
 b=NFtB2t0LPTSEg1CAayejqhR7wCtpvk6N3k0hi8BWuyHVbmSQShT4JQqjzTYuWXLiGx
 2UjBN+lT2Qs2CczvRbTGY/wFO4PLJJjYsfQ+P8CHmlIi4oe7SKo3FTQrwsmwvs/3N7GX
 CI3CrWYw7yik4xwFgXWtGjGd/3m2o7ceNr6qq3gw2ZqD52Sr1kJe7oCkYZw8zi8hBJE1
 /N8B/OghM9351nGvohbSvDfnzmpWEgu+JdHB4XZWgPSYIR65pvgJ7hhxDR9p0MXBjemm
 mU6ueNSv0g7fx/GVFQT26hCtD0OYEWEnGSH0FAxGrXA+Dgm7nIcq1qNiC9qePpWGPDM+
 XA9w==
X-Gm-Message-State: ACrzQf1FipbNe+4DEcieGJh3cyo5z190r0WOVXsQLWOU18idV7ja0hJc
 UPxxOupry7EyPWXdWu6ukdA=
X-Google-Smtp-Source: AMsMyM5QG/hbTP0GgOdpLWkfLu7at/Wgl1M2fr1LZcGBYHj6q7svLrd3xOaQiLDwa/S213jc6sDvfA==
X-Received: by 2002:a05:6000:10d1:b0:22e:3bc5:c91c with SMTP id
 b17-20020a05600010d100b0022e3bc5c91cmr18250079wrx.368.1665593264626; 
 Wed, 12 Oct 2022 09:47:44 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c065600b003c6c2ff7f25sm2056959wmm.15.2022.10.12.09.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 09:47:44 -0700 (PDT)
Date: Wed, 12 Oct 2022 16:47:43 +0000
From: Stafford Horne <shorne@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH 2/8] openrisc: mm: remove unneeded early ioremap code
Message-ID: <Y0bvr/gKaKYd7ur2@oscomms1>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <9010e8719949cce376dc3f75a97b8bfb2ff98442.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9010e8719949cce376dc3f75a97b8bfb2ff98442.1665568707.git.christophe.leroy@csgroup.eu>
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
Cc: linux-arch@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
 wangkefeng.wang@huawei.com, Baoquan He <bhe@redhat.com>,
 schnelle@linux.ibm.com, linux-kernel@vger.kernel.org, hch@infradead.org,
 linux-mm@kvack.org, David.Laight@aculab.com, akpm@linux-foundation.org,
 agordeev@linux.ibm.com, openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Oct 12, 2022 at 12:09:38PM +0200, Christophe Leroy wrote:
> From: Baoquan He <bhe@redhat.com>
> 
> Under arch/openrisc, there isn't any place where ioremap() is called.
> It means that there isn't early ioremap handling needed in openrisc,
> So the early ioremap handling code in ioremap() of
> arch/openrisc/mm/ioremap.c is unnecessary and can be removed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org

Thanks for picking this up.

Perhaps add this link?

Link: https://lore.kernel.org/linux-mm/YwxfxKrTUtAuejKQ@oscomms1/

But either way.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/mm/ioremap.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index 8ec0dafecf25..90b59bc53c8c 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -22,8 +22,6 @@
>  
>  extern int mem_init_done;
>  
> -static unsigned int fixmaps_used __initdata;
> -
>  /*
>   * Remap an arbitrary physical address space into the kernel virtual
>   * address space. Needed when the kernel wants to access high addresses
> @@ -52,24 +50,14 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
>  	p = addr & PAGE_MASK;
>  	size = PAGE_ALIGN(last_addr + 1) - p;
>  
> -	if (likely(mem_init_done)) {
> -		area = get_vm_area(size, VM_IOREMAP);
> -		if (!area)
> -			return NULL;
> -		v = (unsigned long)area->addr;
> -	} else {
> -		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> -			return NULL;
> -		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> -		fixmaps_used += (size >> PAGE_SHIFT);
> -	}
> +	area = get_vm_area(size, VM_IOREMAP);
> +	if (!area)
> +		return NULL;
> +	v = (unsigned long)area->addr;
>  
>  	if (ioremap_page_range(v, v + size, p,
>  			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> -		if (likely(mem_init_done))
> -			vfree(area->addr);
> -		else
> -			fixmaps_used -= (size >> PAGE_SHIFT);
> +		vfree(area->addr);
>  		return NULL;
>  	}
>  
> -- 
> 2.37.1
> 
