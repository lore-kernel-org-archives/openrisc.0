Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352131AF22
	for <linux-openrisc@vger.kernel.org>; Mon, 15 Dec 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822790; cv=none; b=J7+9zSsUWB6VB0cmhge6YtWiz15508uKo5iF8r86o8tVD8PYfPOa2/me1Dos+HtAnIAA6j09xJehPoiDmulZ/FtxrxXfbORaRf9WlIw3copCJ8qZYC/e62Xn1xu07nY//QUFdc3hm+gygfkot5MRdw6HIRVKAxsy55iGCk6//g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822790; c=relaxed/simple;
	bh=+eSIzyNsld8324MccJzy0k1uEsMhJSv9KmPlRqapoLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKN451Rxl7pPSzEpVENz1kAeI0aVU1Zxa5Rgb9HkLCV8xewnaMlfS+L202ne7QbFQ8+iuul7oBvfcPJgaTVVbze29tg6KOvk5RBD9AmvOltwjwopmGY72REKwdWZX5Pz4h/EPsO0V+PlDcW/KWQAMAHxP0jeNZgWK3rXE0BpM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7w6c1/S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7w6c1/S"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a637712so25664315e9.1
        for <linux-openrisc@vger.kernel.org>; Mon, 15 Dec 2025 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765822787; x=1766427587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XM8muLe+cUJikc6NHCimAzQfLZpxefXeXRMQFGpchNU=;
        b=S7w6c1/SU0igq0Bx5ZsIlysEN9LhqllSGpR+dwM2cYGkoIk2ni29edIWvFHKE9f+m1
         ruBY8dMeONYfnC9hx1fyz4El3FCJzFneFXyAKPY66LwnqPVxjmSiJfKwVc9hhqH/Yf+J
         /OSDqZtqQ2oR2mtRuKQrl0EcujRPcVd/sEa8dEh4jkThN4TM4rk2tfPPFof7NjT2bhCr
         tpgVPZLeaPDYqe2lscNS7Jbk16M2wBvuSlPpaOMv98Vk+gSbybTHgme1ttUGOzcH3v7D
         xAWGL/qFki186SvxocnoPzo36GaAO9q0DguUZqGAiN4whWSLvUneB36H/MfTwPolQuBT
         tK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765822787; x=1766427587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM8muLe+cUJikc6NHCimAzQfLZpxefXeXRMQFGpchNU=;
        b=J1WuIsg2Art9ejpI3vjk0Ttrj75QBGH2A540j/oMKETh25OC8Eg8fUl8YFNv4SSqDA
         zPlLFlPF8a+J8f5rXst8UIwwvYcvSaKX4UmUr0STtNJ/Ql1vSHfO5hBYpgPWpm3tzjvq
         1gVaWl4D8Zx2sRKSyH3xZJBJmHVgeOiRv1mUw9d7Xk/3Di39R+wQU0vzGLwAGKvosXQb
         g1TqFZDhii23uZLQkA7cm1YhBNFKGwxBKBWOQHLNe45zZ9VNs9gtIvMH4x6FXxrknKvU
         alPMIIvhR/ZdY5oGjwagnZOtMgxJnEk6UOqlsOoWNWGAvV51wxjF6ZVOKPLYprrPNmub
         EZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCUzBT1FswsdRxgEwtIl1aIkx++67k6uDFnT3YRMgHiFDz8loeV8BKYqF1fjT0O//IwQGh1cabHRwgk6R7OoDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnNR8ACsAJYBpoCaiatp9oLHSwywYEw1X9NBHPxSecUoWghPu
	BOX4pMGDrPNDQdW2LevcImmZFegRswG0Lvl9p5TAYvVLT4lFmDQ3Eflc
X-Gm-Gg: AY/fxX5pAiTlRjk/40cw9/Q/nkfmjjTkyYAV1riqFnOS01kdNYTxuIvbTt6ts5Pne25
	yBYsux0x5yfbEwtCqnaIHnkTwCTVufZ+Z3WdhVdaGWA13BF8m7Dfi8ka9dniRZItVG0ZAtg6Afr
	WZFSFe8K5yfNHklruZMHw31U0mP0sTYmdp8E0cHXJqPoVwxJ6X8bGhTsH+1IJiTTPnlGOjSVyy4
	oyJ59JADDbeydw+mFfnH8GdBwHn/GtntCLRjDYnOOEO0ddJyZKgcVCHXg4iTQd5OiPqmEYO0KZ4
	prcZCTJLKYtiO4oVn7vte7arV5aWeh77J+dbUsHLEMlj7DBs95/IXGmoChaLzeL+Ub9P8XX74/W
	/L+B4ZbW1AOHeinu2DssrGuNZUCzJH8/n288rSikfKnVUmo++jLYtdofd3tXsVYrHFy7IarTWlM
	rYWkiqRfMhV5MNO1rlLvmunxoqW6AHPlz/Hk+abxjGRu65EAfdpjXqXQJFewdz0CtsD6p2MA5aP
	6w=
