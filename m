Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F25647
	for <linux-openrisc@vger.kernel.org>; Sun,  5 Jan 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736059703; cv=none; b=rruHYCGd5r3Ni6LCXzq01eGhBFjPSNZfgq0OAyzw+DQvWWgs1XdImULrM9lXgPK3KULu/qHOnmYwppG1RICVJWdFa7AXgyzrjpmCMJsC9TJpR7NJ208frHnJ4UV9MRVYOgJz7/LYnqnkDqnf93rD6UfvUT1/jzm3kt2MshU88Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736059703; c=relaxed/simple;
	bh=8ZZNgm0Z7dXatacK85xzmQHBBuZTBGFyGqN5jMFRsJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvMpvqGzyjF3dnDaZ7eoUB8E0ddO3umfact7HAJIF6t7c+9i1KzpJM3F4fuD18kQ4lxu0CijQTQsVm2uVwfWJlFRbF6+OJA/BHmnv/azlpkT5lQxN/JeKvVBuxpbjX+nlgXGbtWulKC+iikjipqTel6xZbjaa9nDUm22/72x4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTzqTyS1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTzqTyS1"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so10544369f8f.0
        for <linux-openrisc@vger.kernel.org>; Sat, 04 Jan 2025 22:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736059699; x=1736664499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZIncnD2rWg1e9MYKu2KFef1/lJdPWpLw/JOWYDMPGY=;
        b=MTzqTyS10HDxZUpNgx3Irdb7Oy2nB7hwDSrYdbYW/ECCRZ54DAt/t1cPyXOKoRp/Vk
         LfxxQV7/a54z4Q+/ot23Iml9+qFVdBCFQ40lOE+uqEYrsXvBi4HoPZPOfutIEyWv5di4
         4zve4C0tOjTKwJupnidVY5/T1V5z14ADg0T8ZZRGjnNTxgdaHNrYgQhVKAO5rwrJmAcG
         SoqIuBwKxdlJJEu+XcATqA5QrmMBW5/fUGjCvG1jXU+IfSRkfK8VF3I26+4yI6xcCn1P
         gBSl0b6oc6vrMJAMsoeSGlG2WZTIZE848LT17yER5hh4u0MWMG4IpVVjgKS9mSrfa7Q8
         dO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736059699; x=1736664499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZIncnD2rWg1e9MYKu2KFef1/lJdPWpLw/JOWYDMPGY=;
        b=ZX3R7/4Vx4NRDw75NGzRnmEitG0t5eUexkw/Dvo/OcmWZtE0NYO2DPj5p8rXkZtBxV
         Ipvh2843SvmJc/Sy+TreE4ntQATdR09hd9bW4BeAFBEFbXEEt9ACXkd+GH67z44fFR+D
         fneqXQx/KzByMMVzXmLyarNMACy53PbKp41xB2/96Lgj94ZOnJtEfgmR+fGLkuYzlxGF
         KjU6I05o+ef7aUIRtTwTuTx4U0iWqNgvaup3btmn0TX+Z2N6wf4lOXLetDmGzDg9GGyP
         mM5fg0fvC3YI2FyyOo0EZPX/rpK1gIfCQp15y2IiSJFvtflbJUh3Mnf0pFVMRfzLGmIZ
         QyFg==
X-Gm-Message-State: AOJu0Ywfq/tgNdtBCA1CrhmWFQvVcWuToYzqBeWmrPkTvFcMH+rJ+BCr
	FEOjsWbxj+4+Yc8Y2cATDelAtCOzaOQ+D73Yzn7BA72mZcQlwsgt/UR7Ww==
X-Gm-Gg: ASbGncsQzGsYBRAAJZFweVDeyUD9O6lXud2hN6YHY4P0HiEwbzTPZMDLT6K9f2SAIta
	wO/0mq7EX13E1FCjeKV9wtePquLj7mglCR2sJaORbIQO3sC/Q4M/skncf2j91GwdR403KiqdoVW
	CghdDnZRm3TgK1tARvvuzqKB77ppFIgdnp29rh5ybMLGMumgBmCtOBEPFRqEPWykoXw1dMXV2GB
	dCMbg4S84YKT7aztCHmn0CqHpEvFHAP3Fdxkd1S9i8hWzYcevct6rRehC/QbRRIiBlpTlp2fDlJ
	lJ6fSZjQUePokyXEsH0W
X-Google-Smtp-Source: AGHT+IFjIopGL+6Y6OftaOmY1TnJkdrdTEe4YbTUUtXyHVhaLkR4pmg9p46YkCIbc+KxLA3ScB+E0g==
X-Received: by 2002:adf:ab17:0:b0:386:4a0d:bb23 with SMTP id ffacd0b85a97d-38a221ed2f2mr36307147f8f.11.1736059698300;
        Sat, 04 Jan 2025 22:48:18 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8292adsm44527824f8f.19.2025.01.04.22.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 22:48:16 -0800 (PST)
Date: Sun, 5 Jan 2025 06:48:15 +0000
From: Stafford Horne <shorne@gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	GLIBC patches <libc-alpha@sourceware.org>
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
Message-ID: <Z3orL1GN8DjVRQiT@antec>
References: <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec>
 <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com>
 <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com>
 <Z11l_-7RV07JRwCo@antec>
 <Z2sXcENuw--JWlx6@antec>
 <Z3XnAt7z1xWermeI@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3XnAt7z1xWermeI@antec>

