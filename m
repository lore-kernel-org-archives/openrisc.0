Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234C5C433EF
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 13:14:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E6089248E8;
	Thu, 14 Jul 2022 15:14:37 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by mail.librecores.org (Postfix) with ESMTPS id EF42B247D6
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 15:14:36 +0200 (CEST)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M4aEC-1oDcZG1T2U-001kLs for <openrisc@lists.librecores.org>; Thu, 14 Jul
 2022 15:14:36 +0200
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-31c8bb90d09so16367657b3.8
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 06:14:36 -0700 (PDT)
X-Gm-Message-State: AJIora+a8Hb8m+fvT6SXhC9JfeoBAL/P8TvFsrhcZZxhqT6OdXdDIMfT
 yOMEIl4bqoMXdOcTR9jU+4waGVqIYwsChIlu+7s=
X-Google-Smtp-Source: AGRyM1uafSJFpQOlxzTuazebv+1foYrOHcDhoNoaVMnzWGhMXx70Y5podLuFPtEHoJzzuxj3TfSuVgA3zmXb+TXcIs4=
X-Received: by 2002:a81:9b02:0:b0:31c:9ae4:99ec with SMTP id
 s2-20020a819b02000000b0031c9ae499ecmr9597696ywg.495.1657804475066; Thu, 14
 Jul 2022 06:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220714042736.2133067-1-shorne@gmail.com>
 <20220714042736.2133067-2-shorne@gmail.com>
 <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
 <YtAO/nxcsjjc8M/c@antec>
In-Reply-To: <YtAO/nxcsjjc8M/c@antec>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Jul 2022 15:14:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2B82z3+qUDnm7hSn0y7Kqs3CoGtUDxUSrjG86UA56tAg@mail.gmail.com>
Message-ID: <CAK8P3a2B82z3+qUDnm7hSn0y7Kqs3CoGtUDxUSrjG86UA56tAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] openrisc: Add pci bus support
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mU5Pk5tivN/9FXk5ymjsE6qJM8fZkmFHxvpMdAnw5mWkvaJkp+V
 VCbmSUDJUuVn25SXFHCnIWN29pjMQ+6DtwThT3AUZ/luVN6J+jUnaZL/aoHpDfwGPxGFHb5
 GkTFES+vlLTatq1uT60ua4lotCN8A6sWSDjywkCGiWY4vRN0NfIEd1dfCUYt27+VSwksidM
 vTaLUiLPXMl+i0vPLVltQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4SjDq6AwDUg=:ZkazgbWtKbcQbwGWDmquJo
 nkb1eLCkYz91y72P3YmASaI79K5RmA1py2HU5/Ucw2kUxkqt2tJqyl6qf0gUcNQER8YiPTsXc
 5w9HSYZNmuE5yXpoJ9w7IC7smWfaQkYHqDRDOda4QOSZlZqCiWyfcyQEL/jLsBJhyX4aXN5n1
 pWHHXorVNXH2matlrXLiuuj5sb9xg2quShLon2tdFBrASfzFcX6YyEgbumeqGImZP1xPMvZu4
 P0nqplsZemtOyoJ1qRAwShHSnKp9QKaDPRlMEpEtuJCT/0vnt3qn1yHh6vLeZzGhYkvZOkALC
 PtMhbNrku0uxwmuuaOyhXos3bZgLQERg2EXdPr1GVgIoqSpQErvZKmY5JjIx5SEAm7xQfnpn8
 Xremv5bfQQ7pC1eCp0OE97Q8Padp10ykNaHteX497GrSQ8VHkKeBhXjtQ8hEgnXCS6K6q6BTq
 EGdJw7FF1X0u0ibiKaV/mBVGCYCM3959PQ1sgmNTbl/iDR1lSxtSgHLAGTqs6OS7rnxTo4Vpv
 D+twqVk4ew4JQNpXokA5HBqiOL6m6fAEF6WaWKCw+QPn8cB+38c0RoKjR7khHTsjsbNzKDmOA
 3mvpyqhpqfDLpk+ccFnRDGWStm3sHjpiHyvbQdSVcDsTtukQB/jGDyRFlq7IOtgZbXbSGJA7B
 lzKr9UcDBYJuhYm8v1/ls2kYJK+raT9REhhoAcpzVcpzv+P4eq4mpOHSWisOmZEHOJ6CtOqDw
 zgHfQ7cpNEnB1ZCmB/3gvWe/wnHBKXscx/ViWSVb32hhZWRimz17GpySJ6Ayc44OAP4XpvuR2
 vohoItbWJphxSM8l7hvkk5l0TBgXjJsfZ5dzMBfnw7q/QJUc6LDZ8Vf7rlve5CuU4Kyn5Lx1F
 NiPx3Ce2Mqy+DlUGm1sw==
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

On Thu, Jul 14, 2022 at 2:41 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Jul 14, 2022 at 09:56:44AM +0200, Arnd Bergmann wrote:
> > > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > > index e814df4c483c..327241988819 100644
> > > --- a/arch/openrisc/Kconfig
> > > +++ b/arch/openrisc/Kconfig
> > > @@ -21,7 +21,9 @@ config OPENRISC
> > >         select GENERIC_IRQ_PROBE
> > >         select GENERIC_IRQ_SHOW
> > >         select GENERIC_IOMAP
> > > +       select GENERIC_PCI_IOMAP
> > >         select GENERIC_CPU_DEVICES
> >
> > > @@ -46,9 +50,6 @@ config MMU
> > >  config GENERIC_HWEIGHT
> > >         def_bool y
> > >
> > > -config NO_IOPORT_MAP
> > > -       def_bool y
> > > -
>
> I tried the below patch on top of this but I get failures, as the __pci_ioport_map
> uses ioport_map.
>
>     lib/pci_iomap.c: In function 'pci_iomap_range':
>       CC      drivers/i2c/i2c-core-base.o
>     ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
>        29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
>           |                                         ^~~~~~~~~~
>     lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
>        44 |                 return __pci_ioport_map(dev, start, len);
>           |                        ^~~~~~~~~~~~~~~~
>

Ah, I see. So setting NO_IOPORT_MAP without GENERIC_PCI_IOMAP
probably just works, but then you'd also build all the driver that use
ioport_map() when they cannot work.

Maybe add another

#define __pci_ioport_map(dev, port, nr) NULL

case to include/asm-generic/pci_iomap.h, or add an #ifdef to lib
pci_iomap_range() to not call it in this case.

> > GENERIC_IOMAP makes no sense without PIO, and I think you also
> > need to keep the NO_IOPORT_MAP. I think you still want
> > GENERIC_PCI_IOMAP, which in the absence of the other two
> > should turn just return an __iomem pointer for memory resource
> > and NULL for i/o resources.
>
> OK.
>
> If we keep NO_IOPORT_MAP, it causes HAS_IOPORT_MAP to be false and it removes
> the definition of ioport_map which still seems to be needed at link time.  Maybe
> thats an issue though.

This is the intention of CONFIG_NO_IOPORT_MAP, it's meant to be set
on architectures that have no way of defining ioport_map() in a sensible
way.

        Arnd
