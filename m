Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0E155C82;
	Fri, 18 Apr 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970435; cv=none; b=LCQucW1E6uZl4Gw3k5MbtNG+E0stCbOnDqKPjWH4MNQ2giTbc37ypSYjFxJmRyFZT+pn8R4eKyBLh+/rLMB+Io24qiV1G5ZGebVVlN9BNjZ4pre0kD+Pi3ReIq9UBLr8ize5T9AvPdbcfFr3fSfAs12Fktjbr8FITrKZJYVPZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970435; c=relaxed/simple;
	bh=irvX3Kf4X756JsU0YCDL86boKYBb6LyTE8yrOMOi7Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1et5oqjn0dnbfByy31Bp92TXaw9ZviICFaohFdP11GHl1V8F2nvcqZfSAsun0m5dMs5Ma9zzRA9b8yPMgQNcmSaDG5Nx76vfIGTOPqGfQynzngDUZ4h4NulUNyChL3vRGLU71wJ5oBg+6UF+oiIU+DKEzHHYatEig/3u6EQEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLMkvjJr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLMkvjJr"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1242103f8f.1;
        Fri, 18 Apr 2025 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970431; x=1745575231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmdzOyBKySkqBAKKcD6PgWQb4+yfqKbUqL+8us9T71s=;
        b=XLMkvjJrn5CRZ3aLliHTz2oXqY4lbrdXiHucvCnZQTJsMvxW5/gQMeI5HjLK45evu4
         CoByG0jcPkE8k4T0eA1hUB5vJw875P6zNrVN/ERxFWKNOUFt9icO/yu+DWjWvNELWInX
         WONJptKfo3VGBgwhh/rrhqzIe9V5DW75icG+ll/vbxGkq8Pe2kY9bYrVASxy+1tBmIe3
         KsFI/hS+mto3sso5xNv1rP14Dd3axgxQ9ddvu2k64nGXMspyNnKEQm9uYm+WhKWIFLVO
         RmjcqDcvdU4B1AcTrV8htDbQgVnk+Uw3KdXNsXHi5eswn/3rIdqiCf1M0l1MCp4ywiSE
         k+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970431; x=1745575231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmdzOyBKySkqBAKKcD6PgWQb4+yfqKbUqL+8us9T71s=;
        b=wbo4rzRRC/Hc/yRP7oLMW7lA7XElJDI5MzWJvmuphGhlU4/4kcP0V4ctSCgql53SgZ
         XXvgZ4rrLmr7mv38Zwy1b2u1AHOtQ2q36oW1/zKDxVsPAfuNNx49aHeiKdIe4d6QwSuh
         z8FlMZeum63C8lxeuZ5YSNmnxnex0LSUO/kduGLI+Hnb5wEOszjCubf4ZuMDu81e4Phq
         y7QIOaYxfRXLx0urvXOSO90QXMEGQ5n9xP06lCEfl0L+nXgCbxTiuomDZYImeAJqFac5
         1fZviR8TEw5yz/yJ/Jkh+q+/ioGtqmr7okIleO6xiUHpP1AqISQY3hKezp7t2r/KN3Qs
         eHvg==
X-Forwarded-Encrypted: i=1; AJvYcCVNpjxu98PojO9Q+vpcSKNPb5cWuvghxhuZBYzuh5i6maPPwqITRMEDqouAHh7q56sxt5x0hRMpBqymDHY=@vger.kernel.org, AJvYcCXdYjsnYRqkgqwMWZxCbllh9v6pcXbQH4FRWegYnAlywFzmadfjR51cogkA6LmI04mwcd/PW5zHeZlpgbBiia8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rzm2Q4ubBxeN/AcFC/0H1jLMwoI6OIAp5o9t74xLxywOiJW4
	JNQqCx4omtbJqmkWaWtlYzUxrBBscLoHVA4qN4+gd9UadKGeVFFT
