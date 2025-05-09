Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE424061F
	for <linux-openrisc@vger.kernel.org>; Fri,  9 May 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817154; cv=none; b=kOvx1u0bAHMxuXkLjesZj63QewzWNh6dx7Sg632GhvPr7iNyin4u1hq9Iu7601T6yAenkFmZthj95gYI0iicRACS2o5UIj2D0vioiBRrU9+U03JQDgVsmeD3VwO/4c86LDbAsexAGtnDq3e+zW6t5Pk23lNCmj6mmLOnampizRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817154; c=relaxed/simple;
	bh=F18gOkiXHALgHSnNYHdA4W7Zmd2zXDj0Rqb5oX0/eNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELH4r91yQCBlm0tDBCZfzINkdRGdEeuSRV58p9pQTERMl1mmH6DsMr92uYX2bcLZnYIRajJxQ/WGuj8kJj8syF2JHQoi8aDqsn8+Q8AKMNrELxWSt5bd0euHY4UCUhOruxr9VrfMZ58gqWKCO8sABeMB+WSURT06hQUlXc+i5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXWYcIGh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXWYcIGh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so24000495e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 09 May 2025 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746817150; x=1747421950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBNRAXvc9T6H31T7FcuTupLs2FsbZoyEOIFcNZiUI/E=;
        b=FXWYcIGhAqQyPFMfP6x5WVCdNXtWTYpILxHsRoAmtgjbvx3TQzHIkigzV7NhEsQGon
         Xj5piAou22oJb1LPnX5v2ndZ6aW/z10hdVyBObALLruLJiFEe6Cuf1FWtcVsKwpa2OLT
         z49vYviHFz9m5KasPyJpgSVGffbcMf35A9KAK1lpv6Zs7Oto2WJyRbaUo8AkeCc0fzP8
         bBqBZ5jiE70Mz6y6RDfKqx7qywWnCTOFwEG7QIHkcmBSGA9j1i0ah4IBhIR8cEfVK2nt
         jfFQWlCFSNFs4AUMeawt42ogGok4fDuGdnwY9lpNNXQ1GnGw3DGLrnASO7zIvhUwQOX3
         Y5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746817150; x=1747421950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBNRAXvc9T6H31T7FcuTupLs2FsbZoyEOIFcNZiUI/E=;
        b=f40Fh7dnEQyQWsQMq86Huzs0ttPR7qM5hYHwF95C6DLNib/i9nW5El+rGbDiE2kRUI
         cLh4dXcSPr62ot95BTfELldVUTWzpNFuwlJFk0dXpbenFuJU8x1LMMYoZTA1cT65WxwK
         j4ypiBAAGrqeXkLAKllXrpFHHNspNAHa9+887XK+WqsDNAetqwKLtWnDV5pd713sGtlo
         xW5NPVmcpi2QEtg3R+8aQOXUzmgAXzFrpdTgu2ZSLBBYZhyO/hLEBnvtMdaUItGgouS2
         XUc806vGl1/ZRf8vVfYtnS7bQCangKAoPC0RyteyeP1Y5fvJZs0pXVW/WS+Le6gNX33N
         3KyA==
X-Gm-Message-State: AOJu0Yz8lTI3DrK5VZp8ZrcUgX5AJAQ11c5VamFX2wvhX4e7W3FcOCe/
	GKNFfcMPyY10mbo332prY2gjxczq0ePXeJ8NuCwR49UtxOwIsQ9S4g55EQ==
X-Gm-Gg: ASbGncuUinYzZ85tx1qt5tkpeG5YXAkgsefWnZR/BhMnqs2/gujMYsGKDQ4ZzkFcSRa
	dIeuC4NMdIk1+hbGLJzlHZwuHlgSYYaf1+HxlIz07WDc2ebe5L2cj/1gOdY75O4pqVYMISfKTX1
	3Hh4X286cYI/0gHFmli9v7JWmPfEsAHPk2MBm5jXnErKG14EjnVZJDr/V+eodFAL6vJ1BSXvcL5
	SkVdDhgLnr3eHrrBxmMdrO1zH9NDg1YbKrtQwQXRshp/AGmy6ZoFRMXNSzOLWHwBvN53R3ATd6B
	zOGYAeXMmRWnpQxe87w+VS+0r0/chC9UgPICA5ZfTfucI7c2zbZNtluP7u8hdvcBt0n6ZtV1IxR
	awQhZZ5Gzm4vm5vA=
