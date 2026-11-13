Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589923;
	b=tSAps0xrhXOcI803Lzwb6LVRr6lw9oe2KQy013/HowF0UHZhG57Jc8iDb3AuLSoQ06DF
	 JXyUYu2LB4kAVZQWpK/Y4FlyQnzvEdInyo3OXgB93zhJeAvZZ++4+e3ZamTAXHNC9hm3s
	 tDbpyxxxxCCy29ElDsYVqRTlTWMawoY9qYOiwB453C2ChCDqgjPch1QfauRqZ+gIA+Ksx
	 Lndt4Ug4o7m7vFmMHabdklkd1DPD1SrJiaWOv5KPBrNVO256PZd69DwYAbag9kETrZRzZ
	 kCN/vKVNc5sa8Z/ZmiFPc3P5LuWdqk1itgWJP3JNfGxtkskx5Hig4nAnWPqCogjY+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IxXxoNwj22+Dy36iHNXW95kbwk4XPaL1NeXI0EBISjQ=;
	b=tHrBo9h/eIKeuHwu8/Opn0aCZSQUYPQUKqXVBZlYOMpD5pedBlKs46larFwPs632GLsj
	 nyIrNut6vlWJFQj0PJCJGFqg5ryErUXd7kciSYfTjrXnu2yffC15oXOBZ/ZAe/Q9fJB8f
	 uYgsINzAVYuDmuLNnd+fBAI4i2ltskaXzbzNQHtCn8FKVt4a5Rb0MH0ty2khOeVZbrj7V
	 KVP/h172KFPBqlm+fWQo0ioHs7PBUz92EyINsSQWnTgNU66sK/vkDf/M5PqhR9evKqCRs
	 9dPiKtSBbwaQzXwLgfTfsJNbv47Fg4Gu+mJCW4kIoEuutXQDZqXboYIlQC7zveIUtfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkwQy7DG;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36973606A334
	for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 17:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36973606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkwQy7DG
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1611088eec.0
        for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 09:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589922; x=1795194722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxXxoNwj22+Dy36iHNXW95kbwk4XPaL1NeXI0EBISjQ=;
        b=IkwQy7DG+ZzVzAYi1f+tbEIRi7gWYxvNnlJrGs10GeQ9UNZ0EIPBLomu39yvu+LK5g
         kTmm/v36hnCH2bjvbvdhvp0GqBXX1nKHgqSANKtm/xXdHuasWtzl1Jhu9lX16LapQeJ0
         HEydXQV7ctfquwtyAd+zI+rMzjeXl4wioRi3MklFxzmM7/Tiq8G1eot/tPfPwWy1XwsZ
         AG1MiEyjip0qMnFkdsI1vNe+5gXlMWTxBe51BU+71ZTkA41Eq42I7vXuL00p+tBqoHWF
         BwDHyWlWI95c1cKt35JcATxI/t0Gv0aE2ZzIzGbRxWRi6cGbp5le4zxrafjUPjuglqHI
         2nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589922; x=1795194722;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxXxoNwj22+Dy36iHNXW95kbwk4XPaL1NeXI0EBISjQ=;
        b=rmG33FQmbsVse7X57k/VP1ix2BzR3spuJxipfcy7tqDG2q5K3Wx3oGLJ3/pP5s/H19
         45K4BHdieOYGfylDpn50byMPqHmKG6MAjGNpZPZsNwXeEp9akHPvpuaHgx9Hk6Y1FM4z
         3LPYJ5WHQlowAmKf2bb/cVzrZjj14mj/QelQlEfAVug/Dr/Jw0Tq9sUWh9rINTDznxlH
         RG/3bNRj1mSdWDnnYvp/8bqJkg0aDjXBD4HLnTRvnJBxHr9RUxa9DKXLU1rfAlP/LMPT
         TZR2FL4ohCuC3btF5hoNX1W377IaJiV+6NFyetU23U23nVcXw4AKDY7Vo2j9A/aAz7Xq
         Kckg==
