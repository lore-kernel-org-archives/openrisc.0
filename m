Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DF1805B
	for <linux-openrisc@vger.kernel.org>; Fri,  6 Jun 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749239109; cv=none; b=rAgTcyX+yhuvfMjQzBVGaAEeQweeEh1pQmj6q8rz6kS0x4bkbl6ssFhx9RB1hRSBdObxLeaNitYZOcalErzVmJ20qEsdqQiLWqa4GdCM0aC/j47HsdAOIAksAiu7bG5ozpGvkdo/kaT749C/3R8nLEP6OtJ1RX4s3aGVShLPEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749239109; c=relaxed/simple;
	bh=CVP1wfaTisYF5ukBSEouYcKJ+cNFCcYEeLYLa4pDoNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIvopw9vnzzeBsTKaw2+FE4Iqj1h5YGBME0cnMKzSKpJLCI9E8kwSCZL76vXuHGB8alBOY03PliZvFx/b7OWJFQ5lC/U8P7EuW1usWRO9si5yZP3VGJ4ElTcP9NuBBflg0stJAcg43FCb2G5gjyUiwxxn8bAx7bRyIkmmlkgHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI4mJqa5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI4mJqa5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so29998695e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 06 Jun 2025 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749239105; x=1749843905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/iCeLDNhTW0cWoIAmpwAOBwHgAC7qxwW6Ega+LrpjUg=;
        b=bI4mJqa5StkWPgvjetlUGAHJaHAHTZ/RoWtoVlVP+XEaZPZADc3LDcmkoJ6BzQISoo
         FNsSO6//O0c67qoQSOMeY5zkjtoG7/H/qHUl7QdnGv8JyV+mDlNaAE35V2GmIdY9wv2t
         kOQVGiw4PjgfMrocUrWS/xzGyAQH78l2EreP5mE6XhGuLXzD4N9lvWC/WlBPhl9xPW1+
         lxkNPrF5zxrX7qVJwn9itj8EVhXsZ8oA6riz5qLpgM4N2jyf9oqCCqCizZeUkpcYsOEf
         aKlIlZJXtlGmx/c4UyY/PQRgJX3Fa/0WVu4tKR2jlG9nmvI5oc1XeAWpK197HKxc1ao1
         C0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749239105; x=1749843905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iCeLDNhTW0cWoIAmpwAOBwHgAC7qxwW6Ega+LrpjUg=;
        b=YzlJGenJmo77lc5CLvWzP5mDXx0pWX/zOe3YX3hxm4Hfs9aj3kwFJO24otEHhPGNVG
         /A+a2lEHRoNRQhWa7swvJ/zkQoLCbyyW0ZusCkLtGOa1erlxyPITyzME3d4smJ5Qj/ND
         W+HFQWZJ+1AIYxlQnZ1Wxz3iDKRZ4JVONeCPuQurUI4KPiQTYwXImmf/P69m1Urp5rKn
         JcitAyC/63zfAnEpt1JdYicZY5Te2BDFKwwtcZ4xQqKx/optY9uv5WmU0QrkTf2CB2C5
         lOECacXnbXsaNcWklj8MH9xlFPnG6kj+RNNgdpVy8kkiBegTRA8KsT92+xzL68vhNN6C
         X7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUrDiNPhRMSBLUh4xzbvrqQgyi1E46LZDm/UlmLFILoukSnnY4tCtdrqcMbt2zItJVVx2UOKdeUnK3kE/Zr0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQerdEPlVBQwwTwBWagA0Jl8Nd3G2o5GjvE5J8c2uZssdxN2g
	IdHfnIFj+B1JcFP1ljjUseVIflNy5uuUWvFF0nn7R6YfL6Au0ZXZmqTzCLB2Gw==
X-Gm-Gg: ASbGncsSH6mp8Ht09k2J93S5tsr8FgZhIG3eKmO1PsaJIEe8RzQRh69XLWUQCrSmtPH
	VciZBCihEwmcQwZdaSI22t7Ng1ckLH7gNnig2aXsZgb7wXA0BBhP8N4kjqv8qFOg6BCPK3Iz5pp
	+wNtpplK6enAFWeeL+YD2UJNRyF/r17SaIPw3duIaI4VFKsnR8OXW8Dd9qEjgbYwEe985U9mMVf
	HjcRyfLY2fOy+Rc8MvfFpYqkO3yX61xAoryw102tmIOXe7X1iEPsMmOYxMHFgpCQHF9/Almkkfi
	VjpVHypEgmRBk1asbnLaVbAbpPuIaMgyJqrE48nasRWRPsaCfC9K5zFUttzpheRDvchYNxYQSk8
	aqdoSgQF+8hTI5SykhX4Oq1zuig==
