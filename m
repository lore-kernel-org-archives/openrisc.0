Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB96208A7;
	Sun, 10 Aug 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838601; cv=none; b=jRnoyk+BOwJKeVuSMZOF0l0I/hW74zd0YkE/8k1YSshpp0cbBKzh3ZJ8ik8W4x9CzgoW83QmcyCmDnkOh74mOwua7Ze9x7RpW8/Cw5hh1svHkgtk3saHhbF0kpl/j9vr4hDF/ormb0UILtWhg8if0OOJF6PK9XDKeV2V/OahyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838601; c=relaxed/simple;
	bh=hKaq6ed9j/hKPPP18vIAhjF9vhBxS4dyCJaEaaOU4oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmoMAOiW3Q5X9+K9mqBI/F8C8txoyJQT34nNYQHBdwHjNHU6rMpgQ2tL0ohrBcQmuz8cKZQI1VkT32j/HKRypTxKY1/ggxp4dZOZqd56svVlXp7yj5xnqYzI5zp+aAiuvkcpA0iHEvfZBLtm7zAEEYh2yqDD/KRNPyYSCrBziss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgZtbMWo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgZtbMWo"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so5991450a12.1;
        Sun, 10 Aug 2025 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754838598; x=1755443398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JXImIm9BMq/4A9/FbIsuY6trEXraLPXXjV5pdSCV4c=;
        b=LgZtbMWocHHOKyeYXMJtxsbShwL/oyZiiv4CR/ydhQPLgj3Sr0ngvwO566w8J5HVtA
         sT6UlmIyh70TP5GPJmTEv1a4hYDiVtPrWhhydrjRGWKUYWIDN0axAWUzpAUkchOGI6oZ
         omdrHkPEsHEy3DqtDpHFoCKgE0m3bm1mVuB09AXyqxlUpsUwUAXXzjQDMoaXtrGldcfI
         bkRchVJogls0JeEsJizw1k3vuz+1aNEj+2kE83Vv5pKTHpz9DLVESoDDqshjXKDlpD2v
         vuzg4gENzgwxx6fDdw2JBGFFU9Ve/dR8x1sI9sJ5WRpLaeqlAqnK2LlxQLbO7u5H6vfr
         vBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754838598; x=1755443398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JXImIm9BMq/4A9/FbIsuY6trEXraLPXXjV5pdSCV4c=;
        b=oeL+QzY0fsapvO2JB0rpOVhWQ9gvUh90SBdAqOztDbKx21Zll7QLF8boCBMX/SflX0
         SQVL95YkidU6/o10xrhJpqHyNP5yPYmSJp68BuDrZZJ8xnJLrPEdobfUzOSM5CGObRbB
         YhUrui+Ij7yuIqcvK0cegujsk2oitpOn3mXVqSj+NZQtU5m7Fr+J59cdsHOvh6iSnmFc
         xQow3Nz8SPHD0FOIx2jv8+hMJO1afzeSRPKk5GhUNXLCOmb5yhhz33MWWSYoLbfd+mI9
         w9+tYjrR2MqAqrRZxlxY2ARoF7YN3zNisahFK3D9ZE9N6DAN2CFOz9FZO+WI3wgoBf+x
         vivA==
X-Forwarded-Encrypted: i=1; AJvYcCWWk5EGNIt4oimPABCeuvonxZaTxzKgZ5MMsJL3J3DcV9rmJ2Qe8WRZqr2O9azkK5dlmcJTNnGND5Ii87lugmI=@vger.kernel.org, AJvYcCX2iFmNl389Qbgn4PQWf7HYJjZNOar9kG1Ox3fh13a3jI9gqsQGkORt+xQkJskOSIvXawiWbGgARwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVufpbARxAs6o62eqNKg099zuf8DENjWDdLT2FkE21lPBiXRY
	R/1LM7jAWJCpdkskx5gGMHZRAKk9Q6g1L+TyH4YmsyTMxoTLeZh4XNCZiQkNHvoOLoNpUL3A7ge
	659YJR61whqmtKoObN40n19LA9/2FNabfOAYtiethEuke
