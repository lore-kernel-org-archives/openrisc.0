Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F44CCA47A
	for <openrisc@archiver.kernel.org>; Wed,  8 Jun 2022 23:00:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 48049249BC;
	Thu,  9 Jun 2022 01:00:34 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by mail.librecores.org (Postfix) with ESMTPS id 04E99249B2
 for <openrisc@lists.librecores.org>; Wed,  8 Jun 2022 22:27:50 +0200 (CEST)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3lgL-1nzJGH1Fz9-000ukY for <openrisc@lists.librecores.org>; Wed, 08 Jun
 2022 22:27:50 +0200
Received: by mail-yb1-f169.google.com with SMTP id v22so38438227ybd.5
 for <openrisc@lists.librecores.org>; Wed, 08 Jun 2022 13:27:50 -0700 (PDT)
X-Gm-Message-State: AOAM532YWUAOGs/l4eC3soUe3m1JVTOfSYCWBVSJ1YcAtabw7DwYUeOI
 8cyW8jQRln+AXlPImSiCpsHVaXzGPXOBYW2LJ8s=
X-Google-Smtp-Source: ABdhPJzN5kbTwiXruPcKSpnmqojFIl1cGQUBuhNCCdRneCrpSwm0deMOGKvKLmavgOJ05DHkpAoCHNV4Fm5CQu/QOU4=
X-Received: by 2002:a0d:efc2:0:b0:2fe:d2b7:da8 with SMTP id
 y185-20020a0defc2000000b002fed2b70da8mr36982567ywe.42.1654705351589; Wed, 08
 Jun 2022 09:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org>
 <20220608144517.188449351@infradead.org>
