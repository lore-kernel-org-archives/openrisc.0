Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B55C43334
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 07:05:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C75B820C6A;
	Wed,  6 Jul 2022 09:05:24 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by mail.librecores.org (Postfix) with ESMTPS id 04C4620C6A
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 09:05:22 +0200 (CEST)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6EKU-1oFZjm1lxQ-006dfM for <openrisc@lists.librecores.org>; Wed, 06 Jul
 2022 09:05:22 +0200
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-2ef5380669cso130703637b3.9
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 00:05:15 -0700 (PDT)
X-Gm-Message-State: AJIora/3SpPs0K+PKs5rp+M2P30kxLo6ADzMs0y8IeYS5bxVsJqejOKJ
 nbYVLsC1pZH9i2i7WlCR15Gdx6nshb1JDzhmBUA=
X-Google-Smtp-Source: AGRyM1sFkLoTiaaVIBkcDzO6lGV11chQSm3x6oRhEtv1xOtqIu5uDObFEe7OPQNG4jMZlSfDIkbGiGD4cv9otOB20XA=
X-Received: by 2002:a81:f8f:0:b0:31c:bd9f:31ce with SMTP id
 137-20020a810f8f000000b0031cbd9f31cemr10731679ywp.347.1657091114041; Wed, 06
 Jul 2022 00:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220630051630.1718927-1-anshuman.khandual@arm.com>
 <8a6ccbae-7d7c-6e08-cc28-eeb649f86112@arm.com>
 <85fff3f6-373f-3e6a-325e-0fa8ad46273a@csgroup.eu>
In-Reply-To: <85fff3f6-373f-3e6a-325e-0fa8ad46273a@csgroup.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 6 Jul 2022 09:04:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1gb1Xrg4AGnncFpN=aDxVKfjkt1TmSvZXXADZTv7eE-g@mail.gmail.com>
Message-ID: <CAK8P3a1gb1Xrg4AGnncFpN=aDxVKfjkt1TmSvZXXADZTv7eE-g@mail.gmail.com>
Subject: Re: [PATCH V6 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RdfxC//ZlGJbnS1258rBps9ZvmmjaJx3qQRXvIoKgDzWnZ6iwWN
 9mGVWJ6wygmkoCCjbDAjfr0sGQ42xz4W4c18zEzcpto1nh50xIBbKo4lbdXiY4jpfOgL7Ev
 1bxPzlBHEuX7n1LiJyOVZ0WbuNKHI5GAC0jc3gmkIKrlFBbCisKfgoX6vuCIQXUksPStMtD
 sRjHFlKGoG6CWpHImUzuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W+0uKT8anXQ=:wOvxqtGtVR3acp1Vutmvhy
 ynMC8BA99Y+uQV9/EX2A5LqOuvP+dxvenu8A7kBe3XXZ9Bmrd7G/RNQv/y0v/hptPZthG8Bvo
 9IO9oDYxFtkz3vDxV99jiB6wY5JuP89FspEUDcudvhDLo2xH9fW6QcYB7luC8/IVeXxDZgrm8
 FUBF9LmkhbQ4BD5BowbWybKtBIcVo22SMC3x48EnaH4UJ7MDw33pqvcvAWpkzRZdReRUkQ6Mk
 8JU1Pvmaus318jvIor3Fa12YENbHFovNDIYLn2gOt6kXyxQd9YlQZUwas8CgafFdphWvFxl9u
 J4yTHHuE7LGzWUgkwNpwGqVwZGX7ZTQJnbO+v2WSEbnd9m6pK88UjhGqICBJybx9yu33v7oby
 irzX+S5bakGHA3X6GD7ulRHO+3+IYxENj3n6KKWXVCcXZ9aX9nQf6r0ksTjmViU0Qi4kUAKuV
 Vl2fFNiJ4rsscTmDGsK0Vi1/fLvjCD2vy04HM402G5cE5JeX6cmIclyDDBKOLWvGLR0m9iLNy
 ybhS/V0pbS+457t9P79AAIdBRCNOp2ddl+KzaPT7xS0WeyG7nNrjD3FWJMCYmNXjL74jGVSVx
 PQWiDqJ7IUuqMgsIu7lJW1jFjgjy8R1SGqRvE1darY7AaSY9prqIxwG2jubKPmiwPrxHE4EO+
 gMnHIgelzQF7OgoSq9py/9dp906f1p5+7rrcVjeiv1flm3BTma1VmMxTv41CBzcKUxcf8Oebt
 YQbvfDnqJbEtNYSHSSmjXzywPrrSZnse3YzYEY0bx5FnrpYa1XOqioNLzeXa/uXEkklEVH6Au
 e6l9k9QsxPKX7+Umpd4CpSJTZ7Uv0en42GzQAt4bX0GoYNfQs6Ee4f0zrdblHdE9yXqE9BzUV
 sUP3fnSIsYvAZjz1ky4w==
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
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Jul 6, 2022 at 8:33 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> As far as I can see in Kconfig, CONFIG_MMU is user selectable on the
> following architectures:
> - ARM
> - M68K
> - RISCV
> - SH
>
> And is disabled by default on XTENSA.

Right, the list is complete, though it's also default-enabled for
every CPU core on xtensa, and you can only disable it for
"custom" CPU cores.

        Arnd
