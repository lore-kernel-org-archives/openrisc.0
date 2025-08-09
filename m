Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C502206A6;
	Sat,  9 Aug 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754727927; cv=none; b=cIT1WnRDccaJ2UGhd9oJBq3X7YbwgV4qkZDsNExoOeZurS60OyNl3DgMR17X9Bvn/JZLrPZJEoy8398Vp0acPfcZpxCRtTE0K2X5zdaPfklTQ/7ppYE8KPGr/t6Jfv0nncsW5i70BZbSmOi9orkEUStnf0SaWHwmIv7YPa1av4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754727927; c=relaxed/simple;
	bh=6hZUX5BzXJxl+le6JejaaAQ5vkqA5NpiAPa/FpDs7EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KftFMoMSmQPvwLl3XynQc60NssoAvhiy1TFFELUTnGM1/kaHkzysJvDQAlqD+lmXB17EVYcwaTmcy3b6X/c926O8KR0o4SKhsCL7xCMzdL93lz0Mvo0M3S8WuaoOqgDhuOOHWRfMZ8uacvUtJOSO5kmhgEEQjpSScj9NYXilci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIowxpi6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIowxpi6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d3f72391so22767865e9.3;
        Sat, 09 Aug 2025 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754727924; x=1755332724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkGRBgYyAuoN42OXjEbj1I1gqGxF3tvkJgNCQHwK9uM=;
        b=YIowxpi6sBQd3GXdRB41gfa7JxeZ+CTfVN8nqo/a7FGSTbDjDqZ7vIUPcp6oF7rNhP
         Wbtd505E02iwwoNy77a9y8i0QS/VKd/UzuFewg69HVoXW9Q9t1VUaoWC/IG32L1wifyW
         zcFty5DNPkrFy9D4cvl9LLtkbmFzvFfPG6+BhdoqHKotmjVRlIK+hxKTkOTfAp4Gevtr
         dB3NxCWBDX+yVHeiM+ghVjaU9VSol9w9nlvhmnXX9YBr2LAtScmygG1+qK661+jPnjlh
         I3KfKncaf/lDekqpwx1A7V5LtkPW2KYOSzRxjRTz2Z48gqmsR//BaUKKeJ9ZTySMW4AI
         AsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754727924; x=1755332724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkGRBgYyAuoN42OXjEbj1I1gqGxF3tvkJgNCQHwK9uM=;
        b=L0geCIS/984DypQxhscr77jaq07BGY8IWBKBFwKluhD2F9E6e2kqSl3QXTghYPlEYz
         M8tMoybpNcsIBWNgdAfi2O9iOSb3+BJf/sMwBbcI+IZ85KIyCxpfQ6CdRJaRkvGg8fdm
         fwiFRIwhFXg//9Mw6XlBQEmInzxn0nFmVzaw7/3HtbG2pZ9Vq+dQLa+1l8gF1YJcYg5S
         gytFKfJazr60WRiCyWVmz4sGG8DeCZCR9ZW/oTMtG6pnDQ/uhKyOZt1MutVGFBB1cUdD
         vyFY0uFg9YKFAwBJC++TnEQKfeaWbcdZSDA78HptIaKMWVbA6AND5hM0LHf4v/QpmkMK
         mCSw==
X-Forwarded-Encrypted: i=1; AJvYcCXBqAiVNJolVwK9V92ltvX8NtnKkTYMfEu78KPvYXfpvcoBrDN1F8F+1X5xmfRKABae/OhB1jcl+7tj3KYl+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkas1PDwKMvupfxjL9gXPDqBI4HyotmIgMExqtWwhnQTV1ZrBC
	7EIAv3JUZyN4JX45ByWquXrWHRa7W3XMmFeXzgqptun4fFDG95WRbYTF
