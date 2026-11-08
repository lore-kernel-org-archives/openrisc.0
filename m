Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794124694;
	b=ybtD3Ra/fRY8OtSGIqchnprXmd35eHr/pJwnaRRqXNzuxtqTJ8zY4u/Ie0XZvGEm/eXo
	 9LhaSnmxdm9p83dRoRI1N30jQdaStb3YSVycQpY9W6+U/tc3XTq3Hi+jEPBfcDXDpH1S8
	 hLHQQNcvwindHnXmrW5GbelKAYAPBElu674spPQgFdzkfX7ESw0FYaRsklmBxu/8/JRgH
	 EAxhl62eoqf1z1HPcQfxnAfNOWXA1NLfraea0Ycnl+JJ/A8LWXCl6JFhpeNMbqYMLYVgF
	 3JU8QBeUpODT61ZyQCun1sTvtQLBdm4hWocEGdqIrQRH16uVqAR9d6Mm/6wbePiHlpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794124694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MxlVXrp6rlOPl7F6z/PePk753r6QIMo4ZGdlX0mzQgY=;
	b=Xejw5h8E6fT7Gd3pRwUsHWFffJzLO6OTiOjXumr8hddVxjJkCEXNX2+TzOEMNWaL8+1n
	 DVH8OYTG1ZbFfwYGHsv51/rNbkq8AZVx6aJ9ES9FVNbSHYcPEpqayKtiUzeg1upSjRzUo
	 hneLVQanLMdP5rxkqqPqLUThvkG0PVoiokq/zi3H/pxp4BkmvegMlm8z2DVu/lSBdfLRl
	 bj7V9/AoQ9TtQu2WFrxuAZXjuVzilpRRXIfCBUKdDnNEmSzgNsK6mjHFfE0pDx0trSREF
	 9wJ/Wq7wyNFts3m2p6zGnvVXzQVOvOCog6mpfcvPJ9qfn8bGnTtvHAyHdZRsrLZT5DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="d/D0VLJo";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DA606A323
	for <linux-openrisc@vger.kernel.org>; Sun,  8 Nov 2026 07:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795DA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/D0VLJo
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so195715f8f.1
        for <linux-openrisc@vger.kernel.org>; Sat, 07 Nov 2026 23:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794124692; x=1794729492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MxlVXrp6rlOPl7F6z/PePk753r6QIMo4ZGdlX0mzQgY=;
        b=d/D0VLJotg4qrzbZoi23OlLMY9CkzcHSQ9zbQJaGcaeL6tBoozZi4l+KQtVcckRoc+
         l6LNPyQum/KASsPE+flmFY755tb4OkB6dYSPRVVZMTYrDwfef6jPzrQsJ3I5conwO2Gk
         C83KJ1pRBBrmYC5I5JxqT0/XBPFbYuYv+syfetAiWt5+ELBJcJ4oklBsokzhHV+Z/1vl
         nR/iJxco0OX7X7NNAF4nbyfmgPFFpTgv+zhKfoD4ISPihr1BHA9uDBZoeU+iY+lSwXGA
         DQi48yfwWe6CNhbUpDgTGhQYFG3olYNeyKAVg40MeMhR6aq+qQH8jQDNuMhsQd6SnPB3
         Irbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794124692; x=1794729492;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MxlVXrp6rlOPl7F6z/PePk753r6QIMo4ZGdlX0mzQgY=;
        b=QZ5X89LXqCC4LzxUxhXu0hexDdIGmKbd/ACZkbcc3uq2Fdqb+4lCfRUXKHOoFMen7n
         R4lANNkBFthjicfXkw40BOL4VbBEVJmWda2pyDJtuKzMJUv74yRMx/p/p2nsEMTbRYoX
         7LR/HSjfnvYoLL5x5LDzOAZC4Y+Dyjghk5nGP1iyvj2yyHtkxkw4VkL1qSJTFuSLPgmk
         y8fR9i5E5J49UEi56DES01dqrbEF//DuGuoAH61pM3s9He1Djd8j3c9a+HRGOuyj+5ZR
         WA81bGSe2t2PhuBZ1eDpZ7Nd7l1FfUqj0pkQ4DfDkDgD8V5du9w/iZnwhKm0PL0805xY
         NL3A==
