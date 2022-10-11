Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C268C4332F
	for <openrisc@archiver.kernel.org>; Wed, 12 Oct 2022 16:51:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7525A24786;
	Wed, 12 Oct 2022 18:51:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 278FE24BCC
 for <openrisc@lists.librecores.org>; Tue, 11 Oct 2022 18:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665505336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gv22bmoTax0J0zhnmYTJUdzNvY/rZYRIc0hd8rouMg=;
 b=jHF6JUnuS1iw6uZ0sq4yfF5yGJjc9LzpyDYOYBfAsfhSPdVGo8jlPXULrqux57MQ1eGQpT
 +4Au/9AqiO1qyyRMD1Zzity73MlaJtg6H8ZWRlo5qyOVtjnTloOagF4QyQ/X5nmAXUerCO
 0ch3tbgsF4961TloCZEkprFhwj8Wqyg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-478-odnbB1WWMYO6YWf0ZINyyA-1; Tue, 11 Oct 2022 12:22:07 -0400
X-MC-Unique: odnbB1WWMYO6YWf0ZINyyA-1
Received: by mail-ed1-f71.google.com with SMTP id
 i17-20020a05640242d100b0044f18a5379aso11771861edc.21
 for <openrisc@lists.librecores.org>; Tue, 11 Oct 2022 09:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6gv22bmoTax0J0zhnmYTJUdzNvY/rZYRIc0hd8rouMg=;
 b=uKgJAp6YjoavX7XvrNIbLXUS7/a6Ch3CRSG1ZrK0wr1dDpTQ5jszn1cJ9HrxmpPca/
 On5JZaJP6olCdZP62bIygpyO382EPPrmIEsOOjZPRsci1Qb9KRy5WS0s88w6jqA+nC4w
 zenbqU9kC5naPV36KGAgXJUgro+Ojw3f62ZxBpiUhx5fg0h7cpOaMHShSJWMRdEUi1YB
 ndoTtCDrPtxtgtp7ZvEux7b8zU4CgF6l+MaNg3Mt6YOoIHJDWETm16L0LCQlmF8mgeKx
 84EjFRWFCZfT2vKHIMQaZB40HJQ7cfx2618bMTQju4baZgEfEvQiCYR+k5WB4eBPArzA
 cEjg==
X-Gm-Message-State: ACrzQf0Y6/op1euEDY1AF3r8sQfHHWRePWpZCY1cY9cIwJZHiZUrEqW5
 ga8YqosCohvVE0H0yfXP84CLkKE4JA0FI+Oa5/Q3kMInAV+a3D8WxeITgysoWqtR5/Iubyy2Ir9
 eodpMGmr9nHxDObtHIbo9LoEKsw==
X-Received: by 2002:a17:907:2712:b0:78d:a223:729b with SMTP id
 w18-20020a170907271200b0078da223729bmr11697157ejk.443.1665505326058; 
 Tue, 11 Oct 2022 09:22:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5z3+5ecaWwqYPDE234CAcuf3hKc1qLTNOp8VUNiMDwybT1F6EbMEGGKCCgL+v4lylioGXOig==
X-Received: by 2002:a17:907:2712:b0:78d:a223:729b with SMTP id
 w18-20020a170907271200b0078da223729bmr11697097ejk.443.1665505325743; 
 Tue, 11 Oct 2022 09:22:05 -0700 (PDT)
Received: from [192.168.0.198] (host-79-47-205-133.retail.telecomitalia.it.
 [79.47.205.133]) by smtp.gmail.com with ESMTPSA id
 xf13-20020a17090731cd00b00730b3bdd8d7sm7273113ejb.179.2022.10.11.09.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Oct 2022 09:22:05 -0700 (PDT)
Message-ID: <3e680bb9-9896-3665-dd59-4f2e6f8205bb@redhat.com>
Date: Tue, 11 Oct 2022 18:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 0/5] Generic IPI sending tracepoint
To: Valentin Schneider <vschneid@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
 <Y0CFnWDpMNGajIRD@fuller.cnet> <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 12 Oct 2022 18:51:41 +0200
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Nicholas Piggin <npiggin@gmail.com>,
 loongarch@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 Douglas RAILLARD <douglas.raillard@arm.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 10/11/22 18:17, Valentin Schneider wrote:
> Thinking out loud, it makes way more sense to record a cpumask in the
> tracepoint, but perhaps we could have a postprocessing step to transform
> those into N events each targeting a single CPU?

My approach on the tracers/rtla is to make the simple things in kernel, and beautify
things in user-space.

You could keep the tracepoint as a mask, and then make it pretty, like cpus=3-5,8
in user-space. For example with a trace-cmd/perf loadable plugin, libtracefs helper.

For rtla I was thinking to make a new tool to parse them. and make it pretty there.

-- Daniel

