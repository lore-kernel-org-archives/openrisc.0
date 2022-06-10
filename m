Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D38C433EF
	for <openrisc@archiver.kernel.org>; Fri, 10 Jun 2022 03:58:52 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 19484248F3;
	Fri, 10 Jun 2022 05:58:51 +0200 (CEST)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by mail.librecores.org (Postfix) with ESMTPS id 3E7B7248FA
 for <openrisc@lists.librecores.org>; Fri, 10 Jun 2022 05:58:49 +0200 (CEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VFxazjx_1654833523; 
Received: from 30.0.143.52(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0VFxazjx_1654833523) by smtp.aliyun-inc.com;
 Fri, 10 Jun 2022 11:58:44 +0800
Message-ID: <6351ead6-b4b8-dc43-2c1d-c099094cadc9@linux.alibaba.com>
Date: Fri, 10 Jun 2022 11:58:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [mm] 9b12e49e9b: BUG:Bad_page_state_in_process
To: Matthew Wilcox <willy@infradead.org>
References: <20220608143819.GA31193@xsang-OptiPlex-9020>
 <d64da0da-9f71-3ae9-4d72-00b0c42fce5e@linux.alibaba.com>
 <YqHlKj5LbmtYGWUy@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YqHlKj5LbmtYGWUy@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-arch@vger.kernel.org, 0day robot <lkp@intel.com>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
 lkp@lists.01.org, openrisc@lists.librecores.org,
 kernel test robot <oliver.sang@intel.com>, akpm@linux-foundation.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>



On 6/9/2022 8:18 PM, Matthew Wilcox wrote:
> On Thu, Jun 09, 2022 at 12:42:16PM +0800, Baolin Wang wrote:
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 6cccf52e156a..cae74e972426 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -858,6 +858,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>          /* INVLPG to clear all paging-structure caches */
>>          flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
>>
>> +       pgtable_clear_and_dec(virt_to_page(pte));
>>          free_page((unsigned long)pte);
>>
>>          return 1;
> 
> If you're going to call virt_to_page() here, you may as well cache the
> result and call __free_page(page) to avoid calling virt_to_page() twice.

Right, will do in next version. Thanks.
