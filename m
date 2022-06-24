Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C4CCA473
	for <openrisc@archiver.kernel.org>; Fri, 24 Jun 2022 06:11:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CF62B24A10;
	Fri, 24 Jun 2022 08:11:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mail.librecores.org (Postfix) with ESMTP id ED15524A12
 for <openrisc@lists.librecores.org>; Fri, 24 Jun 2022 08:11:40 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F88B19F0;
 Thu, 23 Jun 2022 23:11:40 -0700 (PDT)
Received: from [10.162.41.7] (unknown [10.162.41.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE6293F66F;
 Thu, 23 Jun 2022 23:11:32 -0700 (PDT)
Message-ID: <378e124f-914a-36b1-ff2f-9f4ea3b946a5@arm.com>
Date: Fri, 24 Jun 2022 11:41:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 02/26] mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-3-anshuman.khandual@arm.com>
 <d3676fce-2dc7-6331-66f5-7009ac45f605@csgroup.eu>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d3676fce-2dc7-6331-66f5-7009ac45f605@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>



On 6/24/22 10:58, Christophe Leroy wrote:
> 
> Le 24/06/2022 à 06:43, Anshuman Khandual a écrit :
>> This just converts the generic vm_get_page_prot() implementation into a new
>> macro i.e DECLARE_VM_GET_PAGE_PROT which later can be used across platforms
>> when enabling them with ARCH_HAS_VM_GET_PAGE_PROT. This does not create any
>> functional change.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   include/linux/mm.h | 8 ++++++++
>>   mm/mmap.c          | 6 +-----
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 47bfe038d46e..237828c2bae2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -428,6 +428,14 @@ extern unsigned int kobjsize(const void *objp);
>>   extern pgprot_t protection_map[16];
>>   #endif
>>   
> I think the comment above protection_map[16] in mm/mmap.c should be 
> moved here.

Sure, makes sense. Will move.
