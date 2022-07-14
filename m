Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE285C43334
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 12:41:40 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6C0AB247D4;
	Thu, 14 Jul 2022 14:41:39 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mail.librecores.org (Postfix) with ESMTPS id D787020D5D
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 14:41:37 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id fz10so2779000pjb.2
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3h9c3FGTTpmVX++3flAulp3WHcv9mbKiAG+klxgd4Fg=;
 b=koV+yx9nkANm2Uhwc2mx1p5TDVvFO0Pq9026BPOplyIfNkRQxR172QmsM1iZZsRR0l
 hTZhVAPjokJ1WmwxCpkdz76SFFZ3He+2CS/3yu1+4Xyue49Ut0nmEAIIABtBjBscI2F/
 FKVi/u/gYbZdU8Sjtrc14gSnroHF3rwWZ3nAffq6mqA9dts50OcbA3G9RGCUKyhKGg26
 MIRADkVdUR9D6S+BcW95uBk9BFrtNobrOQbqU2cyC6Aq2UFQRrUfNaXMwOKRkAvbGoe5
 6ORcFKNWFQ7U6VUZ9m5tbj1Wh2kPtZMhEC8niQc1stGNKl83l04Qi80Df9lC1uTd+1dQ
 UQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3h9c3FGTTpmVX++3flAulp3WHcv9mbKiAG+klxgd4Fg=;
 b=QtOA0/wwlhdMr7EjXH2C3vB/QzqJOgPgxcKTCXMsextIAcZzFp/h96HpFroqBNqr+4
 fAtISkRG5JERlZZ6dcvosPv1Gd+GM8L9gdYYpMCrkXCTj9tb1uZ/2FL3LEU2tdTwlDXG
 jDN9yqsjVTeFr13KbFZf13hSOQr9Jh50PDMUbHrmrPEfNpMx43kYr4CROrGsvh4VvbBC
 3YkEaoyyjjPd142EXeCTIBiCX5NR6Qv2C902QfDbaP677wpal28Czx+RHJ+JR876pECA
 R5ETGPHYkPfGlJ+ecj0DBYkpxydDkF8sh2guKYvXlwZGgKRJuZ2zv0JiH8D+IXgEiXl2
 LFWg==
X-Gm-Message-State: AJIora+87SOsz29hG2OeRJeJg8cJN/gIdjCgYALIV/zWq55VhKKpKFwg
 C2mvCFOElgmDKkGvD0j4uAw=
X-Google-Smtp-Source: AGRyM1uZUUoWrMws0sOG5cPzaHob5mxbfrBC/vfZxXW6L7AasRxArG6rpLgplExROVPACGPcJXcKlg==
X-Received: by 2002:a17:90b:3811:b0:1ef:e647:ff34 with SMTP id
 mq17-20020a17090b381100b001efe647ff34mr9875511pjb.171.1657802496327; 
 Thu, 14 Jul 2022 05:41:36 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a170902e84700b0016c1cdd2de3sm1375408plg.281.2022.07.14.05.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 05:41:36 -0700 (PDT)
Date: Thu, 14 Jul 2022 21:41:34 +0900
From: Stafford Horne <shorne@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] openrisc: Add pci bus support
Message-ID: <YtAO/nxcsjjc8M/c@antec>
References: <20220714042736.2133067-1-shorne@gmail.com>
 <20220714042736.2133067-2-shorne@gmail.com>
 <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jul 14, 2022 at 09:56:44AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 14, 2022 at 6:27 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > This patch adds required definitions to allow for PCI buses on OpenRISC.
> > This is being in the QEMU virt platform.
> >
> > OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> > any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> > MMIO for all IO.
> 
> Ok, this looks better.
> 
> > Also, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> > systems") all platforms that support PCI also need to support parallel
> > port.  We add a generic header to support parallel port drivers.
> 
> The parport_pc driver is actually one of the things that doesn't work without
> I/O ports, so at least the description here is misleading. We should really
> have Kconfig logic to enforce this, but that is a separate topic.

OK, let me try to fix up this comment in v3.

> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index e814df4c483c..327241988819 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -21,7 +21,9 @@ config OPENRISC
> >         select GENERIC_IRQ_PROBE
> >         select GENERIC_IRQ_SHOW
> >         select GENERIC_IOMAP
> > +       select GENERIC_PCI_IOMAP
> >         select GENERIC_CPU_DEVICES
> 
> > @@ -46,9 +50,6 @@ config MMU
> >  config GENERIC_HWEIGHT
> >         def_bool y
> >
> > -config NO_IOPORT_MAP
> > -       def_bool y
> > -

I tried the below patch on top of this but I get failures, as the __pci_ioport_map
uses ioport_map.

    lib/pci_iomap.c: In function 'pci_iomap_range':
      CC      drivers/i2c/i2c-core-base.o
    ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
       29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
	  |                                         ^~~~~~~~~~
    lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
       44 |                 return __pci_ioport_map(dev, start, len);
	  |                        ^~~~~~~~~~~~~~~~


diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 327241988819..c7f282f60f64 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -20,7 +20,6 @@ config OPENRISC
        select GENERIC_IRQ_CHIP
        select GENERIC_IRQ_PROBE
        select GENERIC_IRQ_SHOW
-       select GENERIC_IOMAP
        select GENERIC_PCI_IOMAP
        select GENERIC_CPU_DEVICES
        select HAVE_PCI
@@ -50,6 +49,9 @@ config MMU
 config GENERIC_HWEIGHT
        def_bool y
 
+config NO_IOPORT_MAP
+       def_bool y
+
 # For now, use generic checksum functions
 #These can be reimplemented in assembly later if so inclined
 config GENERIC_CSUM


> GENERIC_IOMAP makes no sense without PIO, and I think you also
> need to keep the NO_IOPORT_MAP. I think you still want
> GENERIC_PCI_IOMAP, which in the absence of the other two
> should turn just return an __iomem pointer for memory resource
> and NULL for i/o resources.

OK.

If we keep NO_IOPORT_MAP, it causes HAS_IOPORT_MAP to be false and it removes
the definition of ioport_map which still seems to be needed at link time.  Maybe
thats an issue though.

> > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > +{
> > +       /* no legacy IRQs on or1k */
> > +       return -ENODEV;
> > +}
> 
> The comment seems misleading, as "legacy IRQs" normally refers to
> non-MSI interrupts, which you do support. It's only the legacy IDE
> interrupts that are not supported.

OK, I might have copied this from another architecture.  I will check if those
comments should be updated too.

> I see that the asm-generic/pci.h file is now completely useless,
> as it only has a single function left in it, and this one is wrong
> on most architectures -- it only works when you have PC-style
> interrupt numbers. Out of the five architectures that include
> asm-generic/pci.h  (m68k, s390, sparc, x86, xtensa), I would
> expect only x86 to use this version, and maybe a few sparc
> machines.
> 
> Can I ask you to move out the existing asm-generic/pci.h
> code into those architectures, and add a new file in its place
> that you can use as-is on openrisc? Ideally we should
> be able to also remove most of the contents of asm/pci.h
> on arm64 and riscv. If you have conflicting settings, the normal
> way to handle them in asm-generic headers is like

Yeah, that sounds like a good plan,

> #ifndef PCIBIOS_MIN_IO
> #define PCIBIOS_MIN_IO 0
> #endif
> 
> #ifndef pcibios_assign_all_busses
> #define pcibios_assign_all_busses() 1
> #endif

OK.

-Stafford
