Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F331D4169
	for <linux-openrisc@vger.kernel.org>; Mon, 16 Dec 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384737; cv=none; b=uK4izLKkZFcMAYtSa4OP4bIc4ZG6ndiyEk5TfBbMcLsLgnETkti1PZD2+3E4PK7yYsmbDTjL/GMK1E4IEm0/UNzUuGJ/BGK0+mGWCR83JFLzKY4Dee2CvoambsIy4GuWT0Hpa09GqYkEbqMHA5Vu/cSfgHljv2WvwHCdg0AGQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384737; c=relaxed/simple;
	bh=KhzpVriyiySNAdmDEGfiU8DAucgeqkSz5pTkgqSCAUU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUIUAB6cEkj94CVdFVFDCsmjDTbrWt2TVIu68FkD9WITydzfM3rZEkLASkkg/3nqrjkOJPT9dpxckiaj4SX3z/Naetizn/zoZ/G/0X800l6YlhQMEAA6xkr1/OYgQU1V+TsSxR7BT2uRWyKHv7VKKkFyOtn5+MUzAOvi1Gw8//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0RDGH3m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0RDGH3m"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43626213fffso26789605e9.1
        for <linux-openrisc@vger.kernel.org>; Mon, 16 Dec 2024 13:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734384734; x=1734989534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlso9J/OfRco9aD717UwzJC8oqWtvHcUTi1ZtSiZyM4=;
        b=Z0RDGH3mdLemTCMGWF81Afx1QJWlkjFW+etXDYA3EhETypOz1XQBbmnTy+IGh+vsfb
         igOccZimtijJek+N1PzcKOxF619bzJ6ZbuA+AWNQEqeA5q5gOTsbuqpVxX5rUCXBMcHd
         +HXjMAGYchxS4shhCnGEvgAYACmftD0rbRsGeCgm60nt4AcZ35t+HjSHw+6loO5AnoAW
         RZwrIDfDflkc5ArFPv9zNykBfzv0HRUorAO+7nbmDpPn2Y8roBVlABenaZy6MQ2v2Ngy
         gCgtbmU+PIw8pQA43lyo8mvkcoIjU/8OsYuKrK38mpuuTo1cKfalIA5UV7mc9EKXAfz5
         5UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734384734; x=1734989534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mlso9J/OfRco9aD717UwzJC8oqWtvHcUTi1ZtSiZyM4=;
        b=nTn+/9FfkNwI/o91jfzsit03s+cyCI4rs/ZInrWKFcDIzf+JLd9ocjGJX9HcEziDmD
         e+hq1COtqxaF4K4K5mf4c/j8QxPFgEi8pMeCJkcBBrdEDPclOMsP6DqqSwDUesP7rtas
         DVqkU5uux/CzYBkeEklRbxWgl+skJGGwSoMOh4D+sCVuMWYCoqIXjxZbduvK8OvwngsI
         gm/9A5kPklpCyAyT/ob3jNazWwvLr/14hWcMYhKJyC7yHhefTahGgdR6j8GXLMRRyBG1
         l5rmObD5pGh6NANKUG6baL5jl06H6iuLWzRTwVvunE9EkvijHtPGAp74iIFrtvNh4wAZ
         5uOg==
X-Forwarded-Encrypted: i=1; AJvYcCX6b/BXEwlp0izFg8NhYllLFh5JUNjhUkwHLbx3RQFrFMCsKMRNqqHyCtXyJruFWH0FwYXp0jcmIBbIpBJi6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnWsYw/KHddZb1Qgp/+rMYsh/sVaD13IH9002238TGqfysnKM
	6ari23d25dRbIdY9MCalAgRq5qDuuwIUw+kyyU2Sqq7Ke6oXHmzZ33cftnVP
X-Gm-Gg: ASbGncvLby4QQMf/06lTuCwuRGhgCYulNJ2manTKfQJRFlopMq8AJVcSOJCKzKGPl4+
	6rYQN0sYvcb4gbB/TX1aU2KsQSEXIkyEpvoc22iUG7EKdl9ZHqTRyiokKSXTzxdiTswTkpbGFyt
	ceefVBCDKcKSZGoR/9w/WoWB6Sm6joZ4lZgxXW2B458HZk/vkfNGa8U9XNrREzQLheYOxQqmJ+C
	K4VcqG/Nzlc0jhEPgv8Y1YOMGU8Zpy2hc5vE2dOQjIxrrXCjq/Lanft9tQw5ogu551NWlGNtk/5
	FGfiHo0mynTzmFB5yKrX
