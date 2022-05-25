Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C46C433EF
	for <openrisc@archiver.kernel.org>; Fri, 27 May 2022 22:15:17 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 20612205C5;
	Sat, 28 May 2022 00:15:16 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mail.librecores.org (Postfix) with ESMTPS id 12CA6247C8
 for <openrisc@lists.librecores.org>; Wed, 25 May 2022 14:44:21 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id l82so12479351qke.3
 for <openrisc@lists.librecores.org>; Wed, 25 May 2022 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w0F6iR9EKs/zIprBUHWYk0xdfCPICb6b6FOC3ooI/Qg=;
 b=LMEKNyEIRYPV5QWJlwplZCx+Yze+80z3MALcLFPz5jKdddgbR28N/X6bo9Jvgd00MP
 WWkcUcb1+z91voFM8WjtduJpm5pvevvusNqH0PzjaxsPqwHpEmvLG6H17fO8d+8uqQ/c
 xW/rbo+trH8MjL1X/foXOCmesnHHx99Tmug43Nb91EXZFTR7KAdlglnJRYtL1NUTbXz5
 2CGVavB8u5eJ5bdNx8JVu0TNi6KB2NiCnWSVtKfIEdRU3i4wp/Kah2nDHcLAJXmplYfJ
 xzofRGg4rofGSre9mJv/qm1XS4Pms5gIR+r4L8hjS8Owdd3qkT56i/sicOD/din7w+oO
 VJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w0F6iR9EKs/zIprBUHWYk0xdfCPICb6b6FOC3ooI/Qg=;
 b=rld1syyTviC7jh3Rzf1MXBqzDqoRzD3nVuM1jL2tWtKAzRV+RzNXpT4WRqncjV8iBs
 CPf+8gp1Sr5lrkEeXk008AhJhcfG+OKG2KIyTC0JUOhXFgQ95G7UMGeCXvuc+viHK2nV
 GuLlUyb2DycpsBQ9U65Qp2atvHNraNHEIduSpONsO3ir7T4IYbWJBdmCLg7fF9Pp9xEm
 kRey97S4Q/nLz5AhHCoxv5SgO0f1mW62CcVAMRRqp1R1ADxyFICiSuaHo+/U/Wdt+3A9
 xcL1ei1qriUPUsYEzKJ9X2Hj2Yjfp3vRbZXRjkqGYtUwWUwEdQEknOsyjnW2ov+/KQ+J
 9GnA==
X-Gm-Message-State: AOAM532nnoOyc/mUMEijOcVpeX4euCR2g6CgveokI17MRlI+S86Kt5JM
 Mdqf0Xn/T22trE2h7ZuSC5I+bw==
X-Google-Smtp-Source: ABdhPJx/POKWSCbmzd2neCxXDwISwEb1wGzjcuEavupLeI/smDQTCNVGAU9PwpCoNv+A6qxiW2wj4Q==
X-Received: by 2002:a05:620a:4047:b0:6a0:5dae:ad67 with SMTP id
 i7-20020a05620a404700b006a05daead67mr19946570qko.530.1653482659851; 
 Wed, 25 May 2022 05:44:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
 by smtp.gmail.com with ESMTPSA id
 g25-20020ac870d9000000b002f9433ed963sm1207797qtp.64.2022.05.25.05.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 May 2022 05:44:19 -0700 (PDT)
Date: Wed, 25 May 2022 08:44:18 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <Yo4kojxZfjNiZI7/@cmpxchg.org>
References: <20220524234531.1949-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
X-Mailman-Approved-At: Sat, 28 May 2022 00:15:15 +0200
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
Cc: x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>, Will Deacon <will@kernel.org>,
 linux-riscv@lists.infradead.org,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>,
 Matt Turner <mattst88@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Brian Cain <bcain@quicinc.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Weinberger <richard@nod.at>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 Dinh Nguyen <dinguyen@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sven Schnelle <svens@linux.ibm.com>, Guo Ren <guoren@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Borislav Petkov <bp@alien8.de>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, May 24, 2022 at 07:45:31PM -0400, Peter Xu wrote:
> I observed that for each of the shared file-backed page faults, we're very
> likely to retry one more time for the 1st write fault upon no page.  It's
> because we'll need to release the mmap lock for dirty rate limit purpose
> with balance_dirty_pages_ratelimited() (in fault_dirty_shared_page()).
> 
> Then after that throttling we return VM_FAULT_RETRY.
> 
> We did that probably because VM_FAULT_RETRY is the only way we can return
> to the fault handler at that time telling it we've released the mmap lock.
> 
> However that's not ideal because it's very likely the fault does not need
> to be retried at all since the pgtable was well installed before the
> throttling, so the next continuous fault (including taking mmap read lock,
> walk the pgtable, etc.) could be in most cases unnecessary.
> 
> It's not only slowing down page faults for shared file-backed, but also add
> more mmap lock contention which is in most cases not needed at all.
> 
> To observe this, one could try to write to some shmem page and look at
> "pgfault" value in /proc/vmstat, then we should expect 2 counts for each
> shmem write simply because we retried, and vm event "pgfault" will capture
> that.
> 
> To make it more efficient, add a new VM_FAULT_COMPLETED return code just to
> show that we've completed the whole fault and released the lock.  It's also
> a hint that we should very possibly not need another fault immediately on
> this page because we've just completed it.
> 
> This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> program sequentially dirtying 400MB shmem file being mmap()ed and these are
> the time it needs:
> 
>   Before: 650.980 ms (+-1.94%)
>   After:  569.396 ms (+-1.38%)
> 
> I believe it could help more than that.
> 
> We need some special care on GUP and the s390 pgfault handler (for gmap
> code before returning from pgfault), the rest changes in the page fault
> handlers should be relatively straightforward.
> 
> Another thing to mention is that mm_account_fault() does take this new
> fault as a generic fault to be accounted, unlike VM_FAULT_RETRY.
> 
> I explicitly didn't touch hmm_vma_fault() and break_ksm() because they do
> not handle VM_FAULT_RETRY even with existing code, so I'm literally keeping
> them as-is.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
