Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95C3815FB
	for <linux-openrisc@vger.kernel.org>; Thu,  8 Jan 2026 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860446; cv=none; b=LyQ2WxX9JV7XZYOJO5c9mz/goRHTLAb6+U3MiBHEkcie+GMep+PE3Yb7ab6JHtiSZQdcQQwctslA7GG0Y4rxFksX2xsAYi5Uqvu9jwNMIBxgKvDA2DmNfb0JkNUFU5sHD9qv9tUflGHMu/d+LvxKadWrNhbAo0AB63EPMFQI4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860446; c=relaxed/simple;
	bh=0EXX04ybii9G7qyj95CN4kbgQyyGv8bobMIMiT6u3Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP9LRj2ijKoOcumV5iVA558bymv+4lCXIGFdi4em3hZsyJGX3ChDpIPZ2FNDzCj7fvJ4qAoKs0A4N3RYjJFNUSuJqdy7ByYuGTtMbFJ9ReaUBhEaF4TdT1dpl45d4s6Qwg8pZd6o08rjcAbvArzdwKYzDP0GrNTCVANTD4f7NWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNPU37oQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNPU37oQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so21234015e9.3
        for <linux-openrisc@vger.kernel.org>; Thu, 08 Jan 2026 00:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767860438; x=1768465238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DR0GCYK6h8L6OB0x8sKyoqDgYiBaxX9t2TeYHE9k9UA=;
        b=PNPU37oQMRdHjJXggOZvfC7MkzZmrUXX7juN3oO3A6ofxPPEYCrMzTub2ANUl2k2zG
         C/8NcRv9lomHS/PuCbg0wYt7Em6zQ05gywI9ULxAYg0fVxiETXTLh2RvhwCjCb8z56gx
         5uCxKpOy0tqwnh5MKe9l1CRA6izisfkkwIiVEtTEXNkUGPFeUMHnn1HZMN+sKLYha0a7
         qYWd3o1OWTL2RQJWE6KpbNfanHP8cITKG42LS58C3MBtHoHLIDgm0AFHwjErIq+LbVzQ
         DPAhU2O/QO/EviageXfus1kk27hbgJIPOIIguNp7P5vnBgTtWpnysPNRy+iDcqp2JmAd
         c9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767860438; x=1768465238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR0GCYK6h8L6OB0x8sKyoqDgYiBaxX9t2TeYHE9k9UA=;
        b=GHlJ/Pgirk8LG7G/4UZtYQk2XhKTo9KNbjRx6gfITLmhIMO/7Qq0iiq7dnCaTPZ2hA
         hpO0rZMmkTUwl+DthrdJTEbQeRnt0dt+a//VucQMEa55OOj2MpL93L/ZJQjVJYdib4M4
         /vjqIC+2OwSZ16WDOUFbh8/oeA0ZPtObO7hMfGdhSoFiRzf1Eb2p/lq3bE2GlHhazZDH
         EvYaA9ZSx8iJ9u5UbiU/9lF2LxNXX0H7bgV1tXL5OwDVef6NYG22Ivl53IaAjq0ZGxv6
         RC2dWkV2B0RnUPR8IPFX4bNjpe/yWdaOthswhQomlJ965i4yddaTU+qkXQfqMUq0tM6y
         dVRA==
X-Forwarded-Encrypted: i=1; AJvYcCWF+rdnxSrDEpOtLJNIKNm7XP24H4VIoF4MVY/WlD/v62Cj1jHnES47Yk48wvzY5iLv9T9R2FNXcEAPMNaSkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSfe995ztX1yts0sS5R7W7qXliHNJxda5hpu3q2s6luveoYJD
	CVcVOlI/bzNNRaEgVTh93T74hasnTHie2mWRS9CHkBCnLsWyAPwJIPeH
X-Gm-Gg: AY/fxX7rHGSvCKcZcqQb6bci6gcjk8AeQLZgqMSxSMvl7mZHbxttLW4eE1zWawUck/x
	Rv7EWtNrn/+3jZXytrD6pww2P4YDN9Z+eP0De9Q8oi8q4IKPsxbmH1IGBJ52wGB65InwAHu5nDA
	f6PkbvPd1dUHkBLq5SwIxk9pSNx3Ylkt0tfJIuWUMXi63PM/fLeMaNyA4F/D/Gfqj0+Wz7zcurm
	3oCVNVegE7Lu/HnM8dlz0jX7vWqTHt2b02m9ca5sdOtUhxnl3N+Ch5Uu62Eg+QmzkBISXX5gXtd
	izE//GDe3zKgynPjYddxcEuyFi6Pemp5aKSzQ2GKHYumCiTeJDNbpVmon9BjgGM8EJrzvW4cw03
	GrPLE76Df82efTsRVtAt8eZhxhG6K2IYfMs5P88I3Yi+0BiBIYF2vvjhTFCDONuau29HviP4lA6
	S/Bwm6BhRGwFqlB41of/x1zbXgMey7lzpRE2KfquoE2fGWuCq/iOGQMRerpcALKsVcg7QQobv/P
	sw=
