Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3724C6FA92
	for <openrisc@archiver.kernel.org>; Mon, 19 Sep 2022 14:24:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7626A24871;
	Mon, 19 Sep 2022 16:24:44 +0200 (CEST)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by mail.librecores.org (Postfix) with ESMTPS id B6E9324C8C
 for <openrisc@lists.librecores.org>; Mon, 19 Sep 2022 12:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=6o9qTJ/QjCltP+zmu0PkeSqB0nVcTaPJ8iw1lVGI/YI=; b=fh6jTDX0iTAQBch3m1E8OK/teW
 GEjpiaTGkYRg8vW/aNBRkADkEkRImQUbzpta6LI3AmhS4mLdaW44WlTemKQQHS4Rib2Jfagk+JvNt
 68yaJmGcdY82ZdDz3uA87H5wQgt/XUMfWTG9ArE4FLvW/Q1KIsjvg4XIJz1Peh9lF2VNg15j8v85Y
 4WT3iEDs4Y+JCcmg6XLoixnFygR6J3BhKqIRZKs+QG8Lg6WzUGeQtqQJvH/MYkNqMTCc25mz62Mdv
 1r8UW5CvdoSFJxq4HftoO38anvP9uEWdLAZrJvn5BWoV7b0HiT7bN+lsCpQ1+FWS29ScGWW8uBlG+
 r0yDTsUA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oaDpF-00E293-Ay; Mon, 19 Sep 2022 10:17:17 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0605302EB1;
 Mon, 19 Sep 2022 12:16:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 052C92BA49043; Mon, 19 Sep 2022 12:16:21 +0200 (CEST)
Message-ID: <20220919101521.139727471@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 19 Sep 2022 11:59:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Subject: [PATCH v2 12/44] cpuidle,dt: Push RCU-idle into driver
References: <20220919095939.761690562@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailman-Approved-At: Mon, 19 Sep 2022 16:24:30 +0200
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com,
 linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz,
 agordeev@linux.ibm.com, srivatsa@csail.mit.edu, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org,
 christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org,
 linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com,
 borntraeger@linux.ibm.com, mturquette@baylibre.com, sammy@sammy.net,
 pmladek@suse.com, linux-pm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org,
 dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, mark.rutland@arm.com,
 linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@HansenPartnership.com, jcmvbkbc@gmail.com,
 thierry.reding@gmail.com, kernel@xen0n.name, cl@linux.com,
 linux-s390@vger.kernel.org, vschneid@redhat.com, john.ogness@linutronix.de,
 ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, festevam@gmail.com,
 deller@gmx.de, daniel.lezcano@linaro.org, jonathanh@nvidia.com,
 dennis@kernel.org, lenb@kernel.org, linux-xtensa@linux-xtensa.org,
 kernel@pengutronix.de, gor@linux.ibm.com, linux-arm-msm@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 loongarch@lists.linux.dev, chris@zankel.net, sboyd@kernel.org,
 dinguyen@kernel.org, bristot@redhat.com, alexander.shishkin@linux.intel.com,
 fweisbec@gmail.com, lpieralisi@kernel.org, atishp@atishpatra.org,
 linux@rasmusvillemoes.dk, kasan-dev@googlegroups.com, will@kernel.org,
 boris.ostrovsky@oracle.com, khilman@kernel.org, linux-csky@vger.kernel.org,
 pv-drivers@vmware.com, linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
 ulli.kroll@googlemail.com, linux-clk@vger.kernel.org, rostedt@goodmis.org,
 ink@jurassic.park.msu.ru, bcain@quicinc.com, tsbogend@alpha.franken.de,
 linux-parisc@vger.kernel.org, ryabinin.a.a@gmail.com, sudeep.holla@arm.com,
 shawnguo@kernel.org, davem@davemloft.net, dalias@libc.org, tony@atomide.com,
 amakhalov@vmware.com, konrad.dybcio@somainline.org, bjorn.andersson@linaro.org,
 glider@google.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 vincenzo.frascino@arm.com, anton.ivanov@cambridgegreys.com, jonas@southpole.se,
 yury.norov@gmail.com, richard@nod.at, x86@kernel.org, linux@armlinux.org.uk,
 mingo@redhat.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 richard.henderson@linaro.org, openrisc@lists.librecores.org, acme@kernel.org,
 paul.walmsley@sifive.com, linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, dvyukov@google.com,
 jgross@suse.com, monstr@monstr.eu, linux-mips@vger.kernel.org,
 palmer@dabbelt.com, anup@brainfault.org, bp@alien8.de,
 johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Doing RCU-idle outside the driver, only to then temporarily enable it
