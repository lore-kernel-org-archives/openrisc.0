Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E7285CB4
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400686; cv=none; b=oiZ+tq9JFjulQYuF1UoDUDkTg5YEYJ62r7UxIZLswS+F+vzG9rVPH5CGP8Wx3MLJZIHIiI6kQTwyaL1ZTBcmd843y5HPqOmVFLWxBY0jY9e9ZOdNgyR6AanknoKd0GHyEGMSoGJQ4/oHAkdphHJYsMsUs8jzyiL96cXezl3eYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400686; c=relaxed/simple;
	bh=5oL6AvIqkyKwZjO0mD2/yYyQwRXx8TSv2K9qlKzrIXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm2bd6VdFcffAv4djbztR1oDspFhGZo7gq4O84J+ieHOmlcAuyyLLxiXhPQDEHbXhBK0GhKrEfkqGEjpbwdqfEX1hxD0PH/epML0hgCuf6Jk7tykSY2mCuuHY9xbQYuLh1SSJXpms8bwt56qeVQd1wUzKwBI/HBs3oDCov3Y4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUMwOu5n; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUMwOu5n"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4773839f8f.2
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400683; x=1769005483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ijENdGZX9Lgu2wTs3qW/G5R3AgDc664xhdb20AB1kI0=;
        b=RUMwOu5nLQqNO95IbNVJgOcZ6Ss/9l89DpfA8Y7a97Qzzr3+pqQOrsV/nAbeqi5MOM
         BueDuyx84ql+bJOsZt8m6lrgA7Ekx3r656bVODYGCjoti+jaYOEZaYLcm23Yvnw5+EVv
         3iDtL9I2VVa2Z1iX2cIA+1sWu3mfh1lQIJQEZQad214Bik4cKa1Dt+Ouv0SrSd93cK5O
         yz6Hzg37MXi5gVLmz9mrm+iwpPhiDaAoQz2KEJJCQ6LCitRIXbpyEzPEwz5XTluzHwpe
         EUjREbsq9ADAtJ8m9UBdl5JNISiFGc0MXrkpuJomoFWkpvS8JMZNbIxyVJa7PLt7gJEx
         m/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400683; x=1769005483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijENdGZX9Lgu2wTs3qW/G5R3AgDc664xhdb20AB1kI0=;
        b=l2K696mi+VyFG1jwV29Xxj44F/dXUZkSjSHMNHcBTeWPpmEP/B80v+TG8kXny8gfv8
         pKyB7WJ8eejebQZe1e+7yiu92dx8XKVk3bncTMwHysF0LENHp9IqbCpa0MuS2+7Qsy5j
         1xB06w0YfN6skjYo7Y0Y+7hhVFVEOROTTx6jdNft8TWRKo+ANGEre3r+4S91rft1J/Qy
         NGBNtylRUoSOFw8IWdmihUzrz+ijm8PWkYuGJB2dX5T9IztqenAHk4auLbHeKLJtLDyF
         D7XyztGfCP7qfbr1Mt6LSXzGlG8LM5NO1cCaSg3+KTBgFt/s29MmQKBJi/xBwCUethCg
         +eHw==
X-Forwarded-Encrypted: i=1; AJvYcCWYBekmh7Y3Kd498zkDeADxSkVIZp8u+X+yAG7pS023WUAOVBfe1F/nZBBkxzplA3SMCs5NzyL4Qzy81wwwOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRBkwzFEYhklNoYOrjbG0afwC/oDKFZuoOFuOxy8d21p5pHXR
	cCu+O88RvroJ3RSYKKGt40QKJS/l2FPsxYr8KlX9ghbgDZMylqP9z+un
X-Gm-Gg: AY/fxX65OIFXcgmbYJiRBwt+8EwF1++VSqSnrjj48CIazByREUzW6GNxQPSZIhBmceG
	vItKa0DMZbEzj1gPokDxICkI0pRAq3j1yjTAf5IXe6h11E8geabauFxzvfRw6kxRdA4cCJYK0+e
	jjlMX1hb9uaPocjiUDJs3+X2x/CvF9tJg2IFpqN8NH72zNDjLCyr8q4ru76zjGjf0hR5xi4zCUK
	Frk+3RssUa0Kk0IWJWnaNJuex5jTNtT6B8rrsJ/FV0bNULgIKw1JyzSRsnzg47HLxMW8hogLpce
	FcdtokAB7auJf64CTltyy+hZQz8FTJtbBiB8nZubmOhPatTcBN79TQjenGKHD4MD0JCThyLLy4A
	t2tpMBmxf4KqFzmT54x97AZzG0XMzveQQYRw9uF6Okkkp2oPNzAcj6CTCJBYnuoEVxXulUQCAtr
	rUdfNEdrCVlhQba6wEaGYyue/B+URZi7/yTC1ACHj3WeRqLHfZhb/Ed0DEAMYMefGZ
