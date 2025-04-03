Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303F45C18;
	Thu,  3 Apr 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689168; cv=none; b=YWQnST+fLRlwwjNEyQ+fPzZmm5XqEoFzNswtwgsHcNuAsQJe2CkaMReEUrWht0j96abAGmsfLj6/+wKkG5dJQO5q7suUeeaGYiOrq4QtPEKiZdEh2tq0E6ZAQrLNViTT5KASrIWLQqMYIPP4njd92cnDwRCBdv2BAOdWsUXtqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689168; c=relaxed/simple;
	bh=zu3u2ChpM6x6j8qkhbLwOzKuOSKEV5HQD/n9ssTYcyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufFOwgVmdiS1+kBFHNgUt8dPFaYuSJ9Kt/5Nj/IIAJ8bFK9E60Or9thzbfTD9IZWtiExFZgedhaMkBYN5VpYemyUZjihc+8h/ULT37sPcRqS+P3Nbd81Y5Ls9qzz3SmMCKwr+mzczGk8y6SSdam3yKiUymGzr38SheR46Wt8IRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkz4kfuB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkz4kfuB"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c30d9085aso464754f8f.1;
        Thu, 03 Apr 2025 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689165; x=1744293965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSVBq2vvXQ5f0YR3Y4w44ZUYQpggzfZsXtbYmHNAQYE=;
        b=fkz4kfuBcM645+Ww3fS8JS/DtYBHqxT9WZHzpfW4Gb6V6ftgIKf8Z5xJWSXyAooAY/
         VWCDn+MsCaRqF3WoRoxBgDP9Zy1ZmvD8ZZsAq6MtyTRlQJVDTXid8EMsqP8YY7Snw960
         B6dXlaFR1+I3t7nIJGqHDO0poSRKIMBfA227NQuvP2eNms6ScCpw/ATnqima+p7ptPP3
         S8pRJkQvGPgGMyEa1xQiQT73+FGVwyu3lBuGEBVbavT300hpgeIh7nNCm3BvN0UmNqIH
         cStulaxvzbRO4ROcdX/X0qiLOPXLqwi5lISdDSH1j3KWzhmg3iVFr1VDHgZ2d5YjHlkr
         WnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689165; x=1744293965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSVBq2vvXQ5f0YR3Y4w44ZUYQpggzfZsXtbYmHNAQYE=;
        b=p7Wh7qQCBLOPL7GCi+dUFgANsUA2Rfv5ogTUfTYA6zeRD1ekknLdDf8WDjCqJJc7WA
         8AD99jFHunMI4sHJW/kqZUQW65PsSeLBn6E9i9j3uxd+jyzxw1yEKBCuQDZbg6BRge9f
         EPLVKgx88EYzhpCnVm72IZffg6eP/DbJRqEVIR8p81cH6iJV2oiYUAIZU2AzLUXfP4Vu
         gMvUAA1M2XSOm5k1rXB9TuS1XXEEZqwqp1JpExFzYjQObG8/FgSYx9K5gkWuA1Qa2t4j
         EAgCgnP/8ahuYnePPrb9GL88C4oCnIujpf+D4S+FROce8K0ThVvOlr02K4HjhPvDQCBd
         UXzg==
X-Forwarded-Encrypted: i=1; AJvYcCUfGvKiefZ7OHTmsTX2phdkLuGFkXTIS8WOh+4oq5m8iCoZnQ0SBZDqVNhIHrDEOKnGP7VYh5jNh9emCQUEyWA=@vger.kernel.org, AJvYcCWLabLNZh8ZnSUVo2Uk76/5xet6MQwA8vTiJS2aVoTU8cgZeWz7jB9QA5xHZl6gP+bM59qvjmC/xpfUKhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTxNwdE2Ues4Dsyk01vP4grru6WdqF37NmLllZOGpnq1q993h
	p7dmDBfqrBJ2LrbfpvVz1UDFnmmyu6bp7jnnvHo3aLkbTn1mUTiwPBsfJQ==