On Thu, Jan 02, 2025 at 01:08:18AM +0000, Stafford Horne wrote:
> On Tue, Dec 24, 2024 at 08:20:00PM +0000, Stafford Horne wrote:
> > On Sat, Dec 14, 2024 at 11:03:27AM +0000, Stafford Horne wrote:
> > > +CC Lists,
> > > 
> > > They should have been included for all of these.
> > > 
> > > On Fri, Dec 13, 2024 at 11:22:32AM -0500, Michael Jeanson wrote:
> > > > On 2024-12-12 07:41, Stafford Horne wrote:
> > > > > On Tue, Dec 10, 2024 at 03:30:05PM -0500, Michael Jeanson wrote:
> > > > >> On 2024-12-10 13:56, Michael Jeanson wrote:
> > > > >>>> I started adding rseq support to OpenRISC, but it seems I need to do a bit more
> > > > >>>> for me than just call rseq_signal_deliver().  OpenRISC does not implement
> > > > >>>> HAVE_REGS_AND_STACK_ACCESS_API yet, so I will need to do that first.  Also I
> > > > >>>> need to think of an instruction to use for RSEQ_SIG, but that should not be too
> > > > >>>> hard.
> > > > >>>
> > > > >>> Do you have a WIP tree somewhere I can have a look at? Assuming you add
> > > > >>> HAVE_REGS_AND_STACK_ACCESS_API, the rest should be pretty simple.
> > > > >>
> > > > >> I had a quick look at the kernel code and it looks pretty straightforward,
> > > > >> I hacked this together just to see if it would build :
> > > > >>
> > > > >>   https://github.com/mjeanson/linux/commits/openrisc-rseq/
> > > > >>
> > > > >> This is thoroughly untested and only cross-compiled.
> > > > > 
> > > > > Thanks, while you were doing this I did something similar but took a much
> > > > > shorter route, I only implemented the APIs used by rseq.
> > > > > 
> > > > > I have pushed branches for linux and glibc here:
> > > > > 
> > > > >  - https://github.com/stffrdhrn/or1k-glibc/commits/or1k-rseq/
> > > > >  - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
> > > > 
> > > > You might also want to add a call to 'rseq_syscall' in arch/openrisc/kernel/entry.S
> > > > on return to userspace when CONFIG_DEBUG_RSEQ is enabled.
> > > 
> > > Yes, I am aware of that one, but I think I discovered an issue with the return to
> > > userspace code that needs some cleanup before I can add that in.
> > 
> > I think this ended up being ok.
> > 
> > I have added the call to rseq_syscall and implemented self tests on my branch
> > now.
> > 
> >  - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
> >  - commit 1fa73dd6c2d3 ("rseq/selftests: Add support for OpenRISC")
> > 
> > I haven't got the tests to complete fully yet though.  Do you have a recommended
> > approach for building, testing and debugging them?  I am using my glibc
> > toolchain, but I assume the original implementations didnt have glibc support
> > available when they were testing.
> > 
> > My stack now:
> > 
> >   - QEMU virt
> >   - Linux virt_defconfig (or1k-rseq branch)
> >     - rseq selftests - built with gcc/glibc toolchain (or1k-rseq branch)
> >   - rootfs - Buildroot with my glibc (or1k-rseq branch)
> >     - gdb
> >     - strace
> > 
> > In general I am using the latest git HEADs for qemu, gcc, binutils etc.
> > 
> > Once, everything is working on QEMU I will test again on the FPGA hardware.
> > 
> > Currently tests are failing with SIGSEGV:
> > 
> >     TAP version 13
> >     1..10
> >     # timeout set to 0
> >     # selftests: rseq: basic_test
> >     # testing current cpu
> >     ok 1 selftests: rseq: basic_test
> >     # timeout set to 0
> >     # selftests: rseq: basic_percpu_ops_test
> >     # spinlock
> >     # ./kselftest/runner.sh: line 37:   772 Segmentation fault      /usr/bin/timeout  --foreground "$kselftest_timeout" /usr/bin/timeout "$kselftest_timeout" $1
> >     not ok 2 selftests: rseq: basic_percpu_ops_test # exit=139
> > 
> > In gdb it looks to be happening in in an mprotect syscall in glibc and at that
> > point the stack seems to be corrupt already.  So its taking me a bit of time to
> > untangle.
> 
> I was able to get this fixed, the issue was with how I was setting up the
> rseq_cs in rseq-or1k.h.  There were some other problems too which I fixed.
> 
> Now, some of the tests are passing.
> 
> I have been making progress with some kernel printk's in kernel/rseq.c and using
> gdb.  I should be able to get the remaining issues fixed up before too long.

Hello,

I have all of the tests passing now under OpenRISC.  I would like to clean up
the commit messages and send the changes for review.  I incorporated your
HAVE_REGS_AND_STACK_ACCESS_API patch with my changes put it on my branch here:

 https://github.com/stffrdhrn/linux/commits/or1k-rseq/

Your commit does not have a Signed-off-by.  I am happy with the change, could you
fixup the commit message and submit it as a patch?  Or is OK if I do that and
add your Signed-off-by?

-Stafford
