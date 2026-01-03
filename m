Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A9E199920
	for <linux-openrisc@vger.kernel.org>; Sat,  3 Jan 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767421027; cv=none; b=PAllFo9E+AY7u/zZfZ7yUu5IiM7J8+tE9rETmqHUrSq76mPrFaS51UbFiGNkGuyBsxgaU7JWAaP34V2l0P7maEagupvZ1oBbJILVe1+5/B/4SHKmIfmY82xoHcr9f8jt0CY6FV4j3VplNfW71Vgc02TDkeAJKVSN1IfSkVSwaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767421027; c=relaxed/simple;
	bh=OvhHsmnhwBytDwLUIZZt3NNO22amAFYoNYaJEB8XD9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1wvgP/WyYWrkqX+70dMhQ1qNdJ+GxP4tyJe3vA0/qeKQyapbsIHch1lHR/VbHFAWPVESUqmKxRCJ/gcPTOQTJmqFoz5isXTEP1MLiZcS7qd/hLFM9hUOByHyZmIpBfrszrjnM5TVzFdbVGH6Jzvq4zFALr1vYAnC7b172bCjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLMzOR/R; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLMzOR/R"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so5122880f8f.3
        for <linux-openrisc@vger.kernel.org>; Fri, 02 Jan 2026 22:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767421024; x=1768025824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fBTw2m0sw3DdZqYCahoE5TIOLBwDoJuhOGkXgvJXBI=;
        b=CLMzOR/RwI2YMXXLnWzTNCq3EuQGAR22JxggEVtWWzr1wQMLzQjOkIR85wRFSmnnjQ
         knWZnqb1RMq9+0vFeaW9oWDA5gfvfUnV9+NuTOWyoiNrKZ2GeFR3a9OPInEdql6CETdx
         GKPj2dt34tWAes36tNyETN9n+qbuVoBcTTa8GYY328my4WZkekcbYIwkMf0XqBBSD8+j
         eY83w1CTYj8KrnMBheItjCUuT0Zih+E31ngcHAid4InNDU5yGS3a5Fegn7EXzKHitXMA
         Jpzap6jRsQokSlQ9lhRq/UYDYOsy8gf9nNrF0Y1zJadD0o4E9t6FpLH4U9twiUpq7L30
         jt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767421024; x=1768025824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fBTw2m0sw3DdZqYCahoE5TIOLBwDoJuhOGkXgvJXBI=;
        b=mGciWb4YjIpds8YkGYbtp0oeTjnx3dsJ6Suxd94kIiDmA3ucgW/Byb8/7kv1Q1Uoly
         enAMJimEQ9MyVVprjIphMlg1ZM1FzGPoTHmKQa0eLdKi5JSxpNvG4iq2f8w04jslxkIr
         rtWm2ZSpYM9MM0ak2J9/Z+8gYRxRz6njEiWvoyqnkU/ScjTYBm2LMCsvYo4k/wGZCEVA
         kIpvoIq5Y7Hjjq/GQydUR6pl9gKdwvubfAL55fXQJlr9Mi4+0aWzWNaQkoaOFlsxMEBo
         DXuBNSQrPjo89ZedJaCIVHW+Fkjg/T7w3LB6dVfSBWTNLebtTLBsXsSoE9itsNsmXb7V
         ZZug==
X-Forwarded-Encrypted: i=1; AJvYcCU8AztdyQfBld/djxmV/a0uIz4H79qIQmo/PXoisG5ROwQE+barDttPNhEAi1K0oUyWguQSV/dkLLPdIYi7QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/mFtjlAZhj8Ytn9HLrrvPXKGtzxt5TApuJeUOHJDAnLe9pWq
	G/eYZlF/DqLNncWxU0uf1MAWMRVkuzPEKU1GNMsH3Zaw+xel8CX219rT
X-Gm-Gg: AY/fxX7Xr2XGgqIn3evzo5IKWIxRuX5yVMf/Nn1+KRw/8mfPlTQ6jiaCsqwsC5hvUaz
	4MpvPksu4eELhqhiuPaeAdlhIzw7zpYotmHv0CmNcD/TN1n+vQobWFIIasCNUUutDkzSsTUPHMo
	pa4yq4MAbJMcnMurqqMUaK0fYV1E87be8YFhgY/t8dDdOLGTi4jBC5t8h9Jiqe3l88C8U3WUv1c
	uqQSd1ZazXDxOX+aCd0a1763mwEm3YdUs/UedpPN+T+wvmL3IDy6cySHvIiv979q3j0Nz0QFJoj
	q7kvj1Xqgi0TLWEx5M9YCbiBXYSSzMvGyTLlWgoE0UfJjz8BxrIvc5cF0i7eKVfn6KJkYaZ+lSm
	79HSJWnyEPGdBAg5XI5I3m7Vtvi75RuDa0TF9Y7/x7nLVsSXf/tZjmQ/Ae8JsANmnFyGueCPlp/
	m00SLnO8DdxyNM+hYa3d4tf7EkHq4iX/wm56rrW63mY78QR/arMRxnWYcCD3WCuSob
