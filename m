Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A803FC5B9
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jul 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586535; cv=none; b=k8mauFVx5sIU7ILlkVg7OZA9HifK6o5pdlgjwpSQRlpyfZSrEqZoIjgdiSG70ujCTnqpJ54cPFlCS2VC07Q/1euWRaesps4cVbuQ/vscpP9PQOC2PijIx0R56SXEQyahio+tnbkbIlPVzu84nzAoThNSxA+acqB/MS13Gy3mYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586535; c=relaxed/simple;
	bh=vcIYcFn8wOu64JToHCd3V3ghUBsco6aWxPDuriYHfZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RV9fQuO54VLMfYs6Tb7VMNUKIx0RJJ+6/I861Kj7D9QPkKT5QtgUCi8XaXH0l5Yai+WKlvNqELVlxAi5mbL0krG39j21Ceh28pktcz64/LM6v+FIrPWrneznRfVeE1PlgWe8UTi9WUTGvzOPzX7fwDcDEKtmjTaUYOvKhIzkWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9690c99c917so553927241.2
        for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 01:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586529; x=1784191329;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=mE5Nu5O7OAH5QhvzqdmnZB78dYS2mh/hfM08W2+5zMpiGssAMGVerh+eM/SiYhbBJ3
         WMC1uiAomzjQ9r3WJBspigcyj2Y0KrvKykCCwvhFGuHRUbXoAtDMUI+u3iQtxkA62xNG
         UefX7DEh54YsTWhpe7jS9oq4Hclw0mc+JkI9HiTA7WD9e6ROuVjUnqJ4kRvzy2I0qWGL
         rAB0poIlifPCmalFYWVcC4vj68ATOlbSvTznLlvyGr7O722CQeWg5yjZdlqu7QOvG59b
         85q6OXyLCZ/BiDZa1aeciWL4OhtUulUkCYUWM+EVuQ4IarIsw4BwIwN324GsqUzgXFyE
         AjIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rosidpu6eB7MRsVdJgnszC2Yb82GA60sGXC1fg0YKbrnci/94M0N1coIQ2Z69HTfxColMapAwjbTJmUK7deZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydiqLYctumvLyZ2IhUV9a1kNPd74gh7dnb9czGxEKH9jaA82MC
	ukiOWV1G1cqm/qxItFeuBnrzWTtt9L0ifAQOZhSRoLsw5EyAh9bzhe4iINfUuGn86R0=
X-Gm-Gg: AfdE7cnjmvv7AbfBw1ur1ucxg+Ynv1Ep5v89fRUEk1JdqBaY3qfW/8ZDu0z7gRprV3w
	qVkVAP+EcRSnR9JQ4j2XMr7DG9xlMSpX11FS4ZYRzwK1dfAnAAMAEyB7M+1mFMK/NiamIzeMC3w
	yHcpTF42woyK4Y8SjExqDz2g6IS23mAdOIs3Cknd7F3XG7TsyzykNg7KvafMO5C2Nv0C41WF4TL
	CAC4QP/9MbOV/iVxi8y13VbvaftnzZOJSZ1M+GT9H4H9HpluGEvfwMElYLjSRZAPMx6AUFKHq8X
	lC4K7KBoA13J/6aI2zJ0n6h8+FelhqhyoeSzZ4ys5+Gl2Jx87RIvait1aixQ5rwOJGL+zi/p1yZ
	OqZH5wB22ykt78K31/sExtakAWKeNl7XpNU5sTmoAfLfBjklAvWrwVYAMi86MVIAAyDhCJcsd11
	xRVkdWmPwOs3dvcX7/WfR2rhug3fjTLsMxIDwdix+Z+qFV2bat/Q==
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id ada2fe7eead31-744e03a337dmr3306976137.20.1783586529287;
        Thu, 09 Jul 2026 01:42:09 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6e38b3bsm3160924137.10.2026.07.09.01.42.08
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:42:08 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9690c99c917so553919241.2
        for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 01:42:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpUwfJqNaMWriDVVU3NR6CJFwn9DQJnleWNIktfHD3IZ2U4FiHD7rpQYl6pUlT3/NJqnZgk8S9hixgxuYRoBw==@vger.kernel.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
