Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC1227563;
	Sat,  9 Aug 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728668; cv=none; b=ux9IMoclvDzAJ0YaU26KMGg4zg/2Dlwu0JtIVshSlSZz2Gsu1qn0GehFltacO7m4azuFS4VsP9vV29XhxYd7Dd4DDpo8XCAEZfpoTOYLLQlPj/3CH2uBNzoj8EuXunzL5RG6Ap81i32wnIlHGrM+VE88yyOOLoDk/s3ICSNS6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728668; c=relaxed/simple;
	bh=OXIu3ZwosSTqSvLAOP5vlqWAG1tlDw0cMqTHNjaIquc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWYMVFphre0VHm2o3MVmxhLyTeTqWyL7/S9WJlby/0zP2nyJlSyE53BefSSMhTsA7wTFzlIHG9C3iwASh4R7qj1dluLgr6dZITobM5QHFAyyeczSoqsVODlEI1d2W6klpcekUrxQfEECbaHlRFym5TauPC4e9L1pu3IoCj9pO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi2NT1Mh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi2NT1Mh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so24378085e9.0;
        Sat, 09 Aug 2025 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754728665; x=1755333465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTOXYj3i7STcpYp00YB8eHyH1DFpV7xQaYk6AtLc3CY=;
        b=Qi2NT1Mh1QeZy7FgIG9gOg7rpsBedFcXDooTVahdHau/43RY1aSjYi0CqJFHKkAEMQ
         0oSmph2CvC2evqW/JUSzD/prprnH7yOnPbXS6Z0K7Z/x2IU1BxNiMSch5HDPZzhp2v4u
         sjnS1Eg1wfFKiUbNPJGy1Yls02IguMQocKCaQiteUg4CuYeFyMC94L7/DeT6BZ3XmQAt
         Qv3o+1Ln1RyYdFSDA+dx1uNHfSowbmaGkokI822NJ5n/qIEvsfiBm9jaMCh6zL5wPzn1
         Eca52FS5iuTdX+BwwrkIb/pqzqxdrPJPMxKE0Qx6g3uU5GiJJp10aocu1cgz9Kh919et
         8E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754728665; x=1755333465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTOXYj3i7STcpYp00YB8eHyH1DFpV7xQaYk6AtLc3CY=;
        b=CPwZPQtJge4Nvci+HFQNe+K6lLnydaizkWLd0OeEafl+Dj/fCkDdjOfMTK6imibAG8
         aT1npZMvppd/t7D8nwBXBT9lh0CbRtGBH2sGwaoD1ZBQPXPM05XWkPvqEbhZpB/ij4Bz
         qVjr9ar4bc4mnZ+RYAVWiaztkB14dsyA80CafZLKOXHocOhIWWlZzgscZWd7YiNuMgRn
         tkehkNsTywSiZ/c4iJx0Ie6XEGnOvuom8DQy2H6pkr/ERgMTAvaygwSVss/yafOSdz0Q
         fBG23TY9IiKh4UoOJLW6THjU2YHU/RNoWODxoRxG9QiNwFITXN574KsJdmoB3RT3MD3m
         32Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU5CAH/wS1Bsytqorke1UbpqkTOey1VkXP3Q+fucT7aVQtrfTkuxXIFaXBLaH/4zWuffKuJem6NUVI=@vger.kernel.org, AJvYcCVFhf13T4LQB+eqFvDwIRciQkPZ/opXzJ8CRsIOG5I07FLVFVbNYKOH9zpUQjE9gCv7E43HzcE5khMaZDmp94E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIF86M9BhsM2rbedFbmLLeUWcN3e7zYmF8B3hfnszrpro3dPV
	YgECX/iLOOyTeAs9VtFOzmgoKnXooydKCJ4tWwjPrdEnRCoaWancjDbOLnWEYugf
