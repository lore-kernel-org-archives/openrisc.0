Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956A1E522;
	Tue, 26 Aug 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221168; cv=none; b=Zyd8zHxp8BZDAGm66MW0viOSxLwfMCeEHwd0Xxs9gJOAjjM09BYgvMazbcD1S2Ek1aWzBXWwaWCIBR103aZphHYdSAyym5NGYmXifF7eIeu46889ed1/nKsB/4BcvrCFNRqhDa3F5FSCgOvzIEFuerZlZTT3P0l2SuloM3fu/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221168; c=relaxed/simple;
	bh=poE2bSlhrsZ48YhrGNd+qqoTNdamNKV99qDxtacTcEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muNZfvbEynIvTZ2jvCF1TD1KxG/JLhrJWmIAHZVe0JKWOH0fEAuQc6d5M18DeTHlsVKmmgM9JdgxRr84d0SjfWIuUMPpvYN/oFzy7hAhJOC4lC7PCvTfkNBydPHP8xoxqoc3SCDHguR7UOkFfjpVy1QLdligP7K+NVfKDbscf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY8JdY/H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY8JdY/H"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so36378565e9.1;
        Tue, 26 Aug 2025 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756221164; x=1756825964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONmbW5esqMOez0fXy4tVMfg0Y/iOt+VR1S+OBbiVslc=;
        b=KY8JdY/HMUfhzwItATF6t/ES0ywtsSZ+wAysYCbZNlgGqgILPBo/6JmVkSTZ5fH6jP
         R+eVChlqmlk0bLb3369M+rhzBH3pU9yTaNC4OzKpHWXqc2Wz3dEvWKdJgS51brck9Unc
         yStxDQJBW7aaBCohhRm4FCuSuOPgZ91TT44FMedjZpOiM4CvwZIxH5KbPRqcgPemnIvb
         LZM2lMtK573KhrZ+SyP33S3p4odq+ggC2anZLhgM4vhaXiuInhe82SVjxWgZ8yzCN41u
         VVBg+kMCyWBQt76FLLOxPLqTCv/Eve3YdUHGVbtohksfCGF8PmAuEWHF41Lb138i6Bjz
         38Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756221164; x=1756825964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONmbW5esqMOez0fXy4tVMfg0Y/iOt+VR1S+OBbiVslc=;
        b=syjZTt8eAstdqSkWjnI1gRoCFyW5wN0zjc4jb0q5AFjvEHpvv/D+Do0ye1xqlvWHKP
         eVT7toQZmdVmPWw3CJ8mvuIiVf6j1dn3qIZVYDv3nF1WKASLfSOK4a6E/JRGM12dp6mG
         p9PVNZQyIFAAcMXbhrRSiSlmqE9flOeAYs8lDfdFp+fl7TKxowaBezfKxYbekjFNT3Za
         iAG0zBFYyKXX5Aiw8ZlBpe/5FWXO1IbCv6y0eEQvvchl+kGbjinesbTs1JYMRwkNyAp/
         NODP3GnVylrYgc5kVIb/0xvEEw16xI2ZnmryFa8/wyuyu9xbshpSl+YY2OdRh6LjxcdD
         ua0w==
X-Forwarded-Encrypted: i=1; AJvYcCVmTReFgcc+b3ndLiSD1SFCSCMO+3SEkTKpOikQQxiep9WEPpfqDXxP80KJiKJzZMI7fJhxwlVC5v4=@vger.kernel.org, AJvYcCWg394pknq+DANZgldw5bAbXKUnP+PcROR/M2Ti3/fKROi+XWKiJSrkJVA8fGhmMOs2Bl1K3aEnKbTAGjsgMGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/MZHZATn810fvJYgHp5MVvq/Epots5SYLaJiiuTWojiD5x4M
	GwDFFiJhsJmxCeYIkGq3zVcke1pP4N1vVcx4dR7DjVfERX26cz7KNClfUGQVmd42
X-Gm-Gg: ASbGncsi4+fOzMCQomOe1dVM3r/YkwzFHtDbA/qXA59l9xL5Cq0ZXWUo7jOPv9Mn1Dw
	blkPsNHJot/OUgIFStbvc1PiL9fucSc0e31zDJBktJkIq7cgNwC5f0veLlKDwLMl4lPTJTU/em0
	B6kUyOC8U3be2Sa5KEihDkH67b84TxAKXW704ikMFSXqNuwdUOCHwm0Ukcw+RtD/n1/EmGbfWCv
	NRTaanUlTTY4iQmeAy+L63qlMTGpzdlFMEzC03xpOJKDD1boQdn4Gk4mckovbVNiEf7Rqxoj8DQ
	X5K7Q9F2AQA/dGQFwN443IFjhavlRWjqnS5I2qQL4lyqpMfKw2NJsIiDVe9NgshNuPkN+rp4/z0
	LbgZwFz2Len5AlolfB1Y4Q0JQ9ZAtzUasiQkRf12xo2EixTHq4/sOirZF08MohOzYt0uhhXhB
