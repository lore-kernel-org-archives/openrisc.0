Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A423A9B3;
	Tue, 26 Aug 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220786; cv=none; b=Ff+ZrGaLT+8I+h8Yx8FJJud5Sz5IJRihry+/qlRn83La2S+tgslSSn9rklnsf3e92GRHg6+Ukla/9k6x9Jpvf85ig4bHDdCpl5q5VY+GLENcdDh1EL+3DSyRPf9wL4g0kZqKzMUJw6Y6ciK2RToGnPVBIgdfxr7VSk9NsBcYti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220786; c=relaxed/simple;
	bh=lwb4A6igi9n728qv9j/YTWe0CE4j5dATxHn27zrDcF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/AYLTPhF+45e68wzUKqCRpA4tKfVuDs438oGJmE+fA8CE6XwRJ9TrwYEZq6LG6G/sFJAwnI71srPBd1x2ivqb2Yb0//8/Ze5gwReTvd1B6Db8QL3ptlKbw3B1VBQ8P/C81p2vNhQ+Blusr9cdHwf6crQINNpXBBGZBRqjHYlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2xGbu5J; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2xGbu5J"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4e5c3d0fso13060355e9.2;
        Tue, 26 Aug 2025 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756220782; x=1756825582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IWqIuZ1z9Jm7Aj+UVUhIFdU7BdxTLHR+9pDx+/y2JA=;
        b=E2xGbu5JwuhITwvI0qG9CjRQofclukz6joTJGMcqfSExvHDWBXM/J4lnXByCCyK5Z0
         eiK3GcrzTnrv7JKNFTRAknhitNUlryu5Wb7o2Q7eaxfPiu2EYTHxc1ltTR3LmZ9/C43E
         C3G+qalDiTumFkawA8d4Z0urODJcLDIc8B6TpYrfkNfz0N7iQk6g2FsBn/7LJ6HTninp
         CGEsSWNRaNOpvFYlgsQj/GOpgu0w/zq7Bi5ts8fOSbnSivW4mzPnqXq5X9yAki7afOcD
         iuhmunGBBisy+tpG/5PdcewL34UUd3cFplLR689u7tpCvf2tIfF1c1xz4GzyDGl+s+GJ
         VLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220782; x=1756825582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IWqIuZ1z9Jm7Aj+UVUhIFdU7BdxTLHR+9pDx+/y2JA=;
        b=hLwVbEufgDP08GYoCWoHAG6xgNWqKFhCI9vesGLEuNFsVv7MrsCcQ5qMCr2CdGaXr5
         RWlmExyFM5zXu/NPwcXAqaTFOSs3saseA97bB0yKdP5wcO3qXYf8GYux9spHSzql2USm
         epGfQYoAHvHacZlqoMtxLeMwmmU9A/pRWs4liPFZAEL6JXlDNEDO2OMIKLBbgMbDcJ7I
         Ib+eX1O9v+yYnAWXBpHVUBd8ngPPq+6FA68kAx24G9kVUzamWKmEpI1cKAsgzsEvz5lj
         rI5X8sn2vi/YqH00qgDI3AyvKbxcvNfoQmdazJRD8jMk1Ke9IpJqIQN8STyEGrkINr1p
         5FRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/K96CCuMWZjZujlnTYCE+PpvHlk+R5wfmidpglRaJUMm5+U88BQclWG3gQKrK0iFrGq3q+KY/XTvBOMHcMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoAAMuWtjBumTAejK18PpWZiLFdJIJREK0SJgkHliIqjXj/u+y
	5q4FZOK7QbDpI0wl+CluQZBcXqZ94uXA44W+m3LKPcny4RGergh4VUCo
X-Gm-Gg: ASbGnctOOmNrSbrEO2mqAsMkBH451cKhLMpFZGL1clAxjsktoMi6nkMNpXmGe8BHpy5
	YGD/+OL0PMPtQoXVmDvMe/1QLUS08DmDAp/rIy44mhP5dzjb+VEM+1WSSJrUOrMfnt6Eikbc03q
	yrwDaG7phzULDm92DQ+qmXsgdJ2JEoGG4Rbhd99zu598E3RU+AWmu2wehE9axb1TmFW1mof7TId
	W6a2yHrtNLCXnhnn3nCzbnrmb0Fich58k3VIOwN3EXQ/oPISOgmQNYTW8GibxE4ZqGRwLMhxACp
	wEdDei7+1dm9OqKERBIgoYgtBUyKmqxyXdL8i70M4GAUeo1y7Mn9GrjeRx7vV9SfD/CkL9MExBn
	UnVgf5SKICRapA5KIgyd+uEew7KcbWK5zvSeoA3XizPBn1SBDQJ8dKrcUGpTjN0VwFzfBZm7E
