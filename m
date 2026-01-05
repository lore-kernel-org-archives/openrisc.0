Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32054313558
	for <linux-openrisc@vger.kernel.org>; Mon,  5 Jan 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610988; cv=none; b=roTQediPMtdYc8ut5PzcMg9Etzw7pEw0SR5yUyaMCgNECfOqLa32XfjkTENl4733O2+xRxcfGcvNFKJUkz843ZDaCpt0s712/6uwWi60qS+mobKYELFKwFs1x4d/KpG4ZiZLPF7PLY+dLMHApEa7FZpGNk7vMU83U78i9OHHHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610988; c=relaxed/simple;
	bh=hAms7IKyqam6rNOoqdYp7LLOeRfAUy6pwyvcxDno2zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5ivm5CRPgT0Q0BRLTNYs3prJkJZs1H4OiS1bD/19tLiEP6wqIOYLjXunEYFIRK2V+UBhkeJ1JqcR1bdQ2IIqXIyDz3ELabMKIBJzOT+tHvYCENHioJ6rKqlGCrdReA9KbOQh7bZUlDVvDW/+BRaKd1A2Rlfr+ClD8EGyGjgODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b155c9ab2so3160627e0c.1
        for <linux-openrisc@vger.kernel.org>; Mon, 05 Jan 2026 03:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767610984; x=1768215784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HVxxcSl5ZUgm/OiTpMLt/jnUpdmkmBIJiQ/3TY5I8k=;
        b=H5eI2ecwadOzdJDkuz397JaXhu5U+EcmAq9nBKjUQdjIlZXD/14JRKPkLNXr9LOi6h
         TrOjmRzeEmU/bV/9tdSi15d2vynGSaGMeZhSHtLglVM0n20+1nDTKfZPPXy7NkhEYB6j
         +f35U++fj1Q98iq3x43Nj+QLWIvSa+ChT/4IzU4rZms6ruZqk7b3XEh3u/4Wd8c5CqPz
         1hkgkf4FyS7WNCHAg54Flp6gOPiJ9ITPojRCAT2Xsf3FZe5n2qXePzDxIwfYjYSV1gvf
         pvvTC8rYUoPCoxfu8cv6MnfB8xvXboe+nVRDOmawC5tSZ7GC7TgFLiRuMbquSqYDYDjX
         uyIg==
X-Forwarded-Encrypted: i=1; AJvYcCUlQ408sCw3VtwFFxBNSIQ1Leu3dyXOBPeoP0YZ8PqxLYvvzQzKVRChDOYNZhLX/wfR8nagg0rISDUfV9XXhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhwmoFVqDAo2PcDrVlBe7A+Yd0Ijzpm923WdOiJ9lagVgOz7p
	29zSGqLno6MTkjoiA1Weu4o1/xEV+Kjv77HNouyb5b4qSCWi2cC9IqKHA7xpeQzW
X-Gm-Gg: AY/fxX518kuyvJQoWH9U55UZmF2w46uK4Nmkg5PlNreKVnt/r6/0f6koYSVnynBQ0VI
	WF5xRTBShHggTFKcL3CB4E9eyWTCUw3g9ttDwUbwKMszpoK+n9O/lgD1hB8KFSG0b35Bn34my7V
	7NSXYCbOLtWM90loC8XJaWgwm8cihUxYG7P+rPzehq0Dhn2H6ZeOUlrx8e8blHQ9k6e2KZermif
	2REcdX8zsKTveZPQtGBibHPpZwerd5UBpvvRD7+opgy7nZhMZDehRi5oZ9brMgI/hKLillbC5bb
	hHqGdVe/+2sn9imMxTtdIvniXB7+EhXkzQBHZRGg19vmCkyiVfzRn2GUbLABngIgj1tBcUg2wF9
	609HCjQWK568D+l3kWlk0On7Ic+1/u2zbhcPnc7VTzM+x6aofCEwoL2E3bRgRtB0kE7SuoNTV21
	3hyqafJ0k6qS4CGdjdVAZms1C0UAJ6ewEjmXldXzhmwrncjs5t
