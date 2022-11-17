Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8EC433FE
	for <openrisc@archiver.kernel.org>; Thu, 17 Nov 2022 09:11:08 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2EDF224A1B;
	Thu, 17 Nov 2022 10:11:07 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id DD2FA2062E
 for <openrisc@lists.librecores.org>; Thu, 17 Nov 2022 10:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rs9mPbZMWkmGpFMwZXAxzgJsIHnGFVekqWq8NHBYPaE=; b=R1R3c0H1DMOPHL2EgzaQiKmWc6
 4g7vKNmWUZA3OnVQZ/791nS7MV15HGuXYR4LWct/zjRRgTK+dNnL85b46VmpoobJ+EHG/3iX5n7IA
 +equo9lBjaJUg3gTG+mevrb7K9jv6FfkkHfl2p47Rs0cy6NoLBkr9vyQZjccWCdTguIbSq3W8L+M+
 g5vZQ/0UzVMiD70Ih/xvhFHjAJMHV/ca+Xik2nReUKV0TeWwkr909DO60dbGyjqIg2jCR8xKkeWGW
 uwTyKLOnFvLCxPonjQNLfIhyogu3+VVn7IZf6T5ilF6RWcC9C3xOpf/z/mpnIIqLWzT4qucfdy49N
 D47XaqmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ovavI-000qVG-8t; Thu, 17 Nov 2022 09:11:04 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C93830002E;
 Thu, 17 Nov 2022 10:10:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 64B5420B670CB; Thu, 17 Nov 2022 10:10:57 +0100 (CET)
Date: Thu, 17 Nov 2022 10:10:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH v2 5/8] irq_work: Trace self-IPIs sent via
 arch_irq_work_raise()
Message-ID: <Y3X6oQdySdXBh7v8@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-4-vschneid@redhat.com>
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

On Wed, Nov 02, 2022 at 06:33:33PM +0000, Valentin Schneider wrote:
> IPIs sent to remove CPUs via irq_work_queue_on() are now covered by
> trace_ipi_send_cpumask(), add another instance of the tracepoint to cover
> self-IPIs.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/irq_work.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 7afa40fe5cc43..aec38c294ce68 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -22,6 +22,8 @@
>  #include <asm/processor.h>
>  #include <linux/kasan.h>
>  
> +#include <trace/events/ipi.h>
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>  static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> @@ -74,6 +76,16 @@ void __weak arch_irq_work_raise(void)
>  	 */
>  }
>  
> +static inline void irq_work_raise(struct irq_work *work)

__always_inline, unless you want to occasionally only see it point to
__irq_work_queue_local().

> +{
> +	if (trace_ipi_send_cpumask_enabled() && arch_irq_work_has_interrupt()) {
> +		trace_ipi_send_cpumask(cpumask_of(smp_processor_id()),
> +				       _RET_IP_,
> +				       work->func);
	}
> +
> +	arch_irq_work_raise();
> +}
> +
>  /* Enqueue on current CPU, work must already be claimed and preempt disabled */
>  static void __irq_work_queue_local(struct irq_work *work)
>  {
> @@ -99,7 +111,7 @@ static void __irq_work_queue_local(struct irq_work *work)
>  
>  	/* If the work is "lazy", handle it from next tick if any */
>  	if (!lazy_work || tick_nohz_tick_stopped())
> -		arch_irq_work_raise();
> +		irq_work_raise(work);
>  }
>  
>  /* Enqueue the irq work @work on the current CPU */
> -- 
> 2.31.1
> 
