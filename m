Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DFDCCA47F
	for <openrisc@archiver.kernel.org>; Fri, 24 Jun 2022 05:20:46 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 235FE24A13;
	Fri, 24 Jun 2022 07:20:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mail.librecores.org (Postfix) with ESMTP id 80CF1249FC
 for <openrisc@lists.librecores.org>; Fri, 24 Jun 2022 07:20:44 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BB59176A;
 Thu, 23 Jun 2022 22:20:44 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB2DF3F66F;
 Thu, 23 Jun 2022 22:20:36 -0700 (PDT)
Message-ID: <33bdac1e-207a-192b-bf43-818abfa49fe1@arm.com>
Date: Fri, 24 Jun 2022 10:50:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <YrVHvv0spuMsC1In@infradead.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YrVHvv0spuMsC1In@infradead.org>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-csky@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 christophe.leroy@csgroup.eu, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>



On 6/24/22 10:42, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 10:13:13AM +0530, Anshuman Khandual wrote:
>> vm_get_page_prot(), in order for it to be reused on platforms that do not
>> require custom implementation. Finally, ARCH_HAS_VM_GET_PAGE_PROT can just
>> be dropped, as all platforms now define and export vm_get_page_prot(), via
>> looking up a private and static protection_map[] array. protection_map[]
>> data type is the following for all platforms without deviation (except the
>> powerpc one which is shared between 32 and 64 bit platforms), keeping it
>> unchanged for now.
>>
>> static pgprot_t protection_map[16] __ro_after_init
> 
> On most architectures this should be const now, only very few ever
> modify it.

Will make it a 'static const pgprot_t protection_map[16] __ro_after_init'
on platforms that do not change the protection_map[] even during boot.
