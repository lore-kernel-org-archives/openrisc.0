Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6607CC433EF
	for <openrisc@archiver.kernel.org>; Wed,  8 Jun 2022 23:00:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CCD2E249A9;
	Thu,  9 Jun 2022 01:00:32 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by mail.librecores.org (Postfix) with ESMTPS id D06B720CC0
 for <openrisc@lists.librecores.org>; Wed,  8 Jun 2022 20:20:40 +0200 (CEST)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MkYkC-1nKgOE0h8I-00m7GV for <openrisc@lists.librecores.org>; Wed, 08 Jun
 2022 20:20:40 +0200
Received: by mail-yb1-f176.google.com with SMTP id v22so37910941ybd.5
 for <openrisc@lists.librecores.org>; Wed, 08 Jun 2022 11:20:39 -0700 (PDT)
X-Gm-Message-State: AOAM532FMwQJiPrT0md0xceW7gIxv2l6uaH0yJ8HnhF5rha5wU7hLStg
 oCZX1aQ/KyI7/gAsoenjQaRtQ5239g2hzjDmrA8=
X-Google-Smtp-Source: ABdhPJzNVjvOg+I4TKoqtI9Mj5r7eGnKl4yZEYVHLzTr22uimte8bgKc1nTgREfDsecVqzQDeuxH8v8jGezndj85u8s=
X-Received: by 2002:a25:e64b:0:b0:663:ffad:eac5 with SMTP id
 d72-20020a25e64b000000b00663ffadeac5mr3789690ybh.550.1654705730388; Wed, 08
 Jun 2022 09:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org>
 <20220608144518.010587032@infradead.org>
In-Reply-To: <20220608144518.010587032@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Jun 2022 18:28:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
Message-ID: <CAK8P3a0g-fNu9=BUECSXcNeWT7XWHQMnSXZE-XYE+5eakHxKxA@mail.gmail.com>
Subject: Re: [PATCH 33/36] cpuidle,omap3: Use WFI for omap3_pm_idle()
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:m3IqppAKm5/KdKJjPbxCNRncFxbPHFyHTxz+/pjeiT3nXEmjniY
 LG6gPY3vc67087BmxtbyagP/33rPeBQyN15lU2x46KWwU9unhF+C9i18tJo9yPutr0EnROX
 iFE+0psfuGqr1c9Rba0VVPBNY+ZFEYlMgzw0wHx75zHCXN5OXCSsIyGEW4DH1gtsAlx58VM
 1I158NcjMHdJT+IFPOsGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4NqRi0Y15Go=:62hnv0zgPOFEQchCu4GUhU
 5rKaiv+bs4y19hPo+aFqSoHs3EcRrN5eT2p/Ax9eSPTLgV3muNZnnIhwBhCK7BnaWb6KpSueH
 m7lZzCf76irJWw/uP6+augD09AgKpjJeXAu1L7W4np8WEfrBkTMTzvFnCihVfDaaTo7/vozCj
 dS60ux5xLVa+W3K7jKQTy8X9rhJx0b1BUzufeEpxAo4RvUTg8qX9TSz/+sjofaDjXqCzzuvPs
 bay97SZl4l5YQ7IhEoK4pH6Vs5oyRis8eSOqb3q51+Xwxn8g0OQ4HGeu4fY8oHQwCna0nj0lI
 0x8QNNiTREChiz7p4aIIMqrGoayJo78g03ErsidcHFrkeAdTSF+Rll568HTSOiVa4+eCWtIeq
 QoI6XPZMyex5lNW3tz5BjzEnSIkhwhBR7jimaOJpMTHdWHoWISpfzd0kYyovA6PGCktV+1+KL
 h+MmOihPAZ7qnyY/Mt2mb5Fpz9u2zaE0Mx2x62hkmjZCro759hM7qY9w+CMSGyPaXca4gFZx1
 +XkBCL6r6aD2X4kR6FN7OKMQUuSteP1zhH8r0rVl3yMyGMfcCSwZjdidw+9k4oZyUH3W73Wij
 6S7eH6+wV/FQtzTQxfMq64aqq80dEu3PShulw/dft8StjJGDAEkMmcSGESY6AAp0v9O29Tq5J
 jYSIEV0Y33C/PtYso/DQxQTTTzjPsCYzxrmVv+7BVpljqJQtKpUyhhQQcQnJouXh6ODZ9hw7o
 QApRQ5z8aQfVUmizmI9z+n81e9eezPj+BWZXPzqnee/1TSKhW5IjW0VEmZWn4NHHTYYIgS6Ia
 paGgv2fCWL9edsnWaP6RPsKspMtM7VKYoDeEHX7SlZlHNvKrMnYpyZZGfT5SG3HAs7BPUSXmg
 bYDs2UNosbG58CF0Hk7dAwMGYmUNW6ioU1HAB/t28=
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
> arch_cpu_idle() is a very simple idle interface and exposes only a
> single idle state and is expected to not require RCU and not do any
> tracing/instrumentation.
>
> As such, omap_sram_idle() is not a valid implementation. Replace it
> with the simple (shallow) omap3_do_wfi() call. Leaving the more
> complicated idle states for the cpuidle driver.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I see similar code in omap2:

omap2_pm_idle()
 -> omap2_enter_full_retention()
     -> omap2_sram_suspend()

Is that code path safe to use without RCU or does it need a similar change?

        Arnd
