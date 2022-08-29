Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C975EECAAD4
	for <openrisc@archiver.kernel.org>; Mon, 29 Aug 2022 08:18:41 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A1DFF248E8;
	Mon, 29 Aug 2022 10:18:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id 08C5924994
 for <openrisc@lists.librecores.org>; Mon, 29 Aug 2022 10:18:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661761118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDag/OyOW5J2lHZGYxPXL7WM7zq/jil/fCsPlf3BqyI=;
 b=KVcqMKJSrTzu6wMWPq2dTTmzUAqhc2eJYqbC2DCUDaXyLiZLEEMM6x20bAAqKB9u6r8Yyr
 8/mL18sD3fOGzgT8rTyDpw3SvexVzQaNuZpZQph+IYZcTA7Jc+GUr8mub40Ls6tcd1iW9M
 MZ7pMxVnDbuNcF9CCkGM+/Dr/m2psB8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-4rDcRiYtPEGtt-VtKCIOuA-1; Mon, 29 Aug 2022 04:18:34 -0400
X-MC-Unique: 4rDcRiYtPEGtt-VtKCIOuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D338C3C0E201;
 Mon, 29 Aug 2022 08:18:33 +0000 (UTC)
Received: from localhost (ovpn-12-153.pek2.redhat.com [10.72.12.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7847C4011A58;
 Mon, 29 Aug 2022 08:18:31 +0000 (UTC)
Date: Mon, 29 Aug 2022 16:18:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <Ywx2U3NpfH/Ixg6V@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
 <YwHYx0eXouIWnN8Z@infradead.org> <YwwZCO279Vh/cXGW@MiWiFi-R3L-srv>
 <YwxfxKrTUtAuejKQ@oscomms1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwxfxKrTUtAuejKQ@oscomms1>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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
Cc: Jonas Bonn <jonas@southpole.se>, wangkefeng.wang@huawei.com,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, openrisc@lists.librecores.org, akpm@linux-foundation.org,
 agordeev@linux.ibm.com, linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 08/29/22 at 06:42am, Stafford Horne wrote:
> On Mon, Aug 29, 2022 at 09:40:24AM +0800, Baoquan He wrote:
> > On 08/21/22 at 12:03am, Christoph Hellwig wrote:
> > > > +	if (unlikely(!mem_init_done)) {
> > > >  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> > > > +			return IOMEM_ERR_PTR(ret);
> > > >  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> > > >  		fixmaps_used += (size >> PAGE_SHIFT);
> > > >  
> > > > +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
> > > >  			fixmaps_used -= (size >> PAGE_SHIFT);
> > > > +			return IOMEM_ERR_PTR(ret);
> > > > +		}
> > > > +
> > > > +		return (void __iomem *)(offset + (char *)v);
> > > >  	}
> > > 
> > > This code needs to go away, and all very early boot uses of ioremap
> > > need to switch to use early_ioremap insted.
> > 
> > Makes sense. On openrisc, the thing is I didn't find one place where
> > ioremap() is called in arch code. I can cut the early ioremap out and
> > wrap into a separate early_ioremap() function, however I don't know
> > where to put it. Not sure if I miss anything or openrisc doesn't really
> > need early ioremap.
> 
> Hi,
> 
> I don't know of any early_ioremap usage either in openrisc, maybe some drivers
> use it?  However, we do not initialize any early_ioremap infrastructure in
> openrisc so that may cause issues if it is used.

The variable mem_init_done indicates if mem_init() is called or not.
Driver should only initialize after mem_init(). With my understanding,
the early ioremap is only needed by arch code.
> 
> We can try to remove it all.  I tested these below additional changes and they
> work, if you want to add them we can see if kbuild robots pick anything up.

Very helpful information. Then I will remove the !mem_init_done part
code as you listed below, let's see how test robots react. Thanks a lot.

> 
> -Stafford
> 
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index bc41660e1fb0..ffe6d5e2b5fe 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -22,14 +22,10 @@
>  
>  extern int mem_init_done;
>  
> -static unsigned int fixmaps_used __initdata;
> -
>  void __iomem *
>  arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
>  {
> -       phys_addr_t p;
> -       unsigned long v;
> -       unsigned long offset, last_addr, addr = *paddr;
> +       unsigned long last_addr, addr = *paddr;
>         int ret = -EINVAL;
>  
>         /* Don't allow wraparound or zero size */
> @@ -37,27 +33,6 @@ arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
>         if (!size || last_addr < addr)
>                 return IOMEM_ERR_PTR(ret);
>  
> -       /*
> -        * Mappings have to be page-aligned
> -        */
> -       offset = addr & ~PAGE_MASK;
> -       p = addr & PAGE_MASK;
> -       size = PAGE_ALIGN(last_addr + 1) - p;
> -
> -       if (unlikely(!mem_init_done)) {
> -               if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> -                       return IOMEM_ERR_PTR(ret);
> -               v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> -               fixmaps_used += (size >> PAGE_SHIFT);
> -
> -               if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
> -                       fixmaps_used -= (size >> PAGE_SHIFT);
> -                       return IOMEM_ERR_PTR(ret);
> -               }
> -
> -               return (void __iomem *)(offset + (char *)v);
> -       }
> -
>         return NULL;
>  }
>  
> 

