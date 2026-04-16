Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269A39C018
	for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338555; cv=none; b=Yq1747a8V3uNC+cj8nNt5YmFPL9+7BAmFxzRD0ScEy2S4ciTp0kseHbEz8Y26nCRiMZJJ9cTUPqbtO8hA4MvKcDRhBMhMvzFar1zAJXPU0XAedsTc4GxwLMqRatfDsXHoyeEaeRHbD9FWrUo0Hzo/xy1kEYk0FxxswBdzDDKrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338555; c=relaxed/simple;
	bh=5RcGmn3E6IkK/4PLTUVN24XJ2jAiV11BodM4t9S5uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzEM1PoYyLGNnarVuasCd9XKucHm0k4s59AASh6Pdys2JQXOT2F8RgFv+6FJaXEttT3Q3G72fULUWMMJcpKgdGoRSwFr4nmNa+PGnh0nFvvEXYy9IAfmuE6t1yGXXey4gtkMNiRRqJRCbGNFThu6itwUVWEAR1gyzE+JpOI5Lpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-60579b9c0ccso6368713137.3
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 04:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338549; x=1776943349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=GyhMNtmItqlVYP9IY4hXltmZIejsa6dWzDXvRYcEGXwfFGaNWagcMuzoVKIj5dLrP6
         0ueFWpRofCMqto1cFg+oHVqZ/pwc8VwBv07fquUpl5nJ9fZJxX81GIqP+j2LaBPzjehw
         Ub9AIDdyPo3fL1dUjPzWWEZLcDylfuRzTzupFYsgzp6qlDThQ5f/n9PAadU0mAAR43y1
         Nre//PM5+QwzGcBla4lpjGkWOhEhy60hA4CUbaBOrEsRpYGsZX/IZ+XUR9aaNbl+01Xx
         ukR2y1LmnGM7S48qegCY2tZKNXLr0ZX23j/SNfzKGOU9bt/pcnevP55X2CtaH2l7hNwa
         3LjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UNRZ+EFsmYwJsC46rknf115Qi00Era/8gB3tlGbXiu99EimY6M4phf6LijSPvX84zTS68+dsI/gV98QqRag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGo6TfzOQL/MDP9RgZqzekFAcakZ5Rzea3PxKe2RffWEOvgO6
	r/EpD42EJp0EYC0j0bROHTd7cZl2FDJf+Lavk6PSmKqiUVOfFz3hZ7R371kRf5Ja
X-Gm-Gg: AeBDiesMuBRoRrDY2AIBFAvQ8v2F7lJtsAXdaGqNvHFqiH6T79DTM5nn2FyjMhz1M8Y
	rudxvrLT5KEfzueyynoB08Qcye7dnp8vUaS7LgcRomkLCCITtcziXYYW42mRl9NHKDF8nlhhtAj
	jsf91LZ3z1s6QwhuC0XvzNkXdgqvl1JiuvgTX9voniF8QRNTQi3O0z19QlqjKJfrULfROMxHu/l
	3e4qIFWgjnKsBWsvnTR424MStofBlBSVSVjvw9pYgqGn7D8rSM1zUJaTK6HC7OzDu9MLW1uZCfo
	uZEDXIT6phCTEQc5OANi/DzSJU+4n9Dae0zFyR+GqxVHRQpd9/nAI8qBdYQ0QpBv4Mn84PUQ6dA
	HDdxq3deWFMy96f+F6driMxyrX2Db1fI9ZQtI2HHC30D2QQEcaIYYXBSO8wsLclggmwDi+lt9+E
	5SFs3wMzvmau20vuNXwVCm7G42X2v1i/Kht0kHWYZ/inoYALF7UiT1VMuPPvO9rWXAUnlLE5M=
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id ada2fe7eead31-60a0157295cmr11348140137.30.1776338548831;
        Thu, 16 Apr 2026 04:22:28 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95864f494dasm2228065241.0.2026.04.16.04.22.27
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:22:27 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-606045ef716so4243819137.0
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 04:22:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/eHbiDCie8G1cR1qQ5qrQnXzI/RYnWZwmv/jCMXMnWpdhUT2iGDMFDNBcddqPDQ8KTUt3cGK3k/EWsJwLqHQ==@vger.kernel.org
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
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
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
