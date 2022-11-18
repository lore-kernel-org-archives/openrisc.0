Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5644C4332F
	for <openrisc@archiver.kernel.org>; Fri, 18 Nov 2022 09:13:24 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 83FE52493F;
	Fri, 18 Nov 2022 10:13:23 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id 6498B240AE
 for <openrisc@lists.librecores.org>; Fri, 18 Nov 2022 10:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mwt73Igv1Cbi6CXwxAPKd0Pr+R9hvpBvRt03pYQ3bys=; b=ab3Y1GXh5hZN4kYCUal3zeuK3Q
 7SRG1cvzhO7eKodvFDYyuRae96G8g5PWd/XWhtSWcEI5MUsYEab5Ovzc8ze8gBOk9y9y/n4/VG6QA
 kxoDu7O/fG1a2giqiMnnG8GWp7V1BxUra+Jgp+oiupx2occO6L51vWUZQgeu4+7U3imdC7NUUUJ2N
 J5VaNoVksNMD06l+gxDbRhfwA3keSj0mXPL1+LX088MVxqFi6HWwWMGwF0jamw9uSp14pYO1PV0sb
 dSKJCydBYVIQlrwj2um9MWjTnI+ZTo1PEgHrvF9BZHJpiPATdBDwJ3bT9CqtMVsKHp/fep69BWHYQ
 1FAlMbCA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ovxQb-00287L-Gd; Fri, 18 Nov 2022 09:12:54 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78E20300487;
 Fri, 18 Nov 2022 10:12:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5E8232C316131; Fri, 18 Nov 2022 10:12:43 +0100 (CET)
Date: Fri, 18 Nov 2022 10:12:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH v2 8/8] sched, smp: Trace smp callback causing an IPI
Message-ID: <Y3dMiyFn6TG1s5g3@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-7-vschneid@redhat.com>
 <Y3ZBUMteJysc1/lA@hirez.programming.kicks-ass.net>
 <xhsmhfsehy706.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhfsehy706.mognet@vschneid.remote.csb>
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

On Thu, Nov 17, 2022 at 02:45:29PM +0000, Valentin Schneider wrote:

> > +	if (trace_ipi_send_cpumask_enabled()) {
> > +		call_single_data_t *csd;
> > +		smp_call_func_t func;
> > +
> > +		csd = container_of(node, call_single_data_t, node.llist);
> > +
> > +		func = sched_ttwu_pending;
> > +		if (CSD_TYPE(csd) != CSD_TYPE_TTWU)
> > +			func = csd->func;
> > +
> > +		if (raw_smp_call_single_queue(cpu, node))
> > +			trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);
> 
> So I went with the tracepoint being placed *before* the actual IPI gets
> sent to have a somewhat sane ordering between trace_ipi_send_cpumask() and
> e.g. trace_call_function_single_entry().
> 
> Packaging the call_single_queue logic makes the code less horrible, but it
> does mix up the event ordering...

Keeps em sharp ;-)

> > +		return;
> > +	}
> > +
> > +	raw_smp_call_single_queue(cpu, node);
> >  }
> >
> >  /*
> > @@ -983,10 +1017,13 @@ static void smp_call_function_many_cond(
> >                * number of CPUs might be zero due to concurrent changes to the
> >                * provided mask.
> >                */
> > -		if (nr_cpus == 1)
> > +		if (nr_cpus == 1) {
> > +			trace_ipi_send_cpumask(cpumask_of(last_cpu), _RET_IP_, func);
> >                       send_call_function_single_ipi(last_cpu);
> 
> This'll yield an IPI event even if no IPI is sent due to the idle task
> polling, no?

Oh, right..
