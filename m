Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F564188733
	for <linux-openrisc@vger.kernel.org>; Sat, 14 Dec 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734174214; cv=none; b=MOVaM1ypD9w7+AnoJylPVnu3RrioB+PjmRfL8LCJje1hccKJhWez7McK2R9//U52Jw1y+5aRhMFw1p6lNrpHtmZ/q4ybTq7Q8NjGvygazStiFbETYnpZoggKwbsOIarYNvlAGRpMwaqXmLjNXDilJaaU5CO5qCL9tauDoLUv2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734174214; c=relaxed/simple;
	bh=ZVKV6hYVy1vlCQCamOaJRRARkdiIxDMHbCHISHcHO9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6Ygf1LKbDboo+ZjR8G+IS/spPsTEAweEuCqzX8SzJhtI7McUcYWNxKMs+9z3KsGNNcULEH00oQQ45dfGMbB2KCrS7w2dtz02tiiGE515ExU72iv5FbRCfm4ymosCYR0ucADjzvhP/47MDHlsNWdwlo5TkU0yMesRBH3QoXCWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h56DgAJn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h56DgAJn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38637614567so1175810f8f.3
        for <linux-openrisc@vger.kernel.org>; Sat, 14 Dec 2024 03:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734174211; x=1734779011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+af+fst9tFrXnoc0bJEIhWiEGLYw6Po/+29KHK+Ir8=;
        b=h56DgAJnV+iCnmaekGNvW6EGT+WhmfGxUlD3hNju2Y4hO30xrkd5DebrMCE4SL1RXr
         Pgd3qC93fdS3PczF0AGz3wwXriQhfwC4bVWyS5uilEAPnxpLW1D0qzlfxDzO7iI6xyrp
         CjQpm5ew6M8/cthvi96SM955Vu7C21h6rVqdVVD+FBl/Xp1uXmxaNfXH+m5qzVpOesRl
         b6dTSRIDmuetvtyZ3TNeF+Sbrh7Fe1Y60QtXGmYHXiAIq1BlGud+Xh0PNKSj84vSdDaW
         KAUI60zvctBjIBfVrc3I5oZT152+kImkpbQyZU5D9UhABCF7fMU8+qHGBlCdJK+1kIYQ
         D7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734174211; x=1734779011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+af+fst9tFrXnoc0bJEIhWiEGLYw6Po/+29KHK+Ir8=;
        b=LCaPvAzswu3BfjJ9ONRjz4viaPH6a1wlRIhpoZ5x8TVBgZKzgX8cHImqnLs8o0fcgZ
         0WaHEcZWpOKXfljahGZmQ3qtk1VgYjtfBFEEQz29kZ09vaSuzwLe6CI/uV1Gnj8ScXoC
         Qa1dEnJ5124UO+n0R6M8nEOnQR6Ch7Mh5ovWsgME7rxyXYOuqw1WCmJJiTZ+nvcteSvX
         Jc49QwEOQM0LZZFDQcAdjeQ5NDDuMwGjQjRvvt60dUiBmt1FmIwnEG/pxm6+NH67U/qZ
         F6vhP0AmEKJptWRPvtQogFBhFmezkjxn/AjR6DDAeYMd/y3a2rRwnQJEyk5oiWlP2yzI
         exCQ==
X-Gm-Message-State: AOJu0YzIJedwz5ilF0B9L4QJtnlNpCMqwpkhb9X3izVHICmXJ0qfl18q
	OgEmTckmzmGA0GRWjuw6rrLC9KDpEWBfPtGOznqi4FufRM6KGRLh
X-Gm-Gg: ASbGncsqWnLrHDLGfIi4KQV7D5nSHxYqLfzr2LMMT3kzGDupq5gbM+nJhjz2SxSN13O
	aGYXj2EI1PAz3HTWMWWSjeezNWv+3Dd5r8uIzT1Bym+bOFO4a9wPa6Y553HtorFUJwjolysd8rQ
	P14bF0+F/jLYrfWg3oMDV9xzm9O0bgyU+5QFbxd4iTDYRVASo7gAyynZBnIUdfXdn5nejEQFbI4
	xBVxsY1iJ/c+bw+Y1693tTiMyl7P2nB3921b0/Cduzd4uOz+Md79xJCTrX5kzodHH81iJB79l09
	Y9O/TOP5bRRd7yzvDeUA
X-Google-Smtp-Source: AGHT+IHOxF6EIFbsNm73Z8GeQ8F1riW1/Hhn74L1bmcglN5FTNBThQgiOQevP/I7R4pLFpJxSzNLHw==
X-Received: by 2002:a5d:588b:0:b0:385:fc70:832 with SMTP id ffacd0b85a97d-38880ad10bcmr4915238f8f.16.1734174210590;
        Sat, 14 Dec 2024 03:03:30 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806b84esm2228878f8f.108.2024.12.14.03.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 03:03:28 -0800 (PST)
