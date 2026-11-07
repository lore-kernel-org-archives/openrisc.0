Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033909;
	b=I5KS9fkYTo5Ge9hn6waes/MrwoffyShBbyTu09WOUojVX5qzoJwyd7VeHU9mf0Vmjlx9
	 s8IRmcXUwSYGw89+SJeURhJmW8g10bdpyW8EiJDfjR8W0Umri0mkyB7aUlOt1KLc4FYSl
	 qkplQzCebrWf77g23id3v8L2hJYhmXqGW9787Da2pUjAD7cgr9asN0QQgMz2uyCw8Vwpq
	 ez8AgVsyjsjzugVKtvVEjF97CNc1tzhswlZUnMOBaVMZcIOxNTmtLQ/7Hjcu1i4x4Q1QL
	 cCKx6JEO+VYvmzMMoyjsoE/hoNOiac8GbaRZ8AVbHi076UmmXH8jKATCFXhCFeIUfFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cqqyCthw7hnNA2GM5wIPdFu2kROxCR9BdN9ixgyq1o4=;
	b=Cce4RV+K7hO8t7ZwwjbsGbPUoG8/x5JG40jzKeglYnQd5ZA6VjinZLmFhX+1adHH/tDs
	 iL2k/0G/PoK9FkxVzYfLY4DHnAWKs7JMUfuq2fz3lKSjxrogp+xo8UbPloHY2Qxi/izcp
	 1QEK+MeuvPSfGbXSUlJe5B7w3o3MluLbtY74mDUsb7q2vPrlmwoMhAdaosgQRYQ623HDW
	 Hi3SzsfUiE1dwEA0o833VEzKirID2ChE9VVif7DoSCl9PP6IXuffT0nrCsYRqkXlDkEup
	 Mhszmuu/a63j/bqWANKkkx5LRuhSy3hCNgsJCvZElTxZjCX6E8AZCFbdpcrCTNxHvhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stoXERb1;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787E606A32E
	for <linux-openrisc@vger.kernel.org>; Sat,  7 Nov 2026 06:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8787E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stoXERb1
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso14579885e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 06 Nov 2026 22:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033907; x=1794638707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cqqyCthw7hnNA2GM5wIPdFu2kROxCR9BdN9ixgyq1o4=;
        b=stoXERb1Ipzneh3Zt82lYuEC3zww6a80LG6sWCvedRJ5zkjeCFNo+Coq+eu+3lXuY7
         RRHKnHT1b5zLx70sfvwbZV3Zh1D5uQA/EV2Bfc15nvbojQ9iGL8QQS4Ob9MF19tevS/o
         DJEZa3RUXNjR/AiwhjiLe2CTtyWgCdtL0JyGdegfBJL45Kw3FW22Mwrs2X0u+Mfm8lvQ
         +ik11qxsn0qxu+dUYZyeOVKaJslYQKSGfckmEhzqa2NXEHIx7rJYsC1Qe3XOPj2jRi/R
         L/4wc6fmIo2WGbLyHj2vvW56TsLCwb6GfhGBhJ23uYpaYaDkCmygc/7shF9d43l0R307
         HgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033907; x=1794638707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqqyCthw7hnNA2GM5wIPdFu2kROxCR9BdN9ixgyq1o4=;
        b=pwpsk6qyFlF1f0CB6+CAcqDDvQopRIrlby8lS4lCyio1/+f6nXYwGKRPwuwbE3u49/
         B51u+hK1U35s7ZC8ni6Rms3GS2LPdCoz/COx5tRg9xvj/ZQjUR4GM0uavKxWZFRC8h0i
         6ci3f4Qa/09A3Jtwxjcu1ZFPP4dgnC/IhRoA9yPZ6VtuWyD52u3Rstg3QDzFCG/cPpuf
         dvGEyy/1lzWD8hslBfLq4lDT2QmE31mC3NEX4CqlqKS40W8eKaBYFhuQjftN9UAZIUxj
         JsgzoCya9O+ilRomy/8cOohyW9iyRKJ3aKmf5b52Oc2u2fzFRbV9LZmY3p6COg/Zkr6j
         lQXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvtjZNjFYqPAV97flt3g9qhosm0dxPwMgIv0c9K+zjz0DLOGQzxPA9050661r4NrEmmCMW27Y51csKjEmFzw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/R7CMx+5oULNBatcFOe+Awik3pv/p3dp4jE1VmG591Vjxf2NS0
	mkTb7fvTDuEI13Z0UI5r1a1DxhnOgcpgpOs1ai+y9KNQHy4XikIj/TNf
