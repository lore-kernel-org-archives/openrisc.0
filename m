Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69491C54EBC
	for <openrisc@archiver.kernel.org>; Tue, 10 Jan 2023 13:52:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C8D9C22A2A;
	Tue, 10 Jan 2023 14:52:35 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mail.librecores.org (Postfix) with ESMTPS id DAB2921730
 for <openrisc@lists.librecores.org>; Tue, 10 Jan 2023 14:52:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673358754; x=1704894754;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Tp8Z9Ay/HrlqQE0qDFK7p4Fost9+vU0ggkXvi/hfbkY=;
 b=O67movT6tNBUxbCNP48DFQij2LwtsqhhGNclza7b6SO0hzOGQUD02Zim
 Cr/UiGNEW6Kr6/rsSO/x7TkDgs8QD8KSJBEDequ9pIsIrBhWRKAkqaHnE
 TWMDcNhGt+hr1uCGWWYBygx+guaWozKv8oPCrCBvIrk+KywwKHAShE/hq
 HDXBOD7a1HUk0cf8JcwqwxFVZVu9TjQi3f6+kB8MSYLDnz1AtyldY2b2e
 mJz0Ku6udOLxQWAQ6ZLGYGqGJHVPvzug6oa329oPwXvfn9IixkUikySp1
 hgqDf5oqnUGvEM4+Bgg4rtAX+y9Ci9ijvD0H9sa8Fp6LgS1d7lfNwA6Ng g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="387599286"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; d="scan'208";a="387599286"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2023 05:52:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830995823"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; d="scan'208";a="830995823"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga005.jf.intel.com with ESMTP; 10 Jan 2023 05:52:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1pFF36-0073E7-37; Tue, 10 Jan 2023 15:52:20 +0200
Date: Tue, 10 Jan 2023 15:52:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [Intel-gfx] [RFC DO NOT MERGE] treewide: use __xchg in most
 obvious places
Message-ID: <Y71tlG23t0gH9K1t@smile.fi.intel.com>
References: <Y7b6/7coJEVlTVxK@phenom.ffwll.local>
 <20230110105306.3973122-1-andrzej.hajda@intel.com>
 <Y71G1tkmUzM4BLxn@smile.fi.intel.com>
 <1bfae3d0-8c0b-ea83-7184-db847a4a969f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bfae3d0-8c0b-ea83-7184-db847a4a969f@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.29
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, loongarch@lists.linux.dev,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Jan 10, 2023 at 01:46:37PM +0100, Andrzej Hajda wrote:
> On 10.01.2023 12:07, Andy Shevchenko wrote:
> > On Tue, Jan 10, 2023 at 11:53:06AM +0100, Andrzej Hajda wrote:

...

> > > +	return __xchg(&p_chain->p_prod_elem,
> > > +		      (void *)(((u8 *)p_chain->p_prod_elem) + p_chain->elem_size));
> > 
> > Wondering if you still need a (void *) casting after the change. Ditto for the
> > rest of similar cases.
> 
> IMHO it is not needed also before the change and IIRC gcc has an extension
> which allows to drop (u8 *) cast as well [1].

I guess you can drop at least the former one.

> [1]: https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html

...

> > Btw, is it done by coccinelle? If no, why not providing the script?
> 
> Yes I have used cocci. My cocci skills are far from perfect, so I did not
> want to share my dirty code, but this is nothing secret:

Thank you! It's not about secrecy, it's about automation / error proofness.

-- 
With Best Regards,
Andy Shevchenko


