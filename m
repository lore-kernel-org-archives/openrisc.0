Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA5C5479D
	for <openrisc@archiver.kernel.org>; Mon,  9 Jan 2023 19:02:22 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1218E229F3;
	Mon,  9 Jan 2023 20:02:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id 87CC4229F3
 for <openrisc@lists.librecores.org>; Mon,  9 Jan 2023 20:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673290938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mHlpuxTK3Q4mXdtUEAjHx/X4tIty+fqRI+m6xngZY9c=;
 b=AMKetqY2wJ0PNcucelDqLnMCoLTvsNyEB3MH1dhrZAv1J63KXnKQLo9tEUlbV0rJxsjmoM
 KyfXVnPawh7lJmzsqJJVny6kebidM0iBpRjJcDsujWZ9NRrBefAAtD7vsZPhCTbDkfBP4G
 sOJCIlhOPkHWorrbGgsD5tx3084y1Pg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365-XmKJ9cZ0PKKx3fmEOqO6Kw-1; Mon, 09 Jan 2023 14:02:16 -0500
X-MC-Unique: XmKJ9cZ0PKKx3fmEOqO6Kw-1
Received: by mail-yb1-f197.google.com with SMTP id
 a14-20020a5b0ace000000b007bf99065fcbso1941820ybr.2
 for <openrisc@lists.librecores.org>; Mon, 09 Jan 2023 11:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mHlpuxTK3Q4mXdtUEAjHx/X4tIty+fqRI+m6xngZY9c=;
 b=nnKDFw1Am2ea0d8/hBhF5XNVAhqs8PMYfG+QE6CrToeEj/Yv1+gnVkVytk/FicIJdX
 uGSJ7/avcWU8u73vsd5iPkLjXsopAKKrqzGbn1JZsDzdN1IhJfwToLb8DsK1d4fSHbZq
 z5eI3ckfThBl/W4ZrGsidBNC8dFQMLViPhYOQjraqrZp+OtUchFjjF2A8Ie/DcqRrCNx
 xfXv2Q/hMcqgougyThXkAcFmqNC5CILhb30coFFmypEd1I7sbGekFGKgc7VPBT8J7KZI
 26HGmspGRoZlDA9wBlcNL+AiEMzONQBhX3/N9ofMdTFQGrP7ToVHMOwmvKD0O8oVZcNR
 Fkgg==
X-Gm-Message-State: AFqh2kqUNYyXlODext/hnaBsM9shRjrigvY9KbAnrf/qMUJTqqGvHyJu
 l+hulsfIJkz/B/XB3OFkr6kcAphdbz2JFWvIw2fb+ayspPWOhtj6IHbzu1wBIWUxo09flbqF6jr
 sPsfirPQAG/eb0Miqy1RmFrH2SA==
X-Received: by 2002:a05:7500:5c96:b0:f0:f14:b4f6 with SMTP id
 fh22-20020a0575005c9600b000f00f14b4f6mr1334317gab.55.1673290935392; 
 Mon, 09 Jan 2023 11:02:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvpgx9uVCbTytxfSzpNGAx1CCCprwK9dYT+w5TdWAjmS9/Yvcm6uASOc9C3qqyAspkLlpcI4w==
X-Received: by 2002:a05:7500:5c96:b0:f0:f14:b4f6 with SMTP id
 fh22-20020a0575005c9600b000f00f14b4f6mr1334309gab.55.1673290934985; 
 Mon, 09 Jan 2023 11:02:14 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
 by smtp.gmail.com with ESMTPSA id
 az31-20020a05620a171f00b006fbbdc6c68fsm5795671qkb.68.2023.01.09.11.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jan 2023 11:02:14 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 3/8] sched, smp: Trace IPIs sent via
 send_call_function_single_ipi()
In-Reply-To: <Y7lRz7oCaAmAhoqS@gmail.com>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-4-vschneid@redhat.com>
 <Y7lRz7oCaAmAhoqS@gmail.com>
Date: Mon, 09 Jan 2023 19:02:08 +0000
Message-ID: <xhsmh4jszedlb.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.29
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Nicholas Piggin <npiggin@gmail.com>,
 loongarch@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 07/01/23 12:04, Ingo Molnar wrote:
> * Valentin Schneider <vschneid@redhat.com> wrote:
>
>> send_call_function_single_ipi() is the thing that sends IPIs at the bottom
>> of smp_call_function*() via either generic_exec_single() or
>> smp_call_function_many_cond(). Give it an IPI-related tracepoint.
>> 
>> Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
>> which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".
>> 
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Acked-by: Ingo Molnar <mingo@kernel.org>
>
> Patch series logistics:
>
>  - No objections from the scheduler side, this feature looks pretty useful.
>

Thanks!

>  - Certain patches are incomplete, others are noted as being merged 
>    separately, so I presume you'll send an updated/completed series 
>    eventually?
>

The first patch from Steve is now in, so can drop it.

The other patches are complete, though I need to rebase them and regenerate
the treewide patch to catch any changes that came with 6.2. I'll do that
this week.

The "incompleteness" pointed out in the cover letter is about the types of
IPIs that can be traced. This series covers the ones that end up invoking
some core code (coincidentally those are the most common ones), others such
as e.g. tick_broadcast() for arm, arm64, riscv and hexagon remain
unaffected.

I'm not that much interested in these (other than maybe the tick broadcast
one they are all fairly unfrequent), but I'm happy to have a shot at them
for the sake of completeness - either in that series or in a followup, up
to you.  

>  - We can merge this via the scheduler tree I suspect, as most callbacks 
>    affected relate to tip:sched/core and tmp:smp/core - but if you have 
>    some other preferred tree that's fine too.
>

Either sound good to me.

> Thanks,
>
> 	Ingo

