Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4B43746A
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jul 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622421; cv=none; b=pjZ9X8lzrDKMKZXiqmG54KnDTQWUNE1f+in8ZCQWH1BhDT3L78FdhMwNoHcARfTzh487CMda1FjPcik/bFnhLIfmVXzH4oUt65BwFjmKhEAzQu2N2Yux1zhV38isgitjTFIl+JNZ3JnNN2/6JKhcCGKZC+q/H+DWPiqZnFEx/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622421; c=relaxed/simple;
	bh=rnI8Mtk7zFh67ToOxrITQJjhD2smVc7SMC3A0Srfn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr6kkOlcKuRdp8bGaZR8Rbae8QyQUErQGTf+8waUqhqXLn0OSdMmBR1cLlv7SuzPsR8PEV0OyuvxQHPMl0+FyB0a+faHBbw7XyIkLPElcbHuApbj7vxyeoJ2o61cwZeQODkJah3ORQDWZ6me/qIK3sLTVnJOC5jFqpg8PLNSDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSxrzxxE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSxrzxxE"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8484f229529so66552b3a.2
        for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622419; x=1784227219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=;
        b=hSxrzxxEgcIPpX4HGktg5ZBZPXnANJ73MP3lQU8dB8IP7Qadq7oJ8G+4+MWybMR345
         8CD1MkedcDdfN9mmArcgE/028EQezgTd0kAfl421CaxIudItiKKE10qi8Hx/9r62yEyx
         L94i9XpzAPgVLVw5oRo/Cu4zV80C73sGdWFgFhGCzziH+NX//k6+57HkXCDPFDDUBWZc
         ASWX5fCCg0oURezyLULnlaLxVPoPewDbOh1Y8+e6IUs/KO6/S3FQwLZwN/3FF0sAVTqs
         pcWyaUPVyMBfu+h0C/SdPiDsIEvJVLAXiECIbVjHMA/BigcVj3icz30PkDlWEhhKpoRQ
         lmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622419; x=1784227219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3NWG3nzWzn0lD5brSEphHHDIxNRitNNFv0e1po41sA=;
        b=X/PLOFtjJSOUZW0ztNeTYZfzjgwYXx+/7vdYvuBHU6B1k8GtgEsI5mqQceP5Q7h+Jr
         FenVWUXLlAUEvjo4unJJ8TTRVm6XL72ZkUXZ62C0AVP0xa8urZiKVnVfRete+tZlgTHP
         XXee3NQo3Ah9TOhiv19Er2hUIktcP89vw14DESTwWSTv5EG7Y/EJnMeh5yp7ESDnsX6b
         M23JhpOyx0WVWr3csFJCJcm540eDORzBtKVT0Kg+aw1dvUSCrsuhXvpqpE+uQwrwfWjq
         yWeJjdhyurxHlYQHFrV2P1FdcoHhr5vY/zhx3Utsq3igEKX5kh7Tbywbq6zk723+Mqid
         B+Og==
X-Forwarded-Encrypted: i=1; AHgh+RrB/1niKCSANBK4HuIpyVk7oCfn0PWtZgZ9E6ktxOLJ87aicXF8Pz8PFNVkQ5SyM5YbgY0IjwCZmV5gKkrGjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBSp2vopX/lzJef+brpxVjc1q5Tye5cjy5xAJVukl6GFxMTZi
	QmuEiMPuPuk8HcADKXCeJ6M/h4MnIkq9iEem0pvNdAGchY4liISrgIU7
X-Gm-Gg: AfdE7cnJSppwwmC/2YAFuBuPT5W7Srj3M6Js7qJrzjOMZD5WZMdBlnXzF/+dsL/iLM5
	l5TPEaq69lmP94RxhUWdIPEsXFDna+pwAL5/1AEuhlTbtGPfjX5o9XJ0MKsYfw9UonZSCRd7dbA
	QWboCj175ZNwwWsboqwIsP6iF1p2/PyIYBATjzfwEf7sfP5HwuCDk83+6Vcp3XQt8qVNgFaDU6F
	f3fJ6bRTovrctIZ5TvNTwK65TLBibNU5rAFxEXKHcbD0QB2QwahsXky/P5XLQSl1+et9xh10ZuC
	x1Ug2p94N+wiT62GTLcA2kC/5uFROlh38g9bwg5/H5+vKdlyPgfcxMgRPWBnL+rWUuDrK6RNV7U
	xsCJ1byw0go+xmEC6bvwmavENTiwNxbTYi9DwWV9BZTTYM5vwTelbs1SriQ75wvvjtSXP6tx8u9
	TPI2nYnHcxpKWN7DIk1ZX2fZKEzfydie6Eq9E1Fg+P1CrVl/MDIJsp6A85KPnP
X-Received: by 2002:a05:6a21:4902:b0:3b4:8300:7019 with SMTP id adf61e73a8af0-3c0bcf656a1mr10343651637.18.1783622418932;
        Thu, 09 Jul 2026 11:40:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm28653518eec.14.2026.07.09.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:40:18 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:10:01 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
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
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Message-ID: <ak_q9qWuifFdo_9S@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.865955911@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.865955911@kernel.org>

On Tue, Jul 07, 2026 at 09:06:11PM +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>  arch/loongarch/kernel/syscall.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -11,7 +11,6 @@
>  #include <linux/linkage.h>
>  #include <linux/nospec.h>
>  #include <linux/objtool.h>
> -#include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
>  #include <linux/unistd.h>
>  
> @@ -70,9 +69,7 @@ void noinstr __no_stack_protector do_sys
>  	regs->orig_a0 = regs->regs[4];
>  	regs->regs[4] = -ENOSYS;
>  
> -	nr = syscall_enter_from_user_mode(regs, nr);
> -
> -	add_random_kstack_offset();
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
>  
>  	if (nr < NR_syscalls) {
>  		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
> 
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc
