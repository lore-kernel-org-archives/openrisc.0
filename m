Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CAC4332F
	for <openrisc@archiver.kernel.org>; Tue, 18 Oct 2022 07:36:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CEE5D24C2F;
	Tue, 18 Oct 2022 09:36:32 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mail.librecores.org (Postfix) with ESMTPS id D1E0C24B37
 for <openrisc@lists.librecores.org>; Tue, 18 Oct 2022 09:36:31 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id f22so9176413qto.3
 for <openrisc@lists.librecores.org>; Tue, 18 Oct 2022 00:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mwq8mRE5qiqVJEFTV8PMaTxlxiFl0HRvXCI1ESDIAgA=;
 b=0tYsrYZPvPuggXxZjkgYkvKB1nyxhHADNxxwWySB5V+23tuXgcg5zsgxy+vbdF9joh
 vfnjE9JwvnvkPVcLxOnTZnKH8uUE+jjQVOVoa0USIkHbpPvHmhBJ4qF8zCpAm2dvTIyA
 ZihP/+wY8P7xmGUo3qNgDhy/C7gTYzbMPViM8EL6ZklJi9hjwYhk3dOJGC1rdP3gOptV
 bIApLbFXt90zoOm6thWIKGJz42gp1xA2ujhNGzshD69KZEtKwBAJMNOtmUc/kVS9iQp0
 8z27t6FeXMvxgfpNyibEXCyKt8HiKcxm9u7CBAMz+NKhXmd//C/9jUlF7VA5lU8TamCg
 NTIw==
X-Gm-Message-State: ACrzQf1BdHxtYuZQnHsYPx84Ok9hmoflBFgTnH8KhGVZenp/rMbiUDiN
 5MtxCrrYnHTnkeiwk9ssElCA7DcVNfGhQHBj
X-Google-Smtp-Source: AMsMyM6jx+DW+CbMV0t2gdN+4v/pkC2yYb9pzJVB/QzqwZBBC6lHc1U+2jnIOWkeGA0jH5C/1h4JTg==
X-Received: by 2002:ac8:5d49:0:b0:39c:c082:1417 with SMTP id
 g9-20020ac85d49000000b0039cc0821417mr1042547qtx.687.1666078590661; 
 Tue, 18 Oct 2022 00:36:30 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com.
 [209.85.128.178]) by smtp.gmail.com with ESMTPSA id
 fa12-20020a05622a4ccc00b0039cb8cdaa6bsm1402902qtb.63.2022.10.18.00.36.30
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Oct 2022 00:36:30 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-358bf076f1fso129246137b3.9
 for <openrisc@lists.librecores.org>; Tue, 18 Oct 2022 00:36:30 -0700 (PDT)
X-Received: by 2002:a81:848c:0:b0:356:e173:2c7a with SMTP id
 u134-20020a81848c000000b00356e1732c7amr1276352ywf.502.1666078253767; Tue, 18
 Oct 2022 00:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Oct 2022 09:30:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwAgPkifAkah7MoBKBoyB4tb+HM5cgvenwNFaAfbg+UQ@mail.gmail.com>
Message-ID: <CAMuHMdWwAgPkifAkah7MoBKBoyB4tb+HM5cgvenwNFaAfbg+UQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove kern_addr_valid() completely
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Oct 18, 2022 at 9:25 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Most architectures(except arm64/x86/sparc) simply return 1 for
> kern_addr_valid(), which is only used in read_kcore(), and it
> calls copy_from_kernel_nofault() which could check whether the
> address is a valid kernel address, so no need kern_addr_valid(),
> let's remove unneeded kern_addr_valid() completely.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>  arch/m68k/include/asm/pgtable_mm.h        |  2 -
>  arch/m68k/include/asm/pgtable_no.h        |  1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
