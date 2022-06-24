Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6D9CCA485
	for <openrisc@archiver.kernel.org>; Fri, 24 Jun 2022 05:11:09 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1F5A424A0C;
	Fri, 24 Jun 2022 07:11:09 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by mail.librecores.org (Postfix) with ESMTPS id E9EDF24A0F
 for <openrisc@lists.librecores.org>; Fri, 24 Jun 2022 07:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oy8Qzv7ZwesdQ7gZcxE/IliyoXQVuCtp5qw3DJ66UmU=; b=tYEY6TDJRXfImJFb/TegSvBB52
 c9s1q6arcG99qLu14ih4wheulphZK3pt+18fSMiLmXsL2oDuB7dPvXw7yuFMgzGpHbHvusQBMskHB
 MEDDM/XjG+R7Lzh/3+bIAU/402+xsYAByeCBVOA0I8WhpORdaOiymIQlPUyq4X9KtlBx1l3ssAZWz
 5kVdXI840LT9CyXBPW9XnEObiktYQInNMEYJCgmlVRdPEgXlKUePxM+/UFR7JkbhiRuzBlDVzuO7q
 97wrFo+nfpajUACMGdBzXCRcH0frNcML2+64mW5MNr8axsa789mj7G6nXr8zjaYQMjHBPDkFr6VGZ
 mk0T0xhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o4bat-000V4L-M8; Fri, 24 Jun 2022 05:10:59 +0000
Date: Thu, 23 Jun 2022 22:10:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 16/26] riscv/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <YrVHYwb3z0Wv+vZx@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-17-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-17-anshuman.khandual@arm.com>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-csky@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 christophe.leroy@csgroup.eu, hch@infradead.org,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jun 24, 2022 at 10:13:29AM +0530, Anshuman Khandual wrote:
index d466ec670e1f..f976580500b1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -288,6 +288,26 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
>  #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
>  #endif /* CONFIG_XIP_KERNEL */
>  
> +static pgprot_t protection_map[16] __ro_after_init = {

Can't this be marked const now?