X-Gm-Gg: AYBFou1JXQiLDsHLBFt3HD79/z7znh3drc5CyXzcN3+E/IK+0xVtPwLcWywLfUj+3TD
	ANomsmT2EI2kNw+t+9jNuu6IFdDIfKNC1O2P7OGvsu9N5gRxrGLLPxghGjhMotrZGjnqjb5BkOX
	+7goAT1+bWU7vv1OayMDM0En+ZSITDQONNAdwo6cwtiKXty65LqC2Su905AS9FEc4dEcx0dNGtt
	LLw2YHHLNlQaB9jCWq6TT29os0YP9Tr/RvFkOhN66DxXAQ1vkzQ9J4/g3mgNM7A7aM7mX9jqeDH
	O2iyWYCti0Iy6IRFvo24/p6hgTzsBvsDjpze9UfpcwJBrTunKoWca1Es4b2e4MsVsv/ZZlnoQ+4
	636TT1VnNaPU7+/ZRvj4jF37c3m43NkKbcqhMTat4YFK5T0PjY73rFKqEH7Snt7nZ4pHCbY+1WP
	lmYIA9aBwgK2ktYPt1OjIBW28RRqNeTfOpTeAPTZ6J/51wx6+s+k8bJ5Cl2gIgT8nZQ0jEejSmn
	ZJY0tS2UgeZ3bOKAlRt5c6FJyNFmhroO7nxWxAJ3TO/322y+HysRvY2GAEbqCJoM5AOYY4oLPpV
	dU9Dyy0TvuJ9SRQyDPVGOektQFKpGxJdgmag7FqNeIsXJri39C1BMZ+p3+p/a/81Z3nwdmSSH0f
	edjlaUA==
X-Received: by 2002:a05:600c:4f13:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4b6de1c645dmr86817705e9.20.1794033906551;
        Fri, 06 Nov 2026 22:45:06 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d6085asm11009570f8f.3.2026.11.06.22.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:45:05 -0800 (PST)
Date: Sat, 7 Nov 2026 06:45:04 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
	kees@kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] openrisc: Add utilities and clean up simulation
 of instructions
Message-ID: <au7I8FNoMcsoh54X@antec>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-2-sahilcdq0@gmail.com>
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
In-Reply-To: <20261026201240.107462-2-sahilcdq0@gmail.com>

Hi Sahil,

Thanks for your patches, sorry its taken me time to get around to them, my year
since summer has been quite hectic.

I will do the review in chunks so give me some time.

