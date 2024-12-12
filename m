Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85341223304
	for <linux-openrisc@vger.kernel.org>; Thu, 12 Dec 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019347; cv=none; b=A5cYPBdjt9BCI0kAAU9c7xRXG3fpP9TsYZrSlS7Xco32Oym2KZvBxNmpWqqf71ab09qfc12i46v07TWds2TknfnGfn/l+FopVGF07tWfv9H83/VoZJgu6rtsTLEpNJJhrOzaFghkRXTdn85tjtY8ysdvwh1jsV2ss70fA0jaoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019347; c=relaxed/simple;
	bh=RjD39zlfgTf9pkfh7d/i5jdOBcMRTVOOmItBJQWuHFc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5kmmB+OwOykxobxR2sKfmrbdNG8ZZaznAHjZFb9qCnL7XHLqpR8etdyGI+lxrGJ1tbiZ/w6Usp1WMHfodfFz25NLAreH/r6YnV3Rp5zdqUadq2TUhrzg2hHvzDCNm4tGhQB/wF2G5AdJMBy8V6I0bI0QAasJ/P9BMJGDIBq3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy3rJ9q8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy3rJ9q8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43622354a3eso5808315e9.1
        for <linux-openrisc@vger.kernel.org>; Thu, 12 Dec 2024 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734019343; x=1734624143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyZOc9WzqbeMb86755vK+LfhFLqwmrAR5+Ltt8vp+yA=;
        b=Yy3rJ9q8Pikwwi75UQ8VEfwEZbUXb95pBidOED1idJ1NSPF+XOwIpqKw068cHmXHca
         QkstcIStFKfs5VLwAmFtYe79SxMEK/6G5PteZoIl1ZaMgjM+Lt5po7i2ZKlZ5DvVf3g/
         PvjHrKngJMLJHD2XTlGA31anQpEZuQ/6OJJ0EF0GHWyL7/8XOZoc2xP+J0cCZ1IYUqvQ
         12OrMaFjFfg8XJwdff/WRPcEOwMErhCm4mLc9TeQhV3rj3ee55fWesaKl4PerOvpJ+pG
         lVzS2abxssGprCOc8gvqanMT9EUiwyvQEoViQx7jB+/wTxnJV3Eo2RRhO8eZWuY4URJr
         b8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734019343; x=1734624143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyZOc9WzqbeMb86755vK+LfhFLqwmrAR5+Ltt8vp+yA=;
        b=Yl7zNLTGczDPKvLf+W2joDaSd2nODKS3ldCsOgMTMcP17b/iS7HdbZyv18uwGrtPyk
         M9SL/ei/DfHDVEOg65mAebRjjksrAukiAh7zFrGNByfiFH3nilg8SOXp86w1hujhDdFn
         y6iewrjkWOigpMdyQoILBspLMHAKucyZCDcCXw0EW0+nlh/s9iq8LlrsH95U88akO5fC
         GeTAl93k+AXEAAYRRlY757tzre8vD8MoDEFh7AdNuLhCMptRU3N8tndVKqnfRsGLNtCz
         n4ySi1KZ1oTM+lsRiSMGpRh0s8l/rQS+GKqmdD3dFVCKxzjvmYKuFVYtNlfFWUxgA0mz
         sLBQ==
X-Gm-Message-State: AOJu0Yws5EaSc4XHErMw/mXgmpqDCJx0IweJA+z7n1z820jjIcrmaaM0
	yTohRFYmH371JXtBaXhA4CqnDjHO+IamcfZdKcLmNpfaaPx5Iy3CS6olKg==
X-Gm-Gg: ASbGncs/IODTJ5ZuDgMK7ty49aaKQjavy6Jmwe3vqlAYEUlTXVoI89loUKzwYyyAVVG
	UVnsrsKZTcFizWyBRonsQToyvJeF7TjlXunGj96SwreTBTmisTT9nslpfpUbQJu1DDWSlDJw2ew
	O7PN0ZTcXRODxdrM1bnwfxpBFgmwqsL94ynlsreI3cpkjl41hswiJFtDUGwmjSfjQfEXuaMbG9H
	A6B8LbLABcc2cooUnbCxule2M8F6WDBlnWXDmsyck8NztS9Xb1aERb1fkBlNqtKK7qGSDI8KszX
	7jgfhx7V/M1dg91maQgr
X-Google-Smtp-Source: AGHT+IGfa8f5u7BSnp8BOWG7mP8kfUqOdVfYCAyMU9RHHBZNBaIDLATUgtIaPYlHi2Z0ZDZFotUgYg==
X-Received: by 2002:a05:600c:a011:b0:434:eb73:b0c0 with SMTP id 5b1f17b1804b1-4361c38d930mr56045365e9.5.1734019330465;
        Thu, 12 Dec 2024 08:02:10 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ef66sm20795595e9.25.2024.12.12.08.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:02:08 -0800 (PST)
Date: Thu, 12 Dec 2024 16:02:07 +0000
From: Stafford Horne <shorne@gmail.com>
To: Linux OpenRISC <linux-openrisc@vger.kernel.org>, newlib@sourceware.org
Subject: Re: [PATCH] or1k: Fix compiler warnings
Message-ID: <Z1sI_3QXMyl1ez8G@antec>
References: <20241210125847.401222-1-shorne@gmail.com>
 <Z1mPY2CcYF_WaHEj@calimero.vinschen.de>
 <Z1mkGubLCh8Rte7Z@antec>
 <Z1oUxmYHBXJKHHcp@calimero.vinschen.de>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1oUxmYHBXJKHHcp@calimero.vinschen.de>

On Wed, Dec 11, 2024 at 11:40:06PM +0100, Corinna Vinschen wrote:
> Hi Stafford,
> 
> On Dec 11 14:39, Stafford Horne wrote:
> > On Wed, Dec 11, 2024 at 02:10:59PM +0100, Corinna Vinschen wrote:
> > > Hi Stafford,
> > > 
> > > I'm not engaged in this stuff, so maybe this is dumb...
> > > 
> > > Changing the parameter from uint32_t to void* sounds like it would have
> > > been the right thing from the start, but it's also an ABI change on 64
> > > bit or1k.  I could imagine the uint32_t is just a pointer value from the
> > > lower 4G space on 64 bit.  Do we even support 64 bit or1k?
> > 
> > Hi Corinna,
> > 
> > I think it's a good conncern.  I put some comments on the patch below with my
> > thoughts.
> > 
> > If this is OK, I will send a v2 with a better description of each change.
> > 
> > See below:
> > [...]
> > I agree that if we did have a 64-bit implementation it may be an
> > issue.  But there never has been one, or1k is only 32-bit.  I think
> > the ABI does not change with this patch.
> 
> IIUC or1k is designed with 32 bit and 64 bit implementations in mind.

Right, the architecture spec was expanded to include 64-bit but that has never
taken off.

> However, if there's no existing 64 bit toolchain for or1k yet, my
> concern doesn't really matter.  Even better if the ABI is 64 bit clean
> before such toolchain is created.
> 
> > Maybe I am wrong, but I think this is safe because:
> > 
> >   - There is no ABI change as void* and uint32_t are the same in or1k
> >   - There is no API change as or1k_uart.h is not a public API
> > 
> > What do you think?
> 
> Sounds good to me.  Just go ahead with a v2 as per your suggestion.

OK, thanks

-Stafford
