Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7C79C8
	for <linux-openrisc@vger.kernel.org>; Wed, 17 Jul 2024 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188951; cv=none; b=r4dvbsXbPNpWJSXbJZublMUhirQas2gsEu271kuNRAuwBaudNn3PngnmdbYxZF7ZZHM69yUUZXZ4C+GP7t7Owsb4Nkar96/P9X4P9Z/TTVVgqJ4GR2bhU7lKkuMwKVFtOck/eBbExZP05nsk0nAtQuA1Hwlq/il35CtFRn0BxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188951; c=relaxed/simple;
	bh=+PBwcB9983LmNCN43zPYuSin1XxQnwumx190TVwsnxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iObQDhPbj/cZhbujFhuKwGAMdLS4Fa4y/YfhcZBlGtCUlP2CBX5OqYpA+Da2lA4UO6cXKPEkLLohcYxDO64tcy53iE+2WRPC+cMsjQMVyh5lnctnqdAYaQGx6rl7fFMGC460PxqoC7F9LlaTc0skyS71ZfT/60LsLZgDrI1Iybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WaFXw7e0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WaFXw7e0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so698604a12.0
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Jul 2024 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721188948; x=1721793748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=WaFXw7e0HGFPrWoCmbMYuR99vJJmtDKGCkabO1cfM/MD21kWO+FTGO6Umu3C/BUqZu
         qPuYyS64t3pDlxTqSkrqDBwX/anqhG6VlnOwxOhWFrgKL2OO3vZN/qrZggTRXxtADedN
         ps6kTQOgQqBOsoOrUvnomv7768HEEAXH+YIiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721188948; x=1721793748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=Hx80j/MCItEp4SDkK3f4Vq4B7ST4Xh4bOsepC8V5FvAo19U2GCyi3T6HceKrbJciBT
         bptqlLC3ipOE5EQKAcHrNoPsIIZID2vXdLtpk9rIw9N+tcI5vJv90UHcCc518pTQaniD
         aM6hkMOca8wor9iNlZ5AUpaCcrWh0noTKji4ve9Ngitzt+hobNPZFU619t+ArJxTgqfn
         iu0mjy9hbssJdLRHVuUctavk7HEvjKrMa4y/l9YT6nxm5RyBzNZERu2+PgErCGdpmnU8
         lCzs9fIV6f/RTtwM6fhUSmPwtr6WTd5/gtKJ+jBpv+S/pI7ONilynrSOQ5Qqj1/+Bz5I
         Nq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVfq8qE/li2OVXsvKeweo0TCmZP5fZ+1qSNMMJ4VKKm1nlUB7Dd4Oiftit+MLoM174b3yIm3kfbjWM+CP7ZuPmMaqGQ/MsEgbrgbwkRiw=
X-Gm-Message-State: AOJu0YxMqme3okYrwc8xAcnpLngaYig0uQRr2Wd1rJq8CPADzpb855K0
	EqwkOk+n2GyaMZTkTggFrl9rwqqcCzNnNOIiG04ugbmJQzFzHL3voNHU0k1n+A8GwKzW05AlVp2
	lsn5Krw==
X-Google-Smtp-Source: AGHT+IFgFiZoIea6W1+kFLkJcCisVfaNUu+ea0Y/QJnZ+n9K9BUA3UYcnvu6IfBHpKWN2k0TuTtQSw==
X-Received: by 2002:a05:6402:26c7:b0:59e:a1a6:11b9 with SMTP id 4fb4d7f45d1cf-5a06872caecmr568449a12.2.1721188946878;
        Tue, 16 Jul 2024 21:02:26 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59ca3e68567sm4630496a12.1.2024.07.16.21.02.22
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a083ba04e7so137583a12.1
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWphlvZQ/SdXe3Mi1BrhFjrfhIpbCMLXCbRaFyGWFjjLSZQupLfZjj7LkSs/kUeqp0RAAr20HiU3w1zuJz/iwPh5uu0AIg42NL4Zp0MQqg=
X-Received: by 2002:a50:8ad2:0:b0:57d:4409:4f48 with SMTP id
 4fb4d7f45d1cf-59f0c41dfa9mr3193440a12.15.1721188942100; Tue, 16 Jul 2024
 21:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
In-Reply-To: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:02:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 14:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Most of this is part of my ongoing work to clean up the system call
> tables. In this bit, all of the newer architectures are converted to
> use the machine readable syscall.tbl format instead in place of complex
> macros in include/uapi/asm-generic/unistd.h.

I haven't bisected things, but I think this code is seriously and
utterly broken.

When I do a

    make allmodconfig
    make -j199 > ../makes

on my arm64 machine, it keeps rebuilding pretty much the whole thing
every time - whether I have made any changes or not.

The second time it should be basically a no-op. Sure, a fairly slow
no-op, because 'make' will go through the motions and check all the
dependencies etc, but it shouldn't *build* anything.

But that's not at all what I see. It rebuilds pretty much the whole
tree (not quite everything, but at an estimate it rebuilds the
majority of files).

And the first things I see in the build log is

  SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_32.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_64.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_32.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_compat_32.h
  HDRINST usr/include/asm/unistd_64.h
  CC      arch/arm64/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  ...

which is why I'm suspecting your changes without having actually
bisected the build time regression at all.

And yes, I checked - it does update the timestamps of those four
generated files: unistd_compat_32.h, unistd_32.h, syscall_table_64.h,
and syscall_table_32.h

Every time.

So I'm pretty sure it's on you, even if I didn't do the bisection.

This needs fixing, urgently. Because it turns a "small pull" into
always taking 5+ minutes for me. I didn't notice immediately, because
many of my core pulls I _expect_ to rebuild everything, but...

Btw, I don't see the same effect on x86-64, so this is purely an arm64
issue (well, and presumably any other architecture that uses
'syscall-y').

You might want to do a build like this:

    make allmodconfig
    make

twice, and then do

    find . -newer .config -name '*.h'

to find things where the build has generated header files with new
timestamps despite no changes.

There are other bad cases, but the syscall ones seem to be the ones
that cause problems.

I'm adding Masahiro to the participants, because of some of the other
files that *do* show up for me when I do the above thing:

On x86:
  arch/x86/boot/voffset.h
  arch/x86/boot/zoffset.h
  security/apparmor/net_names.h

On arm64 (ignoring the above and the syscall ones):
  include/generated/vdso-offsets.h

That 'find' also shows that the install headers thing does the same to
the ./usr/include/ directories, but the kernel build doesn't care
about those.

             Linus