On Tue, Oct 27, 2026 at 01:42:37AM +0530, Sahil Siddiq wrote:
> Introduce new instruction-related utilities and macros for OpenRISC.
> This is in preparation for patches that add tracing support such as
> KProbes and Kretprobes.
> 
> Currently, PC is first updated and then saved in the link register
> (r9) when simulating l.jal and l.jalr. This can result in a corrupted
> page table (bad page map in process). Fix this by saving PC in r9
> before updating it.
> 
> Move branch simulation to its own function, simulate_branch(), so it
> can be reused. It's already being used by do_illegal_instruction().
> It'll also be used by KProbes in the following commit.
> 
> Introduce simulate_pc() to simulate l.adrp. KProbes will require this
> instruction to be simulated as well. simulate_branch() and simulate_pc()
> need to be handled differently since branch instructions change the
> value of PC while l.adrp depends on PC but doesn't change its value.
> 
> Use a static key to check if delay slots are disabled. Delay slots are
> a part of the CPU's configuration and won't change at runtime. Since
> they are often enabled in an OpenRISC CPU, using a static key will
> reduce the overhead of checking this flag in the default case while
> processing KProbes inserted at branch instructions and simulating them.
> 
> Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> ---
> Changes v2 -> v3:
> - arch/openrisc/kernel/insn.c:
>   - (simulate_pc):
>     Handle case when rd=0
>     Add function to KProbe blacklist
>   - (simulate_branch): Likewise
> - arch/openrisc/kernel/setup.c:
>   - (setup_arch): Set static key before calling paging_init()
> - arch/openrisc/kernel/traps.c:
>   - (do_trap): Move handling of Kprobes in commit #2
> 
> Changes v1 -> v2:
> - arch/openrisc/include/asm/cpuinfo.h: Introduce "delay_slot" static key
> - arch/openrisc/include/asm/insn-def.h:
>    - Use macros instead of union
>    - Use better names for macros
>    - Use genmask() for masks
> - arch/openrisc/kernel/insn.c:
>    - Use macros instead of magic values
>    - (simulate_pc): Update PC
>    - (simulate_branch): Handle rb=r9 in l.jalr simulation
> - arch/openrisc/kernel/setup.c: Use "delay slot" static key
> - arch/openrisc/kernel/traps.c: Use macros instead of magic values
> 
>  arch/openrisc/include/asm/cpuinfo.h  |  3 +
>  arch/openrisc/include/asm/insn-def.h | 58 ++++++++++++++++--
>  arch/openrisc/include/asm/spr_defs.h |  1 +
>  arch/openrisc/kernel/Makefile        |  2 +-
>  arch/openrisc/kernel/insn.c          | 88 ++++++++++++++++++++++++++++
>  arch/openrisc/kernel/setup.c         |  4 ++
>  arch/openrisc/kernel/traps.c         | 53 +++--------------
>  7 files changed, 159 insertions(+), 50 deletions(-)
>  create mode 100644 arch/openrisc/kernel/insn.c
> 
> diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
> index 3cfc4cf0b019..d6bb8744eba0 100644
> --- a/arch/openrisc/include/asm/cpuinfo.h
> +++ b/arch/openrisc/include/asm/cpuinfo.h
> @@ -15,6 +15,7 @@
>  #ifndef __ASM_OPENRISC_CPUINFO_H
>  #define __ASM_OPENRISC_CPUINFO_H
>  
> +#include <linux/jump_label.h>
>  #include <asm/spr.h>
>  #include <asm/spr_defs.h>
>  
> @@ -34,6 +35,8 @@ struct cpuinfo_or1k {
>  	u16 coreid;
>  };
>  
> +DECLARE_STATIC_KEY_TRUE(delay_slot);
> +
>  extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
>  extern void setup_cpuinfo(void);
>  
> diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
> index 1e0c028a5b95..ccbda049171f 100644
> --- a/arch/openrisc/include/asm/insn-def.h
> +++ b/arch/openrisc/include/asm/insn-def.h
> @@ -3,13 +3,63 @@
>   * Copyright (C) 2025 Chen Miao
>   */
>  
> +#include <asm/spr.h>
> +#include <asm/spr_defs.h>
> +#include <linux/bits.h>
> +
>  #ifndef __ASM_OPENRISC_INSN_DEF_H
>  #define __ASM_OPENRISC_INSN_DEF_H
>  
> -/* or1k instructions are always 32 bits. */
> -#define	OPENRISC_INSN_SIZE		4
> -
>  /* or1k nop instruction code */
> -#define OPENRISC_INSN_NOP     0x15000000U
> +#define OPENRISC_INSN_CSYNC	0x23000000U
> +#define OPENRISC_INSN_MACRC	0x18010000U
> +#define OPENRISC_MASK_MACRC	0xfc01ffffU
> +#define OPENRISC_INSN_MSYNC	0x22000000U
> +#define OPENRISC_INSN_NOP	0x15000000U
> +#define OPENRISC_INSN_PSYNC	0x22800000U
> +#define OPENRISC_INSN_SYS	0x20000000U
> +#define OPENRISC_INSN_TRAP	0x21000000U
> +
> +#define OPENRISC_OPCODE_ADRP	0x02
> +#define OPENRISC_OPCODE_BF		0x04
> +#define OPENRISC_OPCODE_BNF		0x03
> +#define OPENRISC_OPCODE_J		0x00
> +#define OPENRISC_OPCODE_JAL		0x01
> +#define OPENRISC_OPCODE_JALR	0x12
> +#define OPENRISC_OPCODE_JR		0x11
> +#define OPENRISC_OPCODE_LWA		0x1b
> +#define OPENRISC_OPCODE_MFSPR	0x2d
> +#define OPENRISC_OPCODE_MTSPR	0x30
> +#define OPENRISC_OPCODE_RFE		0x09
> +#define OPENRISC_OPCODE_SWA		0x33
> +
> +#define OPENRISC_ADRP_IMM_MASK		GENMASK(18, 0)
> +#define OPENRISC_ADRP_OFFSET_MASK	GENMASK(31, 13)
> +#define OPENRISC_ADRP_IMM_SHIFT		13
> +#define OPENRISC_ADRP_REG_MASK		GENMASK(25, 0)
> +#define OPENRISC_ADRP_REG_SHIFT		21
> +#define OPENRISC_JUMP_IMM_MASK		GENMASK(25, 0)
> +#define OPENRISC_JUMP_IMM_SHIFT		2
> +#define OPENRISC_JUMP_REG_MASK		GENMASK(15, 11)
> +#define OPENRISC_JUMP_REG_SHIFT		11
> +
> +#define OPENRISC_MASK_SYS	GENMASK(31, 16)
> +#define OPENRISC_MASK_TRAP	GENMASK(31, 16)
> +#define OPENRISC_MASK_BCODE	GENMASK(15, 0)
> +
> +#define OPENRISC_OPCODE_MASK	0x3f
> +#define OPENRISC_OPCODE_SHIFT	0x1a
> +
> +struct pt_regs;
> +
> +#define OPENRISC_INSN_SIZE	4
> +
> +static __always_inline unsigned char get_6_bit_opcode(unsigned long insn)
> +{
> +	return (insn >> OPENRISC_OPCODE_SHIFT) & OPENRISC_OPCODE_MASK;
> +}
> +
> +void simulate_pc(struct pt_regs *regs, unsigned long jmp);
> +void simulate_branch(struct pt_regs *regs, unsigned long jmp);
>  
>  #endif /* __ASM_OPENRISC_INSN_DEF_H */
> diff --git a/arch/openrisc/include/asm/spr_defs.h b/arch/openrisc/include/asm/spr_defs.h
> index f0b6b492e9f4..5d13a9b96263 100644
> --- a/arch/openrisc/include/asm/spr_defs.h
> +++ b/arch/openrisc/include/asm/spr_defs.h
> @@ -179,6 +179,7 @@
>  #define SPR_CPUCFGR_OF32S  0x00000080  /* ORFPX32 supported */
>  #define SPR_CPUCFGR_OF64S  0x00000100  /* ORFPX64 supported */
>  #define SPR_CPUCFGR_OV64S  0x00000200  /* ORVDX64 supported */
> +#define SPR_CPUCFGR_ND     0x00000400  /* No delay slot */
>  #define SPR_CPUCFGR_RES	   0xfffffc00  /* Reserved */
>  
>  /*
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 19e0eb94f2eb..150779fbf010 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -5,7 +5,7 @@
>  
>  always-$(KBUILD_BUILTIN)	:= vmlinux.lds
>  
> -obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
> +obj-y	:= head.o insn.o setup.o or32_ksyms.o process.o dma.o \
>  	   traps.o time.o irq.o entry.o ptrace.o signal.o \
>  	   sys_call_table.o unwinder.o cacheinfo.o
>  
> diff --git a/arch/openrisc/kernel/insn.c b/arch/openrisc/kernel/insn.c
> new file mode 100644
> index 000000000000..619d8080d822
> --- /dev/null
> +++ b/arch/openrisc/kernel/insn.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * OpenRISC instruction utils
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
> +#include <linux/ptrace.h>
> +#include <asm/insn-def.h>
> +#include <asm/cpuinfo.h>
> +
> +DEFINE_STATIC_KEY_TRUE(delay_slot);
> +
> +void simulate_pc(struct pt_regs *regs, unsigned long pc_insn)

Since this simulates l.adrp, maybe the name makes more sense to be called
simulate_adrp?

> +{
> +	int page_offset;
> +	unsigned int rd, op;
> +
> +	page_offset = sign_extend32(
> +		(pc_insn & OPENRISC_ADRP_IMM_MASK) << OPENRISC_ADRP_IMM_SHIFT, 31);
> +	rd = (pc_insn & OPENRISC_ADRP_REG_MASK) >> OPENRISC_ADRP_REG_SHIFT;
> +	op = get_6_bit_opcode(pc_insn);
> +
> +	switch (op) {
> +	case OPENRISC_OPCODE_ADRP:
> +		if (rd != 0)
> +			regs->gpr[rd] = page_offset + (regs->pc & OPENRISC_ADRP_OFFSET_MASK);
> +		regs->pc += OPENRISC_INSN_SIZE;
> +		return;
> +	default:
> +		break;
> +	}
> +}
> +NOKPROBE_SYMBOL(simulate_pc)
> +
> +void simulate_branch(struct pt_regs *regs, unsigned long jmp_insn)
> +{
> +	int displacement;
> +	unsigned int rb, op, link_offset, temp;
> +
> +	displacement = sign_extend32(
> +		((jmp_insn) & OPENRISC_JUMP_IMM_MASK) << OPENRISC_JUMP_IMM_SHIFT, 27);
> +	rb = (jmp_insn & OPENRISC_JUMP_REG_MASK) >> OPENRISC_JUMP_REG_SHIFT;
> +	op = get_6_bit_opcode(jmp_insn);
> +	link_offset = OPENRISC_INSN_SIZE;
> +
> +	if (static_branch_likely(&delay_slot))
> +		link_offset <<= 1;

Why do shift left here instead of += OPENRISC_INSN_SIZE? Since logically we are
adding one more insn for the delay slot, not doubling.

However, It may be more efficient to avoid using the alu and write as:

       if (static_branch_likely(&delay_slot))
               link_offset = 2 * OPENRISC_INSN_SIZE;
       else
               link_offset = OPENRISC_INSN_SIZE;

what do you think?

> +	switch (op) {
> +	case OPENRISC_OPCODE_J: /* l.j */

