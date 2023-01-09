Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D6C5479D
	for <openrisc@archiver.kernel.org>; Mon,  9 Jan 2023 19:01:32 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DED5B215C3;
	Mon,  9 Jan 2023 20:01:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id EDDDE229F3
 for <openrisc@lists.librecores.org>; Mon,  9 Jan 2023 20:01:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673290889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bU+svoPcyEEDaWYmIcNec69dTXz5hTgyu3b7xJNjXUQ=;
 b=iflefN2DlMtAjzC/hgBZNZ/9Mxmuy6Mv2BQNZTP7HxFc9zBhjzmItsXKEXpOlFV6NJHpD+
 GPPIhzd6Ymwu5k1HOoNQYWJGVNx2+ka3tUCJlQno7GpZz1LDeT97uZvS3+lF22t4BeS+Bb
 6qMQQSPRl/T0/PxBUFv+HxfP3xpKYI4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-umn73bQROEWvV-HAvXb7Hw-1; Mon, 09 Jan 2023 14:01:28 -0500
X-MC-Unique: umn73bQROEWvV-HAvXb7Hw-1
Received: by mail-qt1-f200.google.com with SMTP id
 k7-20020ac84747000000b003a87ca26200so4260138qtp.6
 for <openrisc@lists.librecores.org>; Mon, 09 Jan 2023 11:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bU+svoPcyEEDaWYmIcNec69dTXz5hTgyu3b7xJNjXUQ=;
 b=A6amKE7RtAGzk/g7RH3GMRXVsE5N7nMRuzULiEjfdBKoGXdz9QrP+bAdh7yWn8zOnP
 tUjMORbKAgWfU++TCx/nmrUZmc6KtHEksMiko16B8fIMbdajWDWoeMLQhrgsb0HCSutV
 7yHrD6WUV6DAcrB32q1gLq5NCh9Nd9aB/Tclo3NHeCfQqmr54kxZpiiHnXqLZpD6yCSY
 JROT/0AmTvMcf93hAHHPvHzyKC5MBf6XIciy0PxiggdmzBEfYOefMC5ahHNMehtsNvRo
 EQakffLja1pF6LHpDl0KfhuRHAeFx6vlMie6AV7IqHY4Mqyj+w2RVZor5IpDOtubS7T+
 Nilw==
X-Gm-Message-State: AFqh2krQBp32R6jYghuVc6F2OG1rVJee++g2mNYxZdX+bLSArOLAEiby
 xAKQ7k9811lzvN30DNRQ3lJ+00sArsXRKCG1t5DlEJJpaSzENuDYqU3HHMvmiTZ22we8sTvJeUD
 b2KxX2yHkphwfFFTWIP0JoHbDuw==
X-Received: by 2002:ac8:7395:0:b0:3a7:ed31:a618 with SMTP id
 t21-20020ac87395000000b003a7ed31a618mr91336668qtp.7.1673290887984; 
 Mon, 09 Jan 2023 11:01:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXseRLv5+JCaBFPqzT7E7Yv2YOrloRSyhYUUSWRG6zA8srvH9gyrV5oV35teC9nwwkDxbanAYA==
X-Received: by 2002:ac8:7395:0:b0:3a7:ed31:a618 with SMTP id
 t21-20020ac87395000000b003a7ed31a618mr91336646qtp.7.1673290887764; 
 Mon, 09 Jan 2023 11:01:27 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
 by smtp.gmail.com with ESMTPSA id
 cj12-20020a05622a258c00b0039cc0fbdb61sm4985479qtb.53.2023.01.09.11.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jan 2023 11:01:27 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v3 6/8] treewide: Trace IPIs sent via smp_send_reschedule()
In-Reply-To: <CAAhV-H6Oii6t-4aHFjgPkCgFAd+LcVVg+7jMu_w4mEa0Ecuwaw@mail.gmail.com>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-7-vschneid@redhat.com>
 <CAAhV-H6Oii6t-4aHFjgPkCgFAd+LcVVg+7jMu_w4mEa0Ecuwaw@mail.gmail.com>
Date: Mon, 09 Jan 2023 19:01:22 +0000
Message-ID: <xhsmh5ydfedml.mognet@vschneid.remote.csb>
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
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David
 S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 08/01/23 20:17, Huacai Chen wrote:
> Hi, Valentin,
>
> On Fri, Dec 2, 2022 at 11:59 PM Valentin Schneider <vschneid@redhat.com> wrote:
>> @@ -83,7 +83,7 @@ extern void show_ipi_list(struct seq_file *p, int prec);
>>   * it goes straight through and wastes no time serializing
>>   * anything. Worst case is that we lose a reschedule ...
>>   */
>> -static inline void smp_send_reschedule(int cpu)
>> +static inline void arch_smp_send_reschedule(int cpu)
>>  {
>>         loongson_send_ipi_single(cpu, SMP_RESCHEDULE);
>>  }
> This function has been moved to arch/loongarch/kernel/smp.c since 6.2.
>

Thanks! I'll make sure to rerun the coccinelle script for the next version.

