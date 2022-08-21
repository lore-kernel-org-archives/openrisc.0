Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C806DC00140
	for <openrisc@archiver.kernel.org>; Sun, 21 Aug 2022 07:03:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 91AFA21292;
	Sun, 21 Aug 2022 09:03:57 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by mail.librecores.org (Postfix) with ESMTPS id D4E0D2485F
 for <openrisc@lists.librecores.org>; Sun, 21 Aug 2022 09:03:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0a6VDXeUDWqpyW5dOeUR66fpQ0IrNu3SkYDJZLhUFfo=; b=XRGOGR1tWbxOf4fDsEL+NOAGv1
 YjukYmQI6hJ3+/xQ/UEv5zWKUjB9onx+ZXXuobJMOVCAhg1TKxSuxD7X0GLQPqIUVDp2t5bNsZLG0
 kA7EdGMiJ3pWzT13YzsWSieLDBa2jyFuSMo5qVs9ZEm+nz7Mac8vJfa3dMg/+xduqLN4OLAMl68ne
 bsc4Xxio8PO6AE4SWwqg2IYMO0TTgS1RzZeQOrebGail+VtL+xYP482C30r9Jte01uIOix7tY/48i
 VKleSSJTRjUQZr1ugne+x2bWv2UI2MdqXLShtcUAyvKcv009mQ1Q97rFA5vshUwH8T5T1coO1gVBl
 DOkTIMYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oPezf-00760D-Cc; Sun, 21 Aug 2022 07:03:35 +0000
Date: Sun, 21 Aug 2022 00:03:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwHYx0eXouIWnN8Z@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-8-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
 linux-kernel@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org,
 openrisc@lists.librecores.org, akpm@linux-foundation.org,
 agordeev@linux.ibm.com, linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

> +	if (unlikely(!mem_init_done)) {
>  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> +			return IOMEM_ERR_PTR(ret);
>  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
>  		fixmaps_used += (size >> PAGE_SHIFT);
>  
> +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
>  			fixmaps_used -= (size >> PAGE_SHIFT);
> +			return IOMEM_ERR_PTR(ret);
> +		}
> +
> +		return (void __iomem *)(offset + (char *)v);
>  	}

This code needs to go away, and all very early boot uses of ioremap
need to switch to use early_ioremap insted.