X-Gm-Gg: ASbGncsyjstCR6MTgUp+OJad7L855L+TfPeO4/hQscrilw/HDFcqXzSONrGiSZ61uPJ
	zm/l5VJVe6Qn3xRyvXt3CUAaAjRostpPk7eergNDME8pVx4sVROgvbtgcTzVodx6W8Y7Gu5cLjY
	IXgN2jEpVj5O5YWVs3OsEg26Mo/ZYCmECAITGJ5o3pt8E56a3y1pLTgG7uBuFA7mNDXSNyeroAR
	eyGo/+qfSGqn/L6tNv/Fg+sKma+2ZTVLVO5vWzNR0ESI67w0LY3QCmVTPy8wF4xxZEgHIfot/Be
	xiMPBSJ4LtDWrbJNUycvgCfmrUWigmGbo3YRvKpdgjVjed0Sw2S9SJe7SNLdf9Cb4ZDASD01A7w
	nwwcUqOpSjZ9OOwaGU7tyebu4008y2jthOxVzDntWM9YINRuhUTGfLPLuux5aDw==
X-Google-Smtp-Source: AGHT+IF/AjD/uSKMHY+9I7X9FWDKbt9gCniZj27bIHBhWy2Exb0IZvR9U87sHXds88zqGJNJL10CSQ==
X-Received: by 2002:a05:600c:458b:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-459f4eb411bmr53201545e9.12.1754727923848;
        Sat, 09 Aug 2025 01:25:23 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2848sm32599079f8f.71.2025.08.09.01.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:25:22 -0700 (PDT)
Date: Sat, 9 Aug 2025 09:25:21 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] openrisc: Add text patching API support
Message-ID: <aJcF8RnqYVNEMlp8@antec>
References: <20250806020520.570988-1-chenmiao.ku@gmail.com>
 <20250806020520.570988-2-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806020520.570988-2-chenmiao.ku@gmail.com>

On Wed, Aug 06, 2025 at 02:05:03AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> We need a text patching mechanism to ensure that in the subsequent
> implementation of jump_label, the code can be modified to the correct
> location. Therefore, FIX_TEXT_POKE0 has been added as a mapping area.
> 
> And, I create a new file named insn-def.h to define the or1k insn macro
> size and more define in the future.
> 
> Among these changes, we implement patch_map and support the
> patch_insn_write API for single instruction writing.
> 
> - V2: We modify the patch_insn_write(void *addr, const void *insn) API to
> patch_insn_write(void *addr, u32 insn), derectly support a single u32
> instruction write to map memory.
> 
> Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t
> 
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---

The v2, notes should go in this part of the patch (after ---), this way
it does not show up when I queue the patches.

>  arch/openrisc/include/asm/Kbuild          |  1 -
>  arch/openrisc/include/asm/fixmap.h        |  1 +
>  arch/openrisc/include/asm/insn-def.h      | 12 ++++
>  arch/openrisc/include/asm/text-patching.h | 13 ++++
>  arch/openrisc/kernel/Makefile             |  1 +
>  arch/openrisc/kernel/patching.c           | 79 +++++++++++++++++++++++
>  arch/openrisc/mm/init.c                   |  2 +-
>  7 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 arch/openrisc/include/asm/insn-def.h
>  create mode 100644 arch/openrisc/include/asm/text-patching.h
>  create mode 100644 arch/openrisc/kernel/patching.c
> 
> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index 2b1a6b00cdac..cef49d60d74c 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -9,4 +9,3 @@ generic-y += spinlock.h
>  generic-y += qrwlock_types.h
>  generic-y += qrwlock.h
>  generic-y += user.h
> -generic-y += text-patching.h
> diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
> index aaa6a26a3e92..74000215064d 100644
> --- a/arch/openrisc/include/asm/fixmap.h
> +++ b/arch/openrisc/include/asm/fixmap.h
> @@ -28,6 +28,7 @@
>  
>  enum fixed_addresses {
>  	FIX_EARLYCON_MEM_BASE,
> +	FIX_TEXT_POKE0,
>  	__end_of_fixed_addresses
>  };
>  
> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
> new file mode 100644
> index 000000000000..dc8d16db1579
> --- /dev/null
> +++ b/arch/openrisc/include/asm/insn-def.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Chen Miao
> + */
> +
> +#ifndef __ASM_INSN_DEF_H
> +#define __ASM_INSN_DEF_H
> +
> +/* or1k instructions are always 32 bits. */
> +#define	OPENRISC_INSN_SIZE		4