X-Gm-Gg: ASbGncvpI9hizMhj1EX/6ZxDU9MwLqYo1zA51GCf2BtoBKHo9aFJOiQkEcGaseIPXqM
	pYCKmv3DqHfqMo9iBwIoRKGAWK9HnJlGvuGvwwiTNArFINlZBSZz17VD+oXoDk7Zn8FhUTDgkwr
	hCRD5PIATJ+iymAicLEs5XaHZ/nDso9QbdzaL6/iydvCQz/qdDdNN9QVm7GrFWFJx7EfWs7VPic
	BrVTkfSciFtaFkNhsbX0fURdnbCAX9M47KwYd/SXQVPtkoYu6QSBMUvHFkvzlSP2gMOknQ8TfcE
	FdJ2fb3lm1ibdh+/VyO35QIPrrwCoh/OCdRfXwjyWVSbdyYRQnj22M3bE7oAsG/wQKmITQokV8L
	B1tDDhiNp7vjJYD8=
X-Google-Smtp-Source: AGHT+IGI5khHQIWwIC8A0ujecRvJNh/8dd2rdMdf6ZZWOg9tPpvImGZXGtcFwEzmElLefwyL9zx9yg==
X-Received: by 2002:a05:6000:2d12:b0:39e:cbe0:4cd0 with SMTP id ffacd0b85a97d-39efba399a4mr1021492f8f.7.1744970430670;
        Fri, 18 Apr 2025 03:00:30 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493124sm2279882f8f.68.2025.04.18.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:00:29 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:00:28 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] openrisc: Fix build warning in cache.c
Message-ID: <aAIivK7NDG-6_aIU@antec>
References: <20250401200129.287769-1-sahilcdq@proton.me>
 <Z-6VyRhGdInVidsw@antec>
 <af85b465-13e5-44e5-a0af-c7c68af7d43e@gmail.com>
 <aAIDfcZ4XD5f6mA4@antec>
 <f6f4f410-4a0a-4ce3-bf41-413af39fd50e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f4f410-4a0a-4ce3-bf41-413af39fd50e@gmail.com>

On Fri, Apr 18, 2025 at 02:42:20PM +0530, Sahil Siddiq wrote:
> Hi Stafford,
> 
> On 4/18/25 1:17 PM, Stafford Horne wrote:
> > On Fri, Apr 04, 2025 at 10:39:22AM +0530, Sahil Siddiq wrote:
> > [...]
> > Hi Sahil,
> > 
> > Sorry for delay in getting back on this.
> 
> No worries :)
> 
> > I was working on getting this patches ready for upstreaming and noticed one
> > thing:
> > 
> >      ---------------------------------------------------------------------------------------
> >      ./patches/or1k-20250418/0001-openrisc-Refactor-struct-cpuinfo_or1k-to-reduce-dupl.patch
> >      ---------------------------------------------------------------------------------------
> >      WARNING: From:/Signed-off-by: email address mismatch: 'From: Sahil Siddiq <icegambit91@gmail.com>' != 'Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>'
> > 
> >      total: 0 errors, 1 warnings, 102 lines checked
> > 
> > As you can see above the scripts/checkpatch.pl is failing with the warning
> > about your email and signed-off-by not matching.  You can see more about it
> > in the FROM_SIGN_OFF_MISMATCH section of the checkpatch[0] docs.
> 
> Ok, this makes sense. I configured git-send-email to use gmail because
> protonmail does not work with git-send-email without a paid account.
> 
> > How would you like to resolve this?
> 
> Is this a warning that cannot be ignored? I can:
> 
> 1. submit the patch series with another email address that won't have issues
>    with git-send-email, or
> 2. submit the patch series using protonmail's web client (which might not be
>    the best option).
> 
> I would prefer not to use "icegambit91" in the signed-off-by tag.
> 
> What are your thoughts on this?

I could rewrite the from header to match sahilcdq@proton.me.

But if I do that you should find a way to get proton.me to work with
gi-send-email [0] for future commits.  It seems this can work using the
Protonmail Bridge[1], though this site also says proton.me is not so good for
using with git send email.

Maybe using another email in signed-off-by would be better.  The current
patches are on linux-next[2] where we can see the From/Signed-off-by mismatch.
For example:

    author	Sahil Siddiq <icegambit91@gmail.com>	2025-03-29 15:16:22 +0530
    committer	Stafford Horne <shorne@gmail.com>	2025-03-29 10:22:21 +0000
    commit	af83ece87a1ef5097434b7c3c1fc0e9e7b83b192 (patch)

    ...

    Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
    Signed-off-by: Stafford Horne <shorne@gmail.com>

-Stafford

[0] https://git-send-email.io/#step-2
[1] https://proton.me/mail/bridge
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/arch/openrisc
