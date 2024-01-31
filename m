Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE4524DF
	for <linux-openrisc@vger.kernel.org>; Wed, 31 Jan 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686675; cv=none; b=iotoPtBjsHgvkMd00bEGtvs6/zDo4K4YJ2ZCM1NTQmAVf2Nr32cc5QI/hmtF8gQJJ17+N2jZuC2z/FFIj0VOUa8VNRVwFuNEmlQC/+mQbZ+Gjmzyb6ptfucRVoXSF5mvh8bITYhas7sxhlmH7nsvRv9cMcU0CaeOt6hgXk6rDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686675; c=relaxed/simple;
	bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjpir74ZXkMz3CJCak0VJ+GLJ8ccjrhuZ3CvfBcDH3S52K5aOmv/nWvVieIFmIrYkfCxXNQbDNEv9uec6uI7apA4pQUxhyyyjWok8dQtA+z1zZOocCSg7LtzBVXqLENTsIMORcWtsjAb2hXbt3lJn9Qv2StnmaGfWmkobzBlDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qugRA3lU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qugRA3lU"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-603fdc46852so9783257b3.2
        for <linux-openrisc@vger.kernel.org>; Tue, 30 Jan 2024 23:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686672; x=1707291472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=qugRA3lUGE+4iv2RbCrW9rOiaw+w1w3TnSsPYDomTVfsIhBg2yT8hCDktaLzV3YGPN
         WBPsoZOl2KfuIr0rENOH+XOCCEeDvC3sZczUAKUMtG7ZqIdeEaKs1yFvO/WULHi4fXYc
         QXg/hYuy920fMaLiFZcR5MURBY0NKyO505nTAXQiC2yHNPMZ2aENuRnHDJlfmFVDwVJl
         7qt9yIFqWkVfGto8L5BeZSTJ3GlnL8D6EaEgkKMbzlDnoa/G03OPi52x9soysoVd0wst
         agXaaPO1fxdI4jS0s22srNBdAFPD1+vYng+hLso2Z0EQi5ud482G+YaHuHAD5CMh49p0
         UHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686672; x=1707291472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=cJ9Zz1w6Znr71mQRvQz/QGzqp3DoiDDRaYFKQcnQrS4+jPIHvEKnOMyvynV2hMUpcI
         hbiNDLiA4rUbjsSdcQ3d1l1M/zmW31irHlQnwD2lt7huLf2MBio2l/J9fvF8KECrvH9r
         AuPTr9rhRrDXaKEfqcYWiwUpVVTpHaZuYOHxNumMbj8Ya4FveSNQ19Be9KqY2epZVYsh
         Z6xr32Kh6EtSKLDy8NJRXEZX3VUSqBgmExWql2hN4QZNTPWLU3ejccmp8I8VtqdvIsJG
         TLb9PeNFjzKv6KaLKfD2YUx0mipjeIAdohhPe7+ZZR9Q6PtNAWE8GKJE/aDzHeLjMi3d
         xm7g==
X-Gm-Message-State: AOJu0YwHAeIH5tjRP0Fx5mkyzXGkdWob//CUC2j+c6I4O6Zk1ncdScUw
	B+w9Q/4A02pbQ+GCOgFLWttF5CE8lG95xE0WM7BCrwe55JEW21m46+UF+dDVPxoEGVcZk71Axqg
	UHJ7T13jcG6No+kE/+yCKGVDN1txvK7ud1D0lMw==
X-Google-Smtp-Source: AGHT+IHYpXRaWLqQlh0oX2pZAjMnT3Ad18mWcU8jYVwFB0aAGnyeiCdKxqpu+uBFZ0ub/5leFryzgJhdACbtZXLSvtQ=
X-Received: by 2002:a81:c545:0:b0:5ff:a52b:55ac with SMTP id
 o5-20020a81c545000000b005ffa52b55acmr594058ywj.34.1706686672385; Tue, 30 Jan
 2024 23:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055159.2506-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 08:37:40 +0100
Message-ID: <CACRpkdY6dS_sedemVk-fGzhsyT_B5dXAeFX-PO+GcvCrt9Je5w@mail.gmail.com>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:25=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> This is a tiny fix to pfn_to_virt() for some platforms.
>
> The original implementaion of pfn_to_virt() takes PFN instead of PA as th=
e
> input to macro __va, with PAGE_SHIFT applying to the converted VA, which
> is not right under most conditions, especially when there's an offset in
> __va.

Ooops that's right, I wonder why I got it wrong.
Arithmetic made it not regress :/
Thank you so much for fixing this Yan!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Arnd: I think you can take most of them through the arch tree.

Yours,
Linus Walleij