Date: Sat, 14 Dec 2024 11:03:27 +0000
From: Stafford Horne <shorne@gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	GLIBC patches <libc-alpha@sourceware.org>
Subject: Re: [PATCH] nptl: Add <thread_pointer.h> for or1k
Message-ID: <Z11l_-7RV07JRwCo@antec>
References: <20241101192339.123141-1-mjeanson@efficios.com>
 <20241101192339.123141-5-mjeanson@efficios.com>
 <ZzJ-T-5VFZ8gZEf7@antec>
 <94aee33f-c9d2-428b-9b03-7e4fb1c97472@efficios.com>
 <Z1g2UxaMlKH5o5nc@antec>
 <Z1h5hzWpD8Fu77AL@antec>
 <8dcf9b95-b7fb-4b5e-8708-b4428b58ecd1@efficios.com>
 <8afa2c34-9416-412d-9920-ab15b44c6d4b@efficios.com>
 <Z1rZ6APG2ViLdLmy@antec>
 <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e249789e-0cfa-4d66-805b-e3cd1aef957a@efficios.com>

+CC Lists,

They should have been included for all of these.

On Fri, Dec 13, 2024 at 11:22:32AM -0500, Michael Jeanson wrote:
> On 2024-12-12 07:41, Stafford Horne wrote:
> > On Tue, Dec 10, 2024 at 03:30:05PM -0500, Michael Jeanson wrote:
> >> On 2024-12-10 13:56, Michael Jeanson wrote:
> >>>> I started adding rseq support to OpenRISC, but it seems I need to do a bit more
> >>>> for me than just call rseq_signal_deliver().  OpenRISC does not implement
> >>>> HAVE_REGS_AND_STACK_ACCESS_API yet, so I will need to do that first.  Also I
> >>>> need to think of an instruction to use for RSEQ_SIG, but that should not be too
> >>>> hard.
> >>>
> >>> Do you have a WIP tree somewhere I can have a look at? Assuming you add
> >>> HAVE_REGS_AND_STACK_ACCESS_API, the rest should be pretty simple.
> >>
> >> I had a quick look at the kernel code and it looks pretty straightforward,
> >> I hacked this together just to see if it would build :
> >>
> >>   https://github.com/mjeanson/linux/commits/openrisc-rseq/
> >>
> >> This is thoroughly untested and only cross-compiled.
> > 
> > Thanks, while you were doing this I did something similar but took a much
> > shorter route, I only implemented the APIs used by rseq.
> > 
> > I have pushed branches for linux and glibc here:
> > 
> >  - https://github.com/stffrdhrn/or1k-glibc/commits/or1k-rseq/
> >  - https://github.com/stffrdhrn/linux/commits/or1k-rseq/
> 
> You might also want to add a call to 'rseq_syscall' in arch/openrisc/kernel/entry.S
> on return to userspace when CONFIG_DEBUG_RSEQ is enabled.

Yes, I am aware of that one, but I think I discovered an issue with the return to
userspace code that needs some cleanup before I can add that in.

> > 
> > With these the glibc tests for rseq do work on openrisc, see output below.  Do
> > you think with proper cleanups the glibc tests only would be enough to push this
> > upstream? As I haven't started writing the linux selftests for rseq.
> 
> It would really be better to implement the selftests, the current glibc test only
> do registration of the rseq area, there is no critical section / functional tests
> of the rseq feature.
> 
> This is something me and Mathieu could assist you with, first adding support for
> openrisc in librseq [1] and then we mostly just have to copy the headers to the
> kernel selftests to add support.
> 
> I can do most of the boilerplate of adding the architecture but you would be
> better suited to write the assembly used in the critical sections.

OK, I think I can add the boilerplace too by copying from another architecture.
Thanks for the tip on using librseq. I was looking at this code earlier today.

> Do you have access to hardware you could share temporarily for testing?

I have been doing most of my testing with qemu-system-or1k, built from source.
I run the virt platform which boots with Linux virt_defconfig.  The filesystem I
run is a setup from builtroot [1].

For "real" harware I have run OpenRISC in litex [2] on FPGA boards.  There is no
real hardware that I have access too.  The QEMU system emulator is the fastest
though so I have been using that almost exclusively lately.

-Stafford

[1] https://github.com/stffrdhrn/or1k-utils/tree/master/buildroot
[2] https://github.com/enjoy-digital/litex
