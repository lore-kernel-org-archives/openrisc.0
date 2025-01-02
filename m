Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62EA1392
	for <linux-openrisc@vger.kernel.org>; Thu,  2 Jan 2025 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735780107; cv=none; b=mkC344xDfjK4F1sDC8BIEHqSqbsHvDDEGz5xHxsC7iwmSha5pSR9h4TWhxlqD5zjh5BVkMhDCK36d6NMSuTs3ifInP8fDLVNQBxMZJK57M8AckhO74heO8tERaHsCqm4tTDey6nmSztcB2y9B+O4oNKyzgvo7fbM9Q88v1mJsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735780107; c=relaxed/simple;
	bh=RQt+mZoVIY9qfB8fzq9bdSLxSMxcKbQ2XBuA1swTlqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdZG6qMhvhZ64uXeXMLx0W7FLjlPJYj+wTWoatEelTMR4jNyo4p8+7xRG5NFzsi0Vu2qhcIXlkGlID/tiHsxdEEpgBdYh8XSh6POUnIwCLnWMzGJXaxSzDmmcLkK+JWK50rwvMzvn0uTwCalAebaGXyB0gNPBzdckrn4cdm8g3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJzcQIqj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJzcQIqj"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e3621518so5128859f8f.1
        for <linux-openrisc@vger.kernel.org>; Wed, 01 Jan 2025 17:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735780104; x=1736384904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXW+tVyNlOTbq3/jybseJqdq1KoHsRtQcauQhRRLAWY=;
        b=nJzcQIqjZD/ilSZfgyEEDrKHDnh+pwYqhZ+XppulfUgot1gGD8u/XozycUNKK/46yd
         QXMZQv9xgS07Y0e/VaW96uNoRXujwGoCxLDLcZTLWsNR2xpxElYnCraeR3Qj1cdfu9j+
         vWO3UWeUglj0AImQHtQwqQeDhtccOfSDF4EeqBTDbn27O3pPzzo6kPovE38Iq/lsaYAU
         T9jclC61AUL+pU8pSGsqZYzFAF+dVvtYvEI0l2RAa5qMHapINWnQgfFQXx+GWu4SNSVV
         zaIUN1DLnCtcrnoqfDFwusABTXscNGVPTgXsy+rF2W9qqv9M2qW2FqD30Ob0oSAJzkht
         cyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735780104; x=1736384904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXW+tVyNlOTbq3/jybseJqdq1KoHsRtQcauQhRRLAWY=;
        b=iPg4kfBZ6/ISMcOAhDJZqABwwMkVoZQXBp0K8uxcXTQ6C+cIaIQTdqaYUYUi55oc3U
         Ltbg0BI50GhiUJ0TIvw4ruSoH0vML+OagtxrMR88JhfNXpOckY5I6Ml5lmq3ShcO7K1U
         umNP9eAfGfEgnUYdB5lwysWYOcdXYc2FeqsAeofBILbFTFlShQollkdkXzkZir4xfsPI
         xL9AeAmGhvVHm60pApJdmD+H2HWVqJdts+nFvJB7SeyuWi6HVZ1Yy3ubQq0psjj1gqQ+
         VCIoUqiBhlLYQD5QUEvUfNlo5Xshp8UWVXQdViR5dCHMMtXbhrrGsgRSMxfnB0EgV2jO
         ZLuQ==
X-Gm-Message-State: AOJu0Yz4VngX/1zXGN4sRFxQDfhK+Jzcpd7y8NGbX6vw5BainafrSQtT
	aXC21Y4Si5bzSTcZ2B2siKF7C0eIBgUYxrM5REVexAzeViAsxiVP2IRoalhD
X-Gm-Gg: ASbGncs8bwOTJJY721/131GYPUSEEamMvlyZGjbzdfKP/j8LGLHp7r2n40qpTHE5Ilt
	vQnO46kdv04tLyqj/l7KuU49BhJtj/IutwSiyDKOBTFjk1MjJqPSS8SBdOzR4y6BJlYTihF4Plj
	NxQfgs+Ea8w4o+td7ar1XHAoEleTpw8BhrxNBokODWkVU6hfusxtFDX51A0XydGW8wAk2nBysA7
	eUCfqvUrKfa1jylAUTICovyHZZKga9X4O/NVylKp2Y6PfFCQzAQJo1Bb9gk1GL/3rZTe6Oyre27
	0vvphpZNiNwMwdbNOxcd
X-Google-Smtp-Source: AGHT+IH9tbTL/NnkcBG3sfZ5I42TERls/dTCtuLKyCtw2Xze8KuamxkZKgyDgvy+rPHkzlH5VgONvw==
X-Received: by 2002:a5d:64c8:0:b0:388:c75c:e839 with SMTP id ffacd0b85a97d-38a223f7167mr35442927f8f.42.1735780103804;
        Wed, 01 Jan 2025 17:08:23 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b214sm474864935e9.28.2025.01.01.17.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 17:08:20 -0800 (PST)
