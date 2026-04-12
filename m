Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF837C912
	for <linux-openrisc@vger.kernel.org>; Sun, 12 Apr 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000188; cv=pass; b=uGgObcU298rnjOgbiE8YI7NiqTvzBJrwkf9BcBcAHrNhPWgZGLR7DdI8MbGSx3jrVPFZliXl4fdUAb5V3h8lkajwsZD4VccvM7XHmIhKv611roObz3pbruGUJFlcmKVk7ebniYkbV5xZsDYxnS6oGyE9JPBWwFZJO41AtEomce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000188; c=relaxed/simple;
	bh=1p6x7PvyQL+5PGqdAnx23TY8v0cVXdqCOnUZdmPD2Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3G1bkxJCBx6Jzb5/KUJVDWxGskEy49ReyW5OARjycUHa9TI+PRt+rVvwFGsDxrvbZgS59LspWYDk/aKxaBwsZqxUvCTT8TCDoY7Pq36P2OmcP+RrWmDqyDxYz72spiDMJYXbhu777txFnUsdbkqdDRC6QRHrJh1TvRqg1W35pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccArJm9; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccArJm9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b97f9587e6eso465135366b.3
        for <linux-openrisc@vger.kernel.org>; Sun, 12 Apr 2026 06:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000183; cv=none;
        d=google.com; s=arc-20240605;
        b=fZ4HXN7WEA18qFcUuMP7x2zxVAs9r6Eozu2j2Yk9ux5PPR32MTSbVt18CnvmHhhpyB
         IbcxhHImAciC16FEZBLu8W7/vJHIakW+Z2qUrSIF9Xi2Llc5H9PrpaRH6PnDcTRdxwKt
         e7bZ+F37329Kz9R51EJdROJpNKqZ2ZuGy2MDLrBUfXlgvuJ8WAbVwZzmAse6gDWwvnxL
         M7XWdyXMVwnFClnLE/SXD6S6SBoXdN+qNSs0dT8MoWtnRZxImuMLB+TdHR8NAzcq8qBE
         D099A+vpv8pMHReK3W9nJN+oC2I8j2fvIurJUH3d6cr4SfS7b5dPM3HAJvV7NXy0EgM5
         kXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        fh=RawgSfuDEmRa2WJzdoe+kEQnrnj54pWac+QZBxW/CZo=;
        b=gIorwIXUd9HUtdG0TXi80uGV4mKn431/gEwBeTIeDnn1Y8rW3Quko9LeNYT+N+KDxQ
         lnkumduT3RS9WS8ZPlgL6nezUNr1/asQg2btYgDaOjRppPog5JHwz9qOwHkeKhjpoZNN
         b1c5wPrI7wxP+ZLlJ78mSoq5X+6ABoWF5v84vNuD6UxCeeglYi2jTxLaPIjYmUzysb6c
         f2G+XXh4MDO+ZZUe14CskRQbhwCRhXLFoo3+F/NasMCZ/xon7VYd8CbYr/mFQNlNBKQn
         BkPpLuJbivPX/oBC1f6rK/6ZY98xqY8OVNvlYUpVOFs+OIf6X5B9sFZ7ObeFxlKGFoVa
         65vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000183; x=1776604983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=dccArJm9v6h9Fdk8lDGNWZnQG14AQ9ZokHDnv7DAL1GW0R6BDoMR0waR0wHnO++sNY
         YJPJSDf/Eo4Jqw4GQ8Gz/T/rsLkNap5uTZ+EpwANfeQ1dFGXyG88+fN/49+h4JvC9C7c
         2+asFn0yzVsL4n2hJqrH+GINWtCINsNrMCDz6yHqeLWKks0EsNy7ssNes4vhdFLCd+tg
         k2Ys2/EuxonOOeyCkSNs/L20e6zSdmHhXIY25hzHxXat+VjZowRiCo0VNk9bdjlPvxYt
         DV9owUMCQ8VWv/4Ldm8HtUCj9QQlhYJyZr8JnJBv87EbzYIfO7KpnQu2sRPezsHrfV9J
         1U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000183; x=1776604983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=gkl9F+IRYv4v/SbCS4kemNXU6F3NzVe8GS+pZ2Cul8GBA1JVgMKlVSL8KfJSqtWtKc
         m+PLSl2tm9ILOODQmjxj3Ai80XYqYNFafytDNRakL6pHfSKrId8cU7Z3u0hgwCemmX6s
         nGQP9DyGMOPAWsSAxFzJzyFf9oy3OkYMGoFn5MBxI0y++/wCxjHQaCnjYhfKDRcjWn4T
         3UO6byGxFuLyxy3zxrHSNmH3pBJWGQdjaAMGjgHSPHjXzY75gNsRey5MJshmHhRdeBpw
         V0YDFOgOa9vaiCLgV7u2YdKwiMncmPMWMfQv9IY6/aMSCLAHKZrVmln+hez53Graw3tr
         l3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLroqmoU2frYB5PAcdg7lkkk2kHJbcZpT260xMJKzle2Aci/vXErYn1UhijzvCwX1tOgIKawygh5SQ6JeyoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXFmldG59x0uMoESD9pFfjPGzXnZwmCMKHnOVzkqkVpRoTVX+
	qfN8LfI3g8lDjkQuga6Oo1Kuut9oWNN1AeupXQD1s1Tvdzf8TsENamPnRA5TgSVL1c+IQ8zapIS
	Hk/WMLzT2cxOx2G4QKY5abfvusuPtJP0=
X-Gm-Gg: AeBDiesEYKQnVdDbyPfysS+YIJTH5kEUYt2ZIEigFn51ghfOfJrY6p30fTd0tcYeybM
	gnudf/zp86rnk8o33TE8vQEiQX/4zjuSp07dDS/L8bLG6S+1Nt9T11UDL1x4HbGbmQcdfFWXpSd
	kTeH0rQ+bN2pOTUFfzzndL00F0vE4POrXbfEI0EWI5tAc3jBsJWXnVaW9S6LssvAOO03AgCznz8
	lpXHo7NNK0JYGsSifnmBOPL0I4BJBgXEEfZGi38KuYvF8vE8lfdyq+fZLr6mhVcnOJWoioMTeu5
	aXyVkEy5OTLMeueei/mz1v15KFBw5fGfG6uj7Sw/
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr352963766b.25.1776000183133; Sun, 12 Apr 2026
 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.131582521@kernel.org>
In-Reply-To: <20260410120319.131582521@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 12 Apr 2026 15:22:51 +0200
X-Gm-Features: AQROBzAeMsaeSVePCJ__tEd4f2rWAY6MixXzp_fii2b8vyUpLt4xjSbtYzENFaw
Message-ID: <CA+=Fv5S68wZQapeaYTspOfsuGk=nBj60sx-ojHBSqrxV59Q+ZA@mail.gmail.com>
Subject: Re: [patch 23/38] alpha: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:36=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch alpha over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/Kconfig              |    1 +
>  arch/alpha/include/asm/random.h |   14 ++++++++++++++
>  arch/alpha/include/asm/timex.h  |   26 --------------------------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Hi,

The Alpha side looks fine to me.

I've applied this patch on top of v7.0-rc7, built a kernel successfully,
boot-tested it on an Alpha UP2000+ (SMP) without issues.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
