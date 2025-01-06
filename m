Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1321194A53
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194706; cv=none; b=N724mh78oYKpQdV1deoD2Tr6hlZHNn+QT/3EOgm8z4IRiGLbn3V2KVqBc9rxeLsomTSRUDS5+DBtAuQyflM42sf4faO4paLYdKuy0ELx9COcGBHjjVTpTkKrycU7a6gxCzJltYNXx+0EAeYVJjpKbnizrU+eV0l5NXsv2065LkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194706; c=relaxed/simple;
	bh=Ct3IBdcWJrltE3UJXbZ6GBz0buD2tkhk4Pn7L+LLqio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8kUpPDdAu71YlMrgoORplASYotlViXh2q0GvTMchJHtnO4tQl5g/7BYaNqmdCX1s/XAP+oU4nhbNuEeRoNibOByhieCWoAObX9T6TMkLHzeU6+3VlTJ/1do3t0EB4FSgQeKPMcsAIBf1l3BlYzu2f3uTwO5yMekTNF9s6q877o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajcogr6c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajcogr6c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361f664af5so168115895e9.1
        for <linux-openrisc@vger.kernel.org>; Mon, 06 Jan 2025 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736194703; x=1736799503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFxO3X4CIE4wMc4cVtXpyWSPit2bs0iW4LL/2p4Z5aQ=;
        b=Ajcogr6co2bNYIoKxlV0IU5IjKRiFNZ5CwSEunsDTguELAbD0RYBUoWuxuZID8lYKZ
         uQo+IS1fjzbdDMyhVyvUP913iLvsQuFPH6dpnvhcBgp1yY0M9rVPeQBiAkYqipaLG1j4
         FnxHLNFJ6Bpzhz2dGbKhrn185KlAwpz3XVsj3WwrJLZP8PUODC+Do/qOw2Co95jIzWze
         /VIaDdIICshKKJ058lfkOTAFRZP8v/MSBtjr4seFNlhi0kv1atKD3S2/5MEc8RB0FP89
         gs4gPvaYxwUidxYT3uaufi45rnuVWNsgrz4BWBLUAKIhHzuOAsaqZibaO9gCMY23DdO7
         Qjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736194703; x=1736799503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFxO3X4CIE4wMc4cVtXpyWSPit2bs0iW4LL/2p4Z5aQ=;
        b=ZD/rIYB1QdaNZLToQhBAbCmhUqqkWimwr6KmR2NtQTi16PpjADOLt0JuUOtfSj3j93
         RzV0zyNS0GUzCpqFuF0TeSmY1KmPIUkz9FVr7XsSQHej5YhnidHre+5YtvD+RZpCFehH
         QthQ36M+Iwhpy4Hwxf+Lt1rStPAXM5Fm9bOEV9ikm14UmegQmudvR6falnUziXgnOZ2j
         0f+Bgc3yH1HbN8BR1nNMXA5D9CCeg9hX3kD/O6z3hNVrJDAigRFL0Nsv5A+eZSzdtbGP
         GIesmojfXAAfJI9m+5/XON2c1Gddeik/zB8RyH+9QjSl2Xl7y7kjGV1Q8aPfGjfTYV9i
         ORzA==
X-Gm-Message-State: AOJu0Yy3x6f8k//qFaLbGQ4/6+JStBhUx/PiC5vMPwtRGM4GrjTsdFVn
	AXeUNkSgd5dswhzI+MphOfx0reSjg71X70uDW0lIg1nVv8OQFPC2
X-Gm-Gg: ASbGnctLYjSvYNGaPYPuEWmH17DdK1Pz9SbBH9pWB92wDYu2oS2nnRJOQ6WkBhv3wRo
	MdHkiGugjcvro+19ZG/65VnPQmrvuLKrTB06FFTkVE3iLwb9A3BzVSDdaNKDpK1pdNCgyhLYnDU
	Xa7eRAmuiaPyu2S0aKliVm9i7Kt2lnh+sSfix2CfYImCMu1EeYb+u6qNnfuKAIsdQ7eZiSVrJp1
	NFFVtQwZwIvR81dC1ve7xc9UzJ6Q/plWx/hSIB2j6MchZTpJ2wPCrfc22X4r/XSAoVd5v6n6QxY
	0k9AJdIdnjrbyEw3m4+D
X-Google-Smtp-Source: AGHT+IEzZjeUgU0qtJOOkMHOH/ikXwYH4GbjJoLpYbfD2+mcbS9DyutZwSE6AgAc+0NBAlnyNOWB5g==
X-Received: by 2002:a05:6000:4a03:b0:385:f638:c68a with SMTP id ffacd0b85a97d-38a221f9f58mr45974343f8f.30.1736194702663;
        Mon, 06 Jan 2025 12:18:22 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829120sm49959869f8f.6.2025.01.06.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 12:18:21 -0800 (PST)
Date: Mon, 6 Jan 2025 20:18:19 +0000
From: Stafford Horne <shorne@gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	GLIBC patches <libc-alpha@sourceware.org>
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
Message-ID: <Z3w6iz3oo7JCoU_z@antec>
References: <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec>
 <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com>
 <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com>
 <Z11l_-7RV07JRwCo@antec>
 <Z2sXcENuw--JWlx6@antec>
 <9dfd2255-12fe-48ba-a6cd-43956a08e685@efficios.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfd2255-12fe-48ba-a6cd-43956a08e685@efficios.com>

On Mon, Jan 06, 2025 at 01:26:48PM -0500, Michael Jeanson wrote:
> On 2024-12-24 15:20, Stafford Horne wrote: 
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
> > 
> > -Stafford
> 
> Hi,
> 
> Sorry for the late reply, I was away for the holidays. From your other message I
> think you managed to get through this. Is there anything I can still help you
> with?

No problem,

I figured you were on vacation.  I just kept sending mails to document my
progress.  The holiday's are when I get the most time to work on this stuff.

As of now there is nothing else needed.

-Stafford
