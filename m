Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA4AC433EF
	for <openrisc@archiver.kernel.org>; Fri, 24 Jun 2022 05:21:54 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9D43424A19;
	Fri, 24 Jun 2022 07:21:53 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by mail.librecores.org (Postfix) with ESMTPS id 15EC324A18
 for <openrisc@lists.librecores.org>; Fri, 24 Jun 2022 07:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QYAP6IdYxL4kkP1mhFiWFjHH5BifnWV+2KXEJB5WN44=; b=vzFJlocgeN9Sn5a6VlqTMFsTGY
 spn+jb0ZGmZFBUPtgTeT5l3ETwKxU8cJw9juEpT490/JJZ8T84TkG9jSA1WN13ix1Rg/6JtCx7A6Y
 Qr5aim01kpLR8tF9eVuG4M3oLni2WsyOxRwUbkBurz8n3uAL8OPxWTHyPbZNlT0sCjd4abNX7GsQL
 k+ihqoWOlZdrzK8sGGb8Xw764sspo87RnfFrOiFIl3aO1VLj+Y4OI76Lc/+blZNDfJnhhwnPtzGsj
 Omz4DbGrmtJ6CuJeOcV6bqdsmqHsoyWJZkPQxsLlDnpY0lM8GjBxxjyIaableNzgWQSj/EPV39I2D
 97JcYzwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o4blI-000aUe-MC; Fri, 24 Jun 2022 05:21:44 +0000
Date: Thu, 23 Jun 2022 22:21:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Message-ID: <YrVJ6GaSzD/4kD6M@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <YrVHvv0spuMsC1In@infradead.org>
 <33bdac1e-207a-192b-bf43-818abfa49fe1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33bdac1e-207a-192b-bf43-818abfa49fe1@arm.com>
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
 christophe.leroy@csgroup.eu, Christoph Hellwig <hch@infradead.org>,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jun 24, 2022 at 10:50:33AM +0530, Anshuman Khandual wrote:
> > On most architectures this should be const now, only very few ever
> > modify it.
> 
> Will make it a 'static const pgprot_t protection_map[16] __ro_after_init'
> on platforms that do not change the protection_map[] even during boot.

No need for __ro_after_init when it is already declarated const.
