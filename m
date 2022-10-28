Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC633C4332F
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:05:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B3F6B24A5E;
	Sun,  6 Nov 2022 22:05:57 +0100 (CET)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by mail.librecores.org (Postfix) with ESMTPS id 5B7D524A5E
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 17:03:19 +0200 (CEST)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD3D51EC02F2;
 Fri, 28 Oct 2022 17:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1666969398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=i/4Cjq8GYwaXxiXVKl0FhiYMVNlnZzPqMpB349dIQEo=;
 b=gxQSofa/L8yGDLBNTJGXcDQT1BZ9EN2QpEBOtb8fae2l7kkacWjuo0irRxC4ObsNM3cmGG
 bPB442gmbrlZRjjavdzIHDYaIOFPK4Q5k/F+Co/CHbM3wSA0Xik4w6msl5qJHKYZvW3nFR
 flu71/Fhe1SdET62l2UNhiU1pG+TDjA=
Date: Fri, 28 Oct 2022 17:03:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y1vvMlwf/4EA/8WW@zn.tnic>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1vrMMtRwb0Lekl0@yury-laptop>
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
 Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
 Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Jones <ajones@ventanamicro.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Oct 28, 2022 at 07:46:08AM -0700, Yury Norov wrote:
> I'll take it in bitmap-for-next this weekend.

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
