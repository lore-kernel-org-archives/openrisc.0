Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEE7136E;
	Sat, 19 Apr 2025 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745039539; cv=none; b=Ll3UUcD8jd+wIovdpnIVEQGc/JlfWCPpgViIH0nnJOcZjn9+jXerdkd8CxYedOEuT6EvyrkelefBk7xx6YxOfRwtzxTT5YFRNGdPu/F/R86n8bXpHIheK/+vXXqOxnBC6Z9xcKPWI/sxS+VfFjFJMza8qSuwkQEimuBiLSYRaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745039539; c=relaxed/simple;
	bh=AlEY4zKhmRNDt20P9Xp6i5Nd73YvPO7VbqqVtJST+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odjmst6OhLRhNS1DPgohgn0pmI9J3EAOPWYbpLR+7mnHs4aapQVcAzPDGSrYlpr4XqzMESGUKJuk/uGnVe7MqqbtWFBu94gK6mivlp8o912JBDZ7lNFOtZG2E3sUTYBgzSiC5drC/u5Q1pJa2IrRU3T/sTPBb9rWR3YFMVIo1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6903dHy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6903dHy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so25223235e9.1;
        Fri, 18 Apr 2025 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745039536; x=1745644336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWXhDw052JqSwc2DEiWR3CaVZdUZyR9wDp3GTxz2iYM=;
        b=T6903dHyoI8e/rd5EPeep42RKoYdI8DzYFXk47sOvp9XHkcph1GwXIXlDGzRwDG89o
         J4Yjz6ebtn+xG3jzH/tActkz7F+1ecXspzaoTu6NKk7ivhGDhEJ7MFrdzqRo1qT08ijp
         GmHq8yLJrdj5RjnB5WYS+NHXAwyEmivQju0eMHaWierocsAcK+Cyi5MLZZFiII/kENU5
         8CeRxLwCNUTdar2aANxVcNJ78Bedtcppbg+xDErjpRT/IjNWTpxmoVAJE2kqMWXvEUcA
         4ZBpli7jtcJwb7qbebDRl14HZG1ihju2Wo3Uz5/uF9S8nj1BSPbKmmEt4TGbrkTktVTv
         jrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745039536; x=1745644336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWXhDw052JqSwc2DEiWR3CaVZdUZyR9wDp3GTxz2iYM=;
        b=eVcSIBuNlrJkE4VtQgX4Cy20Ba0kxid8mUFMW04L+mpEpjSZbeaWG84mm8usGNq1Bk
         cpsdXUPn7x1exJfSuz5TXGzsSNbNDELAI8fU8KLGqpM/t+WCBLskHNx2Z/VKJhc3NglI
         2AmfpmXygdKFx24AESZaWUI3nVxcgQln0PVjHZ29Yksh8YvpiNt8kqOpFM1c9XuA6Q2m
         TGrsVfxymq9EpFaOU8/6bvd+x2AryKyFVzHwP6MU/sMFSnf59MSBXeZXi8vviQ1PWfo9
         2LQM8mBGaGjdlO2pu26LrZQk9DtWGMeF/HTHDHTmeorVc60q5fqGOyms+PoN5oDI9PMy
         RwGw==
X-Forwarded-Encrypted: i=1; AJvYcCUdOX9/AWUMbSLvN+AMCGwYGKA5290XZLIWg286l1zNJfeW9R21/lt+QRj3x0BqimSXdJtB9ZsEqmq3TrrFhIM=@vger.kernel.org, AJvYcCX74JYDR1IEGdvLfNyq1UnJGiwlyayWnnLqjy0TvTEuAQ2r6aqasOUPml0TYeQzhI9G5c+rQFn7MoB/KsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMNptRsgaXkDMjdAWZKUDhHwc6eOQnBz1WpVr0o8Ci0alPn3d
	/VHjRfUtOKxsu9vY8kRYbcSDu2+7ncOw4kPxMzrs1AEiHNZYnzBp
X-Gm-Gg: ASbGncvEPXa3UnQ91p796Ykt5fZPzOooVY//dcRPaz51SKMfoIJK8xu41bO1ME3poYS
	yY9sYFaKcoJpqY0wchZ5QOSG0f+aOJTCvQnIPTBVob5VflAyNvb84RxiPVi1notImeNKHFhPqBK
	0jYkrsCEVmLJJX9TLVMiGwdGVFH5tNdayvh0y3yCUz+AATpU6lB1pKsuLBR1aNTwRFqCBv9+Os0
	+xa16fV2FuWRWgg7V0wmZTAzYM2S1ZDrsVFThAOJyKluEMDS1lh1+XBO5/A08VNAAq2Z1AtzY51
	+7QaPYsMq00ANCTNJGJbFBgFF9GdpHp7XgNlJ12EyVgD8uvO3o/FAZTDDLDFhfIxrB0FSbeNkUZ
	IdPqQ
