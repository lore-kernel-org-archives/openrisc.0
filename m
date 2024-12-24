Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80D17996
	for <linux-openrisc@vger.kernel.org>; Tue, 24 Dec 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735071609; cv=none; b=qClGKvIFf63wiOcv7QWzJxW6NwWK8tIxcV6Tn3NEuzNMC2QvTacQTsh6ZL1DiSAtXeo7NoDhEgThw6KtIVywVeXaiXj3XDrnkAx7BGpwEf9DZKsh5vOxVrRNRONOIL/7kIvnr0jSEjBY6bnyOefsjMFfg0QJGkZGNx5etl/R3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735071609; c=relaxed/simple;
	bh=NbTSWFXz6Eh4CKJa9rqiMMWgfXuetnFsqx5MvzdH5Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piyVC4MVSNMM0Fcsv84GwNbqTd50K1x40KASlhaPh6MzaT5uatRAGSzzo3MOgJVVQ0xNvNE3rI2IXZJWW3Q+ftb0vcNV/QxUybAKCQIhxZSettWOsLRmUWcUwUwqICBpviAHGkJ4xbVd0MGTcctZERAsUxM4ziJkZNKZ//tZft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae0YAf9x; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae0YAf9x"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso4634421f8f.1
        for <linux-openrisc@vger.kernel.org>; Tue, 24 Dec 2024 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735071605; x=1735676405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7Pey9rXArqJvfAxmxOrdrxqfM/gCIyHOw8FfQUqsE4=;
        b=Ae0YAf9xDl1DJBKiWBUumphpgMt8TFbLt0yRskaIVgu4+YDyp2YazLx+o8652tWCo4
         sY5Eevn7RxPDCqwwGoNG06pRKV3OMceSGFu8NHuAB5PsH4I/bVgbHqVMCzzwOBcet0WT
         Qr7PPT+zr5C1OfvVH1apzVvz0A2agWIupChS+QnkXbPrZA17KwitkX6L3Lh3W4IVBhEd
         8mWlrp9/8JelXNujXB5rHq6XNySyywhZMhngnYL6kNNCGMbAXWFo4WKpBIGS725QK5Z0
         iiJ+wY5IBoF2+oFC8ZC6b1Q4JjwEr5DLnittOCKRUNrl4DHzWGPGfNVf8qIAB+vIKLLZ
         w0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735071605; x=1735676405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7Pey9rXArqJvfAxmxOrdrxqfM/gCIyHOw8FfQUqsE4=;
        b=dwwIzGcCu+QqvVeW4dNfQ6NoAybmX1819B5yCviEoz6Pk/k0BVyOL8gMnZDpXSmZjd
         9qAEaB01Zsrwx4EMFoeWNbMQuKJiOCC4M8P0sLur7DZJhbpVNxDfwd00Zbx3udgFSGQt
         YK2r0zsADYrvBtStqeWwIOjFyjYQqHDPdiSZu/J8/aVpu5PRyc/OmYbKZxBseC8eSzXF
         m7XP1aoIjF09XoTg0GfazxI6yQzGmp248MA7hj3Aq+QIZ4KmGog0p87W3PhgGyqxs5dE
         6Xpn2Qlt610yVNKPCePCMxeGRzQFZf6CN8J/mfmeeQW6ZqCyLdZsg2/AoNb9ZuxrpxA3
         HXug==
X-Gm-Message-State: AOJu0Yx//hoaEKAjkkiLfj83kbgL4XE9yWrcDLpXR3XOge5pmJpqjUZZ
	K8ehoFGGi3er5lkgyxXp1VX6g+r7TqGnm8V9fnOhYs+b26QFO94rE2wjD+2v
X-Gm-Gg: ASbGncvVfSWjgJF9XD52QnBWHvhXq4qn/35UwuEB9zGbwQRs5H7FxzqqBjQr2L8G+4Z
	d6zEBhZtl8AVKODR3NhOTPw8CdX+es3ogt6zEbI+Q6/KYrRLaIs0w/fazyB2LTQEx4YA4uRWb1s
	8OzGma8mpcoXkFO2j4Oz2JVrbtkV6BG19PfJOgi1M1WdDcstS13OU71xXWKg0j6zvfgrMztSG0o
	wb9wDYwtCahLgov49VGCF/liABveaW7ez/9hiC2xHnbcQbWiKhdOXXcsjtLfP2bI/oaTB/cHdLa
	51ACGNNJJaNHtqxnmwWJ
