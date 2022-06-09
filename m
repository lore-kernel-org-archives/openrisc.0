Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE75CCA47D
	for <openrisc@archiver.kernel.org>; Sat, 11 Jun 2022 21:54:10 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7198A24906;
	Sat, 11 Jun 2022 23:54:08 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mail.librecores.org (Postfix) with ESMTPS id B684B248F0
 for <openrisc@lists.librecores.org>; Fri, 10 Jun 2022 01:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654818329; x=1686354329;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/qix89+4Yux2UyS3QMBWmKLCne+VvkXES21cCGFIhLs=;
 b=m7JQUuE0Zvcd6XmNNK545YmT39sV4l3yJ8UdhYnd0ujMYCI8Gsy2jUBq
 bmle3uM7F5mYqV5XdB6FBYLpgrNTwgR6EwqCLxMH+cYzD7eC5W5Pu8BRh
 iTX+mtQ5HbNNTDpsJqBJPx/Pic6HWmL16TZhSKLCfy7E0taQ5uXVnPRC6
 gib74lqsspG89qTNSHWUzAfLao5NGgcJ+QWgkcmeKaUvFSTLQAbD29m2Y
 yIBAv8ei9fFi/L5qZmjZpZey7Zb4YwvJitXjH6XI/buIyhgCz+Sxn44TS
 x8JqjMQkR0OIzu94XjJUCeeZQu+EFpTUk4Y7lAgsPhHJFLbjlSDHQy8zD Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278263534"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="278263534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 16:45:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="610480359"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 16:45:19 -0700
Date: Thu, 9 Jun 2022 16:49:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Message-ID: <20220609164921.5e61711d@jacob-builder>
In-Reply-To: <20220608144516.172460444@infradead.org>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 11 Jun 2022 23:54:06 +0200
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, srivatsa@csail.mit.edu, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org,
 linux-acpi@vger.kernel.org, agross@kernel.org, linux-imx@nxp.com,
 catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com,
 borntraeger@linux.ibm.com, mturquette@baylibre.com, sammy@sammy.net,
 pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org,
 dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org,
 paulus@samba.org, mark.rutland@arm.com, linux-ia64@vger.kernel.org,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, quic_neeraju@quicinc.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, festevam@gmail.com,
 deller@gmx.de, daniel.lezcano@linaro.org, jonathanh@nvidia.com,
 mathieu.desnoyers@efficios.com, frederic@kernel.org, lenb@kernel.org,
 linux-xtensa@linux-xtensa.org, kernel@pengutronix.de, gor@linux.ibm.com,
 linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-arm-kernel@lists.infradead.org,
 chris@zankel.net, sboyd@kernel.org, dinguyen@kernel.org, bristot@redhat.com,
 alexander.shishkin@linux.intel.com, lpieralisi@kernel.org,
 linux@rasmusvillemoes.dk, joel@joelfernandes.org, will@kernel.org,
 boris.ostrovsky@oracle.com, khilman@kernel.org, linux-csky@vger.kernel.org,
 pv-drivers@vmware.com, linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, vgupta@kernel.org, linux-clk@vger.kernel.org,
 josh@joshtriplett.org, rostedt@goodmis.org, rcu@vger.kernel.org, bp@alien8.de,
 bcain@quicinc.com, tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 sudeep.holla@arm.com, shawnguo@kernel.org, davem@davemloft.net,
 dalias@libc.org, tony@atomide.com, amakhalov@vmware.com,
 bjorn.andersson@linaro.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 anton.ivanov@cambridgegreys.com, jonas@southpole.se, yury.norov@gmail.com,
 richard@nod.at, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 aou@eecs.berkeley.edu, paulmck@kernel.org, hca@linux.ibm.com,
 openrisc@lists.librecores.org, paul.walmsley@sifive.com,
 linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com,
 monstr@monstr.eu, linux-mips@vger.kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, ink@jurassic.park.msu.ru, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Peter,

On Wed, 08 Jun 2022 16:27:27 +0200, Peter Zijlstra <peterz@infradead.org>
wrote:

> Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> Xeons") wrecked intel_idle in two ways:
> 
>  - must not have tracing in idle functions
>  - must return with IRQs disabled
> 
> Additionally, it added a branch for no good reason.
> 
> Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/idle/intel_idle.c |   48
> +++++++++++++++++++++++++++++++++++----------- 1 file changed, 37
> insertions(+), 11 deletions(-)
> 
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -129,21 +137,37 @@ static unsigned int mwait_substates __in
>   *
>   * Must be called under local_irq_disable().
>   */
nit: this comment is no long true, right?

> +
> -static __cpuidle int intel_idle(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv, int index)
> +static __always_inline int __intel_idle(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int
> index) {
>  	struct cpuidle_state *state = &drv->states[index];
>  	unsigned long eax = flg2MWAIT(state->flags);
>  	unsigned long ecx = 1; /* break on interrupt flag */
>  
> -	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
> -		local_irq_enable();
> -
>  	mwait_idle_with_hints(eax, ecx);
>  
>  	return index;
>  }
>  
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	return __intel_idle(dev, drv, index);
> +}
> +
> +static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
> +				    struct cpuidle_driver *drv, int
> index) +{
> +	int ret;
> +
> +	raw_local_irq_enable();
> +	ret = __intel_idle(dev, drv, index);
> +	raw_local_irq_disable();
> +
> +	return ret;
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> @@ -1801,6 +1824,9 @@ static void __init intel_idle_init_cstat
>  		/* Structure copy. */
>  		drv->states[drv->state_count] =
> cpuidle_state_table[cstate]; 
> +		if (cpuidle_state_table[cstate].flags &
> CPUIDLE_FLAG_IRQ_ENABLE)
> +			drv->states[drv->state_count].enter =
> intel_idle_irq; +
>  		if ((disabled_states_mask & BIT(drv->state_count)) ||
>  		    ((icpu->use_acpi || force_use_acpi) &&
>  		     intel_idle_off_by_default(mwait_hint) &&
> 
> 


Thanks,

Jacob
