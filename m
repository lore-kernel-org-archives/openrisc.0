Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475DC433EF
	for <openrisc@archiver.kernel.org>; Wed,  8 Jun 2022 23:00:17 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9DEFF249C0;
	Thu,  9 Jun 2022 01:00:16 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mail.librecores.org (Postfix) with ESMTPS id 7BE2D249B2
 for <openrisc@lists.librecores.org>; Wed,  8 Jun 2022 16:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=zScd4cADrYcj3rMhEyHUI7u7RAFkUNduwGg8qRRyi/k=; b=lMeZtUCMmLelJdq3AWi7ufvFy9
 zlr0j5q30DieJ7hrCz8do1dwuurdkRTVZkClv5qAsNNY34C5+J1MisafZfl5mqNbyVj29S2tZDxtK
 LEpTKomujvoW1TCLYxlDbZt43UH74WE9L7Lh3HKWRXe6UR3tN8vTT5ffsmmFmxd0VHkpTlLfEISj7
 1YiC/dMdRcaQcaLa3hWd6i2S9Ph6nB4hTbaK6IoI8FUNQvFYBexxYiq+T8SJikPxMDFN+B/sZWVMO
 b9LXaI8a06LKzZOZDbTdvz+wlt156y7IT5OCrJlji47mznjmSKwwwdv64p++NrqDV4Nf5RRQ6f3GK
 cjl+uyVg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nywwz-00ChWi-PN; Wed, 08 Jun 2022 14:46:25 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A2ED302E59;
 Wed,  8 Jun 2022 16:46:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 7DA0620C10EC7; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608144516.998681585@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 08 Jun 2022 16:27:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH 17/36] acpi_idle: Remove tracing
References: <20220608142723.103523089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailman-Approved-At: Thu, 09 Jun 2022 00:59:57 +0200
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

All the idle routines are called with RCU disabled, as such there must
not be any tracing inside.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/acpi/processor_idle.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -108,8 +108,8 @@ static const struct dmi_system_id proces
 static void __cpuidle acpi_safe_halt(void)
 {
 	if (!tif_need_resched()) {
-		safe_halt();
-		local_irq_disable();
+		raw_safe_halt();
+		raw_local_irq_disable();
 	}
 }
 
@@ -524,16 +524,21 @@ static int acpi_idle_bm_check(void)
 	return bm_status;
 }
 
-static void wait_for_freeze(void)
+static __cpuidle void io_idle(unsigned long addr)
 {
+	/* IO port based C-state */
+	inb(addr);
+
 #ifdef	CONFIG_X86
 	/* No delay is needed if we are in guest */
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return;
 #endif
-	/* Dummy wait op - must do something useless after P_LVL2 read
-	   because chipsets cannot guarantee that STPCLK# signal
-	   gets asserted in time to freeze execution properly. */
+	/*
+	 * Dummy wait op - must do something useless after P_LVL2 read
+	 * because chipsets cannot guarantee that STPCLK# signal
+	 * gets asserted in time to freeze execution properly.
+	 */
 	inl(acpi_gbl_FADT.xpm_timer_block.address);
 }
 
@@ -553,9 +558,7 @@ static void __cpuidle acpi_idle_do_entry
 	} else if (cx->entry_method == ACPI_CSTATE_HALT) {
 		acpi_safe_halt();
 	} else {
-		/* IO port based C-state */
-		inb(cx->address);
-		wait_for_freeze();
+		io_idle(cx->address);
 	}
 
 	perf_lopwr_cb(false);
@@ -577,8 +580,7 @@ static int acpi_idle_play_dead(struct cp
 		if (cx->entry_method == ACPI_CSTATE_HALT)
 			safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
-			inb(cx->address);
-			wait_for_freeze();
+			io_idle(cx->address);
 		} else
 			return -ENODEV;
 


