Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2CFC43219
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:19:36 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 20F8020919;
	Sun,  6 Nov 2022 22:19:35 +0100 (CET)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by mail.librecores.org (Postfix) with ESMTPS id A045824B4D
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 17:13:40 +0200 (CEST)
Received: by mail-vk1-f172.google.com with SMTP id e2so2579597vkd.13
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KKCH5rHwhLvmhcc4ioAH94OT26KUWrAa0eYV8ovw8iI=;
 b=PlAf8nRWcV62vxam17acZLUisAZSkcz3NtgdT8N6ODK2aQ66VaCnXQWamCgfngeEr8
 y8I9yAuzs+mMi9jKZ32iz7XP83EhETabvU0rdvCNxNtSOa6bTmlelysbYCuannQ2EOtq
 aGnfPR1MxVDopOfF1F5jKqO4a3dHhaFPZvWtPTIECZtKTUomDZP6UHi6LmhF7yodt3PL
 wOQ/RA1eKxlbzdaVD86aHd5Mp1nfyouIIZtozsYyYB/6ek3a7tLhDrUWNmJ1zwI3usmp
 +3m8SGGHJnhuYC8YGKaBM5xNTdyqzecV4+mgdlPdHZhCHmpnv2ttQZq3IF5VwXWOmmrh
 KlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KKCH5rHwhLvmhcc4ioAH94OT26KUWrAa0eYV8ovw8iI=;
 b=rFRVfL5yr4aPAa9aumuVVgHX0/XH47d9AZ2Oq8WC6/jb8MbsiTtXwlQlp19fAeqrWa
 R++I0l4Wp7dcgw1mAPkv8MQNJXLn6fqURHdaPmjHujuXJ7IX5OcCF9npMkKOA9gM3bji
 SkF13jaGlKXPCOaiDka6OqcxCPkoyCFUIyMJuzjCh9ksPHCyGzo84PeRl60eKbQUMXhq
 GR32nxHvtCG5ztVG/O2guYBK4hZvJBne3JNPGBpl9arZr0ch3ntcaDNF0l8XcbKFb4T/
 dNhoE4FN6a53xNHrLwCgpqLNosYaii6JVIt0KJ6g7lAYJuOHcFTUxGeOZc/emjuoQeBA
 uu4g==
X-Gm-Message-State: ACrzQf0aBCKn66PPiDOHomlY3DqQi4VwD23H96eaOJ1MBNmBzReWkqk2
 nQHbH3Zs15DIKcnHdHXHjYRbKpdpepMVs5+13Xs=
X-Google-Smtp-Source: AMsMyM5fMD47AwXdAGZJkp9B9Oi7IArr3hCpb/0IcUoq2JbMjotYiQc5ku/yJ7p1imIS/+yBcPCbJ8RdJkA91IwUrXg=
X-Received: by 2002:a1f:4315:0:b0:3b4:5f59:7408 with SMTP id
 q21-20020a1f4315000000b003b45f597408mr19151364vka.16.1666970019339; Fri, 28
 Oct 2022 08:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop> <Y1vvMlwf/4EA/8WW@zn.tnic>
In-Reply-To: <Y1vvMlwf/4EA/8WW@zn.tnic>
From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 28 Oct 2022 10:13:28 -0500
Message-ID: <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
To: Borislav Petkov <bp@alien8.de>
Content-Type: multipart/alternative; boundary="000000000000daa0b705ec19b325"
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
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Jones <ajones@ventanamicro.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

--000000000000daa0b705ec19b325
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 28, 2022, 10:03 AM Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Oct 28, 2022 at 07:46:08AM -0700, Yury Norov wrote:
> > I'll take it in bitmap-for-next this weekend.
>
> Why?


Because it's related to bitmap API usage and has been revealed after some
work in bitmaps.

And because nobody else cares.

If you're willing to move it yourself please go ahead.

>
>

--000000000000daa0b705ec19b325
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Oct 28, 2022, 10:03 AM Borislav Petkov &lt;<a =
href=3D"mailto:bp@alien8.de">bp@alien8.de</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On Fri, Oct 28, 2022 at 07:46:08AM -0700, Yury Norov =
wrote:<br>
&gt; I&#39;ll take it in bitmap-for-next this weekend.<br>
<br>
Why?</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Because it&#39;s related to bitmap API usage and has been revealed after so=
me work in bitmaps.</div><div dir=3D"auto"><br></div><div dir=3D"auto">And =
because nobody else cares.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">If you&#39;re willing to move it yourself please go ahead.</div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
</blockquote></div></div></div>

--000000000000daa0b705ec19b325--
