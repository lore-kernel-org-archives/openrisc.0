Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DA500940
	for <linux-openrisc@vger.kernel.org>; Sun, 11 Jan 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149569; cv=none; b=EydCHnKCAir87blz7trOuPHcP511tKuEyvvJBgPYNoRlB6sRh448AXk6PO5w/xHFuPbf2vFGDFn9K98a8J8ip8DtLSzUnVzV6+Bd+Ogy3K9saFH6XpQXQWKaYL1O3IzbCPvcrOVyumqOt1wkbT/5VxWLO3isHudv6307kTmnuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149569; c=relaxed/simple;
	bh=eO1AVpSk59oA0tWauR5oZblvoKabzFz5L7YlptvNcJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfhPWWhbGEzjQ6CENm/AszfF6JF3IrU395g9uYEZ0CetF4tWaF5bkEtTYebaGabuDvyi3F9HFoIyb1xn5iH/3xW/uVYkGnVip7EdTIY1hV6OpKfN6lYhDBbx1MjyYHVOC0vTcJ+XW4mUmYoEJiaumgd/4+tII6zPuydQ8OMyl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKzpsGW1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKzpsGW1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso51766035e9.3
        for <linux-openrisc@vger.kernel.org>; Sun, 11 Jan 2026 08:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768149565; x=1768754365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mz2xAPMP6u2Cl+fDwJ8gf02dRfUGoZtdvzbIFlJ5LDE=;
        b=MKzpsGW1SxxSzQuLGkt5wFIfsCuNsJnpwKRoWo01nnfiJAaUedy1iNICJ7MGIxgXMW
         d7J0af0FWHKTwWwi1+EuJuijIDOqc3EqSrwx5mWyneomlxo8qh2nZqI2k8puqt8XP0f9
         4xbYYadnBvuZoPY94oMf0Z+sHEyexB0SBreldhSA6q1lCKXFbMVOpAvonhRZvllX9wVO
         CveQvoAS0MMaF05YvIN4tEMAasZv7rVshL+P5eXaDOWugxibz8QsIW+kGlqhzsZ0hhfk
         Yt0i+R828ivfexTbTDLEt2221OI/8IbgicQzh/40+5fBe/o35lGGNw7kBW49Zhz98+KX
         H7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149565; x=1768754365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz2xAPMP6u2Cl+fDwJ8gf02dRfUGoZtdvzbIFlJ5LDE=;
        b=t7FkGcPRKVu6ChDMUXdCg/LGN8tgaHS8k71emRMAny702Iu4XkAT+UcZUJAe/fkpOF
         DeOY0Co9fMpA2/5x1uwF+8PSsjlUvtW1AhxFKpPyQyVntukgDf4huTY6YHe/wtzW5HBf
         qxEe+r3gNzhk5BgVI02EoSb9T5oLQ+1I1DI2OHbytxusXJW0hfuP3dpldJ0L5qMF+WTA
         bv+zuhSg0eD8/rybtSn9FnzMg1U6OGzG+DYdJJk1SpblgdCBWlM0NurdnE54k7KHAf93
         wSoVkd6VgfMFb8EoglRIfRMhAAeU/hr6r0p+emF24Tj22rbVnKggQuZWGSRb9IK5RV3G
         y6ew==
X-Forwarded-Encrypted: i=1; AJvYcCVgX6KEiSWW9oaniyZGFD/sqTFPKUsbDNkPaDpjGrptHRhc2yU9qi0oyCZ8tsGIgG5kgqT+V5dlH/XtZ+MW1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPenJ6e0RJga0EfOKN2g/0Z5FEbk0Wgb7C6jxJKSGN/TcvNw7m
	9v9XtUWIh0AM9qAVm5GnlPPUtr+bP8IuL0pyhyJLF0SjVY6Th5Qewkf8
X-Gm-Gg: AY/fxX4CfMeppr2d2t70Pkc/bFr8Sf/5fdCz8Vmt3v2RLI5C9Dj1vILPfmTrkRYDnOp
	UoTTJI+rSzUiBziBSUUEIGZV+A9jvi4VoFqwUvEEKJxORj3xpiSaEmOXjF//8a3oZmEApmNWGM+
	fJNgmaeiq6l0hC4+uMHZBxyzaRChsCRehS6T9YdSFiEhujfbEkLlP7RkdHZnCwuiRKPiDXTcmu8
	OoQrbf7rEoRHrTo7k3hlwq/70R3naq14VcvHdtTdPyGAlZ5QRehSbTvFiRlIEBiYnZ6hE2YNoHF
	68jTuniZKu1gUkzkAMaAqYU47oHTRNuGDHUTOzGDv7cEtNR6rDsh49Cci18HkDG509D//p/fYGm
	dtZJrfJOpHrY4gEm0ENUlt8QcJbBxQ68dSj14mQ+3bTeW7PqHaJg3AsERxu6CKf+vjyRYBjIoMJ
	soCcJJM515uE4gz+DlR0lMsUC2WvZ5p23Sh4LQujdw4BC4cPZvgMPJiyB9gil3IezP3oOIm9yeu
	VM=
X-Google-Smtp-Source: AGHT+IH+Se0dgfT+MtQCblXH4IS2OIwWST/EMlxFFgfLh7CPq+K6JRpZgl78BXXKXKcha0vzJ+31AA==
X-Received: by 2002:a05:600c:3152:b0:479:1a0a:ebbe with SMTP id 5b1f17b1804b1-47d84b18db4mr180030555e9.14.1768149564984;
        Sun, 11 Jan 2026 08:39:24 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm308010895e9.13.2026.01.11.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:39:22 -0800 (PST)
Date: Sun, 11 Jan 2026 16:39:22 +0000
From: Stafford Horne <shorne@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/5] OpenRISC de0 nano single and multicore
 boards
Message-ID: <aWPSOmKD9_bePghi@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <176606559331.6520.4498279930581822500.b4-ty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176606559331.6520.4498279930581822500.b4-ty@oss.qualcomm.com>

On Thu, Dec 18, 2025 at 02:46:48PM +0100, Bartosz Golaszewski wrote:
> 
> On Wed, 17 Dec 2025 08:08:26 +0000, Stafford Horne wrote:
> > Since v1:
> >  - Use proper schema in gpio-mmio suggsted by Conor Dooley
> >  - Remove 0 clock-frequency definitions in dtsi file
> > 
> > The patches add support for OpenRISC systems running on the De0 Nano FPGA
> > development board.  We have two SoCs which are available here:
> > 
> > [...]
> 
> Tweaked the commit message a bit and applied, thanks!
> 
> [1/5] dt-bindings: Add compatible string opencores,gpio to gpio-mmio
>       commit: f48b5e8bc2e1344f588cc730082aed6ccc5a6b3e

Hi Bartosz,

After discussion [1] with Linus W and Geert U on this patch we agreed it would be
best to drop this old patch and replace with a patch to add "opencores,gpio" to
the binding and the driver.

I have sent two new patches for that.  Can you please consider dropping this
original patch from your queue and replacing with the new?

If you prefer me to post these in a different way I can do that too.

[1] https://lore.kernel.org/lkml/CAD++jLm1u9ChqsftwvbOptiG3Qo2KWxPjqN2snOVuZDYuVST5Q@mail.gmail.com/

-Stafford
