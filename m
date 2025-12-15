Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C22328B63
	for <linux-openrisc@vger.kernel.org>; Mon, 15 Dec 2025 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783828; cv=none; b=ZQKhlEGsNE1GKqfuaTcOw2zWvv3K2yUhVraN690QcmCqFerJan66SOhOTmAyo8/GNVWubpIGIidiD0iPXzvIozW12xnDKYTSdGdcHX3Q425o2tLBcn3VTmFnNK8NDpcJleeCg+BJuBpK373U1HmdZx/u8ENwpDo7RlHVLarI6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783828; c=relaxed/simple;
	bh=ny2OD9BiO7SHTpHigNLl/XImUrXL4VCXAvUSIHW8BGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFiRVxRo6wc2PjyAaWYVXy9z1nph6h0QExXI0vkQKMeL1/CI1hMxqNpT7w1JQUmRMxdiqqyC8JT8P8ZGk/s7cHiWbP8JJsdJO1RZrMt5smfgPW6lzMRWzilzo/35BrUrwgAC1PqOgQ034WstuhA9oLjjA8d2qs1bqtUshbTEIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLfquJmP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLfquJmP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779a637712so20500235e9.1
        for <linux-openrisc@vger.kernel.org>; Sun, 14 Dec 2025 23:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765783825; x=1766388625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Xd5pQpDiVW5fKbBbRiS4/q3sr+HKaLlW1Eq/UI+9o=;
        b=DLfquJmPnJMVuFRtn4oBWUX7s3WxUFm7ZjlmW1HXETicMMjSlilhnYNl0NlBQX8m/C
         2TMN8QRR2rOQ91aYOqt5zShn7Ri0DsymP/1OlPlrQ6pACK1EpgKvmnNQw1zY68Z2Ua8D
         jBmVf8M4AtDDDI5ItZkmgL2j3L3eKMF/9wXBPa8Izw+vdhsDfvnKWeUuu2Md/ob5aZ7S
         8X6cmRX+x/sUr5ZwyDyrUZHwZeRAUyp/DGHvvh4h+UBWjjRgaaJCe9hHqgnKd0aLZSD7
         Ht3+lfPoLdZcBsfPIeBHaEtUnXkhVNaY1ROgDzCRn/UjoW4dbVLqDpOSr2y7NW14Kn0F
         v46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765783825; x=1766388625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Xd5pQpDiVW5fKbBbRiS4/q3sr+HKaLlW1Eq/UI+9o=;
        b=CC0W9SzaufjjTmfWklEtQNIAHyZbV21h04ntrKeKKsSQWhfruE1+ab3c3SZ1mJhlpw
         3VhG+LBduh9NYLs4VR5b+2CH8SxcNUEzggAYBnF6yyHlv9jd7SAWMXn69o/BkraFxtw0
         0xbDVtV7n1DOeTnaUsPXvwmFbHHgRbiSAh53L6hPHbe+p8XAo+LMxyEC5zgVloczOQ/G
         T93NvQNquFttesAYHtgimqEnB61ujyJnP3ClVolAM/JCNjsc5kbG8NqHxfkvm9b/8vSc
         n9vjl/Gut1qqRPIGRROCiKDyMkh5+fp8Qb7mYshiOSOmASw+3WzlUkmGL7r7XSH54K7f
         WflA==
X-Gm-Message-State: AOJu0Yz03HR/0cuZMLHNdB7XAfdfD1FMxKX1exleoQuJERu3xXYzEVd0
	xeQg2PG1wUwA9rQfTJvHxYNJDZeHkvMX/URxxiY5NYCDezr/OLu75LJi
X-Gm-Gg: AY/fxX6/zjV7vAkTNjo7I96b7fbnAJYgsMb7f6fy6S9rJpDo0+aNYV/zybs030/4J5a
	d/yZhWIraRiYtmYYvEhyjNAoZJdCOfgklfa6kNmYDwOjVYW1UIgpkExuFmRY3fqn7kb9x/SAMWs
	C1V3sLNKFaOJWNrRilqT1d3zX4Bte4QXVvtRlph1U4530mBEH/Uzav8OtZVx+9kuRkuPZXpZYoX
	Nqq+iQcM9355GXRQUjYKFr0Orkrw/shCYPz/qKjWDlc6lEWaX/SjFLr2FMgclTwHjh1nd4CrPrM
	AMjbZM6VI+Z7jiudLEK3JkrRf4p5NZL5r58nKasKbXNe1hIBsuJK85VKohgVkJln7Ao8vlq87jU
	quT8gdQnm07XYfmXteedhyhu824WdNxVQWnBPRAuYNLWh4m09wBTfjPAj++ff9y0/Omaci9jUhH
	NJ6e/nER0qneJuu5S9kp9DISqyPu3s1fowhSWnUqG/3/9yf3luohR8Dup/NB19S/vJ
