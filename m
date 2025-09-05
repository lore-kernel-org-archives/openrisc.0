Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CD313263;
	Fri,  5 Sep 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092348; cv=none; b=epXfWzpVLRSOonBQyl4D+i7sZACc77AEtf38kvdc5immd/QYpoCpJIghZmUup1uwRvgOhGFVC/QJ0csj7VCK8upWX8uaFuS6P4/OqrlM4gsrOSg8SsC811BClHSVmFJbvGq1YqKoqg/XpNMdg7h1/wXYmFpNbDSwYB/d4s7kbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092348; c=relaxed/simple;
	bh=lyqfJ/ZN3M6mFpy4g8NM3d22I/vUrO5IUFMLD0nCawo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrWlAzD3oXdb+VAWsjT4s+4MTgcYLqT/v7f/wiOmp+3qi+oTd32PBzoskHbuI5xiuUN981yDF3ZApeHFGMMBBFioWU3iI2JCVWwEOPEKen/AqPIf7lRUc/UaauHVgFkrwTK10ykP20x+GFk3pucziUfocj4MX9EJ7yhWd1wvEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhfeOHTW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhfeOHTW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so21482025e9.3;
        Fri, 05 Sep 2025 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092345; x=1757697145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j4B5K2QuSQMfRWCeZrOmBjCMlWlaylCu+OhDi6hAi8=;
        b=LhfeOHTWos9VjEjshr1H4PyTBMJ4lndzbVeMV+xDSgu3OIGuUo4JVEKebRUW+2Bcre
         bIY8J0h/SpNwBxjC9kUb0r0iMw1mQant8is/YFBB6AIRAfFJQig8QefETFbshCnEjwbG
         88i3SRmcrDrdQAL0Cyyah5wBP2kN65+AYAud2/xPM8Peer9AsHymIKcNUGG2YluE1O6O
         pv/WouSNgLRAEurPskqMEdXq9ea1YgP3BNd5xH9HJOkyzFPKpbsOGWBskhpAbEwN9MNs
         EHZRR/GOa8Fv6eExTZyjkxeoh0jO8B3vnLgiMhf2la9SgUu1Q/jzDvRp7DOj7Yy4G2iB
         UOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092345; x=1757697145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j4B5K2QuSQMfRWCeZrOmBjCMlWlaylCu+OhDi6hAi8=;
        b=I1X7b+dRhX2lihWw1NXJC3hdK0q7bT3KBIHMbntye/7VUdeMKDEIm9pv78IESo2SDo
         pAa6TJkQYIT9pcJkACLMAfTMm4a231Ib4fV3bIQ40ynaJbVxQm3goXvWiv5AV4090ESB
         pbB6c3vm+1skCC7Zcc1NGx66nvmGHj3dHNAOJgMxKPqkkE1WJ8CGFuIwv2YxmjG9c/Sy
         fea0ias46Y0Cu2KeWNoppzngu/CZ/xRhwQ+o/TpFGnSmT0Z1wui5cYNLvVcLI0DPJHO9
         Z8VchpNdDo34c5f1MEKz1gmJrVCeTbusdL+TT0yl/Ts4+C7FyhZg+G6seX9+u/5G1rjq
         ZIUA==
X-Forwarded-Encrypted: i=1; AJvYcCV5eXTZpA/nroBZbz1spyzreLXvF2H5N8k1Dk/g0d1LeOpqtexwqokZsdWq8ewgSGn8YAJsceeEmQE=@vger.kernel.org, AJvYcCXeW1AUxU4yrXJl9fKVStIxdrgFEzrhkulSrujC7vYRcNwA/KcVXDVfYC6xpLw0UEri/m9hHLSmMvXC6OO4wUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwvYxhSHtPEEc6fdtpMSHbJDHuiRWvdSbeKPswhbjbSvQrYrF
	pnnuhWkpI2pBcNb/1zqa/r68ouRhpUEEXJ+ilTy6OUQ9Fsn8M7NnvxDb
