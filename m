Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046381;
	b=EtCu7i7Vp+gxAuTPdJa3zbOoLVkXW+gInQUXawuAz7hvlnygTkII2ITbG2D4eh5aEOqg
	 9RfUoYWAFwCoU1LhEnHWaLrzVWWPd5Dn09Er602ZKh5ez+KtpYZePWekNtXzfYf+AB6gC
	 GFx09x1o5mdMnr4y8DOvaBKups/d8hqMBh8ejSA83gWszg+M+d7cW0AuJAR7s6ipDWyb/
	 QvjKTo8eYvdB3IzWE97FZgR7zChBLnEX2jhX1N70BICv3DrbLqWjanbpRPoXsA4EINq85
	 9TmuxWkiOHJHMJu//9GgNFneyl28Mq1WJH/o1xsc/gOPd8WELVZEVuuzwEMr4Dx6CWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=r1kwqOn9s+Z1Iv4jtlKJw++IdaDVWzo01BlrEy3WNcY=;
	b=xqrUy2ndTe4eLot12Un2mFiNigysPFjArhYlK19ZsDMIb/LWpZ+FbARbiVQluXBilph5
	 8jDpKQbd+dsbSyi0ZMjzRkb8/rRZ8gGYWnHpIVUaz91HjWA8IHTonhrax2p2w54uTwNtG
	 MKuEnhCkJ/MNBcMtWmWGxePZE60x8vzqw9ZcwedLxoPRJLNoCJvvIaUZvPd2F3NLTC2Ci
	 tnAWqsJ+Ka5T+68noEv0JAW4zm78BxOy7flSh/Rw73+WoncSNt0ajIQwEcyJcZQi/2CZU
	 raL08LUSICNLsIqWcNC6v/jvmxMaQMnNyIDriVEj5um58KDQYbm6ZyUBjTW6I0jgMZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kHQDMnDr;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBB60A2636
	for <linux-openrisc@vger.kernel.org>; Mon, 26 Oct 2026 20:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BCBB60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kHQDMnDr
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1032998c88.0
        for <linux-openrisc@vger.kernel.org>; Mon, 26 Oct 2026 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793046380; x=1793651180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1kwqOn9s+Z1Iv4jtlKJw++IdaDVWzo01BlrEy3WNcY=;
        b=kHQDMnDrUY/rB35jHhCGT4DG1U9ACLnZK+QMoyoDjUir2QJ8hat3p+xKM4iqJgtEII
         5zT9Xd8f7DEVY5uH5+v/A2hnUZx0qaPU0Vm9TsmHAz8zkZaSvJdAkp0qtPac3si0RhcB
         f6HrNt10P98lT4K/bkZ9pu5AaxqJ5AMXbX7Y29XOAVqkpoiNn6mtPFqbvZDVkffWHVH9
         Z3qjFXoXZQq2iqy7z1R0Qw24bZ2jUcCxLxF1+qaM7Lf1DTWu+qvus9A+ukeZbkMfW2gm
         ezOW95i0CBdGnGfCuhyr6qvJ+p64PvFmt8say3CPVpkh1A0JBGP5+Zhq07FJyWlgOtRY
         OERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046380; x=1793651180;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1kwqOn9s+Z1Iv4jtlKJw++IdaDVWzo01BlrEy3WNcY=;
        b=dsP4pPXq4nY/+H35x6cz5HIiwK71UD0y/59a2cnCaR0oRsqpO6c9cVEMrYfHjd0mNv
         cFIUjy/dkObhcpMZQgghhfHZPvgjRI5L8sSaUfd8y/ucO/aUlAMgH4AQzf6oXc70JYgO
         fzSSS0g95iXZiUKnKmiCD2+uhH3xLis0C9cQuB4oAXhCjZKgMKaCiM+ELeLuHu1LhHNQ
         jzR1cwTOXs/fs+0dGB9IQciO9ptEBAJqnxK5/VpB6sVnB0wlGsp65WXBqrTIQbsBPkMp
         DwwPqLyyhdBJoIZlBbTMUQ00IEqFlqdOhnlbU5pzcDTQRGyvJfsWvutuTIOrGJQjbItI
         QEjA==
X-Forwarded-Encrypted: i=1; AKwUvBzExfwsc/qZBNLt06GKdrsC8rNoOLUxSoq8+bUND9OR59TKMIsv2fcf9ICj4UzTbBV92xa33/LSgYp0sUX0ZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKsWwiCLlfIEmjq4I/eUsWjODHe2OPI8tJhGRrAgerv1N/lepPI
	OInh7H4ufqx8mWQPtcTpPSLDG9x+5BZqSoz5ifLMLIYVy6dO4uo5CTih
X-Gm-Gg: AYBFou0fQAGq9Kfl9yPA4TmNtNHx8NsL+suWmUJjcyp1187yN38Fb73to72W7M8O+zY
	4IMlui6hwTbI/KN0obhzhGywHNJtGneFB8cr0ADr3QbIuB13mXvbLoqo6z2tseCwfgiw/ZwMcpD
	WQxL7eZgbtxW44I0qUMGaYBbUi5WjWKvMYN2S7ztiF3ArozXhCy7TC6w7ea292cA6yyAWA1R38q
	2AMy4amPCcBxcLMRu6KT/a83U0Hv3Paw5VRVzXGn7JJJSzZDziHkukqRh+os4gwuxZ1IcYWxg2y
	5nJM2H/4qTR2RZPR3hT9ungs4l1Q/FMTYzUZYVTsn546OQcgazd2AmVw/m7Cv7GsQprgf7wRGTV
	AZ5q0gGrTMoCxoT/ZIFwtyCyJYFutABme5hhk/x/uIo62ugQAyiBHM+w8AwsScEVEVniri5Dcmk
	PJY0+ZpoDL9Faa15p/35e2F0mecUawyJ3Y53zY6ZgCRI1UgXUVn2038phM2Lbn7+q3LW7jgpjko
	I9aBQOhMEQhXW/+/5Ne85bsUCf1bX1icmUyJaL5gJ2Vffh1EcaPW5u0NMjfYB8kacMljJLFDY0M
	o0kIVk46lv9KNu80kmQ=