X-Google-Smtp-Source: AGHT+IHZi4YEyjXSh3+xr8wfS4Ptfco/QiJmJQcOuGES3JsEx8a6lhUx7zm74MVICNiYUDhJ7dAdnA==
X-Received: by 2002:a05:600c:6090:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-47a8f8a7efdmr89529355e9.5.1765783824606;
        Sun, 14 Dec 2025 23:30:24 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f280cf30sm13151751f8f.3.2025.12.14.23.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 23:30:23 -0800 (PST)
Date: Mon, 15 Dec 2025 07:30:22 +0000
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] openrisc: dts: Split simple smp dts to dts and dtsi
Message-ID: <aT-5DoreXbGm_QMn@antec>
References: <20251214180158.3955285-1-shorne@gmail.com>
 <20251214180158.3955285-5-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214180158.3955285-5-shorne@gmail.com>

On Sun, Dec 14, 2025 at 06:01:44PM +0000, Stafford Horne wrote:
> Split out the common memory, CPU and PIC definitions of the simple SMP
> system to a DTSI file which we will later use for our De0 Nano multicore
> board device tree.  We also take this opportunity to swich underscores
> to dashes as that seems to be the more common convention for DTS files.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/boot/dts/simple-smp.dts         | 25 +++++++++++++++++++
>  .../dts/{simple_smp.dts => simple-smp.dtsi}   | 12 ++++-----
>  arch/openrisc/configs/simple_smp_defconfig    |  2 +-
>  3 files changed, 32 insertions(+), 7 deletions(-)
>  create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
>  rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (89%)
> 
> diff --git a/arch/openrisc/boot/dts/simple-smp.dts b/arch/openrisc/boot/dts/simple-smp.dts
> new file mode 100644
> index 000000000000..174c2613c419
> --- /dev/null
> +++ b/arch/openrisc/boot/dts/simple-smp.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "simple_smp.dtsi"

This should be simple-smp.dtsi.

> +
> +/ {
> +	model = "Simple SMP Board";
> +};
> +
> +&cpu0 {
> +	clock-frequency = <20000000>;
> +};
> +
> +&cpu1 {
> +	clock-frequency = <20000000>;
> +};
> +
> +&serial0 {
> +	clock-frequency = <20000000>;
> +};
> +
> +&enet0 {
> +	status = "okay";
> +};
> diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple-smp.dtsi
> similarity index 89%
> rename from arch/openrisc/boot/dts/simple_smp.dts
> rename to arch/openrisc/boot/dts/simple-smp.dtsi
> index 71af0e117bfe..92770bb6fcf7 100644
> --- a/arch/openrisc/boot/dts/simple_smp.dts
> +++ b/arch/openrisc/boot/dts/simple-smp.dtsi
> @@ -1,4 +1,3 @@
> -/dts-v1/;
>  / {
>  	compatible = "opencores,or1ksim";
>  	#address-cells = <1>;
> @@ -22,15 +21,15 @@ memory@0 {
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			compatible = "opencores,or1200-rtlsvn481";
>  			reg = <0>;
> -			clock-frequency = <20000000>;
> +			clock-frequency = <0>;
>  		};
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			compatible = "opencores,or1200-rtlsvn481";
>  			reg = <1>;
> -			clock-frequency = <20000000>;
> +			clock-frequency = <0>;
>  		};
>  	};
>  
> @@ -57,7 +56,7 @@ serial0: serial@90000000 {
>  		compatible = "opencores,uart16550-rtlsvn105", "ns16550a";
>  		reg = <0x90000000 0x100>;
>  		interrupts = <2>;
> -		clock-frequency = <20000000>;
> +		clock-frequency = <0>;
>  	};
>  
>  	enet0: ethoc@92000000 {
> @@ -65,5 +64,6 @@ enet0: ethoc@92000000 {
>  		reg = <0x92000000 0x800>;
>  		interrupts = <4>;
>  		big-endian;
> +		status = "disabled";
>  	};
>  };
> diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> index 6008e824d31c..db77c795225e 100644
> --- a/arch/openrisc/configs/simple_smp_defconfig
> +++ b/arch/openrisc/configs/simple_smp_defconfig
> @@ -20,7 +20,7 @@ CONFIG_SLUB=y
>  CONFIG_SLUB_TINY=y
>  CONFIG_MODULES=y
>  # CONFIG_BLOCK is not set
> -CONFIG_BUILTIN_DTB_NAME="simple_smp"
> +CONFIG_BUILTIN_DTB_NAME="simple-smp"
>  CONFIG_SMP=y
>  CONFIG_HZ_100=y
>  CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
> -- 
> 2.51.0
> 