X-Forwarded-Encrypted: i=1; AL+hErEa5YUWCAkBL7YuUcLTWPn3rNrOqGiVj8x58bWw2VqOp/yiU8QMcKF10jKu0nWvkA9UQ8Uj1V5Iq0gZWIf/5A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9tqI50n/tIlav7QbMUaexypNLQYRq4NkTc8UGkF3eUBA14XZkN
	UpuR1b+HgBn+kfSChPe5e+iep+q+guEq9lBSiRyerYOjer4kRF3NLb12
X-Gm-Gg: AYBFou0VWCrEstwYpd0NwYsdDmeUMcpKIydr4PTqLQy7Vz0anRjOROxU3bo8Vfdjbf7
	AD/szbGDCoZBMqV1xX4sBdyPiIB5CmBIc+Oywi/c/nBWAKEmkfCbYOgXirdssHHSyRETozMBW/9
	Y3sYHH3tXMvqt/WK70z5iQU9eOg0WMRF1rIydst8dv17qioNGcvYEizrBdePZ8f1RWQ2DzlZd6Y
	P5j+QhwPgaaaorhnLRH3psQWFhJjgBi/1TmDl4fGdtxc735xnZw8TmM0SLlhdlkjtKXywf7zUtT
	1Q8wd1geLviYX0khVdQqkiwJAnWFf7SBC+k25trG6TB4lsXsTXnZktLB7WA5TJGJmCeYLiaP6lC
	XKRl970oTR/wqXoIQ5nDzo2CVmT6GXG0zapXmpks4AoD75aMe7y6yhC4OFg6Utf/IBJvmfs8rja
	tmMSqUOs7pMVhant4BudI3yB/SHvEWSGH+Qg84+Hw9HZIx/dRZA/luUNURfBHM1N69Jz0CblIch
	cEcp6sK4gbDJ6gwXvV7aA4jAD390sRRtj5FEop/Harz+H7yo5aCcCuHFX9+09c6bdFencdQtcJs
	oJF2PjlNzEDbThVXTAmG/tqFf/qTpqjsH+AuG0xY/L8i7RkX33ERCgNolJh5sqcTPeyVUMCTgWK
	LXCWNhA==
X-Received: by 2002:a05:6000:2388:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-4958d021480mr1459790f8f.52.1794124691575;
        Sat, 07 Nov 2026 23:58:11 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186eb9sm2616918f8f.35.2026.11.07.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:58:11 -0800 (PST)
Date: Sun, 8 Nov 2026 07:58:10 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
	kees@kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] openrisc: Add Kretprobes
Message-ID: <avArkiSOmUfSrmYF@antec>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-5-sahilcdq0@gmail.com>
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026201240.107462-5-sahilcdq0@gmail.com>

