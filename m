Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFF3451DC
	for <linux-openrisc@vger.kernel.org>; Mon, 15 Dec 2025 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827285; cv=none; b=cCGDvxjItYeyi71TQHvol9sdcemulqhO/wM5LkX2Bp4tEArBBa/yKmP4fpeYSFvK9Z51koppWk61g95gr7sBx/TLmGwju8FI9b+hmf1WSUiq5UubTva16/usbMiCx+yXkre3blzI0xYWnnetB7z+DXvkvCO60OmwdGAEOHEOVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827285; c=relaxed/simple;
	bh=R9rr7JYAlu4ut1klPHqgSod04bJtytEccLyOYIIOoOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGcs2OcnopocPsIbfmYsYpXYr6ABL3NmKvhpbTzYxJzDS/wx6oXjJvy9iO1nG+T+iF8k6NiqhFqg0coKn8Pgf99P/UJLIv+87B0kZeiwce+iaQHOAdEa9WZpiBz8cO7PL+9oFn6566Tm06MvnSkuNd3yCKkxgyd+LG1rFxukcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP33xbMo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP33xbMo"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so24963775e9.1
        for <linux-openrisc@vger.kernel.org>; Mon, 15 Dec 2025 11:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765827282; x=1766432082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvsN36HEjkdkzaTc/2dKVIMfjzjS0gkF6l57K40dHSI=;
        b=hP33xbMogz6C+7KYeJ4qUY2y/7SUagcVMZnRLJK1gzaibawRUhT66dJ6GpTu/C796Y
         Rxo4076qBEOjdfB5DJwbxgrMHLQvvtufQvjED7i3vXS3Ksvg1ng44+lrUJVbEudf/kBC
         asxaA7eMuS4/vMz2Rbkq4R8UjtHx7dpKnTtWFSSn6GHDTl7JhQk+jpZItmTkQGmk+5Zv
         7rWDGBBe9WY9AoQ6s8qJ0qKABXDHBzLctwmteSMzoMFTftdVivb8eH7mzSsvGQD/PO02
         3412cSpQ4/Q7Hpop3uUoS4FFZ8vr0HVMsPL2GrnOC7bSp7W/FsyeAyIzC2bbDKEctIoa
         o+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765827282; x=1766432082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvsN36HEjkdkzaTc/2dKVIMfjzjS0gkF6l57K40dHSI=;
        b=J38yogVW7fTyJ1spb3y+iHmWxbXL7esVYVvjda+f6fQimj1e6r2MAEMWmtmSDnILr3
         vtofavgCtULOqjcoqH9JLFeqYEi4MBcuYMkrbyRhV3FexTN3dWzMPQaVvr3IfkegOpFh
         bwooJ/zmX6gPEEBd3AwS0FvtnOjKDpccjnx3uc/ynlrc90IXsLTilfMdDWEw59VbkzMZ
         qIl+V/ukOsIiSNWCLRwWyODZ30GiCtUlWidPJb63QnIdG7FXriau//vrLblXRu+lRpJo
         k+AHDMP7jhs/XStVixhHdZZByldxy3p1X5p2z0/q68Z1eLlj7IB7KdtUbwjypMOS4IEI
         f0MA==
X-Forwarded-Encrypted: i=1; AJvYcCVFFR9u7hSbpUO22uCfkxTEPwhfoBkR+0FBlFr4jy1qdQF3ilKS/kZ6L2KnDyZz06j9RJGcTmay+MbO1XRvwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20zAkMP+GGxU1ZwVo/kLrxCHEmpwdrOw3CpNleTRYnNdVN2qe
	yYkingx5eGmOUpWHMWlhrgOxSvAtm7LvBajEHNlufk7coyEo4sV1jBga
