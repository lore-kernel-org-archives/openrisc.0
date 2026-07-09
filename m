Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1574499BF
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jul 2026 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622983; cv=none; b=ca7bDi+cMvHy8qKmFq1PakhpmS44gwmILrW4BniANMV7qW+KlDQfI3skEfmOgZV0RVdfoYTcxjk5Do36Oo5rxJfUEBBmHSyAGJK8o7pBr1AIXz+qNueOtCsWGR+1DV9fGNTEhda8O9OxfPCJtNmjqipLbkVE8YfjdEEPLL+gltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622983; c=relaxed/simple;
	bh=Vt3AAg3Xfx8+LNeTFAW2+W3Hb+78J4FMQ1nIkkkMzK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0QqZ2ikPhdN8yOii5A0rLt8pYK2gjDOmaCNZkyLChzfrmQbqYoyyKgT0zJfNcagSGVH0wwIo2xTJdAKVzAuiP3UDQWC7YnUvYyGY3sWg1r2iwnXN5CqinE7c6I/3QMsNqNbynKXOFDh7TlEtBZmR9MKxoexSoId2nBbJRnvN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WseUpRiD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WseUpRiD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-388b404ea89so193911a91.0
        for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622978; x=1784227778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nwM8hgg0owOvY9szEO+ZJ41xpH48S7vT5kW5bfv9ji8=;
        b=WseUpRiDSW1IwvJgJS8P4KkUNnBWLn7KhUi98d7jYXG6XuXauUVzyeudzSDC80u4EZ
         ZBoh2fncfuh1OfPnEgQH7fpXE0QyODrg5BQaPaqwFRfrKcV3X0xNWeNuXgfxNUQiqSUD
         d/OFMuunwQZHR3xDsSJWX4M7+h9j11+6Lx8rFgnBzZFBWkLVUuS870k5worYzoz5Gcub
         alPI6Q3hla4/AsL7CbHM03wPidOJ+1vPSXO8YuAYWAtkFh/OvWAhECy3/AvwOLZkdlNs
         MdbkqBUXt8hcVLq2nwxmBlIPPS/5b6Igt9XjnTbg440E2N2pGveUWVor5FM5WetWaGVQ
         Tr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622978; x=1784227778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwM8hgg0owOvY9szEO+ZJ41xpH48S7vT5kW5bfv9ji8=;
        b=NFBXCey9xZIt4EL2qULSSKGAZ7tsaw/wfv8VEFXwtwY7KqpPMnZrqpjtiPicWexjfI
         2IxvRq1oBi4SIuXDxjN7geCIoAHSjohoO8LQOJNGxPFQhZ08hPOsqDDYb37HvaYnHGyN
         qiMIIrf8/2S6ONqlNcWunCMCjq/x5KrYUbuIzcx6DNMvdg2vsh3bYdwx9ZizhjUJgWk2
         vfzA7Llxo/9b7WJCDI1Y4vwFha6Z9lGbPdUyHe9dG3TBprrHqixz/YB6OCZ85RZGRMbb
         5cpIGhyFqg8tuPLIS+dYbZRhwN2aXo3Y5mnHYW0D/lGkOLhsghwT77gtBHIhDZhelLFt
         iOCA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3KRHoUvXp06qoskv0J1Jk+cRigWbkGGVD3+0cyDpch0wZyW7imeDQHvjP3xoy+Jae8YxA3pviCqEbKHMtlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6X5qtCo1p0u5VrDeg98h3j7PTNT+jKg/0piRn9Gt8TM3JlJZ
	6jdFJgYuaEaBFSDNwW2kZ8MfdkAbLn7XDPr+HqpSVmi2Z6cipe4Ehm6m
X-Gm-Gg: AfdE7cn92Y78EE06o8rxURvmPZ8IZgzMSNmquCXanqNasRgsUA61Q22NYn+GjNUyDtT
	fZjrI0ye6CVoUnYVT5u/Bw2BY4pxF4gFOCfOcyDplhyMlHyx+Bw6y/00saOJZM9BuwIYgeIXvdF
	FCypOIC93zP301pvPn2ee5DrNvPacPkjW0Haip9IgXvA4ufEdnvqoIESKsJgccnXdxRx5yUqIe9
	GjCi2QqJCRQan1JZSBNN+/MtYlUuOClXHRH2ZyspoTGlWM3kn+DbQ01ga8B/MiucjHW+Kdr9WDS
	wNJHjfp3pDQAYuwGhie6/crMymejosmqN1tRKruGu/RrcEE2DOfMCsd4/ZSS5Q+6z1xgApbZnCy
	iDIfkteAn4Pp2iyd2jPAA0iO6z7ZEjrp4gVywNcCwSOIMAvV3NeQFvMghvv3NI2v4AyycjcYzoJ
	uKi56UlwGrl0WHLnCiEHAXOFY4FzYs3EOBCP6f/6+MRW59rRt4lNh/kFgw/UHC