X-Google-Smtp-Source: AGHT+IFkhD0B4edf8JV5WoNpslcI+6DC9QyQoU8qWT4xpT/DnMrnWUXBpS034Thuk3hiohF+oXA9Lg==
X-Received: by 2002:a05:600c:1d86:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-452013ab8e3mr59995215e9.16.1749239104942;
        Fri, 06 Jun 2025 12:45:04 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324360fasm2747068f8f.56.2025.06.06.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 12:45:03 -0700 (PDT)
Date: Fri, 6 Jun 2025 20:45:02 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH 23/41] openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__
 in non-uapi headers
Message-ID: <aENFPqbFFLOh3uSZ@antec>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-24-thuth@redhat.com>
 <389d8e93-0dbf-4b69-a80c-bf1e9c93b0ff@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389d8e93-0dbf-4b69-a80c-bf1e9c93b0ff@redhat.com>

On Fri, Jun 06, 2025 at 08:42:28AM +0200, Thomas Huth wrote:
> On 14/03/2025 08.09, Thomas Huth wrote:
> > While the GCC and Clang compilers already define __ASSEMBLER__
> > automatically when compiling assembly code, __ASSEMBLY__ is a
> > macro that only gets defined by the Makefiles in the kernel.
> > This can be very confusing when switching between userspace
> > and kernelspace coding, or when dealing with uapi headers that
> > rather should use __ASSEMBLER__ instead. So let's standardize on
> > the __ASSEMBLER__ macro that is provided by the compilers now.
> > 
> > This is a completely mechanical patch (done with a simple "sed -i"
> > statement).
> > 
> > Cc: Jonas Bonn<jonas@southpole.se>
> > Cc: Stefan Kristiansson<stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne<shorne@gmail.com>
> > Cc:linux-openrisc@vger.kernel.org
> > Signed-off-by: Thomas Huth<thuth@redhat.com>
> > ---
> >   arch/openrisc/include/asm/mmu.h         | 2 +-
> >   arch/openrisc/include/asm/page.h        | 8 ++++----
> >   arch/openrisc/include/asm/pgtable.h     | 4 ++--
> >   arch/openrisc/include/asm/processor.h   | 4 ++--
> >   arch/openrisc/include/asm/ptrace.h      | 4 ++--
> >   arch/openrisc/include/asm/setup.h       | 2 +-
> >   arch/openrisc/include/asm/thread_info.h | 8 ++++----
> >   7 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/openrisc/include/asm/mmu.h b/arch/openrisc/include/asm/mmu.h
> > index eb720110f3a20..e7826a681bc4a 100644
> > --- a/arch/openrisc/include/asm/mmu.h
> > +++ b/arch/openrisc/include/asm/mmu.h
> > @@ -15,7 +15,7 @@
> >   #ifndef __ASM_OPENRISC_MMU_H
> >   #define __ASM_OPENRISC_MMU_H
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   typedef unsigned long mm_context_t;
> >   #endif
> > diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> > index c589e96035e15..85797f94d1d74 100644
> > --- a/arch/openrisc/include/asm/page.h
> > +++ b/arch/openrisc/include/asm/page.h
> > @@ -25,7 +25,7 @@
> >    */
> >   #include <asm/setup.h>
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   #define clear_page(page)	memset((page), 0, PAGE_SIZE)
> >   #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
> > @@ -55,10 +55,10 @@ typedef struct page *pgtable_t;
> >   #define __pgd(x)	((pgd_t) { (x) })
> >   #define __pgprot(x)	((pgprot_t) { (x) })
> > -#endif /* !__ASSEMBLY__ */
> > +#endif /* !__ASSEMBLER__ */
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
> >   #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
> > @@ -73,7 +73,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
> >   #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
> > -#endif /* __ASSEMBLY__ */
> > +#endif /* __ASSEMBLER__ */
> >   #include <asm-generic/memory_model.h>
> >   #include <asm-generic/getorder.h>
> > diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> > index 60c6ce7ff2dcf..cd979bd28ab3b 100644
> > --- a/arch/openrisc/include/asm/pgtable.h
> > +++ b/arch/openrisc/include/asm/pgtable.h
> > @@ -23,7 +23,7 @@
> >   #include <asm-generic/pgtable-nopmd.h>
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   #include <asm/mmu.h>
> >   #include <asm/fixmap.h>
> > @@ -432,5 +432,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> >   typedef pte_t *pte_addr_t;
> > -#endif /* __ASSEMBLY__ */
> > +#endif /* __ASSEMBLER__ */
> >   #endif /* __ASM_OPENRISC_PGTABLE_H */
> > diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
> > index e05d1b59e24e1..3ff893a67c13b 100644
> > --- a/arch/openrisc/include/asm/processor.h
> > +++ b/arch/openrisc/include/asm/processor.h
> > @@ -39,7 +39,7 @@
> >    */
> >   #define TASK_UNMAPPED_BASE      (TASK_SIZE / 8 * 3)
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   struct task_struct;
> > @@ -78,5 +78,5 @@ void show_registers(struct pt_regs *regs);
> >   #define cpu_relax()     barrier()
> > -#endif /* __ASSEMBLY__ */
> > +#endif /* __ASSEMBLER__ */
> >   #endif /* __ASM_OPENRISC_PROCESSOR_H */
> > diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
> > index e5a282b670757..28facf2f3e00c 100644
> > --- a/arch/openrisc/include/asm/ptrace.h
> > +++ b/arch/openrisc/include/asm/ptrace.h
> > @@ -27,7 +27,7 @@
> >    * they share a cacheline (not done yet, though... future optimization).
> >    */
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   /*
> >    * This struct describes how the registers are laid out on the kernel stack
> >    * during a syscall or other kernel entry.
> > @@ -147,7 +147,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
> >   	return *(unsigned long *)((unsigned long)regs + offset);
> >   }
> > -#endif /* __ASSEMBLY__ */
> > +#endif /* __ASSEMBLER__ */
> >   /*
> >    * Offsets used by 'ptrace' system call interface.
> > diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
> > index 9acbc5deda691..dce9f4d3b378f 100644
> > --- a/arch/openrisc/include/asm/setup.h
> > +++ b/arch/openrisc/include/asm/setup.h
> > @@ -8,7 +8,7 @@
> >   #include <linux/init.h>
> >   #include <asm-generic/setup.h>
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   void __init or1k_early_setup(void *fdt);
> >   #endif
> > diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
> > index 4af3049c34c21..e338fff7efb0e 100644
> > --- a/arch/openrisc/include/asm/thread_info.h
> > +++ b/arch/openrisc/include/asm/thread_info.h
> > @@ -17,7 +17,7 @@
> >   #ifdef __KERNEL__
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   #include <asm/types.h>
> >   #include <asm/processor.h>
> >   #endif
> > @@ -38,7 +38,7 @@
> >    * - if the contents of this structure are changed, the assembly constants
> >    *   must also be changed
> >    */
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   struct thread_info {
> >   	struct task_struct	*task;		/* main task structure */
> > @@ -58,7 +58,7 @@ struct thread_info {
> >    *
> >    * preempt_count needs to be 1 initially, until the scheduler is functional.
> >    */
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   #define INIT_THREAD_INFO(tsk)				\
> >   {							\
> >   	.task		= &tsk,				\
> > @@ -75,7 +75,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
> >   #define get_thread_info(ti) get_task_struct((ti)->task)
> >   #define put_thread_info(ti) put_task_struct((ti)->task)
> > -#endif /* !__ASSEMBLY__ */
> > +#endif /* !__ASSEMBLER__ */
> >   /*
> >    * thread information flags
> > -- 2.48.1
> > 
> 
> Friendly ping!
> 
> Jonas, Stefan, Stafford, could you maybe pick this (and the previous patch)
> up via your openrisc tree? (x86 and parisc already got merge via their
> respective architecture trees, so I guess the same should happen for this
> patch here, too).

Hi Thomas,

Sure, this might not make it for the 6.16 merge window as we may not have time
for it to have a cycle in linux-next.  Is that ok?

-Stafford
