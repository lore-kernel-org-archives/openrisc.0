Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED153C43219
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:06:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 08C4324929;
	Sun,  6 Nov 2022 22:05:58 +0100 (CET)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by mail.librecores.org (Postfix) with ESMTPS id 028B924C42
 for <openrisc@lists.librecores.org>; Wed,  2 Nov 2022 19:44:06 +0100 (CET)
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72DBB1EC0430;
 Wed,  2 Nov 2022 19:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1667414646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=iOr/2V0DoRyu5jKtmDX0XiBrZE84Kn1Pob6d6OL2TAQ=;
 b=P8xIFXf059+smEe6r5YZYLEbBvKhvHMQlCDMpFuQpPIyUL+0Na11Qye0LmeFzVkyGcJ0Ue
 fIrCmtMkvbI9pekV7eZIq4LZ2B96yVhn3hhIe318CHOxpV0wNqptu2eHkXK4/tBD234sAI
 ZmyjnjRhdV4j8e7O51OrF3B1uOD5hfo=
Date: Wed, 2 Nov 2022 19:44:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y2K6clNJBn0SbWU+@zn.tnic>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop> <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic> <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic> <20221031100327.r7tswmpszvs5ot5n@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221031100327.r7tswmpszvs5ot5n@kamzik>
X-Mailman-Approved-At: Sun, 06 Nov 2022 22:05:55 +0100
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

On Mon, Oct 31, 2022 at 11:03:27AM +0100, Andrew Jones wrote:
> Currently (after the revert of 78e5a3399421)

After the revert?

That commit is still in the latest Linus tree.

> with DEBUG_PER_CPU_MAPS we'll get a warning splat when the cpu is
> outside the range [-1, nr_cpu_ids)

Yah, that range makes sense.

> and cpumask_next() will call find_next_bit() with the input plus one anyway.
> find_next_bit() doesn't explicity document what happens when an input is
> outside the range, but it currently returns the bitmap size without any
> side effects, which means cpumask_next() will return nr_cpu_ids.

That is good to have in the commit message.

> show_cpuinfo() doesn't try to show anything in that case and stops its
> loop, or, IOW, things work fine now with an input of nr_cpu_ids - 1. But,
> show_cpuinfo() is just getting away with a violated cpumask_next()
> contract, which 78e5a3399421 exposed. How about a new commit message like
> this

You're making it sound more complex than it is. All you wanna say is:

"Filter out invalid cpumask_next() inputs by checking its first argument
against nr_cpu_ids because cpumask_next() will call find_next_bit() with
the input plus one but the valid range for n is [-1, nr_cpu_ids)."

But that thing with the revert above needs to be clarified first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
