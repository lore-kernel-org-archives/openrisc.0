Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0B279327
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404998; cv=none; b=fy0o5HikDZI1h8U6xyc+HfMgaGyzrkEhiGAKcElx5VeqB7z8wauw5eSdVz5lR3FoBW9baUJHJxd/yjXDlb+sqsE9NeY8yM0oXruMU3IqzT0glIYvQHZHKB2QFu3onHni60FO8p/RMml7l5Ss5k5A87iejPZ8TWuRewQu5xnhcWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404998; c=relaxed/simple;
	bh=O8YhrdqWvzZyoq4CqxqmbkpSRKVqDxU7IFcj9d6kka8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdHlVJawExi/80XjyROS+tZZfXhPRT0U9GY6OD6aI+RUGtIIkxtDgczvOIIs7ca0bMgz15UWFLMLKdR4JnWRaV54qLDLM2RNwJ6zLqwKuk7RUjMB5x7bI4PeQ8YGs1oztSxHZPF5eAqPaheQqZ4cM/NGhsnf1WrRAvEKnqM85XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-93f573ba819so3529986241.1
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404996; x=1769009796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8vpeO0iETHWaHO53ExF9TcMHcv+dXCbwCEeIoUj/6s=;
        b=CSQH0mqYLtdxWO5W/3eYu9qF/RXQfEkggBbOZLHUsTGq/7trUwk4qMVNwGCyHQlyln
         njlqSNOI0TyYu2OqYDg4O2vEiSPNdFtCPmpcWJ+//XUNnz42HxsynUH6TPcFTPpljEuh
         shMGTAbyCfvyQHKuvHpK7a5OmdnekC1yJDdbiO9kcbLBSSCyFlAFAjrcGtaiI7INaIzh
         e1AAVQfs5f1LhikYonGXGbL4d7e2q18LwBSHO4ePD8JPfE7Pf8dRi93iJ3VwnbcrcXxF
         WFfPTpAAfG4Wzza87HUGfWDkxcz7+5IrMkDs6wOKJVIWpuFzRh2X2bQEKaInUztvlFw/
         oVfA==
X-Forwarded-Encrypted: i=1; AJvYcCXsqk4h8FCMiKhHMl/sEytFcW4nwGyai5lo/LFE1Dd5U7cBwzNm+0o3GGt1/xmoDw3pyzNMAJBSj48cJ4E8Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22KoLlxPWkirHSiELyiR+Srwec76JsSeR8pbIPKmkZ0qIT/8u
	Y0xkiBKNIBQFie/tLqva2kmzdxdKVtdFTQ6vQhbhaYAL1k3XaWAlWXPitdbO7VbS
X-Gm-Gg: AY/fxX5Oteb3tJjw0ibbS2rAIpKsl/7TvjKC7XT/ysf+82RzwWvPg0uLI32qe1l8Lgd
	tdlKi93wUBm5w4HzeLrtF6SkRddPSPfaN8bKzzN3oIoLHXjLGZadierw0UKrNLsCeWtNmlAc4sD
	054468w2Alp60wt3FesiOYYCmHhUtlkMfT18Xs68oqrX5lw2yqMPr94THdaqEtVCGwL2ExaKqQo
	PLmZ7h59wxiDLlIpsqfbvum1svqNP6LGrxO0CMT8AnNSmQHIQjcooB4SzCivkOBHAeVJB/TdsCf
	+SkTLHgyT5XLxOocBy6OdEDThftg9dH6CTHBMkkp5apUvvmomWwjbAwOJ9Fkxu8GleNqS/2yOsF
	045kiP8gjr06Dp0esFZ1tD5Efx3OISo9TUiY0fs8HojzhESTH1tups79Pk9SUjZyYy4MpCcCFfD
	LStPI3g16bb+HmuqAo16BvykLex8+WW99saDLNwS9UTRL+31v7
X-Received: by 2002:a05:6102:3584:b0:5ee:a309:6684 with SMTP id ada2fe7eead31-5f1838c41f6mr768331137.10.1768404994761;
        Wed, 14 Jan 2026 07:36:34 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944121ef3fcsm22781987241.0.2026.01.14.07.36.34
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 07:36:34 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93f573ba819so3529974241.1
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:36:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYjfnVcaTMz2Y7WWfmu57pki0GJy9cJQYP24+2APaSLoRpnFnl1q79OR3wJYNaPXtLlB9qSaDi0Bl1iDDK3A==@vger.kernel.org
X-Received: by 2002:a05:6102:a49:b0:5db:f615:1819 with SMTP id
 ada2fe7eead31-5f183896f48mr869822137.3.1768404994347; Wed, 14 Jan 2026
 07:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114151328.3827992-1-shorne@gmail.com> <20260114151328.3827992-2-shorne@gmail.com>
In-Reply-To: <20260114151328.3827992-2-shorne@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Jan 2026 16:36:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdeepsCSMBrzUvhAFXj4zjA7VwRpxn+xVuZ0d1+9mTEA@mail.gmail.com>
X-Gm-Features: AZwV_QgYklX1dY-yBai_t1Hmyb0_GhAlHmkB-BntyC-t8YeO5tJVXZ8WCzYpBkQ
Message-ID: <CAMuHMdVdeepsCSMBrzUvhAFXj4zjA7VwRpxn+xVuZ0d1+9mTEA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

Thanks for your patch!

On Wed, 14 Jan 2026 at 16:14, Stafford Horne <shorne@gmail.com> wrote:
> In commit f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible
> string for opencores,gpio") we marked opencores,gpio to be allowed with
> brcm,bcm6345-gpio. This was wrong, opencores,gpio is not hardware
> equivalent to brcm,bcm6345-gpio. It has a different register map and
> is 8-bit vs braodcom which is 32-bit.  Change opencores,gpio to be a

broadcom or Broadcom

> separate compatible string for MMIO GPIO.
>
> Fixes: f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v4:
>  - New patch.
>  - Rebased old patch and rewrote commit message.

The actual patch LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