X-Gm-Gg: ASbGncuGeLQ18T3BjTI/JcMd3H0r6I7e9rxLE7pqJd0Py9TytGRnL9AC1ZSFICpxFa0
	S2ZGG4w0sTNcbAsc+KEDZP5SHkYF4DyhB9u4K8Kod37ZOPMah1zL722oy+pY52Ixj8afI+YM/bH
	Xi/4RLtGMRdo5V/evdlzzRE4Qx3ABshdbextkG7RAmp3y1mnHWPzN8Ybt5RhUJNmH0MnGfuq0yy
	S8r57Qw97MGWPVrOCGBgh7OKOx2O6oYecmtF7LpmPVNk1VbDETC/ezXJU8DrC50MWy+uBLsJ1BF
	vyGlzNS6fO31mO1iwn7BEHfhr+8WspdhxvTcRPcmVgnEvss+WNPcYQJysPw1xW/ptQh6yt1kT1J
	nzV6AqW/qkAjCf+3kfBejtaEgonqvbRiGyxrvODy7oAvtoPmM4Lwltl31xecgTQ==
X-Google-Smtp-Source: AGHT+IGcYS9IeqzR9eNCU87gKESJCq9FM/d8nWLLxrchfLm0ffaMKy5+HWL1cEp+FhUVLe1hQ3voDg==
X-Received: by 2002:a05:600c:4f89:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-45dd3fb5119mr51923665e9.20.1757092344506;
        Fri, 05 Sep 2025 10:12:24 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e177488999sm6565829f8f.36.2025.09.05.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:12:22 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:12:21 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Sahil Siddiq <sahilcdq0@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 4/4] openrisc: Add jump label support
Message-ID: <aLsZ9S3X0OpKy1RM@antec>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
 <20250904100109.688033-5-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904100109.688033-5-chenmiao.ku@gmail.com>

On Thu, Sep 04, 2025 at 10:00:52AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Supported a complete jump_label implementation based on the ARM64 and
> RV64 version and add the CONFIG_JUMP_LABEL=y to the defconfig.
> 
> Testing was conducted using a dedicated test module (jump-label-test,
> provided in the link below) with the following environment: Below is
> a brief usage and test report of this module. For detailed steps,
> please refer to the README in the provided link.

Maybe you can shorten to:

    Testing was conducted using a dedicated test module jump-label-test,
    provided in the link below. For detailed steps, please refer to the
    README also at the provided link.

> Link: https://github.com/ChenMiaoi/GSoC-2025-Final-Report/tree/main/tests/jump-label-test
> 
> Test Environment:
>   - Hardware: QEMU emulated OR1K
>   - Kernel Version: 6.17.0-rc3-dirty
>   - Configs: CONFIG_MODULES=y,CONFIG_MODULE_UNLOAD=y
>   - Toolchain: or1k-none-linux-musl-gcc 15.1.0
> 
> Test Procedure:
>   1. Build and install modules (make modules_install)
>   2. Build the jump-label-test module
>   3. Boot kernel in QEMU
>   4. Transfer jump_label_test.ko via NFS
>   5. Load module and observe results

The procedure is in the readme, maybe its not needed here.

> Test Results:
> $ insmod jump_label_test.ko
> [   32.590000] Jump label performance test module loaded
> [   35.250000] Normal branch time: 1241327150 ns (124 ns per iteration)
> [   35.250000] Jump label (false) time: 706422700 ns (70 ns per iteration)
> [   35.250000] Jump label (true) time: 708913450 ns (70 ns per iteration)
> $ rmmod jump_label_test.ko
> [   72.210000] Jump label test module unloaded
> 
> The results show approximately 43% improvement in branch performance
> when using jump labels compared to traditional branches.

This is good.