X-Forwarded-Encrypted: i=1; AL+hErF5a1S5VhTp7OCSehbmfFtnFb/dsoK49seecXgdnMz/kuOUT7jS60YQvQTiR5pNJDkdfEhLVtqi2XpxuXkgjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+5jAF4nxOWwJ+UPavvY+9/Fc1VDV/nRLc5HbOKncqB1GKCEyWz
	y1f8CTuVbHBld7qrcwSHQcyQN74d7phjiBQD7B8AtEd+Q8mjCrf3yqQ2
X-Gm-Gg: AYBFou3xsj1Ji0yKJO2AxXPSFflEYEWYugJC1TZluOGYTkS9VLSAOv03l9Itllcud/R
	abnpcRXwkQ6QIrO86Bju67Mzg2VhfH3LzPmRoIF18gomgk3RSbYuDgefpwlEKT8GkG7EzmA95KU
	wQzSpAxH50k8yyl1JFyagWTjy64LUjPh1+iaFxaN1APlfpYGfmhr08HuqlxqS/jC2euFlSuzIy8
	VI6AYWj84nWd3e9z6Y7+6RVP+JQQuh3EJ11dypuAQLVohx/JbC9A/7fDdwaCqdD86LDFFU+Gsbp
	Ba9+Df5q4Ujh0nh1Brjc6LQBnId8ulghgwBmCr4wjV1L22sjQtA6Cik8XwrCRin98Zl1AIl/y+q
	gS2tH81ujIbJKs/dpu4ZNBNyi4FPzpLej0x0x9C0gpasyZB6oShUNY+OcWESgKOz19ALKh0u0Mb
	89gCsF5gKjAJHmUdF3IvuV7ms0uv09dTvCvcju4b4B+kwfpx8YvkOzGutiBOYn1xjPN8SRCMpu8
	J5ZPSwCfVqUuJYzRdBedipOjiSKZHeLlltM0qPcRgwX+iwuhzajr3ZhFyOJABI16JYb2js=
X-Received: by 2002:a05:7301:4614:b0:36a:12bb:7f8e with SMTP id 5a478bee46e88-379655d45c1mr2402482eec.13.1794589922171;
        Fri, 13 Nov 2026 09:12:02 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm9396249eec.14.2026.11.13.09.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:12:01 -0800 (PST)
Message-ID: <52c3ae66-4165-4fc3-a440-fcb76931382a@gmail.com>
Date: Fri, 13 Nov 2026 22:41:56 +0530
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil <sahilcdq0@gmail.com>
Subject: Re: [PATCH v3 1/4] openrisc: Add utilities and clean up simulation of
 instructions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-2-sahilcdq0@gmail.com> <au7I8FNoMcsoh54X@antec>
Content-Language: en-US
In-Reply-To: <au7I8FNoMcsoh54X@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stafford,

On 11/7/26 12:15 PM, Stafford Horne wrote:
> Hi Sahil,
> 
> Thanks for your patches, sorry its taken me time to get around to them, my year
> since summer has been quite hectic.

No worries. I completely understand :)

> I will do the review in chunks so give me some time.

Thank you for the review.

