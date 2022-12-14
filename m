Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C6CC4332F
	for <openrisc@archiver.kernel.org>; Wed, 14 Dec 2022 11:22:59 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C9BCB24A9B;
	Wed, 14 Dec 2022 12:22:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 322E024A55
 for <openrisc@lists.librecores.org>; Wed, 14 Dec 2022 12:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671016976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxc01zNwMiugjthmgVOlTrtXQnLfLvXjRGMFtbZZLpc=;
 b=GJcAeE/PtFpn1/vFz2lK7BDUass2fCIFAvVi8EBj6OqZTconYOfb+By/rmk+gq1GAKOa8b
 734+aQmBnwNi/m9nC2CtNfqjt7F+Omlx24wbZ5cxu51n+kH6d1Im1NR/kYsVan5x35GoQO
 +Zsm1ClMCEBcuT2XMJ7yTnKLj1rUEHA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-Q-U7rTOiO5uE3X8ZtCY62g-1; Wed, 14 Dec 2022 06:22:54 -0500
X-MC-Unique: Q-U7rTOiO5uE3X8ZtCY62g-1
Received: by mail-wr1-f72.google.com with SMTP id
 a7-20020adfbc47000000b002421f817287so3462298wrh.4
 for <openrisc@lists.librecores.org>; Wed, 14 Dec 2022 03:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxc01zNwMiugjthmgVOlTrtXQnLfLvXjRGMFtbZZLpc=;
 b=P26Q2StB2AApHPlrtqxX1nJP4ggXzp47tAbB/ykn15hegAIAJcNosNJp3gIyHcD60E
 Vi1UbKmKM4YD9w3rQG6xDqSoXU1MzZKVYyvdB5kH0J0CexC8zkafrW7DxynodMVkVWAA
 c4Q4+SH+/TAwdVkjN+1+VFap5lwxdHAVVncST5uTO3mzTblAJ/kRu11J/UD1GIgRFC+Y
 OKUHl3RUos4RxZoADMptIxLNefs3QtdKHF6IQmPEyJH8aS844WMsV6jc6L+PUYH9Fy0u
 Ly0gpR1h3/c9CiOJlXWac5h1+zIseS+VqgV2SQNJaJPFCM+Dh/aVfzuV9TfB7EAnBmtD
 vBFQ==
X-Gm-Message-State: ANoB5pnAKzj5Tq0fmIJjhVd9GcMiIbSiwSH5lDBLUNu5L/eCkeHjxJAK
 MxKQUxy+0JSPnpKBc5m06GdEgELVjAQ1FV3Sg4z6O9Gro0HBgg5fA8SL2uRaUjCeieJtG1CP12s
 3z0+J3oGO9jep0XZYGta0Z5TsLg==
X-Received: by 2002:a05:600c:1da2:b0:3cf:5fd2:87a0 with SMTP id
 p34-20020a05600c1da200b003cf5fd287a0mr17488496wms.40.1671016973461; 
 Wed, 14 Dec 2022 03:22:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4UNUk6/OXN07sN3FMRll3MrS2ehO8GnTfEO+JQv3BigUvXvNgLJLKqkas5vWijxjr/1KiucA==
X-Received: by 2002:a05:600c:1da2:b0:3cf:5fd2:87a0 with SMTP id
 p34-20020a05600c1da200b003cf5fd287a0mr17488468wms.40.1671016973157; 
 Wed, 14 Dec 2022 03:22:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7700:dd7c:92f8:481f:b96b?
 (p200300cbc7037700dd7c92f8481fb96b.dip0.t-ipconnect.de.
 [2003:cb:c703:7700:dd7c:92f8:481f:b96b])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a05600c510300b003cfa3a12660sm8504320wms.1.2022.12.14.03.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Dec 2022 03:22:52 -0800 (PST)
Message-ID: <10bd4fc0-4fc0-bd98-6926-7d721a3bb12e@redhat.com>
Date: Wed, 14 Dec 2022 12:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable RFC 00/26] mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap PTEs
To: linux-kernel@vger.kernel.org
References: <20221206144730.163732-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
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
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Peter Xu <peterx@redhat.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Nadav Amit <namit@vmware.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
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
 Max Filippov <jcmvbkbc@gmail.com>, linux-mips@vger.kernel.org,
 Dinh Nguyen <dinguyen@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-alpha@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 06.12.22 15:47, David Hildenbrand wrote:
> This is the follow-up on [1]:
> 	[PATCH v2 0/8] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
> 	anonymous pages
> 
> After we implemented __HAVE_ARCH_PTE_SWP_EXCLUSIVE on most prominent
> enterprise architectures, implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all
> remaining architectures that support swap PTEs.
> 
> This makes sure that exclusive anonymous pages will stay exclusive, even
> after they were swapped out -- for example, making GUP R/W FOLL_GET of
> anonymous pages reliable. Details can be found in [1].
> 
> This primarily fixes remaining known O_DIRECT memory corruptions that can
> happen on concurrent swapout, whereby we can lose DMA reads to a page
> (modifying the user page by writing to it).
> 
> To verify, there are two test cases (requiring swap space, obviously):
> (1) The O_DIRECT+swapout test case [2] from Andrea. This test case tries
>      triggering a race condition.
> (2) My vmsplice() test case [3] that tries to detect if the exclusive
>      marker was lost during swapout, not relying on a race condition.
> 
> 
> For example, on 32bit x86 (with and without PAE), my test case fails
> without these patches:
> 	$ ./test_swp_exclusive
> 	FAIL: page was replaced during COW
> But succeeds with these patches:
> 	$ ./test_swp_exclusive
> 	PASS: page was not replaced during COW
> 
> 
> Why implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE for all architectures, even
> the ones where swap support might be in a questionable state? This is the
> first step towards removing "readable_exclusive" migration entries, and
> instead using pte_swp_exclusive() also with (readable) migration entries
> instead (as suggested by Peter). The only missing piece for that is
> supporting pmd_swp_exclusive() on relevant architectures with THP
> migration support.
> 
> As all relevant architectures now implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE,,
> we can drop __HAVE_ARCH_PTE_SWP_EXCLUSIVE in the last patch.
> 
> 
> RFC because some of the swap PTE layouts are really tricky and I really
> need some feedback related to deciphering these layouts and "using yet
> unused PTE bits in swap PTEs". I tried cross-compiling all relevant setups
> (phew, I might only miss some power/nohash variants), but only tested on
> x86 so far.

As I was messing with sparc64 either way and got debian to boot under 
QEMU, I verified that the sparc64 change also seems to work as expected 
(under sun4u).

-- 
Thanks,

David / dhildenb

