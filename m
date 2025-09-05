Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110224DCE5;
	Fri,  5 Sep 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092537; cv=none; b=nZ8QJZjyw4CsQ2xUnzOkBOY0/PJA1Th94g5q0gcMLIXUDqfq1ijeg6OLnhRTsi+UxV41CfRiMHuWIGhH58irG+iAASmBgmXS4zJcP+vk2cg9nxxL4BKL4Cn/isJvYqmC3gMhGpjzWFDQCUXPnnXhXT8U6ULc1BtV5TLHM4ZZVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092537; c=relaxed/simple;
	bh=wJLezOvIHnv7UPZHfc3w5/VFhMk3/VbTy2UD4V7VPuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLdShyZQ5evKNkT6yispfMaeN6dWaWA46R/hgSQtlmiiot/Edgy/RkEUdErbzy1+mhwrE/Jnad1yUs31fux60AMqo0AEf750T+wiRBTCFKOlSWotUrRgDf4WbHZB5y767mX52hoW4IfJH+U+kJmw9WenJR/ExeLHJIs7zRh7UOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMiPXOGW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMiPXOGW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so11500635e9.3;
        Fri, 05 Sep 2025 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092534; x=1757697334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbjtyeIvGngIN1ejGrsGiEwfiz9L6HVFRhur4GikOLQ=;
        b=QMiPXOGW2kOije4x6/7aFkIIyYITiYCcCI8rwyzY+8XoR31PMvpFnFZg2b0BKk0iuH
         bsGOiYUN3VdB7iotR3CdNhR8fXPF+eK/fsl/v90SZIGXSEs4UJp2chUp5SYbozhnylLY
         A7u525pzJ1rppf0Bfyt0fztZZkBj741bZdbKomeLn4UvfNdulpJ6Ha+K8X4kU45NbT6Y
         gjlnNL6AJloRhjxhsA5MAsdfSOaEjFZIENqmjCKjzOVtXjSZgg8mtE4YcwhBetCxFW/G
         Ms6wkn0vTMKwhECj4REe8L7+EIWmdnsOGnORVkKAEVnMFPy95vMM7BDnd2n9tFoLNLbu
         XFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092534; x=1757697334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbjtyeIvGngIN1ejGrsGiEwfiz9L6HVFRhur4GikOLQ=;
        b=oOReDaz0PjpTA/QMSWZYvY+ZNtzEMyY5a+nh9Izb/Zqg4uspXYHN+pjMQ/YdG5jRwm
         VZkKPFv4Oui5TgAxSYU+gXNQMqTzYXQvE9NnnHZV7fN/3qpjfl3i2RkinMvQ/MonZdHu
         eLptbbz/PHt9B5CcZHz2EfFLj7bfqp0jTen1Uu9pN+Cxt050a6s+0nbnC1yKoCRSbxmy
         jzRoPOtZFAPM+RZa70IQxx8mbTlBOEcP6bpIU/91Ga9L7gieNfk3we/fm2fZ5qZJM4yZ
         dQjAiYi9Y4hudcW7jYzHtf7jFA6keUUw71r4SNyU5eFuXwserHpLdlK9spidMBa12MMg
         llww==
X-Forwarded-Encrypted: i=1; AJvYcCXrXZ+fVlZ7og4b4gGGnya3OlmxzdMMP4YwVlj3f7CJvJn8BHSqxM6LySeqZAwMPXqzrAPahr7zNiGU79pvjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaRLeGqqfVDSQ4UeaRUVh13C9KoOWJVHNIexlm0ppTGSrR0x0
	lWH3pM8baUvMHwxnBJjiL1HstV57ZpvNbQlJBFpKdxzXXInLFtgj50Te
X-Gm-Gg: ASbGncsKx/wgPddd9Dkihj4snR/yNftdY2YhWoCeDYmd8j86Qw+6bwPUErnCz9fkI+z
	kVa3PG39Q8eY6vNYRRMokjBAF/qGthZ5pomUm6PbPBMVMiG/8NubSuS8eOUSCfEIGP58Ks5rYMN
	xKJvJrAYkTrUpE6PW8nM1Hgi9ml9rtq0c/V1gsQTIFcGQP6EAzQql2LxgZSxQeT5+omTzGBiMkM
	jbSNYVkPep/4f/0NEV2+TK0HslvD8+05AvV8R2T16qe1fo+o859xsa7v5dwhuTXZ4wZMjYD9ptl
	wHCoT3FwEEczVFRl8x6mgFOQFuJvnO+U5W4RkRwnALFk9BzlsVk2k/rivIz3v+c9AKfx4NiRGXs
	cRjl1xBeDnQYqvjBjtZiY8VgPvLID7tqsnpI94bJ0QPVlOj7PeE6hPsbWliOXZQ==
