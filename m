Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAF212D65;
	Tue, 24 Dec 2024 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735071719; cv=none; b=TPM8r9EaiRFSev6CaKtWmeaccwiCoBCVMTYsOsINYFp0oWQVQo1TBXKUHL/ZBnh2GqoxcEAPPS8QLgkdxqdO3ygtH7zDKVO/xKQVXxKxUeqZ6pCj3dOW/OEgcgXTknV04zsarUeSsdhDLW3WiJE1oAv7Lp6OoZogUsfI1tY0SmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735071719; c=relaxed/simple;
	bh=lrZuvtJLO+ODhBjiaYakRFdOqlf92oZVKHokzkG0r/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO+5JwgyqzXoqx0mm7GYCSiMfRfvu80RxH//MteFAfXtyJrK0xquSYtph3OAIQxSmLVQWeH04g4rMeZ4T7PMcG5eRalxe9moMjLp2l41vPOqFKy9/gu9h0dWY2CwuS1ZrR4XTBKWWGxLRAVXhwAFGA1wO5POSki1wsPg1eMo2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvTtF2P1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvTtF2P1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d161947so2619581f8f.3;
        Tue, 24 Dec 2024 12:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735071716; x=1735676516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atbGifQIM2H5IJ+rpy7vbzj9n0kS26ASFPC2gnvIgMw=;
        b=SvTtF2P18giy2X6stKsaNCOrvoJSNzxOzB7LKczoISBEeDDCDQJMXXJ7xl1fpnmHiS
         HUCFZ2QoXf4l8Nr7SGAE1rH/RCnr4ZoUcmrViQLYgatjPsYRx0Z47Pgu3MDluSeJI7ff
         WhK+NokqfTzg56FU66widApV7SgNZgqv/+Q7mmj96bffGQyXupC9DK1dMpOMXspytRkN
         DEXBmBCY5ZNrpNJfhi/A8wm7ujgWHz6/VvJvZZIF5zv993u7GDVCPBVhf+Ty2YOiog5r
         QOTcJDs+ozM0tF+tuw0HjQGDrbSRj8jrvBzvupAfa0x6RYPRZmqeugsAuhUUA7gEvwG8
         fhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735071716; x=1735676516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atbGifQIM2H5IJ+rpy7vbzj9n0kS26ASFPC2gnvIgMw=;
        b=NKDSnqr0K2tBsZR7eHWmqaVjF8mm889a/zGRXch7KnHdhhSTmg/sAK8eA8TbtRQb1g
         qXgLlrBX0UjCPFGrV2se/mXf8nbDmW5EzODqdAFZfvLEsGcCzOt/HwKT9d64EsV7/BTj
         iJmsZHDLmVIzYs8TXGNSa7gjF20dWnh6PnEVIAdaN76BJZ+ANCCYB9/bx9z5uJtWVmPJ
         gUaVFV89gOIQ/sOk0gUMxSS1/1oHb7L9YNSSm1Rzm0cOW14IgCrc620zWoNr6IGpfH0w
         eOL8rG5PSOSH/744hpLQqe5CLzGnHKtQhueGsqJNBRL5COlxmb1hArcYhCEYUoXMGthN
         2/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUiI+pPpLPZJU7Z5+iwmDhj0iEX7ugnObC6DHWiT7AQHvJPua7i/cR4j6/otXuFrzGeTR30OyShCQc4ZXUW@vger.kernel.org, AJvYcCVwVqYNmKYmPLEkdaw1PTzIe4VdL/C9wooMrRDUWS2daQtHmWntkaN84RGvf0RuGe6ng0Q1pUOO/pZd@vger.kernel.org, AJvYcCWItDYnoh+gYDaL82yEIIneGeMIIiZ/opYHo3xOOZdAgi03/tp99BpZegxutmP3mNQzi9PtfYgQUv2tB6YE/p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Ych6Xo33+q9uUwOKqRyZX0XG70u5Y2o4Fio2ZeR2DaTc92dA
	aDGYkxinTYrebCxzSoC4a1kPQtXo9neYj6xPenIDP7o6hgVdAYTfPtUlIcQyusQ=
X-Gm-Gg: ASbGncsJ3j36O+jX3CkZhvc0r+eKG+2fvgl7npo0SN6YaKy9i19WFObGl9H+Gdbdvam
	dpLkKppwfa8fMo1qMYhhNxhzQnvC/cxVG0WbfuSLPfhmKz6XDVE/UkGlrRZZOfwYV92Qn1NqEom
	4ch1u4ETfB6Cb9dy3gD9mPQnqnCRhEkf7ngsWTfXGACbIF7OXSas1UZrwlGdhrv+EAO6l8CBbGR
	2W/BacgnGlpWaDP0CxdQuRL8yxcAkP9C/MVfeXxiKf9fJ5FxEWUDX9K1kMibaH1Ej4ZCffQuykt
	XjYlge5tAn0Ys81HGPz4
