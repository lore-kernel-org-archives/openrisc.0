Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61030392838
	for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335543; cv=none; b=n88W21vF+gxfv69nGH/Mwuw0Gx20/3b7dh9FVLESBaUry6oLqBUieDK2JJb/cnuDEBaQLK12dykKJ6ieHjRm7u0PBO422aNaDdJSB779e5bQvjH8d9jIhzG6TZTIM3Gd7xNDAHMW+qVhapEmsFXSkQ0v7W3XhJIFGjh9L2jUfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335543; c=relaxed/simple;
	bh=Il5EilNKbQmVM1qv4XgxLAe02Z9+zxydkwUqJc2BPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ92GQDI+0NuJAL7GD99xuAeTjZXETYpn/yHNF8LrvxR0XujpXKzCVwZTf/6PBAiAGwczz1j860RwCEV4QRlY3EcvdGtJBuwkKOcBOaJIWeQn7OHNBTgxYV/RATc6P/yMdIIQ5/Ujs0TrnoFhM+NVbLoQwHYD5PHIAnJUT3a6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-409de4132b5so4997220fac.1
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 03:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335541; x=1776940341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
        b=Jl0PFrReDQ4b0Y3VwojbjdYLUV8VgVxMz9Xw7MtJ6TsGhuVippHaRsQIlYQb+ed4MZ
         2t13d83hlqz213FeUP1yo2OSEsd0q1hXCkTYHwrMkClfDRqPKYprqXsmYwJXeqsnv42T
         gTeExJUbHojfB31n2HTpxLnk6UjumKCA40+ASJoUp5XCqR9dHUYcHCPOGh4p4yHSnr4N
         T7m4dS4M102RrFGIQwTzmsveS7PQj0oJeiIM+h4CuXDEwMW2DPqCR6RC8ZpDDKUmOXA+
         YlIIePT50HE1VzQSC+9hxVGrgxm7Kgl2ojRLj7ehOZnLmbqhtQ8+SE2SCuQYKvM9o4cM
         XBRg==
X-Forwarded-Encrypted: i=1; AFNElJ+L3TEz8ttmwrhikSsxM519AsjmmMt3TBQc5AHywbIRnWbLlmpDkHAzunYUjzylAlLSZnlef8vUJy30a3avJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1UKoKIyVBWi0aoh0R9iNbkFET0UQO+uMzwpvXuRK9RRKArLs+
	df64PCJVisTRaJhv52EMCoHY28v9PxBi44RzYtJGVCQhQzbw5k1OJzpoPIqk3FVp
X-Gm-Gg: AeBDies2rJdYFZ/g5WX1IFv8gYDMmSACUHc5jFq8QQTSgQNtQpsrwjiSStb7Y3cc7CB
	ixXeggF1ypUZ2xf6lCU8ysbbAexVmhMiJX1spaVj7/sZeJhwoBVjLx6hWTUqDJ5kcIGsWpSD2Sh
	7xgsLmjZBqp95hyjcDV9M1pK3NIcYA6Egiqm7OzhxoSf0eofV1pGbO4WOrshsVy4VL5xHEov9Bz
	tg2SSz1SuQ9kmFE2OoKnsE8tNrifA7diGgUaMelu5czSh+TE/av3gx5P10Bl3DU/A3pC8buqiVR
	vbt2PuOWMUabGOjGDcyiirWZXGQx2dE5G1oCo4nYjgfxBoClE1QvDf2tqG9ICqzunKj+uFkA3H/
	meQODLNIfFSvP9Vdkyj2CeBZMnmwQZblbgEG3fFUqrGsquh+1hPcFCmg8N5Ua+L0+fskzZhWcRI
	QFdvF1W0T78FeMxuxYN3QN6uslhVWNl80q05fXiLqgp3G/bI0EE8lu1aouVJXlZSWrNa1nEYtlp
	QHmFV53bA==
X-Received: by 2002:a05:6870:240e:b0:40e:dcc9:c3a9 with SMTP id 586e51a60fabf-423e0e5d316mr13061980fac.3.1776335541274;
        Thu, 16 Apr 2026 03:32:21 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4268963d70esm3553875fac.9.2026.04.16.03.32.20
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:32:21 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7ebe11bffso6493984a34.0
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 03:32:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/8IFou9CFOLTd2JKeI6BHRM+UpK6oVn2dMyyXavi6Opcg3I4aYqiYdVF7E9jiVyFpexGu0PbPlCiHAJYcjJA==@vger.kernel.org
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr11966750137.3.1776335071251; Thu, 16 Apr 2026
 03:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.794680738@kernel.org>
In-Reply-To: <20260410120318.794680738@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
X-Gm-Features: AQROBzDRGGELVSySTko37h6zEj8YoV3p6pwZDCVQUlUW6sZbw_W5mbJzFIh35nQ
Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
Subject: Re: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> get_cycles() is the historical access to a fine grained time source, but it
> is a suboptimal choice for two reasons:
>
>    - get_cycles() is not guaranteed to be supported and functional on all
>      systems/platforms. If not supported or not functional it returns 0,
>      which makes benchmarking moot.
>
>    - get_cycles() returns the raw counter value of whatever the
>      architecture platform provides. The original x86 Time Stamp Counter
>      (TSC) was despite its name tied to the actual CPU core frequency.
>      That's not longer the case. So the counter value is only meaningful
>      when the CPU operates at the same frequency as the TSC or the value is
>      adjusted to the actual CPU frequency. Other architectures and
>      platforms provide similar disjunct counters via get_cycles(), so the
>      result is operations per BOGO-cycles, which is not really meaningful.
>
> Use ktime_get() instead which provides nanosecond timestamps with the
> granularity of the underlying hardware counter, which is not different to
> the variety of get_cycles() implementations.
>
> This provides at least understandable metrics, i.e. operations/nanoseconds,
> and is available on all platforms. As with get_cycles() the result might
> have to be put into relation with the CPU operating frequency, but that's
> not any different.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Thanks for your patch!

> --- a/lib/interval_tree_test.c
> +++ b/lib/interval_tree_test.c
> @@ -65,13 +65,13 @@ static void init(void)
>  static int basic_check(void)
>  {
>         int i, j;
> -       cycles_t time1, time2, time;
> +       ktime_t time1, time2, time;
>
>         printk(KERN_ALERT "interval tree insert/remove");
>
>         init();
>
> -       time1 = get_cycles();
> +       time1 = ktime_get();
>
>         for (i = 0; i < perf_loops; i++) {
>                 for (j = 0; j < nnodes; j++)
> @@ -80,11 +80,11 @@ static int basic_check(void)
>                         interval_tree_remove(nodes + j, &root);
>         }
>
> -       time2 = get_cycles();
> +       time2 = ktime_get();
>         time = time2 - time1;
>
>         time = div_u64(time, perf_loops);
> -       printk(" -> %llu cycles\n", (unsigned long long)time);
> +       printk(" -> %llu nsecs\n", (unsigned long long)time);

While cycles_t was unsigned long or long long, ktime_t is always s64,
so "%lld", and the cast can be dropped (everywhere).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
