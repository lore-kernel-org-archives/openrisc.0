Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781FC25B0D
	for <openrisc@archiver.kernel.org>; Sun, 31 Jul 2022 22:07:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 74963248E4;
	Mon,  1 Aug 2022 00:07:44 +0200 (CEST)
Received: from server.lespinasse.org (server.lespinasse.org [63.205.204.226])
 by mail.librecores.org (Postfix) with ESMTPS id 671FD242D7
 for <openrisc@lists.librecores.org>; Sun, 31 Jul 2022 01:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-79-ed;
 t=1659224730; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=nAVqtDkPyoGTnjQOsobKhENqaeU5rNiWFfP8mKVev5k=;
 b=HFFhCK7R4iKO9dp7xadnNvlJ3TFgnIFCD+mWF8YiQOWKhEk/dwPTWNRYWGC9XfN1WRDf2
 g306xaRkvMw+dqoAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-79-rsa; t=1659224730; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=nAVqtDkPyoGTnjQOsobKhENqaeU5rNiWFfP8mKVev5k=;
 b=xEm4vrS+nhrfg16KlTSOz6xKHVgl2anxivbQOaQ8iyITrSIXx3k7S+7DNm3/9PE3/hP5/
 weBfs5WCmns8PrJOUh5+LyucC170rSw2K/NgNrAjDpputAJGflo+dG36LsXYxD+GZSSZKbP
 Pj/N5DYITgz/J3aBedmEOjvEEcNa6ityOyI32KA+gNj6htWosOb+QOsIsRx/2q9SXnXOMQE
 CoO7nRU+J2kcBx1HiMTnfjr/eN+QixQZGT0tRp8own4vN9hl237pUBRGLyuycFtncUUh4v4
 MsO6ge1ke2qwlIabxdvLZxjhahuiQC5BaBfCoCYkudJkUo4tS5HM55MrUsVw==
Received: by server.lespinasse.org (Postfix, from userid 1000)
 id F117B160977; Sat, 30 Jul 2022 16:45:29 -0700 (PDT)
Date: Sat, 30 Jul 2022 16:45:29 -0700
From: Michel Lespinasse <michel@lespinasse.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Message-ID: <20220730234529.GC1587@lespinasse.org>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
 <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org>
 <CAJZ5v0gyPtX=ksCibo2ZN_BztCqUn9KRtRu+gsJ5KetB_1MwEQ@mail.gmail.com>
 <20220730094800.GB1587@lespinasse.org>
 <CAJZ5v0hXVjsWab=qYZfXBTqcjkpWV0CFT9_oQBKQ28rFG3_VLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXVjsWab=qYZfXBTqcjkpWV0CFT9_oQBKQ28rFG3_VLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Mon, 01 Aug 2022 00:07:35 +0200
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
Cc: Michel Lespinasse <michel@lespinasse.org>,
 Juri Lelli <juri.lelli@redhat.com>, Linux-sh list <linux-sh@vger.kernel.org>,
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
 Matt Turner <mattst88@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, sammy@sammy.net,
 Petr Mladek <pmladek@suse.com>, Linux PM <linux-pm@vger.kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-um@lists.infradead.org, acme@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Richard Henderson <rth@twiddle.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
 Sven Schnelle <svens@linux.ibm.com>, jolsa@kernel.org,
 Paul Mackerras <paulus@samba.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 kernel@xen0n.name, quic_neeraju@quicinc.com, linux-s390@vger.kernel.org,
 vschneid@redhat.com, John Ogness <john.ogness@linutronix.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Will Deacon <will@kernel.org>,
 Helge Deller <deller@gmx.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Frederic Weisbecker <frederic@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-xtensa@linux-xtensa.org, Sascha Hauer <kernel@pengutronix.de>,
 Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-alpha@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Stephen Boyd <sboyd@kernel.org>, rh0@fb.com,
 dinguyen@kernel.org, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Joel Fernandes <joel@joelfernandes.org>, Fabio Estevam <festevam@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Josh Triplett <josh@joshtriplett.org>, Kevin Hilman <khilman@kernel.org>,
 linux-csky@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 linux-snps-arc@lists.infradead.org, Mel Gorman <mgorman@suse.de>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yury Norov <yury.norov@gmail.com>,
 ulli.kroll@googlemail.com, vgupta@kernel.org,
 linux-clk <linux-clk@vger.kernel.org>, Michal Simek <monstr@monstr.eu>,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, bcain@quicinc.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 David Miller <davem@davemloft.net>, Rich Felker <dalias@libc.org>,
 Peter Zijlstra <peterz@infradead.org>, amakhalov@vmware.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv <linux-riscv@lists.infradead.org>, anton.ivanov@cambridgegreys.com,
 jonas@southpole.se, Arnd Bergmann <arnd@arndb.de>,
 Richard Weinberger <richard@nod.at>, the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Paul E. McKenney" <paulmck@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, namhyung@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jpoimboe@kernel.org,
 Juergen Gross <jgross@suse.com>, pv-drivers@vmware.com,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Johannes Berg <johannes@sipsolutions.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Sat, Jul 30, 2022 at 09:52:34PM +0200, Rafael J. Wysocki wrote:
> On Sat, Jul 30, 2022 at 11:48 AM Michel Lespinasse
> <michel@lespinasse.org> wrote:
> > I'm not sure if that was the patch you meant to send though, as it
> > seems it's only adding a tracepoint so shouldn't make any difference
> > if I'm not actually using the tracepoint ?
> 
> You are right, it looks like I pasted a link to a different patch by
> mistake.  Sorry about that.
> 
> I meant this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm&id=d295ad34f236c3518634fb6403d4c0160456e470
> 
> which will appear in the final 5.19.

Thanks. I can confirm that this patch fixes the boot time debug
warnings for me. And I see that linus already merged it, nice!

--
Michel "walken" Lespinasse.