I think these comments (/* l.j */) are no longer needed sinc you have
the named macros.

> +		regs->pc += displacement;
> +		return;
> +	case OPENRISC_OPCODE_JAL: /* l.jal */
> +		regs->gpr[9] = regs->pc + link_offset;
> +		regs->pc += displacement;
> +		return;
> +	case OPENRISC_OPCODE_BNF: /* l.bnf */
> +		if (regs->sr & SPR_SR_F)
> +			regs->pc += link_offset;
> +		else
> +			regs->pc += displacement;
> +		return;
> +	case OPENRISC_OPCODE_BF: /* l.bf */
> +		if (regs->sr & SPR_SR_F)
> +			regs->pc += displacement;
> +		else
> +			regs->pc += link_offset;
> +		return;
> +	case OPENRISC_OPCODE_JR: /* l.jr */
> +		regs->pc = rb == 0 ? 0 : regs->gpr[rb];
> +		return;
> +	case OPENRISC_OPCODE_JALR: /* l.jalr */
> +		temp = regs->pc + link_offset;
> +		regs->pc = rb == 0 ? 0 : regs->gpr[rb];
> +		regs->gpr[9] = temp;
> +		return;
> +	default:
> +		break;
> +	}
> +}
> +NOKPROBE_SYMBOL(simulate_branch)
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 000a9cc10e6f..9c231b320d45 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -252,6 +252,10 @@ void __init setup_arch(char **cmdline_p)
>  	/* perform jump_table sorting before paging_init locks down read only memory */
>  	jump_label_init();
>  
> +	/* determine if the processor supports delay slots */
> +	if (mfspr(SPR_CPUCFGR) & SPR_CPUCFGR_ND)
> +		static_branch_disable(&delay_slot);
> +
>  	/* paging_init() sets up the MMU and marks all pages as reserved */
>  	paging_init();
>  
> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
> index c195be9cc9fc..a59abbca3555 100644
> --- a/arch/openrisc/kernel/traps.c
> +++ b/arch/openrisc/kernel/traps.c
> @@ -32,6 +32,7 @@
>  
>  #include <asm/bug.h>
>  #include <asm/fpu.h>
> +#include <asm/insn-def.h>
>  #include <asm/io.h>
>  #include <asm/processor.h>
>  #include <asm/unwinder.h>
> @@ -252,12 +253,12 @@ static inline int in_delay_slot(struct pt_regs *regs)
>  	insn = *((unsigned int *)regs->pc);
>  	op = insn >> 26;
>  	switch (op) {
> -	case 0x00: /* l.j */
> -	case 0x01: /* l.jal */
> -	case 0x03: /* l.bnf */
> -	case 0x04: /* l.bf */
> -	case 0x11: /* l.jr */
> -	case 0x12: /* l.jalr */
> +	case OPENRISC_OPCODE_J: /* l.j */
> +	case OPENRISC_OPCODE_JAL: /* l.jal */
> +	case OPENRISC_OPCODE_BNF: /* l.bnf */
> +	case OPENRISC_OPCODE_BF: /* l.bf */
> +	case OPENRISC_OPCODE_JR: /* l.jr */
> +	case OPENRISC_OPCODE_JALR: /* l.jalr */

Nice cleanup, again I think comments can be removed now.

>  		return 1;
>  	default:
>  		return 0;
> @@ -269,47 +270,9 @@ static inline int in_delay_slot(struct pt_regs *regs)
>  
>  static inline void adjust_pc(struct pt_regs *regs, unsigned long address)
>  {
> -	int displacement;
> -	unsigned int rb, op, jmp;
> -
>  	if (unlikely(in_delay_slot(regs))) {
>  		/* In delay slot, instruction at pc is a branch, simulate it */
> -		jmp = *((unsigned int *)regs->pc);
> -
> -		displacement = sign_extend32(((jmp) & 0x3ffffff) << 2, 27);
> -		rb = (jmp & 0x0000ffff) >> 11;
> -		op = jmp >> 26;
> -
> -		switch (op) {
> -		case 0x00: /* l.j */
> -			regs->pc += displacement;
> -			return;
> -		case 0x01: /* l.jal */
> -			regs->pc += displacement;
> -			regs->gpr[9] = regs->pc + 8;
> -			return;
> -		case 0x03: /* l.bnf */
> -			if (regs->sr & SPR_SR_F)
> -				regs->pc += 8;
> -			else
> -				regs->pc += displacement;
> -			return;
> -		case 0x04: /* l.bf */
> -			if (regs->sr & SPR_SR_F)
> -				regs->pc += displacement;
> -			else
> -				regs->pc += 8;
> -			return;
> -		case 0x11: /* l.jr */
> -			regs->pc = regs->gpr[rb];
> -			return;
> -		case 0x12: /* l.jalr */
> -			regs->pc = regs->gpr[rb];
> -			regs->gpr[9] = regs->pc + 8;
> -			return;
> -		default:
> -			break;
> -		}
> +		simulate_branch(regs, *((unsigned int *)regs->pc));
>  	} else {
>  		regs->pc += 4;
>  	}
> -- 
> 2.55.0
> 
