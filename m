Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B1C4332F
	for <openrisc@archiver.kernel.org>; Thu, 17 Nov 2022 09:13:05 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CA6EA24A90;
	Thu, 17 Nov 2022 10:13:04 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id E13BC24A82
 for <openrisc@lists.librecores.org>; Thu, 17 Nov 2022 10:13:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nUeE98iw6CYI9P0UZFByNwbWM7T2dlFSVRfygox+oVI=; b=MgJlSA98izh3Lsqm003kpG/mL+
 EevnyLvSFZGX2upk5Jm3WoFC0zvMiO9eBcctfFuhCt0XhehaHroYVKWnLvTx2YsjGIrzuGTlhwGvs
 ycCoIWu5IDrMhT6T0Vi9JKGscYUfbfB21Xy6W0jd+DCfony3PxwWRKrtPSdJZrzWtEqZEBCvPcFMg
 OLvECk1Ph+NKITycPx1vBHQR0FuPmuJhwXJ21vaX9wcNqYWS8QSTCsgQr4GqwF5v3RYfO9wdSx7gz
 c1jMwXTl1i9DvI2bX3n8bA3RjH0bLkkRWvGkx0zXza/d9lP8P7CcehYOSzaseZ7O8CZ8vSGUJmsXd
 ZRL7zqAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ovawz-000qbk-Qm; Thu, 17 Nov 2022 09:12:49 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 220E230002E;
 Thu, 17 Nov 2022 10:12:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 0A96220B67F5A; Thu, 17 Nov 2022 10:12:43 +0100 (CET)
Date: Thu, 17 Nov 2022 10:12:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH v2 6/8] treewide: Trace IPIs sent via
 smp_send_reschedule()
Message-ID: <Y3X7CijMXpqQIHhk@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-5-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-5-vschneid@redhat.com>
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

On Wed, Nov 02, 2022 at 06:33:34PM +0000, Valentin Schneider wrote:

> diff --git a/kernel/smp.c b/kernel/smp.c
> index c4d561cf50d45..44fa4b9b1f46b 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -167,6 +167,14 @@ send_call_function_ipi_mask(const struct cpumask *mask)
>  	arch_send_call_function_ipi_mask(mask);
>  }
>  
> +void smp_send_reschedule(int cpu)
> +{
> +	/* XXX scheduler_ipi is inline :/ */
> +	trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
> +	arch_smp_send_reschedule(cpu);
> +}
> +EXPORT_SYMBOL_GPL(smp_send_reschedule);

Yeah, no.. I see some crazy archs do this, but no we're not exporting
this in generic.
