Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB42F0C49
	for <linux-openrisc@vger.kernel.org>; Mon, 15 Dec 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824055; cv=none; b=sBSSKqFWR0imwr1Smt6kBcZn8p1Zvr+CIb3QKQ2cXn0RqU7lx7AQeCZg8G4wCtnj5zN1Lgmn9dhI16GFBNyHYirDiMGMr7uaqGI8FBL7H8Op8LxnDGbj+wLXn1nPrWNzAYVR25n3krG8HwbM/Geibi3CZOfIkfOYks/phHxJdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824055; c=relaxed/simple;
	bh=lIVXipTQUVpTOtDEFUYihhyCWJmbz98l7oWne/NFb7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNuEhXrKTwglS3uaTheClBF0nDtljlVqdUWEocymMOHf2UWNXSDK7esZRSZUh3Iun2x8sR0dVosR1YDsi6Z8jITc2hmbEGLbndBpLo2qUFmHXOXi7HdKNt1f9/RuM09H/iT0eAX2eL1eDranV2m5zmazUyyJWwjDpuDyubP18os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAb+sZvA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAb+sZvA"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430f1cd0026so1513471f8f.0
        for <linux-openrisc@vger.kernel.org>; Mon, 15 Dec 2025 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765824051; x=1766428851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CyBTq9jLEiMDCmEowsuiPxhEFRUD4GVU2KPfPukCJE=;
        b=nAb+sZvAqbk0+0fa7+lJd27J73fsbUCOsQmoXfZLkJkJOpvLUtNqD6W9lSr95DuyYp
         7XcNEOgdMomo6hL1vuXtKpfWoAG4OZb+vQoFDkWhFDhlx20AQTeqCRBkt9XWiUhlr8Yz
         kBuxgsQNwSIa+KHKVtTTFevZ96md6N8r34Tx16re+dB2o1gOCDW0yLrqUs8Bh/5Y3njA
         aOKbtWZMQap4Y60d1Ugrr/Kc2zOTnvhdnhu9vXYkkFco6pK/9KqqahxdJyMJnFJMJ6ii
         Px2InM/DARYhXax97Ua5qHnkNs4hfRrkTbw7wVh4jybhsuv1ACNripFISh+rWvpMMl03
         K6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765824051; x=1766428851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CyBTq9jLEiMDCmEowsuiPxhEFRUD4GVU2KPfPukCJE=;
        b=xQFDJNpbUXYxHLFUsvYHMrF9zPMelnavCI4hN/sRZqZeoacbzXbiCyCwet1rimnnMd
         NUQqO2DQI+iNLjmJBjbLprrSjUqgolLa93kmQccymqO4uF2xBeODDPOHQ4F/ZjC3fAkH
         S3BR8F1KxPGXamKgOISTvwR94gqfSJwdRkh0bcp9Nc2FpIT714Auem7wxisYb6ic+b/m
         3YtcX/nmGZlijy1/PRExHYyRDaZM9gRsC0GR0zRy8mKIcRPKRng2o419O7w/8BfQDLiF
         kEK+EP8gDO/3HVrSeoLkwQc5NBK5iIac8byqVAzBj9QQSUP5cza2La3VOQVJSiEjE0iE
         +wqw==
X-Forwarded-Encrypted: i=1; AJvYcCXtvrJm+Rka/SReGTBD6BsjR7T+chsJangF0+GflYJUF1GRNp80j+BdpovjV7U517JOaJVx+KHRyEGXxeMX+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqOYWhaOvCnIN224Ekn9TsTAl2V5kWq70IrlKtwY4+djd90mi
	hci0S+mbytnGgpu6vCe58yY5VHNyzpHkhN2LI00TyI7JXm4sGWyr21m0
X-Gm-Gg: AY/fxX7UdrYg0MLjMgv1v2yuUanSrePb64IfYPmNWXKvP5ww7FJ7DLbyixY1WIxLdYS
	defE4/jyIrz0peKI+zARDzjGTb2pNeSOr0qAGPdD/R4oQS2JJxrFOOy5yLnWXWE+ku5ZfT2xnbK
	tn/3JS8cJGmNgwP9DlGka66d1Mw2+2RibJsWS6/yISEYrUkFry0eqvTghM1cfo+8RvkDh1JiJin
	1v4sHTDX5TRWoSGQi0ruJ0XGtABX5HCQLjFDs8srIR6ABkD0JU8ZdZBVY16WPC478iPtmqTBYW+
	2VnaBcHqiJ8XdSUl1ZD1EbHRM2YC+oWyvyeKO+uPbi+ZAIbG7c1Ubgzyes/lLGfIQfLusIBJ3pD
	26k+8u6l2ojfr8SnkQlsxrlpPfs6LRwyMbh7y2jmV2dFmQxVOgh1zhhcEcwFnBCNEEYXSR6BEhw
	D7IIK1DAPbl4gaN7TKtx/bJGolreuUNH865/Bc3n3vNXTb9x1N7y5vyOvDw9ifNksb
X-Google-Smtp-Source: AGHT+IFpW6CxSU45/d3ozXnd56s4i9wy9U479O5ED3vRIcHNNAFa5Ur26ZBdU+1QKOAT3KavHokbqg==
X-Received: by 2002:a05:6000:230f:b0:430:fdb8:8510 with SMTP id ffacd0b85a97d-430fdb886c1mr4417808f8f.24.1765824050820;
        Mon, 15 Dec 2025 10:40:50 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f268d459sm15401602f8f.32.2025.12.15.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:40:50 -0800 (PST)
Date: Mon, 15 Dec 2025 18:40:49 +0000
From: Stafford Horne <shorne@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: Add compatible string opencores,gpio to
 gpio-mmio
Message-ID: <aUBWMbKLMWO2Wv_B@antec>
References: <20251214180158.3955285-1-shorne@gmail.com>
 <20251214180158.3955285-2-shorne@gmail.com>
 <20251215-skillet-perceive-2b564a29ed71@spud>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-skillet-perceive-2b564a29ed71@spud>

On Mon, Dec 15, 2025 at 04:57:45PM +0000, Conor Dooley wrote:
> On Sun, Dec 14, 2025 at 06:01:41PM +0000, Stafford Horne wrote:
> > In FPGA Development boards with GPIOs we use the opencores gpio verilog
> > rtl.  This is compatible with the gpio-mmio.  Add the compatible string
> > to allow as below.
> > 
> > Example:
> > 
> >         gpio0: gpio@91000000 {
> >                 compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> 
> What you have done below does not permit this, it only permits
> opencores,gpio in isolation.
> pw-bot: changes-requested

Understood, I was not familar with the new schema. I was trying to follow what
was seen in some other patches, now I see where I went wrong.  I will fix this
and use the schema validation tools to verify.

Thanks for pointing it out.

> >                 reg = <0x91000000 0x1>, <0x91000001 0x1>;
> >                 reg-names = "dat", "dirout";
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> >                 status = "okay";
> >         };
> > 
> > Link: https://opencores.org/projects/gpio
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > index b4d55bf6a285..0490580df19e 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > @@ -23,6 +23,7 @@ properties:
> >        - ni,169445-nand-gpio
> >        - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> >        - intel,ixp4xx-expansion-bus-mmio-gpio
> > +      - opencores,gpio
> >  
> >    big-endian: true
> >  
> > -- 
> > 2.51.0
> > 


