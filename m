Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC251ECAAA2
	for <openrisc@archiver.kernel.org>; Mon, 29 Aug 2022 01:40:39 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7B6FA20AC2;
	Mon, 29 Aug 2022 03:40:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id 0247724AAE
 for <openrisc@lists.librecores.org>; Mon, 29 Aug 2022 03:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661737235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vCF2MFLwabeNCUHxCLBI4UWY8z6BpyfJcEettVVvuc=;
 b=P2XEGmabert+YPn3a5ifG6+53a3hHSU5HhuRX34ECRUYhST1VjiA9k3g94y8XiaxvdPAJg
 UvKHLcOTt4xaKRGMNMW9XECyXHEHu65ejr7z5GSsj53jWYt0aDOX4tip/zS8yVI3CoMsT2
 AXR7R2sjTIRNKTNdofj57URPoJDrUK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-LevrZ2iyNZi2Fkpakragqg-1; Sun, 28 Aug 2022 21:40:29 -0400
X-MC-Unique: LevrZ2iyNZi2Fkpakragqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 092B3101A54E;
 Mon, 29 Aug 2022 01:40:29 +0000 (UTC)
Received: from localhost (ovpn-12-153.pek2.redhat.com [10.72.12.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EDB34010FCC;
 Mon, 29 Aug 2022 01:40:27 +0000 (UTC)
Date: Mon, 29 Aug 2022 09:40:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwwZCO279Vh/cXGW@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
 <YwHYx0eXouIWnN8Z@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHYx0eXouIWnN8Z@infradead.org>
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
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 openrisc@lists.librecores.org, akpm@linux-foundation.org,
 agordeev@linux.ibm.com, linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 08/21/22 at 12:03am, Christoph Hellwig wrote:
> > +	if (unlikely(!mem_init_done)) {
> >  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> > +			return IOMEM_ERR_PTR(ret);
> >  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> >  		fixmaps_used += (size >> PAGE_SHIFT);
> >  
> > +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
> >  			fixmaps_used -= (size >> PAGE_SHIFT);
> > +			return IOMEM_ERR_PTR(ret);
> > +		}
> > +
> > +		return (void __iomem *)(offset + (char *)v);
> >  	}
> 
> This code needs to go away, and all very early boot uses of ioremap
> need to switch to use early_ioremap insted.

Makes sense. On openrisc, the thing is I didn't find one place where
ioremap() is called in arch code. I can cut the early ioremap out and
wrap into a separate early_ioremap() function, however I don't know
where to put it. Not sure if I miss anything or openrisc doesn't really
need early ioremap.

