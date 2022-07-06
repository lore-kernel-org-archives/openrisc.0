Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B2C43334
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 21:55:30 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0F565205C5;
	Wed,  6 Jul 2022 23:55:29 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mail.librecores.org (Postfix) with ESMTPS id 17F1124844
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 15:51:22 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-2ef5380669cso140480577b3.9
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 06:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5SiPC3jj492VC8TfaG5lxiX62rjLNKysidcQlbSYqow=;
 b=Y/9zTDq0hDTLJJHW7Ww4rQim+3okLKvE49puVGWNOvHsIbOLbR33TadpKxMKTg6U3e
 9wWPmKqYRIVYKE2EpQDvzhwZaJ2vfCaB3NOHfHaqjA1rHh1nWNA6SmA9gXho2c8Ffyjj
 amf9fw7Amyg4eUmYXYnGQVkSWo3AjrLt9a7Uz3FqvlU8xBrMlI/x/e40/PMEx1xKD/LV
 luYZ+LRiokVEaNUfrmTlsBZtYzdmYdgy7bEHvIRW/tbD0wyb1z1Jl59Or/DCmhDXqtEt
 3IFxnC7ZyI7xhC/ZMltodCGI/lUMLtR4OAM8XYIf+GqQmVsiQ6BMtmPIUufs6PdnZZmJ
 Aiqg==
X-Gm-Message-State: AJIora8KRJKXBftOHSdFQ58XgtsbJqzOmb12f1pmnmwTZ6z77xhtFfRy
 QRX5tadA/+sBrscYUTmtLcG2pLET/qnkPMWbaHI=
X-Google-Smtp-Source: AGRyM1t2zFLeLAi3TOz/3FKNOaozLIghzMJavy2698E42fvxt6d4SsTob1/anQx1a1kTDZPSEUZEInHEN/JL2sa2rXc=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr45075306ywb.326.1657115480888; Wed, 06
 Jul 2022 06:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org>
 <20220608144516.109792837@infradead.org>
In-Reply-To: <20220608144516.109792837@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Jul 2022 15:51:09 +0200
Message-ID: <CAJZ5v0jO9+jRSm3d58K15JaO3=kgM2Ueo7W+Smi3WCBPR_VM5Q@mail.gmail.com>
Subject: Re: [PATCH 03/36] cpuidle/poll: Ensure IRQ state is invariant
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
> cpuidle_state::enter() methods should be IRQ invariant
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpuidle/poll_state.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -17,7 +17,7 @@ static int __cpuidle poll_idle(struct cp
>
>         dev->poll_time_limit = false;
>
> -       local_irq_enable();
> +       raw_local_irq_enable();
>         if (!current_set_polling_and_test()) {
>                 unsigned int loop_count = 0;
>                 u64 limit;
> @@ -36,6 +36,8 @@ static int __cpuidle poll_idle(struct cp
>                         }
>                 }
>         }
> +       raw_local_irq_disable();
> +
>         current_clr_polling();
>
>         return index;
>
>
