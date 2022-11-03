Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8751C4332F
	for <openrisc@archiver.kernel.org>; Thu,  3 Nov 2022 12:59:50 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6831124BF2;
	Thu,  3 Nov 2022 13:59:49 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mail.librecores.org (Postfix) with ESMTPS id 6E45F24841
 for <openrisc@lists.librecores.org>; Thu,  3 Nov 2022 13:59:47 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 i5-20020a1c3b05000000b003cf47dcd316so3292433wma.4
 for <openrisc@lists.librecores.org>; Thu, 03 Nov 2022 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IxRwrgpGcbayuw2J5RAtTHB/3ysPD12k+PHRaeFxlKQ=;
 b=GwwrRjkkygx3kA4xo0QuwS+Ne2RINsFO3eCQp6cQ9Ourq60bUc4Bt5AgAPDbQAon6l
 gYwG/q+U+4m65imNxHxEtv/wguv7zVx1FdM6bBSupRiKHQqcJvzgQCj/pXBAzObzeey2
 eIWJHLQuwXCd9OYAJulehF09iAhGGabS+GZ77jdsbOlVSgmaGBS8wMdeEM0HU+61DYEc
 XSM998DKTGw19ogYfqk8LePf/GDY1Q9OaYCfMoPhWyy6X91NirqfboJUiqUVN8Bntsr0
 J4JjRNE0fAbRqdAi3Z8tdryQsJpUsCFo5O3S6BnzL7FXthHoIBTqW543UoTxkVoKFyC9
 j5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxRwrgpGcbayuw2J5RAtTHB/3ysPD12k+PHRaeFxlKQ=;
 b=FFFjgvH6ufvdPCDxOYduwffKj0ISag3k1/TU+hgWjhRUP6tbP+u3nSexhjlQd03ROu
 WPPv0mKQc2lUNMFSbHmCk07jOAp4lPJghPuFtQNrAnMCBM4uE6G0j5qX0SEFm+mMJbPJ
 kf/jfBi+p2jJPNBAB7kHou7Hs6pVdN7VILUifh3UMlz1sP7TsPVJb7DqxP4tUSVi0nwk
 q4jVTJ7NFMExsJ1gWI6SrKt8c6KVe2w37kJ6dkV6o+D0YHB++7p9Vf7XAGapZ5a+hd07
 bQmsIFhcEGMA7Go88xJihHbPTHzEIQInyH6nGMZ0X6jHqCR7feVptp5+o6Uma2XlnTBf
 k+OQ==
X-Gm-Message-State: ACrzQf1Xj8yqEGVTcDkW1P0ggP2ZckrzyMOqxwLYrS0y/yefKXpERqs3
 B1FQOMmbFZ7XD3pB0jWbffxt/g==
X-Google-Smtp-Source: AMsMyM4gXpjfMh9GUNM/WaSq7jLD61jpWhHWyPIsDO5O97VJQvdfk1Gffqv1EV4246udjYvGZYs8Pg==
X-Received: by 2002:a05:600c:3b1d:b0:3c6:ff0d:6a60 with SMTP id
 m29-20020a05600c3b1d00b003c6ff0d6a60mr19364166wms.183.1667480386818; 
 Thu, 03 Nov 2022 05:59:46 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
 by smtp.gmail.com with ESMTPSA id
 bg36-20020a05600c3ca400b003cf774c31a0sm5977531wmb.16.2022.11.03.05.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 05:59:46 -0700 (PDT)
Date: Thu, 3 Nov 2022 13:59:45 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221103125945.lrr5oxxmylwpam53@kamzik>
References: <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop> <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic> <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic> <20221031100327.r7tswmpszvs5ot5n@kamzik>
 <Y2K6clNJBn0SbWU+@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2K6clNJBn0SbWU+@zn.tnic>
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

On Wed, Nov 02, 2022 at 07:44:02PM +0100, Borislav Petkov wrote:
> On Mon, Oct 31, 2022 at 11:03:27AM +0100, Andrew Jones wrote:
> > Currently (after the revert of 78e5a3399421)
> 
> After the revert?
> 
> That commit is still in the latest Linus tree.

The revert commit is 80493877d7d0 ("Revert "cpumask: fix checking valid
cpu range".")

> 
> > with DEBUG_PER_CPU_MAPS we'll get a warning splat when the cpu is
> > outside the range [-1, nr_cpu_ids)
> 
> Yah, that range makes sense.
> 
> > and cpumask_next() will call find_next_bit() with the input plus one anyway.
> > find_next_bit() doesn't explicity document what happens when an input is
> > outside the range, but it currently returns the bitmap size without any
> > side effects, which means cpumask_next() will return nr_cpu_ids.
> 
> That is good to have in the commit message.
> 
> > show_cpuinfo() doesn't try to show anything in that case and stops its
> > loop, or, IOW, things work fine now with an input of nr_cpu_ids - 1. But,
> > show_cpuinfo() is just getting away with a violated cpumask_next()
> > contract, which 78e5a3399421 exposed. How about a new commit message like
> > this
> 
> You're making it sound more complex than it is. All you wanna say is:
> 
> "Filter out invalid cpumask_next() inputs by checking its first argument
> against nr_cpu_ids because cpumask_next() will call find_next_bit() with
> the input plus one but the valid range for n is [-1, nr_cpu_ids)."

The patch I'm proposing ensures cpumask_next()'s range, which is actually
[-1, nr_cpus_ids - 1), isn't violated. Violating that range will generate
the warning for kernels which have commit 78e5a3399421 ("cpumask: fix
checking valid cpu range"), but not its revert.

Since 78e5a3399421 has been reverted, the value of this proposed fix is
less, and indeed the warning may even go away completely for these types
of cpumask calls[1]. However, it seems reasonable for callers to implement
their own checks until the cpumask API has documented what they should
expect.

[1] https://lore.kernel.org/all/CAHk-=wihz-GXx66MmEyaADgS1fQE_LDcB9wrHAmkvXkd8nx9tA@mail.gmail.com/

> 
> But that thing with the revert above needs to be clarified first.

I'll send a v4 with another stab at the commit message.

Thanks,
drew

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
