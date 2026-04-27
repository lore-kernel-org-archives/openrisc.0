Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5231E857
	for <linux-openrisc@vger.kernel.org>; Mon, 27 Apr 2026 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327118; cv=none; b=d4wgI8O4Rso+dya6PrTQ1hATtn7rcyeDgKGhfE4XfMIVm7ecZ8X0rEfBkFY94uysDZmiP9L8vXPqX5902z4bbIBxTBkBQJf/vvHbvM/Zdo+keSpX8kdJwhgplQmDlM+bwPVKl3ATVcDeuuGKSKcy+167LItUTioouvISRMZo4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327118; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRzOYi42bqV+BzwVtqf3I3jyQm5rz0mG44U2pfcTn2QRzYQphOYfkPsuU4urQ290xu6l8nan1IFC/4RSqGAuPdscygRM5anhmayb3kDYOIs02YPJ9AUZU0H1h0SYCIhkqcVkXCoLViBLfMAuXmHo08JB+V7Yg923KUx23zJBaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VXw0atAQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VXw0atAQ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9398781a12.2
        for <linux-openrisc@vger.kernel.org>; Mon, 27 Apr 2026 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327115; x=1777931915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=VXw0atAQoYy9V/eNakSw6OkWKFDvwJ/tEBVXtoXCD63Kgmcvcw90gPQcDPJ3VkJEc0
         cBl6f+KDqX4Y6Zmc7wssITtBwnXVxaAlomMY3k8cBHqQ8FSZafhnnRJ0MyAx1GqFkRnv
         jvAmODXJS37v73psMoYO+dXdNsnstTcN9DOOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327115; x=1777931915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=KMdtbjx8VNyjVVGHqQ3bk3LasoXelEjbXlIb+t32yspHWSQ4M7fOgEy6v3FxKgsc9b
         +dLSAx5yvHBmF1w/UJlmuQh4jxHK2e5M/9p1nY/UAGIVrgReal134uBopvUU0Vuwf6Ec
         TlZIeMh1CJswSkQTmZRJ0zuhGpHRnv//gr1T+Xy3fj0/sfycle39G6H95/dd2NWT8Fsb
         Pf5EzHA+/iY3UTNuQtTnOnF1NI+OKoBR6/YuVL3g7HZbhZlBghXEqsNP7vZSPwBOpC7t
         ZPgdW5V70NNQLcsGVZlYSisu87nQFwJwxW5vfxpHU1pXysk8fZCgevqxyhhBBwmIJl8U
         nvsw==
X-Forwarded-Encrypted: i=1; AFNElJ/VvnfdMno9fGuXGcUf9rlofFyrNV5BLBuUtufzFv+DLdmWiqOwdOHWpODItMYetFrEeHCx1BvG+/u3qNn/vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFt6CyRXrFrwOaIFFjX9Gmj+3xDuS7ff1V5qTqUIBtcVfWoXVN
	4nqdrFh7ydYDsjSB4Zddf7RMjnUDmI9EWm7t2PY4FWqPuM+Zxyhnq5pD2xjyajq7hjr8A1u+8ac
	C9I80r248pg==
X-Gm-Gg: AeBDiet3Y5XEcnj/z8RRRtTgpOo/IUJ6ol+gE0vFDq1yYyQ+QAyqAVHWaDXQRrWViEJ
	L8wrg4OtOH5lT3ZRn3ICi4GB7cldJoj3vEV5gOC0Fxj7CJtYOwDMMwGjGzwrSW4cQ817szJEo9A
	xDqtgna1CDDiWUWm0MB9zrNLo2E31/9BuwOeVqBhioO1/tdj9xKmd4+QNBF/seF2Y0uqFEtKkFm
	Dx4wqFadufe6F9wt1QxgBDiWqZOBZhb42ixhqsuOJm6RGSfm2mbFfkBKRKAArptmitPulNVFC3Y
	wgE9L49ZZb3FqbGJz9HTnOzBkz8tfnwXIH2P+VQS1sc9JWjsgWuvLHYb3Skh2XoR2Rnkrrrdqkn
	ri3stNTJP3EiiWq0RzjbjIUGQz43E9PoPfpAxy0dSyS1LU+sCf7/WzQ7m3HvZUz9VCgvzKOHdCp
	eO07WFVyjSkHbZd1tpSFsYrZqpcpcCCW+SS+tU96ECNGwm+oUPKZJrQ/PWCP37qqXfk8m3SNKV2
	ufmS05AiOM=
X-Received: by 2002:a05:6402:1ed6:b0:670:1417:2132 with SMTP id 4fb4d7f45d1cf-679bb087a42mr164675a12.18.1777327115505;
        Mon, 27 Apr 2026 14:58:35 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67d5ffesm160528a12.9.2026.04.27.14.58.35
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:58:35 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9398770a12.2
        for <linux-openrisc@vger.kernel.org>; Mon, 27 Apr 2026 14:58:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+YpPhlKvzWvNyNWI/v7mmj4+DhyEFoJKXQVh4jUx8LFyTzrLdP9iyqjR89iYksGSpJaAC0w85pxy8luFiZUg==@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
