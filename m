Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B63C4332F
	for <openrisc@archiver.kernel.org>; Thu, 17 Nov 2022 14:24:06 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id EA88424786;
	Thu, 17 Nov 2022 15:24:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 1830220CD6
 for <openrisc@lists.librecores.org>; Thu, 17 Nov 2022 15:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668695044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ero3Dop74ZUrxw/cst3yMxEJhDrRdAAQvlUsX3escHg=;
 b=EiyWF2bGgWI+mcYml0p3NT1eUHswn0yo8fN97sETrVTu0yNhR8B9fISPaU7QyJH/skF9+S
 g5l3gbBMW2kBvyKzEtuKkZoui8g6ZMh5oMWucmQ3QANBwlHB97EZ6X1Yt4rX+boerqHC2U
 2WbHL7ExO/PAM0If3bHFiTYW/fkXcoQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-Gifh-hFuM8eOK2dLuRiL_A-1; Thu, 17 Nov 2022 09:24:01 -0500
X-MC-Unique: Gifh-hFuM8eOK2dLuRiL_A-1
Received: by mail-wm1-f71.google.com with SMTP id
 o5-20020a05600c510500b003cfca1a327fso701416wms.8
 for <openrisc@lists.librecores.org>; Thu, 17 Nov 2022 06:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ero3Dop74ZUrxw/cst3yMxEJhDrRdAAQvlUsX3escHg=;
 b=gcY2z9UqYhS1+oZhJN4j2gyV1hr98ihFzAGrnzFJOCdQpYa7h1k478rxng9wW5z0yI
 WLfMoSishF3qcu9GAmG8j9S1pX6bw0p4t2/1b9hdVwh+u5XDeGJ3oh2CeJcGQ44B+099
 l2PTz/thKfjbgl0f/LW0wztxReR61WjoQLPQ/3B9Vv05NYcw0FSyH4QFhreGB+coZCjz
 vXj0i+sgal2/0dtUAk4zG+J2q0eiWQquG7NyEbWlxTmZ1k6cekA43ICpDMYFWHfkidw3
 FPsEVPgALU2fempg2AeOyKuohTpWIFp8o3/vO9+ajUGGFbqYKTsIT/rwb86BfhojgykR
 romg==
X-Gm-Message-State: ANoB5pmStD/tcD0QoKGxicfcabH1KBFd2yDSzE2PGm4rfkdxNTv7pboE
 8xb81tzhD2WpTuaAvU0PGNC4/ITtfSk5rFtHHRgXmPfDstPLxkFumR7nToU/xlWcB5t5SKTVR3L
 TvUJP9fi4fVRT1MEHHFZkk4VPvA==
X-Received: by 2002:a5d:58fb:0:b0:236:74c5:1b2d with SMTP id
 f27-20020a5d58fb000000b0023674c51b2dmr1616731wrd.14.1668695040746; 
 Thu, 17 Nov 2022 06:24:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7dCrVGloFO6BdNbsi4gADz4iCuS/nJ5b5vEmtvQw4WeirpWLMINwzrWmZ6QxU1sPuLDe40QQ==
X-Received: by 2002:a5d:58fb:0:b0:236:74c5:1b2d with SMTP id
 f27-20020a5d58fb000000b0023674c51b2dmr1616704wrd.14.1668695040586; 
 Thu, 17 Nov 2022 06:24:00 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
 by smtp.gmail.com with ESMTPSA id
 t11-20020adff60b000000b0022e035a4e93sm1096445wrp.87.2022.11.17.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Nov 2022 06:23:59 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 4/8] smp: Trace IPIs sent via
 arch_send_call_function_ipi_mask()
In-Reply-To: <Y3X5/65o8127DgZl@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-3-vschneid@redhat.com>
 <Y3X5/65o8127DgZl@hirez.programming.kicks-ass.net>
Date: Thu, 17 Nov 2022 14:23:55 +0000
Message-ID: <xhsmhk03ty804.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 17/11/22 10:08, Peter Zijlstra wrote:
> On Wed, Nov 02, 2022 at 06:33:32PM +0000, Valentin Schneider wrote:
>> This simply wraps around the arch function and prepends it with a
>> tracepoint, similar to send_call_function_single_ipi().
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/smp.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index e2ca1e2f31274..c4d561cf50d45 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -160,6 +160,13 @@ void __init call_function_init(void)
>>      smpcfd_prepare_cpu(smp_processor_id());
>>  }
>>
>> +static inline void
>
> Given the use of _RET_IP_, I would strongly recommend you use
> __always_inline.
>

Noted, thanks

>> +send_call_function_ipi_mask(const struct cpumask *mask)
>> +{
>> +	trace_ipi_send_cpumask(mask, _RET_IP_, func);
>
> What's func?
>

A rebase fail... That's only plugged in later.

>> +	arch_send_call_function_ipi_mask(mask);
>> +}