> On Tue, Oct 27, 2026 at 01:42:37AM +0530, Sahil Siddiq wrote:
>> Introduce new instruction-related utilities and macros for OpenRISC.
>> This is in preparation for patches that add tracing support such as
>> KProbes and Kretprobes.
>>
>> Currently, PC is first updated and then saved in the link register
>> (r9) when simulating l.jal and l.jalr. This can result in a corrupted
>> page table (bad page map in process). Fix this by saving PC in r9
>> before updating it.
>>
>> Move branch simulation to its own function, simulate_branch(), so it
>> can be reused. It's already being used by do_illegal_instruction().
>> It'll also be used by KProbes in the following commit.
>>
>> Introduce simulate_pc() to simulate l.adrp. KProbes will require this
>> instruction to be simulated as well. simulate_branch() and simulate_pc()
>> need to be handled differently since branch instructions change the
>> value of PC while l.adrp depends on PC but doesn't change its value.
>>
>> Use a static key to check if delay slots are disabled. Delay slots are
>> a part of the CPU's configuration and won't change at runtime. Since
>> they are often enabled in an OpenRISC CPU, using a static key will
>> reduce the overhead of checking this flag in the default case while
>> processing KProbes inserted at branch instructions and simulating them.
>>
>> Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>> ---
>> Changes v2 -> v3:
>> - arch/openrisc/kernel/insn.c:
>>    - (simulate_pc):
>>      Handle case when rd=0
>>      Add function to KProbe blacklist
>>    - (simulate_branch): Likewise
>> - arch/openrisc/kernel/setup.c:
>>    - (setup_arch): Set static key before calling paging_init()
>> - arch/openrisc/kernel/traps.c:
>>    - (do_trap): Move handling of Kprobes in commit #2
>>
>> Changes v1 -> v2:
>> - arch/openrisc/include/asm/cpuinfo.h: Introduce "delay_slot" static key
>> - arch/openrisc/include/asm/insn-def.h:
>>     - Use macros instead of union
>>     - Use better names for macros
>>     - Use genmask() for masks
>> - arch/openrisc/kernel/insn.c:
>>     - Use macros instead of magic values
>>     - (simulate_pc): Update PC
>>     - (simulate_branch): Handle rb=r9 in l.jalr simulation
>> - arch/openrisc/kernel/setup.c: Use "delay slot" static key
>> - arch/openrisc/kernel/traps.c: Use macros instead of magic values
>>
>>   arch/openrisc/include/asm/cpuinfo.h  |  3 +
>>   arch/openrisc/include/asm/insn-def.h | 58 ++++++++++++++++--
>>   arch/openrisc/include/asm/spr_defs.h |  1 +
>>   arch/openrisc/kernel/Makefile        |  2 +-
>>   arch/openrisc/kernel/insn.c          | 88 ++++++++++++++++++++++++++++
>>   arch/openrisc/kernel/setup.c         |  4 ++
>>   arch/openrisc/kernel/traps.c         | 53 +++--------------
>>   7 files changed, 159 insertions(+), 50 deletions(-)
>>   create mode 100644 arch/openrisc/kernel/insn.c
>>
>> [...]
>> diff --git a/arch/openrisc/kernel/insn.c b/arch/openrisc/kernel/insn.c
>> new file mode 100644
>> index 000000000000..619d8080d822
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/insn.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * OpenRISC instruction utils
>> + *
>> + * Linux architectural port borrowing liberally from similar works of
>> + * others.  All original copyrights apply as per the original source
>> + * declaration.
>> + *
>> + * OpenRISC implementation:
>> + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
>> + */
>> +
>> +#include <linux/kprobes.h>
>> +#include <linux/ptrace.h>
>> +#include <asm/insn-def.h>
>> +#include <asm/cpuinfo.h>
>> +
>> +DEFINE_STATIC_KEY_TRUE(delay_slot);
>> +
>> +void simulate_pc(struct pt_regs *regs, unsigned long pc_insn)
> 
> Since this simulates l.adrp, maybe the name makes more sense to be called
> simulate_adrp?

Sure, I'll rename it.