In-Reply-To: <20220608144517.188449351@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Jun 2022 18:22:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2y5+nrQFzhjrTTZe+d57Ug261J3kwLNe8Mu8i2qxtG2w@mail.gmail.com>
Message-ID: <CAK8P3a2y5+nrQFzhjrTTZe+d57Ug261J3kwLNe8Mu8i2qxtG2w@mail.gmail.com>
Subject: Re: [PATCH 20/36] arch/idle: Change arch_cpu_idle() IRQ behaviour
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rElXuRyH0LOUF4iUItu+bNIuTciJWdtdE77ACXG88dnLuYCZ81z
 4cO422lmnEJafrHQ+JvxuGCKr7rvu5N61oXJyiIznEIMm9MveX8O+WKF2dXnrHZR0hbE2hM
 yluFNHQ7ESqLZ4a+sUNeGJ0Vn8yIvtioKcaMIlIXAqnQzi7fY94ARFEZEC7jdW9yVIWlIHc
 8Asb9iCVtDzysbcKp2CbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xEf9Q2Pc8LM=:dMNUstRn7d3bmDmU8dHlW2
 vfC25pKWT4lfqHEDLeMQ4ocwbJikWd6+7jXh5110rb/tPbYUrXSsUofIZvNpVQkDMbFZHTyiz
 sjkaypemuX8ucOVNZLbQmzSZebXOJpdi688GrIwNM/zmJaLG982EWCHq8kIJOfKQI13rqRb+t
 TWX551akj+GINcYqLyk4EeNJSBKEVk1nsiJPoGdOQvfNa3m0JOHi4jhdbp/V7G9kRAcuV7ZEa
 UPi9GUzdPagGEI6MKcGzCPFcDHtnCmOuWk8dDNETe93Mz/dB4DrG/REgDAI8qJl9lmQT7HMvI
 cq8geKDl3ymvR96FZWkdkU6nAUf06Kc1N4WUHWgwXMiut2u1SZD6lptBEAT4W+xaq9E2mRgDm
 mu6PKZ6mFYRccg7sD2gbwCLY1TJklfsjiinBeQhwwseJx9zKdkf8pN9tlGTg87RnTxWQJ5cuO
 zj8+otwHkgY61ETWl2y8X1t7+1dqSV0FeK5fbCLG5f4FbSyR3ku6+N0B2klUQSU2iQvfjXt55
 1dpt18A13IlMOTDvSo4Bsqz9OhW+mgCxSnXzkuQw85+6MU0n7I/PCEZ15MO5BDz29vgWXsVZ6
 D7M/x5P+XMfY6l+l1TbygsaWpWMRQnkAqNVlHko729bEMI17+pZnrdgVkyMDriipJhJRZ7462
 iCVB2BlkObqp89f9sHq301efQt8pCdnOat+iKt12wLEOx3efrl1epvpaKwBlh9nhW/3Ptu3da
 YBSbN7LdV9q1bX7bubY5+SaD+eC9iWOOrzLQExWh+RBPqT1OfBf6CZ+YswqWgd3iG621aVGM5
 ++wZNzi1JzG+qkjrCCvFIuJvGUB3sLvMV/pz9WuWpoHQvPpj3dykzAMnt2ZLBPdUww1FbvuEa
 rezt521+mI6vQ4znFAIdQWhmjsnhPWwnX5j2RDS/s=
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Rafael Wysocki <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>, Ben Segall <bsegall@google.com>,
 Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Alexander Gordeev <agordeev@linux.ibm.com>, srivatsa@csail.mit.edu,
 linux-arch <linux-arch@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Huacai Chen <chenhuacai@kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Gross <agross@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 xen-devel <xen-devel@lists.xenproject.org>, Matt Turner <mattst88@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Turquette <mturquette@baylibre.com>, Sam Creasey <sammy@sammy.net>,
 Petr Mladek <pmladek@suse.com>, Linux PM list <linux-pm@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um <linux-um@lists.infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Richard Henderson <rth@twiddle.net>, gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Sven Schnelle <svens@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>,
 "open list:IA64 \(Itanium\) PLATFORM" <linux-ia64@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Xuerui Wang <kernel@xen0n.name>, quic_neeraju@quicinc.com,
 linux-s390 <linux-s390@vger.kernel.org>, vschneid@redhat.com,
 John Ogness <john.ogness@linutronix.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-sh list <linux-sh@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Helge Deller <deller@gmx.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Frederic Weisbecker <frederic@kernel.org>, Len Brown <lenb@kernel.org>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 Sascha Hauer <kernel@pengutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Stephen Boyd <sboyd@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, lpieralisi@kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Kevin Hilman <khilman@kernel.org>, linux-csky@vger.kernel.org,
 Pv-drivers <pv-drivers@vmware.com>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 Mel Gorman <mgorman@suse.de>, jacob.jun.pan@linux.intel.com,
 Arnd Bergmann <arnd@arndb.de>, Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Vineet Gupta <vgupta@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 rcu@vger.kernel.org, Borislav Petkov <bp@alien8.de>, bcain@quicinc.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 David Miller <davem@davemloft.net>, Rich Felker <dalias@libc.org>,
 Tony Lindgren <tony@atomide.com>, amakhalov@vmware.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jonas Bonn <jonas@southpole.se>, Yury Norov <yury.norov@gmail.com>,
 Richard Weinberger <richard@nod.at>, the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Openrisc <openrisc@lists.librecores.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jpoimboe@kernel.org,
 Juergen Gross <jgross@suse.com>, Michal Simek <monstr@monstr.eu>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Johannes Berg <johannes@sipsolutions.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Jun 8, 2022 at 4:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Current arch_cpu_idle() is called with IRQs disabled, but will return
> with IRQs enabled.
>
> However, the very first thing the generic code does after calling
> arch_cpu_idle() is raw_local_irq_disable(). This means that
> architectures that can idle with IRQs disabled end up doing a
> pointless 'enable-disable' dance.
>
> Therefore, push this IRQ disabling into the idle function, meaning
> that those architectures can avoid the pointless IRQ state flipping.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I think you now need to add the a raw_local_irq_disable(); in loongarch
as well.

       Arnd
