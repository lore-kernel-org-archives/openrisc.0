Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52D2C08AC
	for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083077; cv=none; b=EwWFj272RBVo7bAThmY6j3pglxBWeoGN4enFwMNMj7q2l8IYaESmNpyEKrhzvpvoD5UamA3i9iyQLIrMXn8jw1w/2bTNyTtbn4agsiS1XNk/uwn8/W8YVr6HVycP2+zHwiVCGxX+1NH0SQoFIlBpSrowi4u4bd8i7mqnHeDjRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083077; c=relaxed/simple;
	bh=0OhEslZjp+aTkNYgZvD96zEORwlOpU29eBj68fD9rdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nV8pRZGcqjF4yZec/VPSd3LhYgJ0baHuNCXRICkzcLOM1D6nbUejsSGQzGoIXaZLNGHEXQ1NGK+it4sOL5fSXxnDDfTQxZh9z+TOlteyl5pq7FltldZwF6NZrlBRBUzEkJ9kijFq0vDwGJcn2QH+TLo8E+Ql4cGmDxS94Nzx0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so573023e0c.1
        for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 10:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766083075; x=1766687875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzQKpj+K5xZCnwXpy+92eyq9yIgTThbDeKk8EFe1x70=;
        b=gxYzV6aPuEiHSrawYd4GJntf4/bKtFPlL9yRqCeLmJ5VOVmhph3hnyxev7A4cZc6xW
         6qsT9wEGrRhZn/HYEG0b5YJVS1uezzi4CS6TD5pUgZ8HekHw3UtytqlzC4pHI+95X9og
         uiI1FUtPyLHCBAt3+3rlpqDyF7KpWbVR6tEmO+FqkXqON5GC0mq4l6g7u948X8oEIw3Q
         pFY+xyqsNjRQwvBOImJqLw3sepGLxs4rAFT+KtorDncdw1TmNss3uPqVIhBI2aHO4tdv
         IZxbR2EpnCUlTQ4Mvwe8vV5Vgqqik5ORL2lSUFK0MyVFZKa4MLek6fIZvMs4PyD/sTVr
         nlrg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwzZ5UrGSERRnpnx/ZysUq6OLwR7Ps+u95p1YhTGavR6Nsf320TKhjH23EreX6c8dA91FJq+EqY+nr5DAZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyflLL/DtYoDTPAx9g8+ZEwykBq4u6xIKcWx9rkMZkrruOPwO2v
	9z53gB+x2GL5rG4PO7+F59RJhIzrGGe6WqVM0Z1MPtR51oVpz3Eqs08VPhYIa97X
X-Gm-Gg: AY/fxX5W07ANsJIzLaBbykUk7oKkd/rOQjkk93VaTUrjxDVOwMichybNokMYVfvChLY
	sCKNy1aVz2mChyDkkpWYGH2KnobZK+uRIwcEE2tPoR5FD+dCN/y+aamobZbKOiWivMlbT/uURmv
	RWEff+3sqzRGbdZ5hIOjGpRjEaTZzniLCXVgZHeVAs4QgyAzFgKwCAB1n6kbEXlQTZF+yqi0sVv
	go7ysQ7RsuCB7zrkgZYEngCpDol0QDBBR4yxvku3t55uzoIhH03sxhciaHMj2TQ5b3kM3MlFMoc
	NosMR5apKkUe39AMI4OlFNY4FFLqw1jjPF2MUf/KDdULjRQoto2UKPCt+b+135msOvFukag//p0
	82LfeQl32lPJkfzrRDczQAfuN64JIQE+/RVFzAgH4lJGA7SHm/rHgaKoa0WmK/lGYpxWMMmWpLp
	tdk0mshDKtZq+2uwP889VggSwZA3VuyhKc0ftmrAiap700KNJ/
X-Google-Smtp-Source: AGHT+IFbizpev+ZVMuHdSksVbaM4EolKF6vgxWZusi/EFZ3BXmu4kJEY6wH3X5GxclCc3GBb2avwug==
X-Received: by 2002:a05:6122:400f:b0:54a:a3b1:db63 with SMTP id 71dfb90a1353d-5615b851f7dmr251494e0c.6.1766083075181;
        Thu, 18 Dec 2025 10:37:55 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d14efe7sm1888e0c.15.2025.12.18.10.37.54
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 10:37:54 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dbde7f4341so1470520137.1
        for <linux-openrisc@vger.kernel.org>; Thu, 18 Dec 2025 10:37:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrwjO5iWinH80Q/jmGaj8b6XOmEJFW+jz3nCeGY8TJuZZ+YZPs5Fb5OPIVUjROISpjpxnDGv1J5uf5LNtJww==@vger.kernel.org
X-Received: by 2002:a05:6102:510a:b0:5e0:d009:e4d7 with SMTP id
 ada2fe7eead31-5eb0237d823mr1577578137.1.1766083073953; Thu, 18 Dec 2025
 10:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-5-shorne@gmail.com>
In-Reply-To: <20251217080843.70621-5-shorne@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Dec 2025 19:37:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXG2HQ8e+Hx1CUBus_VYKmx4fEeDRH+sDXmaQQANTraBg@mail.gmail.com>
X-Gm-Features: AQt7F2rcVD25xb8nrGQqVpj5b8hg3KTWDJWwSSU46X3JARvL_KWM_hi9moWh8eY
Message-ID: <CAMuHMdXG2HQ8e+Hx1CUBus_VYKmx4fEeDRH+sDXmaQQANTraBg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] openrisc: dts: Split simple smp dts to dts and dtsi
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Masahiro Yamada <masahiroy@kernel.org>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

On Wed, 17 Dec 2025 at 09:23, Stafford Horne <shorne@gmail.com> wrote:
> Split out the common memory, CPU and PIC definitions of the simple SMP
> system to a DTSI file which we will later use for our De0 Nano multicore
> board device tree.  We also take this opportunity to swich underscores
> to dashes as that seems to be the more common convention for DTS files.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/openrisc/boot/dts/simple-smp.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include "simple-smp.dtsi"
> +
> +/ {
> +       model = "Simple SMP Board";
> +};
> +
> +&cpu0 {
> +       clock-frequency = <20000000>;
> +};
> +
> +&cpu1 {
> +       clock-frequency = <20000000>;
> +};
> +
> +&serial0 {
> +       clock-frequency = <20000000>;
> +};
> +
> +&enet0 {

Alphabetical sort order?

> +       status = "okay";
> +};
> diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple-smp.dtsi
> similarity index 90%
> rename from arch/openrisc/boot/dts/simple_smp.dts
> rename to arch/openrisc/boot/dts/simple-smp.dtsi
> index 71af0e117bfe..2013fd3e7a18 100644
> --- a/arch/openrisc/boot/dts/simple_smp.dts
> +++ b/arch/openrisc/boot/dts/simple-smp.dtsi
> @@ -1,4 +1,3 @@
> -/dts-v1/;
>  / {
>         compatible = "opencores,or1ksim";
>         #address-cells = <1>;
> @@ -22,15 +21,13 @@ memory@0 {
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;

Missing blank line.

> -               cpu@0 {
> +               cpu0: cpu@0 {
>                         compatible = "opencores,or1200-rtlsvn481";
>                         reg = <0>;
> -                       clock-frequency = <20000000>;
>                 };

Likewise.

> -               cpu@1 {
> +               cpu1: cpu@1 {
>                         compatible = "opencores,or1200-rtlsvn481";
>                         reg = <1>;
> -                       clock-frequency = <20000000>;
>                 };
>         };
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