>> +{
>> +	int page_offset;
>> +	unsigned int rd, op;
>> +
>> +	page_offset = sign_extend32(
>> +		(pc_insn & OPENRISC_ADRP_IMM_MASK) << OPENRISC_ADRP_IMM_SHIFT, 31);
>> +	rd = (pc_insn & OPENRISC_ADRP_REG_MASK) >> OPENRISC_ADRP_REG_SHIFT;
>> +	op = get_6_bit_opcode(pc_insn);
>> +
>> +	switch (op) {
>> +	case OPENRISC_OPCODE_ADRP:
>> +		if (rd != 0)
>> +			regs->gpr[rd] = page_offset + (regs->pc & OPENRISC_ADRP_OFFSET_MASK);
>> +		regs->pc += OPENRISC_INSN_SIZE;
>> +		return;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +NOKPROBE_SYMBOL(simulate_pc)
>> +
>> +void simulate_branch(struct pt_regs *regs, unsigned long jmp_insn)
>> +{
>> +	int displacement;
>> +	unsigned int rb, op, link_offset, temp;
>> +
>> +	displacement = sign_extend32(
>> +		((jmp_insn) & OPENRISC_JUMP_IMM_MASK) << OPENRISC_JUMP_IMM_SHIFT, 27);
>> +	rb = (jmp_insn & OPENRISC_JUMP_REG_MASK) >> OPENRISC_JUMP_REG_SHIFT;
>> +	op = get_6_bit_opcode(jmp_insn);
>> +	link_offset = OPENRISC_INSN_SIZE;
>> +
>> +	if (static_branch_likely(&delay_slot))
>> +		link_offset <<= 1;
> 
> Why do shift left here instead of += OPENRISC_INSN_SIZE? Since logically we are
> adding one more insn for the delay slot, not doubling.

Since link_offset is initialized to OPENRISC_INSN_SIZE, shifting it to the left by 1 would
update link_offset to 2 * OPENRISC_INSN_SIZE. This is a little more obscure than explicitly
setting it to 2 * OPENRISC_INSN_SIZE. Initially, I thought the left shift operator might be
less expensive than multiplying.

I was going through mor1kx's design and noticed there's also a pipelined implementation for
the multiplier [1]. But it looks like the implementation for shifting is simpler and can be done
in one cycle. Please let me know if my understanding is incorrect here.

> However, It may be more efficient to avoid using the alu and write as:
> 
>         if (static_branch_likely(&delay_slot))
>                 link_offset = 2 * OPENRISC_INSN_SIZE;
>         else
>                 link_offset = OPENRISC_INSN_SIZE;
> 
> what do you think?

I am not sure if I have understood the alu part. WIll it be more efficient because 2 * OPENRISC_INSN_SIZE
will be optimized by the compiler to simply be a single number? So no alu operation will be required,
just one store operation?

> 
>> +	switch (op) {
>> +	case OPENRISC_OPCODE_J: /* l.j */
> 
> I think these comments (/* l.j */) are no longer needed sinc you have
> the named macros.

Got it, I'll remove the comments.

>> +		regs->pc += displacement;
>> +		return;
>> +	case OPENRISC_OPCODE_JAL: /* l.jal */
>> +		regs->gpr[9] = regs->pc + link_offset;
>> +		regs->pc += displacement;
>> +		return;
>> +	case OPENRISC_OPCODE_BNF: /* l.bnf */
>> +		if (regs->sr & SPR_SR_F)
>> +			regs->pc += link_offset;
>> +		else
>> +			regs->pc += displacement;
>> +		return;
>> +	case OPENRISC_OPCODE_BF: /* l.bf */
>> +		if (regs->sr & SPR_SR_F)
>> +			regs->pc += displacement;
>> +		else
>> +			regs->pc += link_offset;
>> +		return;
>> +	case OPENRISC_OPCODE_JR: /* l.jr */
>> +		regs->pc = rb == 0 ? 0 : regs->gpr[rb];
>> +		return;
>> +	case OPENRISC_OPCODE_JALR: /* l.jalr */
>> +		temp = regs->pc + link_offset;
>> +		regs->pc = rb == 0 ? 0 : regs->gpr[rb];
>> +		regs->gpr[9] = temp;
>> +		return;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +NOKPROBE_SYMBOL(simulate_branch)
>> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
>> index 000a9cc10e6f..9c231b320d45 100644
>> --- a/arch/openrisc/kernel/setup.c
>> +++ b/arch/openrisc/kernel/setup.c
>> @@ -252,6 +252,10 @@ void __init setup_arch(char **cmdline_p)
>>   	/* perform jump_table sorting before paging_init locks down read only memory */
>>   	jump_label_init();
>>   
>> +	/* determine if the processor supports delay slots */
>> +	if (mfspr(SPR_CPUCFGR) & SPR_CPUCFGR_ND)
>> +		static_branch_disable(&delay_slot);
>> +
>>   	/* paging_init() sets up the MMU and marks all pages as reserved */
>>   	paging_init();
>>   
>> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
>> index c195be9cc9fc..a59abbca3555 100644
>> --- a/arch/openrisc/kernel/traps.c
>> +++ b/arch/openrisc/kernel/traps.c
>> @@ -32,6 +32,7 @@
>>   
>>   #include <asm/bug.h>
>>   #include <asm/fpu.h>
>> +#include <asm/insn-def.h>
>>   #include <asm/io.h>
>>   #include <asm/processor.h>
>>   #include <asm/unwinder.h>
>> @@ -252,12 +253,12 @@ static inline int in_delay_slot(struct pt_regs *regs)
>>   	insn = *((unsigned int *)regs->pc);
>>   	op = insn >> 26;
>>   	switch (op) {
>> -	case 0x00: /* l.j */
>> -	case 0x01: /* l.jal */
>> -	case 0x03: /* l.bnf */
>> -	case 0x04: /* l.bf */
>> -	case 0x11: /* l.jr */
>> -	case 0x12: /* l.jalr */
>> +	case OPENRISC_OPCODE_J: /* l.j */
>> +	case OPENRISC_OPCODE_JAL: /* l.jal */
>> +	case OPENRISC_OPCODE_BNF: /* l.bnf */
>> +	case OPENRISC_OPCODE_BF: /* l.bf */
>> +	case OPENRISC_OPCODE_JR: /* l.jr */
>> +	case OPENRISC_OPCODE_JALR: /* l.jalr */
> 
> Nice cleanup, again I think comments can be removed now.

Sure, I'll remove these comments as well.

>>   		return 1;
>>   	default:
>>   		return 0;
>> @@ -269,47 +270,9 @@ static inline int in_delay_slot(struct pt_regs *regs)
>>   
>>   static inline void adjust_pc(struct pt_regs *regs, unsigned long address)
>>   {
>> -	int displacement;
>> -	unsigned int rb, op, jmp;
>> -
>>   	if (unlikely(in_delay_slot(regs))) {
>>   		/* In delay slot, instruction at pc is a branch, simulate it */
>> -		jmp = *((unsigned int *)regs->pc);
>> -
>> -		displacement = sign_extend32(((jmp) & 0x3ffffff) << 2, 27);
>> -		rb = (jmp & 0x0000ffff) >> 11;
>> -		op = jmp >> 26;
>> -
>> -		switch (op) {
>> -		case 0x00: /* l.j */
>> -			regs->pc += displacement;
>> -			return;
>> -		case 0x01: /* l.jal */
>> -			regs->pc += displacement;
>> -			regs->gpr[9] = regs->pc + 8;
>> -			return;
>> -		case 0x03: /* l.bnf */
>> -			if (regs->sr & SPR_SR_F)
>> -				regs->pc += 8;
>> -			else
>> -				regs->pc += displacement;
>> -			return;
>> -		case 0x04: /* l.bf */
>> -			if (regs->sr & SPR_SR_F)
>> -				regs->pc += displacement;
>> -			else
>> -				regs->pc += 8;
>> -			return;
>> -		case 0x11: /* l.jr */
>> -			regs->pc = regs->gpr[rb];
>> -			return;
>> -		case 0x12: /* l.jalr */
>> -			regs->pc = regs->gpr[rb];
>> -			regs->gpr[9] = regs->pc + 8;
>> -			return;
>> -		default:
>> -			break;
>> -		}
>> +		simulate_branch(regs, *((unsigned int *)regs->pc));
>>   	} else {
>>   		regs->pc += 4;
>>   	}
>> -- 
>> 2.55.0
>>

Thanks,
Sahil

[1] https://github.com/openrisc/mor1kx/blob/master/rtl/verilog/mor1kx_execute_alu.v#L224-L377
