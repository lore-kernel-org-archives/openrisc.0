Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB339E6F9
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405703; cv=none; b=SuWfdA5dF4bIstb29/K7yPSXExWnB0CV1r0HwTrTABwEOvtyrHrGxpZn0HqL/SUKlubaxScStG7UiL6eyXPujNvJeuntzA5gB4ohkfttwpXlAEQe4g3wIiMU5QazuUFInGPh7qrNbKoK/Th9KKwFXGpHIJ3/GxbVI0kETH79v44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405703; c=relaxed/simple;
	bh=TV16ywr+bfqMRUG+Xsz04+A0GSeKmtLKO0S6DHFq7/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgHHn7Vj4c97vCnmCJUhMzsgi0h6ZJcC96ysOLhwfI1Tb4DQLTcXrhOKp4Fn1F5YV7uMwPsCFR/qEBhITIaRoigEE2Dwr7l6VKIGRBndqSEevnuUHESOx+fv+IwmHPl6qY1I2n1+Uypjj7kLMwfC2zQ197Jl/RCzfi3CREAJgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXdQ6Na/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXdQ6Na/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327555464cso5284228f8f.1
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405700; x=1769010500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyUFd+fTAc4ItpNI6LyTbMTp3pSM+0F1/ggxvGiRT80=;
        b=VXdQ6Na//JAjO0Bj2wV5/8u1/ovQ9LPEO+GPMLWJPZ0x3ytO2dVDwlnj9PIbBcbkhN
         toEqCass/R8zl2pG3MCeoYeYF06KaHAK7Fxd5i39iGrhtu5rXCidz2WkfXiJQrLwKDQA
         QS2Ev1LDCKXrG3bQe1KegDvWdYNVpJFJ+CQrtz1fsD0iV4vyY73KG0PbJUhoRa4o5LRk
         PARaPyPyz5hHeHmAFgSB/3s6zHAXbu55xKQaaAGZV7hRHt0EmUkCYOpP/UnQtSm+b/2Q
         ORD4URLgynf00igZya4lvROfMshk1BNKhGjYKLWGJ1/ShrWHwY/601vkBo6XXYPaJYcy
         J35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405700; x=1769010500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyUFd+fTAc4ItpNI6LyTbMTp3pSM+0F1/ggxvGiRT80=;
        b=HJIzpoDFK/V89/TtUkkghNYp/iAPKVjev4zYqicOyl2Al6keMwDQRdAlZ/RJSutgyb
         POx9YN5wEntDtUf8Va5QSEYispd2xVrANnxf3K/Fy1N6BRrVfXvlK33iUApMI8uY6NIk
         txDfRlIPOrmrdT3iDlxqOKl4mAd/PgWN/6H8vKix6pDVOo4YyT5++Q7xsDU9k+lWTo4I
         jcq76j5bFXEBJJDrLyNdeZx5JFSg2ZVhh2seUB1WSbjSdAM5wwHRcvFDhN17yt+gXsPB
         MnTkJgk3/oLTmceqQcMIkvoTiaXVPgsNzVjdJUKGR5taleIsKpQGFBtpKdysaHsDTfCk
         /wtg==
X-Forwarded-Encrypted: i=1; AJvYcCXCqTXfjxJ+ddp3h6XGM6l5Mcpufc3T+6xpoJaSbCB+uHiUaJKrQxQ2vWV2RgVBqQ4k1sUHSV3fpdf/CSi1Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DgO9wyf+gcVj5JjBwcQEEVQsaS8h+jKeg2PqTzmscp99rRDr
	W8liCc11dllAim3PzJdCPFz8LrmoO4wMRsbRkY9qNufa+ZsmRprijeSK
X-Gm-Gg: AY/fxX71Y+kQEN1GkiYkZuE6KmWza7UYWeZ5qPFEDYKte7cxzqT+xjHuK/pDrDps4OH
	d1PG17d7fHcLNmxsfiCmvd89v3rzE4SW67yyR7dJoPgP2qq4MuBgN5cG+wzZW64hmOG31wyFsu6
	Hr+hmnpnE7VmH0107VJ+rNF75mGUMNuSm8HpJX1kqjMFsVSYeq3W+OC+T1bGYhsuaqmAa7NzyPA
	evJ213WOcsEKlh7WpFQO4G/O8IXUeJjblXzz/uGYLA4E0Y+XMGHVikxbu5pQ1Kq1wqqINSNxNaa
	TR4f0mFT5UIBJoF4zPgX3fqLqwkP8LfZ1X0Api/KpGpNo9tSi70iNKm0IsdobGsf7mXJxfIFvu3
	bt0bwvcTO1jWDI/dWzvvmxycu40mlXt1NSXMIMS7RU/m1x98FlXhES8OZwlvHcz0TfORcsiYT+s
	v/rakt/Fk0aUwY8ZI5xMUJEA7EAzYeZDxIcB9fWsyZt5tlnjC+rUGi3Dx9hN9sfP+e
X-Received: by 2002:a5d:5d07:0:b0:430:fd9f:e705 with SMTP id ffacd0b85a97d-4342c500124mr4391028f8f.27.1768405700354;
        Wed, 14 Jan 2026 07:48:20 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a671sm16216f8f.9.2026.01.14.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:48:19 -0800 (PST)
Date: Wed, 14 Jan 2026 15:48:18 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
Message-ID: <aWe6wsho70kEXirE@antec>
References: <20260114151328.3827992-1-shorne@gmail.com>
 <20260114151328.3827992-2-shorne@gmail.com>
 <CAMuHMdVdeepsCSMBrzUvhAFXj4zjA7VwRpxn+xVuZ0d1+9mTEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVdeepsCSMBrzUvhAFXj4zjA7VwRpxn+xVuZ0d1+9mTEA@mail.gmail.com>

On Wed, Jan 14, 2026 at 04:36:23PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> Thanks for your patch!
> 
> On Wed, 14 Jan 2026 at 16:14, Stafford Horne <shorne@gmail.com> wrote:
> > In commit f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible
> > string for opencores,gpio") we marked opencores,gpio to be allowed with
> > brcm,bcm6345-gpio. This was wrong, opencores,gpio is not hardware
> > equivalent to brcm,bcm6345-gpio. It has a different register map and
> > is 8-bit vs braodcom which is 32-bit.  Change opencores,gpio to be a
> 
> broadcom or Broadcom

Right, thanks for spotting this.

> > separate compatible string for MMIO GPIO.
> >
> > Fixes: f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Since v4:
> >  - New patch.
> >  - Rebased old patch and rewrote commit message.
> 
> The actual patch LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks.

-Stafford
