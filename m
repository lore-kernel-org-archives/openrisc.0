Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51BC433EF
	for <openrisc@archiver.kernel.org>; Mon, 30 May 2022 15:53:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 591122412D;
	Mon, 30 May 2022 17:53:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id B515523E0C
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 17:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653925982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bDYue/Afd3VGZHzU7tYF7qy5xBeBUpqe85rLuoAiRcE=;
 b=AkXHNJKvAQRHb5OqI+OhXnw4AlFTHU7SQ25I25r8DrkTB9nwXx2U3S7uy3yWEhfxPKMgZ0
 MCHoCCU4ElbTk7DKNd2mXmRpWE6tOdwsDRWpn7scMraYzymGuve2EYFM1vMWpJYkKpJQS0
 OjtcJUf23O2R/uhMV8v3cei4In0oe2Y=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-OSyAMyJtPYWTE99-BY83-Q-1; Mon, 30 May 2022 11:53:01 -0400
X-MC-Unique: OSyAMyJtPYWTE99-BY83-Q-1
Received: by mail-io1-f72.google.com with SMTP id
 u7-20020a05660229a700b006657df613cbso5650620ios.14
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 08:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bDYue/Afd3VGZHzU7tYF7qy5xBeBUpqe85rLuoAiRcE=;
 b=8Fmz63Wmazw58sQet20KzazyBd4sRMU1xb9eerpixkP8fFNblNeZZN0/0+SuMCGF22
 e7+nQ1cwINklbzTrp6Ia0VNFWmwW8i1WsPsCMLYNA0qGAzkcAyn3e4ez/MYwxF89QBal
 ZkbPZEn9zAf+hSyiCzM3uDPyN2hjc7CV+FpYe9Yt7FpeRHmCc2A+ybm8zayi9YZ8zr/1
 9M5R2SDRWSBnljAXZWO+JNwEmnfAxg95a7/Lk7lsoGhwbh6MaWGSuTsEpTm9dQyHTx3+
 vFFyU0RSVgCF27gwd/gME+782Jzn36EK2LfSQ4RWUa238YitpBf0LH+p/E/R9DSmXfEX
 lkSw==
X-Gm-Message-State: AOAM531KpdwvCER9DsO4tnkkeJdGuDnmeGjSdPkD7M+n4W7q55BelIuX
 gkiGUhEcn/ajAEsdJDXXLpY2JWNjqpAeMe20ome1GI4honhBAYqGbUtaccQJwHXJTYOQvaLSC8t
 mvpkFK3kX7eWa4KeZLyajPRbgaA==
X-Received: by 2002:a5d:9cc8:0:b0:663:2899:4b8 with SMTP id
 w8-20020a5d9cc8000000b00663289904b8mr16857403iow.192.1653925980597; 
 Mon, 30 May 2022 08:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKQIoyyqGc41UCjMUnObS0GZ5Lh8IPSVLY8KDGIOa5YRMfMwdzANPXLWIG/1E7oUnwvcvO1w==
X-Received: by 2002:a5d:9cc8:0:b0:663:2899:4b8 with SMTP id
 w8-20020a5d9cc8000000b00663289904b8mr16857337iow.192.1653925980357; 
 Mon, 30 May 2022 08:53:00 -0700 (PDT)
Received: from xz-m1.local
 (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
 by smtp.gmail.com with ESMTPSA id
 66-20020a021d45000000b0032e75bfe344sm2781109jaj.171.2022.05.30.08.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 08:52:59 -0700 (PDT)
Date: Mon, 30 May 2022 11:52:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpToVpjXmdFqGOpY@xz-m1.local>
References: <20220527193936.30678-1-peterx@redhat.com>
 <YpPYkzbrQmy4FjrI@osiris>
 <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
 David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-mips@vger.kernel.org,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Guo Ren <guoren@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul Mackerras <paulus@samba.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Janosch Frank <frankja@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-xtensa@linux-xtensa.org,
 Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
 Chris Zankel <chris@zankel.net>, Heiko Carstens <hca@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-um@lists.infradead.org,
 Nicholas Piggin <npiggin@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Richard Henderson <rth@twiddle.net>, Brian Cain <bcain@quicinc.com>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>, Dinh Nguyen <dinguyen@kernel.org>,
 linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-alpha@vger.kernel.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, May 30, 2022 at 11:35:10AM +0200, Christian Borntraeger wrote:
> 
> 
> Am 29.05.22 um 22:33 schrieb Heiko Carstens:
> [...]
> > 
> > Guess the patch below on top of your patch is what we want.
> > Just for clarification: if gmap is not NULL then the process is a kvm
> > process. So, depending on the workload, this optimization makes sense.
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index 4608cc962ecf..e1d40ca341b7 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >   	/* The fault is fully completed (including releasing mmap lock) */
> >   	if (fault & VM_FAULT_COMPLETED) {
> > -		/*
> > -		 * Gmap will need the mmap lock again, so retake it.  TODO:
> > -		 * only conditionally take the lock when CONFIG_PGSTE set.
> > -		 */
> > -		mmap_read_lock(mm);
> > -		goto out_gmap;
> > +		if (gmap) {
> > +			mmap_read_lock(mm);
> > +			goto out_gmap;
> > +		}
> > +		goto out;
> 
> Yes, that makes sense. With that
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Looks sane, thanks Heiko, Christian.  I'll cook another one.

-- 
Peter Xu

