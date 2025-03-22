Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7498231A2D;
	Sat, 22 Mar 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742660954; cv=none; b=uUrXx3NAD1z0Kc6F08vaYAbLCSG5i8Ki6awQ50qdYK1HhcMh/sGga3Xe9p4PI7s+wP5E8Wl+yH0uGf0DwcMLaLYTLWaMYtvuMYDvvUOOaj+PfKWLeoX1Xrm96uy9AwflD9gPzG2WZFGaeWURlBTwckwJvwW6e/06/uLKaDFspi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742660954; c=relaxed/simple;
	bh=dSX1hlD8JlR6cQLjXz4aNKYoO15uc2ktXL2PwK/NCKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJHCo+5QLNDzCQvFTT8UEyk1ODSE+7CAZIMPnCN4veWL/utpytH+JNIaNZcrTk96NHi3KDuJJHAwVzCDXjo5ekw07OzRtqDgv4JMpJ2mmdFSUrQeSz+/IGEAT86HwjvH0W+0pMfVhsYR1K43eCXRFLdDONKpFOiT9SzkfLulv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGzWtpfa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGzWtpfa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a823036so29795285e9.0;
        Sat, 22 Mar 2025 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742660951; x=1743265751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmGR1LbtL4J3t71evUykuzeSOw/JJ1sOFslRh5h/mjs=;
        b=YGzWtpfaoexS2kJOtvXDX2Ik4j0eR85VgWPDhyTotjgtLDMyAmM1izIB2dmYbIB2ax
         Cy0ijy7UZMzYEnhMgXO7jtGBvjQSH0Ks7pwhwMtWwWQ3SuRUClulwBwFQ4Qe+mRjR0Ur
         14qfa5/Ysu8324kXYbPwWgf7kT6rvVXLAV+Fr/1C4xhH1gutVULFtaiDs7nhpZD3c/GL
         8dWzYlI6M0YoXrLCNsI36SrzepyCts/tjotn9T4vZZEw0hWL3ulg2/NtDNV/lAmN/vKW
         Qe5pzezaV5KhpsRCdIkCxC9yEu3yfp/Q4aUIh1T8+wGQwGJK+BBx/1jRKHpYtrkaWwHr
         IMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742660951; x=1743265751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmGR1LbtL4J3t71evUykuzeSOw/JJ1sOFslRh5h/mjs=;
        b=Qilym9e6KVMxXfSJ051Z/HatWe6QPH2D4zsVJGZINH6MJ7LBpjruVNfeihzln3BZXF
         1n5jOgTiXfba7Bb64R/UnAadPTEEiQrdAGjUCd9zYs6846O8iuyR2IcTAwK5hNiJYw7n
         RIJhiGciteQz6lMRucKGN3pMXc/QS10lVocZZ3vmYD3ZdJPqa2yptP9u+3vpQy61xmGa
         ScD1kg+rvpJfg7fincauBbp5QU1pdlIfnC7WwQV9G0xfGNEqL5fsVGYVVIiT6NMiPCQ9
         uPyD+vCeSs7S85pW8jHvU+jvuLTpziuvC+P3+8JlvwmPokNxSgiKrkcoD3wL4drFNw64
         dqEg==
X-Forwarded-Encrypted: i=1; AJvYcCUd4OnsQH1P3BjzI/cxwLz1PAG/+wjswpKxHNFlNYwm8hBe9M/zLwO5RuYJ+J8cQOB2xYpRQIcxJG0cKQA=@vger.kernel.org, AJvYcCVp+iA9Vr0eK3ZzgjhOVP+KjpQy7XDnvJtq0MlDjda+rJS7ERBhhLZr+HoZJbmcFECYQHMTKzoeHNt6LCnwygw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPitVZRACvUBEOML0yLJ2jgo57+pfMcumiWVc00D4ABcH/1Iz
	pw71by1YJAd00GwO+/qq96QJD9spzI7Gm0VMuxNvmwXctQTmXril
X-Gm-Gg: ASbGncuD7qH+pRMaWGvubaIdCcmjJtmMz14viF8t6mnE7PcyOOdAYmG/HoPlyB/s+SU
	SelUNpKHvSyIdka+aZMitnImyyDUdi4zTaL+aMEk4xrTnZdQltefrXQ1Qz66ixxa8W1An+OCY7S
	xqY/xVmCdDaTRGh18oUPlTTIg72oXL4bQDJFQmLBpifMiF63gS0vGIJis/fGOBwunUehEcJQbIx
	5ztrtHy2c/QwmJCyg2Xp96JZiB+a5aQ9udWqW0pkJ0BKR7fYPcPH7+tP4YYKya5f4RpGcPTF4m8
	6eg8b8xMQHj+6a505lcHXu6c3CfOxS3nZNnT5mNpbAINHpTLXYmWlN1Rl59ijlioDIuuWrGpmfI
	HsuNiAKZq
