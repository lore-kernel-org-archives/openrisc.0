Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7932EC433FE
	for <openrisc@archiver.kernel.org>; Tue, 18 Oct 2022 08:10:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3C5AE24C38;
	Tue, 18 Oct 2022 10:09:59 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by mail.librecores.org (Postfix) with ESMTPS id A339024C2F
 for <openrisc@lists.librecores.org>; Tue, 18 Oct 2022 10:09:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JDMMgGHS9LCKyODLO9uQrrR+709UAysRPcPI7Amnu5I=; b=L0kwJK1DnnjMw8tyn0zVMoz+EY
 2IdplpiHntqnGfoLw4L5aFPbyXl4OPx9n/tpBwGF5wDiG6FL+r+Um3IlVMzFNgTV/m5ZcUvIlS2Ob
 RrHxqkgyiUMQaBA5lpP3gmxEowU/lCegyk+WGXUAAEVF6HQj3gKNX2E/AQeJR9mlBt36SBb1LDzny
 8SthHBt1duKxxVZCWmL2Ea/bbg8i/0WDdmu2vCVA21SOp/DNxrKkT+Wv/bzXP0dLWLheBOZfbgKKe
 UaOoUUHpegGOY5zcQb7I5kXzbmzJH8PgEcu2PoJun9+uZEvGUJ6a+d3bpoO7jJKD1nPp7fZWNjihD
 hzu7tJ0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1okhfO-004K9Q-CP; Tue, 18 Oct 2022 08:09:38 +0000
Date: Tue, 18 Oct 2022 01:09:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: remove kern_addr_valid() completely
Message-ID: <Y05fQrd4TYaOnks/@infradead.org>
References: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Andy Lutomirski <luto@kernel.org>, linux-sh@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "H . Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Greg Ungerer <gerg@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Vineet Gupta <vgupta@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Chris Zankel <chris@zankel.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Nicholas Piggin <npiggin@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, loongarch@lists.linux.dev,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Thanks, this is long overdue!

Acked-by: Christoph Hellwig <hch@lst.de>