X-Google-Smtp-Source: AGHT+IHycUClodmnd2k5ASKeXS74eUQWnGFxo1K65Q7mpzaaobXnHJxuGRlpGDUqVJlAGAXrUL05oQ==
X-Received: by 2002:a05:600c:4e48:b0:43e:a7c9:8d2b with SMTP id 5b1f17b1804b1-442d6dbbdc7mr41059325e9.24.1746817150330;
        Fri, 09 May 2025 11:59:10 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d76b7fd6sm21117875e9.0.2025.05.09.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 11:59:08 -0700 (PDT)
Date: Fri, 9 May 2025 19:59:07 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: Queries regarding ftrace's implementation for OpenRISC-linux
Message-ID: <aB5Qe9EpVSYAf60G@antec>
References: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>
 <aBoks-Muf4CxQvhv@antec>
 <278be55b-49e8-41ae-a7d4-c0eec6f1d90c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278be55b-49e8-41ae-a7d4-c0eec6f1d90c@gmail.com>

On Fri, May 09, 2025 at 12:10:57AM +0530, Sahil Siddiq wrote:
> Hi Stafford,
> 
> Thank you for your response.
> 
> On 5/6/25 8:33 PM, Stafford Horne wrote:
> > On Sat, May 03, 2025 at 09:44:54PM +0530, Sahil Siddiq wrote:
> > > Hi,
> > > 
> > > I have been looking into implementing ftrace for OpenRISC-linux. Based on what I have
> > > understood from the ftrace design document [1], mcount will have to be implemented in
> > > the kernel for ftrace to work.
> > 
> > Thats right.
> > 
> > > While this document is outdated, I did come across an article in the Linux Journal [2]
> > > that explains the use of fentry instead of mcount in the implementation of ftrace. It
> > > states that fentry is a powerful alternative to mcount. To make use of fentry, GCC's
> > > -pg flag needs to be used along with the -mfentry flag. Simply calling -pg results in
> > > mcount being used.
> > > 
> > > Should it be possible for ftrace to make use of either option (fentry and mcount) when
> > > implementing it for OpenRISC? Or should it only use fentry (or mcount)? mcount still
> > > seems to be used in other architectures (I have only checked MIPS, RISC-V, LoongArch
> > > and ARM so far).
> > 
> > I think we should stick to mcount for now.  As I understand fentry is mainly and x86
> > feature now.  We should be able to get it done with mcount, as you say that is
> > what is what is used by other architectures like riscv.
> 
> Going ahead with mcount would be relatively simpler especially since mcount is already
> supported in OpenRISC. I must point out, though, that I overlooked the following
> developments that have been made for other architectures:
> 
> 1. Ftrace with fentry for s390. [1]
> 2. Optimizing function trace for RISC-V. [2]
> 
> > Another point is that for ftrace to work it uses a kind live patching [1] to turn
> > the mcount calls to NOPs when the kernel boots up.  Then when we turn on tracing
> > the code is patched to enable the mcount call.
> > 
> > This live patching covers:
> > 
> >   - kprobes - adds single instruction break points into kernel code
> >   - static keys - allows for static branches, i.e. the check for cache enabled can
> >     be done once then code re-written to to make certain checks go away.  We
> >     could use this for cache availability checks.
> >   - jump_label - low level support for code patching
> > 
> > I think before going to far with ftrace we should look more into OpenRISC's
> > roadmap for all of these.
> 
> Understood. As a first step, I think it should be possible to support some of the
> features in the debug subsystem - k(ret)probes, u(ret)probes, optprobes. Jump_labels
> and perf-related features (e.g. kprobes-event) can be built on top of them.
> 
> What are your thoughts on this?

I think its good, we should start working on this.  Also, there is another
person who is interested in working on these features.  I will ask him to reply
on this with his thoughts and see if there is a way we can split up the work.

But please start your progress as you can.

-Stafford
