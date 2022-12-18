Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67925C10F1E
	for <openrisc@archiver.kernel.org>; Sun, 18 Dec 2022 10:00:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id F2B4524C37;
	Sun, 18 Dec 2022 10:59:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id E853124C2C
 for <openrisc@lists.librecores.org>; Sun, 18 Dec 2022 10:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671357597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40GRUdlRAtUxb7WD8Kqf+Ugi5NyUS71hS5wP23U0j54=;
 b=UEwT+YI04qYOQFnWnlpG/AzKvHu0CGS1KpdTvfZjRr93KtehZJYALmVDj04zK0vbUwL1CZ
 b4WVuQy+yTO0ShZ44EiYIoV8YM1BNTx5FpGXoj38mMKC3ycuN0F8IfD960hmzV78oM0xnb
 NMzpcgbg25owVrISFS07RgOlp+rLt9c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-oj-CzndCMGu77wG54rPWLA-1; Sun, 18 Dec 2022 04:59:54 -0500
X-MC-Unique: oj-CzndCMGu77wG54rPWLA-1
Received: by mail-wm1-f69.google.com with SMTP id
 bi19-20020a05600c3d9300b003cf9d6c4016so5082475wmb.8
 for <openrisc@lists.librecores.org>; Sun, 18 Dec 2022 01:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=40GRUdlRAtUxb7WD8Kqf+Ugi5NyUS71hS5wP23U0j54=;
 b=ffNgZv7ePASSa14gdTTDK5rAs2UZL1X2G2KWNLIsvQalNpShiHS7bcjlwAnTYmAyLB
 t5uK3RVzwI987UJbkfi6SyNYAvQfEytyuyCneAA3dTXb7buxQai1/eo5AWL59e5QAYF2
 IkP20Rpc7yKYWnqtlbQLh5w5r1/LvKzYJ7WNCxsygLc8imaFyzdCqehRSkk8hiuy1pgx
 9aMJbnVuPZPZ/t8vWqEuNIWqgdi1s/q0H2PC+jGltKyawxD32Ij+d+mt4k80NsHG82io
 gqUNFfom4BNWNN5i7G7iKgFoj1z/y4CeA0hzROXOHllLArBE1QuWUnNuj2W4DLWMgNuv
 ci9g==
X-Gm-Message-State: ANoB5pkv2DDXkP3YQmQQ4nlX8m0dg6R0g6B0StQ/91sJu84cb1t3sqlW
 flw4dGtli7qvZG4lXI1d4F0Gox/64SWXH7skHJ3dd3DwTBCpaSjuveG+UmuB3H2tpTp0lFllyDX
 g2bmauG5KtlI0a2enDpUkHf89sA==
X-Received: by 2002:a05:600c:3c9a:b0:3c6:c6c9:d75e with SMTP id
 bg26-20020a05600c3c9a00b003c6c6c9d75emr40381265wmb.0.1671357592906; 
 Sun, 18 Dec 2022 01:59:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf70XdZ3J+8X2dl3DqxLL1m33RuokYuq1g5n3SN2j/YJfgNLpd1gHw4S/kM2L8bQXXp7f0cgIg==
X-Received: by 2002:a05:600c:3c9a:b0:3c6:c6c9:d75e with SMTP id
 bg26-20020a05600c3c9a00b003c6c6c9d75emr40381246wmb.0.1671357592548; 
 Sun, 18 Dec 2022 01:59:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c728:2000:3aca:8d08:a617:1f69?
 (p200300cbc72820003aca8d08a6171f69.dip0.t-ipconnect.de.
 [2003:cb:c728:2000:3aca:8d08:a617:1f69])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a05600c4f9100b003d351a9db76sm2594565wmq.30.2022.12.18.01.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Dec 2022 01:59:52 -0800 (PST)
Message-ID: <b3b90a8e-16e9-a314-8531-e225f8a52817@redhat.com>
Date: Sun, 18 Dec 2022 10:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: Huacai Chen <chenhuacai@kernel.org>
References: <20221206144730.163732-1-david@redhat.com>
 <CAAhV-H4bU7JnAPyf9Mv1m+WGR5NWmHJLva3d9_CsRd4Q_OHVpg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable RFC 00/26] mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap PTEs
