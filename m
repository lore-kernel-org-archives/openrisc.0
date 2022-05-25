Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DCAC4332F
	for <openrisc@archiver.kernel.org>; Wed, 25 May 2022 08:04:12 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 30CB2240FC;
	Wed, 25 May 2022 10:04:11 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mail.librecores.org (Postfix) with ESMTPS id 3139C20CE9
 for <openrisc@lists.librecores.org>; Wed, 25 May 2022 10:04:10 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id x7so13221336qta.6
 for <openrisc@lists.librecores.org>; Wed, 25 May 2022 01:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AP6YAmjuideizUL7mupGqzQ5PgkASmXHUBF+HT7ISso=;
 b=I+1I3ep2tSp4H2KYNwYqDv2FTgaSMLoULwpWQ+CUtPdPnaOBdgKfyF/c5L4FvLzHvW
 QLX8hcsxA0ohlbbf7vnqeOmhJe+ajCINcGnU+f3oHrhb3/SpIwsXXCKqelQfcH5a3jEm
 X78F5UiYtcrqNobIqSvn/vQeNZuJ/u+sKzWVKemqNbdsMYlXZ1fjxi5B6dz+Rqkp5+AR
 18UjWLDZhkjjuo1wtwb4nFq9ERYNYNi6cfbEOS2uzyFniG6SqdQkUPmuYPsK68HID0FZ
 Ss0UVhsu8WvT5q+LrPWbQ5s4J2weeX1VF+vadAtFThJJhaC0ZO01W8EBdYpZA7d78vD3
 iq/Q==
X-Gm-Message-State: AOAM531JxSVGHT5oNM8amiw9kEKFFrjnLsihKrJnsysXI3XXvx/t2+cK
 nEEUmZ1sgKZqf5crLAc7tLiesVZUpHGs+g==
X-Google-Smtp-Source: ABdhPJzmbgBrsbmr8opHh548rayRtb/eELgor+IbT79u52CXP/ChB5g/4LG/gPSFmFQ7cQl0I6b0mg==
X-Received: by 2002:ac8:4e8c:0:b0:2f3:d53a:add3 with SMTP id
 12-20020ac84e8c000000b002f3d53aadd3mr11834644qtp.300.1653465848960; 
 Wed, 25 May 2022 01:04:08 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com.
 [209.85.219.169]) by smtp.gmail.com with ESMTPSA id
 w14-20020ac86b0e000000b002f39b99f670sm945278qts.10.2022.05.25.01.04.05
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 May 2022 01:04:07 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id l32so895355ybe.12
 for <openrisc@lists.librecores.org>; Wed, 25 May 2022 01:04:05 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr30228977ybu.604.1653465845434; Wed, 25
 May 2022 01:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220524234531.1949-1-peterx@redhat.com>
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 May 2022 10:03:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpCUGXn=KzfpfZqResRR41XkBKZiQQVo_O_Hq+KMcDKg@mail.gmail.com>
Message-ID: <CAMuHMdWpCUGXn=KzfpfZqResRR41XkBKZiQQVo_O_Hq+KMcDKg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
 Linux MM <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>, Will Deacon <will@kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
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
 Heiko Carstens <hca@linux.ibm.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Weinberger <richard@nod.at>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sven Schnelle <svens@linux.ibm.com>, Guo Ren <guoren@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Borislav Petkov <bp@alien8.de>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, May 25, 2022 at 1:45 AM Peter Xu <peterx@redhat.com> wrote:
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

>  arch/m68k/mm/fault.c          |  4 ++++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
