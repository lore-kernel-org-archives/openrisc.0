Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98369BA42
	for <linux-openrisc@vger.kernel.org>; Wed, 17 Jul 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192918; cv=none; b=ZBshH5f9eLEIYw1AZ9x4K2LhHWAmcTHqLBnJqu5UKBzO4Bxt3YDNx8rOXX/xsnUlZRRc8u/FuY9id02rV/Fe5U4yOMXeT7HNMZNQnAaLDzphTI2sqyysjErUZ58xGczFd33fAdtCmv/OKewzsNqGjv9KhC1FxGZPLb2Y+rhOOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192918; c=relaxed/simple;
	bh=456vFjdQgX8t+DKO4cXNe0nbngfpEhmfIZpf1Fy7zRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu1TS4MVtK5h541+OV0BaPrCKbifk9ALUnC6Mp7oxpC/c7q2w7PBm2aFX1z6jgTnruAENA4gZB1RW4jNL68NLiFqC54h24L1vTjvid54DyV5CmALTeVvxel9N0KqUMG9KDzv+CJ+EoI+a7Ja27Y4LhfcqtM4UTcM5fZoNedPqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KwGAkvSz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KwGAkvSz"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52eafa1717bso6430608e87.2
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Jul 2024 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192914; x=1721797714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylupikJo36krvlGvfFYUWfmmy7QZTRdDT6qxa+A7N0M=;
        b=KwGAkvSzI3nMfUR/yLeMrhnZU0Q+8oDnMp3St5LbPJgvi8QQWsYjxFMVcgiCKm8xxu
         dpwpOd+Ij5sw7XnA/KsGjM1NWOWK8SBe6bvcEJbPq2P7sXVRKg5HsY0mXcZVvmDbL7M7
         XcJLb0bj7NZTio7h26FJ0JFqqs+qlIH0ZVG0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192914; x=1721797714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylupikJo36krvlGvfFYUWfmmy7QZTRdDT6qxa+A7N0M=;
        b=sx8wtmbEaxNIRcjZB9d3xL++BBFgkTUmzHvjNXOHNiX23EvHn9QIO0AV1YMHyYNomH
         dUhvQ59uLIkCiEOhorNUDqwWkxwTWayqwjYwtPwh7xxWQk+LGENZ7rv371lazP2vxTWn
         Q2MTVV15YvzB6tku0VidbeRQXhvSZnBIVrd4vgFhLXPpm5CLZMrm/EM5R/PHLQkNqdge
         OkY3sMSIZ5v5k16xmW3PXANb8t466onHBqPN7L+bvbdIshN5g7AUGyg8Nf0MQGOeb/WW
         ff3NBxukHnMgMh1LtTiui/gi30TWrQgjuTtTnsqdqlfXGqMUUihp+qdbp8Ys8oHeqaZf
         FjNg==
X-Forwarded-Encrypted: i=1; AJvYcCW0+qm7JJ2xzOguvwu4GbliTX+xSoT3ZgblS4v/fRA4SfPrvnaZLIpfyLQyZkNawzzd6RHuhstjvmOLktv49zHkxd1ubCkc20vkg/nmAO8=
X-Gm-Message-State: AOJu0YwAwwOmb1KPWawhGCJjC0JqHOErrQxjx710vqVkhsdygopKK2ck
	oHl596/3y62ECbPR/PgNBR8D5xGRZVFZuseVREu9wSrxyz0RjSycq0iw69/NAVXuWciJ1VgTXba
	mi+b8fA==
X-Google-Smtp-Source: AGHT+IFkNdrMVjtcTVUW48vLzKw6KDFxWwkg3k6hSJN8Nk/m2Pl2KJKicQiRv1Cqmf1DyOmgjrcyBQ==
X-Received: by 2002:a05:6512:159a:b0:52c:8a39:83d7 with SMTP id 2adb3069b0e04-52ee542d824mr303652e87.52.1721192914578;
        Tue, 16 Jul 2024 22:08:34 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed2532b8csm1356707e87.237.2024.07.16.22.08.33
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 22:08:33 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eede876fccso52952501fa.1
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Jul 2024 22:08:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfuYPEsi9kPHEUM+Tey6lEwpcKhxgLxz2mtydYcpQGnqVs3aPK0YQN3qpH9UeEr4fqcGV6jHEyxgNodB5WPQUaQpc5h/foikVB2aGx8iA=
X-Received: by 2002:a2e:3a1a:0:b0:2ec:5f6e:65ea with SMTP id
 38308e7fff4ca-2eefd1bf195mr3375661fa.38.1721192913022; Tue, 16 Jul 2024
 22:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com> <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
In-Reply-To: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 22:08:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Message-ID: <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Note, it really might be just 'allmodconfig'. We've had things that
> depend on config entries in the past, eg the whole
> CONFIG_HEADERS_INSTALL etc could affect things.

Oh, and my "find" line was bogus, because it turns out ".config"
itself is only updated if it changed, which explains my confusion
about some of the other header files.

So it turns out that to get the real list of rewritten headers, you
need to do something like

    make allmodconfig
    touch .config
    make

and then to make it faster, you just  ^C after five seconds, and do that

    find . -newer .config -name '*.h'

and _now_ it's meaningful, and on arm64 I see

  ./arch/arm64/include/generated/uapi/asm/unistd_64.h
  ./arch/arm64/include/generated/asm/syscall_table_32.h
  ./arch/arm64/include/generated/asm/syscall_table_64.h
  ./arch/arm64/include/generated/asm/unistd_32.h
  ./arch/arm64/include/generated/asm/unistd_compat_32.h
  ./include/generated/autoconf.h
  ./usr/include/asm/unistd_64.h

while on x86, the only header that changes as part of the build is

    ./include/generated/autoconf.h

and all the other files I listed were just because I hadn't noticed
that "make allmodconfig" itself avoids the write of ".config".

So that "touch .config" is needed.

Or just use another file entirely to flag the "this is the state
before I actually started the build". Which I probably should have
done instead of thinking that "hey, I have this .config file that I
can just use as a marker".

            Linus