In-Reply-To: <CAAhV-H4bU7JnAPyf9Mv1m+WGR5NWmHJLva3d9_CsRd4Q_OHVpg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org, Hugh Dickins <hughd@google.com>,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>,
 Vineet Gupta <vgupta@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 Albert Ou <aou@eecs.berkeley.edu>, Chris Zankel <chris@zankel.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, John Hubbard <jhubbard@nvidia.com>,
 linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Weinberger <richard@nod.at>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 loongarch@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-arm-kernel@lists.infradead.org, WANG Xuerui <kernel@xen0n.name>,
 Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 Dinh Nguyen <dinguyen@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-alpha@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 18.12.22 04:32, Huacai Chen wrote:
> Hi, David,
> 
> What is the opposite of exclusive here? Shared or inclusive? I prefer
> pte_swp_mkshared() or pte_swp_mkinclusive() rather than
> pte_swp_clear_exclusive(). Existing examples: dirty/clean, young/old
> ...

Hi Huacai,

thanks for having a look!

Please note that this series doesn't add these primitives but merely 
implements them on all remaining architectures.

Having that said, the semantics are "exclusive" vs. "maybe shared", not 
"exclusive" vs. "shared" or sth. else. It would have to be 
pte_swp_mkmaybe_shared().


Note that this naming matches just the way we handle it for the other 
pte_swp_ flags we have, namely:

pte_swp_mksoft_dirty()
pte_swp_soft_dirty()
pte_swp_clear_soft_dirty()

and

pte_swp_mkuffd_wp()
pte_swp_uffd_wp()
pte_swp_clear_uffd_wp()


For example, we also (thankfully) didn't call it pte_mksoft_clean().
Grepping for "pte_swp.*soft_dirty" gives you the full picture.

Thanks!

David

