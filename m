Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29637CD32
	for <linux-openrisc@vger.kernel.org>; Mon, 27 Apr 2026 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326424; cv=none; b=Jg7pRP1wHLw+IWa9xRmbDsp2OTna7DuXfj+Eari4P2nJEf0JUy2TW8fcDuMzhCswsF1uc8H2oVGM5Lq1wq3Mwh34b5JoFedqLFIp5QDpvzi3vQpfR5OKu7IT5oqf+dOmyMkNCyJaSjwLwYsGVz9vFRkoIHBFkjh6okPAVTUSh1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326424; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/60IPT2IsSGznDI3fNbbRIhATENqcHDh9psLYEFmr8Xtyv/EDXG91anx5BxiwC1ol5kXoMTC9sJJuQUzQsAkrybdWiyW2As3XLEEIayqlO6fhTNJcZQfhZ5GSCGPXQ2k+caw+eHXzCd8ddyIKlmOi3R6vSfI+p7Ilp62Cog1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KNlrfZBO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KNlrfZBO"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so236981566b.1
        for <linux-openrisc@vger.kernel.org>; Mon, 27 Apr 2026 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326421; x=1777931221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=KNlrfZBOews1p865zeMP6wEfzzC8H6oILOeHSaXKvD4iWJaym9AZs3KkG0CbSK1S2+
         8tlh+5FqbtVcumhMGcVXqOChulmDJOJLFqHnB+cY/Z3QAlxnQ5MxMPtU3a7EclDV2hng
         JnSvdKDq27zrUMu0TbhmM0STTLbZKJogm9rvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326421; x=1777931221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=gy2xZNFITIeFaL6hMiku4AyUciIgufDSr4FpOfp6y/3t/YY2cY+ussPDqIUWEN1MGQ
         +14+Xj9oqrNbi6tioN1IuiN54aSTeCzkzoj7pJ54FhNgUo0zcGVrpUPspASZ42zN4gxO
         Fy8TSv3jBwKeA4Bnipr5+mtR/45caYUm3DL4USaEsB0r9xMaTX0tSGkYwAu96s/zAgnG
         kZ5evfWUpQs/Qa64Ky7x12x4oiEXYWPqcLzKedBy1cUyKaAsnPCuZIm8yQQ1vcZ27GUa
         eRzIYlLZY/YpWv+sczRR9fMC3+q/FLNF02EA9PYuBufxCBEqjWNa/IoMbG9rsVGD3ETA
         Q4AA==
X-Forwarded-Encrypted: i=1; AFNElJ+o1JZbxakyTD0AVhcRujIHrzKwbhAtbqH+pWOt+Ud7TMawR9oJlyiAw5GifxqcCVqCatLRT1UAuOEAIXW5dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9cfCL+Yogr33AoDATH1E395SNg+muL2lHubgqBdFOK+KtLPF
	yyTI8u9hBBj1FuKedoKlmim4W6rG6biax+8JXF31JOFHUyA08ddmd2PNI3AzWMKluZ1d9ifbi6/
	i0j865/XZQA==
X-Gm-Gg: AeBDieuG3QDeik2u7Sb+Zm8z0ULJgByebCG9arqOr3hqVoiybFgmNyQGx99UgF/UZY3
	FRX3/51ZpE5vMOz/CPl+foQa1OrJ1SemlXTVxMVG+uBuNorPVBAluEmXzKjQHge75iKdzChGkIj
	A6lPKPr/okO2sgsryEHhWuZKrSk4YYWWAL1sZQrd20BHyQtqK1GxkuwjpnqfX1UVAN/Pi8YlA3N
	UtQP5wtxczzr7bcuaNIt8xZTOTK9s1BxDpcHkU3m8UgEdOCsihzZHoLAAX/aeM6AJC7+OuPgS8G
	fAPkshbdArrGYzqMBxWfCtOV1ZD9uSQFrckKSpYa3HG47fZZSO/nRRC5Nh3BNYcggTeow2BFzEH
	a7/Ijl3oFWyQ1Q2lMYJld1WtnkqmaOLSpEZBds7jKl+dBm2rGsKFp7wAKPGa7rm9/ubKbmuqjOe
	gKTChVKO4sKE47s2DTPj2P1HSlCx43UhiLXf+xXsmnM6vVcnPiNBbIvOm9hYWielaZRtVMqaG9K
	26eeFlbvwI=
X-Received: by 2002:a17:907:96a2:b0:bad:d21f:904d with SMTP id a640c23a62f3a-bb804728021mr26022266b.31.1777326420970;
        Mon, 27 Apr 2026 14:47:00 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2adc60sm9134466b.30.2026.04.27.14.47.00
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:47:00 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b886fc047d5so1921103766b.3
        for <linux-openrisc@vger.kernel.org>; Mon, 27 Apr 2026 14:47:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GPmYLHaPT8Fsjo0JrR+1xNoAke8LW06emNwlgpGqQdwp3VAjw9IqzMntYohEOqQGHluZxmtabXI1NZ06/vw==@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