X-Received: by 2002:a05:6000:2dc2:b0:431:66a:cbc4 with SMTP id ffacd0b85a97d-4342c501145mr3034386f8f.17.1768400683257;
        Wed, 14 Jan 2026 06:24:43 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe67csm50308328f8f.40.2026.01.14.06.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:24:42 -0800 (PST)
Date: Wed, 14 Jan 2026 14:24:41 +0000
From: Stafford Horne <shorne@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: gpio-mmio: Add opencores GPIO
Message-ID: <aWenKb6N6mTJDipT@antec>
References: <20260113161152.3688309-1-shorne@gmail.com>
 <20260113161152.3688309-2-shorne@gmail.com>
 <CAMRc=MfLqoPvCiEtunvfidaRGAfZFbGM98y8vjj8R187ziUtdg@mail.gmail.com>
 <aWZzZWTjctHasCHh@antec>
 <20260114-agile-kangaroo-of-honor-963dc6@quoll>
 <CAMRc=Meicads1OAYM+bRN3B8P2Jt9=D=VNSL-KQytsUiBLaAbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Meicads1OAYM+bRN3B8P2Jt9=D=VNSL-KQytsUiBLaAbg@mail.gmail.com>

On Wed, Jan 14, 2026 at 09:36:55AM +0100, Bartosz Golaszewski wrote:
> On Wed, Jan 14, 2026 at 9:31 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, Jan 13, 2026 at 04:31:33PM +0000, Stafford Horne wrote:
> > > On Tue, Jan 13, 2026 at 05:20:28PM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, Jan 13, 2026 at 5:15 PM Stafford Horne <shorne@gmail.com> wrote:
> > > > >
> > > > > Add a device tree binding for the opencores GPIO controller.
> > > > >
> > > > > On FPGA Development boards with GPIOs the OpenRISC architecture uses the
> > > > > opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.
> > > > >
> > > > > Link: https://opencores.org/projects/gpio
> > > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > > > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > ---
> > > > > Since v3:
> > > > >  - Removed example.
> > > > >  - Re-order this patch to be before adding compatible string to driver as per
> > > > >    device tree binding patch rules.
> > > > >  - Add Reviewed-by's.
> > > > > Since v2:
> > > > >  - Fixup (replace) patch to simply add opencores,gpio and add an example.
> > > > >    (It was incorrect to specifying opencores,gpio with brcm,bcm6345-gpio
> > > > >     as opencores,gpio is not the same hardware, its 8-bit vs 32-bit)
> > > > > Since v1:
> > > > >  - Fix schema to actually match the example.
> > > > >
> > > > >  Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > > > index ee5d5d25ae82..a8823ca65e78 100644
> > > > > --- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > > > +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > > > @@ -23,6 +23,7 @@ properties:
> > > > >        - ni,169445-nand-gpio
> > > > >        - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > > > >        - intel,ixp4xx-expansion-bus-mmio-gpio
> > > > > +      - opencores,gpio
> > > > >
> > > > >    big-endian: true
> > > > >
> > > > > --
> > > > > 2.51.0
> > > > >
> > > >
> > > > This is not a follow-up patch. Please rebase your fix on top of
> > > > linux-next. I already have the previous patch in my tree and will not
> > > > be rebasing the entire for-next branch.
> > >
> > > OK, understood, I wasn't aware you would not rebase. I will rework this rebasing
> > > on linux-next reberting my previous dt-binding: patch first.
> >
> > No, you need to rebase, not revert.
> >
> 
> Just to be extra-clear: take current linux-next (next-20260114) and -
> on top of it - create a patch that fixes the issues in an incremental
> way. No reverts. Also: add the Fixes: tag to your commit before your
> SoB.

Got it, I was doing this but preparing the series with a revert.  Good thing I
waited a bit before sending.

-Stafford