X-Google-Smtp-Source: AGHT+IHdlE+Cj3VwwM7OZ4YHjWykCfF7XHJggX+PliZI3MM3Nwc7QElP+yBNZ3QQxm4vymnI/vBKVA==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-4324e4cbcc1mr61300652f8f.23.1767421023534;
        Fri, 02 Jan 2026 22:17:03 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm88770406f8f.38.2026.01.02.22.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 22:17:00 -0800 (PST)
Date: Sat, 3 Jan 2026 06:16:59 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] openrisc: dts: Add de0 nano config and devicetree
Message-ID: <aVi0W6syzK6buL_v@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <20251217080843.70621-3-shorne@gmail.com>
 <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com>

On Thu, Dec 18, 2025 at 07:36:08PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Wed, 17 Dec 2025 at 09:23, Stafford Horne <shorne@gmail.com> wrote:
> > The de0 nano from Terasic is an FPGA board that we use in the OpenRISC
> > community to test OpenRISC configurations.  Add a base configuration for
> > the board that runs an OpenRISC CPU at 50Mhz with 32MB ram, UART for
> > console and some GPIOs for LEDs and switches.
> >
> > There is an older version of this floating around that defines all of
> > the hardware on the board including SPI's, flash devices, sram, ADCs
> > etc.  Eventually it would be good to get the full version upstream
> > but for now I think a minimal board is good to start with.
> >
> > Link: https://openrisc.io/tutorials/de0_nano/
> > Link: https://github.com/olofk/de0_nano
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/arch/openrisc/boot/dts/de0-nano-common.dtsi
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +       memory@0 {
> > +               device_type = "memory";
> > +               reg = <0x00000000 0x02000000>;
> > +       };
> > +
> > +       leds: leds {
> 
> Move this up (or down), before (or after) all nodes with unit addresses?

OK.

> > +               compatible = "gpio-leds";
> > +               status = "okay";
> 
> Missing blank line.

OK, also I can remove the "okay" line as well.

> > +               led-heartbeat {
> > +                       gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
> > +                       color = <LED_COLOR_ID_GREEN>;
> > +                       function = LED_FUNCTION_HEARTBEAT;
> > +                       linux,default-trigger = "heartbeat";
> > +                       label = "heartbeat";
> > +               };
> > +       };
> > +
> > +       gpio0: gpio@91000000 {
> > +               compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> > +               reg = <0x91000000 0x1>, <0x91000001 0x1>;
> > +               reg-names = "dat", "dirout";
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +               status = "okay";
> 
> "okay" is the default, so you could drop this line.

OK.

> > +       };
> > +
> > +       gpio1: gpio@92000000 {
> > +               compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> > +               reg = <0x92000000 0x1>, <0x92000001 0x1>;
> > +               reg-names = "dat", "dirout";
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +               status = "disabled";
> > +       };
> > +};
> 
> > --- /dev/null
> > +++ b/arch/openrisc/boot/dts/de0-nano.dts
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/dts-v1/;
> > +
> > +#include "de0-nano-common.dtsi"
> > +
> > +/ {
> > +       model = "Terasic DE0 Nano";
> > +       compatible = "opencores,or1ksim";
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +       interrupt-parent = <&pic>;
> > +
> > +       aliases {
> > +               uart0 = &serial0;
> > +       };
> > +
> > +       chosen {
> > +               bootargs = "earlycon";
> 
> Do you need this?

What do you mean here? I want to keep "earlycon", and it is not supplied in
de0-nano-common.dtsi.

> > +               stdout-path = "uart0:115200";
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> 
> Missing blank line.

OK.

> > +               cpu@0 {
> > +                       compatible = "opencores,or1200-rtlsvn481";
> > +                       reg = <0>;
> > +                       clock-frequency = <50000000>;
> > +               };
> > +       };
> > +
> > +       /*
> > +        * OR1K PIC is built into CPU and accessed via special purpose
> > +        * registers.  It is not addressable and, hence, has no 'reg'
> > +        * property.
> > +        */
> > +       pic: pic {
> > +               compatible = "opencores,or1k-pic";
> > +               #interrupt-cells = <1>;
> > +               interrupt-controller;
> > +       };
> > +
> > +       serial0: serial@90000000 {
> > +               compatible = "opencores,uart16550-rtlsvn105", "ns16550a";
> > +               reg = <0x90000000 0x100>;
> > +               interrupts = <2>;
> > +               clock-frequency = <50000000>;
> > +       };
> > +};

-Stafford