Date: Thu, 2 Jan 2025 01:08:18 +0000
From: Stafford Horne <shorne@gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	GLIBC patches <libc-alpha@sourceware.org>
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
Message-ID: <Z3XnAt7z1xWermeI@antec>
References: <ZzJ-T-5VFZ8gZEf7@antec>
 <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec>
 <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com>
 <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com>
 <Z11l_-7RV07JRwCo@antec>
 <Z2sXcENuw--JWlx6@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2sXcENuw--JWlx6@antec>

On Tue, Dec 24, 2024 at 08:20:00PM +0000, Stafford Horne wrote:
> On Sat, Dec 14, 2024 at 11:03:27AM +0000, Stafford Horne wrote:
> > +CC Lists,
> > 
> > They should have been included for all of these.
> > 
> > On Fri, Dec 13, 2024 at 11:22:32AM -0500, Michael Jeanson wrote:
> > > On 2024-12-12 07:41, Stafford Horne wrote:
> > > > On Tue, Dec 10, 2024 at 03:30:05PM -0500, Michael Jeanson wrote:
> > > >> On 2024-12-10 13:56, Michael Jeanson wrote:
> > > >>>> I started adding rseq support to OpenRISC, but it seems I need to do a bit more
> > > >>>> for me than just call rseq_signal_deliver().  OpenRISC does not implement
> > > >>>> HAVE_REGS_AND_STACK_ACCESS_API yet, so I will need to do that first.  Also I
> > > >>>> need to think of an instruction to use for RSEQ_SIG, but that should not be too
> > > >>>> hard.
> > > >>>
> > > >>> Do you have a WIP tree somewhere I can have a look at? Assuming you add
> > > >>> HAVE_REGS_AND_STACK_ACCESS_API, the rest should be pretty simple.
> > > >>
> > > >> I had a quick look at the kernel code and it looks pretty straightforward,
> > > >> I hacked this together just to see if it would build :
> > > >>
> > > >>   https://github.com/mjeanson/linux/commits/openrisc-rseq/
> > > >>
> > > >> This is thoroughly untested and only cross-compiled.
> > > > 
> > > > Thanks, while you were doing this I did something similar but took a much
> > > > shorter route, I only implemented the APIs used by rseq.
> > > > 
> > > > I have pushed branches for linux and glibc here:
> > > > 
> > > >  - https://github.com/stffrdhrn/or1k-glibc/commits/or1k-rseq/
> > > >  - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
> > > 
> > > You might also want to add a call to 'rseq_syscall' in arch/openrisc/kernel/entry.S
> > > on return to userspace when CONFIG_DEBUG_RSEQ is enabled.
> > 
> > Yes, I am aware of that one, but I think I discovered an issue with the return to
> > userspace code that needs some cleanup before I can add that in.
> 
> I think this ended up being ok.
> 
> I have added the call to rseq_syscall and implemented self tests on my branch
> now.
> 
>  - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
>  - commit 1fa73dd6c2d3 ("rseq/selftests: Add support for OpenRISC")
> 
> I haven't got the tests to complete fully yet though.  Do you have a recommended
> approach for building, testing and debugging them?  I am using my glibc
> toolchain, but I assume the original implementations didnt have glibc support
> available when they were testing.
> 
> My stack now:
> 
>   - QEMU virt
>   - Linux virt_defconfig (or1k-rseq branch)
>     - rseq selftests - built with gcc/glibc toolchain (or1k-rseq branch)
>   - rootfs - Buildroot with my glibc (or1k-rseq branch)
>     - gdb
>     - strace
> 
> In general I am using the latest git HEADs for qemu, gcc, binutils etc.
> 
> Once, everything is working on QEMU I will test again on the FPGA hardware.
> 
> Currently tests are failing with SIGSEGV:
> 
>     TAP version 13
>     1..10
>     # timeout set to 0
>     # selftests: rseq: basic_test
>     # testing current cpu
>     ok 1 selftests: rseq: basic_test
>     # timeout set to 0
>     # selftests: rseq: basic_percpu_ops_test
>     # spinlock
>     # ./kselftest/runner.sh: line 37:   772 Segmentation fault      /usr/bin/timeout  --foreground "$kselftest_timeout" /usr/bin/timeout "$kselftest_timeout" $1
>     not ok 2 selftests: rseq: basic_percpu_ops_test # exit=139
> 
> In gdb it looks to be happening in in an mprotect syscall in glibc and at that
> point the stack seems to be corrupt already.  So its taking me a bit of time to
> untangle.

I was able to get this fixed, the issue was with how I was setting up the
rseq_cs in rseq-or1k.h.  There were some other problems too which I fixed.

Now, some of the tests are passing.

I have been making progress with some kernel printk's in kernel/rseq.c and using
gdb.  I should be able to get the remaining issues fixed up before too long.

-Stafford
