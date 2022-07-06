Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF1CCA485
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 21:55:32 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 612B724973;
	Wed,  6 Jul 2022 23:55:31 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mail.librecores.org (Postfix) with ESMTPS id 763492492A
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 16:04:54 +0200 (CEST)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-31c89653790so89963287b3.13
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 07:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UBE539EKjjJ8zkn99yLgr6sf0hQeHTgO/l2k1f9VAKg=;
 b=KTlM6k3BYyg+qO/ZTlhfEF8bXwEtJyLVCIO5OOKnrwOPacqm17FtlgXPmTUpAIQOmQ
 HPL96w7lSGwei7KCGlzE/OphHYjJr+RVy6SDWF0SYNdHq8r5rCDhPptqMg6tluNGUdF8
 tvYSqG7Ll/Z0TwNYS0VXEQGYwd33At4KKrvxdi/0tQ32DOuSE0ucYyvbWsLdUeTvfSUF
 PEnfTYTcTUWuvJU4GuykdTBK15lF6/PbJRbF3OJhjX4WqxEJ/BFOxw3Bh2mz+jpyWkrd
 SnmHcEzr5U8HjuUibOyhCmLYjvSWH9fKmb/ciXi2s7r1oeFFPp0GXL4SoI7Nm2ulu+iH
 rqlQ==
X-Gm-Message-State: AJIora9rXQozVdeU+CPbVICPRlkU+CrxbG/2rvnMZESgy+PYV2mqcUbu
 CGjR+0u0WD0l82GGoQjfXdrul1fo3eLGYvLZVJ8=
X-Google-Smtp-Source: AGRyM1tzweDvK/HpOTrEcMtuYgu75xJlbU4wLmWYqVeEsIhNId5gL4a/NC1jAK4t+CVNf/Oa7/ufr1ZdqBFMCfc4FVA=
X-Received: by 2002:a81:24c7:0:b0:314:1e60:a885 with SMTP id
 k190-20020a8124c7000000b003141e60a885mr46512506ywk.301.1657116293184; Wed, 06
 Jul 2022 07:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org>
 <20220608144517.885263942@infradead.org>
In-Reply-To: <20220608144517.885263942@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Jul 2022 16:04:42 +0200
Message-ID: <CAJZ5v0j6=x-u3dorwQNd6Sihaa1rx1-uaFXbL1Kc37Hu-fcH3A@mail.gmail.com>
Subject: Re: [PATCH 31/36] cpuidle,acpi: Make noinstr clean
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 06 Jul 2022 23:55:27 +0200
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
Cc: Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>, Benjamin Segall <bsegall@google.com>,
 Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Alexander Gordeev <agordeev@linux.ibm.com>, srivatsa@csail.mit.edu,
 linux-arch <linux-arch@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Huacai Chen <chenhuacai@kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Gross <agross@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, xen-devel@lists.xenproject.org,
 mattst88@gmail.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Turquette <mturquette@baylibre.com>, sammy@sammy.net,
 Petr Mladek <pmladek@suse.com>, Linux PM <linux-pm@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um@lists.infradead.org, acme@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, rth@twiddle.net,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
 Sven Schnelle <svens@linux.ibm.com>, jolsa@kernel.org,
 Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>, jcmvbkbc@gmail.com,
 Thierry Reding <thierry.reding@gmail.com>, kernel@xen0n.name,
 quic_neeraju@quicinc.com, linux-s390@vger.kernel.org, vschneid@redhat.com,
 John Ogness <john.ogness@linutronix.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-sh list <linux-sh@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Helge Deller <deller@gmx.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Frederic Weisbecker <frederic@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-xtensa@linux-xtensa.org, Sascha Hauer <kernel@pengutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-alpha@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Stephen Boyd <sboyd@kernel.org>,
 dinguyen@kernel.org, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Kevin Hilman <khilman@kernel.org>, linux-csky@vger.kernel.org,
 pv-drivers@vmware.com, linux-snps-arc@lists.infradead.org,
 Mel Gorman <mgorman@suse.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, ulli.kroll@googlemail.com, vgupta@kernel.org,
 linux-clk <linux-clk@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, bcain@quicinc.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 David Miller <davem@davemloft.net>, Rich Felker <dalias@libc.org>,
 Tony Lindgren <tony@atomide.com>, amakhalov@vmware.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv <linux-riscv@lists.infradead.org>, anton.ivanov@cambridgegreys.com,
 jonas@southpole.se, Yury Norov <yury.norov@gmail.com>,
 Richard Weinberger <richard@nod.at>, the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, namhyung@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jpoimboe@kernel.org,
 Juergen Gross <jgross@suse.com>, Michal Simek <monstr@monstr.eu>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 ink@jurassic.park.msu.ru, Johannes Berg <johannes@sipsolutions.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Jun 8, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> vmlinux.o: warning: objtool: io_idle+0xc: call to __inb.isra.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_enter+0xfe: call to num_online_cpus() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_enter+0x115: call to acpi_idle_fallback_to_c1.isra.0() leaves .noinstr.text section
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/include/asm/shared/io.h |    4 ++--
>  drivers/acpi/processor_idle.c    |    2 +-
>  include/linux/cpumask.h          |    4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/arch/x86/include/asm/shared/io.h
> +++ b/arch/x86/include/asm/shared/io.h
> @@ -5,13 +5,13 @@
>  #include <linux/types.h>
>
>  #define BUILDIO(bwl, bw, type)                                         \
> -static inline void __out##bwl(type value, u16 port)                    \
> +static __always_inline void __out##bwl(type value, u16 port)           \
>  {                                                                      \
>         asm volatile("out" #bwl " %" #bw "0, %w1"                       \
>                      : : "a"(value), "Nd"(port));                       \
>  }                                                                      \
>                                                                         \
> -static inline type __in##bwl(u16 port)                                 \
> +static __always_inline type __in##bwl(u16 port)                                \
>  {                                                                      \
>         type value;                                                     \
>         asm volatile("in" #bwl " %w1, %" #bw "0"                        \
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -593,7 +593,7 @@ static int acpi_idle_play_dead(struct cp
>         return 0;
>  }
>
> -static bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
> +static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
>  {
>         return IS_ENABLED(CONFIG_HOTPLUG_CPU) && !pr->flags.has_cst &&
>                 !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED);
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -908,9 +908,9 @@ static inline const struct cpumask *get_
>   * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
>   * region.
>   */
> -static inline unsigned int num_online_cpus(void)
> +static __always_inline unsigned int num_online_cpus(void)
>  {
> -       return atomic_read(&__num_online_cpus);
> +       return arch_atomic_read(&__num_online_cpus);
>  }
>  #define num_possible_cpus()    cpumask_weight(cpu_possible_mask)
>  #define num_present_cpus()     cpumask_weight(cpu_present_mask)
>
>
