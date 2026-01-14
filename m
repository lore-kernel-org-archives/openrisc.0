Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367E39E6E9
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405827; cv=none; b=L1H+kvG6giktOGMHez9Dn2SeXzziQXsn9lSMA+IQQQKQBBRQ/5YS+CCr14HIL0zE8KusZ/6EXmdP0/O5P1EVfGbZ9MB/9s/BOZzzEeJEmwkLOTQaN4tgJP3hBgL11zuJWxB/STK6dOA49uAIdB0LrX7wTLKK6bjcRtVKKk/FAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405827; c=relaxed/simple;
	bh=ddQehrH3WSA3nGxMiaRyAYUbIlWNzS5C9Jp+zx+8H8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvdObstdpN5+JhzupdDI5MSGHWtlXHUCAf3Ch8n/BJtc4cjD2qEGcM1fLpoMc9Twg6t2945z6p0Ca8JkfM1WIVfZgkMHkf3I3rlkwDyBHCm8aRYkh9g+fRF2BixGzld4e1GVq1pn4EowRDIgCL89aq4P4iBnclg8CWqcD2PVYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHqNHHoD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHqNHHoD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fed090e5fso5126619f8f.1
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405821; x=1769010621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOiuVPrIXtE3jtOHLTY4+B/ZSnvL+yz9lGk8+TFFzig=;
        b=fHqNHHoD7D5VZmBZqNtYp067LU/SrgHKWVBJi4y0eNECXv/XPcOHnqDI+xgib96fbi
         UxrYOxxtwtKMGAK26ISfYunfWRjykjvxD5Pmycz0Ndf6HHj93XFG3PdobFh+yEG1aysu
         Y+IWkT7zBiCL4bBbL7xT/9plnWH/G6fkwlDm0cD/tkpjRfhkF/yxATVKSPu6bDDHtD3G
         LP6SAd9gwHx9Xzto76YC9lq1V1hNHIDNOzKfp8ngvoZe/NV286Fmu8e0GNB6ucMbhMwO
         5cHx0XjJZngKJV3zGMLYE/4PC1xwGqqMxDbnyeH4muNON/NrbSqSGG3d1+NzUDvEWjnM
         hoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405821; x=1769010621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOiuVPrIXtE3jtOHLTY4+B/ZSnvL+yz9lGk8+TFFzig=;
        b=ltTvKdFVOFnFd+RvQrD8w9cYPNx3kl56MWRVYEb82h+9b7Aruuf4sXnRkJW4Bzxzd/
         wsih6UXpWTjsvTlTLQhLqmkklXI0XvCUDP5bV15skyYH6bA5zHPLD4O2mQkNyOcLMN3T
         x7W313114GPXVIxmSszdf/lchtUBU21mn2TW2DS/8UJ3Dd/lqZdfwShaAxfiTYQ70ppF
         GPe1BjdR8zbuaN4c5HOVbLS3v/55dN4Ze28LyFm76UN/CnmcSwQC9wx+cIoh2QJr3ZRG
         //nm3RvKhG3YlIJ3wK1L45wJV7hr8uC70TpcRx/zogA3x9zq2C3NLxeFB4k9x8TjThVN
         KWmw==
X-Forwarded-Encrypted: i=1; AJvYcCU/LQGYtPXf5KvuusQTxqaDUIYxdDs5f3ZSCmz9Rz/K7xsQ8uY6XA0pvCrOh5OwoIMh3+ynL2WoWlSTwuXGPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13ty1+DmFHDreVKYMtQaq11OFe+pz5aT56M9jPFe/PbmxZLuK
	+1gds1gFwpmEGgMkg7+a2m3pPAK9KXiUCz06lbTSOl5wF6BIxj3ZNqhb
X-Gm-Gg: AY/fxX4RNu5pQ1/Nwt63zHWLFWMTnQtuAM9Z4wudOkD7HFo9wH5JKtj4xu757tnvIeA
	u8rpxMA4zCzYBUD25iZ8KbkQG9c1XwqDx5V9KzcCS9leMU0FjwVze/4Fk3VBbJ5EuMgKDaR98yg
	JOsrmMfXKO30k7ihDDC0j+v3SmCvRCiYqrKYPkW5gHJPOzXOSOV9HYB4QEyiP0sXP4625/mp4Kc
	rFL60H44Jof8BmO/aEnbKxXgqYP5j3TNanE3yGT1ad7Lqy/5r9q8zOXQywbl18qfqFlG4hxHXxp
	hAxJlFq8WFpWl/emOnY1Zwb+2kfRCd8tonLC7pSChNA7Rq6P50PV98PHxzv+nu9aDIkpAahLNVO
	LBub8OkxJrKLcGppL/5Gsz9ZPKFXWWpyFMSjpSEcUQ2SGG7k018VQD3jXq8ZrIBfzxHp6USn+8l
	OKKupVVMPoe4YWmVR4/iNlwLrlfN68mVw2Ze9cedxLMKYboT+FRmeOICSP9SY5KDN7
X-Received: by 2002:a5d:5d81:0:b0:430:f3ab:56a1 with SMTP id ffacd0b85a97d-4342c557659mr3494985f8f.42.1768405821138;
        Wed, 14 Jan 2026 07:50:21 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a650sm26077f8f.4.2026.01.14.07.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:50:20 -0800 (PST)
Date: Wed, 14 Jan 2026 15:50:19 +0000
From: Stafford Horne <shorne@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
Message-ID: <aWe7O7njC1gTIUcA@antec>
References: <20260114151328.3827992-1-shorne@gmail.com>
 <20260114151328.3827992-2-shorne@gmail.com>
 <0bb9de0d-f811-45ff-b673-8811540b5376@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb9de0d-f811-45ff-b673-8811540b5376@kernel.org>

On Wed, Jan 14, 2026 at 04:43:35PM +0100, Krzysztof Kozlowski wrote:
> On 14/01/2026 16:13, Stafford Horne wrote:
> > In commit f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible
> > string for opencores,gpio") we marked opencores,gpio to be allowed with
> > brcm,bcm6345-gpio. This was wrong, opencores,gpio is not hardware
> > equivalent to brcm,bcm6345-gpio. It has a different register map and
> 
> "is not compatible with brcm,...."

OK.

> > is 8-bit vs braodcom which is 32-bit.  Change opencores,gpio to be a
> > separate compatible string for MMIO GPIO.
> > 
> > Fixes: f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Since v4:
> >  - New patch.
> >  - Rebased old patch and rewrote commit message.
> > 
> >  .../devicetree/bindings/gpio/gpio-mmio.yaml      | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > index 7ee40b9bc562..a8823ca65e78 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > @@ -18,16 +18,12 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    oneOf:
> > -      - enum:
> > -          - brcm,bcm6345-gpio
> > -          - ni,169445-nand-gpio
> > -          - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > -          - intel,ixp4xx-expansion-bus-mmio-gpio
> > -      - items:
> > -          - enum:
> > -              - opencores,gpio
> > -          - const: brcm,bcm6345-gpio
> > +    enum:
> > +      - brcm,bcm6345-gpio
> > +      - ni,169445-nand-gpio
> > +      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > +      - intel,ixp4xx-expansion-bus-mmio-gpio
> > +      - opencores,gpio
> 
> So if you are changing all of the lines here, you can as well sort it
> and put the new entry not at the end but in alphabetical spot.

OK, I will sort the list and mention that in commit message in v6.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks,

-Stafford