X-Received: by 2002:a17:90b:180a:b0:387:d9cc:7dc1 with SMTP id 98e67ed59e1d1-38d15c8e9c6mr429024a91.19.1783622978242;
        Thu, 09 Jul 2026 11:49:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm37887153eec.1.2026.07.09.11.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:49:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:19:18 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 09/18] entry: Remove syscall_enter_from_user_mode()
Message-ID: <ak_tIel1LZh-zlAU@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.132654198@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.132654198@kernel.org>

On Tue, Jul 07, 2026 at 09:06:32PM +0200, Thomas Gleixner wrote:
> All architecture use either:
> 
>     nr = enter_from_user_mode_randomize_stack(regs, nr);
> 
> or
> 
>     enter_from_user_mode_randomize_stack(regs);
>     nr = syscall_enter_from_user_mode_work(regs, nr);
> 
> Remove the now unused function.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  Documentation/core-api/entry.rst |   17 +++++++++-------
>  include/linux/entry-common.h     |   40 +++------------------------------------
>  include/linux/irq-entry-common.h |    6 ++---
>  3 files changed, 17 insertions(+), 46 deletions(-)
> 
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -68,7 +68,7 @@ low-level C code must not be instrumente
>    noinstr void syscall(struct pt_regs *regs, int nr)
>    {
>  	arch_syscall_enter(regs);
> -	nr = syscall_enter_from_user_mode(regs, nr);
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
>  
>  	instrumentation_begin();
>  	if (!invoke_syscall(regs, nr) && nr != -1)
> @@ -78,12 +78,14 @@ low-level C code must not be instrumente
>  	syscall_exit_to_user_mode(regs);
>    }
>  
> -syscall_enter_from_user_mode() first invokes enter_from_user_mode() which
> -establishes state in the following order:
> +syscall_enter_from_user_mode_randomize_stack() first invokes
> +enter_from_user_mode_randomize_stack() which establishes state in the
> +following order:
>  
>    * Lockdep
>    * RCU / Context tracking
>    * Tracing
> +  * Apply stack randomization
>  
>  and then invokes the various entry work functions like ptrace, seccomp, audit,
>  syscall tracing, etc. After all that is done, the instrumentable invoke_syscall
> @@ -99,10 +101,11 @@ that it invokes exit_to_user_mode() whic
>    * RCU / Context tracking
>    * Lockdep
>  
> -syscall_enter_from_user_mode() and syscall_exit_to_user_mode() are also
> -available as fine grained subfunctions in cases where the architecture code
> -has to do extra work between the various steps. In such cases it has to
> -ensure that enter_from_user_mode() is called first on entry and
> +syscall_enter_from_user_mode_randomize_stack() and
> +syscall_exit_to_user_mode() are also available as fine grained subfunctions
> +in cases where the architecture code has to do extra work between the
> +various steps. In such cases it has to ensure that
> +enter_from_user_mode_randomize_stack() is called first on entry and
>  exit_to_user_mode() is called last on exit.
>  
>  Do not nest syscalls. Nested syscalls will cause RCU and/or context tracking
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -19,7 +19,7 @@
>  #endif
>  
>  /*
> - * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
> + * SYSCALL_WORK flags handled in syscall_enter_from_user_mode_work()
>   */
>  #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
>  				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
> @@ -205,42 +205,10 @@ do {									\
>  	_ret;								\
>  })
>  
> -/**
> - * syscall_enter_from_user_mode - Establish state and check and handle work
> - *				  before invoking a syscall
> - * @regs:	Pointer to currents pt_regs
> - * @syscall:	The syscall number
> - *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * disabled. The calling code has to be non-instrumentable. When the
> - * function returns all state is correct, interrupts are enabled and the
> - * subsequent functions can be instrumented.
> - *
> - * This is the combination of enter_from_user_mode() and
> - * syscall_enter_from_user_mode_work() to be used when there is no
> - * architecture specific work to be done between the two.
> - *
> - * Returns: The original or a modified syscall number. See
> - * syscall_enter_from_user_mode_work() for further explanation.
> - */
> -static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
> -{
> -	long ret;
> -
> -	enter_from_user_mode(regs);
> -
> -	instrumentation_begin();
> -	local_irq_enable();
> -	ret = syscall_enter_from_user_mode_work(regs, syscall);
> -	instrumentation_end();
> -
> -	return ret;
> -}
> -
>  /*
> - * If SYSCALL_EMU is set, then the only reason to report is when
> - * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
> - * instruction has been already reported in syscall_enter_from_user_mode().
> + * If SYSCALL_EMU is set, then the only reason to report is when SINGLESTEP is
> + * set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall instruction has been
> + * already reported in syscall_enter_from_user_mode_work().
>   */
>  static __always_inline bool report_single_step(unsigned long work)
>  {
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -49,9 +49,9 @@
>   * Defaults to an empty implementation. Can be replaced by architecture
>   * specific code.
>   *
> - * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
> - * section. Use __always_inline so the compiler cannot push it out of line
> - * and make it instrumentable.
> + * Invoked from enter_from_user_mode_syscall_and_randomize_stack() in the
> + * non-instrumentable section. Use __always_inline so the compiler cannot push
> + * it out of line and make it instrumentable.
>   */
>  static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
>  
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
