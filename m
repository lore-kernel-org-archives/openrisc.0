Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF732184524;
	Sat, 29 Mar 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743243146; cv=none; b=rItokiFxnqtk8gHrvqXHzgdfY4MaMZe7czo/UHqUDjJmMLDy95V1m4GNF+uPpQ9s3PIWr6RN1Mbs5+eDfaVLUsgODtNQGaPprELOp8ihVbdsqMQY14fMUpyY0zf4lfa6EU9BcPWE1MzHxKBcuAgo/rNm/wGBj1yRaNyn7YuDanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743243146; c=relaxed/simple;
	bh=wvxCqMNZb48yRiki3mhcMKOZ1kNCA1qXcKYhdLENOKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGdtAUm3LqdeAXYFObYAKQhBhAWRXXiGnNiiK/gfOfFlR06ECtX1x67Ff1fHspVuwROHDKug3aOz7meZuA36JqcLThOI7rcza0e3qiUPSJskrs8Ooen/i9igeQiTsBI8+tYsgNVd6avYNoO7RD6frXWC3GGCYjKL34A/6OvoiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYOzXy3y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYOzXy3y"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso13604305e9.3;
        Sat, 29 Mar 2025 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743243143; x=1743847943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUeHeIiWi0wUklAANF4ypF28tasePe8/YNHk2njR8mA=;
        b=DYOzXy3y7WY0uDaZ5UIVF7399fYLd+bUYFifn+ILxLcHFrMOInbZUiv7CQsXy8Svhc
         rtEC0r3S3rnN+jdeYEEVphi9ef69XJMm0DUc6G5PPtT73Johi1/Y37xzpxjHAFR84IM8
         tsg0+BeYGodWwhnggSw0aSfrkx7D4kq5hw6RriM3G5H7RrTX2gx+k1Dz1GCST2bE615i
         mQkMf8+wFzyToKDA9E0iSWC17h/J0i4HswpBQ2OwrxlgUsjvL22iKjgwzsV/OalY4Epg
         MFkdrz4qyeKcVspdkLskBNBdPV5UPDTKGc8GcdFHgrbzk0kY4952yK7UIvZnx1Po3dRh
         wv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743243143; x=1743847943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUeHeIiWi0wUklAANF4ypF28tasePe8/YNHk2njR8mA=;
        b=T35SJok0fep7C/mrIgKt8/39MjrszP8QhPa6F8QUojvLaOuty4WNZatQipm843brtc
         0pV4gs8E4ZEe5WM9P87e9qAdTMfP7P/vX51QDELYxF/GLfgY2vHG82ubxtKMVYT7/BlE
         +W9h2qCB7zL/KrhEfoJ4pGhK2yGJFhHNMV0znEbE0t7ZIlRasrsRYoCk1MEZE0tfGplF
         fFgulyEi58GkTubBBV7GtllVTdNCxAbkFgfESOFJOzbYhnDrQ9kolkrw7hps02b0Nu9v
         FY5+w+dyqdVQ2h9fMD2245PYSHgQM2mJMAb5WLDVRm9hUu2mU/vzy40G+kdnosGr390b
         U1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUlNqTWwU+NCGF+CEwOmL+O3Vvn1hCAQ6Yiy8CWbn9xj1MVbt2R2/iW+PtoRZFKPp97ra30nK6UwikZoj+CVJ4=@vger.kernel.org, AJvYcCWYySNShdFTiEPFQXtsuAGqpfQ4HSSpffpMDHIkswIJdLlhezcH0EVXGofUbBz5rNQN+30XNjK459kOErk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTBDdhldseVamqu7adwo4rjWu5xW09bEHJmcsVFKtqY6F1w9L
	DV0+IV6ipK/Iu1qRyy1WJSlm9f3lPC8r4UV3pBabzjeX7kHioEK0
X-Gm-Gg: ASbGncvdSW/xiqELB0oLNVL9hDOKkjyh8LUMvbkoUUdDATFTOmvUvlbxU+dpu0RhpBE
	9mGJgs5cJb4hTYbA+w/gDHIvBI1j7f+01HvEIykYkCowaJxu1THIxbQgPeQPE8j6fZyEvJwHPUq
	9E03Gxy/B5l7ubmkBWL9STDSU/e6B+PrRcsmXRq9NUqioN0fhqx4mcJzVi8g8bgZpBSB97tRTZK
	oCxnRyXR3hRb4IS46O6cr+Pl+k+u/39IlI6TxminBbMpFUdwFtc/8juL/qfK+guFoUtjLjPWMgs
	HbfyAGDDMsW9NnyEQsBg4iYcLi8G0rptjc2ClM1oLgq7RVMFTEkCnw6MKZ9QLYGTtRB56D9wgrD
	Nu+UCrIZD
X-Google-Smtp-Source: AGHT+IEvib4QJSDtDKzImmT9Wsq0Oz1Zz/p5LdLn6+XNsYmYqtOHG0tdssdwoQRf1dGv1lz5TClS9g==
X-Received: by 2002:a05:600c:5126:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-43db61d7d4dmr19828375e9.1.1743243142816;
        Sat, 29 Mar 2025 03:12:22 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dede5csm102417455e9.8.2025.03.29.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 03:12:21 -0700 (PDT)
Date: Sat, 29 Mar 2025 10:12:21 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] openrisc: Add cacheinfo support and introduce new
 utility functions
Message-ID: <Z-fHhT-0a-fEkPnD@antec>
References: <20250329094622.94919-1-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329094622.94919-1-sahilcdq@proton.me>

Thanks for the respin.

I will take this version and put it in linux next to see if any issues come up.

-Stafford

On Sat, Mar 29, 2025 at 03:16:19PM +0530, Sahil Siddiq wrote:
> Hi,
> 
> The main purpose of this series is to expose CPU cache attributes for
> OpenRISC in sysfs using the cacheinfo API. The core implementation
> to achieve this is in patch #3. Patch #1 and #2 add certain enhancements
> to simplify the implementation of cacheinfo support.
> 
> Patch #1 removes duplication of cache-related data members in struct
> cpuinfo_or1k.
> 
> Patch #2 introduces several utility functions. One set of functions is
> used to check if the cache components and SPRs exist before attempting
> to use them. The other set provides a convenient interface to flush or
> invalidate a range of cache blocks.
> 
> While testing these changes with QEMU, I realized that the check being
> performed in cpu_cache_is_present() would always get evaluated to true
> when the UPR_UP bit was set. This series fixes this check and addresses
> v4's review comments.
> 
> Thanks,
> Sahil
> 
> Sahil Siddiq (3):
>   openrisc: Refactor struct cpuinfo_or1k to reduce duplication
>   openrisc: Introduce new utility functions to flush and invalidate
>     caches
>   openrisc: Add cacheinfo support
> 
>  arch/openrisc/include/asm/cacheflush.h |  17 ++++
>  arch/openrisc/include/asm/cpuinfo.h    |  24 ++++--
>  arch/openrisc/kernel/Makefile          |   2 +-
>  arch/openrisc/kernel/cacheinfo.c       | 104 +++++++++++++++++++++++++
>  arch/openrisc/kernel/dma.c             |  18 +----
>  arch/openrisc/kernel/setup.c           |  45 +----------
>  arch/openrisc/mm/cache.c               |  56 ++++++++++---
>  arch/openrisc/mm/init.c                |   5 +-
>  8 files changed, 196 insertions(+), 75 deletions(-)
>  create mode 100644 arch/openrisc/kernel/cacheinfo.c
> 
> 
> base-commit: ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e
> -- 
> 2.48.1
> 
