Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5428FD
	for <linux-openrisc@vger.kernel.org>; Mon, 13 Jan 2025 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736749916; cv=none; b=tmekDmv7Ok3tG4/6uMxCljateOOaQBkWo4Kf2giLO0aFSp7qql5vy5HHUqLlxBpi+pKzL+Q/Qz9yWZc1rpLqFMDuwj2BYApGAl9sOTCztzq/U5V/sVqYpcH2zaJm+e+mz5bAfb9B2paTchDAOt+9Vp+Vk7vnv+BC6uSMiJdovN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736749916; c=relaxed/simple;
	bh=KHReTNLiq1yMidPW2aJskmJs/EoTsctWYjE9Y2GnyFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR6vdR3rNVGuNUTc3eZtZx63HKOT59y05mxmYFfdG+4Nm8W1kVeA6QKqK55tqB2LcGztlVbaDU77SfTf/NmYFsp1mVnsPEAVlOlKrZ/lg2R6eMaBI7pWjxutak60q3zo9eiNaNBfyd2mToBg2vREigM29R8YJIsY5dBhAQEl5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djfCsu06; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djfCsu06"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436281c8a38so27160635e9.3
        for <linux-openrisc@vger.kernel.org>; Sun, 12 Jan 2025 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736749913; x=1737354713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Duz3qOgyfoqqLepyffKfRJkobUXjE5BMwWW0uKuUTek=;
        b=djfCsu06KZDSUHy9sMn97mF4y+8k/MMZySMelKg8JOuDoN+r3jpGLvUPuRQVDwksXk
         O2WljIUR/WLEKoFVMmPMALS4WXRgKbJsgT+IPXRM1kuKWiCZTPGafMIEVwrHpb4oq3ie
         uoxjhIDWu8MrYjtI3D/x3AE7tgKAPn0OuWsEh14OLVjaGXU0htrOsJ52q5Iz9P3IbnMU
         G/hJR4iZaF7nVzq+4SLxbgv0LWzWEjU6GU2SWbIBFs0UqqB7Bi+YVSZVvYPwpKU+7b96
         rqWpAvP8Lu/+J0z+We1bHVNpqax+h1vG66dYJIVb+GdsSVp3BSN8MbAXtGFf7do1xh9q
         sWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736749913; x=1737354713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Duz3qOgyfoqqLepyffKfRJkobUXjE5BMwWW0uKuUTek=;
        b=w0dp9uOCfQ8ZEOPpdwV4fUFYCoGWu69Qh+yT48In4jAdW6BzWl1LC9ngVCKdo4NTO3
         hQ0OYHZnOQcIjPIgvgi8WDbzsmDQ2m3GSEjz/S/hLfskAFSNb4wAC1K717/2rrArvxvG
         8T7y3LJgxFanEuXY7NJlgxNO6CKG2nUZpmAmNuxJaLbPze8yzXCF7Gl5qWpNYa8Y6caf
         QKfSrardsBOpT2Qs+si87TINOVsOfJ4nYk8x6Kr+pMmOygLjyj2zT9i5pTKYJ/Tap7IT
         gQk7yCXOFDcwKNDCU3K3VvjswVBiFm6uiRtyFpuO6NKZ8MmyMI2/sG3vHibAdQZphXp2
         pgfw==
X-Gm-Message-State: AOJu0Yxp47YieY8x66R8lN7IrDaO0v43dCNKu5QtL58BOToDpHkvCSoh
	jdFbOxPNgyF/2SsT7+U+c21JUwirooFlNJJI0oDBTWhZCRPWw6GK
X-Gm-Gg: ASbGncu0ASMoR6uhCEAanXhYyUdkz+dO2PQHOPneVoBCNwnsEWZaKMTUSlFIom/u0Nx
	nhFu4pa8twCynaB9vK9mBikHGzac87ryGs338hxSoD+4sRjUnMCO8cA8awf8bAULLrL3Uhk7obx
	dQY7G8OSmV4q6UVxikQeddG5X6vIqtbT6pvncvo4GZWO4AYM7pX1xyEB8/uGNU6NtwvNmnqspXg
	m5Kh1TKRopDvwHa7e4PtRTXBz+pOp24vg2+ZIo61F1cr6Y7XBF04ytAAEjiq98S0Tcae1CDX6AK
	lJteAJ/YqUEueeICKKDS
