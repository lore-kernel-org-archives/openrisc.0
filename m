Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84602652AF;
	Tue,  5 Aug 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386208; cv=none; b=peXdo1b1JYEihEmvTNB0CKPQ4enQsED6Dq+rQfpAPA2oSboCgO7LC9LY0Hflvev8xfDB6zp6rR7p3CpPnDaSMjATDKdkgZ4Oi8/hFn+dq9JMbI1784GyUeLA5jDWE9OPicQjPl8U0gTr9r+XK1bi40xLc/L11XykJUQxltQ2B24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386208; c=relaxed/simple;
	bh=/96+wQdXuYGBiFVc2O5oqpZxgQ+f+NwwoqPvRvuLFIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg0al1OIQmqzw0a/32d4qegX9LfBpX6KajdW7paY+8/h16CMs6l5TG/bhfVSB7oetfhjHeZtZCNtypwroD5YMaf8BucN7Ur5rqtaA8ECq5PWX/az3iMlAMnBPrTPbPoPjhn3aQb4hhmUJ2PidXOFrw0TtKYFLyIBpGOzlSFoST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRbJXcK3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRbJXcK3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af949891d3aso410623766b.1;
        Tue, 05 Aug 2025 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754386205; x=1754991005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8ozOId1ZhD4j/yjEjr/14e7MP0S5CB4O3gJh9exrdI=;
        b=MRbJXcK336HS7YSeifHAGkxvS1jDvI64Iwef3xm9/+00F57r8b9yU9NOoTy6mMIMZv
         akv9vzoScHOija/RuXVi4vRi3qW6aklTvq03BL4JG2brflFKnM2JvoFAEJsIvFJ7SZKa
         tPKj9U/9Eu2E5uT4CrtEynhXzRqZ1CfBDBsFs2iFP+5gS4C3VfyqCzDlZF/Yy3EtMA8T
         O3Wmt/KpG4lbN8AlLbOupxaHQRiTzs8CPfY/GhcvhbtKotpEDOlkllT2zt0odPvTrrMS
         IjplwQWnz1iOpheBgkxknvUSDUdnJErrXvoc5EAnOV51lbjGwPcxu7xWOMO0JxWFuxto
         3ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386205; x=1754991005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8ozOId1ZhD4j/yjEjr/14e7MP0S5CB4O3gJh9exrdI=;
        b=B4j4UfH6eyHs08PbiQJrbvFmnukijJV4wxWZcJ4/KsQWfZMs0Z7ELmrllo7VaWM9M9
         kOAg84h1n1gR+t9+jBdE41waDjjqpUfu2NVBrzQYVcDvxyKYkbEGFwIx/LmFsEfe7nMR
         Oe8jqk5se2TLPtLClNHJLmCFZeZTm7o4oFq2HSVRq5onccr8t61mNc1QKyDZPpCk//9P
         yWD3Ha6ldu7EJJ23e8IXCSumTtzCG1PraESwov4ADEZJgNl0K2XITJaQ60cajj0GSe2g
         wslXULwtkk6vXpExEzu9A+k61VipmP2EwinaRAgPSqYGjA/USaJL3FPCU97slChoFrcG
         S9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVrwpAgPFLB0gVmRzjnP689Cka8ADHFXAxCy0zFmrFiNv2QUlOY8SWikAuzdMeAwQSnCc/hHkOHHiRG3G0=@vger.kernel.org, AJvYcCWMb/GmYUTIYZzha+1L1uC0eZXnK9fdXXzekPQL38vIvffLKKtxGnzyA17XAOPkEszDKpuCkA1QHeh8HPfASzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZRWXfuj9we+a5kHw1T4QxZzAbqf07H8Nuk9DtK0XjVTCQzBg
	2hYOxkBfVqURMBi0KzJ4VrqMe6xHXpPKKYGhMq+DneQd7hTODdWoOJWYUsFORXYwusB85ebp1Sb
	Y+QuWLP58969AX7otrabSXCGgP12ZixM=
X-Gm-Gg: ASbGncuK8VX6hPas9uASBlPfVH2fY8nFMzPPnTIkUBXMTAM8+EulQ3lecLgMIo7SPiE
	mcyQl9XE9a0ph9d2sfEw7cZJ/vTIYMW4oi3Vpc7v0TtcVEMzbjfJLx9Jg+pcaW7eisucOSQlMof
	GpjY++/KpFeEt27eg6eWSxVZ7BO7tbZ1OlDOoHOG1iqHcYvpyKkqiFxEfzD+W7KdqK+K6uqBvM5
	vkp4jo=
X-Google-Smtp-Source: AGHT+IH6PTc3BtkOiDilh73+QBsRvV3S5gbrjB3Dg51VaqRBpHDpZQ7l4uV26oIASArzJRSk+1aue0oGggbzKtV88UY=
X-Received: by 2002:a17:907:9812:b0:af6:3194:f024 with SMTP id
 a640c23a62f3a-af940081981mr1204367366b.13.1754386204741; Tue, 05 Aug 2025
 02:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805084114.4125333-1-chenmiao.ku@gmail.com>
 <20250805084114.4125333-2-chenmiao.ku@gmail.com> <aJHLxmPk-5cPCnPA@antec>
In-Reply-To: <aJHLxmPk-5cPCnPA@antec>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Tue, 5 Aug 2025 17:29:26 +0800
X-Gm-Features: Ac12FXyNYIwtCwX-pcCeWHZgSU4-r1UfqaVhARQbfbH0KRC0W9fL1DeGM24KcQ8
Message-ID: <CAKxVwgdKjwPMkCtz+MDuCuf7L+pcRDYsUYd8xPFYTQBrTqC6Jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] openrisc: Add text patching API support
To: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Arnd Bergmann <arnd@arndb.de>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sahil Siddiq <sahilcdq0@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also considered this approach. In the initial design, there was a
size_t len parameter, but since OpenRISC doesn't support it yet, it
was removed to only support single instructions. If there are plans to
support modifying multiple instructions in the future, we can simply
add size_t lento this API and replace OPENRISC_INSN_SIZE with len.
That's why I didn't change it to unsigned long and kept it as const
void*, while using OPENRISC_INSN_SIZE to fix the length of a single
instruction.

