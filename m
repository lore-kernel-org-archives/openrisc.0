Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8119C4167E
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:06:01 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 147E821292;
	Sun,  6 Nov 2022 22:05:59 +0100 (CET)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by mail.librecores.org (Postfix) with ESMTPS id C7AB8259AD
 for <openrisc@lists.librecores.org>; Fri,  4 Nov 2022 00:22:43 +0100 (CET)
Received: from zn.tnic (p200300ea9733e72b329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9733:e72b:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C7531EC04E2;
 Fri,  4 Nov 2022 00:22:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1667517763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=vFXHtgwdW+sR6NHK/2Q+5sMTWyhXvQL1n6tMJLF2xxY=;
 b=BSXGpnI0im++wmsWNxkeuxKjQQej60wIR/Sk0cX2RZ7YrtQNhQA0/JrxGI20wDUweZrCEb
 k+o4bwMt5u5otuBKP/2kTjRja1l1PH+j5LW/iISR7O4Sn/JezDmf47qxabojUHY5r8I2aI
 FToXcyX9TTPeCYGemSLF53/TOlVnQ5I=
Date: Fri, 4 Nov 2022 00:22:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y2RNP/5Xfs0qS/3X@zn.tnic>
References: <20221031080604.6xei6c4e3ckhsvmy@kamzik> <Y1+OUawGJDjh4DOJ@zn.tnic>
 <20221031100327.r7tswmpszvs5ot5n@kamzik> <Y2K6clNJBn0SbWU+@zn.tnic>
 <20221103125945.lrr5oxxmylwpam53@kamzik> <Y2PX9GfxWYh6+XGT@zn.tnic>
 <20221103153404.uh77nrdkowrxj6cr@kamzik>
 <Y2PsvvOWVs9ZLBsp@yury-laptop> <Y2PxAiJ1yNzcUSgs@zn.tnic>
 <Y2P68sfCJMvhKmhj@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2P68sfCJMvhKmhj@yury-laptop>
X-Mailman-Approved-At: Sun, 06 Nov 2022 22:05:56 +0100
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
 Alexander Gordeev <agordeev@linux.ibm.com>, x86@kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <hca@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 openrisc@lists.librecores.org, Ingo Molnar <mingo@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Nov 03, 2022 at 10:31:30AM -0700, Yury Norov wrote:
> Let's take for example cpu_llc_shared_mask() added by you in
> arch/x86/include/asm/smp.h recently:
> 
>   static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>   {
>          return per_cpu(cpu_llc_shared_map, cpu);
>   }
> 
> It's in a global header and available to the rest of the kernel, just as
> well.

Just like 

static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
{
        return per_cpu(cpu_l2c_shared_map, cpu);
}

should check != must check. 

But it's perfectly fine if you're going to attempt to prove some bogus
argument of yours - I can safely ignore you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
