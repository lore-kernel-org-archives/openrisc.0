Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54BC433EF
	for <openrisc@archiver.kernel.org>; Mon, 11 Jul 2022 20:14:24 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 21C9820DEE;
	Mon, 11 Jul 2022 22:14:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mail.librecores.org (Postfix) with ESMTPS id A279D24830
 for <openrisc@lists.librecores.org>; Mon, 11 Jul 2022 22:14:21 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3F26D615E8;
 Mon, 11 Jul 2022 20:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FB8C34115;
 Mon, 11 Jul 2022 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1657570459;
 bh=Qi9KHdTBSLuKZsaLawDZPDz9HT/wF+gH2hGfQ1b/XB4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=j6XVvkVOWxDOzNjGjTDcj6e6ZY1u9GuvGONiK6EGJe21US8g66C0v4Tv4wCu+5Z3u
 T5lr1fQ/vFxEaXWAl9b5zH6sU86TD4i30OcWtJ4fjtKbOuqrDS6Ez0AqW6I2zqbQ9j
 6Q9WeeDMfajEfQXiH+eWEM5JFOXvwrthQ0YF7SB8=
Date: Mon, 11 Jul 2022 13:14:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V7 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Message-Id: <20220711131417.9cac57d9b88eea8bbd7d8616@linux-foundation.org>
In-Reply-To: <20220711070600.2378316-1-anshuman.khandual@arm.com>
References: <20220711070600.2378316-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-csky@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, christophe.leroy@csgroup.eu,
 hch@infradead.org, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, 11 Jul 2022 12:35:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This series drops __SXXX/__PXXX macros from across platforms in the tree.

I've updated mm-unstable to this version, thanks.  I skipped the added-to-mm
emails to avoid wearing out people's inboxes.

Reissuing a 26-patch series N times is rather noisy.  Please prefer to send incremental
fixes when changes are minor.  It makes it so much easier for reviewers to see what
happened.