X-Gm-Gg: ASbGnctWPG8zH7sU3C+sD3q+vvr6n+5a/x1eU/Y4Qj/ppokBGr0cwB5zO8h58RYy4JK
	VsyWs/038Ra2jHHFb0+UfaLYcBeBr0lwh8ivYfFsccGtUydqTunL5fIQACr62zv5p4HeBO5CUSk
	EMZCsqveDlFtzaGy2HN6yzfowkzRieTSjkW6xb+/hXjMIBJLTx6ZZW/by7n9l+OzL9mF0b0vD8f
	l2k+WY=
X-Google-Smtp-Source: AGHT+IGuul49uKlpG0DToOZEE0R70DBd9mCsk1FYfqWxwpbSexDElDPra3ILEBRPbASsFZxN63QS3wDuDYLHYOOx00M=
X-Received: by 2002:a17:906:9f8b:b0:ae6:f087:953 with SMTP id
 a640c23a62f3a-af9c63b0a87mr859020066b.12.1754838597456; Sun, 10 Aug 2025
 08:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806020520.570988-1-chenmiao.ku@gmail.com>
 <20250806020520.570988-3-chenmiao.ku@gmail.com> <aJcI1pr9RMTvfcTj@antec>
In-Reply-To: <aJcI1pr9RMTvfcTj@antec>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Sun, 10 Aug 2025 23:09:19 +0800
X-Gm-Features: Ac12FXy-DTOcZwdWgIQCaWNKbJzNdJKL2YLhbFzSUnq4ackhdKY0LDAclLiNbcU
Message-ID: <CAKxVwgcW9+3XBRp1LJ5KAVCTROLtHaf6ABK+wbt8S1SEm_Djqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] openrisc: Add jump label support
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Sahil Siddiq <sahilcdq0@gmail.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stafford Horne <shorne@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=85=AD 16:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 06, 2025 at 02:05:04AM +0000, ChenMiao wrote:
> > From: chenmiao <chenmiao.ku@gmail.com>
> >
> > Implemented the full functionality of jump_label, of course,
> > with text patching supported by just one API.
> >
> > By the way, add new macro OPENRISC_INSN_NOP in insn-def.h to use.
> >
> > - V2: using the patch_insn_write(void *addr, u32 insn) not the
> > const void *insn.
> >
> > Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t
> >
> > Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> > ---
> >  .../core/jump-labels/arch-support.txt         |  2 +-
> >  arch/openrisc/Kconfig                         |  2 +
> >  arch/openrisc/configs/or1ksim_defconfig       | 19 ++----
> >  arch/openrisc/configs/virt_defconfig          |  1 +
> >  arch/openrisc/include/asm/insn-def.h          |  3 +
> >  arch/openrisc/include/asm/jump_label.h        | 68 +++++++++++++++++++
> >  arch/openrisc/kernel/Makefile                 |  1 +
> >  arch/openrisc/kernel/jump_label.c             | 53 +++++++++++++++
> >  arch/openrisc/kernel/setup.c                  |  2 +
> >  9 files changed, 138 insertions(+), 13 deletions(-)
> >  create mode 100644 arch/openrisc/include/asm/jump_label.h
> >  create mode 100644 arch/openrisc/kernel/jump_label.c
> >
> > diff --git a/Documentation/features/core/jump-labels/arch-support.txt b=
/Documentation/features/core/jump-labels/arch-support.txt
> > index ccada815569f..683de7c15058 100644
> > --- a/Documentation/features/core/jump-labels/arch-support.txt
> > +++ b/Documentation/features/core/jump-labels/arch-support.txt
> > @@ -17,7 +17,7 @@
> >      |  microblaze: | TODO |
> >      |        mips: |  ok  |
> >      |       nios2: | TODO |
> > -    |    openrisc: | TODO |
> > +    |    openrisc: |  ok  |
> >      |      parisc: |  ok  |
> >      |     powerpc: |  ok  |
> >      |       riscv: |  ok  |
> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index b38fee299bc4..9156635dd264 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -24,6 +24,8 @@ config OPENRISC
> >       select GENERIC_PCI_IOMAP
> >       select GENERIC_IOREMAP
> >       select GENERIC_CPU_DEVICES
> > +     select HAVE_ARCH_JUMP_LABEL
> > +     select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >       select HAVE_PCI
> >       select HAVE_UID16
> >       select HAVE_PAGE_SIZE_8KB
> > diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/co=
nfigs/or1ksim_defconfig
> > index 59fe33cefba2..769705ac24d5 100644
> > --- a/arch/openrisc/configs/or1ksim_defconfig
> > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > @@ -3,26 +3,23 @@ CONFIG_LOG_BUF_SHIFT=3D14
> >  CONFIG_BLK_DEV_INITRD=3Dy
> >  # CONFIG_RD_GZIP is not set
> >  CONFIG_EXPERT=3Dy
> > -# CONFIG_KALLSYMS is not set
> >  # CONFIG_EPOLL is not set
> >  # CONFIG_TIMERFD is not set
> >  # CONFIG_EVENTFD is not set
> >  # CONFIG_AIO is not set
> > -# CONFIG_VM_EVENT_COUNTERS is not set
> > -# CONFIG_COMPAT_BRK is not set
> > -CONFIG_SLUB=3Dy
> > -CONFIG_SLUB_TINY=3Dy
> > -CONFIG_MODULES=3Dy
> > -# CONFIG_BLOCK is not set
> > +# CONFIG_KALLSYMS is not set
> >  CONFIG_BUILTIN_DTB_NAME=3D"or1ksim"
> >  CONFIG_HZ_100=3Dy
> > +CONFIG_JUMP_LABEL=3Dy
> > +CONFIG_MODULES=3Dy
> > +# CONFIG_BLOCK is not set
> > +CONFIG_SLUB_TINY=3Dy
> > +# CONFIG_COMPAT_BRK is not set
> > +# CONFIG_VM_EVENT_COUNTERS is not set
> >  CONFIG_NET=3Dy
> >  CONFIG_PACKET=3Dy
> >  CONFIG_UNIX=3Dy
> >  CONFIG_INET=3Dy
> > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > -# CONFIG_INET_XFRM_MODE_BEET is not set
> >  # CONFIG_INET_DIAG is not set
> >  CONFIG_TCP_CONG_ADVANCED=3Dy
> >  # CONFIG_TCP_CONG_BIC is not set
> > @@ -35,7 +32,6 @@ CONFIG_DEVTMPFS=3Dy
> >  CONFIG_DEVTMPFS_MOUNT=3Dy
> >  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> >  # CONFIG_FW_LOADER is not set
> > -CONFIG_PROC_DEVICETREE=3Dy
> >  CONFIG_NETDEVICES=3Dy
> >  CONFIG_ETHOC=3Dy
> >  CONFIG_MICREL_PHY=3Dy
> > @@ -53,4 +49,3 @@ CONFIG_SERIAL_OF_PLATFORM=3Dy
> >  # CONFIG_DNOTIFY is not set
> >  CONFIG_TMPFS=3Dy
> >  CONFIG_NFS_FS=3Dy
> > -# CONFIG_ENABLE_MUST_CHECK is not set
> > diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/confi=
gs/virt_defconfig
> > index c1b69166c500..4a80c5794877 100644
> > --- a/arch/openrisc/configs/virt_defconfig
> > +++ b/arch/openrisc/configs/virt_defconfig
> > @@ -12,6 +12,7 @@ CONFIG_NR_CPUS=3D8
> >  CONFIG_SMP=3Dy
> >  CONFIG_HZ_100=3Dy
> >  # CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
> > +CONFIG_JUMP_LABEL=3Dy
> >  # CONFIG_COMPAT_BRK is not set
> >  CONFIG_NET=3Dy
> >  CONFIG_PACKET=3Dy
>
> The defconfig updates look quite different.  Did you use savedefconfig fo=
r both
> of them?