X-Google-Smtp-Source: AGHT+IF0DV0PcqkPAMgHSHJ/AFOSOa8OeTQRkmET5HDuCcPTUUq6yyc8/DRGg/vAcFHczFOzZXzsSQ==
X-Received: by 2002:a05:600c:1c9d:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-4406ab93151mr44342075e9.9.1745039535907;
        Fri, 18 Apr 2025 22:12:15 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbd7fsm45920605e9.21.2025.04.18.22.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 22:12:14 -0700 (PDT)
Date: Sat, 19 Apr 2025 06:12:14 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] openrisc: Fix build warning in cache.c
Message-ID: <aAMwri9RK2oNuC_p@antec>
References: <20250401200129.287769-1-sahilcdq@proton.me>
 <Z-6VyRhGdInVidsw@antec>
 <af85b465-13e5-44e5-a0af-c7c68af7d43e@gmail.com>
 <aAIDfcZ4XD5f6mA4@antec>
 <f6f4f410-4a0a-4ce3-bf41-413af39fd50e@gmail.com>
 <aAIivK7NDG-6_aIU@antec>
 <64beb3b4-a8fa-4acd-a139-6c19de0e37f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64beb3b4-a8fa-4acd-a139-6c19de0e37f4@gmail.com>

On Fri, Apr 18, 2025 at 06:04:29PM +0530, Sahil Siddiq wrote:
> Hi,
> 
> On 4/18/25 3:30 PM, Stafford Horne wrote:
> > On Fri, Apr 18, 2025 at 02:42:20PM +0530, Sahil Siddiq wrote:
> > > On 4/18/25 1:17 PM, Stafford Horne wrote:
> > > > On Fri, Apr 04, 2025 at 10:39:22AM +0530, Sahil Siddiq wrote:
> > > > [...]
> > > > I was working on getting this patches ready for upstreaming and noticed one
> > > > thing:
> > > > 
> > > >       ---------------------------------------------------------------------------------------
> > > >       ./patches/or1k-20250418/0001-openrisc-Refactor-struct-cpuinfo_or1k-to-reduce-dupl.patch
> > > >       ---------------------------------------------------------------------------------------
> > > >       WARNING: From:/Signed-off-by: email address mismatch: 'From: Sahil Siddiq <icegambit91@gmail.com>' != 'Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>'
> > > > 
> > > >       total: 0 errors, 1 warnings, 102 lines checked
> > > > 
> > > > As you can see above the scripts/checkpatch.pl is failing with the warning
> > > > about your email and signed-off-by not matching.  You can see more about it
> > > > in the FROM_SIGN_OFF_MISMATCH section of the checkpatch[0] docs.
> > > 
> > > Ok, this makes sense. I configured git-send-email to use gmail because
> > > protonmail does not work with git-send-email without a paid account.
> > > 
> > > > How would you like to resolve this?
> > > 
> > > Is this a warning that cannot be ignored? I can:
> > > 
> > > 1. submit the patch series with another email address that won't have issues
> > >     with git-send-email, or
> > > 2. submit the patch series using protonmail's web client (which might not be
> > >     the best option).
> > > 
> > > I would prefer not to use "icegambit91" in the signed-off-by tag.
> > > 
> > > What are your thoughts on this?
> > 
> > I could rewrite the from header to match sahilcdq@proton.me.
> > 
> > But if I do that you should find a way to get proton.me to work with
> > gi-send-email [0] for future commits.  It seems this can work using the
> > Protonmail Bridge[1], though this site also says proton.me is not so good for
> > using with git send email.
> 
> Right. Also, protonmail bridge requires a paid proton account.
> 
> > Maybe using another email in signed-off-by would be better.  The current
> > patches are on linux-next[2] where we can see the From/Signed-off-by mismatch.
> > For example:
> > 
> >      author	Sahil Siddiq <icegambit91@gmail.com>	2025-03-29 15:16:22 +0530
> >      committer	Stafford Horne <shorne@gmail.com>	2025-03-29 10:22:21 +0000
> >      commit	af83ece87a1ef5097434b7c3c1fc0e9e7b83b192 (patch)
> > 
> >      ...
> > 
> >      Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >      Signed-off-by: Stafford Horne <shorne@gmail.com>
> > 
> 
> I agree. I have another email id (sahilcdq0@gmail.com). I can configure git
> to use this and this can also be used in the signed-off-by tag. So, this id
> shouldn't cause an issue.
> 
> Let me know if I should send the series using this email id.

Yes, please do this.

-Stafford