X-Google-Smtp-Source: AGHT+IEWnYMvobeOLIzWC9yLdqPp6dvf9AMbrTWQw3MZnfcVYOX3mCHcL2jfdveiCYMCyFiIuzjGzw==
X-Received: by 2002:a05:600c:c162:b0:45b:8352:4475 with SMTP id 5b1f17b1804b1-45b85598a56mr184301435e9.36.1757092534016;
        Fri, 05 Sep 2025 10:15:34 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2df4c8dsm67635785e9.15.2025.09.05.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:15:33 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:15:32 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 1/4] openrisc: Add text patching API support
Message-ID: <aLsatJXVKshZOG0d@antec>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
 <20250904100109.688033-2-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904100109.688033-2-chenmiao.ku@gmail.com>

On Thu, Sep 04, 2025 at 10:00:49AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Add text patching api's to use in subsequent jump_label implementation.  We use
> a new fixmap FIX_TEXT_POKE0 entry to temporarily override MMU mappings to allow
> read only text pages to be written to.
> 
> Previously, __set_fix was marked with __init as it was only used during the
> EARLYCON stage. Now that TEXT_POKE mappings require post-init usage
> (e.g., FIX_TEXT_POKE0), keeping __init would cause runtime bugs whenset_fixmap
> accesses invalid memory. Thus, we remove the __init flag to ensure __set_fix
> remains valid beyond initialization.
> 
> A new function patch_insn_write is exposed to allow single instruction patching.

OK.

> Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t
> 
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> 
> ---
> Changes in V4:
>   - Fixed incorrect macro definitions and malformed comments.
> 
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
>  arch/openrisc/kernel/patching.c           | 79 +++++++++++++++++++++++
>  arch/openrisc/mm/init.c                   |  6 +-
>  7 files changed, 111 insertions(+), 2 deletions(-)
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
> index 000000000000..e28a9a9604fc
> --- /dev/null
> +++ b/arch/openrisc/include/asm/insn-def.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Chen Miao
> + */
> +
> +#ifndef __ASM_OPENRISC_INSN_DEF_H
> +#define __ASM_OPENRISC_INSN_DEF_H
> +
> +/* or1k instructions are always 32 bits. */
> +#define	OPENRISC_INSN_SIZE		4
> +
> +#endif /* __ASM_OPENRISC_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/text-patching.h b/arch/openrisc/include/asm/text-patching.h
> new file mode 100644
> index 000000000000..d19098dac0cc
> --- /dev/null
> +++ b/arch/openrisc/include/asm/text-patching.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Chen Miao
> + */
> +
> +#ifndef _ASM_OPENRISC_PATCHING_H
> +#define _ASM_OPENRISC_PATCHING_H
> +
> +#include <linux/types.h>
> +
> +int patch_insn_write(void *addr, u32 insn);
> +
> +#endif /* _ASM_OPENRISC_PATCHING_H */
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
> index 000000000000..d186172beb33
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
> +/*
> + * patch_insn_write - Write a single instruction to a specified memory location
> + * This API provides a single-instruction patching, primarily used for runtime
> + * code modification.
> + * By the way, the insn size must be 4 bytes.
> + */
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
> index e4904ca6f0a0..9382d9a0ec78 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -226,7 +226,11 @@ static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
>  	return 0;
>  }
>  
> -void __init __set_fixmap(enum fixed_addresses idx,
> +/*
> + * __set_fix must now support both EARLYCON and TEXT_POKE mappings,
> + * which are used at different stages of kernel execution.
> + */
> +void __set_fixmap(enum fixed_addresses idx,
>  			 phys_addr_t phys, pgprot_t prot)
>  {
>  	unsigned long address = __fix_to_virt(idx);
> -- 
> 2.45.2
> 
