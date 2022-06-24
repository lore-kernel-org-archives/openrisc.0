Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EECCA47F
	for <openrisc@archiver.kernel.org>; Fri, 24 Jun 2022 06:09:59 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7BFE8249BC;
	Fri, 24 Jun 2022 08:09:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mail.librecores.org (Postfix) with ESMTP id D7158249FD
 for <openrisc@lists.librecores.org>; Fri, 24 Jun 2022 08:09:56 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D62B11FB;
 Thu, 23 Jun 2022 23:09:56 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BA523F66F;
 Thu, 23 Jun 2022 23:09:48 -0700 (PDT)
Message-ID: <4a20d826-af0f-0d2c-162e-8797c2603ab1@arm.com>
Date: Fri, 24 Jun 2022 11:39:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 02/26] mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-3-anshuman.khandual@arm.com>
 <YrVHEw6bjUf62Eh5@infradead.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YrVHEw6bjUf62Eh5@infradead.org>
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



On 6/24/22 10:39, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 10:13:15AM +0530, Anshuman Khandual wrote:
>> This just converts the generic vm_get_page_prot() implementation into a new
>> macro i.e DECLARE_VM_GET_PAGE_PROT which later can be used across platforms
>> when enabling them with ARCH_HAS_VM_GET_PAGE_PROT. This does not create any
>> functional change.
> 
> mm.h is a huhe header included by almost everything in the kernel.
> I'd rather have it in something only included in a few files.  If we
> can't find anything suitable it might be worth to add a header just
> for this even.

I guess <linux/pgtable.h> should be better ?