X-Google-Smtp-Source: AGHT+IE1PbUtik0FFXX6YHedHhegpcVazuaIhBygGNW1M3vWd6/2oBzvhPZYkn7+HlrceKgNqmudAA==
X-Received: by 2002:a05:6122:c9d:b0:55b:305b:4e36 with SMTP id 71dfb90a1353d-5615bebce42mr13280076e0c.17.1767610983921;
        Mon, 05 Jan 2026 03:03:03 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d165f2csm14933390e0c.20.2026.01.05.03.03.03
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 03:03:03 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dd6fbe50c0so5277334137.2
        for <linux-openrisc@vger.kernel.org>; Mon, 05 Jan 2026 03:03:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhhJi1nWKLN3JlKtR2Au0uL0SNPuOJGS9QIn8J49QFEQGGaBNG0ifvA5xoGMUvpV2czMK1MFdcgr/hnhFCqw==@vger.kernel.org
X-Received: by 2002:a05:6102:c90:b0:5df:c15b:4feb with SMTP id
 ada2fe7eead31-5eb1a7d3c4fmr13074222137.26.1767610982990; Mon, 05 Jan 2026
 03:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-3-shorne@gmail.com>
 <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com> <aVi0W6syzK6buL_v@antec>
In-Reply-To: <aVi0W6syzK6buL_v@antec>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Jan 2026 12:02:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUP3z4Os=3XC6Nuzx8QAap=LTcuJrGZsy71GO=NFTOjZg@mail.gmail.com>
X-Gm-Features: AQt7F2psihV0yZwb9Ig62dHZ18S-t-DpkRavD32vIkfcb25fPGFgWjTlZzYQH6k
Message-ID: <CAMuHMdUP3z4Os=3XC6Nuzx8QAap=LTcuJrGZsy71GO=NFTOjZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] openrisc: dts: Add de0 nano config and devicetree
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

On Sat, 3 Jan 2026 at 07:17, Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Dec 18, 2025 at 07:36:08PM +0100, Geert Uytterhoeven wrote:
> > On Wed, 17 Dec 2025 at 09:23, Stafford Horne <shorne@gmail.com> wrote:
> > > The de0 nano from Terasic is an FPGA board that we use in the OpenRISC
> > > community to test OpenRISC configurations.  Add a base configuration for
> > > the board that runs an OpenRISC CPU at 50Mhz with 32MB ram, UART for
> > > console and some GPIOs for LEDs and switches.
> > >
> > > There is an older version of this floating around that defines all of
> > > the hardware on the board including SPI's, flash devices, sram, ADCs
> > > etc.  Eventually it would be good to get the full version upstream
> > > but for now I think a minimal board is good to start with.
> > >
> > > Link: https://openrisc.io/tutorials/de0_nano/
> > > Link: https://github.com/olofk/de0_nano
> > >
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>

> > > --- /dev/null
> > > +++ b/arch/openrisc/boot/dts/de0-nano.dts
> > > @@ -0,0 +1,54 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "de0-nano-common.dtsi"
> > > +
> > > +/ {
> > > +       model = "Terasic DE0 Nano";
> > > +       compatible = "opencores,or1ksim";
> > > +       #address-cells = <1>;
> > > +       #size-cells = <1>;
> > > +       interrupt-parent = <&pic>;
> > > +
> > > +       aliases {
> > > +               uart0 = &serial0;
> > > +       };
> > > +
> > > +       chosen {
> > > +               bootargs = "earlycon";
> >
> > Do you need this?
>
> What do you mean here? I want to keep "earlycon", and it is not supplied in
> de0-nano-common.dtsi.

Why do you want to keep it? "earlycon" is a typical debug option,
and should not be needed during normal use.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
