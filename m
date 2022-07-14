Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFC3C433EF
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 07:57:05 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C98F120C94;
	Thu, 14 Jul 2022 09:57:04 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by mail.librecores.org (Postfix) with ESMTPS id AAA88242D4
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 09:57:03 +0200 (CEST)
Received: from mail-yw1-f172.google.com ([209.85.128.172]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhDEo-1ngQqy4AAU-00eNfe for <openrisc@lists.librecores.org>; Thu, 14 Jul
 2022 09:57:03 +0200
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-31c89653790so8802427b3.13
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 00:57:02 -0700 (PDT)
X-Gm-Message-State: AJIora8UtBaFFY7WRDW2Q5dpyG/OslfyUGaBeR9tH6RFMGbvdZ5nRtl8
 p6NgFIB41pK8ogMj/5Cg3OUWVlSG3Is43pBJeb8=
X-Google-Smtp-Source: AGRyM1s6hq6erZ1yK1nIUP2svi0ANxmBF0XKQOXZ/sRFvr5z9HEm2aKaLzHV16xP3Q8+fv2MN1haOC3UBR+vKS0ayV0=
X-Received: by 2002:a81:9b02:0:b0:31c:9ae4:99ec with SMTP id
 s2-20020a819b02000000b0031c9ae499ecmr8278547ywg.495.1657785421695; Thu, 14
 Jul 2022 00:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220714042736.2133067-1-shorne@gmail.com>
 <20220714042736.2133067-2-shorne@gmail.com>
In-Reply-To: <20220714042736.2133067-2-shorne@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Jul 2022 09:56:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
Message-ID: <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] openrisc: Add pci bus support
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cIfxOiLhn8lNIG/VJJfexKQ1dpbGyA2YN/FG5Eduy8CIo+RC27S
 trUvKsT0Eo7XEg+XwvsmrG3+tq0T1PclYgtXKFIr9ie5FGHYlfEPUF4roQ1NDsDiwjhkySb
 i+cbwpILDYFblFl/k6VBD/aWyVGjqrN3Tkr9ER8EWu/Vsz/07BQAXSA+WNOV5hq57oA72VI
 M4tNDKU7NsCVi2deXVriA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6NLHlPMyd0E=:HVRAHtWJeARkINDJF44Mqj
 lDoR0MyyjP8dwlsLrvabx77PdWfWA+zOdw8ieVn2FHa9opH3XXsQLYpEvHQGcvhJAZPd8ksXU
 /LWc5a8KAhK4j76fK3tSY5Z5sOxXQ05GQLv4noVErFeLj7ZEPrsY3x/kWzkjyXByIO4aZrLdB
 FIl2XrjDGLrAtT93QGyBdkJ4M3oZXxm88AM4zXJa07RvkXU/24OHbr0JGUKgfS0LFIiJr64JO
 AzsbagsxE4SObOKiFw24T4ha3JfufWBldoweNWHhR57kslaXcBTRpbKgBpQrD6tQiPbrRmtDm
 d1TpiUAnmddMzNXt4+PuEVsZQZJ3fYzet9V7xSFrbUKo0jxR/M9ylVKfg5lVBVqRD8IaPjt9H
 GVKVufOg20mOv0A1XswU8LnmZI6ZCYSJ+K92WeRk4U6NVohhaQCS1rzS7yAOM6lcosrU1C7c1
 b3KjFeJC2jGH1SiYq6/A6uL2KahLUppI/8cnZUZt0rlF2nZRgF6IxzixQezwKM7yV0XXnox1b
 zYdFnocyCd0Kp5UaOlwRZoWXtzHvG4VPEt36TY1GwyIyktsMIj7TQJs/Vp4SQcWDa22GwL9C0
 F0qzcXrIBi4sz7l1aX43VRzRQgxVut7bTk3jhIGmc/PcKUT17Eaax6h1ylGrYlEmoofuWVv2f
 HOlUc5c6yx7D/hsdXPg73e49rqUk2draaORlbuYxJnK25Owz1ZX+0r7xVnvNPC9OZ8UcYKsHQ
 yOTF8hjFOGDV135IwUl2xZNTaHtN5amI+Z6dX9jSdZttUFI5q1dhwrELk+Ihtp5iDDlCuYenJ
 mxqXFAYH9doMTIF5B/xNq/1IpTT8jSD0fLyeUD9qfZTRAP1QnEcET5KAGNzDd+RW7bFuqoTRs
 K3oCfdTHDTkkNHeE2D10X7QFO9aLIHxoXgtn50kDA=
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

On Thu, Jul 14, 2022 at 6:27 AM Stafford Horne <shorne@gmail.com> wrote:
>
> This patch adds required definitions to allow for PCI buses on OpenRISC.
> This is being in the QEMU virt platform.
>
> OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> MMIO for all IO.

Ok, this looks better.

> Also, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> systems") all platforms that support PCI also need to support parallel
> port.  We add a generic header to support parallel port drivers.

The parport_pc driver is actually one of the things that doesn't work without
I/O ports, so at least the description here is misleading. We should really
have Kconfig logic to enforce this, but that is a separate topic.

> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index e814df4c483c..327241988819 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -21,7 +21,9 @@ config OPENRISC
>         select GENERIC_IRQ_PROBE
>         select GENERIC_IRQ_SHOW
>         select GENERIC_IOMAP
> +       select GENERIC_PCI_IOMAP
>         select GENERIC_CPU_DEVICES

> @@ -46,9 +50,6 @@ config MMU
>  config GENERIC_HWEIGHT
>         def_bool y
>
> -config NO_IOPORT_MAP
> -       def_bool y
> -

GENERIC_IOMAP makes no sense without PIO, and I think you also
need to keep the NO_IOPORT_MAP. I think you still want
GENERIC_PCI_IOMAP, which in the absence of the other two
should turn just return an __iomem pointer for memory resource
and NULL for i/o resources.

> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +       /* no legacy IRQs on or1k */
> +       return -ENODEV;
> +}

The comment seems misleading, as "legacy IRQs" normally refers to
non-MSI interrupts, which you do support. It's only the legacy IDE
interrupts that are not supported.

I see that the asm-generic/pci.h file is now completely useless,
as it only has a single function left in it, and this one is wrong
on most architectures -- it only works when you have PC-style
interrupt numbers. Out of the five architectures that include
asm-generic/pci.h  (m68k, s390, sparc, x86, xtensa), I would
expect only x86 to use this version, and maybe a few sparc
machines.

Can I ask you to move out the existing asm-generic/pci.h
code into those architectures, and add a new file in its place
that you can use as-is on openrisc? Ideally we should
be able to also remove most of the contents of asm/pci.h
on arm64 and riscv. If you have conflicting settings, the normal
way to handle them in asm-generic headers is like

#ifndef PCIBIOS_MIN_IO
#define PCIBIOS_MIN_IO 0
#endif

#ifndef pcibios_assign_all_busses
#define pcibios_assign_all_busses() 1
#endif

       Arnd