X-Google-Smtp-Source: AGHT+IG3gnib459mobCkTQ7iIEyFmSwSaeqk5fVx58hJLHd6faFwIIL5iFtQRNxReo0JLw4ylyXODw==
X-Received: by 2002:a05:600c:3223:b0:45b:6269:d25a with SMTP id 5b1f17b1804b1-45b6269d8f3mr36993075e9.37.1756220782203;
        Tue, 26 Aug 2025 08:06:22 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c9c9324dc9sm8164782f8f.3.2025.08.26.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:06:21 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:06:20 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 1/2] openrisc: Add text patching API support
Message-ID: <aK3NbFkHn5jx7JJ2@antec>
References: <20250814032717.785395-1-chenmiao.ku@gmail.com>
 <20250814032717.785395-2-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814032717.785395-2-chenmiao.ku@gmail.com>

On Thu, Aug 14, 2025 at 03:27:01AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> We need a text patching mechanism to ensure that in the subsequent
> implementation of jump_label, the code can be modified to the correct
> location. Therefore, FIX_TEXT_POKE0 has been added as a mapping area.
>
> Among these changes, we implement patch_map and support the
> patch_insn_write API for single instruction writing.

I think the description here could be improved a bit.

Something like:

Add text patching api's to use in subsequent jump_label implementation.  We use
a new fixmap FIX_TEXT_POKE0 entry to temporarily override MMU mappings to allow
read only text pages to be written to.

A new function patch_insn_write is exposed to allow single instruction patching.

> Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t
> 
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> 
> ---
> Changes in V3:
>   - Removed the unimplemented and unsupported is_exit_text, added
>     comments for the set_fixmap modification explaining why __init was
>     removed, and added new comments for patch_insn_write.
> 
> Changes in V2:
>   - We modify the patch_insn_write(void *addr, const void *insn) API to
>     patch_insn_write(void *addr, u32 insn), derectly support a single u32
>     instruction write to map memory.
>   - Create a new file named insn-def.h to define the or1k insn macro
>     size and more define in the future.
> 
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---
>  arch/openrisc/include/asm/Kbuild          |  1 -
>  arch/openrisc/include/asm/fixmap.h        |  1 +
>  arch/openrisc/include/asm/insn-def.h      | 12 ++++
>  arch/openrisc/include/asm/text-patching.h | 13 ++++
>  arch/openrisc/kernel/Makefile             |  1 +
>  arch/openrisc/kernel/patching.c           | 78 +++++++++++++++++++++++
>  arch/openrisc/mm/init.c                   | 10 ++-
>  7 files changed, 114 insertions(+), 2 deletions(-)
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
> +
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
>

The ifdef here and above a incosistent.  Can you try to use a consistent
convention to what is already used in openrisc?

Mostly we use: __ASM_OPENRISC_*_H

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
> index 000000000000..73ae449c6c4e
> --- /dev/null
> +++ b/arch/openrisc/kernel/patching.c
> @@ -0,0 +1,78 @@
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
> +static __always_inline void *patch_map(void *addr, int fixmap)
> +{
> +	uintptr_t uaddr = (uintptr_t) addr;
> +	phys_addr_t phys;
> +
> +	if (core_kernel_text(uaddr)) {
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
> +
> +	patch_unmap(FIX_TEXT_POKE0);
> +
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	return ret;
> +}
> +
> +/* patch_insn_write - Write a single instruction to a specified memory location
> + * This API provides a single-instruction patching, primarily used for runtime
> + * code modification.
> + * By the way, the insn size must be 4 bytes.
> + */

The commit style is a bit off.  In the kernel multi line comments usually start
with a lone '/*'. e.g.

/*
 * patch_insn_write - Write ...
 * ...
 */

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
> index e4904ca6f0a0..ac256c3d9c7a 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -226,7 +226,15 @@ static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
>  	return 0;
>  }
>  
> -void __init __set_fixmap(enum fixed_addresses idx,
> +/* Removing __init is necessary. Before supporting FIX_TEXT_POKE0,
> + *  __init here indicates that it is valid during the initialization phase
> + * and is used for FIX_EARLYCON_MEM_BASE. However, attempting to support
> + * FIX_TEXT_POKE0 would introduce a bug. FIX_TEXT_POKE0 is used after the
> + * initialization phase, so __init would cause the function to become invalid.
> + * At that point, using set_fixmap would lead to accessing dirty data,
> + * which is invalid.
> + */

The comment about __init does not belong in the source here.  Perhaps your
comment could mention hwo the __set_fixmap function is used for both EARLYCON
and TEXT_POKE mappings.  Also, the comment style need to be updated.

> +void __set_fixmap(enum fixed_addresses idx,
>  			 phys_addr_t phys, pgprot_t prot)
>  {
>  	unsigned long address = __fix_to_virt(idx);
> -- 
> 2.45.2
> 
