Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BADC32773
	for <openrisc@archiver.kernel.org>; Fri, 19 Aug 2022 09:40:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B8250214F6;
	Fri, 19 Aug 2022 11:40:41 +0200 (CEST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by mail.librecores.org (Postfix) with ESMTPS id 40A79211B0
 for <openrisc@lists.librecores.org>; Fri, 19 Aug 2022 11:40:39 +0200 (CEST)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-11c59785966so4641721fac.11
 for <openrisc@lists.librecores.org>; Fri, 19 Aug 2022 02:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=bRymBzdXlfqAZ/An0FhEAiaTJ5r51uvoXyU3bQ2b9Zs=;
 b=fg4FP3WKDoH7iIAvWVvHkPI8g/lnriXZB/VnG+/5P/jGcHU5l45EN7A26k2euRO7R2
 /g7h0PKZnjzrQMhMGkilaGXm3ti8jMZSdg+o/HspwvCQkkS7wFOxx/ZpFpeCM7BjmdiG
 8Va5Djc/hhVIe+tNPPx+LcyY3ldBOE4FgFw+i1tHxYwYKwNOc05rQ216V9i//PlUK7lE
 D8/eirUZ+JwE77cQMdnf636ubs6kTLylihShxw4VbQeufJIdQlaFlXCXDe0iGOdC/IbI
 TyBYxzNFqODVrcXZOgiAJkKQnsOjRtY1SJBphLkEgHQYolRT61age9gbaV/3bP2au3v1
 45xA==
X-Gm-Message-State: ACgBeo2bM7wdWT0Y9FelQ8WAUbI87T2m82Qi2GuGW7/jS0LwDAmo+yB2
 ZT/Gt4pGYciP+PI6sTrpDNUjsMwFltnkcGxP
X-Google-Smtp-Source: AA6agR6QjplwU8HU1DrSnDBX6hmFsJM6uTqEa/1B05P7XuTlLZ2EcwbNPkBHfPbXKN8N6DRE6BiWuQ==
X-Received: by 2002:a05:6870:15c9:b0:101:cdac:3887 with SMTP id
 k9-20020a05687015c900b00101cdac3887mr3260827oad.35.1660902037884; 
 Fri, 19 Aug 2022 02:40:37 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52]) by smtp.gmail.com with ESMTPSA id
 x36-20020a05683040a400b00638cea5947esm1041387ott.25.2022.08.19.02.40.36
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Aug 2022 02:40:36 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id
 m21-20020a9d6ad5000000b00638df677850so2745843otq.5
 for <openrisc@lists.librecores.org>; Fri, 19 Aug 2022 02:40:36 -0700 (PDT)
X-Received: by 2002:a25:250b:0:b0:68f:425b:3ee0 with SMTP id
 l11-20020a25250b000000b0068f425b3ee0mr6898469ybl.89.1660902025045; Fri, 19
 Aug 2022 02:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Aug 2022 11:40:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUd5Ww-mtpymykuahHWD+S62Z8qiBMVx8y4okouuzTCAg@mail.gmail.com>
Message-ID: <CAMuHMdUd5Ww-mtpymykuahHWD+S62Z8qiBMVx8y4okouuzTCAg@mail.gmail.com>
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
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
Cc: Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jonas Bonn <jonas@southpole.se>, linux-s390 <linux-s390@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Ingo Molnar <mingo@redhat.com>,
 Vineet Gupta <vgupta@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Chris Zankel <chris@zankel.net>,
 linux-um <linux-um@lists.infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Openrisc <openrisc@lists.librecores.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, loongarch@lists.linux.dev,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Brian Cain <bcain@quicinc.com>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>, Borislav Petkov <bp@alien8.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Kefeng,

On Fri, Aug 19, 2022 at 3:39 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Only x86 has own release_thread(), introduce a new weak
> release_thread() function to clean empty definitions in
> other ARCHs.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>  arch/m68k/include/asm/processor.h       | 5 -----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -183,6 +183,10 @@ void put_task_struct_rcu_user(struct task_struct *task)
>                 call_rcu(&task->rcu, delayed_put_task_struct);
>  }
>
> +void __weak release_thread(struct task_struct *dead_task)
> +{
> +}

As the default implementation is empty, it might be better to keep
this as a static inline function, protected by #ifndef release_thread,
and let x86 #define release_thread.

> +
>  void release_task(struct task_struct *p)
>  {
>         struct task_struct *leader;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
