Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56BC43334
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 15:46:15 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 348CB24986;
	Wed,  6 Jul 2022 17:46:14 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id 6B5FD24956
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 17:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZMPiGOu1gsOrP+OcjmrgLm7lfQsrjdxIxBZ6JkHGY4s=; b=Igpy4Ztjw6EHxP2kGcUQABTJik
 ouxzd2xaG1VFa/TwwQyX8nCf+NZbuPs26JHzK8ELixfm2UjEcG99xdhcY0ijhI1LtxN1TtWXXB1wL
 QBSZiM37PnQUgp8ys5M4sk1urMtXH3tFmEn9tXn80WEy5ywwwpHY/B24cPAjwB804VrzcVjUODNMU
 REYwWnm8SDyYQhQI+K8NRNdHOXn/LjDqfABaVA7ReWa7TfKrCSZdNUB/0bU3yR8JvVOT6qXB4SQlS
 6cZwAeAkpFg6LyYLh9cFFeOAo0nQow7O0grI47Vbdv0rczao6tql2aINzX6orwdtuyV46iQV7irPy
 1bIWikBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o97DI-001lBg-0s; Wed, 06 Jul 2022 15:45:16 +0000
Date: Wed, 6 Jul 2022 16:45:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 3/3] mm: Add kernel PTE level pagetable pages account
Message-ID: <YsWuC9+b3JaEAr0Q@casper.infradead.org>
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
 <398ead25695e530f766849be5edafaf62c1c864d.1657096412.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398ead25695e530f766849be5edafaf62c1c864d.1657096412.git.baolin.wang@linux.alibaba.com>
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
Cc: x86@kernel.org, loongarch@lists.linux.dev, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, guoren@kernel.org,
 hpa@zytor.com, kernel@xen0n.name, will@kernel.org, jonas@southpole.se,
 aneesh.kumar@linux.ibm.com, chenhuacai@kernel.org, linux-csky@vger.kernel.org,
 rppt@linux.ibm.com, mingo@redhat.com, linux-arch@vger.kernel.org,
 arnd@arndb.de, npiggin@gmail.com, openrisc@lists.librecores.org, bp@alien8.de,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
 akpm@linux-foundation.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Jul 06, 2022 at 04:59:17PM +0800, Baolin Wang wrote:
> Now the kernel PTE level ptes are always protected by mm->page_table_lock
> instead of split pagetable lock, so the kernel PTE level pagetable pages
> are not accounted. Especially the vmalloc()/vmap() can consume lots of
> kernel pagetable, so to get an accurate pagetable accounting, calling new
> helpers page_{set,clear}_pgtable() when allocating or freeing a kernel
> PTE level pagetable page.
> 
> Meanwhile converting architectures to use corresponding generic PTE pagetable
> allocation and freeing functions.
> 
> Note this patch only adds accounting to the page tables allocated after boot.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>

What does this Reported-by: even mean?  the kernel test robot told you
that the page tables weren't being accounted?

I don't understand why we want to start accounting kernel page tables.
an we have a *discussion* about that with a sensible thread name instead
of just trying to sneak it in as patch 3/3?
