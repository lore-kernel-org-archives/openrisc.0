Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D2BC4332F
	for <openrisc@archiver.kernel.org>; Thu,  3 Nov 2022 15:34:12 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8A63524C66;
	Thu,  3 Nov 2022 16:34:11 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by mail.librecores.org (Postfix) with ESMTPS id 79A8D24C05
 for <openrisc@lists.librecores.org>; Thu,  3 Nov 2022 16:34:10 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id kt23so6259166ejc.7
 for <openrisc@lists.librecores.org>; Thu, 03 Nov 2022 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2nyiqtS+4bjeBqC2j1CWjrUOou5+X6yWUKBJ7APuUG8=;
 b=IMzxLKhzewPSr953ozKcvA7MJkFz5aBGxh8wYt4YDDFNkFIw3w1GbuIjjEYSijrvZN
 vrsCGUFhvMNDOgPyJH44HqqAB1ZCby8RagmeEdamwIzh7rWeGkXUJabTgCCG9GgR49p8
 eM1itnPR9VBPRPpXfufcFcUxykqWRbKSPPJgqNhWqyIczmyjaQ6yxBg5KqRewZ7TYZcy
 yquj8IvH/AQtJnsWm9yePrvX+uUI5XSresCTCa3CObXmVX+CRvt3amiWYtwztltaW2u/
 K2vNjxe8ke2YRetylyiUkj+eMGGsypPmIL4gqhk0ENvCLYBb5PdSkY7ojDfwYsl+jzEo
 D12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nyiqtS+4bjeBqC2j1CWjrUOou5+X6yWUKBJ7APuUG8=;
 b=EgicJ9HnP5BpYI6SLqCo67x6+QkLfGXcUQOJ8GKXvFiCMmxlgmc0Usv3zhPXs+pSgy
 m+FcPoCVu81/6Xib0T9xcdHU/XhdE1LyEDzRYKQDTVl8v1++D3NWz7JuRWEMX5+YE7bw
 9OFv75frduL41xcOX7e5g4aLTZ01l6zWIExDcpfzCuZqOPCQSviiu5MP9ciJSLxMSJDh
 Yt4bgyMNwsFhjvPczn9vK9ENSVJGdQY7alYtQR3afSw0bFrXcYeYg3icw23Z6WZBuRgl
 iYW1tRtb2h3JZhWjZ2+FujxI3LdM84JNPRrOeBLW2f0xlVlgdQw3+yXybeGhVvTuja1w
 rcjA==
X-Gm-Message-State: ACrzQf0hUtD2yJD46y9qx1R3ZXFvNgLFnpSh6VCBfMFo5YwbcY/l1Hjp
 XpwrwLQ+SspGZq6lb3ebf/7qrg==
X-Google-Smtp-Source: AMsMyM7fW4+lX3GNb3JnmyhpDtENiHSDLEpmcsIq/zZQ8gPf3Wg1SImlQR44FmCt0HiSs2WLUbDJOQ==
X-Received: by 2002:a17:907:6e1a:b0:7ad:ba0b:538c with SMTP id
 sd26-20020a1709076e1a00b007adba0b538cmr26868184ejc.111.1667489645948; 
 Thu, 03 Nov 2022 08:34:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a170906a20500b00787f91a6b16sm627228ejy.26.2022.11.03.08.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 08:34:05 -0700 (PDT)
Date: Thu, 3 Nov 2022 16:34:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221103153404.uh77nrdkowrxj6cr@kamzik>
References: <Y1vrMMtRwb0Lekl0@yury-laptop> <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic> <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic> <20221031100327.r7tswmpszvs5ot5n@kamzik>
 <Y2K6clNJBn0SbWU+@zn.tnic> <20221103125945.lrr5oxxmylwpam53@kamzik>
 <Y2PX9GfxWYh6+XGT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PX9GfxWYh6+XGT@zn.tnic>
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
Cc: Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Yury Norov <yury.norov@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 openrisc@lists.librecores.org, Ingo Molnar <mingo@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Nov 03, 2022 at 04:02:12PM +0100, Borislav Petkov wrote:
> On Thu, Nov 03, 2022 at 01:59:45PM +0100, Andrew Jones wrote:
> > The patch I'm proposing ensures cpumask_next()'s range, which is actually
> > [-1, nr_cpus_ids - 1),
> 
> Lemme make sure I understand it correctly: on the upper boundary, if you
> supply for n the value nr_cpu_ids - 2, then it will return potentially
> the last bit if the mask is set, i.e., the one at position (nr_cpu_ids - 1).
> 
> If you supply nr_cpus_ids - 1, then it'll return nr_cpu_ids to signal no
> further bits set.
> 
> Yes, no?

Yes

> 
> > I'll send a v4 with another stab at the commit message.
> 
> Yes, and it is still an unreadable mess: "A kernel compiled with commit
> ... but not its revert... " Nope.
> 
> First make sure cpumask_next()'s valid accepted range has been settled
> upon, has been explicitly documented in a comment above it and then I'll
> take a patch that fixes whatever is there to fix.

That's fair, but I'll leave that to Yury.

> 
> Callers should not have to filter values before passing them in - the
> function either returns an error or returns the next bit in the mask.

That's reasonable, but cpumask folk probably need to discuss it because
not all cpumask functions have a return value where an error may be
placed.

> 
> This thing:
> 
> 	if (*pos == nr_cpu_ids)
> 
> but then to pass in pos - 1:
> 
> 	*pos = cpumask_next(*pos - 1
> 
> looks to me like the interface needs more cooking.

Indeed, but that's less of an issue with cpumask_next() than with
the way cpuinfo implements its start and next seq ops (next
unconditionally increments *pos and then calls start and start
must use *pos - 1 since the first time its called it needs to use
-1).

Thanks,
drew
