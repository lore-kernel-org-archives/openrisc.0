Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0480C433FE
	for <openrisc@archiver.kernel.org>; Thu, 17 Nov 2022 09:08:39 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8DE3D24A7F;
	Thu, 17 Nov 2022 10:08:38 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id 5197F24A5A
 for <openrisc@lists.librecores.org>; Thu, 17 Nov 2022 10:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=aQk2rEVdOyLC8MBnXpxdsdOtZKvioHnImfV1oOS2Xtg=; b=I3xClU65IacOMLf2bWeSauP7FF
 FV50Hi48EBk2WK6Yehcm6XtdcO6hf4dsN2DMpSf1Q8J+ZcUcJOT8oIO1945EQRsvfdc4JvICopd0l
 Ui4r6qLsEQxO7P9sxXUeh9gS9sZqkCJSKZK2ctS17TuNst0NjO4G5IjBK7pt6TA2UoyWMLe7JrlZ4
 3rVanZNI9MF1KBvk8SzTNZKx8hjhh1qDV56hj7OC6Wv8JNJ6ypUqg8KZLLfwkKn7jGczcYvLbevRx
 fdi5hL+kowpdqhlUAfa1HbfNoACRcwrRe8SG0NXXobWd3RkjDM5DSjIiSED2Yxip/fi/HuoFKOMRj
 0mZtwn6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ovasi-000qMs-De; Thu, 17 Nov 2022 09:08:24 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7E6F30002E;
 Thu, 17 Nov 2022 10:08:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id C282320B670CB; Thu, 17 Nov 2022 10:08:15 +0100 (CET)
Date: Thu, 17 Nov 2022 10:08:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH v2 4/8] smp: Trace IPIs sent via
 arch_send_call_function_ipi_mask()
Message-ID: <Y3X5/65o8127DgZl@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-3-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-3-vschneid@redhat.com>
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

On Wed, Nov 02, 2022 at 06:33:32PM +0000, Valentin Schneider wrote:
> This simply wraps around the arch function and prepends it with a
> tracepoint, similar to send_call_function_single_ipi().
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/smp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index e2ca1e2f31274..c4d561cf50d45 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -160,6 +160,13 @@ void __init call_function_init(void)
>  	smpcfd_prepare_cpu(smp_processor_id());
>  }
>  
> +static inline void

Given the use of _RET_IP_, I would strongly recommend you use
__always_inline.

> +send_call_function_ipi_mask(const struct cpumask *mask)
> +{
> +	trace_ipi_send_cpumask(mask, _RET_IP_, func);

What's func?

> +	arch_send_call_function_ipi_mask(mask);
> +}
