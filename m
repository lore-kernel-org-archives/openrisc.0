Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F7C433EF
	for <openrisc@archiver.kernel.org>; Thu,  9 Jun 2022 12:19:16 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 20F56242D4;
	Thu,  9 Jun 2022 14:19:15 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id 1B640242D4
 for <openrisc@lists.librecores.org>; Thu,  9 Jun 2022 14:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1Py1XbeQYoV2WaLT1b7PoYSfrJY33ukYR++1ZCekWrA=; b=d5SJnp5L55UkGo1Z+IupQH6lgu
 0gkbpMt2/QZ4OvDi8xybTKth8gEqRWU3azU0NGb1gQMBIoYHblgP9l8SkGX1G9+uUvRgki1kHPZmD
 6XVTPqS9TRmXEXTB/cP7I5WpebsIfo0D8yDIjbhDPKbkwDEcrpdXEzyFK5LOOhF4TDAvwAbVriqgq
 2nfUW9+XjyizpJOLyVruQBK7PFEZw9ImhShAnMgiQJWk5tPYJ67cio1VNzFHTkPrq4mh2yoNjhjIf
 m1aQOc+E/U/brKoYAysMB07FpTjrAY185m9Q3ofZoZeouVvl/NHMBmjpwYXYi1QBrv3vTQjT0dhZG
 FSY7wkRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nzH7i-00DXRv-7v; Thu, 09 Jun 2022 12:18:50 +0000
Date: Thu, 9 Jun 2022 13:18:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [mm] 9b12e49e9b: BUG:Bad_page_state_in_process
Message-ID: <YqHlKj5LbmtYGWUy@casper.infradead.org>
References: <20220608143819.GA31193@xsang-OptiPlex-9020>
 <d64da0da-9f71-3ae9-4d72-00b0c42fce5e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64da0da-9f71-3ae9-4d72-00b0c42fce5e@linux.alibaba.com>
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
Cc: linux-arch@vger.kernel.org, 0day robot <lkp@intel.com>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
 lkp@lists.01.org, openrisc@lists.librecores.org,
 kernel test robot <oliver.sang@intel.com>, akpm@linux-foundation.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 09, 2022 at 12:42:16PM +0800, Baolin Wang wrote:
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 6cccf52e156a..cae74e972426 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -858,6 +858,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>         /* INVLPG to clear all paging-structure caches */
>         flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
> 
> +       pgtable_clear_and_dec(virt_to_page(pte));
>         free_page((unsigned long)pte);
> 
>         return 1;

If you're going to call virt_to_page() here, you may as well cache the
result and call __free_page(page) to avoid calling virt_to_page() twice.