X-Google-Smtp-Source: AGHT+IHlEdUry2/A5eLerel/tgOjxOM1UDY/0/bP0yUxROsj/AbKDjvP1/Icp5UEQBDq+MBNOn2Pzg==
X-Received: by 2002:a05:600d:6405:20b0:47a:935f:618e with SMTP id 5b1f17b1804b1-47a935f64d7mr91820175e9.15.1765822786707;
        Mon, 15 Dec 2025 10:19:46 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd5f89867sm504235e9.0.2025.12.15.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:19:45 -0800 (PST)
Date: Mon, 15 Dec 2025 18:19:44 +0000
From: Stafford Horne <shorne@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] openrisc: dts: Split simple smp dts to dts and dtsi
Message-ID: <aUBRQDJdFi7cppI8@antec>
References: <20251214180158.3955285-1-shorne@gmail.com>
 <20251214180158.3955285-5-shorne@gmail.com>
 <20251215-graffiti-baritone-4eb0a9f58ab6@spud>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-graffiti-baritone-4eb0a9f58ab6@spud>

On Mon, Dec 15, 2025 at 04:58:41PM +0000, Conor Dooley wrote:
> On Sun, Dec 14, 2025 at 06:01:44PM +0000, Stafford Horne wrote:
> > Split out the common memory, CPU and PIC definitions of the simple SMP
> > system to a DTSI file which we will later use for our De0 Nano multicore
> > board device tree.  We also take this opportunity to swich underscores
> > to dashes as that seems to be the more common convention for DTS files.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  arch/openrisc/boot/dts/simple-smp.dts         | 25 +++++++++++++++++++
> >  .../dts/{simple_smp.dts => simple-smp.dtsi}   | 12 ++++-----
> >  arch/openrisc/configs/simple_smp_defconfig    |  2 +-
> >  3 files changed, 32 insertions(+), 7 deletions(-)
> >  create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
> >  rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (89%)
> > 
> > diff --git a/arch/openrisc/boot/dts/simple-smp.dts b/arch/openrisc/boot/dts/simple-smp.dts
> > new file mode 100644
> > index 000000000000..174c2613c419
> > --- /dev/null
> > +++ b/arch/openrisc/boot/dts/simple-smp.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/dts-v1/;
> > +
> > +#include "simple_smp.dtsi"
> > +
> > +/ {
> > +	model = "Simple SMP Board";
> > +};
> > +
> > +&cpu0 {
> > +	clock-frequency = <20000000>;
> > +};
> > +
> > +&cpu1 {
> > +	clock-frequency = <20000000>;
> > +};
> > +
> > +&serial0 {
> > +	clock-frequency = <20000000>;
> > +};
> > +
> > +&enet0 {
> > +	status = "okay";
> > +};
> > diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple-smp.dtsi
> > similarity index 89%
> > rename from arch/openrisc/boot/dts/simple_smp.dts
> > rename to arch/openrisc/boot/dts/simple-smp.dtsi
> > index 71af0e117bfe..92770bb6fcf7 100644
> > --- a/arch/openrisc/boot/dts/simple_smp.dts
> > +++ b/arch/openrisc/boot/dts/simple-smp.dtsi
> > @@ -1,4 +1,3 @@
> > -/dts-v1/;
> >  / {
> >  	compatible = "opencores,or1ksim";
> >  	#address-cells = <1>;
> > @@ -22,15 +21,15 @@ memory@0 {
> >  	cpus {
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > -		cpu@0 {
> > +		cpu0: cpu@0 {
> >  			compatible = "opencores,or1200-rtlsvn481";
> >  			reg = <0>;
> > -			clock-frequency = <20000000>;
> > +			clock-frequency = <0>;
> 
> Delete these lines, don't set them to zero please.

OK, I wasn't sure what to put here so put 0, Just removing is much better.

-Stafford

> >  		};
> > -		cpu@1 {
> > +		cpu1: cpu@1 {
> >  			compatible = "opencores,or1200-rtlsvn481";
> >  			reg = <1>;
> > -			clock-frequency = <20000000>;
> > +			clock-frequency = <0>;
> >  		};
> >  	};
> >  
> > @@ -57,7 +56,7 @@ serial0: serial@90000000 {
> >  		compatible = "opencores,uart16550-rtlsvn105", "ns16550a";
> >  		reg = <0x90000000 0x100>;
> >  		interrupts = <2>;
> > -		clock-frequency = <20000000>;
> > +		clock-frequency = <0>;
> >  	};
> >  
> >  	enet0: ethoc@92000000 {
> > @@ -65,5 +64,6 @@ enet0: ethoc@92000000 {
> >  		reg = <0x92000000 0x800>;
> >  		interrupts = <4>;
> >  		big-endian;
> > +		status = "disabled";
> >  	};
> >  };
> > diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> > index 6008e824d31c..db77c795225e 100644
> > --- a/arch/openrisc/configs/simple_smp_defconfig
> > +++ b/arch/openrisc/configs/simple_smp_defconfig
> > @@ -20,7 +20,7 @@ CONFIG_SLUB=y
> >  CONFIG_SLUB_TINY=y
> >  CONFIG_MODULES=y
> >  # CONFIG_BLOCK is not set
> > -CONFIG_BUILTIN_DTB_NAME="simple_smp"
> > +CONFIG_BUILTIN_DTB_NAME="simple-smp"
> >  CONFIG_SMP=y
> >  CONFIG_HZ_100=y
> >  CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
> > -- 
> > 2.51.0
> > 


