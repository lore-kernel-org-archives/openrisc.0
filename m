Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072513B288
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jan 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324675; cv=none; b=WWYclqLWYeF6tE97IJD3jr4rZ0Aco93E29g2R4jl4g0Yb6yaEvu88swRd1HpvCuOKZX0E9mXdFQMFbWvHY0aGQWDUFYV48wX6RvA+/p3XdC43qpTUzJp9Tm9jcxXl9djkGYkJMovns9JibgPjwXdhYJcC+IHUE52xaOSGQa9iXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324675; c=relaxed/simple;
	bh=q1g+r69Fh4zvWmSE8sEWdnZnqTkXw5vq15lYLbjCgt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYrfxUozzfmEb57779tv5/e0T1+HcyuuqWhdGugAfD0hShs7+dioAAWexf/zBUnaFSjlB1Ptq8FIbr3tTbqOtFV+7c+wF+k4hGjU4Ip7VZrrJUy/x1uJly7qY3+i0y7MHZL35cehmvNRRB+CyIR3w7TA6b/ZCWapZeqMVgmkW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85c5eb83a7fso7959802241.2
        for <linux-openrisc@vger.kernel.org>; Wed, 08 Jan 2025 00:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736324671; x=1736929471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaBeI/iD9rwPK/9Kgw+JgxCrmVuCW+9PizmHcP7JTnk=;
        b=IFmlNlu2rtkTdSdX+lS7IcLOlolfMBK7DOWpA5xpKLIf6CItpmwHtjYFJZ9AkKJ5IF
         IIMAtqkRS36ZRm/CbvFX5tMsT6cRNQSO3oFR/P42yep6yntPr4OpAv51Nu1W/EzgUKWK
         fFAgRBKiMCrphE9CawaXz2g+bLsdqO+wGKYpmfkbVYCFrmz80XHDjSWXfSuOZO7DvKYi
         XenCwEp7tuFtYNMionbr+NTcefNMR8hKGnK+h4C55LyLiqKZcKGXw6iKnQgPX5CV2s+Q
         PqCdYFJmYjHXWiW+kCGFbfaVZuJNP53EnO2OTQiJCIfc0Zyon5IGpo12sbNXyzqQDV5V
         XCQw==
X-Forwarded-Encrypted: i=1; AJvYcCXeZfMoi3Ube5kXsG+xZ84NcQPj/z1c9w5uPwiIzdVdjjdhRZPgHknOGQoDwbb6+4iery2Iw3/bSL2KVC05hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzViVRgT26Hdj3r1+fPd5n988CimqUrDxnd9+hMr2iXKj9WTW3H
	nW9NNZ2TUJw/TY0hsq2wkZB0Tyi+BAqb7Mee2qLVcJnsmxIli4nLhGaEbIz/
X-Gm-Gg: ASbGncuBzRJzdauohHe1VQbSlGC+9zalMJt69YTIBSuvhhCYzU78SWEpX7fBE/M9Buc
	gELQ6EvABgQ46QvwzqNv2kbidOOpPGQfcFBOlOv179e39FmxkQuRHGBeluMchcfStIkAQxBUEu4
	kHjDbJRoqhac+gQPbCyIV5tWWpbERDD8Fh1XHPViD6mLMTXbjWgzYg6tyB5oKy98h5wUPwPPHg9
	uGCXkiq+5cPksZms0l+12SqZTWl78VFEufK4dfDrPm3NKaPP4bg0DtvEDg1HqHx2FmXqyb1YCfE
	vinGD/feMhE5DMWjtUD9uN8=
X-Google-Smtp-Source: AGHT+IExo2lIVmrwBuee9iFuZKhJjjG26iAkLIIkcx5lFpyDLsCmIiySXLEDEUpJRjslu8qqA+dnNQ==
X-Received: by 2002:a05:6102:509f:b0:4b1:1b41:ff5f with SMTP id ada2fe7eead31-4b3d0da4c1bmr1311029137.1.1736324671154;
        Wed, 08 Jan 2025 00:24:31 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf9a4095sm8192307137.9.2025.01.08.00.24.30
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 00:24:30 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51619b06a1cso9134987e0c.3
        for <linux-openrisc@vger.kernel.org>; Wed, 08 Jan 2025 00:24:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXs4ZT8Pp2rLelelVJS2M6IUlKCC0zdeL+9CFRoNWFKsw5zMB7VJl4z8QlY+TUXeKX9i9zbBS4Bv6S6jiTuwg==@vger.kernel.org
X-Received: by 2002:a05:6102:b02:b0:4af:56a8:737c with SMTP id
 ada2fe7eead31-4b3d0dd199cmr1341907137.12.1736324670156; Wed, 08 Jan 2025
 00:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec> <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
In-Reply-To: <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 09:24:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
X-Gm-Features: AbW1kvZzrhxO471coP-DUQZQXWDXgFR5eNkZOOkRN3HgcaBG79rM4GHszy7Ikb8
Message-ID: <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
Subject: Re: or1k -M virt -hda and net.
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Jan 7, 2025 at 11:53=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
> Microblaze has no /dev/?da (as in there's no device I could attach it to
> even with the long option, I'd have to use NBD), sh4eb has -hda is
> working but it's having some endianness hiccup with the network card
> (works in sh4 but not sh4eb, I'm trying to track it down, I thought this
> worked at one point), and the two "No kernel" ones legitimately have no

That's using sh_eth, right?
Last time I tried booting a big endian ARM kernel on Koelsch (R-Car
M2-W), it booted fine until "unable to mount root" (I have no suitable
userspace), except for broken Ethernet, so it failed to obtain a
DHCP lease.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