X-Google-Smtp-Source: AGHT+IF/kfw+2NHkc1CcxbuDL/cgwHH9/tcAFsT2rkq7OvMIWX+smxDM+HUrRizsan17T2Lyk6ZMuA==
X-Received: by 2002:a05:600c:45c3:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-436e26f4ae1mr161660635e9.20.1736749912407;
        Sun, 12 Jan 2025 22:31:52 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcceb374sm159046065e9.0.2025.01.12.22.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:31:51 -0800 (PST)
Date: Mon, 13 Jan 2025 06:31:50 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: Contributing to OpenRISC Linux
Message-ID: <Z4SzVtTIuVN7gsX8@antec>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec>
 <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>

On Mon, Jan 13, 2025 at 11:42:08AM +0530, Sahil Siddiq wrote:
> Hi,
> 
> Thank you for your reply.
> 
> On 1/12/25 12:58 PM, Stafford Horne wrote:
> > Hi Sunil,
> > 
> > +CC List
> > 
> > yes, the cacheinfo task is still open.  There are many things that are still not
> > implemented in OpenRISC, you can always just look under the kernel
> > Documentation/features.
> > 
> > For example:
> > 
> >      < shorne@antec ~/work/linux > grep -r -e openrisc.*TODO Documentation/features | column -t
> >      Documentation/features/vm/huge-vmap/arch-support.txt:                |  openrisc:  |  TODO  |
> >      Documentation/features/vm/ELF-ASLR/arch-support.txt:                 |  openrisc:  |  TODO  |
> >      Documentation/features/vm/ioremap_prot/arch-support.txt:             |  openrisc:  |  TODO  |
> >      Documentation/features/vm/pte_special/arch-support.txt:              |  openrisc:  |  TODO  |
> >      Documentation/features/perf/kprobes-event/arch-support.txt:          |  openrisc:  |  TODO  |
> >      ...
> 
> Got it. I did find this list in the online documentation [1] but I couldn't find
> the cacheinfo task listed there.

Right, not all features have config flags that are documented.

Cacheinfo is implemented by overriding some weak symbols.

> > How far have you come with OpenRISC so far?  If you haven't already I suggest
> > working through:
> > 
> >   - Get a simulator, I use QEMU for most development as it's faster and supports
> >     more memory than most FPGA.  Final verification can be done on an FPGA.
> >   - Get a working compiler toolchain.
> >   - Compile and boot the openrisc kernel.
> >   - Build a userspace environment, either buildroot, toybox or busybox.
> > 
> > I have some tools to help with this in or1k-utils [1], also there are prebuilt
> > environments and docs in the linux kernel [2] and qemu [3].
> 
> I don't have an environment set up yet. I'll start with the steps above. I'll use
> QEMU for development. I don't have an FPGA with me currently.
> 
> > At the momoment, I am also thinking of what to work on next for OpenRISC, there is:
> > 
> >    - kexec
> >    - jump_label
> >    - kprobes
> >    - perf_events
> >    - ftrace
> 
> Is the virtio task [2] also still a part of the roadmap? I can't find that either
> in the TODO list.

The virtio task is still possible but will be more advanced and may need some
architecture changes to support hypervisors.

-Stafford

> > [1] https://github.com/stffrdhrn/or1k-utils
> > [2] https://docs.kernel.org/arch/openrisc/openrisc_port.html
> > [3] https://wiki.qemu.org/Documentation/Platforms/OpenRISC.
> > [...]
> 
> Thanks,
> Sahil
> 
> [1] https://docs.kernel.org/arch/openrisc/features.html
> [2] https://fossi-foundation.org/gsoc/gsoc24-ideas#openrisc-linux-feature-development
> 