> 
> Huacai
> 
> On Tue, Dec 6, 2022 at 10:48 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> This is the follow-up on [1]:
>>          [PATCH v2 0/8] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
>>          anonymous pages
>>
>> After we implemented __HAVE_ARCH_PTE_SWP_EXCLUSIVE on most prominent
>> enterprise architectures, implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all
>> remaining architectures that support swap PTEs.
>>
>> This makes sure that exclusive anonymous pages will stay exclusive, even
>> after they were swapped out -- for example, making GUP R/W FOLL_GET of
>> anonymous pages reliable. Details can be found in [1].
>>
>> This primarily fixes remaining known O_DIRECT memory corruptions that can
>> happen on concurrent swapout, whereby we can lose DMA reads to a page
>> (modifying the user page by writing to it).
>>
>> To verify, there are two test cases (requiring swap space, obviously):
>> (1) The O_DIRECT+swapout test case [2] from Andrea. This test case tries
>>      triggering a race condition.
>> (2) My vmsplice() test case [3] that tries to detect if the exclusive
>>      marker was lost during swapout, not relying on a race condition.
>>
>>
>> For example, on 32bit x86 (with and without PAE), my test case fails
>> without these patches:
>>          $ ./test_swp_exclusive
>>          FAIL: page was replaced during COW
>> But succeeds with these patches:
>>          $ ./test_swp_exclusive
>>          PASS: page was not replaced during COW
>>
>>
>> Why implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE for all architectures, even
>> the ones where swap support might be in a questionable state? This is the
>> first step towards removing "readable_exclusive" migration entries, and
>> instead using pte_swp_exclusive() also with (readable) migration entries
>> instead (as suggested by Peter). The only missing piece for that is
>> supporting pmd_swp_exclusive() on relevant architectures with THP
>> migration support.
>>
>> As all relevant architectures now implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE,,
>> we can drop __HAVE_ARCH_PTE_SWP_EXCLUSIVE in the last patch.
>>
>>
>> RFC because some of the swap PTE layouts are really tricky and I really
>> need some feedback related to deciphering these layouts and "using yet
>> unused PTE bits in swap PTEs". I tried cross-compiling all relevant setups
>> (phew, I might only miss some power/nohash variants), but only tested on
>> x86 so far.
>>
>> CCing arch maintainers only on this cover letter and on the respective
>> patch(es).
>>
>>
>> [1] https://lkml.kernel.org/r/20220329164329.208407-1-david@redhat.com
>> [2] https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/page_count_do_wp_page-swap.c
>> [3] https://gitlab.com/davidhildenbrand/scratchspace/-/blob/main/test_swp_exclusive.c
>>
>> David Hildenbrand (26):
>>    mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
>>    alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    ia64/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    loongarch/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    m68k/mm: remove dummy __swp definitions for nommu
>>    m68k/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    mips/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    nios2/mm: refactor swap PTE layout
>>    nios2/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    openrisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    powerpc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
>>    powerpc/nohash/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    riscv/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    sh/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit
>>    sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 64bit
>>    um/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    x86/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also on 32bit
>>    xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    mm: remove __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>
>>   arch/alpha/include/asm/pgtable.h              | 40 ++++++++-
>>   arch/arc/include/asm/pgtable-bits-arcv2.h     | 26 +++++-
>>   arch/arm/include/asm/pgtable-2level.h         |  3 +
>>   arch/arm/include/asm/pgtable-3level.h         |  3 +
>>   arch/arm/include/asm/pgtable.h                | 34 ++++++--
>>   arch/arm64/include/asm/pgtable.h              |  1 -
>>   arch/csky/abiv1/inc/abi/pgtable-bits.h        | 13 ++-
>>   arch/csky/abiv2/inc/abi/pgtable-bits.h        | 19 ++--
>>   arch/csky/include/asm/pgtable.h               | 17 ++++
>>   arch/hexagon/include/asm/pgtable.h            | 36 ++++++--
>>   arch/ia64/include/asm/pgtable.h               | 31 ++++++-
>>   arch/loongarch/include/asm/pgtable-bits.h     |  4 +
>>   arch/loongarch/include/asm/pgtable.h          | 38 +++++++-
>>   arch/m68k/include/asm/mcf_pgtable.h           | 35 +++++++-
>>   arch/m68k/include/asm/motorola_pgtable.h      | 37 +++++++-
>>   arch/m68k/include/asm/pgtable_no.h            |  6 --
>>   arch/m68k/include/asm/sun3_pgtable.h          | 38 +++++++-
>>   arch/microblaze/include/asm/pgtable.h         | 44 +++++++---
>>   arch/mips/include/asm/pgtable-32.h            | 86 ++++++++++++++++---
>>   arch/mips/include/asm/pgtable-64.h            | 23 ++++-
>>   arch/mips/include/asm/pgtable.h               | 35 ++++++++
>>   arch/nios2/include/asm/pgtable-bits.h         |  3 +
>>   arch/nios2/include/asm/pgtable.h              | 37 ++++++--
>>   arch/openrisc/include/asm/pgtable.h           | 40 +++++++--
>>   arch/parisc/include/asm/pgtable.h             | 40 ++++++++-
>>   arch/powerpc/include/asm/book3s/32/pgtable.h  | 37 ++++++--
>>   arch/powerpc/include/asm/book3s/64/pgtable.h  |  1 -
>>   arch/powerpc/include/asm/nohash/32/pgtable.h  | 22 +++--
>>   arch/powerpc/include/asm/nohash/32/pte-40x.h  |  6 +-
>>   arch/powerpc/include/asm/nohash/32/pte-44x.h  | 18 +---
>>   arch/powerpc/include/asm/nohash/32/pte-85xx.h |  4 +-
>>   arch/powerpc/include/asm/nohash/64/pgtable.h  | 24 +++++-
>>   arch/powerpc/include/asm/nohash/pgtable.h     | 15 ++++
>>   arch/powerpc/include/asm/nohash/pte-e500.h    |  1 -
>>   arch/riscv/include/asm/pgtable-bits.h         |  3 +
>>   arch/riscv/include/asm/pgtable.h              | 28 ++++--
>>   arch/s390/include/asm/pgtable.h               |  1 -
>>   arch/sh/include/asm/pgtable_32.h              | 53 +++++++++---
>>   arch/sparc/include/asm/pgtable_32.h           | 26 +++++-
>>   arch/sparc/include/asm/pgtable_64.h           | 37 +++++++-
>>   arch/sparc/include/asm/pgtsrmmu.h             | 14 +--
>>   arch/um/include/asm/pgtable.h                 | 36 +++++++-
>>   arch/x86/include/asm/pgtable-2level.h         | 26 ++++--
>>   arch/x86/include/asm/pgtable-3level.h         | 26 +++++-
>>   arch/x86/include/asm/pgtable.h                |  3 -
>>   arch/xtensa/include/asm/pgtable.h             | 31 +++++--
>>   include/linux/pgtable.h                       | 29 -------
>>   mm/debug_vm_pgtable.c                         | 25 +++++-
>>   mm/memory.c                                   |  4 -
>>   mm/rmap.c                                     | 11 ---
>>   50 files changed, 943 insertions(+), 227 deletions(-)
>>
>> --
>> 2.38.1
>>
>>
> 

-- 
Thanks,

David / dhildenb