Sure, it will do in the next version.

>
> > diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/inclu=
de/asm/insn-def.h
> > index dc8d16db1579..2ccdbb37c27c 100644
> > --- a/arch/openrisc/include/asm/insn-def.h
> > +++ b/arch/openrisc/include/asm/insn-def.h
> > @@ -9,4 +9,7 @@
> >  /* or1k instructions are always 32 bits. */
> >  #define      OPENRISC_INSN_SIZE              4
> >
> > +/* or1k nop instruction code */
> > +#define OPENRISC_INSN_NOP     0x15000000U
>
> I see you use this header again here, note that in
> arch/openrisc/kernel/signal.c.  We write instructions to memory too for t=
he
> sigreturn trampoline.
>
> Also, you use OPENRISC_INSN_SIZE below.  Could you move this header to th=
is
> patch completely?  I don't think its needed in the patching patch.
>

maybe... this patch we no need this header, but I think this header is
meaningful, we can do this in another patch? modify the hard code insn
to macro.

> >  #endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/openrisc/include/asm/jump_label.h b/arch/openrisc/inc=
lude/asm/jump_label.h
> > new file mode 100644
> > index 000000000000..03afca9c3a1f
> > --- /dev/null
> > +++ b/arch/openrisc/include/asm/jump_label.h
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2025 Chen Miao
> > + *
> > + * Based on arch/arm/include/asm/jump_label.h
> > + */
> > +#ifndef __ASM_JUMP_LABEL_H
> > +#define __ASM_JUMP_LABEL_H
>
> Can this be __ASM_OPENRISC_JUMP_LABEL_H?
>
> > +#ifndef __ASSEMBLY__
>
> Note upstream this is now __ASSEMBLER__.