X-Google-Smtp-Source: AGHT+IEqwz9H4zlTphgUa6QtrDmeQFo+8B1RuC4sojvRfFwNaYzGFa6Q1/WA2iBglkGfpN30+6EASQ==
X-Received: by 2002:a05:600c:46ca:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-47d84b0a8f7mr57916615e9.4.1767860438031;
        Thu, 08 Jan 2026 00:20:38 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df8besm14257574f8f.26.2026.01.08.00.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:20:37 -0800 (PST)
Date: Thu, 8 Jan 2026 08:20:36 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio
 to gpio-mmio
Message-ID: <aV9o1LL0Ahip0O3-@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <20251217080843.70621-2-shorne@gmail.com>
 <CAMuHMdUaO_PwWygW8qss47W_ErB4pm1Z2HQ+edvw1-x7ce7oKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUaO_PwWygW8qss47W_ErB4pm1Z2HQ+edvw1-x7ce7oKw@mail.gmail.com>

On Wed, Jan 07, 2026 at 03:35:45PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Wed, 17 Dec 2025 at 09:15, Stafford Horne <shorne@gmail.com> wrote:
> > In FPGA Development boards with GPIOs we use the opencores gpio verilog
> > rtl.  This is compatible with the gpio-mmio.  Add the compatible string
> > to allow as below.
> >
> > Example:
> >
> >         gpio0: gpio@91000000 {
> >                 compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> >                 reg = <0x91000000 0x1>, <0x91000001 0x1>;
> >                 reg-names = "dat", "dirout";
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> >                 status = "okay";
> >         };
> >
> > Link: https://opencores.org/projects/gpio
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Thanks for your patch, which is now commit f48b5e8bc2e1344f
> ("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
> in gpio/gpio/for-next.
> 
> > --- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > @@ -18,11 +18,16 @@ description:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      - brcm,bcm6345-gpio
> > -      - ni,169445-nand-gpio
> > -      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > -      - intel,ixp4xx-expansion-bus-mmio-gpio
> > +    oneOf:
> > +      - enum:
> > +          - brcm,bcm6345-gpio
> > +          - ni,169445-nand-gpio
> > +          - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > +          - intel,ixp4xx-expansion-bus-mmio-gpio
> > +      - items:
> > +          - enum:
> > +              - opencores,gpio
> > +          - const: brcm,bcm6345-gpio
> 
> What is the rationale behind using brcm,bcm6345-gpio?
> Given brcm,bcm6345-gpio has 32-bit registers, while opencores,gpio
> has 8-bit registers, I doubt the latter is compatible with the former...

Hello,

I was following what we did for uart, where we have
"opencores,uart16550-rtlsvn105", "ns16550a".

I am using brcm,bcm6345-gpio to match the drivers/gpio/gpio-mmio.c driver.
The opencores,gpio is compatible with the same driver as brcm,bcm6345-gpio but
not 100% the same as the brcm,bcm6345-gpio.  Since the device tree allows
configuring the gpio-mmio driver to make it compatible with opencore,gpio I
thought this would be OK.

I switch the size from 32-bit to 8-bit using the reg = <* 0x1>, <* 0x1> setting.
Also the reg addresses of "dat" and "dirout" are different for the real
brcm,bcm6345-gpio.

brcm,bcm6345-gpio. Example:

       /* GPIOs 192 .. 223 */
       gpio6: gpio@518 {
	       compatible = "brcm,bcm6345-gpio";
	       reg = <0x518 0x04>, <0x538 0x04>;
	       reg-names = "dirout", "dat";
	       gpio-controller;
	       #gpio-cells = <2>;
       };

vs opencores,gpio Example:

       gpio0: gpio@91000000 {
               compatible = "opencores,gpio", "brcm,bcm6345-gpio";
               reg = <0x91000000 0x1>, <0x91000001 0x1>;
               reg-names = "dat", "dirout";
               gpio-controller;
               #gpio-cells = <2>;
       };

The opencores,gpio setup does work.

Now that I think about it, would it have been better to just add opencores,gpio
to gpio-mmio.c compatible list?

If so I will can revise this patch and add patch to gpio-mmio.c.

-Stafford
