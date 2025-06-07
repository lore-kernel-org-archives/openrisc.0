Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC871367
	for <linux-openrisc@vger.kernel.org>; Sat,  7 Jun 2025 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276182; cv=none; b=BswRnpfU+2QrmhyhTVnshi2LxX9LbZhTff+funL3OmIhQGdt3Pks4oY3b0M+DWw9GhUcNxKD5gtQJn/fLNDxF96OFmXpWKnKX3MIP1d5o9VqzDHhuKQggztx6uWu2iF/8TNreEnmQu4GFNCoZRsHFmHIAV0hKXvh3SzTyh6DeO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276182; c=relaxed/simple;
	bh=d9qFDWHaqsI/4IXt8F9coyYRn3mNP5FO3pbSw/doLOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WivcWvnCwmlb8SyPca12T5Ts2v+C0Xud9WxcyFPMYT6MR/jnJRiJWAREaXx2ubFqLFXzsKkW+Z/8wlCicgAzaS0xlwa5N9eoInq0hZ1URSX/NIs+K+pGkx+mI/4jz5WeXX7z8Jwwua1zpFsFkcffGixTMpODXY72xk83dAEC2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0+955gH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0+955gH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so22460415e9.3
        for <linux-openrisc@vger.kernel.org>; Fri, 06 Jun 2025 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749276179; x=1749880979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CP4e2NB7uJYoOGQ73qH574mfGKFvdqkAFH9RUqxgYzc=;
        b=Q0+955gHRFxi4vHnHI9TPhIrUd1e2nfGhP5Wy92YtBlcKx9Ly7yGVqjdAtqKYfFZCH
         71+o27KOlwfUqOV8wNqztjOwH/wCj/T8ElYLDd2kf7neR5EbNvUPq1C50dCPmgNqTH08
         uvzl084zguMk2AwhgaBfWZpsQc+2cmNemrM82MA7AqCEZ8ntGbON0E6nUfbSwKzrCWJt
         DnIfEg8ge366/FA4+qaxZZRrJKbqnFf0FSujczGul/o6Q76YI7yDoXh9+YSIdmCqMVv7
         uhO68UYbujcG/uHweTPfltW09utDos9D8/1r4m0Kmkt8008nlu08SEOj1Ss7Jwox/et5
         1B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276179; x=1749880979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP4e2NB7uJYoOGQ73qH574mfGKFvdqkAFH9RUqxgYzc=;
        b=nNmAcOetIKtyewknDAaXKpRcOn2+e5zyP7Et0V5O9h/VUW88/lFyfTi8jpaMqE3xGw
         ZgWF7He850J6nPcREDvhY+b/1A6hFoa6ByBiiYkJF9x+0S4Ad2A8yIYsWhLgW5HIPBFv
         vlUKctIhFGWdJt5bg55Bhmxy2dUZbO06BA8wSnPw9ecxkg4bjrZn2/VJQa3z6iLVlx8B
         at3UpGqDVISPny05ayIxO0xkIOupceMDHmwZZvIjE6GkGSG29vEH7b5t8K1zZATDiV7G
         fatOwuPUm88nSxMCV9CInkW1ETAezcTwsMJMtTiCxZObpraXTaoj8WZ4vHZzQHuYe+F/
         7jRw==
X-Forwarded-Encrypted: i=1; AJvYcCU8unRwtH+dPgWALMdXNUzvHc1aXgctUNWce15mmwt2U44InNHXC0kBF37dYrR/FQXWI/UJS4rk6ufrfca00g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUkHZRSLetkliH2Fp7nk0/LSmFAbOsH3iHv0JT/xaQ5Z/5Xlcc
	x9Y6+FlRZ1Rr1A7tolYYT0T9HGLTmdhCCQJNeh7JElTkstqBnCcVUDYZDgXXug==
X-Gm-Gg: ASbGncvZ1LrNkwxfyrhxMjtUUvWKJ5Po5icjRL7Fx2EPOBAE4sehaSmIkJ9eLU/u3B3
	M9Gj2mwWSyXKTyjTBJ8qu30OPiFom1+FRsIimBcrX7nY0lLgt8OisIU5+ThrMH2JJANvU6A6X5o
	1+uAvTnaWH5FfRweayYkv9x6hqu7RMii/2ax5Y0VtxTcUGEKuam8GHQcdqdvAsA9vYVyt903sKs
	t0RS1TzvhWXs47m/JwJY1Yvvs4DpPUQahXfsaoZ6Rd7hXN8hE/34WhHMAHomdZp+yqEbOcvCluv
	DInj5cf6AmJGBvyrN1TE6XumXdiOQCV3tOSBRBm3GvaL6fzphzd/I/i5iJOh1cx1QHIwejJRqew
	Qg9wgNzOMNKQWNUQY5ddVp9DXnw==
