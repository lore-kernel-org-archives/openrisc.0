Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B966BC433EF
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 15:52:49 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CA6B324956;
	Wed,  6 Jul 2022 17:52:48 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mail.librecores.org (Postfix) with ESMTPS id C3BAF2492C
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 17:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657122767; x=1688658767;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=y3/9f4gAnKgtfKYM4zXe/3Q35Ma8+prwhvKdkpVJo64=;
 b=lcFmzJUg412oSVFPJg2jef43YtIMpWHfwh7xXxJNhYh2HQliiHovfYEx
 80Kf/tuRyxJN719m4gXvim0u+HS5Sp/XzQXRfFXMs6SKPDfhlwRk8zWza
 qr89w3rq/DR7V3dmCigM8cRpnfro68Y039gS7MFljemiTeNOWUACIPhhP
 x9012dFJrdaavGfF+eZQJp7IwPM49anlRtlhc7bbE2bVpGmLkIYG9Kc1Z
 EUddlIbnKBKEyp9iLS0fTMvprRofZYLADyVunsAQ0U7EbQNsfQe83tMEv
 jPkGGG3rlGevxjImNXlhdIxw898hLhRjBTrjayXTKB3GO3/4ZGtE2xZWK g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284523363"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; d="scan'208";a="284523363"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 08:50:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; d="scan'208";a="620370161"
Received: from tjsteven-mobl3.amr.corp.intel.com (HELO [10.255.228.25])
 ([10.255.228.25])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 08:50:12 -0700
Message-ID: <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
Date: Wed, 6 Jul 2022 08:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: x86@kernel.org, loongarch@lists.linux.dev, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, guoren@kernel.org,
 linux-csky@vger.kernel.org, hpa@zytor.com, kernel@xen0n.name, will@kernel.org,
 tglx@linutronix.de, jonas@southpole.se, aneesh.kumar@linux.ibm.com,
 chenhuacai@kernel.org, willy@infradead.org, rppt@linux.ibm.com,
 mingo@redhat.com, linux-arch@vger.kernel.org, arnd@arndb.de, npiggin@gmail.com,
 openrisc@lists.librecores.org, bp@alien8.de, luto@kernel.org,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tsbogend@alpha.franken.de, linux-mips@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/6/22 01:59, Baolin Wang wrote:
> Now we will miss to account the PUD level pagetable and kernel PTE level
> pagetable, as well as missing to set the PG_table flags for these pagetable
> pages, which will get an inaccurate pagetable accounting, and miss
> PageTable() validation in some cases. So this patch set introduces new
> helpers to help to account PUD and kernel PTE pagetable pages.

Could you explain the motivation for this series a bit more?  Is there a
real-world problem that this fixes?
