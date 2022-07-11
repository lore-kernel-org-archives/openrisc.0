Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D35C43334
	for <openrisc@archiver.kernel.org>; Mon, 11 Jul 2022 06:05:22 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CA8BE20D93;
	Mon, 11 Jul 2022 08:05:21 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by mail.librecores.org (Postfix) with ESMTPS id CE92F20D93
 for <openrisc@lists.librecores.org>; Mon, 11 Jul 2022 08:05:19 +0200 (CEST)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mrwnt-1npPh40zNl-00o0iS for <openrisc@lists.librecores.org>; Mon, 11 Jul
 2022 08:05:19 +0200
Received: by mail-yb1-f172.google.com with SMTP id i14so7146793yba.1
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 23:05:19 -0700 (PDT)
X-Gm-Message-State: AJIora/+Jds0F866874wbbNF7ioWGqq+5gkJiUISKMoMcW2VeidpOEYM
 P9kDOIRm45o+9ZGV/migp81dxy5Kq4KbZfeTy/w=
X-Google-Smtp-Source: AGRyM1tPfwQLWVGFNJv200YPAwP2Ym4eh/2LMH3iarHxSqOtUeMPoy+HIGyJVB9MVyfKwjsDS+Cz/sBwWQtviAbR0Bw=
X-Received: by 2002:a25:3b05:0:b0:66e:c216:4da3 with SMTP id
 i5-20020a253b05000000b0066ec2164da3mr16437619yba.550.1657519518013; Sun, 10
 Jul 2022 23:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220709211549.1163327-1-shorne@gmail.com>
 <20220709211549.1163327-2-shorne@gmail.com>
 <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
 <YstDEargBYwjN2Yp@antec>
In-Reply-To: <YstDEargBYwjN2Yp@antec>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Jul 2022 08:05:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0o1rd4BiYwGq_JnWthBG11rxCevKE3+x3fE-S2EnbTxg@mail.gmail.com>
Message-ID: <CAK8P3a0o1rd4BiYwGq_JnWthBG11rxCevKE3+x3fE-S2EnbTxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] openrisc: Add pci bus support
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QeKiEddPOJrKH3+oBKKZTetNOMhYL4wmsn+DLdephPMdIKq5UlM
 75ITtEIDvz988M5tZx5hchZyynoM/j+X2d/wTF7bpmN/XrzD983kDoEyaqE+wmUWDSHK75s
 FUsWi18JGcu7r7A/UASE2xDrmBI3ICCiIYcV2X8KLPuxe+GmiSHVqNg639yQrlEk+9kmGSz
 8qUv5tP31nru3lcgA2yEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0UmNlOE9TDY=:roPX+P4vAF1Uopedv2uNR5
 y+vXvrBl0bqsEKIoztZiWokD1njt03coaa37IfZS7C/lqVqYLWBTiS2b40b9aHElhomAtDXSj
 mWnipDQjCduUyOjmy7VtXao0Y2kR65vhvcEbyiS9YWldj+sGGnDwFstZFeyyq9L41xrkonyeN
 jQQLVqrXan9GQTC++Pp0qXeo3rV8eHUFsbIDiXA4TuDE8kM+EIUcvY4n+syVXQIkFy6g+LURH
 hsddDK+LyZELWB8JrweLCFwB5i2gryFqAQ5BQ9BZhq3jQ3MNuZpQALNnvao/CW6YSopgbMf4z
 Ucy5djUivNpzWoV29bK8Juj7ogYRvuMN5Idf2Kn7wXH8/Tn25qmzvsXoegWZAlQ3ESWwCOWms
 edFtL+O/TItVRHy3/qOd1+5JOUfgt+1ylMIpiYcUK+YfZ8skHCVOgwep0FmKLOixJRGBXvvH/
 5o7CoBRaMMKw4aomat1AwpDfDslKqMfzAD43nRnJhz1SM/dwLtyw1Jh5TEXdU0l8nvuzIVKQT
 7NZ0h7xq7HkFgskpS8UicLfHsVlGU6yJKpnGp1tVH+2FipOzbI/42p8McI52CCYopz90HOLBh
 meTGIK6PQ/bmsyGIgYjSXYJbKtp6X5cF0R1KdyyP+ffhQbjJA0YU9NOzWljJyJ/qAwgvAlKAP
 S66bfkntOiLSyUOKrRh8DQBxd+KFN2Fz9F41oVypN6w0EWe/Gwh6BiN22DfsN1w282kgE4mdt
 dUYuEy6pO6DquqlIdiqw17LzIJcBmwfLi69pqA==
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Sun, Jul 10, 2022 at 11:22 PM Stafford Horne <shorne@gmail.com> wrote:
> On Sun, Jul 10, 2022 at 05:54:22PM +0200, Arnd Bergmann wrote:
>
> OK, I see, but I think IO_SPACE_LIMIT needs to be defined as something other
> than 0.  It is used to define kernel/resource.c's ioport_resource.

I think the kernel/resource.c one is fine, it just means that any attempt to
register an I/O port resource below the 0-length root resource will fail, which
is what you need when inb/outb cannot be used.

> For example on risc-v they set it to 16MB.
>
> I will setup a LIMIT smaller than 4GB and add a PCI_IOBASE.

Do you support multiple PCI domains? Usually you want at most 64KB
per domain, as that is the traditional limit and what the normal
pci_remap_iospace() will assign to a domain. The 16MB limit for riscv
is way more than what one may need on a 32-bit machine, since that
is enough for 4096 domains even with the largest possible I/O space,
and each domain has up to 65536 PCI functions attached to it.

> > Most PCI controller are however able to map I/O ports into the
> > physical address space of the CPU, and in that case you can just
> > define an otherwise unused address as PCI_IOBASE and map the
> > ports there from the PCI host bridge driver.
>
> OK, understood, do you think this needs to be documented in a architecture
> manual?  Maybe it's fine for it to be linux specific.

Of course it's Linux specific, but it's also architecture specific since
there are different ways of making I/O space available: Generally you
can leave it out completely, unless you have to support devices from
two decades ago, some architectures that existed back then have custom
instructions, some hardcode part of the virtual address space to access
MMIO registers at a fixed location, some rely on an indirect method
going through a particular MMIO register to access all I/O space, and
some use a per hostbridge window that gets mapped using
pci_remap_iospace().

Do you have a driver for your host bridge available somewhere?
It should be clear from that driver which method you need.

       Arnd