On Tue, Oct 27, 2026 at 01:42:40AM +0530, Sahil Siddiq wrote:
> Add Kretprobes support for OpenRISC. Kretprobes allow a probe to be
> fired when a function returns. They are built on top of the generic
> rethook framework and also require the KProbe mechanism introduced
> in the previous commit. This work is primarily based on similar work
> done for RISC-V.
> 
> Kretprobes work by inserting a KProbe at a function's entry point.
> When the function begins to execute, the KProbe is fired and its
> pre-handler replaces the function's return address with that of the
> rethook trampoline. The trampoline in turn calls the kretprobe handler.
> Control is returned to the original caller following this.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> ---
> Changes v2 -> v3:
> - arch/openrisc/kernel/rethook_trampoline.S:
>   (save_all_base_regs): Save SR and SP registers
>   (restore_all_base_regs): Restore SR register
> 
> Changes v1 -> v2: New commit
> 
>  arch/openrisc/Kconfig                     |   2 +
>  arch/openrisc/kernel/Makefile             |   1 +
>  arch/openrisc/kernel/rethook.c            |  32 +++++++
>  arch/openrisc/kernel/rethook.h            |   8 ++
>  arch/openrisc/kernel/rethook_trampoline.S | 111 ++++++++++++++++++++++
>  5 files changed, 154 insertions(+)
>  create mode 100644 arch/openrisc/kernel/rethook.c
>  create mode 100644 arch/openrisc/kernel/rethook.h
>  create mode 100644 arch/openrisc/kernel/rethook_trampoline.S
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index d240533b424b..82365eb8f574 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -28,6 +28,8 @@ config OPENRISC
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_PCI
>  	select HAVE_KPROBES
> +	select HAVE_KRETPROBES
> +	select HAVE_RETHOOK
>  	select HAVE_UID16
>  	select HAVE_PAGE_SIZE_8KB
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 0c1cade09e0c..e36537cea319 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_OF)		+= prom.o
>  obj-$(CONFIG_KPROBES)		+= kprobes.o
> +obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
>  obj-$(CONFIG_OR_KPROBES_KUNIT)	+= tests/
>  obj-y	+= patching.o
>  
> diff --git a/arch/openrisc/kernel/rethook.c b/arch/openrisc/kernel/rethook.c
> new file mode 100644
> index 000000000000..50ef6715d044
> --- /dev/null
> +++ b/arch/openrisc/kernel/rethook.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Generic return hook for OpenRISC. Depends on KProbes.
> + *
> + * Linux architectural port borrowing liberally from similar works of
> + * others.  All original copyrights apply as per the original source
> + * declaration.
> + *
> + * OpenRISC implementation:
> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +#include "rethook.h"
> +
> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
> +{
> +	return rethook_trampoline_handler(regs, regs->gpr2);
> +}
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback)
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> +{
> +	/* Store original return address and frame pointer */
> +	rhn->ret_addr = regs->gpr9;
> +	rhn->frame = regs->gpr2;
> +
> +	/* Set return address to trampoline */
> +	regs->gpr9 = (unsigned long)arch_rethook_trampoline;

Though this will work, in the kernel code we prefer to regs->gpr[n] syntax
for accessing gprs.  So to be consistent could you use that?  i.e. regs->gpr[9];

> +}
> +NOKPROBE_SYMBOL(arch_rethook_prepare)
> diff --git a/arch/openrisc/kernel/rethook.h b/arch/openrisc/kernel/rethook.h
> new file mode 100644
> index 000000000000..332306a5c380
> --- /dev/null
> +++ b/arch/openrisc/kernel/rethook.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __OPENRISC_RETHOOK_H
> +#define __OPENRISC_RETHOOK_H
> +
> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
> +
> +#endif
> diff --git a/arch/openrisc/kernel/rethook_trampoline.S b/arch/openrisc/kernel/rethook_trampoline.S
> new file mode 100644
> index 000000000000..5e8fd5a65222
> --- /dev/null
> +++ b/arch/openrisc/kernel/rethook_trampoline.S
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Author: Sahil Siddiq <sahilcdq0@gmail.com>
> + */
> +
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/ptrace.h>
> +
> +	.text
> +
> +	.macro save_all_base_regs
> +	l.sw	PT_GPR2(r1),r2
> +	l.sw	PT_GPR3(r1),r3
> +	l.sw	PT_GPR4(r1),r4
> +	l.sw	PT_GPR5(r1),r5
> +	l.sw	PT_GPR6(r1),r6
> +	l.sw	PT_GPR7(r1),r7
> +	l.sw	PT_GPR8(r1),r8
> +	l.sw	PT_GPR9(r1),r9
> +	l.sw	PT_GPR10(r1),r10
> +	l.sw	PT_GPR11(r1),r11
> +	l.sw	PT_GPR12(r1),r12
> +	l.sw	PT_GPR13(r1),r13
> +	l.sw	PT_GPR14(r1),r14
> +	l.sw	PT_GPR15(r1),r15
> +	l.sw	PT_GPR16(r1),r16
> +	l.sw	PT_GPR17(r1),r17
> +	l.sw	PT_GPR18(r1),r18
> +	l.sw	PT_GPR19(r1),r19
> +	l.sw	PT_GPR20(r1),r20
> +	l.sw	PT_GPR21(r1),r21
> +	l.sw	PT_GPR22(r1),r22
> +	l.sw	PT_GPR23(r1),r23
> +	l.sw	PT_GPR24(r1),r24
> +	l.sw	PT_GPR25(r1),r25
> +	l.sw	PT_GPR26(r1),r26
> +	l.sw	PT_GPR27(r1),r27
> +	l.sw	PT_GPR28(r1),r28
> +	l.sw	PT_GPR29(r1),r29
> +	l.sw	PT_GPR30(r1),r30
> +	l.sw	PT_GPR31(r1),r31
> +	/* Save SR in pt_regs */
> +	l.mfspr	r13,r0,SPR_SR
> +	l.sw	PT_SR(r1),r13
> +	/* Save SP in pt_regs as it was prior to setting up this frame */
> +	l.addi	r13,r1,PT_SIZE
> +	l.sw	PT_SP(r1),r13
> +	.endm
> +
> +	.macro restore_all_base_regs
> +	/* Restore SR from pt_regs */
> +	l.lwz	r13,PT_SR(r1)
> +	l.mtspr	r0,r13,SPR_SR
> +	/*
> +	 * r1 doesn't need to be explicitly restored from pt_regs. When
> +	 * arch_rethook_trampoline_callback finishes, it restores SP to
> +	 * what it was before its frame was set up.
> +	 */
> +	l.lwz	r2,PT_GPR2(r1)
> +	l.lwz	r3,PT_GPR3(r1)
> +	l.lwz	r4,PT_GPR4(r1)
> +	l.lwz	r5,PT_GPR5(r1)
> +	l.lwz	r6,PT_GPR6(r1)
> +	l.lwz	r7,PT_GPR7(r1)
> +	l.lwz	r8,PT_GPR8(r1)
> +	/* Return address in r9 is stale, so don't restore it */
> +	l.lwz	r10,PT_GPR10(r1)
> +	l.lwz	r11,PT_GPR11(r1)
> +	l.lwz	r12,PT_GPR12(r1)
> +	l.lwz	r13,PT_GPR13(r1)
> +	l.lwz	r14,PT_GPR14(r1)
> +	l.lwz	r15,PT_GPR15(r1)
> +	l.lwz	r16,PT_GPR16(r1)
> +	l.lwz	r17,PT_GPR17(r1)
> +	l.lwz	r18,PT_GPR18(r1)
> +	l.lwz	r19,PT_GPR19(r1)
> +	l.lwz	r20,PT_GPR20(r1)
> +	l.lwz	r21,PT_GPR21(r1)
> +	l.lwz	r22,PT_GPR22(r1)
> +	l.lwz	r23,PT_GPR23(r1)
> +	l.lwz	r24,PT_GPR24(r1)
> +	l.lwz	r25,PT_GPR25(r1)
> +	l.lwz	r26,PT_GPR26(r1)
> +	l.lwz	r27,PT_GPR27(r1)
> +	l.lwz	r28,PT_GPR28(r1)
> +	l.lwz	r29,PT_GPR29(r1)
> +	l.lwz	r30,PT_GPR30(r1)
> +	l.lwz	r31,PT_GPR31(r1)
> +	.endm
> +
> +SYM_CODE_START(arch_rethook_trampoline)
> +	/* Allocate enough space on stack for pt_regs */
> +	l.addi	r1,r1,-PT_SIZE
> +	save_all_base_regs
> +
> +	l.addi	r3,r1,0	/* pt_regs */
> +	l.jal	arch_rethook_trampoline_callback
> +	l.nop

Could you indent the delay slot? For example:

	l.jal	...
	 l.nop

> +
> +	/* use the result as the return-address */
> +	l.addi	r9,r11,0
> +
> +	restore_all_base_regs
> +	l.addi	r1,r1,PT_SIZE
> +
> +	l.jr	r9
> +	l.nop

Indent here too.

> +SYM_CODE_END(arch_rethook_trampoline)

Thanks,

-Stafford