Is this used outside of the usage below?  Why do we need a header for it?

> +#endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/text-patching.h b/arch/openrisc/include/asm/text-patching.h
> new file mode 100644
> index 000000000000..bffe828288c3
> --- /dev/null
> +++ b/arch/openrisc/include/asm/text-patching.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Chen Miao
> + */
> +
> +#ifndef _ASM_PATCHING_H_
> +#define _ASM_PATCHING_H_
> +
> +#include <linux/types.h>
> +
> +int patch_insn_write(void *addr, u32 insn);
> +
> +#endif /* _ASM_PATCHING_H_ */
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 58e6a1b525b7..f0957ce16d6b 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -13,5 +13,6 @@ obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_OF)		+= prom.o
> +obj-y	+= patching.o
>  
>  clean:
> diff --git a/arch/openrisc/kernel/patching.c b/arch/openrisc/kernel/patching.c
> new file mode 100644
> index 000000000000..c9a30f0d1193
> --- /dev/null
> +++ b/arch/openrisc/kernel/patching.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2020 SiFive
> + * Copyright (C) 2025 Chen Miao
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/insn-def.h>
> +#include <asm/cacheflush.h>
> +#include <asm/page.h>
> +#include <asm/fixmap.h>
> +#include <asm/text-patching.h>
> +#include <asm/sections.h>
> +
> +static DEFINE_RAW_SPINLOCK(patch_lock);
> +
> +static inline bool is_exit_text(uintptr_t addr)
> +{
> +	/* Now Have NO Mechanism to do */
> +	return true;
> +}

Is this needed?  OpenRISC doesn't seem to have any sections to support __exit
annotated cleanup functions.

  Ref: https://kernelnewbies.org/FAQ/InitExitMacros

Returning true here means that all of the patch_map calls will be treated as
kernel pages below though, which is wrong, please remove this.

> +
> +static __always_inline void *patch_map(void *addr, int fixmap)
> +{
> +	uintptr_t uaddr = (uintptr_t) addr;
> +	phys_addr_t phys;
> +
> +	if (core_kernel_text(uaddr) || is_exit_text(uaddr)) {
> +		phys = __pa_symbol(addr);
> +	} else {
> +		struct page *page = vmalloc_to_page(addr);
> +		BUG_ON(!page);
> +		phys = page_to_phys(page) + offset_in_page(addr);
> +	}
> +
> +	return (void *)set_fixmap_offset(fixmap, phys);
> +}
> +
> +static void patch_unmap(int fixmap)
> +{
> +	clear_fixmap(fixmap);
> +}
> +
> +static int __patch_insn_write(void *addr, u32 insn)
> +{
> +	void *waddr = addr;
> +	unsigned long flags = 0;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	waddr = patch_map(addr, FIX_TEXT_POKE0);
> +
> +	ret = copy_to_kernel_nofault(waddr, &insn, OPENRISC_INSN_SIZE);
> +	local_icache_range_inv((unsigned long)waddr,
> +			       (unsigned long)waddr + OPENRISC_INSN_SIZE);

Instead of OPENRISC_INSN_SIZE, can you use sizeof(insn)?

> +	patch_unmap(FIX_TEXT_POKE0);
> +
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	return ret;
> +}
> +
> +int patch_insn_write(void *addr, u32 insn)
> +{
> +	u32 *tp = addr;
> +	int ret;
> +
> +	if ((uintptr_t) tp & 0x3)
> +		return -EINVAL;
> +
> +	ret = __patch_insn_write(tp, insn);
> +
> +	return ret;
> +}
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index e4904ca6f0a0..b5925710f954 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -226,7 +226,7 @@ static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
>  	return 0;
>  }
>  
> -void __init __set_fixmap(enum fixed_addresses idx,
> +void __set_fixmap(enum fixed_addresses idx,

Can you put a comment about this bit in the commit description?

>  			 phys_addr_t phys, pgprot_t prot)
>  {
>  	unsigned long address = __fix_to_virt(idx);
> -- 
> 2.45.2

-Stafford