X-Received: by 2002:a05:701b:2714:b0:1a2:2da2:b278 with SMTP id a92af1059eb24-1a22da2b352mr3210683c88.14.1793046379474;
        Mon, 26 Oct 2026 13:26:19 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:61b8:f26f:bd5b:b550:7a07? ([2401:4900:1c44:61b8:f26f:bd5b:b550:7a07])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19886f790e4sm26156609c88.0.2026.10.26.13.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 13:26:18 -0700 (PDT)
Message-ID: <19f2782e-c631-4668-99f2-95107cd2e6d3@gmail.com>
Date: Tue, 27 Oct 2026 01:56:14 +0530
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
Subject: Re: [PATCH v3 2/4] openrisc: Add KProbes
To: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org
Cc: pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
 kees@kernel.org, linux-openrisc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-3-sahilcdq0@gmail.com>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <20261026201240.107462-3-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have two queries in this commit.

On 10/27/26 1:42 AM, Sahil Siddiq wrote:
> Add KProbes support for OpenRISC. This work is primarily based
> on similar work done for LoongArch, MIPS and RISC-V.
> 
> KProbes make it possible to trap at almost any address in the
> kernel to collect performance/debugging info.
>
> [...]
> diff --git a/arch/openrisc/include/asm/kprobes.h b/arch/openrisc/include/asm/kprobes.h
> new file mode 100644
> index 000000000000..2b5847002141
> --- /dev/null
> +++ b/arch/openrisc/include/asm/kprobes.h
> @@ -0,0 +1,77 @@
> [...]
> +
> +struct prev_kprobe {
> +	struct kprobe *kp;
> +	unsigned int status;
> +	unsigned long restore_pc;
> +};
> +
> +/* per-cpu kprobe control block */
> +struct kprobe_ctlblk {
> +	unsigned int kprobe_status;
> +	unsigned long irq_flags;
> +	/* address of next instruction in case of SSOL */
> +	unsigned long restore_pc;
> +	struct prev_kprobe prev_kprobe;
> +};
> +

There was a review comment from Sashiko about saving "irq_flags" in
"struct prev_kprobe". I am not sure if that's actually required.

My understanding is that a KProbe will be reentered if a probe is hit
before single-stepping (e.g. a probe in the pre-handler) or after it
(e.g. a probe in the post-handler). If a KProbe is reentered before
single-stepping, nothing will be present in kprobe_ctlblk.irq_flags that
requires restoration. So, it doesn't need to be saved in prev_kprobe.
And if the KProbe is reentered after single-stepping, by that point the
value in kprobe_ctlblk.irq_flags should have already been restored (i.e.
IRQs should be reenabled by then) and so it shouldn't need saving in
prev_kprobe.

Could you please let me know if I am missing something, or if my
reasoning is sound?

> [...]
> diff --git a/arch/openrisc/kernel/kprobes.c b/arch/openrisc/kernel/kprobes.c
> new file mode 100644
> index 000000000000..0b8762e340d5
> --- /dev/null
> +++ b/arch/openrisc/kernel/kprobes.c
> @@ -0,0 +1,426 @@
> [...]
> +
> +int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> +{
> +	struct kprobe *cur = kprobe_running();
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	switch (kcb->kprobe_status) {
> +	case KPROBE_HIT_SS:
> +	case KPROBE_REENTER:
> +		/*
> +		 * The instruction being single-stepped caused a page fault.
> +		 * Reset the current KProbe and set PC to the probe's address.
> +		 * Then allow the page fault handler to continue as usual.
> +		 */
> +		instruction_pointer_set(regs, (unsigned long)cur->addr);
> +

There was another review comment from Sashiko. It stated that in the case
of a page fault which is triggered in the delay slot of a jump-and-link
instruction, resetting PC to the branch instruction can corrupt the state.
It theorized that this is due to the modification made to regs->gpr[9]
(the link register) in "simulate_branch()".

I haven't really understood why the state would get corrupted in this case.
Rewinding PC to the branch instruction implies it'll get executed again.
If it gets re-executed, the value in regs->gpr[9] should also get re-evaluated
and it should hold the correct value after re-execution.

> +		if (kcb->kprobe_status == KPROBE_REENTER)
> +			restore_previous_kprobe(kcb);
> +		else
> +			reset_current_kprobe();
> +
> +		kprobe_local_irq_restore(kcb, regs);
> +		preempt_enable_no_resched();
> +		break;
> +	}
> +
> +	return 0;
> +}
> [...]

Thanks,
Sahil

[1] https://sashiko.dev/#/patchset/20260407185650.79816-1-sahilcdq0%40gmail.com?part=2 (1st comment)
[2] https://sashiko.dev/#/patchset/20260930203129.51048-1-sahilcdq0%40gmail.com?part=2 (6th comment)

