Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED631B810
	for <linux-openrisc@vger.kernel.org>; Tue, 20 Jan 2026 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937031; cv=none; b=UIiNqKTwj6lRxBEuzJa1iKQuZLU91cbeJeFVZfULoLkLVU2bNI4PDdfZWlYaPW093aNC91tHycw0QJSENlu++Vs4ayCF5NzoS/WlXtD/y2kE8lsZv8CJpN2j1BTx3+W/cOep2cdsR3YbCKbTb8DoDIwbOl+4ch/f+0+xQ+nuCWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937031; c=relaxed/simple;
	bh=iFyz9iMAr+j91DPr9mK9EakRZorWKp+biw6lQCJB8jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFDcmoBNfuOivaVwlWn38lyjpNiipMuJUXysIMyEK6j5rNIJCzfHdf4iHTo6gijcEOHpPKSxG7FeYzVCYgFRkg90wwlkiVlfCKi29AgGxd9JFQOl6bc5UGzdIyiCi28QWFRVNxsOjxsdfaodLwcLTacXU77aS0htyc5o6PU7eZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu/pvQEg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu/pvQEg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so38160435e9.1
        for <linux-openrisc@vger.kernel.org>; Tue, 20 Jan 2026 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768937028; x=1769541828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlcPtB/vkLtnzhxmmvarVCwPpli7Lu4X7dLZI3+Lvfo=;
        b=mu/pvQEg08XBuOv7yXmaYoQcE5FM+4mKOxpunY85/2ZYIsg7PZdWBg3CWjh/BZpNz/
         N0tzxGQnr/itgc9eL6SuhXefVFm9BHIE7eu7OSg4Gg7D2zZPqDE/Zwm3MQx4gHZhwiWK
         rg29lhWcOXEJfJpL7YPErD/5uyxVtPQisMtjP0UfQU5R5MS5qmCj7A+fSNrRsHxZY3PL
         wv+8WjwZNvGqvypcWDmGdKq5dSOBNyYYIK19REGaxzJN2aZzTFJp6tO3ycKXY7nwa/RO
         EW5N4mT1IiSeFRV1C2CpuH5kxG+MTFYAh2xIMJmC80RSnG5PNtWJ0A75ROBgFV3xtQTT
         4YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768937028; x=1769541828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlcPtB/vkLtnzhxmmvarVCwPpli7Lu4X7dLZI3+Lvfo=;
        b=pEEU4DtkuLV2prN/2h4G8EtensWuY+eITLOnwGhSRlxcCxSMDDGEkY5zdR34j3Rot8
         /mO7bH0TPewQDQS0UhVM0yuovCYlhOaj0BjSmPQgYsIUYeoph1g6dytzjhV5YQXMgdph
         1SZcY2/lmdf/oJwu5G3m9cE41Uij/TuReQc/25R/T3DUT8kep0ewC6Y3UW/SCj9AaFa5
         I7JL0ETFnfjIXnrqMCB/xoFQ4fwnFDcwHmQOy/3pchwrky37hCM7hUx10qNzyxpSR2xT
         Xp8iCoHcnG9+Ty90v+mxB6ZGyzga3GF/jX+2v5vwlurOa5zCmhMOIDuK79pmTrOByWPW
         NLLw==
X-Forwarded-Encrypted: i=1; AJvYcCV53pStmJjNBMcMDymSQqn8sUbLstl2onRQq+mW+G9NzGnXOjjwmgTciXjkIEiHYHm8mdu0pEnwvziiGGK3lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPY6EsLDrHZ0vXYWW3/zSars6C7825fl6QbKbB6m9YvYrTJ4cF
	2vBIQWKPxQ9rsKlNuI+OwNpjW+PxIRyagvp0DwENI/gj7ii0Ow70ODXG
X-Gm-Gg: AY/fxX4U11CnfQDp7dZHe2BX7gL5BcV5gq6LVZgWjQZb03DyJg3kuodZwcV3X4nmHPg
	PyBkGGY222BDAlRRTzOEQdvlgHyqqHxlsPfNVzgvBHzJdca7KA/Xe8XameqyhM9wrSJ/bi/uOOA
	yzX6Q/ZDLlsMFj8adQZm0NG3q+b/xembKc4dhh781jll3PnL+jsuc1QgEfx/oqwcy6Fotv0UltH
	q3ZSrkR39lIcF4xWySZRqL9608RkVtdv1BAppuiTgEk8njWIlXgxy9rlSGcQ8zagoGOmjN/GTHS
	GFYGiELJt+0pZIWftp+tSNbdRTyn5zMOOg9RLdf8J91P3XxoTGNOwWDpEzFJZi4f+y5ZlU2KsJ2
	YqCt6lYeClIaYZEZu1p1nB3/whHVUt/CACsPP4Rmgdg8qrJGNxMLi+Y/E1L5UOsbyX3A7YeDtR7
	9BIe1ma58XJe4nXUT+1/QC63hnauh5HXseS4G6rxL58pQApn3VPOziYlfEwwr0tKHFmHUpndcDI
	jY=
X-Received: by 2002:a05:600c:524e:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-4803e7f1860mr45462755e9.32.1768937027356;
        Tue, 20 Jan 2026 11:23:47 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879537sm263750375e9.5.2026.01.20.11.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:23:46 -0800 (PST)
Date: Tue, 20 Jan 2026 19:23:45 +0000
From: Stafford Horne <shorne@gmail.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] openrisc: define arch-specific version of nop()
Message-ID: <aW_WQfaa4zzO6YR5@antec>
References: <20260120-openrisc-nop-v1-1-a29da65537c8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-openrisc-nop-v1-1-a29da65537c8@redhat.com>

On Tue, Jan 20, 2026 at 12:07:23PM -0500, Brian Masney wrote:
> When compiling a driver written for MIPS on OpenRISC that uses the nop()
> function, it fails due to the following error:
> 
>     drivers/watchdog/pic32-wdt.c: Assembler messages:
>     drivers/watchdog/pic32-wdt.c:125: Error: unrecognized instruction `nop'
> 
> The driver currently uses the generic version of nop() from
> include/asm-generic/barrier.h:
> 
>     #ifndef nop
>     #define nop()   asm volatile ("nop")
>     #endif
> 
> Let's fix this on OpenRISC by defining an architecture-specific version
> of nop().
> 
> This was tested by performing an allmodconfig openrisc cross compile on
> an aarch64 host.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601180236.BVy480We-lkp@intel.com/
> Signed-off-by: Brian Masney <bmasney@redhat.com>

This looks OK to me.  Queueing.

-Stafford

> ---
>  arch/openrisc/include/asm/barrier.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
> index 7538294721bed7bc8da3d08f3db89a408091f3f8..8e592c99090235423a9f4c9149da9822918afb13 100644
> --- a/arch/openrisc/include/asm/barrier.h
> +++ b/arch/openrisc/include/asm/barrier.h
> @@ -4,6 +4,8 @@
>  
>  #define mb() asm volatile ("l.msync" ::: "memory")
>  
> +#define nop() asm volatile ("l.nop")
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif /* __ASM_BARRIER_H */
> 
> ---
> base-commit: d08c85ac8894995d4b0d8fb48d2f6a3e53cd79ab
> change-id: 20260120-openrisc-nop-82b7f95dad7f
> 
> Best regards,
> -- 
> Brian Masney <bmasney@redhat.com>
> 
