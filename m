Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED96DC433FE
	for <openrisc@archiver.kernel.org>; Mon, 30 May 2022 18:29:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 893ED240FC;
	Mon, 30 May 2022 20:29:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id ED18E23E0C
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 20:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653935379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ALrzFnb0YEuDamJlOSrZjOy/DY+2J0hn9MNRn5A9C4=;
 b=HbBF2ajaufZl9/WUtxyDJxCGJ9BcRQz/emu2qDiECh2i5UBkeWh6TtnQT3PjvYY6l7es4L
 3G/Q11/CJkMBZz1hC5mVhwu/tKZIJ5EMd75pJNM4heYAIld/c/yvBrPTjjfZZIlZEMTa+c
 wzKHAMoIoP3+DAvw0soTcPl5tm37JoM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-_ssiL9j8PAOVHdlBl1BMtg-1; Mon, 30 May 2022 14:29:37 -0400
X-MC-Unique: _ssiL9j8PAOVHdlBl1BMtg-1
Received: by mail-il1-f198.google.com with SMTP id
 c1-20020a928e01000000b002d1b20aa761so8770534ild.6
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 11:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+ALrzFnb0YEuDamJlOSrZjOy/DY+2J0hn9MNRn5A9C4=;
 b=OkDxRtQfBGdL8J0PyMKhxNLzZZpJwiNL5+EEG6Y/1Xb5vZeHHWbm56JSxE+LLWGXfL
 WA7+blh3msDIg/XVjO0zd8VriSAwBiQhlgGFF+LlHFEFfCWh1XRPnRCoXawMX20LsLhK
 uwC4gnlyCpgSnQLGglPW9vJOs4/sgf6DpuICvY6L9Qo88qWaF7JrKKgPs2UyIaCvtO+e
 o9gaErtjfdFp2ln6zXeUKjVR5i0uY4belVVlkqhEKr6ZyNESU8QrqqKqn3cjYp2oHo7T
 2t0Lf+LbKhnAMMeR7kp2n5J7vFr6N4psK1+cf8iROf87ft+StAJSZVip4fJt++ny3Kav
 VJyQ==
X-Gm-Message-State: AOAM533Ke5yfnt71yxsveevukLWvvA3abRsHixSgX4oc6Pav7uDvrnGC
 KWBoYErRQLvEdQkLn5JHPY+agG6GIYumWTFOP0/JF79ClYp0hgmRTN0ylkq6tI1r4cbcvdwigWB
 JxrdGb+CKyYMGsYZzJVSXrpm0xQ==
X-Received: by 2002:a92:d785:0:b0:2d1:7ce6:b834 with SMTP id
 d5-20020a92d785000000b002d17ce6b834mr25171917iln.207.1653935377091; 
 Mon, 30 May 2022 11:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3wrc9ZuPCRdn+Dbnr8a7+sDY/SXALiOk3qZ3Cm9Rs8SSVa+bj9UHR0EABkWjwoIvWxsPXBw==
X-Received: by 2002:a92:d785:0:b0:2d1:7ce6:b834 with SMTP id
 d5-20020a92d785000000b002d17ce6b834mr25171841iln.207.1653935376794; 
 Mon, 30 May 2022 11:29:36 -0700 (PDT)
Received: from xz-m1.local
 (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
 by smtp.gmail.com with ESMTPSA id
 cn9-20020a0566383a0900b003313b7a5731sm183095jab.178.2022.05.30.11.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 11:29:36 -0700 (PDT)
Date: Mon, 30 May 2022 14:29:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpUNC6iGrZRlWMyA@xz-m1.local>
References: <20220527193936.30678-1-peterx@redhat.com>
 <YpPYkzbrQmy4FjrI@osiris>
 <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
 <YpToVpjXmdFqGOpY@xz-m1.local> <YpTqNKMTt8PoA41n@xz-m1.local>
 <YpT443jVZtM6p9OD@osiris>
MIME-Version: 1.0
In-Reply-To: <YpT443jVZtM6p9OD@osiris>
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
 Chris Zankel <chris@zankel.net>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Weinberger <richard@nod.at>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Ingo Molnar <mingo@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Richard Henderson <rth@twiddle.net>,
 Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 Dinh Nguyen <dinguyen@kernel.org>, linux-riscv@lists.infradead.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-alpha@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, May 30, 2022 at 07:03:31PM +0200, Heiko Carstens wrote:
> On Mon, May 30, 2022 at 12:00:52PM -0400, Peter Xu wrote:
> > On Mon, May 30, 2022 at 11:52:54AM -0400, Peter Xu wrote:
> > > On Mon, May 30, 2022 at 11:35:10AM +0200, Christian Borntraeger wrote:
> > > > > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > > > > index 4608cc962ecf..e1d40ca341b7 100644
> > > > > --- a/arch/s390/mm/fault.c
> > > > > +++ b/arch/s390/mm/fault.c
> > > > > @@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> > > > >   	/* The fault is fully completed (including releasing mmap lock) */
> > > > >   	if (fault & VM_FAULT_COMPLETED) {
> > > > > -		/*
> > > > > -		 * Gmap will need the mmap lock again, so retake it.  TODO:
> > > > > -		 * only conditionally take the lock when CONFIG_PGSTE set.
> > > > > -		 */
> > > > > -		mmap_read_lock(mm);
> > > > > -		goto out_gmap;
> > > > > +		if (gmap) {
> > > > > +			mmap_read_lock(mm);
> > > > > +			goto out_gmap;
> > > > > +		}
> 			fault = 0;  <----
> > > > > +		goto out;
> > 
> > Hmm, right after I replied I found "goto out" could be problematic, since
> > all s390 callers of do_exception() will assume it an error condition (side
> > note: "goto out_gmap" contains one step to clear "fault" to 0).  I'll
> > replace this with "return 0" instead if it looks good to both of you.
> > 
> > I'll wait for a confirmation before reposting.  Thanks,
> 
> Right, that was stupid. Thanks for double checking!
> 
> However could you please add "fault = 0" just in front of the goto out
> like above? I'd like to avoid having returns and gotos mixed.

Sure thing.

-- 
Peter Xu