X-Google-Smtp-Source: AGHT+IG4NlZpVwez63CDFubVJOXjW1WbXInLeW8zJokIQJhJj1YyBdBVXLd1GS0t3rmTFphzH9jrtA==
X-Received: by 2002:a05:600c:3849:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-452013fd1bdmr55268305e9.6.1749276178408;
        Fri, 06 Jun 2025 23:02:58 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce17f9sm47898285e9.11.2025.06.06.23.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 23:02:56 -0700 (PDT)
Date: Sat, 7 Jun 2025 07:02:55 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH 23/41] openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__
 in non-uapi headers
Message-ID: <aEPWD-WOkVM3uO-b@antec>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-24-thuth@redhat.com>
 <389d8e93-0dbf-4b69-a80c-bf1e9c93b0ff@redhat.com>
 <aENFPqbFFLOh3uSZ@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aENFPqbFFLOh3uSZ@antec>

On Fri, Jun 06, 2025 at 08:45:02PM +0100, Stafford Horne wrote:
> On Fri, Jun 06, 2025 at 08:42:28AM +0200, Thomas Huth wrote:
> > On 14/03/2025 08.09, Thomas Huth wrote:
> > > While the GCC and Clang compilers already define __ASSEMBLER__
> > > automatically when compiling assembly code, __ASSEMBLY__ is a
> > > macro that only gets defined by the Makefiles in the kernel.
> > > This can be very confusing when switching between userspace
> > > and kernelspace coding, or when dealing with uapi headers that
> > > rather should use __ASSEMBLER__ instead. So let's standardize on
> > > the __ASSEMBLER__ macro that is provided by the compilers now.
> > > 
> > > This is a completely mechanical patch (done with a simple "sed -i"
> > > statement).
> > > 
> > > Cc: Jonas Bonn<jonas@southpole.se>
> > > Cc: Stefan Kristiansson<stefan.kristiansson@saunalahti.fi>
> > > Cc: Stafford Horne<shorne@gmail.com>
> > > Cc:linux-openrisc@vger.kernel.org
> > > Signed-off-by: Thomas Huth<thuth@redhat.com>
> > > ---
> > >   arch/openrisc/include/asm/mmu.h         | 2 +-
> > >   arch/openrisc/include/asm/page.h        | 8 ++++----
> > >   arch/openrisc/include/asm/pgtable.h     | 4 ++--
> > >   arch/openrisc/include/asm/processor.h   | 4 ++--
> > >   arch/openrisc/include/asm/ptrace.h      | 4 ++--
> > >   arch/openrisc/include/asm/setup.h       | 2 +-
> > >   arch/openrisc/include/asm/thread_info.h | 8 ++++----
> > >   7 files changed, 16 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/openrisc/include/asm/mmu.h b/arch/openrisc/include/asm/mmu.h
> > > index eb720110f3a20..e7826a681bc4a 100644
> > > --- a/arch/openrisc/include/asm/mmu.h
> > > +++ b/arch/openrisc/include/asm/mmu.h
> > > @@ -15,7 +15,7 @@
> > >   #ifndef __ASM_OPENRISC_MMU_H
> > >   #define __ASM_OPENRISC_MMU_H
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   typedef unsigned long mm_context_t;
> > >   #endif
> > > diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> > > index c589e96035e15..85797f94d1d74 100644
> > > --- a/arch/openrisc/include/asm/page.h
> > > +++ b/arch/openrisc/include/asm/page.h
> > > @@ -25,7 +25,7 @@
> > >    */
> > >   #include <asm/setup.h>
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   #define clear_page(page)	memset((page), 0, PAGE_SIZE)
> > >   #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
> > > @@ -55,10 +55,10 @@ typedef struct page *pgtable_t;
> > >   #define __pgd(x)	((pgd_t) { (x) })
> > >   #define __pgprot(x)	((pgprot_t) { (x) })
> > > -#endif /* !__ASSEMBLY__ */
> > > +#endif /* !__ASSEMBLER__ */
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
> > >   #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
> > > @@ -73,7 +73,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
> > >   #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
> > > -#endif /* __ASSEMBLY__ */
> > > +#endif /* __ASSEMBLER__ */
> > >   #include <asm-generic/memory_model.h>
> > >   #include <asm-generic/getorder.h>
> > > diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> > > index 60c6ce7ff2dcf..cd979bd28ab3b 100644
> > > --- a/arch/openrisc/include/asm/pgtable.h
> > > +++ b/arch/openrisc/include/asm/pgtable.h
> > > @@ -23,7 +23,7 @@
> > >   #include <asm-generic/pgtable-nopmd.h>
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   #include <asm/mmu.h>
> > >   #include <asm/fixmap.h>
> > > @@ -432,5 +432,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> > >   typedef pte_t *pte_addr_t;
> > > -#endif /* __ASSEMBLY__ */
> > > +#endif /* __ASSEMBLER__ */
> > >   #endif /* __ASM_OPENRISC_PGTABLE_H */
> > > diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
> > > index e05d1b59e24e1..3ff893a67c13b 100644
> > > --- a/arch/openrisc/include/asm/processor.h
> > > +++ b/arch/openrisc/include/asm/processor.h
> > > @@ -39,7 +39,7 @@
> > >    */
> > >   #define TASK_UNMAPPED_BASE      (TASK_SIZE / 8 * 3)
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   struct task_struct;
> > > @@ -78,5 +78,5 @@ void show_registers(struct pt_regs *regs);
> > >   #define cpu_relax()     barrier()
> > > -#endif /* __ASSEMBLY__ */
> > > +#endif /* __ASSEMBLER__ */
> > >   #endif /* __ASM_OPENRISC_PROCESSOR_H */
> > > diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
> > > index e5a282b670757..28facf2f3e00c 100644
> > > --- a/arch/openrisc/include/asm/ptrace.h
> > > +++ b/arch/openrisc/include/asm/ptrace.h
> > > @@ -27,7 +27,7 @@
> > >    * they share a cacheline (not done yet, though... future optimization).
> > >    */
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   /*
> > >    * This struct describes how the registers are laid out on the kernel stack
> > >    * during a syscall or other kernel entry.
> > > @@ -147,7 +147,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
> > >   	return *(unsigned long *)((unsigned long)regs + offset);
> > >   }
> > > -#endif /* __ASSEMBLY__ */
> > > +#endif /* __ASSEMBLER__ */
> > >   /*
> > >    * Offsets used by 'ptrace' system call interface.
> > > diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
> > > index 9acbc5deda691..dce9f4d3b378f 100644
> > > --- a/arch/openrisc/include/asm/setup.h
> > > +++ b/arch/openrisc/include/asm/setup.h
> > > @@ -8,7 +8,7 @@
> > >   #include <linux/init.h>
> > >   #include <asm-generic/setup.h>
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   void __init or1k_early_setup(void *fdt);
> > >   #endif
> > > diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
> > > index 4af3049c34c21..e338fff7efb0e 100644
> > > --- a/arch/openrisc/include/asm/thread_info.h
> > > +++ b/arch/openrisc/include/asm/thread_info.h
> > > @@ -17,7 +17,7 @@
> > >   #ifdef __KERNEL__
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   #include <asm/types.h>
> > >   #include <asm/processor.h>
> > >   #endif
> > > @@ -38,7 +38,7 @@
> > >    * - if the contents of this structure are changed, the assembly constants
> > >    *   must also be changed
> > >    */
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   struct thread_info {
> > >   	struct task_struct	*task;		/* main task structure */
> > > @@ -58,7 +58,7 @@ struct thread_info {
> > >    *
> > >    * preempt_count needs to be 1 initially, until the scheduler is functional.
> > >    */
> > > -#ifndef __ASSEMBLY__
> > > +#ifndef __ASSEMBLER__
> > >   #define INIT_THREAD_INFO(tsk)				\
> > >   {							\
> > >   	.task		= &tsk,				\
> > > @@ -75,7 +75,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
> > >   #define get_thread_info(ti) get_task_struct((ti)->task)
> > >   #define put_thread_info(ti) put_task_struct((ti)->task)
> > > -#endif /* !__ASSEMBLY__ */
> > > +#endif /* !__ASSEMBLER__ */
> > >   /*
> > >    * thread information flags
> > > -- 2.48.1
> > > 
> > 
> > Friendly ping!
> > 
> > Jonas, Stefan, Stafford, could you maybe pick this (and the previous patch)
> > up via your openrisc tree? (x86 and parisc already got merge via their
> > respective architecture trees, so I guess the same should happen for this
> > patch here, too).
> 
> Hi Thomas,
> 
> Sure, this might not make it for the 6.16 merge window as we may not have time
> for it to have a cycle in linux-next.  Is that ok?

I have now put this in the OpenRISC queue.  Note, I didn't pay much attention to
this series as it seemed generally OK to me and usually I figured these trivial
treewide patches should be merged via other means.

I expect it will take time to get all maintainers pick these up individually.

Do you have a plan for those?  In the past I think Arnd has helped.

-Stafford