Stafford Horne <shorne@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=8C 17:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 05, 2025 at 08:40:57AM +0000, ChenMiao wrote:
> > From: chenmiao <chenmiao.ku@gmail.com>
> >
> > We need a text patching mechanism to ensure that in the subsequent
> > implementation of jump_label, the code can be modified to the correct
> > location. Therefore, FIX_TEXT_POKE0 has been added as a mapping area.
> >
> > And, I create a new file named insn-def.h to define the or1k insn macro
> > size and more define in the future.
> >
> > Among these changes, we implement patch_map and support the
> > patch_insn_write API for single instruction writing.
> >
> > Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> > ---
> >  arch/openrisc/include/asm/Kbuild          |  1 -
> >  arch/openrisc/include/asm/fixmap.h        |  1 +
> >  arch/openrisc/include/asm/insn-def.h      | 12 ++++
> >  arch/openrisc/include/asm/text-patching.h | 13 ++++
> >  arch/openrisc/kernel/Makefile             |  1 +
> >  arch/openrisc/kernel/patching.c           | 79 +++++++++++++++++++++++
> >  arch/openrisc/mm/init.c                   |  2 +-
> >  7 files changed, 107 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/openrisc/include/asm/insn-def.h
> >  create mode 100644 arch/openrisc/include/asm/text-patching.h
> >  create mode 100644 arch/openrisc/kernel/patching.c
> >
> > diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/a=
sm/Kbuild
> > index 2b1a6b00cdac..cef49d60d74c 100644
> > --- a/arch/openrisc/include/asm/Kbuild
> > +++ b/arch/openrisc/include/asm/Kbuild
> > @@ -9,4 +9,3 @@ generic-y +=3D spinlock.h
> >  generic-y +=3D qrwlock_types.h
> >  generic-y +=3D qrwlock.h
> >  generic-y +=3D user.h
> > -generic-y +=3D text-patching.h
> > diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include=
/asm/fixmap.h
> > index aaa6a26a3e92..74000215064d 100644
> > --- a/arch/openrisc/include/asm/fixmap.h
> > +++ b/arch/openrisc/include/asm/fixmap.h
> > @@ -28,6 +28,7 @@
> >
> >  enum fixed_addresses {
> >       FIX_EARLYCON_MEM_BASE,
> > +     FIX_TEXT_POKE0,
> >       __end_of_fixed_addresses
> >  };
> >
> > diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/inclu=
de/asm/insn-def.h
> > new file mode 100644
> > index 000000000000..dc8d16db1579
> > --- /dev/null
> > +++ b/arch/openrisc/include/asm/insn-def.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2025 Chen Miao
> > + */
> > +
> > +#ifndef __ASM_INSN_DEF_H
> > +#define __ASM_INSN_DEF_H
> > +
> > +/* or1k instructions are always 32 bits. */
> > +#define      OPENRISC_INSN_SIZE              4
> > +
> > +#endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/openrisc/include/asm/text-patching.h b/arch/openrisc/=
include/asm/text-patching.h
> > new file mode 100644
> > index 000000000000..4c3d8a6a906a
> > --- /dev/null
> > +++ b/arch/openrisc/include/asm/text-patching.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2025 Chen Miao
> > + */
> > +
> > +#ifndef _ASM_PATCHING_H_
> > +#define _ASM_PATCHING_H_
> > +
> > +#include <linux/types.h>
> > +
> > +int patch_insn_write(void *addr, const void *insn);
> > +
> > +#endif /* _ASM_PATCHING_H_ */
> > diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makef=
ile
> > index 58e6a1b525b7..f0957ce16d6b 100644
> > --- a/arch/openrisc/kernel/Makefile
> > +++ b/arch/openrisc/kernel/Makefile
> > @@ -13,5 +13,6 @@ obj-$(CONFIG_SMP)           +=3D smp.o sync-timer.o
> >  obj-$(CONFIG_STACKTRACE)     +=3D stacktrace.o
> >  obj-$(CONFIG_MODULES)                +=3D module.o
> >  obj-$(CONFIG_OF)             +=3D prom.o
> > +obj-y        +=3D patching.o
> >
> >  clean:
> > diff --git a/arch/openrisc/kernel/patching.c b/arch/openrisc/kernel/pat=
ching.c
> > new file mode 100644
> > index 000000000000..2b979a0bc584
> > --- /dev/null
> > +++ b/arch/openrisc/kernel/patching.c
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (C) 2020 SiFive
> > + * Copyright (C) 2025 Chen Miao
> > + */
> > +
> > +#include <linux/mm.h>
> > +#include <linux/kernel.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include <asm/insn-def.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/page.h>
> > +#include <asm/fixmap.h>
> > +#include <asm/text-patching.h>
> > +#include <asm/sections.h>
> > +
> > +static DEFINE_RAW_SPINLOCK(patch_lock);
> > +
> > +static inline bool is_exit_text(uintptr_t addr)
> > +{
> > +     /* Now Have NO Mechanism to do */
> > +     return true;
> > +}
> > +
> > +static __always_inline void *patch_map(void *addr, int fixmap)
> > +{
> > +     uintptr_t uaddr =3D (uintptr_t) addr;
> > +     phys_addr_t phys;
> > +
> > +     if (core_kernel_text(uaddr) || is_exit_text(uaddr)) {
> > +             phys =3D __pa_symbol(addr);
> > +     } else {
> > +             struct page *page =3D vmalloc_to_page(addr);
> > +             BUG_ON(!page);
> > +             phys =3D page_to_phys(page) + offset_in_page(addr);
> > +     }
> > +
> > +     return (void *)set_fixmap_offset(fixmap, phys);
> > +}
> > +
> > +static void patch_unmap(int fixmap)
> > +{
> > +     clear_fixmap(fixmap);
> > +}
> > +
> > +static int __patch_insn_write(void *addr, const void *insn)
> > +{
> > +     void *waddr =3D addr;
> > +     unsigned long flags =3D 0;
> > +     int ret;
> > +
> > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > +
> > +     waddr =3D patch_map(addr, FIX_TEXT_POKE0);
> > +
> > +     ret =3D copy_to_kernel_nofault(waddr, insn, OPENRISC_INSN_SIZE);
>
> If you change *insn to unsigned long insn, you can do:
>
>         ret =3D copy_to_kernel_nofault(waddr, &insn, iszeof(insn));
>
> > +     local_icache_range_inv((unsigned long)waddr,
> > +                            (unsigned long)waddr + OPENRISC_INSN_SIZE)=
;
> > +
> > +     patch_unmap(FIX_TEXT_POKE0);
> > +
> > +     raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +int patch_insn_write(void *addr, const void *insn)
>
> Does insn need to be void *?  It think it could be just unsigned long. Se=
e
> comment above.
>
> > +{
> > +     u32 *tp =3D addr;
> > +     int ret;
> > +
> > +     if ((uintptr_t) tp & 0x3)
> > +             return -EINVAL;
> > +
> > +     ret =3D __patch_insn_write(tp, insn);
> > +
> > +     return ret;
> > +}
> > diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> > index e4904ca6f0a0..b5925710f954 100644
> > --- a/arch/openrisc/mm/init.c
> > +++ b/arch/openrisc/mm/init.c
> > @@ -226,7 +226,7 @@ static int __init map_page(unsigned long va, phys_a=
ddr_t pa, pgprot_t prot)
> >       return 0;
> >  }
> >
> > -void __init __set_fixmap(enum fixed_addresses idx,
> > +void __set_fixmap(enum fixed_addresses idx,
> >                        phys_addr_t phys, pgprot_t prot)
> >  {
> >       unsigned long address =3D __fix_to_virt(idx);
> > --
> > 2.45.2
> >