X-Google-Smtp-Source: AGHT+IGcZ30m5rPc0OUpnWOu5jkqU14bSxURCwLJlz4cPqVUZMYOVNFcLgoAsfm44aBEBzsQCbwccg==
X-Received: by 2002:a05:600c:1547:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43d509ec734mr65143995e9.8.1742660950606;
        Sat, 22 Mar 2025 09:29:10 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd17cfesm61192345e9.10.2025.03.22.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 09:29:08 -0700 (PDT)
Date: Sat, 22 Mar 2025 16:29:06 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
Message-ID: <Z97lUpoTXVccaCeN@antec>
References: <20250315203937.77017-1-sahilcdq@proton.me>
 <Z9Z2sjWQHKgGJyGo@antec>
 <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
 <Z9gOwYl6kmoPY9-C@antec>
 <d54849db-956b-4c1a-ab93-4705394af637@gmail.com>
 <Z9kkE3uQru_VxLqA@antec>
 <10b01724-d47f-4f0f-87ea-2793e67b18b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b01724-d47f-4f0f-87ea-2793e67b18b9@gmail.com>

On Sat, Mar 22, 2025 at 07:21:18PM +0530, Sahil Siddiq wrote:
> Hi Stafford,
> 
> On 3/18/25 1:13 PM, Stafford Horne wrote:
> > On Tue, Mar 18, 2025 at 12:06:30AM +0530, Sahil Siddiq wrote:
> > > On 3/17/25 1:55 PM, Geert Uytterhoeven wrote:
> > > > On Sun, 16 Mar 2025 at 07:59, Stafford Horne <shorne@gmail.com> wrote:
> > > > [...]
> > > > > @@ -176,8 +177,11 @@ void __init paging_init(void)
> > > > >    	barrier();
> > > > >    	/* Invalidate instruction caches after code modification */
> > > > > -	mtspr(SPR_ICBIR, 0x900);
> > > > > -	mtspr(SPR_ICBIR, 0xa00);
> > > > > +	upr = mfspr(SPR_UPR);
> > > > > +	if (upr & SPR_UPR_UP & SPR_UPR_ICP) {
> > > > > +		mtspr(SPR_ICBIR, 0x900);
> > > > > +		mtspr(SPR_ICBIR, 0xa00);
> > > > > +	}
> > > > Here we could use new utilities such as local_icache_range_inv(0x900,
> > > > L1_CACHE_BYTES);
> > > > 
> > > > Or something like local_icache_block_inv(0x900).  This only needs to flush a
> > > > single block as the code it is invalidating is just 2 instructions 8 bytes:
> > > > 
> > > >       .org 0x900
> > > > 	l.j     boot_dtlb_miss_handler
> > > > 	 l.nop
> > > > 
> > > >       .org 0xa00
> > > > 	l.j     boot_itlb_miss_handler
> > > > 	 l.nop
> > > 
> > > Given that there'll be generic local_(i|d)cache_range_inv(start, stop) utility
> > > functions, would it make sense to simply have a macro defined as:
> > > 
> > > #define local_icache_block_inv(addr) local_icache_range_inv(start, L1_CACHE_BYTES)
> > > 
> > > instead of having a separate function for invalidating a single cache line? This would
> > > still use cache_loop() under the hood. The alternative would be to use
> > > local_icache_range_inv(start, L1_CACHE_BYTES) directly but using the macro might be
> > > more readable.
> > 
> > Yes, I think a macro would be fine.  Should we use cache_desc.block_size or
> > L1_CACHE_BYTES?  It doesn't make much difference as L1_CACHE_BYTES is defined as
> > 16 bytes which is the minimum block size and using that will always invalidate a
> > whole block.  It would be good to have a comment explaining why using
> > L1_CACHE_BYTES is enough.
> > 
> 
> While working on the patch's v3, I realized I am a bit unclear here. Is the ".org"
> macro used to set the address at which the instructions are stored in memory? If so,
> the first two instructions should occupy the memory area 0x900 through 0x907, right?
> Similarly, the next two instructions will occupy 0xa00-0xa07.
> 
> Since the two instructions are 256 bytes apart, they shouldn't be cached in the same
> cache line, right? Maybe one cache line will have 16 bytes starting from 0x900 while
> another cache line will have 16 bytes starting from 0xa00.

Yes, to invalidate the cache we will need to do:

	local_icache_block_inv(0x900);
	local_icache_block_inv(0xa00);

This will then compile down to the pretty much same as, (but with checks to
validate the caches exist first):

	mtspr(0x900);
	mtspr(0xa00);

> If the above is true, I think it'll be better to simply call mtspr() for each address
> individually.

Thats right, but I figured the local_icache_block_inv function/macro would be
more useful other than just this block.

-Stafford