again before going idle is daft.

Notably: this converts all dt_init_idle_driver() and
__CPU_PM_CPU_IDLE_ENTER() users for they are inextrably intertwined.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c    |    4 ++--
 drivers/acpi/processor_idle.c        |    2 ++
 drivers/cpuidle/cpuidle-arm.c        |    1 +
 drivers/cpuidle/cpuidle-big_little.c |    8 ++++++--
 drivers/cpuidle/cpuidle-psci.c       |    1 +
 drivers/cpuidle/cpuidle-qcom-spm.c   |    1 +
 drivers/cpuidle/cpuidle-riscv-sbi.c  |    1 +
 drivers/cpuidle/dt_idle_states.c     |    2 +-
 include/linux/cpuidle.h              |    4 ++++
 9 files changed, 19 insertions(+), 5 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
 		state->target_residency = lpi->min_residency;
 		if (lpi->arch_flags)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+		if (lpi->entry_method == ACPI_CSTATE_FFH)
+			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
 		state->enter = acpi_idle_lpi_enter;
 		drv->safe_state_index = i;
 	}
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
 	 * handler for idle state index 0.
 	 */
 	.states[0] = {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter                  = arm_enter_idle_state,
 		.exit_latency           = 1,
 		.target_residency       = 1,
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -64,7 +64,8 @@ static struct cpuidle_driver bl_idle_lit
 		.enter			= bl_enter_powerdown,
 		.exit_latency		= 700,
 		.target_residency	= 2500,
-		.flags			= CPUIDLE_FLAG_TIMER_STOP,
+		.flags			= CPUIDLE_FLAG_TIMER_STOP |
+					  CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "C1",
 		.desc			= "ARM little-cluster power down",
 	},
@@ -85,7 +86,8 @@ static struct cpuidle_driver bl_idle_big
 		.enter			= bl_enter_powerdown,
 		.exit_latency		= 500,
 		.target_residency	= 2000,
-		.flags			= CPUIDLE_FLAG_TIMER_STOP,
+		.flags			= CPUIDLE_FLAG_TIMER_STOP |
+					  CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "C1",
 		.desc			= "ARM big-cluster power down",
 	},
@@ -124,11 +126,13 @@ static int bl_enter_powerdown(struct cpu
 				struct cpuidle_driver *drv, int idx)
 {
 	cpu_pm_enter();
+	ct_idle_enter();
 
 	cpu_suspend(0, bl_powerdown_finisher);
 
 	/* signals the MCPM core that CPU is out of low power state */
 	mcpm_cpu_powered_up();
+	ct_idle_exit();
 
 	cpu_pm_exit();
 
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -357,6 +357,7 @@ static int psci_idle_init_cpu(struct dev
 	 * PSCI idle states relies on architectural WFI to be represented as
 	 * state index 0.
 	 */
+	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[0].enter = psci_enter_idle_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -72,6 +72,7 @@ static struct cpuidle_driver qcom_spm_id
 	.owner = THIS_MODULE,
 	.states[0] = {
 		.enter			= spm_enter_idle_state,
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.exit_latency		= 1,
 		.target_residency	= 1,
 		.power_usage		= UINT_MAX,
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -332,6 +332,7 @@ static int sbi_cpuidle_init_cpu(struct d
 	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
 
 	/* RISC-V architectural WFI to be represented as state index 0. */
+	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[0].enter = sbi_cpuidle_enter_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -77,7 +77,7 @@ static int init_state_node(struct cpuidl
 	if (err)
 		desc = state_node->name;
 
-	idle_state->flags = 0;
+	idle_state->flags = CPUIDLE_FLAG_RCU_IDLE;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 	/*
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
 	int __ret = 0;							\
 									\
 	if (!idx) {							\
+		ct_idle_enter();					\
 		cpu_do_idle();						\
+		ct_idle_exit();						\
 		return idx;						\
 	}								\
 									\
 	if (!is_retention)						\
 		__ret =  cpu_pm_enter();				\
 	if (!__ret) {							\
+		ct_idle_enter();					\
 		__ret = low_level_idle_enter(state);			\
+		ct_idle_exit();						\
 		if (!is_retention)					\
 			cpu_pm_exit();					\
 	}								\