copy that.

>
> > +#include <linux/types.h>
> > +#include <asm/insn-def.h>
> > +
> > +#define HAVE_JUMP_LABEL_BATCH
> > +
> > +#define JUMP_LABEL_NOP_SIZE OPENRISC_INSN_SIZE
> > +
> > +/*
> > + * should aligned 4
> > + * for jump_label relative
> > + * entry.code   =3D nop.addr - . -> return false
> > + * entry.target =3D l_yes - .    -> return true
> > + * entry.key =3D key - .
> > + */
> > +#define JUMP_TABLE_ENTRY(key, label)                 \
> > +     ".pushsection   __jump_table, \"aw\"    \n\t"   \
> > +     ".align         4                       \n\t"   \
> > +     ".long          1b - ., " label " - .   \n\t"   \
> > +     ".long          " key " - .             \n\t"   \
> > +     ".popsection                            \n\t"
> > +
> > +#define ARCH_STATIC_BRANCH_ASM(key, label)           \
> > +     ".align         4                       \n\t"   \
> > +     "1: l.nop                               \n\t"   \
> > +     "    l.nop                              \n\t"   \
> > +     JUMP_TABLE_ENTRY(key, label)
> > +
> > +static __always_inline bool arch_static_branch(struct static_key *cons=
t key,
> > +                                            const bool branch)
> > +{
> > +     asm goto (ARCH_STATIC_BRANCH_ASM("%0", "%l[l_yes]")
> > +               ::"i"(&((char *)key)[branch])::l_yes);
> > +
> > +     return false;
> > +l_yes:
> > +     return true;
> > +}
> > +
> > +#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)              \
> > +     ".align         4                       \n\t"   \
> > +     "1: l.j " label "                       \n\t"   \
> > +     "    l.nop                              \n\t"   \
> > +     JUMP_TABLE_ENTRY(key, label)
> > +
> > +static __always_inline bool
> > +arch_static_branch_jump(struct static_key *const key, const bool branc=
h)
> > +{
> > +     asm goto (ARCH_STATIC_BRANCH_JUMP_ASM("%0", "%l[l_yes]")
> > +               ::"i"(&((char *)key)[branch])::l_yes);
> > +
> > +     return false;
> > +l_yes:
> > +     return true;
> > +}
> > +
> > +#endif /* __ASSEMBLY__ */
> > +#endif /* __ASM_JUMP_LABEL_H */
> > diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makef=
ile
> > index f0957ce16d6b..19e0eb94f2eb 100644
> > --- a/arch/openrisc/kernel/Makefile
> > +++ b/arch/openrisc/kernel/Makefile
> > @@ -9,6 +9,7 @@ obj-y :=3D head.o setup.o or32_ksyms.o process.o dma.o =
\
> >          traps.o time.o irq.o entry.o ptrace.o signal.o \
> >          sys_call_table.o unwinder.o cacheinfo.o
> >
> > +obj-$(CONFIG_JUMP_LABEL)     +=3D jump_label.o
> >  obj-$(CONFIG_SMP)            +=3D smp.o sync-timer.o
> >  obj-$(CONFIG_STACKTRACE)     +=3D stacktrace.o
> >  obj-$(CONFIG_MODULES)                +=3D module.o
> > diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/j=
ump_label.c
> > new file mode 100644
> > index 000000000000..ce259ba30258
> > --- /dev/null
> > +++ b/arch/openrisc/kernel/jump_label.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Chen Miao
> > + *
> > + * Based on arch/arm/kernel/jump_label.c
> > + */
> > +#include <linux/jump_label.h>
> > +#include <linux/kernel.h>
> > +#include <linux/memory.h>
> > +#include <asm/bug.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/text-patching.h>
> > +
> > +bool arch_jump_label_transform_queue(struct jump_entry *entry,
> > +                                  enum jump_label_type type)
> > +{
> > +     void *addr =3D (void *)jump_entry_code(entry);
> > +     u32 insn;
> > +
> > +     if (type =3D=3D JUMP_LABEL_JMP) {
> > +             long offset;
> > +
> > +             offset =3D jump_entry_target(entry) - jump_entry_code(ent=
ry);
> > +             /*
> > +              * The actual maximum range of the l.j instruction's offs=
et is -134,217,728
> > +              * ~ 134,217,724 (sign 26-bit imm).
> > +              * For the original jump range, we need to right-shift N =
by 2 to obtain the
> > +              * instruction's offset.
> > +              */
> > +             if (unlikely(offset < -134217728 || offset > 134217724)) =
{
> > +                     WARN_ON_ONCE(true);
> > +             }
> > +             /* 26bit imm mask */
> > +             offset =3D (offset >> 2) & 0x03ffffff;
> > +
> > +             insn =3D offset;
> > +     } else {
> > +             insn =3D OPENRISC_INSN_NOP;
> > +     }
> > +
> > +     if (early_boot_irqs_disabled) {
> > +             copy_to_kernel_nofault(addr, &insn, sizeof(insn));
> > +     } else {
> > +             patch_insn_write(addr, insn);
> > +     }
> > +     return true;
> > +}
> > +
> > +void arch_jump_label_transform_apply(void)
> > +{
> > +     // flush
>
> Could you use the /* */ comment style?  Is this really flushing?

sure, really flushing.

>
> > +     kick_all_cpus_sync();
> > +}
> > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.=
c
> > index a9fb9cc6779e..000a9cc10e6f 100644
> > --- a/arch/openrisc/kernel/setup.c
> > +++ b/arch/openrisc/kernel/setup.c
> > @@ -249,6 +249,8 @@ void __init setup_arch(char **cmdline_p)
> >               initrd_below_start_ok =3D 1;
> >       }
> >  #endif
> > +     /* perform jump_table sorting before paging_init locks down read =
only memory */
> > +     jump_label_init();
> >
> >       /* paging_init() sets up the MMU and marks all pages as reserved =
*/
> >       paging_init();
> > --
> > 2.45.2
> >
