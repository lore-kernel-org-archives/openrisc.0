Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE42EC084
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321897; cv=none; b=YT25F0zdXGx+3KTyCTkpxUkZeh8fH85zG8JkqFoW1ycEvUqCd1ktYA7J1otJd5dKmF2wFRFegOA8DUgwycE4SURzXKByNBjEGnGqUOxJJa+gcUNZJxSbn3aBpK2bRWWIZ72fxuUAPBYynkIB1Cw8fABGWwdxt05TLZg/TsjCpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321897; c=relaxed/simple;
	bh=LJvzeJ8sBeVhqAy36T1wh5GmbB79XkoE5MDUcTT4H/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCw6PAzlTP6I3ob/y62bFLXIdin0YMrd5cLjJETSDnfM7hbTB+k/5X1K2nU/AEVg4WLlErqvABJArgIagw5rNYNrkax9rwW0qZg6mbIl5M/9U7DkqP7wy+RQXojQ3GswydwlG9wlaWxH5Xmse0HU9ovP0xRrBzPaGaR9HqlezxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBBxawHu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBBxawHu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso83688425e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 08:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768321895; x=1768926695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=grkn1v8X7YjSC+2N10jrNHP80DnpBreGGtO6qDJnKFo=;
        b=PBBxawHuyqJJ/lWIjL1n47LS/TE8DXOrsKXuyRls0/n6LI7/dXmcEyl7JmD/U2t7jY
         PduNBxh7wc2wa6NuWT42cKWm4XfuizQ4rJc6F0y8rHfnkAHyzuy2iLUMmEgQ8uICsWly
         EHHDJ4R1n58YCLgoez21Axblx9UPShbWVPtMr6sg0DTFUSeK36rGGlCG1fBwW04ybw1g
         uS8uUvl6vssr5z/pTmfMR1gAHVqOrtDisL+jbJbQkRbfr8WAa2jsKK/HIr4KZTLf6W+J
         FOCEmZaPbcxgEaBHVFxEy3+j8AC33F1nxdOg/3uKcr9X9d9Tifdbg7UOCfAn2uyLX8Kt
         AjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321895; x=1768926695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grkn1v8X7YjSC+2N10jrNHP80DnpBreGGtO6qDJnKFo=;
        b=ToDCbdyOHO1uMrQ8HO4EgP1OvVWWUaMbqA5aHdXKBHHiR26XH8itLsr8D9gEi9MIxS
         A7jf8H6BhhZ40TMsvH33/+IQmayGB6CRXKMV1oVpVEQbB4j7l+PqRErIj9sDGuFtCynf
         gZfUGFnVKX9LjUqJJoz24SRGUSVYxB9gs7Y6zc7GIscyKseIBa2yKn7G8vj1f3zqC2dr
         TjjXfoQ+GVF4lxgEMvh5BXCKVVS2bpkre1lbwNMy+1KrDI0UoUdofK+XMow+PIDTxoAC
         Bu+4aXyODJ4RaqelzeJJRAKlyJ3BPaKYSJkQn5g4LE316yjIMVx38DVTr9jfL8EjwYo0
         Y09Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFQzz7OOpY6pJer/6DFm7lgziMXpYmDKG9UFNL14LmhOWFYfuQgbDCDZF3TJWygrCD8zJ9XPrLbjiS+NZYOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZF07TRRkIVWdGV5M8VfGzGJxbSY/6kqvFUsFE5uwWSiB2cLR
	7mFvQXK4r08x0+0v+RXXo7fvACWEC/JkPMkjHp8DjJevb2c93uIq7uJDWKiUMw==
X-Gm-Gg: AY/fxX6EUTgLYQQyhL1gUc8NckABHZeMwW1zveFZtmO4aJUV/2npqGAFO0VFRK4V9yg
	doYQHr5T69TDHKi/kC91iVzvb48dHnYXUMb6M5NzsbkdDnxYxf7N7PTRWRgb/MtH0sosypQAhhn
	fzok5wygehE+0UmpfuB5KFf3q4a1L9jlL7tY9IuJHQtm5Odqk1VYyTY3Z3VA7hnt8Il7r9I+JMW
	eghFPpfShaSrgCs/HvR0UyFei7pLeHVh203W6H3CaUCQLJ0g357n6Re2MtPhCypfszVg60kKDTF
	8xFXH2Pbb10gu7swr5O7bwns1MGotnNT7iRXO4o2b6XXik3OJXAHMteNfO3h5Su5OzZUUpU4b/W
	isUHrhVgSucMG7zF69K5PsENau9wh4my6oN3emtwi6nOswNTSXllfrQ+EbxwMCFDLXwqXqIn9rx
	nxhm1Xi7ttqHXbZZv9J7XGvErLOMYWUk0/uy6W2wJkxRhtQPAhAOGgctbF+dw7Csm/
X-Google-Smtp-Source: AGHT+IE76r6khCk9GhD6pPYjROvDziF403oJS/8McLP7s+xvzVPzDhrbdQizx3AjhSkT2XmEvncKKQ==
X-Received: by 2002:a05:600c:840f:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d84b1895fmr274042315e9.13.1768321894647;
        Tue, 13 Jan 2026 08:31:34 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d286cdecsm31463451f8f.7.2026.01.13.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:31:33 -0800 (PST)
Date: Tue, 13 Jan 2026 16:31:33 +0000
From: Stafford Horne <shorne@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: gpio-mmio: Add opencores GPIO
Message-ID: <aWZzZWTjctHasCHh@antec>
References: <20260113161152.3688309-1-shorne@gmail.com>
 <20260113161152.3688309-2-shorne@gmail.com>
 <CAMRc=MfLqoPvCiEtunvfidaRGAfZFbGM98y8vjj8R187ziUtdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfLqoPvCiEtunvfidaRGAfZFbGM98y8vjj8R187ziUtdg@mail.gmail.com>

On Tue, Jan 13, 2026 at 05:20:28PM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 13, 2026 at 5:15 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > Add a device tree binding for the opencores GPIO controller.
> >
> > On FPGA Development boards with GPIOs the OpenRISC architecture uses the
> > opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.
> >
> > Link: https://opencores.org/projects/gpio
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Since v3:
> >  - Removed example.
> >  - Re-order this patch to be before adding compatible string to driver as per
> >    device tree binding patch rules.
> >  - Add Reviewed-by's.
> > Since v2:
> >  - Fixup (replace) patch to simply add opencores,gpio and add an example.
> >    (It was incorrect to specifying opencores,gpio with brcm,bcm6345-gpio
> >     as opencores,gpio is not the same hardware, its 8-bit vs 32-bit)
> > Since v1:
> >  - Fix schema to actually match the example.
> >
> >  Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > index ee5d5d25ae82..a8823ca65e78 100644
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
> 
> This is not a follow-up patch. Please rebase your fix on top of
> linux-next. I already have the previous patch in my tree and will not
> be rebasing the entire for-next branch.

OK, understood, I wasn't aware you would not rebase. I will rework this rebasing
on linux-next reberting my previous dt-binding: patch first.

Thanks for the clarification.

-Stafford
