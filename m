Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED31F8AC5
	for <linux-openrisc@vger.kernel.org>; Sun, 11 Jan 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768150017; cv=none; b=R/ueAyDORdDi1Vu7HJppqj6jtenlp6KAe4CP3XB+lmhZCok9DIq3UT3p43o2uwbUMUOpTy8mksifZt2uEaQXTH3fMOsBcsq9JVhQXAVUPrzCO5GYNkcM/hk9Mhme4mr8RUlVHCi9rqJglnkqEXUIQ7wd8AL2hm/864EKpV8mgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768150017; c=relaxed/simple;
	bh=EKeMRlHlw2Rgeq19TymBbPBx8wczT3GJe0/hQx0Xx0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctqgz/Q9iV2VCr09lWDlvgfCT/u2HOfNNDcLxwJkPGF3U2B8/qSRujndJ6etD+N9wRkKN5hHQkL8JxVSAzl8XDRXlu7OqLUqF0qL8YLfskp2HniUqUGTKREdbVQ94FbVXj2erpbCSXmEtLdSdNJnJiTvnCNdNcPE4Xs6xUyxuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ6MJ9LH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ6MJ9LH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so32645535e9.1
        for <linux-openrisc@vger.kernel.org>; Sun, 11 Jan 2026 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768150014; x=1768754814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXXIjf5GUwJDqboXk/BUgrbJnl8FqgJPhbiKhNF9WA0=;
        b=RQ6MJ9LHuABBd9ogQNkQfS/9O3RDmNxuR4vrJ14RGOcQgHchoqwJE5e4RpNtRWWYU3
         OfEqQYJktCFKykX/DeyKL3ddpF49HcfKEwe+g8n5+nEDREgPIZnH8/F7fGLYqByTJwSW
         1jgwVLD/DXoenWTSNiv4OCvV2PDZgWRDT/lxbdy5Wo3wB6+DdrlP9Qs8xowncs04aGfS
         PWW2D6x0BnEU4D/hYc2bDaXkjVp58VIFosSRTQ39VgPP0GhydlCDF+hCDfJUxZsD7i2v
         +tH/ovKHwBrvUtY2+Mf2DK2l1ErL0+NOUPJlVCZjdFtRFH4ObnucSJrKL3N3g0bMSmZz
         1YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768150014; x=1768754814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXXIjf5GUwJDqboXk/BUgrbJnl8FqgJPhbiKhNF9WA0=;
        b=tEAOlPdTuyXIqaCXYbfRU7PQh2cF+3RQu1/VT+kx0+4LHLiXGyPPyGyi6YeQbcDN4n
         DuYRozRrrhMptnTnnp3rFlp7UpFTcnEXjgFAe2piOZ987DyPY6STZr/i4ErVfDxstW5B
         SJiY7+dNKh1Hb7EQ+Al7XbiKrDDhbBxrXtlUPeHHRkaHFVIHC6gsnuEkT8CVaUaUOuK/
         T0JvKtB1vhf+K/4Zc5/FOWKa2MtsACAJ5ddY/LrNBnMvExijaA/lITANz7zOG5jJUgGb
         DFZs6FE3Orv0fsN/ykBgq2qXpiY6fqjX70sz0aITXzpr3RE+uLc9HLZLh42ZEZyWyHgc
         sOsw==
X-Forwarded-Encrypted: i=1; AJvYcCX9zOQYC3xWwIHPKVjkYUUdutUbKUEkFBgzfb/k05Kp7MU1gpZ2IuNs0NRfpE8tyAdDkqO4EvAPf6Izm/V68w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXkRcrb31KTXAltbGJU2WAu8JaAFaBZY8+D64mVCGQNYzZv+V
	aY535WLH2jaXumQdTw+wSWl6abvAk0aXJ73XPyfDMu+TTXN7YaLbAlcI
X-Gm-Gg: AY/fxX5yZskQbhQQuUbqrXGmO8/yiTKx6DX8AXd6U4EJ/bz1M52XLHA3KhnWBIdv8pi
	AGk8ZC9XYXG7/BAeROurberdPVZ1tY7bSBN1lcQ95c82S18q7Edn5mJChOuHNjJUSzKpFeX0jwB
	TNrRYK//9nCxcKijv5Cr7kH5S1P9b2DJgBAPc+onCbXKJoZtSQV5YhX+L7vgu/LnRPpw6KtiWmw
	IITkdfgWKFY6hGBvk+Q0S6iK7Ko+uJSz7sT6yjX77QQ7OCTxu5OW3/y5qi+cRI13UX2tCag8H0Z
	tUzxI+TkojB5V98CyrfETTfTm04N3oIi7wz0gil5zdla9zAnGv+FAdhUhLoMpw9dML9c1mgNzma
	86uUuKpJaWh2XdwjM1Tl6Fp/U6csiJ+l4ITcTD6aQ+zYbCIyPoMTnKhbWJ9q45H8WT8O3oHq499
	g09+xaNMqeVMNhCMHHhOhFkCx36g/d4uFPkZEna60qv1yin8zKHsvQXwf51KKuo08h
X-Google-Smtp-Source: AGHT+IE/2VrwBn/B2S3fOGbBdhWgsr/s+ZUXrx13BwQ/UzL/3rHx0t494nmIc60K28I7RKjr7ysiHw==
X-Received: by 2002:a05:600c:a08:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-47d84b36b7emr195633575e9.17.1768150014007;
        Sun, 11 Jan 2026 08:46:54 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f0cf2sm110128995e9.3.2026.01.11.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:46:52 -0800 (PST)
Date: Sun, 11 Jan 2026 16:46:52 +0000
From: Stafford Horne <shorne@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: gpio-mmio: Add opencores GPIO
Message-ID: <aWPT_HsRVC0dQ_j6@antec>
References: <20260109134409.2153333-1-shorne@gmail.com>
 <20260109134409.2153333-3-shorne@gmail.com>
 <20260111-bold-wolf-of-champagne-58fac7@quoll>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111-bold-wolf-of-champagne-58fac7@quoll>

On Sun, Jan 11, 2026 at 11:18:42AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Jan 09, 2026 at 01:43:53PM +0000, Stafford Horne wrote:
> > Add a device tree binding for the opencores GPIO controller.
> > 
> > On FPGA Development boards with GPIOs the OpenRISC architecture uses the
> > opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.
> > 
> > Link: https://opencores.org/projects/gpio
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Since v2:
> >  - Fixup patch to simply add opencores,gpio and add an example.
> 
> Simplify? You completely changed the meaning of binding here - now
> device is not compatible.
>
> I don't know which one is correct, but your changelog must explain why
> now devices are not compatible but they were before.

Hello,

Did you miss the 1/6 patch in this series?  We add the compatible string to the
driver there before we add it here.

Sorry, I thought the series and the over letter would be enough to understand
what I meant by the "Fixup" description here.

> > Since v1:
> >  - Fix schema to actually match the example.
> > 
> >  Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > index ee5d5d25ae82..d44edc181e0a 100644
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
> > @@ -160,3 +161,11 @@ examples:
> >              intel,ixp4xx-eb-write-enable = <1>;
> >          };
> >      };
> > +
> > +    gpio@91000000 {
> 
> Please do not grow the examples if they are exactly the same as other.

I figured this is a new compatible string with a different set of 8 bit
registers so having this example would be beneficial.

> > +        compatible = "opencores,gpio";
> > +        reg = <0x91000000 0x1>, <0x91000001 0x1>;
> > +        reg-names = "dat", "dirout";
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +    };
> > -- 
> > 2.51.0
> > 
