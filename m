Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25538D
	for <linux-openrisc@vger.kernel.org>; Sun, 11 Jan 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149281; cv=none; b=EifHsmvf5cKKCDZrPBlAz/HMxgux+EN3jkbVsVc3PU5lGxll+pm5x/xXBlJ4l8X2zW+xt7WFu0tVsQZOpdbUErFFl0PnDycxKm3GtbzZ7Q69OiDMuK2FkahKIQrY2ELEjwIavkOI/bvDHjKo2m8rJQJ4GcVpiPfI75/YCIHor9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149281; c=relaxed/simple;
	bh=F+U56dSbf7Zy+QbKFDejhjPm0vpdjDs41/JBQT0YeyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etDK83mOb8qsS97bFJNepzTGJl+mYgRqwfKyWcixmtS5eEwosjIEU6M3tw2mVcOcNR4vdn1Q1N1skVGDUGZQtel/qP2ZkwHNho5wr9u9tKgdxIlgVrNiBhs7N564o05fi3rtv06NbJBdC82TSQw2C7IMuSc2u8mKQIkD0bMPqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izhscTgG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izhscTgG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so25766985e9.2
        for <linux-openrisc@vger.kernel.org>; Sun, 11 Jan 2026 08:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768149278; x=1768754078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8q1LsrMBmg/TGb8G1+4FUjTEnWz4H6p2nQGEZCp0b4=;
        b=izhscTgGQiCwnhQ+XHOzvZXbbf8yk5vs0bWRVczqQvjg2gd7yO8m60k0m7RlSPn78U
         DBM2757kxeUTZegXhR9HwkLqMQ1zytxTnWmfspmvf6uiSNtSMo7XXasVSbes7U1CKfuz
         flC8Ynt5LAgh++SFRMgUYh3yNNRjhZzg11oOIntF9z7o9MWfAmJjq4Q3hE79/sL/av7w
         Jk4Caot698DtgqnGvbPBA2ISw29/FwsMRmaLzWtvDxyv1Pklu4BcppKtPkTHLTSwjNY6
         4O3vsCwCk/BxTrumVNeS5UPZz38QB34MvqUDoOpUwWevb3+y5TPtq9WPEToR1lhoDCTW
         0afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149278; x=1768754078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8q1LsrMBmg/TGb8G1+4FUjTEnWz4H6p2nQGEZCp0b4=;
        b=Cy4oYsTjcXC7Wudjf5C8reWQ/1I/JF6wD+pCfS4u2pZXEptk7M1as54J/y/WKGL8Na
         gv5TdeknRHrY9DbLZrNTGunnqGGDZEzz9T6OoLxySCNiv12Ncin+QPx/mWIIqxeWrBku
         VPaZo890ihNm/DM2XgUV94Glkc1lvSLRZwYeS1uQN8bQro4CYrrolLkT52fx2Aevyggk
         QkA3XpXD86botu7I98Hd+qbH3mncBcPN8gE5jJ2Pp3Dv5doXpCOPb9Dmq0IVcVxhG6mg
         KyEYa+y1vrj2ojw4lAoQ6MGGU7+/yY6/Oy91/7mboz0hLbXh/XJn8/Mj+nDiJFEe3O4Q
         ybMA==
X-Forwarded-Encrypted: i=1; AJvYcCX+BRCKZ3DSpiVqff68NYt3gnXw6bh+qVU8+uP5THqsDQNjR0+4UUis/VuNhYCzD4rjqvI3Ips9vQ6BnThAJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIJ+WV3mutECQ++KTUOytTRNx7WgD14WBYtay8t3MFmVZgzEu
	41f8YE6TzqMMy+o+aquMeJxqnbpd/D8CCr/OO1jP85JCDoPc9QGtrao3
X-Gm-Gg: AY/fxX4IPMorGvZnCA2pKHFcXYI7MRCvnWY++fnA8+7fWKUKyZfICO93SUSTqF6MhcU
	baM8O6YAIXKDEnzaffXDYabD+9bT+GGjEZCAef1w6XRpojpl0IOInX7dKzO/cIVFXKRbzAcqRVR
	FXeLYVG89IBZ204eAdHBfwsRkbMlH+F3boPPI21Ag360cyHLjxf/oK8uVTIHboXVoJPXStRVAhX
	bPZYX4KTEYxdXkIpy2RIDNhEywl7N6TRHlPsA7Zlh4QkKa2qYLbS8FLd5PFLSTBDP2uCp3jWevD
	meb4Bgk29jdfCD0LjDVaVSKzGIH3nfcB91Jdh1W1wmKAdqmNO0fI6B+EJXleEcXOHwx2/RRtbmS
	g62k9opWsNuGtZ2LrmsxJmRc+d1mov3d9DpmIv1OawEwSd9LE8GpbEGe7oljsgPWA1q5Mi0aisN
	OfduIvoZ0laeejYDlYGbnDsPVNEbE77pS2w+eJShEFyRe+SsJW8YBYOebt5KZI1HKiVxBcOnU90
	oE=
X-Google-Smtp-Source: AGHT+IFYvLDVG9dfmgUfUU3OGeAq3xGgS7rQ4R72Ej+LSG+5Vt262FuiLPk/JG1Eub29aEzaeex3eA==
X-Received: by 2002:a05:600c:4713:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47d84b5b43dmr200425195e9.30.1768149277862;
        Sun, 11 Jan 2026 08:34:37 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f0cf2sm109933435e9.3.2026.01.11.08.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:34:36 -0800 (PST)
Date: Sun, 11 Jan 2026 16:34:36 +0000
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
Message-ID: <aWPRHHhdjGE2f8aT@antec>
References: <20260109134409.2153333-1-shorne@gmail.com>
 <20260109134409.2153333-3-shorne@gmail.com>
 <20260111-amorphous-cow-of-stamina-6f2720@quoll>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111-amorphous-cow-of-stamina-6f2720@quoll>

On Sun, Jan 11, 2026 at 11:20:38AM +0100, Krzysztof Kozlowski wrote:
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
> > Since v1:
> >  - Fix schema to actually match the example.
> > 
> >  Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> This does not even apply now. Your previous version was applied almost
> one month before and you WERE notified about it.
> 
> Why did you ignore Bartosz's reply?

Hi Krzysztof,

Sorry for the confusion, we discussed [1] this patch in the last Series with Geert
and Linus W. We decided to Fixup (replace) the original patch with this and a
patch to the GPIO MMIO driver instead.  I pointed it out in the cover letter but
it may have not been clear.

I will reply to Bartosz's original mail too so he can understand the intent.

[1] https://lore.kernel.org/lkml/CAD++jLm1u9ChqsftwvbOptiG3Qo2KWxPjqN2snOVuZDYuVST5Q@mail.gmail.com/

-Stafford
