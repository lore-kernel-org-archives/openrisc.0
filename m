Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284129CEB;
	Sun, 10 Aug 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837595; cv=none; b=EwFjtkIuN3AP2nHtX/O28JGGH9QkUnQ6W1hdxH5SmB+YMgysvZt/43CD5FY74k5P33dIV7Okw+imUxnT9BB3X/yt7JVu+b4NTABbm3IQa9AHfEp+S+xXIYkW6O0HOTsVl6ZAmNy12tkz6MXXxZoM2/TSvRN2t2j9neSbdOkfqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837595; c=relaxed/simple;
	bh=B1zGGBnNY/F4uZlUa+5+0P/rBTzD/wJgI92+nosWius=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIW6UkWIP73wnefX03yiBPGssYylR9/muMwoFqCNU0OMJwu07EqwhqcI8mftsSL9gAMsbsImqIT3DMSLMeQw+yULZDVHBkuEWVGQQ81oSsC8hVsRvSjGma4712i9i00Bzxiux50Jw2wuwVm2+K4/HrB3rIKqpfrfbDeL7M/9IFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPdepSgO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPdepSgO"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so7331745a12.0;
        Sun, 10 Aug 2025 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754837592; x=1755442392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efk2QEVgvsw+t70nztyA0P7ZeXAOLlkXcme9WUHcL7o=;
        b=SPdepSgOhpY3speoTY1ck2II2h1N85Eno22gDMj+rGSAhaRbkrHrvc70Cuc59x6jg8
         2r38NpGckbfyv93aIXqiZEUCqot+mKn64HKMLaAMVjA+B5mkkk9GOrhWYQCGzALMp43Z
         PmW3FFzb2nk6h6c+dnSLIqllsZd/47apl3c1ZI5mZdHdyEhux850OVq0q14zQEgK9Hqp
         iB1Q6B0RKWSJqapazRue2DU3iNGnZWebQad25EtrDyt34Pu4Mp42+S+OICMxxPIPigjf
         y/pCOtdVEkiSRJUpU3V5z+3bYc1O7e4YRxWPnYkfbuxM2RI7h30E45L+fgbGvxrTHiAk
         ZHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754837592; x=1755442392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efk2QEVgvsw+t70nztyA0P7ZeXAOLlkXcme9WUHcL7o=;
        b=lebMXM2OL+4mzOUBIQNbP9Hnz2VJisXU/kbyA2F4623PyxVoMe2Z1Nf69L1seH48JF
         JA4uHYNQeAcqXcA4Oidn6gFW8H+kgCrBCzWYZrxx54mYYdJXEzDBniB3bVF81abm4V82
         dcqfquurHiCrRAS/B1w43uiMdpIRblSVZPGs26jCpovlXs16pmL0IeF3ot000/5yKw30
         jsyZSZmJk9yxGAABYNSjjsPtTanm81gSc9RM3+SO+rO6HpNz2iB1F6Qzdd8bNyvJX4hK
         g9WXFbdMBWVb67cmA3U4E+unFnZkUkqhyqcq4qlXUcPKoxPtm+EtrkHeQ4N+BMtWGUbI
         fBlw==
X-Forwarded-Encrypted: i=1; AJvYcCXNR+3TQeqdl5pZvpfF3SDIQQf5XVvOKyG+fwIRwSz+oV4cOEmhNfuSUZDEdmk+lN27ngIeN+SJgHljXgj59w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2/CHWnpNdr1zPpGAzIw2hXsDHCGoNphaoeHGVu4pldaHIQBC
	0FTHKuKbkJ+R0vGFGkIpBl4KiB8ddWGjX1Hl298dmPjG/4vQHTDiCFvgW32na6o3GaP2AGPljIZ
	tXBc9hL7X0i0MJBo879fxKjBD7sThcb8=
X-Gm-Gg: ASbGncsKEXYsDmG65wk+vUAHceyzAz/fPh0crgfkazy9bwpDDnubIFoMJObdbAXBANL
	WqVgGl3Cl1tVQupnAsu1ucfEqn1wJUC4SQgyNG1AGOP1pyPOxR6kLDl0Bsvci08BGI1YJPxdfCV
	0QuylB/cRSl5JBIrlZpo9r6imqX3zdnxO3abJSmPAucCnyqaEvymFPNJ1+TFBXW1cPQy8rkx8dK
	bsmCDI=
