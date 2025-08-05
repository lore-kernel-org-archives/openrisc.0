Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729D262FE9;
	Tue,  5 Aug 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385356; cv=none; b=p9uKnT4yObos/Lnw4qV/4If84k5o20y26kJrQjahKz/G77cqlc0NiOHzp6qK5ZCWxW0RqIVF9LyxkICqHGQ0DLKVgTU/LXsoRbrFstpiaAC3qetGym7tagnSHY0JftrrOVFqLDzX9BlAcyCKGmYQe5nVr5y4LkiY12G2wEuzX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385356; c=relaxed/simple;
	bh=Gm/7tQCoey1ZR++BK/jJJ1FKh0QPkAawgAkyjI0mhF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+TkkF8NkcgS6B6N5utbFxzXPLazcMMORCGpgtvGwr1EbYYyzx9Hfk20zwsEmkOzvuEThmfIhIGXB25QwJL9VLG9OKDCVBSHuLf5Iebqt1pwXsQYe02w0YviHfp3J83M0YkRWJZwEHlWZjQ4ropl5Se07wrnmOJBQdVPvOP6ifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKDUGKcW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKDUGKcW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so23099495e9.1;
        Tue, 05 Aug 2025 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754385353; x=1754990153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zfOKFs2KSkJt6EfEJa66RtmY8SaEOtW71EvLnpkOlpQ=;
        b=bKDUGKcWOWRRLoR18IK07vqSI81w0R192b2OrAROFF3/ryLFQeVWBUs1bW04HA8kR0
         Gns9U70RflyiWH51g+j53ZgZYx5krvLOq6kIoTT2sL8dfxGD9JMXclihgUA2QxRBNyRJ
         3bS7Hg/TVtEmoGKQxJNk5HbQLrmB8AqQATLioZgbz49vMCrzkqFmN/gFk/fwS9ABmYcd
         y1HRWNwWMrdjOFoWYKIdYJrL/YABHJmjI+uix9rQunIAIzkPSapOXGnK8IQ1BYvf4DX1
         SdWcM+hcmLX9Gm5LlFalentEVDmyi664HLW9R8tTkvlY4CqmBkLEjbZVe2h6yYZDmeZ4
         XyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754385353; x=1754990153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfOKFs2KSkJt6EfEJa66RtmY8SaEOtW71EvLnpkOlpQ=;
        b=BCGNyzwKrHtHKL7Ea/Qt7yvthbTM3qBYO5TfoE4qs6EHhPD/wffgsIUHRz7OZ6kPGb
         xocEx84FEIc9xyKF0UOdyk965kxM0+muOcP+B2uTB9veAjs5+eGcI9JF4Qz0CrJcWLVF
         BnmOZYNqmyEzPaPsRl5B4I8cdvsZ7sX74PdsT/4643rhQolCVwu5GPVWoKR68tX9n2uH
         x3EOoxXyB9RJDQOiFRnZFNdasHF6wURCmuh/cansNyu8AeRDsVU9wXY35xKeCf5ssz3v
         snoUlsV2OdgvbXqHwB6DDoNndqy6ze5hoRy3+eB29Ip1WRsK8bwvnZasI+/Ue0WOJ3Bn
         /H8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwcTHlZM8hygAa6uAx8NxR6qKrWwr4mY1BDBHs9wEqYDWHmyR6VB8ae8PXd+MjoZ75I3/PW4LDyO4Cguo=@vger.kernel.org, AJvYcCWsgxVCi6I+koNg1JMecBveA8By0HT5ksa2NPHhO1ApSqSp1vkJbuVYvL18ywSSbU08IByBsNpSj6Tz8U3qMHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTyV5/RNL9FOkbMBuRBD8gIUKP+Po0efOZhQp/H59cRhDdxTdl
	R4lu/4d+2iPSzfNzlqKK15sQhb0t/Yrt6Z6cmbpFi5S4cxJt9ExhUTxlBtzXEoHI
X-Gm-Gg: ASbGncv7WpqQRXJ6GOBaHqAK8PYHVdQxJYqEwnIkRuQdoocttn/rQMdxLMUCBuF0vyV
	Dk9qfFOzUlvvW9r5dpD5IXzfJq7bu4VFGm4XeevVMe6NVCjnEXF8aulMO4PU9aV7OqQ6gJgupi5
	Kfq3GgdQBNn+Km6KXUGOt0kFJiIomzE1OXBk/QFdatR85gEktBFvrW8WIXM/pNUseNKjnf2DVwu
	6gg4PCetI370uGg5g5uIzAK/XDhojjIHgNgTV3+pSDTeUGgQcnlsa/CyLtN7hauvH0ORuID0mRW
	x6XlSQpoeX+Y59kCm3W7DohzQR68g+sAezE4qgU6t1FZtZtO91tmmEFvhzXtJl9agYp3QV3CUWT
	UxilQOUWSvSsLbE+lCfweOCQXkieTTph7nBIGQbMFRL0ksKa8Bym+2UQqB09Bxw==
X-Google-Smtp-Source: AGHT+IFZc+1tFfp9jlNeO23LRnsfjZihfn9Pda8cbelddn5S+aCfl7W5T3uGHFSReyW/drO7mvQRBQ==
X-Received: by 2002:a05:600c:788:b0:458:ba04:fe6d with SMTP id 5b1f17b1804b1-458ba04ff2bmr68189805e9.14.1754385352487;
        Tue, 05 Aug 2025 02:15:52 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45910e182besm102478965e9.32.2025.08.05.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:15:51 -0700 (PDT)
Date: Tue, 5 Aug 2025 10:15:50 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] openrisc: Add text patching API support
Message-ID: <aJHLxmPk-5cPCnPA@antec>
References: <20250805084114.4125333-1-chenmiao.ku@gmail.com>
 <20250805084114.4125333-2-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805084114.4125333-2-chenmiao.ku@gmail.com>

On Tue, Aug 05, 2025 at 08:40:57AM +0000, ChenMiao wrote:
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
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---
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
> +
> +#endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/text-patching.h b/arch/openrisc/include/asm/text-patching.h
> new file mode 100644
> index 000000000000..4c3d8a6a906a
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
> +int patch_insn_write(void *addr, const void *insn);
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
> index 000000000000..2b979a0bc584
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
> +static int __patch_insn_write(void *addr, const void *insn)
> +{
> +	void *waddr = addr;
> +	unsigned long flags = 0;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	waddr = patch_map(addr, FIX_TEXT_POKE0);
> +
> +	ret = copy_to_kernel_nofault(waddr, insn, OPENRISC_INSN_SIZE);

If you change *insn to unsigned long insn, you can do:

	ret = copy_to_kernel_nofault(waddr, &insn, iszeof(insn));

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
> +int patch_insn_write(void *addr, const void *insn)

Does insn need to be void *?  It think it could be just unsigned long. See
comment above.

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
>  			 phys_addr_t phys, pgprot_t prot)
>  {
>  	unsigned long address = __fix_to_virt(idx);
> -- 
> 2.45.2
> 
