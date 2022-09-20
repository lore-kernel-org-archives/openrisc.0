Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A347C54EE9
	for <openrisc@archiver.kernel.org>; Tue, 20 Sep 2022 02:49:30 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C9918249BB;
	Tue, 20 Sep 2022 04:49:29 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mail.librecores.org (Postfix) with ESMTPS id E019A2496F
 for <openrisc@lists.librecores.org>; Tue, 20 Sep 2022 04:49:27 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 d64-20020a17090a6f4600b00202ce056566so9346468pjk.4
 for <openrisc@lists.librecores.org>; Mon, 19 Sep 2022 19:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=rI0IpfDVb05suW6mssP/QFC86Iigix9NLenW3JQ6Phs=;
 b=lnIljFKp1ED3j5wPYTN7mdVUfk7FiKkjAkcUsYSYUMCZpdQ5U8vkDdIo4K0hiw1RH3
 +GFslTzjK43l0+rnV0YItKzr73eqf7dBzWl3BzQNkwS39xy9TTbRZE0df01R7//5oEJr
 gCiIxE6Vh5vvSGpkucOrRiDvI3G32scMCweV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=rI0IpfDVb05suW6mssP/QFC86Iigix9NLenW3JQ6Phs=;
 b=2/Ix06k7gdyuTGqX585HuSZxE0N1EEf449AwUBWfWU59flG3SmPnUQ+XZp+rU78Xw3
 sHlftQxE/R8q2S/i7MRflCfuqcIFvDQUx+LtF251bV0ljv/K8CtC2Woi6RKEKLOMPcFu
 HQK11zKOro64WCP0agQqJBYgXA2ukI7denlvSxRBgQBcdrkeVtCP5K/VSXW+uGly59Yp
 i0qr3DoxKP1lELxIt/8r/y2Ap747M2r92j3yJfn5rDMZT4I2sUuNmyZbRrYWj0t/zg9g
 /iZPu92/eIAUJJ/dqjkUsdRnSsWad/8mOBONIifg0NLugQbersE9eCIgF+Zz6E4BqPnn
 IISQ==
X-Gm-Message-State: ACrzQf1i73/MDoOy6bg1GUnLi6qdSc+3OCIMXRohl6hGN+tw/PFspk9r
 RWaJHEdtoFNv3p7PuE//ebQN3w==
X-Google-Smtp-Source: AMsMyM7S+Aze7xjQjfeMxV1IycjxiN9uStAZCOz26LYAWGHUeF519ICUTt9w2zkpb7un7hJ/v+di5Q==
X-Received: by 2002:a17:902:8e84:b0:178:57e4:805b with SMTP id
 bg4-20020a1709028e8400b0017857e4805bmr2741327plb.144.1663642166279; 
 Mon, 19 Sep 2022 19:49:26 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:5744:3726:1f8b:92ad])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a170903024600b00178a9b193cfsm119779plh.140.2022.09.19.19.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Sep 2022 19:49:25 -0700 (PDT)
Date: Tue, 20 Sep 2022 11:49:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 25/44] printk: Remove trace_.*_rcuidle() usage
Message-ID: <YykqKm5j5q9DEKk7@google.com>
References: <20220919095939.761690562@infradead.org>
 <20220919101522.021681292@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919101522.021681292@infradead.org>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, kasan-dev@googlegroups.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 linux@armlinux.org.uk, linux-csky@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, linux-imx@nxp.com, linux-snps-arc@lists.infradead.org,
 virtualization@lists.linux-foundation.org, pmladek@suse.com,
 john.ogness@linutronix.de, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-um@lists.infradead.org, rostedt@goodmis.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 loongarch@lists.linux.dev, linux-tegra@vger.kernel.org, tglx@linutronix.de,
 linux-omap@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 senozhatsky@chromium.org, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On (22/09/19 12:00), Peter Zijlstra wrote:
> The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
> tracepoint"), was printk usage from the cpuidle path where RCU was
> already disabled.
> 
> Per the patches earlier in this series, this is no longer the case.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
