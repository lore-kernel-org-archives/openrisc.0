Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795973A7F56
	for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338968; cv=none; b=RLRG5gu5Zele43oXepzIcvmCwh5qinX8FY7m9jrjRgr2xB98OhIV23yTXXzNfoljFtFVbBnwZTqa35EUx4pV2pWAkNJQAewGZhTId6iBYZ7nBGmXf0+pZy2eVYBMMD5vhZRrOYrZHGg9gnjZXBvJl2l9d2RR8FMQz95DNaaBaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338968; c=relaxed/simple;
	bh=FSgVIzpnraycKQsxAztrNgNSM9On/XU1ftEj+pCL/gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxK9FljvwKBpamItjO9DBuEJJuq3rr3e/yXcYr3GXq+g8kFF37bNbeM/0m08BVlp678imDx7PnR1HN7tmkEq+7GH9rvVBYk0aXKDAotcj485Xo+nXVx7WAFnW19hxny5Ywp8g7FelnIi1J83eTgHejYIjhJGl61ObI/ybTEJ8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-679b072ed3aso3595935eaf.1
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 04:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338966; x=1776943766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
        b=I9Bc0tu0iY1TfvysQxexa/ds2euv7J/aGDz9pQtRCcXPBRp1p5/1TwTNpt0V8SItRP
         G68jUuM7qCqcRU2fbVnUspUeyXF62PXSOWCvHbJl9Y3VdHhgdnykFF6lSpJWKmYUUmVo
         Em/VVhVvjikPMFls0x3XYRpeCb6uid/0xxqsACT3QB8sbfUQ1yHfMs7+CCaZMlkc13Dv
         8t7yE8HyFevlOXLQXGXrRFfuxflIJTcfUfRRm1rAwEfuQ9/JDBqbnypLHKOB7xH5Ev8O
         nWoziuQx+VD4ldkQIrkJ7vcbov6rs9V3OYllV3K19DhJ6n8WwB3ZcXQ/dvVg9hpI/WIh
         bTYw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ow4RuktBOCO7sWMh9g5FGxjMSFCfF1fk4XNSTPXetLzpwBtZ5AcAAUK2J2KUICRGuQUZ4bPBEupOgA9yyig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOm51NjAozjKjF/5XpQfUTshO/URabMmj20A261ytjai0uFf/+
	kS3JR9dIMhGLQfsM1UikRPFEGu4Jg8i6r5cbaGU0N1N4WgzzaI7YvKJwiOyib8ng
X-Gm-Gg: AeBDietlp0VrX5Wvoa/t4kQQQehffTIFJGDezUnXnvjeqxPXeRmD6m0I03bdUVYzCnw
	h6QWhRLzNtDhRLAJju/5DOJSaciQ996ZM7ovqXVSDgiLpTYCzQTuZMO5/0jF5bycJ5vPy6/hdXV
	sv8wpVWUU81LjrFht6+uNaEMwqAM941HONsnFDg6HCIRLc1/4Lj9j2aVOTWBnU1oP3vc8WYHjyX
	PZfl6rhc4qHhQs55W9KQPy2aCqnfPNo9QHUxkLM30yVE2pmp/YVGIq8mA2kuCBNx7k3/ELPtViY
	UTRv7yVDB670yBdzbwdtetNWVFl8FhMK0eskVgYU6pIxHrW+uTk6cQC6R64uL2qd9Z/FHgSEjY0
	oVhQHitKITCBKsnKJjhX+iZuWV2OSrQPqOx7zd3CrKnje3qgmPAlMqifjLKZkxdNnrJvhzFbKA1
	Dqlf9Yv4J1Bi7xMpN3jSqcKcNNPidBG6vKJ9EtasTcOyyCcWnZAZORgiE5B48LjSUN7zwhYj+N8
	q1o2oDwLg==
X-Received: by 2002:a05:6820:5105:b0:684:188a:737d with SMTP id 006d021491bc7-68be85d363fmr8855520eaf.44.1776338966550;
        Thu, 16 Apr 2026 04:29:26 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4268963932esm3863652fac.11.2026.04.16.04.29.26
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:29:26 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7ebe11bffso6532448a34.0
        for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 04:29:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9q123FuSqEKLp2M5Jq0D5GLQ5jjqwvC+96fKvLTcxLGhkvle9eUFLgaWiLyt7/rUx+Mpf8X6kdiEzYozCJYg==@vger.kernel.org
X-Received: by 2002:a05:6122:788:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-56f3bca6059mr11244615e0c.9.1776338533353; Thu, 16 Apr 2026
 04:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120317.910770161@kernel.org>
In-Reply-To: <20260410120317.910770161@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
X-Gm-Features: AQROBzBwwjc8yd10cT00Tu5Dl2qrCYQStWr3Lcobhh8coMrpPeCH9vhBSNokYJk
Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
Subject: Re: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
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
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:18, Thomas Gleixner <tglx@kernel.org> wrote:
> This has been scheduled for removal more than a decade ago and the comments
> related to it have been dutifully ignored. The last dependencies are gone.
>
> Remove it along with various now empty asm/timex.h files.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h       |   15 ---------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
