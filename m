Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524339D6FE
	for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338547; cv=none; b=F1qGxaDzuQ1ja5RVdFPuYW72AD8kQtRwp9WCE9Wu8L9qcan2ZFrb8TjWlMbJtaRYaxUwN8PsRy152VmH+QDAVeNTUkiXtLPR+xezG0Hz7SHpdHtU6reEYbEEUQvFyBICIgV98BwTHGEoHGwl+eUyKmppVJG05KKeA4M+MFJx0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338547; c=relaxed/simple;
	bh=onL90hyVAUlPY0ASaWQwK2lX8QEYr5m106IAfPoIE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+x9dV+gq3ES6DpWBQzxR1lLkpNy/uGRHVatDCRrNNKfEfeKnGUrAiynqPtQ+g+g6+nGV1L2RpITWkxNyOKBrWp8tfxm/2rUJOCeVuaD2eaV5jZ3VrqSfzv4BI++GxtIaJhlxIb+cAElFlFpc3MdySpEnDEfsy82D48cgvSQwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a9076813bso3732746e0c.3
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 04:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338542; x=1776943342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=bJhJHQ4iz9x0ox04/hWsrnFB58Wzu2FDB1Iru2Oto4V7hGh/Bu5FjA1745cSiIpUtS
         ZtELDSRpjStkgOdv0v0A3eSCbVeh56WHVNJXIbBu6PveCeB4LkVp5FQPMjcyu2cgn9v2
         O31wpqDuu/bh3Cu2nisshgRYiUuEC1EpAhc9Agbbnhu2OrqyXmCI/lwsJ0Ri/JoXS9PW
         Mwf9ZNjxl9JEO2yX9V76cg/7gPfBayTuAnuKuS8I4ERnqaaVHEJA6Co4Ga6pc8AX63r0
         cSh0nSmcOVoM18LYGcdMwvmU6GN8dIWNyC+WjIhkEDCA7YejQhwc0ttDp0Lfarpmdx/Q
         jzag==
X-Forwarded-Encrypted: i=1; AFNElJ/if9tOAkbvK/qqbB/4xx694rTH5Cte1/YX096AEnwfvRHS+regzKBWbXzlC2vz0/yKnZUqVmV05UuTMh0X0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKZMvT63xnJcDWgDIeLiYEksMVjquneRoSM6GrKR/Y7KqYIzR
	gEm5FCkh0xIfTK3SaTNrgKji1oj7VmYTxTY6l5moxC5jcNOHx+S3NucNVgP1zHJ8
X-Gm-Gg: AeBDievNfFy6dusXIcr8MnZUz4yyy4t+jSW6JKh9S90Gp1qQgY03PbRmTVfZruA19Lc
	WcS33pthOrrrmVFAjUV4lGi01RqywV5pLiv477Hwvcwqjtuu4S23Welx6OL7rPD1CCSPvoNwe4K
	aBY42cr51rQyCV6gGLLje7DASzXajBOwATR2whMZkEKkJiQEQ/nIzAydqbPek/BJEnwJkkTCNSB
	5/m6V5P17TW7YX/eUSbPbRQYb5sBA3A6sLrfKOL8ayL66+Ry7gsDKy6OktqklbJQ2sWA5bcprM5
	AymSgstg+aU4p2Bq+gpV2WVj9a3BKyT/nWCRGuL+n+GI+MKMfxpwDjgbH4gAh0aKG5Da3FP1Xdq
	4ABo69ah7v5PAPsg2cmKMQ6N88/Vw5JJNiFBfxhE019YODC4pmUbVVB4tzVMxivYg15Xodk7xFX
	j10FtRK2Ak1MUP4TcUgl0lnbs/hsFXjV2NnhFfX8ueWMpbYCM0yO1I8TuMxFmhCbauTqZMumM=
X-Received: by 2002:a05:6122:2a56:b0:56e:f262:910f with SMTP id 71dfb90a1353d-56f3bb287c6mr12549449e0c.3.1776338542438;
        Thu, 16 Apr 2026 04:22:22 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89e282d9sm2769600e0c.7.2026.04.16.04.22.21
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:22:21 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-605def5b807so2371318137.3
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 04:22:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9bqTulF8LTrYHajUt+KWVH/7G4jXFCwZfEiZJlB7hGsAWtXmWQc6Ji07HGHBcnchtY5fZ7Kdam6VZx3lXbsw==@vger.kernel.org
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
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

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