X-Gm-Gg: ASbGncs6CcIIzoyaXrrV+zhCZXVb4qVYmbDcO3PT1uIfS9bGzngrgwrkS70AWOItAHI
	9f0YcQUiTZuXPi50WXo6b4CPJjyegQQz7g+74uKFCd/K8eHv0+yrdphxJiRYvJmwnEiPllMHoW8
	rYYQDL1EFfAWqXU0qRWa3Wogp/k4gZDgdfdNjEI7tUGGtVUF9nACg5GaGa8GsVZMLLJMlzCBcft
	St/XveM9oeRcoJM5JVCq+hF+kWFDPykag+avXy8UyAzaTjf1WY4U+kl187MJrWVvj5JGtxgWuR8
	LV6sNyuPq9QlgSs8xmiHRQn2p2HZomL1kYP+p8jTWg3fJLeRfz4JMrpaDuoqutumlP2PudZIATW
	L0ccGDtSc
X-Google-Smtp-Source: AGHT+IFd+r4atu1Xj2pyFaetp8ao4PwiW1Baonfysak549TauseTYG3yw3uf4PIBIllkoVzLvHmc5Q==
X-Received: by 2002:a05:6000:400f:b0:391:2f15:c1f4 with SMTP id ffacd0b85a97d-39c2f957927mr2905069f8f.55.1743689164678;
        Thu, 03 Apr 2025 07:06:04 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30239813sm1859153f8f.101.2025.04.03.07.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:06:02 -0700 (PDT)
Date: Thu, 3 Apr 2025 15:06:01 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] openrisc: Fix build warning in cache.c
Message-ID: <Z-6VyRhGdInVidsw@antec>
References: <20250401200129.287769-1-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401200129.287769-1-sahilcdq@proton.me>

Hi Sahil,


On Wed, Apr 02, 2025 at 01:31:29AM +0530, Sahil Siddiq wrote:
> Commit c5c6fd8be51207f0abd3 ("openrisc: Introduce new utility functions
> to flush and invalidate caches") introduced new functions to flush or
> invalidate a range of addresses. These functions make use of the mtspr
> macro.
> 
> The kernel test robot reported an asm constraint-related warning and
> error related to the usage of mtspr in these functions. This is because
> the compiler is unable to verify that the constraints are not breached
> by functions which call cache_loop_page().
> 
> Make cache_loop_page() inline so that the compiler can verify the
> constraints of the operands used in mtspr.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503311807.BZaUHY5L-lkp@intel.com/
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Hi,
> 
> I noticed that the previous patches have already been merged in the
> for-next branch of openrisc's repo. So, I thought I would send a separate
> patch to fix this.
> 
> I managed to reproduce the warning and error using or1k-linux-gcc 13.3
> following the instructions found here [1]. The issue is not with the usage
> of unsigned int in place of unsigned short. I tried replacing int with
> short but that didn't work either. Apart from this, I see there are no
> issues with mfspr even though this uses unsigned long for the register
> "ret" and for the immediate value "add".
> 
> Also, from the gcc manual [2]:
> 
> > The compiler cannot check whether the operands have data types that are
> > reasonable for the instruction being executed.
> 
> I am not sure if the above is just for output operands or all operands.
> 
> In mtspr, __spr is constrained to be an immediate value. I noticed that
> all calls to mtspr (except for the ones called via cache_loop_page())
> have the value of __spr evaluated to a constant at compile time. However,
> the compiler is unable to determine if the constraints of the operands
> are violated when mtspr is called via cache_loop_page(). Making
> cache_loop_page() __always_inline solves this problem since this results
> in the value of __spr being evaluated before compilation is completed.
> 
> This warning/error can also be observed for mfspr by changing its
> prototype to:
> 
> __attribute__((__noinline__))
> static unsigned long mfspr(unsigned long add) {...}
> 
> The compiler did not throw any other warnings/errors on my machine.
> 
> Thanks,
> Sahil
> 
> [1] https://download.01.org/0day-ci/archive/20250331/202503311807.BZaUHY5L-lkp@intel.com/reproduce
> [2] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Output-Operands

I will just take this fix and apply it to the series (git fixup) rather than
take this patch as is.  Also, as registers should be unsigned short, I think
we should change the type to that.

I will fixup patches in place.

-Stafford

>  arch/openrisc/mm/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> index 7bdd07cfca60..0216d65e6f86 100644
> --- a/arch/openrisc/mm/cache.c
> +++ b/arch/openrisc/mm/cache.c
> @@ -40,7 +40,7 @@ static __always_inline void cache_loop(unsigned long paddr, unsigned long end,
>  	}
>  }
>  
> -static void cache_loop_page(struct page *page, const unsigned int reg,
> +static __always_inline void cache_loop_page(struct page *page, const unsigned int reg,
>  					    const unsigned int cache_type)
>  {
>  	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
> -- 
> 2.48.1
> 