X-Google-Smtp-Source: AGHT+IFTtglOPOnR65bnQJNVIFMfAuslZGfpnY/WuS/Unk8l/SSDeHIHXRhKgP9srRxl3LeizZ0Gnw==
X-Received: by 2002:a05:6000:178c:b0:385:d7f9:f15d with SMTP id ffacd0b85a97d-38a221e300amr16069720f8f.11.1735071715809;
        Tue, 24 Dec 2024 12:21:55 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e126sm14711673f8f.65.2024.12.24.12.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 12:21:54 -0800 (PST)
Date: Tue, 24 Dec 2024 20:21:53 +0000
From: Stafford Horne <shorne@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Karol Gugala <kgugala@antmicro.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] openrisc: migrate to the generic rule for built-in DTB
Message-ID: <Z2sX4UwT_ds_6TFt@antec>
References: <20241222002355.2581242-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241222002355.2581242-1-masahiroy@kernel.org>

On Sun, Dec 22, 2024 at 09:23:50AM +0900, Masahiro Yamada wrote:
> Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
> DTBs") introduced generic support for built-in DTBs.
> 
> Select GENERIC_BUILTIN_DTB to use the generic rule.
> 
> To keep consistency across architectures, this commit also renames
> CONFIG_OPENRISC_BUILTIN_DTB_NAME to CONFIG_BUILTIN_DTB_NAME.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks,

This looks good to me. I will queue this for 6.14.

-Stafford

> ---
> 
>  arch/openrisc/Kbuild                       | 1 -
>  arch/openrisc/Kconfig                      | 3 ++-
>  arch/openrisc/boot/dts/Makefile            | 2 +-
>  arch/openrisc/configs/or1klitex_defconfig  | 2 +-
>  arch/openrisc/configs/or1ksim_defconfig    | 2 +-
>  arch/openrisc/configs/simple_smp_defconfig | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/openrisc/Kbuild b/arch/openrisc/Kbuild
> index b0b0f2b03f87..70bdb24ff204 100644
> --- a/arch/openrisc/Kbuild
> +++ b/arch/openrisc/Kbuild
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y += lib/ kernel/ mm/
> -obj-y += boot/dts/
>  
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 3279ef457c57..3d053e0b59f4 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -10,6 +10,7 @@ config OPENRISC
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select GENERIC_BUILTIN_DTB
>  	select COMMON_CLK
>  	select OF
>  	select OF_EARLY_FLATTREE
> @@ -92,7 +93,7 @@ config DCACHE_WRITETHROUGH
>  
>  	  If unsure say N here
>  
> -config OPENRISC_BUILTIN_DTB
> +config BUILTIN_DTB_NAME
>  	string "Builtin DTB"
>  	default ""
>  
> diff --git a/arch/openrisc/boot/dts/Makefile b/arch/openrisc/boot/dts/Makefile
> index 13db5a2aab52..3a66e0ef3985 100644
> --- a/arch/openrisc/boot/dts/Makefile
> +++ b/arch/openrisc/boot/dts/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y += $(addsuffix .dtb.o, $(CONFIG_OPENRISC_BUILTIN_DTB))
> +dtb-y += $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
>  
>  #DTC_FLAGS ?= -p 1024
> diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
> index 466f31a091be..3e849d25838a 100644
> --- a/arch/openrisc/configs/or1klitex_defconfig
> +++ b/arch/openrisc/configs/or1klitex_defconfig
> @@ -7,7 +7,7 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SGETMASK_SYSCALL=y
>  CONFIG_EXPERT=y
> -CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
> +CONFIG_BUILTIN_DTB_NAME="or1klitex"
>  CONFIG_HZ_100=y
>  CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
>  CONFIG_NET=y
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index 0116e465238f..59fe33cefba2 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -14,7 +14,7 @@ CONFIG_SLUB=y
>  CONFIG_SLUB_TINY=y
>  CONFIG_MODULES=y
>  # CONFIG_BLOCK is not set
> -CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
> +CONFIG_BUILTIN_DTB_NAME="or1ksim"
>  CONFIG_HZ_100=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> index b990cb6c9309..6008e824d31c 100644
> --- a/arch/openrisc/configs/simple_smp_defconfig
> +++ b/arch/openrisc/configs/simple_smp_defconfig
> @@ -20,7 +20,7 @@ CONFIG_SLUB=y
>  CONFIG_SLUB_TINY=y
>  CONFIG_MODULES=y
>  # CONFIG_BLOCK is not set
> -CONFIG_OPENRISC_BUILTIN_DTB="simple_smp"
> +CONFIG_BUILTIN_DTB_NAME="simple_smp"
>  CONFIG_SMP=y
>  CONFIG_HZ_100=y
>  CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
> -- 
> 2.43.0
> 