X-Gm-Gg: ASbGncslDkyCWRnyx40ur0Cjls7+L54sTAwTq8XhU7lSb4e9urAPFCaHi07HXD3BztC
	ajZ0zIk0nd9oU+JpEuqwLDEDZcx1+a5XXy5oSW25QoirT1diCJA5IWDpjLViRwW9z9oVwP0NljG
	fal9VCq66tHnJPOQ1zEKWC8454EyUWuk7i99RWTs9O30LU0bo7Vjq0+BodUHw19w5yXjiIG6erY
	jsI9WCakzVn5mKiBpNI3fn8fadaNwLjiR/1YxIR8QS8V9ag10jylDK4/Op5dPwr54V/0nVuUkPp
	eDx65+ARzk3+vX86lRaefttaM0+tbKcGXreMqdxQ3CeMcF4TivRkujlEclqkuGFUNOHO6HHUYzN
	UELcaHPhMaP7dzIIa+9+uhxOV78nASAV5p+GfAUQd758kU786TOQGscMNhkP1pQ==
X-Google-Smtp-Source: AGHT+IHRfffAqTyGU55GjuAMX7DVuMqjQINkCU0qbnRn8lMroi61+z8ToMKLzzZY9NYbQvCRtc1Q7Q==
X-Received: by 2002:a05:600c:37cf:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-459f5a9863amr48573915e9.7.1754728664347;
        Sat, 09 Aug 2025 01:37:44 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58553f8sm179973925e9.14.2025.08.09.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:37:43 -0700 (PDT)
Date: Sat, 9 Aug 2025 09:37:42 +0100
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
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] openrisc: Add jump label support
Message-ID: <aJcI1pr9RMTvfcTj@antec>
References: <20250806020520.570988-1-chenmiao.ku@gmail.com>
 <20250806020520.570988-3-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806020520.570988-3-chenmiao.ku@gmail.com>

On Wed, Aug 06, 2025 at 02:05:04AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Implemented the full functionality of jump_label, of course,
> with text patching supported by just one API.
> 
> By the way, add new macro OPENRISC_INSN_NOP in insn-def.h to use.
> 
> - V2: using the patch_insn_write(void *addr, u32 insn) not the
> const void *insn.
> 
> Link: https://lore.kernel.org/openrisc/aJIC8o1WmVHol9RY@antec/T/#t
> 
> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/openrisc/Kconfig                         |  2 +
>  arch/openrisc/configs/or1ksim_defconfig       | 19 ++----
>  arch/openrisc/configs/virt_defconfig          |  1 +
>  arch/openrisc/include/asm/insn-def.h          |  3 +
>  arch/openrisc/include/asm/jump_label.h        | 68 +++++++++++++++++++
>  arch/openrisc/kernel/Makefile                 |  1 +
>  arch/openrisc/kernel/jump_label.c             | 53 +++++++++++++++
>  arch/openrisc/kernel/setup.c                  |  2 +
>  9 files changed, 138 insertions(+), 13 deletions(-)
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
> index c1b69166c500..4a80c5794877 100644
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

The defconfig updates look quite different.  Did you use savedefconfig for both
of them?

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

I see you use this header again here, note that in
arch/openrisc/kernel/signal.c.  We write instructions to memory too for the
sigreturn trampoline.

Also, you use OPENRISC_INSN_SIZE below.  Could you move this header to this
patch completely?  I don't think its needed in the patching patch.

>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/jump_label.h b/arch/openrisc/include/asm/jump_label.h
> new file mode 100644
> index 000000000000..03afca9c3a1f
> --- /dev/null
> +++ b/arch/openrisc/include/asm/jump_label.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Chen Miao
> + *
> + * Based on arch/arm/include/asm/jump_label.h
> + */
> +#ifndef __ASM_JUMP_LABEL_H
> +#define __ASM_JUMP_LABEL_H

Can this be __ASM_OPENRISC_JUMP_LABEL_H?

> +#ifndef __ASSEMBLY__

Note upstream this is now __ASSEMBLER__.

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
> +#endif /* __ASSEMBLY__ */
> +#endif /* __ASM_JUMP_LABEL_H */
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
> index 000000000000..ce259ba30258
> --- /dev/null
> +++ b/arch/openrisc/kernel/jump_label.c
> @@ -0,0 +1,53 @@
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
> +	// flush

Could you use the /* */ comment style?  Is this really flushing?

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