> Link: https://lore.kernel.org/openrisc/aK3O6kOMqgDb6zZj@antec/T/#u
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> 
> ---
> Changes in V4:
>   - Add appropriate comments.
>   - Added testing for jump_label
> 
> Changes in V3:
>   - Ensure the two defconfig using the make savedefconfig.
>   - modify the __ASSEMBLY__ to __ASSEMBLER__, modify the
>     __ASM_JUMP_LABEL_H to __ASM_OPENRISC_JUMP_LABEL_H and remove
>     invalid comment.
> 
> Changes in V2:
>   - using the patch_insn_write(void *addr, u32 insn) not the
>     const void *insn.
>   - add new macro OPENRISC_INSN_NOP in insn-def.h to use.
> 
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/openrisc/Kconfig                         |  2 +
>  arch/openrisc/configs/or1ksim_defconfig       |  1 +
>  arch/openrisc/configs/virt_defconfig          |  1 +
>  arch/openrisc/include/asm/insn-def.h          |  3 +
>  arch/openrisc/include/asm/jump_label.h        | 72 +++++++++++++++++++
>  arch/openrisc/kernel/Makefile                 |  1 +
>  arch/openrisc/kernel/jump_label.c             | 52 ++++++++++++++
>  arch/openrisc/kernel/setup.c                  |  2 +
>  9 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 arch/openrisc/include/asm/jump_label.h
>  create mode 100644 arch/openrisc/kernel/jump_label.c
> 
> diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
> index ccada815569f..683de7c15058 100644
> --- a/Documentation/features/core/jump-labels/arch-support.txt
> +++ b/Documentation/features/core/jump-labels/arch-support.txt
> @@ -17,7 +17,7 @@
>      |  microblaze: | TODO |
>      |        mips: |  ok  |
>      |       nios2: | TODO |
> -    |    openrisc: | TODO |
> +    |    openrisc: |  ok  |
>      |      parisc: |  ok  |
>      |     powerpc: |  ok  |
>      |       riscv: |  ok  |
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index b38fee299bc4..9156635dd264 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -24,6 +24,8 @@ config OPENRISC
>  	select GENERIC_PCI_IOMAP
>  	select GENERIC_IOREMAP
>  	select GENERIC_CPU_DEVICES
> +	select HAVE_ARCH_JUMP_LABEL
> +	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_PCI
>  	select HAVE_UID16
>  	select HAVE_PAGE_SIZE_8KB
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index 58e27d8fdb4e..769705ac24d5 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -10,6 +10,7 @@ CONFIG_EXPERT=y
>  # CONFIG_KALLSYMS is not set
>  CONFIG_BUILTIN_DTB_NAME="or1ksim"
>  CONFIG_HZ_100=y
> +CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  # CONFIG_BLOCK is not set
>  CONFIG_SLUB_TINY=y
> diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
> index 8a581e932766..a93a3e1e4f87 100644
> --- a/arch/openrisc/configs/virt_defconfig
> +++ b/arch/openrisc/configs/virt_defconfig
> @@ -12,6 +12,7 @@ CONFIG_NR_CPUS=8
>  CONFIG_SMP=y
>  CONFIG_HZ_100=y
>  # CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
> +CONFIG_JUMP_LABEL=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
> index e28a9a9604fc..1e0c028a5b95 100644
> --- a/arch/openrisc/include/asm/insn-def.h
> +++ b/arch/openrisc/include/asm/insn-def.h
> @@ -9,4 +9,7 @@
>  /* or1k instructions are always 32 bits. */
>  #define	OPENRISC_INSN_SIZE		4
>  
> +/* or1k nop instruction code */
> +#define OPENRISC_INSN_NOP     0x15000000U
> +
>  #endif /* __ASM_OPENRISC_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/jump_label.h b/arch/openrisc/include/asm/jump_label.h
> new file mode 100644
> index 000000000000..3ec0f4e19f9c
> --- /dev/null
> +++ b/arch/openrisc/include/asm/jump_label.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Chen Miao
> + *
> + * Based on arch/arm/include/asm/jump_label.h
> + */
> +#ifndef __ASM_OPENRISC_JUMP_LABEL_H
> +#define __ASM_OPENRISC_JUMP_LABEL_H
> +
> +#ifndef __ASSEMBLER__
> +
> +#include <linux/types.h>
> +#include <asm/insn-def.h>
> +
> +#define HAVE_JUMP_LABEL_BATCH
> +
> +#define JUMP_LABEL_NOP_SIZE OPENRISC_INSN_SIZE
> +
> +/**
> + * JUMP_TABLE_ENTRY - Create a jump table entry
> + * @key: Jump key identifier (typically a symbol address)
> + * @label: Target label address
> + *
> + * This macro creates a jump table entry in the dedicated kernel section (__jump_table).
> + * Each entry contains the following information:
> + * 		Offset from current instruction to jump instruction (1b - .)
> + * 		Offset from current instruction to target label (label - .)
> + * 		Offset from current instruction to key identifier (key - .)
> + */
> +#define JUMP_TABLE_ENTRY(key, label)			\
> +	".pushsection	__jump_table, \"aw\"	\n\t"	\
> +	".align 	4 			\n\t"	\
> +	".long 		1b - ., " label " - .	\n\t"	\
> +	".long 		" key " - . 		\n\t"	\
> +	".popsection				\n\t"
> +
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	".align		4			\n\t"	\
> +	"1: l.nop				\n\t"	\
> +	"    l.nop				\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +
> +static __always_inline bool arch_static_branch(struct static_key *const key,
> +					       const bool branch)
> +{
> +	asm goto (ARCH_STATIC_BRANCH_ASM("%0", "%l[l_yes]")
> +		  ::"i"(&((char *)key)[branch])::l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
> +#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)		\
> +	".align		4			\n\t"	\
> +	"1: l.j	" label "			\n\t"	\
> +	"    l.nop				\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +
> +static __always_inline bool
> +arch_static_branch_jump(struct static_key *const key, const bool branch)
> +{
> +	asm goto (ARCH_STATIC_BRANCH_JUMP_ASM("%0", "%l[l_yes]")
> +		  ::"i"(&((char *)key)[branch])::l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
> +#endif /* __ASSEMBLER__ */
> +#endif /* __ASM_OPENRISC_JUMP_LABEL_H */
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index f0957ce16d6b..19e0eb94f2eb 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -9,6 +9,7 @@ obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
>  	   traps.o time.o irq.o entry.o ptrace.o signal.o \
>  	   sys_call_table.o unwinder.o cacheinfo.o
>  
> +obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>  obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= module.o
> diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/jump_label.c
> new file mode 100644
> index 000000000000..071dacad885c
> --- /dev/null
> +++ b/arch/openrisc/kernel/jump_label.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Chen Miao
> + *
> + * Based on arch/arm/kernel/jump_label.c
> + */
> +#include <linux/jump_label.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <asm/bug.h>
> +#include <asm/cacheflush.h>
> +#include <asm/text-patching.h>
> +
> +bool arch_jump_label_transform_queue(struct jump_entry *entry,
> +				     enum jump_label_type type)
> +{
> +	void *addr = (void *)jump_entry_code(entry);
> +	u32 insn;
> +
> +	if (type == JUMP_LABEL_JMP) {
> +		long offset;
> +
> +		offset = jump_entry_target(entry) - jump_entry_code(entry);
> +		/*
> +		 * The actual maximum range of the l.j instruction's offset is -134,217,728
> +		 * ~ 134,217,724 (sign 26-bit imm).
> +		 * For the original jump range, we need to right-shift N by 2 to obtain the
> +		 * instruction's offset.
> +		 */
> +		if (unlikely(offset < -134217728 || offset > 134217724)) {
> +			WARN_ON_ONCE(true);
> +		}
> +		/* 26bit imm mask */
> +		offset = (offset >> 2) & 0x03ffffff;
> +
> +		insn = offset;
> +	} else {
> +		insn = OPENRISC_INSN_NOP;
> +	}
> +
> +	if (early_boot_irqs_disabled) {
> +		copy_to_kernel_nofault(addr, &insn, sizeof(insn));
> +	} else {
> +		patch_insn_write(addr, insn);
> +	}
> +	return true;
> +}
> +
> +void arch_jump_label_transform_apply(void)
> +{
> +	kick_all_cpus_sync();
> +}
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index a9fb9cc6779e..000a9cc10e6f 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -249,6 +249,8 @@ void __init setup_arch(char **cmdline_p)
>  		initrd_below_start_ok = 1;
>  	}
>  #endif
> +	/* perform jump_table sorting before paging_init locks down read only memory */
> +	jump_label_init();
>  
>  	/* paging_init() sets up the MMU and marks all pages as reserved */
>  	paging_init();
> -- 
> 2.45.2
> 
