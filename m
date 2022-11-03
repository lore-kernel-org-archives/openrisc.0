Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66CEC43217
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:19:36 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8FAB920ADE;
	Sun,  6 Nov 2022 22:19:35 +0100 (CET)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by mail.librecores.org (Postfix) with ESMTPS id D60C62591D
 for <openrisc@lists.librecores.org>; Thu,  3 Nov 2022 17:30:57 +0100 (CET)
Received: by mail-oo1-f49.google.com with SMTP id
 k12-20020a4ab08c000000b0049e2ab19e04so333477oon.6
 for <openrisc@lists.librecores.org>; Thu, 03 Nov 2022 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2wf8Ox+cqI36jbP+T7p6EKTUvmpF6v5KouIok7EbcyU=;
 b=Jxprr5Yb6GFP2iMDdNYwrv+edL5lsVZ+sskHoEYasypEvTLy4Q6vhTS7qqFC2ZOJ9F
 7UlwmUBWdL8ATQXLGSU2oLt77vVHPXn0OrJO9RZ4ozCxeZSFNH6CKpqcZtCvnwol4zeN
 srTpQmrtC9fSlFcJoeE3VBMkcRHxF4UC77PI0QPdBZOTiLk4O1EgX10WGEBp+gELT/Of
 f0hLEd5d1y3j2mzfUulOKKw9wLwe0rGXdFxYErQK/3o71DkASuqcP1UgrC5XDCQfhx1n
 GSTmaFTFIU7py0xRt57Y61rOd+D7tYEKoK35ZenJvXOnTlTZe3nUPKJMZ1OW7PKQwbP+
 CarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wf8Ox+cqI36jbP+T7p6EKTUvmpF6v5KouIok7EbcyU=;
 b=GjQ6uVrbiWwe9pnCYa8Y2mumVcvdf+uEm2ZMU51SYqfLlCHkkHLGIqXLXqVkFeiI8F
 g2UzRPC9NkIwGgPqOIP8B9KVOyrv3p7HLfe3vw69KrJi7Xt+5vWTFHoF3jnVkRU3t0Zm
 CC/gd8DopjSjsK4/E6xb6cpYQhZwW38rrXl3FCGfoHg1MZ0xr0p3B8UsFzS3buzlDTvi
 VQehHnpajho5QczK/psCH3qJECcKVXtDewVPF86APIRkGHslsgIpktWsmh61+ZKnCkk3
 V8PRFTS9AsJhd+fL73stiGwn1Pikgy/DSvk7qYAxbY6vD0Mh3I1l4MuRHpTNtMkgp75N
 mMhQ==
X-Gm-Message-State: ACrzQf1cK4C6GHFY0RHlfb0Xa0/Xpu6ixmeAWBAR15DrdESpSq4cEWpa
 aODtby6woan86rhXvZGz5yE=
X-Google-Smtp-Source: AMsMyM4XFkvxtx6hYtImOQooUBUuMwcsCe7CNpBD20J79Sc2FfnE52Rm7s0RT965HybTqZXYxmJ8ng==
X-Received: by 2002:a4a:a609:0:b0:499:74ab:f10e with SMTP id
 e9-20020a4aa609000000b0049974abf10emr12101601oom.13.1667493056510; 
 Thu, 03 Nov 2022 09:30:56 -0700 (PDT)
Received: from localhost ([12.97.180.36]) by smtp.gmail.com with ESMTPSA id
 t15-20020a4a858f000000b00480e1109695sm370965ooh.10.2022.11.03.09.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 09:30:56 -0700 (PDT)
From: yury.norov@gmail.com
X-Google-Original-From: Yury Norov <yury.norov@gmail.com>, To: Andrew Jones
 <ajones@ventanamicro.com>; 
Date: Thu, 3 Nov 2022 09:30:54 -0700
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y2PsvvOWVs9ZLBsp@yury-laptop>
References: <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic> <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic> <20221031100327.r7tswmpszvs5ot5n@kamzik>
 <Y2K6clNJBn0SbWU+@zn.tnic> <20221103125945.lrr5oxxmylwpam53@kamzik>
 <Y2PX9GfxWYh6+XGT@zn.tnic> <20221103153404.uh77nrdkowrxj6cr@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103153404.uh77nrdkowrxj6cr@kamzik>
X-Mailman-Approved-At: Sun, 06 Nov 2022 22:19:32 +0100
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
 Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 openrisc@lists.librecores.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Nov 03, 2022 at 04:34:04PM +0100, Andrew Jones wrote:
> On Thu, Nov 03, 2022 at 04:02:12PM +0100, Borislav Petkov wrote:
> > On Thu, Nov 03, 2022 at 01:59:45PM +0100, Andrew Jones wrote:
> > > The patch I'm proposing ensures cpumask_next()'s range, which is actually
> > > [-1, nr_cpus_ids - 1),
> > 
> > Lemme make sure I understand it correctly: on the upper boundary, if you
> > supply for n the value nr_cpu_ids - 2, then it will return potentially
> > the last bit if the mask is set, i.e., the one at position (nr_cpu_ids - 1).
> > 
> > If you supply nr_cpus_ids - 1, then it'll return nr_cpu_ids to signal no
> > further bits set.
> > 
> > Yes, no?
> 
> Yes
> 
> > 
> > > I'll send a v4 with another stab at the commit message.
> > 
> > Yes, and it is still an unreadable mess: "A kernel compiled with commit
> > ... but not its revert... " Nope.
> > 
> > First make sure cpumask_next()'s valid accepted range has been settled
> > upon, has been explicitly documented in a comment above it and then I'll
> > take a patch that fixes whatever is there to fix.
> 
> That's fair, but I'll leave that to Yury.

I'll take care of it.
 
> > Callers should not have to filter values before passing them in - the
> > function either returns an error or returns the next bit in the mask.
> 
> That's reasonable, but cpumask folk probably need to discuss it because
> not all cpumask functions have a return value where an error may be
> placed.
 
Callers should pass sane arguments into internal functions if they
expect sane output. The API not exported to userspace shouldn't
sanity-check all inputs arguments. For example, cpumask_next() doesn't
check srcp for NULL.

However, cpumask API is exposed to drivers, and that's why optional
cpumask_check() exists. (Probably. It has been done long before I took
over this.)

Current *generic* implementation guarantees that out-of-region offset
would prevent cpumask_next() from dereferencing srcp, and makes it
returning nr_cpu_ids. This behavior is expected by many callers. However,
there is a couple of non-generic cpumask implementations, and one of
them is written in assembler. So, the portable code shouldn't expect
from cpumasks more than documentation said: for a _valid_ offset
cpumask_next() returns next set bit or >= nr_cpu_ids.

cpumask_check() has been broken for years. Attempting to fix it faced
so much resistance, that I had to revert the patch. Now there's
ongoing discussion whether we need this check at all. My opinion is
that if all implementations of cpumask (more precisely, underlying
bitmap API) are safe against out-of-range offset, we can simply remove
cpumask_check(). Those users, like cpuinfo, who waste time on useless
last iteration will bear it themselves. 
 
Thanks,
Yury