X-Google-Smtp-Source: AGHT+IGhN4oHbHy//ACajEZKQOIiPiwcrun+5fF5awcgDHHwxh0hLQa5tka7vmRiauTyYXDSv4qenQ==
X-Received: by 2002:a05:600c:609b:b0:458:a7b6:c683 with SMTP id 5b1f17b1804b1-45b541d1026mr134336525e9.1.1756221164109;
        Tue, 26 Aug 2025 08:12:44 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57589c42sm154269435e9.17.2025.08.26.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:12:43 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:12:42 +0100
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
Subject: Re: [PATCH v3 2/2] openrisc: Add jump label support
Message-ID: <aK3O6kOMqgDb6zZj@antec>
References: <20250814032717.785395-1-chenmiao.ku@gmail.com>
 <20250814032717.785395-3-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814032717.785395-3-chenmiao.ku@gmail.com>

On Thu, Aug 14, 2025 at 03:27:02AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Implemented the full functionality of jump_label, of course,
> with text patching supported by just one API.

I am not sure the second part of the statement is relevant.  Perhaps we can
mention that we use relative labels.

Do you have any details about how this improves performance?

How have you tested this?

We should try to measure boot time or various syscalls or scheduling operations.
I would like to get some numbers before we queue this for upstream.  I may do
myself as I think its beneficial.

Other than that I think this is ok, one small comment below.

> Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t
> 
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> 
> ---
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
>  arch/openrisc/configs/or1ksim_defconfig       | 19 ++----
>  arch/openrisc/configs/virt_defconfig          |  2 +-
>  arch/openrisc/include/asm/insn-def.h          |  3 +
>  arch/openrisc/include/asm/jump_label.h        | 68 +++++++++++++++++++
>  arch/openrisc/kernel/Makefile                 |  1 +
>  arch/openrisc/kernel/jump_label.c             | 52 ++++++++++++++
>  arch/openrisc/kernel/setup.c                  |  2 +
>  9 files changed, 137 insertions(+), 14 deletions(-)
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
> index 59fe33cefba2..769705ac24d5 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -3,26 +3,23 @@ CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_RD_GZIP is not set
>  CONFIG_EXPERT=y
> -# CONFIG_KALLSYMS is not set
>  # CONFIG_EPOLL is not set
>  # CONFIG_TIMERFD is not set
>  # CONFIG_EVENTFD is not set
>  # CONFIG_AIO is not set
> -# CONFIG_VM_EVENT_COUNTERS is not set
> -# CONFIG_COMPAT_BRK is not set
> -CONFIG_SLUB=y
> -CONFIG_SLUB_TINY=y
> -CONFIG_MODULES=y
> -# CONFIG_BLOCK is not set
> +# CONFIG_KALLSYMS is not set
>  CONFIG_BUILTIN_DTB_NAME="or1ksim"
>  CONFIG_HZ_100=y
> +CONFIG_JUMP_LABEL=y
> +CONFIG_MODULES=y
> +# CONFIG_BLOCK is not set
> +CONFIG_SLUB_TINY=y
> +# CONFIG_COMPAT_BRK is not set
> +# CONFIG_VM_EVENT_COUNTERS is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
>  CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set
> @@ -35,7 +32,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
> -CONFIG_PROC_DEVICETREE=y
>  CONFIG_NETDEVICES=y
>  CONFIG_ETHOC=y
>  CONFIG_MICREL_PHY=y
> @@ -53,4 +49,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_DNOTIFY is not set
>  CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
> diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
> index c1b69166c500..a93a3e1e4f87 100644
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
> @@ -55,7 +56,6 @@ CONFIG_DRM=y
>  # CONFIG_DRM_FBDEV_EMULATION is not set
>  CONFIG_DRM_VIRTIO_GPU=y
>  CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>  CONFIG_LOGO=y
> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
> index dc8d16db1579..2ccdbb37c27c 100644
> --- a/arch/openrisc/include/asm/insn-def.h
> +++ b/arch/openrisc/include/asm/insn-def.h
> @@ -9,4 +9,7 @@
>  /* or1k instructions are always 32 bits. */
>  #define	OPENRISC_INSN_SIZE		4
>  
> +/* or1k nop instruction code */
> +#define OPENRISC_INSN_NOP     0x15000000U
> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/jump_label.h b/arch/openrisc/include/asm/jump_label.h
> new file mode 100644
> index 000000000000..28dd6c78f8ce
> --- /dev/null
> +++ b/arch/openrisc/include/asm/jump_label.h
> @@ -0,0 +1,68 @@
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
> +/*
> + * should aligned 4
> + * for jump_label relative
> + * entry.code   = nop.addr - . -> return false
> + * entry.target = l_yes - .    -> return true
> + * entry.key	= key - .
> + */

Perhaps this comment could be expanded a bit?

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
