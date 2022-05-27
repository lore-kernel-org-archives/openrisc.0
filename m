Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC7CC433EF
	for <openrisc@archiver.kernel.org>; Fri, 27 May 2022 10:46:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2CACC247C4;
	Fri, 27 May 2022 12:46:37 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by mail.librecores.org (Postfix) with ESMTPS id 103562431F
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 12:46:36 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id m20so7894961ejj.10
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VEAekRrz/FSY4pk4QnV3m6H5QVjhz8BFDYr0EcpVw1E=;
 b=nXTl96gpCDbYy3bbmZHUFxanwBKanpTD5T3ye91nNt0S5DzRS50X+C3V5calou/Tbd
 W3tp+Pa5ui5nyk/J9IilzxqUhKzX+QyGcukjZk0ELfa/RtKrZMaq9i+yE1j0RcYeHGEH
 V+4RtLXDWPxnAymJMfcVpu0JZEZoxenwNXkmgyYKMQXGnN1Ls7NkOSx9TgW4IEazH0HS
 TOy4lNsQjFRd71dz5D/Ux8BGGU+UgNurAc7P2zcBMC8bJFwbS5pJWekOq461oc+DsRDd
 eh87WbfBiCTIu2NxwA+S3LoC7J0WxrnESI1Jt77XHjKjToAke3bka2tT28oXpFfiDYxk
 GFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=VEAekRrz/FSY4pk4QnV3m6H5QVjhz8BFDYr0EcpVw1E=;
 b=Ys0eRtOoanttAAbyRmgvUhOf1dORCJ4ngrpSeqCNx032O2sf9donmzsmKsq7Mr+8DM
 XCCc6mX69Ym93O/y+BrDgMmtx3el3HuV2XtZwmn99RQjftMhislhCjOrFcDiqtvA1Oml
 1gSvizRsR6PZ5q8klKVo+obJM0LGBOSZw80l489N2/ajb/imc70xSTmOb1ILs7IqQ+jT
 ZMksD4Fl3D2ZG5DjkxAplMSmPN64E5hkq8G5+OI9xJ2wvSUjRBY6cExcH9e7mN3a0ZgN
 TD7lxngfeYTIe/+Voi8hWlkyULpIyC1VTV3dc6o5HylPaC+H1tNaPSyIDqzahM6kpFQi
 0Mig==
X-Gm-Message-State: AOAM532pXe8jSLR4TRE9B6g2mR2pkgs0eh6pz6GJ3pisaMTo/O7suh7l
 ZDPREWsBNf/2jc4QHYvD7WQ=
X-Google-Smtp-Source: ABdhPJyWn7wVchQLELsEVq6TA/gUzEaBn19VUAXtFTYBInhQr0sSQqMx29HcpQwhBHqmmOM8Z+iT0g==
X-Received: by 2002:a17:907:7baa:b0:6fe:b3dc:2378 with SMTP id
 ne42-20020a1709077baa00b006feb3dc2378mr30766036ejc.266.1653648395645; 
 Fri, 27 May 2022 03:46:35 -0700 (PDT)
Received: from gmail.com (563BA16F.dsl.pool.telekom.hu. [86.59.161.111])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a17090639d400b006fec1a73e48sm1320742eje.64.2022.05.27.03.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:46:34 -0700 (PDT)
Date: Fri, 27 May 2022 12:46:31 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpCsBwFArieTpvg2@gmail.com>
References: <20220524234531.1949-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
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
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 Dinh Nguyen <dinguyen@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sven Schnelle <svens@linux.ibm.com>, Guo Ren <guoren@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Borislav Petkov <bp@alien8.de>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>


* Peter Xu <peterx@redhat.com> wrote:

> This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> program sequentially dirtying 400MB shmem file being mmap()ed and these are
> the time it needs:
>
>   Before: 650.980 ms (+-1.94%)
>   After:  569.396 ms (+-1.38%)

Nice!

>  arch/x86/mm/fault.c           |  4 ++++

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Minor comment typo:

> +		/*
> +		 * We should do the same as VM_FAULT_RETRY, but let's not
> +		 * return -EBUSY since that's not reflecting the reality on
> +		 * what has happened - we've just fully completed a page
> +		 * fault, with the mmap lock released.  Use -EAGAIN to show
> +		 * that we want to take the mmap lock _again_.
> +		 */

s/reflecting the reality on what has happened
 /reflecting the reality of what has happened

>  	ret = handle_mm_fault(vma, address, fault_flags, NULL);
> +
> +	if (ret & VM_FAULT_COMPLETED) {
> +		/*
> +		 * NOTE: it's a pity that we need to retake the lock here
> +		 * to pair with the unlock() in the callers. Ideally we
> +		 * could tell the callers so they do not need to unlock.
> +		 */
> +		mmap_read_lock(mm);
> +		*unlocked = true;
> +		return 0;

Indeed that's a pity - I guess more performance could be gained here, 
especially in highly parallel threaded workloads?

Thanks,

	Ingo
