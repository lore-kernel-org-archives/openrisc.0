Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDFC46467
	for <openrisc@archiver.kernel.org>; Sat,  7 Jan 2023 11:04:57 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 042C9200CB;
	Sat,  7 Jan 2023 12:04:56 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mail.librecores.org (Postfix) with ESMTPS id B9447215C6
 for <openrisc@lists.librecores.org>; Sat,  7 Jan 2023 12:04:53 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id g10so2702566wmo.1
 for <openrisc@lists.librecores.org>; Sat, 07 Jan 2023 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=jV2yBF+mbkDE0BvyOwe05ARE6EO7XhtOfB/KJLMsfFA=;
 b=BzPTx+ODS2RwGu5d9Av3CGI6XJ0NbmKP1pStUzg0M0m6+VF6wu2vf0tqTwK0k6q0qV
 Fbx7Y4Wluy9p+k8PZjL3FOoLufHJHxtq2K/BaarEwd/dPtd/DgO4uDiDqLUXCcfzSy4g
 Wd0wz4xfpZYGbxR/O6enZWRjIhs25ZrrKgwvTGouDcupcbkSfLeRveiApotbcr4XMgph
 w/4+08uhP/RwKAozhcyw6lYPvScMk8zL6fmWwbkyxQOkT9WdSUz8lze9ta3Mlh7zLg9k
 cM2v76pe7iQT/2ZR+EkGweLVXlhhfTIoWJwjo2u32vXfi3qjeDrWte72tROnSs3wxhtS
 1Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jV2yBF+mbkDE0BvyOwe05ARE6EO7XhtOfB/KJLMsfFA=;
 b=pcTFRAjc4EjsMoiC+5XgNF7Xx1gUmEtXMqGa+3KcmmIo0Leqo+pbtmg4e1Kski7GOr
 mk3RlkwOZ+mbqHO/rB37BYOYzG9+bzDLnZ6TKA66OeT0+9cTCy3haHOWbiVh6UuaT3mt
 cCGAbKl3p7BkdHDWrP9lkY4JV8Gg3D3puX9Qy8AecGKAFCbqWsPKJyxtP954uo5orSLp
 7K2EPuX1otvIzTnWuFPYSLzADtEwLqRxpEoQlPJVuv9jKXtAvm2ARhtJHBGy0ln3LiY4
 NgewVorcpxBtL862HdlzQjNrZ9sy2E9iGBEBG4sEFZ6Hb8l/RhDbFGB1BpjxpSb4gtAI
 jW5Q==
X-Gm-Message-State: AFqh2koM1uoQRazUEHNSvm7L3aEe7sDt9chtcFzJJLVvW/M8+vQJMBC5
 XPsB9e8amJvcuFcWERsPLPY=
X-Google-Smtp-Source: AMrXdXuUafS1AFxogNrZXZJj6k6oC1QjVGeJmfZCRFdf2sgwNHMbrVBUD4+y7GGme2gWJhcqxBhA0A==
X-Received: by 2002:a05:600c:601e:b0:3c6:e61e:ae71 with SMTP id
 az30-20020a05600c601e00b003c6e61eae71mr50341357wmb.1.1673089493118; 
 Sat, 07 Jan 2023 03:04:53 -0800 (PST)
Received: from gmail.com (1F2EF507.nat.pool.telekom.hu. [31.46.245.7])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a05600c510900b003c6f8d30e40sm10657278wms.31.2023.01.07.03.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jan 2023 03:04:50 -0800 (PST)
Date: Sat, 7 Jan 2023 12:04:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 3/8] sched, smp: Trace IPIs sent via
 send_call_function_single_ipi()
Message-ID: <Y7lRz7oCaAmAhoqS@gmail.com>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202155817.2102944-4-vschneid@redhat.com>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.29
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Nicholas Piggin <npiggin@gmail.com>,
 loongarch@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>


* Valentin Schneider <vschneid@redhat.com> wrote:

> send_call_function_single_ipi() is the thing that sends IPIs at the bottom
> of smp_call_function*() via either generic_exec_single() or
> smp_call_function_many_cond(). Give it an IPI-related tracepoint.
> 
> Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
> which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Patch series logistics:

 - No objections from the scheduler side, this feature looks pretty useful.

 - Certain patches are incomplete, others are noted as being merged 
   separately, so I presume you'll send an updated/completed series 
   eventually?

 - We can merge this via the scheduler tree I suspect, as most callbacks 
   affected relate to tip:sched/core and tmp:smp/core - but if you have 
   some other preferred tree that's fine too.

Thanks,

	Ingo