X-Gm-Gg: AY/fxX5H2K7ScJVuV2VBqLDeza84c5EXTXGjHlv7nGmB+GUZE3VCntNagod0BehcAmr
	FelN9Tuk1/xfY7CMbNLYeDGIJ5ACgGf4XTLz1hubjS1C/44fqmc3rlALo1MBH4656owByqzzTF6
	Yh/+WA/GccS2pEConxt4uLYQGf54Dwo83XJK6ydp0mcuofF43vOC5ct5pSmRVdiOpq/Tf0nIvpq
	szFkLeC/4qFTx9Edg0ij7NhkHTfF8GAnGVb//MnTgSx4bFsPvwICMUo2LKWxUAtf58T7LM0hm7i
	tkojd+QoDw8WmMsZXXUHqxT7iDXcnwE4FveAKZgak+9x/jG2LDvG4YNDigFVhhxLehY0iJ0bCuq
	KmeUuFP49fiYQ3wVQa4+uOkdRJMQc8VjCEBiwqE4EnpVV8kNZ4jvZMA8vVXq8me/vq3xD1dlWUR
	equkAEUX4YLe3tMYUkO7vZ/YF9yCjqrYHOBqEVh3vwZbN9QMxcjq6UaM1ibhhYlttf
X-Google-Smtp-Source: AGHT+IHqMmTrPYwvoqeuDlvMpEDl0MXgKJmnwWH2vCQFY8SiusRi4m3bCAkknOzdZ7YPRYj3LhSsRw==
X-Received: by 2002:a05:600c:3ba2:b0:477:97ca:b727 with SMTP id 5b1f17b1804b1-47a8f907d9emr138780595e9.19.1765827281485;
        Mon, 15 Dec 2025 11:34:41 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fbc6e3392sm19493062f8f.13.2025.12.15.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:34:40 -0800 (PST)
Date: Mon, 15 Dec 2025 19:34:40 +0000
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
Message-ID: <aUBi0Fid8vF-G8Wl@antec>
References: <20251214180158.3955285-1-shorne@gmail.com>
 <20251214180158.3955285-2-shorne@gmail.com>
 <20251215-skillet-perceive-2b564a29ed71@spud>
 <aUBWMbKLMWO2Wv_B@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUBWMbKLMWO2Wv_B@antec>

On Mon, Dec 15, 2025 at 06:40:49PM +0000, Stafford Horne wrote:
> On Mon, Dec 15, 2025 at 04:57:45PM +0000, Conor Dooley wrote:
> > On Sun, Dec 14, 2025 at 06:01:41PM +0000, Stafford Horne wrote:
> > > In FPGA Development boards with GPIOs we use the opencores gpio verilog
> > > rtl.  This is compatible with the gpio-mmio.  Add the compatible string
> > > to allow as below.
> > > 
> > > Example:
> > > 
> > >         gpio0: gpio@91000000 {
> > >                 compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> > 
> > What you have done below does not permit this, it only permits
> > opencores,gpio in isolation.
> > pw-bot: changes-requested
> 
> Understood, I was not familar with the new schema. I was trying to follow what
> was seen in some other patches, now I see where I went wrong.  I will fix this
> and use the schema validation tools to verify.
> 
> Thanks for pointing it out.

I think the below is correct. But, would this be ok to put in one patch?

I do:
  - Convert compatible from simple enum to oneOf.
  - Add items: for the openrisc,gpio compatiblity string.

 properties:
   compatible:
-    enum:
-      - brcm,bcm6345-gpio
-      - ni,169445-nand-gpio
-      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
-      - intel,ixp4xx-expansion-bus-mmio-gpio
+    oneOf:
+      - const: brcm,bcm6345-gpio
+      - const: ni,169445-nand-gpio
+      - const: wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
+      - const: intel,ixp4xx-expansion-bus-mmio-gpio
+      - items:
+          - enum:
+              - opencores,gpio
+          - const: brcm,bcm6345-gpio

Thanks,

-Stafford

> > >                 reg = <0x91000000 0x1>, <0x91000001 0x1>;
> > >                 reg-names = "dat", "dirout";
> > >                 gpio-controller;
> > >                 #gpio-cells = <2>;
> > >                 status = "okay";
> > >         };
> > > 
> > > Link: https://opencores.org/projects/gpio
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > index b4d55bf6a285..0490580df19e 100644
> > > --- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > @@ -23,6 +23,7 @@ properties:
> > >        - ni,169445-nand-gpio
> > >        - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > >        - intel,ixp4xx-expansion-bus-mmio-gpio
> > > +      - opencores,gpio
> > >  
> > >    big-endian: true
> > >  
> > > -- 
> > > 2.51.0
> > > 
> 
> 
