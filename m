Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53F7E572
	for <linux-openrisc@vger.kernel.org>; Thu, 29 Feb 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213689; cv=none; b=Z3Lj9HdT0HWTsiE5HDk5Zs89KMLckWxLaqqJUpXBMK4P4o1kWogzOP7cFaMRLv6qonbmiaBhrXj6oHPNL/lBsP2/GgCV4ZRtUob0OdODMtFJHX/C7JBy7Z8xGxV9Ich6937xKHkDdQxNM8240lrmC4N9WeLa67j8Ew1P5oEdYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213689; c=relaxed/simple;
	bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJDCbwECg02LRYtKnGtw6awGZp2wi0AiqY9BeRBJWD7AqW9Cb6MDCFLyqKJM1LFILMuP8YEkCwN7OFbPs0hW7g79SWdtyL9r0fbQGziKst6J7LyzUn5aAUVgm1frK90Hp34iW9ITU57wtmNzatPvTwlMe7InQdegaX/eMg+WYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYTHdjbe; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYTHdjbe"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso934016276.2
        for <linux-openrisc@vger.kernel.org>; Thu, 29 Feb 2024 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709213687; x=1709818487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=rYTHdjbepJHMdVjx9Imtk329wSoXnJZBxYtV726m28GV/V7gkGQXPfFJS2NlI0S+Z3
         pXj8RmkMOPs3Jb8OVqphW3Napgbwm1MIUNERMqYj4NC7ltvi8pWlz+H7gayZ6OINuFIs
         2OVx+oS+NV3eE2ZEX02/Rm9ABRCLur7+SmPKQ9hKv4p7d2wFX/CJXyoayu9c+vgIBTzW
         8wK5fPlhwVYHyYN2E86WCIwXywoAeodSrA5Fseo5fERoN2K9XEyGZOQw5KPl57WMELqa
         EfxraAKLsT0oNEysbw6hjhZJblor543ZwdklXGAAb1Tl4oYZgENGAgeCEVQK+lmfcI54
         1h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709213687; x=1709818487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTfLJyTcpdwpsuN8unpr2XZZEd0IJSDdAW3OCgpy0zE=;
        b=SnC+swgesUhEOMitWVicBzRfec4f5Ts79GQxwj3Xx6KhbkaUGZ8jofiqVHdhLYJKUF
         Q02RZf9gkWPQXXsgom7WWSI6NxIMzfdla0ywltSXNWlTUr8zwyM2riJFtclEjMgaaweL
         wxobg31PyyQswYBtXhbHZyIjoA5cO/0bLbWLmdAJ0SadKZropdAlZJ1I5QzvO/HdqqpP
         6kAgSOU3nnpWcTnyUHZSH2+K8SVE6Ytl+5dkKCqq0mkMai1yrCx4wHfJbZJ9Qwuryqei
         WaBYfunsZ8r/8yClLtH54lMq4fgkkFM8vfW/v6aj3Z4/DT9WKO2FOk/pzYN7Cro4D5yr
         gaTw==
X-Forwarded-Encrypted: i=1; AJvYcCWzoO8gzDhDtLvMjG6DbnCVHLx7ozyJu43doZmQcGultrL2MGWQ/XI57IsAD7Rh+GiWrDSAwaFGxNaT6tg5yJs53hNJE9HOH1gieCj3oKs=
X-Gm-Message-State: AOJu0YyhASlQFHi1nSVz5DoC7HjzYB8RNaD0oHLM9szevsKP5/FhWdGA
	VqhsykkVhhF3wmUHq2e/tulMCfeK19SbgGzsuBKoqgxmLLnUR9Tq7Iu13LY7fsgqCTmKXCpEM7o
	huoPftOy8VL8mmW/oP7uCySQ/hmZ7k6OHj6ksag==
X-Google-Smtp-Source: AGHT+IERWkObLg20g5CkQl+tvX5B3XTQSnYQFzXQbIMveAsaz3h9XahcBzBqENPTvOu/rO9KsYEoYLjXlY8xXBwHNlw=
X-Received: by 2002:a25:a347:0:b0:dcf:b5ba:1403 with SMTP id
 d65-20020a25a347000000b00dcfb5ba1403mr2165256ybi.6.1709213686916; Thu, 29 Feb
 2024 05:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com> <20240131055740.2579-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055740.2579-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:34:35 +0100
Message-ID: <CACRpkdZ_XUmW__y=8R3aJkci+h-pHRh8-xH7ZmfRyQ=jjCbajw@mail.gmail.com>
Subject: Re: [PATCH 1/4] asm-generic/page.h: apply page shift to PFN instead
 of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:27=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> Apply the page shift to PFN to get physical address for final VA.
> The macro __va should take physical address instead of PFN as input.
>
> Fixes: 2d78057f0dd4 ("asm-generic/page.h: Make pfn accessors static inlin=
es")
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

My bug, obviously. :(
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I thought this was already applied with the other fixes, but maybe it
was missed?

Yours,
Linus Walleij