X-Google-Smtp-Source: AGHT+IGbwef14IPRFTfVAgE90oVqGM0woiGjsdRhT0hyyK7DgfUhyRSJ5Zx+VVyK/vi/rw06TKN32XsxlWQYrT2q+tM=
X-Received: by 2002:a17:907:3e21:b0:ae6:c334:af3a with SMTP id
 a640c23a62f3a-af9a3c592b6mr1445768866b.6.1754837591894; Sun, 10 Aug 2025
 07:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806020520.570988-1-chenmiao.ku@gmail.com>
 <20250806020520.570988-2-chenmiao.ku@gmail.com> <aJcF8RnqYVNEMlp8@antec>
In-Reply-To: <aJcF8RnqYVNEMlp8@antec>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Sun, 10 Aug 2025 22:52:35 +0800
X-Gm-Features: Ac12FXxTbWGBWR1x4yX3S4eHDiYSdp2ZKjUrPEPhtvpIp6IM43cW-1v5wZVobtE
Message-ID: <CAKxVwgcUMVrdTsX96gBfFc1o9zGoisS=4T2OVUs8As88AeWv9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] openrisc: Add text patching API support
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sahil Siddiq <sahilcdq0@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Masahiro Yamada <masahiroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stafford Horne <shorne@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=85=AD 16:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 06, 2025 at 02:05:03AM +0000, ChenMiao wrote:
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
> > - V2: We modify the patch_insn_write(void *addr, const void *insn) API =
to
> > patch_insn_write(void *addr, u32 insn), derectly support a single u32
> > instruction write to map memory.
> >
> > Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t
> >
> > Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> > ---
>
> The v2, notes should go in this part of the patch (after ---), this way
> it does not show up when I queue the patches.

well, I'll be care of the next version

>
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
>
> Is this used outside of the usage below?  Why do we need a header for it?

I think we need the header, although it seems redundant. Although we
only added one line here, I think as development progresses, we might
need more macro definitions related to the instruction set, possibly
including jump_label, ftrace, and potentially bpf.

>
> > +#endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/openrisc/include/asm/text-patching.h b/arch/openrisc/=
include/asm/text-patching.h
> > new file mode 100644
> > index 000000000000..bffe828288c3
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
> > +int patch_insn_write(void *addr, u32 insn);
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
> > index 000000000000..c9a30f0d1193
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
>
> Is this needed?  OpenRISC doesn't seem to have any sections to support __=
exit
> annotated cleanup functions.
>
>   Ref: https://kernelnewbies.org/FAQ/InitExitMacros
>
> Returning true here means that all of the patch_map calls will be treated=
 as
> kernel pages below though, which is wrong, please remove this.
>

I'll remove it.

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
> > +static int __patch_insn_write(void *addr, u32 insn)
> > +{
> > +     void *waddr =3D addr;
> > +     unsigned long flags =3D 0;
> > +     int ret;
> > +
> > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > +
> > +     waddr =3D patch_map(addr, FIX_TEXT_POKE0);
> > +
> > +     ret =3D copy_to_kernel_nofault(waddr, &insn, OPENRISC_INSN_SIZE);
> > +     local_icache_range_inv((unsigned long)waddr,
> > +                            (unsigned long)waddr + OPENRISC_INSN_SIZE)=
;
>
> Instead of OPENRISC_INSN_SIZE, can you use sizeof(insn)?

I think not using sizeof(insn)here would be better. In fact, using the
OPENRISC_INSN_SIZE macro might be more appropriate.

Here we are modifying a single instruction, so it must be 4 bytes=E2=80=94t=
he
length of one OPENRISC INSN.

>
> > +     patch_unmap(FIX_TEXT_POKE0);
> > +
> > +     raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +int patch_insn_write(void *addr, u32 insn)
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
>
> Can you put a comment about this bit in the commit description?

I'll do the next version

>
> >                        phys_addr_t phys, pgprot_t prot)
> >  {
> >       unsigned long address =3D __fix_to_virt(idx);
> > --
> > 2.45.2
>
> -Stafford
>
