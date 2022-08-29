Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC7ECAAD4
	for <openrisc@archiver.kernel.org>; Mon, 29 Aug 2022 06:42:15 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8386F24785;
	Mon, 29 Aug 2022 08:42:14 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mail.librecores.org (Postfix) with ESMTPS id 64CA624814
 for <openrisc@lists.librecores.org>; Mon, 29 Aug 2022 08:42:13 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 k18-20020a05600c0b5200b003a5dab49d0bso3900244wmr.3
 for <openrisc@lists.librecores.org>; Sun, 28 Aug 2022 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc;
 bh=EtBowJCOg4bZf/seKGBDDB2Td0pD664BFJhFwsUws4E=;
 b=JzFa8ZXk4k4FIgrpTmd8xr/Fml1Bxzh/zc8n8yDNQ17Q6WUGtq9uRFdTSBKUjCq9m6
 yDAEDD+bk0PEElLYUsd9rMJFoxHs8f1Cn3bp3yf/3aEL3QjcS/18klbgYVzUUMxjvKXn
 My/ce7F8sjd43ihFxOsSYiM4nU+pi3OV8RWN1CtIKFPKNcX+/+5EO2vE6TKypHjSPFo+
 ywACbvkaox9gdsnH9/A3QX/V5as1oVr4C8p7asP/Rm64lzk+LwxhWCcA3zLEiXdte8Ro
 Mouv6wn63AyYBNZwsTyg2Ar9Xh7KKdHKJtLbrljMLLS6meI25K0vI7+2BbzMrVM0dy3b
 mgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=EtBowJCOg4bZf/seKGBDDB2Td0pD664BFJhFwsUws4E=;
 b=ggN4C345oKklky93P4+2yTaZS4jUQ5iOkZA6XTUtncWxiNkDtEyXUmIh6CK97nYOpw
 DxIJEoIxnjcCfRWtlJe9kuLInirP2j2ZC6zA3FO4KB0UXfiMqGrZUrSpAv/GVCYKYEj0
 /pPmTeKQnIDlzmqaaDiFDytKhpKDniV2mt6rvFzGhUEZ1SLLBbXlsVmkTTPzpAazcgwI
 mqVwO/Z2HfpjWZuO/dwfLqEPfY1QmvbWJFKgZCZRGln/5Dkb62KBgDzrAWA/bq1p/QGH
 Kz4qQEtlzoUZsrppMrXFQcBTNXn3UaXneLSnxwFpXgSEbMwQ0DJKB+tGCAgqxXrZk7/x
 PGgg==
X-Gm-Message-State: ACgBeo11BNVVi7GxkvEzZhAJ/8cp4vHxHDcMK+3AW/JfxDONWX0P60UO
 kpcdPPVro2JC6W9629tJz60=
X-Google-Smtp-Source: AA6agR7GZBXQq8tJ1YNGsHzfy52ilSO1EuETNVmd+tTqGDa3GcHyWp5N5vBiDdugcDtXotuoprlTXw==
X-Received: by 2002:a05:600c:1c8d:b0:3a6:9d60:faf0 with SMTP id
 k13-20020a05600c1c8d00b003a69d60faf0mr6003665wms.82.1661755332985; 
 Sun, 28 Aug 2022 23:42:12 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a05600c1c1b00b003a31fd05e0fsm11009235wms.2.2022.08.28.23.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Aug 2022 23:42:12 -0700 (PDT)
Date: Mon, 29 Aug 2022 06:42:12 +0000
From: Stafford Horne <shorne@gmail.com>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwxfxKrTUtAuejKQ@oscomms1>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
 <YwHYx0eXouIWnN8Z@infradead.org> <YwwZCO279Vh/cXGW@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwwZCO279Vh/cXGW@MiWiFi-R3L-srv>
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

On Mon, Aug 29, 2022 at 09:40:24AM +0800, Baoquan He wrote:
> On 08/21/22 at 12:03am, Christoph Hellwig wrote:
> > > +	if (unlikely(!mem_init_done)) {
> > >  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> > > +			return IOMEM_ERR_PTR(ret);
> > >  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> > >  		fixmaps_used += (size >> PAGE_SHIFT);
> > >  
> > > +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
> > >  			fixmaps_used -= (size >> PAGE_SHIFT);
> > > +			return IOMEM_ERR_PTR(ret);
> > > +		}
> > > +
> > > +		return (void __iomem *)(offset + (char *)v);
> > >  	}
> > 
> > This code needs to go away, and all very early boot uses of ioremap
> > need to switch to use early_ioremap insted.
> 
> Makes sense. On openrisc, the thing is I didn't find one place where
> ioremap() is called in arch code. I can cut the early ioremap out and
> wrap into a separate early_ioremap() function, however I don't know
> where to put it. Not sure if I miss anything or openrisc doesn't really
> need early ioremap.

Hi,

I don't know of any early_ioremap usage either in openrisc, maybe some drivers
use it?  However, we do not initialize any early_ioremap infrastructure in
openrisc so that may cause issues if it is used.

We can try to remove it all.  I tested these below additional changes and they
work, if you want to add them we can see if kbuild robots pick anything up.

-Stafford

diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index bc41660e1fb0..ffe6d5e2b5fe 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -22,14 +22,10 @@
 
 extern int mem_init_done;
 
-static unsigned int fixmaps_used __initdata;
-
 void __iomem *
 arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-       phys_addr_t p;
-       unsigned long v;
-       unsigned long offset, last_addr, addr = *paddr;
+       unsigned long last_addr, addr = *paddr;
        int ret = -EINVAL;
 
        /* Don't allow wraparound or zero size */
@@ -37,27 +33,6 @@ arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
        if (!size || last_addr < addr)
                return IOMEM_ERR_PTR(ret);
 
-       /*
-        * Mappings have to be page-aligned
-        */
-       offset = addr & ~PAGE_MASK;
-       p = addr & PAGE_MASK;
-       size = PAGE_ALIGN(last_addr + 1) - p;
-
-       if (unlikely(!mem_init_done)) {
-               if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
-                       return IOMEM_ERR_PTR(ret);
-               v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
-               fixmaps_used += (size >> PAGE_SHIFT);
-
-               if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
-                       fixmaps_used -= (size >> PAGE_SHIFT);
-                       return IOMEM_ERR_PTR(ret);
-               }
-
-               return (void __iomem *)(offset + (char *)v);
-       }
-
        return NULL;
 }
 