X-Google-Smtp-Source: AGHT+IGmlrpV17eSJR8Pj9jB3jnNViHfW6rDhC5+AIibawvpGyF7qy5ntzOR7Fn2FX4KOL1y75HgtQ==
X-Received: by 2002:a05:6000:2ad:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-38a221f2c6emr17914244f8f.22.1735071604462;
        Tue, 24 Dec 2024 12:20:04 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c515sm178339055e9.30.2024.12.24.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 12:20:01 -0800 (PST)
Date: Tue, 24 Dec 2024 20:20:00 +0000
From: Stafford Horne <shorne@gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	GLIBC patches <libc-alpha@sourceware.org>
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
Message-ID: <Z2sXcENuw--JWlx6@antec>
References: <20241101192339.123141-5-mjeanson@efficios.com>
 <ZzJ-T-5VFZ8gZEf7@antec>
 <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec>
 <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com>
 <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com>
 <Z11l_-7RV07JRwCo@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z11l_-7RV07JRwCo@antec>

On Sat, Dec 14, 2024 at 11:03:27AM +0000, Stafford Horne wrote:
> +CC Lists,
> 
> They should have been included for all of these.
> 
> On Fri, Dec 13, 2024 at 11:22:32AM -0500, Michael Jeanson wrote:
> > On 2024-12-12 07:41, Stafford Horne wrote:
> > > On Tue, Dec 10, 2024 at 03:30:05PM -0500, Michael Jeanson wrote:
> > >> On 2024-12-10 13:56, Michael Jeanson wrote:
> > >>>> I started adding rseq support to OpenRISC, but it seems I need to do a bit more
> > >>>> for me than just call rseq_signal_deliver().  OpenRISC does not implement
> > >>>> HAVE_REGS_AND_STACK_ACCESS_API yet, so I will need to do that first.  Also I
> > >>>> need to think of an instruction to use for RSEQ_SIG, but that should not be too
> > >>>> hard.
> > >>>
> > >>> Do you have a WIP tree somewhere I can have a look at? Assuming you add
> > >>> HAVE_REGS_AND_STACK_ACCESS_API, the rest should be pretty simple.
> > >>
> > >> I had a quick look at the kernel code and it looks pretty straightforward,
> > >> I hacked this together just to see if it would build :
> > >>
> > >>   https://github.com/mjeanson/linux/commits/openrisc-rseq/
> > >>
> > >> This is thoroughly untested and only cross-compiled.
> > > 
> > > Thanks, while you were doing this I did something similar but took a much
> > > shorter route, I only implemented the APIs used by rseq.
> > > 
> > > I have pushed branches for linux and glibc here:
> > > 
> > >  - https://github.com/stffrdhrn/or1k-glibc/commits/or1k-rseq/
> > >  - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
> > 
> > You might also want to add a call to 'rseq_syscall' in arch/openrisc/kernel/entry.S
> > on return to userspace when CONFIG_DEBUG_RSEQ is enabled.
> 
> Yes, I am aware of that one, but I think I discovered an issue with the return to
> userspace code that needs some cleanup before I can add that in.

I think this ended up being ok.

I have added the call to rseq_syscall and implemented self tests on my branch
now.

 - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
 - commit 1fa73dd6c2d3 ("rseq/selftests: Add support for OpenRISC")

I haven't got the tests to complete fully yet though.  Do you have a recommended
approach for building, testing and debugging them?  I am using my glibc
toolchain, but I assume the original implementations didnt have glibc support
available when they were testing.

My stack now:

  - QEMU virt
  - Linux virt_defconfig (or1k-rseq branch)
    - rseq selftests - built with gcc/glibc toolchain (or1k-rseq branch)
  - rootfs - Buildroot with my glibc (or1k-rseq branch)
    - gdb
    - strace

In general I am using the latest git HEADs for qemu, gcc, binutils etc.

Once, everything is working on QEMU I will test again on the FPGA hardware.

Currently tests are failing with SIGSEGV:

    TAP version 13
    1..10
    # timeout set to 0
    # selftests: rseq: basic_test
    # testing current cpu
    ok 1 selftests: rseq: basic_test
    # timeout set to 0
    # selftests: rseq: basic_percpu_ops_test
    # spinlock
    # ./kselftest/runner.sh: line 37:   772 Segmentation fault      /usr/bin/timeout  --foreground "$kselftest_timeout" /usr/bin/timeout "$kselftest_timeout" $1
    not ok 2 selftests: rseq: basic_percpu_ops_test # exit=139

In gdb it looks to be happening in in an mprotect syscall in glibc and at that
point the stack seems to be corrupt already.  So its taking me a bit of time to
untangle.

-Stafford