X-Google-Smtp-Source: AGHT+IGuo32F+NgwuMGEByPCOrq6y3ANmNwTsHJlBAzeVrmtLM8EbQt3jUIKBazsnYHmmLzBFVWD8w==
X-Received: by 2002:a7b:cd03:0:b0:434:9ce6:3ec with SMTP id 5b1f17b1804b1-4364815b1a0mr7006925e9.7.1734384733881;
        Mon, 16 Dec 2024 13:32:13 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360154absm95734455e9.2.2024.12.16.13.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:32:11 -0800 (PST)
Date: Mon, 16 Dec 2024 21:32:10 +0000
From: Stafford Horne <shorne@gmail.com>
To: Newlib <newlib@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v2] or1k: Fix compiler warnings
Message-ID: <Z2CcWsCJ9tUq0oC1@antec>
References: <20241212162303.2099025-1-shorne@gmail.com>
 <Z1_9IM-ya8DuQIl8@calimero.vinschen.de>
 <Z2AjopSyWJf2B2Xr@antec>
 <Z2BL3DQ_AFImEgm4@calimero.vinschen.de>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2BL3DQ_AFImEgm4@calimero.vinschen.de>

On Mon, Dec 16, 2024 at 04:48:44PM +0100, Corinna Vinschen wrote:
> On Dec 16 12:57, Stafford Horne wrote:
> > On Mon, Dec 16, 2024 at 11:12:48AM +0100, Corinna Vinschen wrote:
> > > [...]
> > > Just adding the cast silences the compiler, ok, but the question is, if
> > > the code shouldn't use void * directly for actual pointer values, and
> > > uintptr_t as numerical type.  Not only to future-proof for 64 bit, but
> > > also for readability and correctness.
> > > 
> > > Also, even though all vars in the code are uint32_t anyway, the code
> > > recasts them to uint32_t a lot, for instance, line 44:
> > > 
> > >     } while (or1k_sync_cas((void*) &_or1k_heap_end,
> > > 		    (uint32_t) prev_heap_end,
> > > 		    (uint32_t) (prev_heap_end + incr)) != (uint32_t) prev_heap_end);
> > > 
> > > So, still using sbrk.c as an example, what about this?
> > 
> > I agree 100%, I mentioned this in the commit about fixing compiler warnings. I
> > mention:
> > 
> >        23 | uint32_t _or1k_heap_start = &end;
> > 
> >     This patch adds a cast, which is safe in or1k as the architecture in
> >     32-bit only.  But this code would not be 64-compatible.
> > 
> > I think in general the code is full of issues using int32_t for pointer
> > arithmatic.  But it will take a big patch to fix everything.
> > 
> > > ===== SNIP =====
> > > [...]
> > > ===== SNAP =====
> > > 
> > > What do you think?
> > 
> > Thanks, I think this is good, the public signature of the or1k_sync_cas function
> > is:
> > 
> >   uint32_t or1k_sync_cas(void *address, uint32_t compare, uint32_t swap)
> > 
> > So we may get warnings about the mismatch between uintptr_t and uint32_t.  The
> > function is implemented in assembly and the instructions it uses are strictly
> > 32-bit even according to the proposted 64-bit spec. If we were using 64-bit
> > pointers we will need to have a 64-bit CAS operation.  The signature should be:
> > 
> >   unsigned long or1k_sync_cas(void *address,
> >                               unsigned long compare, unsigned long swap)
> > 
> > Is it desired to use uintptr_t everywhere instead of void*?
> > 
> > Either way I think your patch is in the correct direction.  Maybe will need to
> > keep the casts when passing to or1k_sync_cas for now.
> > 
> > Would you like me to test this out and send a patch?
> > 
> > I also looked around other bits and found:
> > 
> >   libgloss/or1k/board.h - uint32_t uses for addresses
> >   libgloss/or1k/include/or1k-support.h
> >    void or1k_icache_flush(uint32_t entry) - it 64-bit this should be 64-bit
> >    void or1k_dcache_flush(unsigned long entry) - actually ok if 64-bit,
> >                                                  incosistent
> >   void or1k_mtspr (uint32_t spr, uint32_t value)
> >   uint32_t or1k_mfspr (uint32_t spr)
> >     - these two are related the MT (move to) and MF (move from) special purpose
> >       registers should use 64-bit ints (unsigned long) on 64-bit
> >       implementations.
> >     * Note the spec mentions mtspr in 64-bit will only move 32-bits which is
> >       wrong and the spec needs fixing.
> > 
> > I think many of these are fixable, though the signatures of public headers will
> > change, the ABI will be compatible though.  What do you think?
> 
> I just wanted to point it out, it's entirely your call if you want to
> change this.  After all, it works, so there's no pressure.

Thank you,

It's good that you know about it now. It will make subitting patches to fix it
easier to review.  I will try to clean it up and send some patches soon.

-Stafford
