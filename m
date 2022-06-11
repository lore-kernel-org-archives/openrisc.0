Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EACCA47F
	for <openrisc@archiver.kernel.org>; Sat, 11 Jun 2022 21:54:10 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id ACAF5248C7;
	Sat, 11 Jun 2022 23:54:08 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mail.librecores.org (Postfix) with ESMTPS id 5533424761
 for <openrisc@lists.librecores.org>; Sat, 11 Jun 2022 04:23:13 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id d14so969716eda.12
 for <openrisc@lists.librecores.org>; Fri, 10 Jun 2022 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HvaEucNyttJ72r4dgkt1sbWCJsvBPyIh5zMt0LNXalY=;
 b=D62jI1p8sOcmW+dGG367yCKI6736qfwlRYdRbtg+pQI3VQ/mZvhMkSh4muEy4yFzXi
 1pifN6keFBPADAFAutLs2f+vKDRy3jOy1SmannYfmHY7tjbpoLbP8600CMqIboz22zit
 FmdCeKC+IDyY3i3YwKCGDz5In1oYgHbIW3q58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HvaEucNyttJ72r4dgkt1sbWCJsvBPyIh5zMt0LNXalY=;
 b=y0sK9joNBLbCt12HtYqKVld2dXQ+Y91Pnaa1xTa/1BJS5R+gkgzHXwOE0AFj+ACP+s
 PuOA80u7bp6ZWjKLLS5SzhqMAC8UVA6iU6nvQDU+K8IA5iVLvnBqcd0jyPhX7o39WnDt
 L5MMkPpqC1aM61KCLzwVedyUWULyM/WoFilVvdf9HSoId6IzoJf0OkPsOxheAWKuWl5p
 7wPCaWW47IRk6B1o+2T17AKN9GBH7iI0TN9A9G2ZikIZxeILQp4FOVMaXDdHtgQ1Hezx
 NM7xFxRJNwKwoTLjGC4j+RwoaS7/DxTvCk5FvofvrwrsBiyK71MN9rsga4bDnjI2mDoA
 kLBA==
X-Gm-Message-State: AOAM533Rc9wvEZHPhYjIjOVRigy4cynVx8gavkpxo6THDrXWUlCPiWUP
 sm5vxpssm6VKKGhmzBNt0JM7zT8w9dm0NnAF77JIzQ==
X-Google-Smtp-Source: ABdhPJz16+9kQdS9QDTB0tjL4FsLbUEsFaIS0ykQfnx5qpyFYyBQCn1i8W4mcCkA/y3viUzYkXAgYYv9JpSOTwgMdpQ=
X-Received: by 2002:a50:eb91:0:b0:42d:c1d8:616a with SMTP id
 y17-20020a50eb91000000b0042dc1d8616amr54940771edr.219.1654914192936; Fri, 10
 Jun 2022 19:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org>
 <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley> <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
 <YqHwOFg/WlMqe8/Z@alley>
In-Reply-To: <YqHwOFg/WlMqe8/Z@alley>
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Sat, 11 Jun 2022 11:23:02 +0900
Message-ID: <CA+_sPaq_47C2PWnGU7WfGXMc03E1Nz+1=F-wZe0B2+ymqdm3Fg@mail.gmail.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
To: Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
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
 linux-pm@vger.kernel.org, jiangshanlai@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org,
 acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org,
 dietmar.eggemann@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 svens@linux.ibm.com, jolsa@kernel.org, paulus@samba.org, mark.rutland@arm.com,
 linux-ia64@vger.kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
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
 boris.ostrovsky@oracle.com, josh@joshtriplett.org, khilman@kernel.org,
 linux-csky@vger.kernel.org, tony@atomide.com,
 linux-snps-arc@lists.infradead.org, mgorman@suse.de,
 jacob.jun.pan@linux.intel.com, yury.norov@gmail.com, ulli.kroll@googlemail.com,
 vgupta@kernel.org, linux-clk@vger.kernel.org, monstr@monstr.eu,
 rostedt@goodmis.org, rcu@vger.kernel.org, bp@alien8.de, bcain@quicinc.com,
 tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org, sudeep.holla@arm.com,
 shawnguo@kernel.org, davem@davemloft.net, dalias@libc.org,
 Peter Zijlstra <peterz@infradead.org>, amakhalov@vmware.com,
 bjorn.andersson@linaro.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 anton.ivanov@cambridgegreys.com, jonas@southpole.se,
 Arnd Bergmann <arnd@arndb.de>, richard@nod.at, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, aou@eecs.berkeley.edu,
 paulmck@kernel.org, hca@linux.ibm.com, openrisc@lists.librecores.org,
 paul.walmsley@sifive.com, linux-tegra@vger.kernel.org, namhyung@kernel.org,
 andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org, jgross@suse.com,
 pv-drivers@vmware.com, linux-mips@vger.kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, ink@jurassic.park.msu.ru, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 9, 2022 at 10:06 PM Petr Mladek <pmladek@suse.com> wrote:
>
> Makes sense. Feel free to use for this patch:
>
> Acked-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
