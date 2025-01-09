Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6B2F2D;
	Thu,  9 Jan 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412583; cv=none; b=r67nL9EOO2tkKntZpvH27aoXQdW9zIQF0gdkbaRP/PTjxnD6eVFDEjlYS117bFGl76PGc2JiDMWaalO9ubXiiR+MaZat+2Y5ujhiovXnd2UwjI0ylqaUuqEY8JGxvR7eOzFfb3rhmzmFSBkhfMvccvKq9piRQnIArwfkpGsf3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412583; c=relaxed/simple;
	bh=gXEGuMGSOcBrQKhonI9sutiNdyi+iWknhbxloYgyS/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyqXTVpPgTswhiRrgk/0Repc09VD01Mua3U5McckYIJ8nVKuBKh1Hla2Mnx9lu0qEd6pZGDb0AWDwC/7iFC4lp1knZ7wI1sl2NzC3UcMLpbbtgtJ1RrL/aVOhqfHXPiGfbggjZKDa/PmtZXqtwIo/VHCjevVItkJhwL7IX5c4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85b9f2de38eso188770241.2;
        Thu, 09 Jan 2025 00:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736412579; x=1737017379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=980cp5wg6VreAhZrvif3H7Z9Otc1vWhF3tByoZBAw1Y=;
        b=haPVfeQ+NXmUxuKdG3w52inmfMP08un++HJp4uFjyN8rNlzzYnnJDNQUGiBHQsKk+c
         7ytQVffsJWgtZfo7TDuroOG4oSz3AOhU0+YQUNtVIeapLe7TxqoGFW0Wwr9bY7jxfpZQ
         e+00JVLOVkb4r04U7NpMHDiWTBqDlsYlhAUeGI4nHRM/S1pzYpBJvdLlxu5cERfXOB62
         NrfvK2YjOQLOWd3YCRO2Xx90uO8741cTLmF31aq4YGd1jkOA+bC4U4cLGQK8L9rFfGWV
         m5RmJVK34FfcEWIyY1tPLbech8nNgpplY6qbhjZnu0MEZTRz9e3Xx1dwaj1Eng/thARt
         Vnmg==
X-Forwarded-Encrypted: i=1; AJvYcCXX6lLG6lf9nDEPE9dJYLpU8QxTpWivspNzhcxJXmBAb4iHcAmYabNNxCb4HjP8HhHFUmrMt8IrgDk=@vger.kernel.org, AJvYcCXvCBATfj12GkBcabxlkxKXGSLt+I/i9VeKDlqSBb+VnYYj9ooBnfvOXCrP8FAAKsoOwJWVv9UB+5ogYaG6LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYi+W4Var9/iPIL7euRGKfNqXr9m5vD08r3qyjGDJZ6eLwSrW
	CkbjNoTzca7S1fgWFrGCMdlqZbVohWEqfUd5AxHRDBT+wxdM900cvWR+mdXS
X-Gm-Gg: ASbGncsVajTcZHJR7cBuvM97Z/KeMBM6x3E+3qvf4ib/+eyXV/ZIgFQxZqLQ0WL1vwo
	78Fc5yIsFG81LcmU8x/q4dXKoNDufUqFSj2RaymEPqXgbI+8ZdQJhGwOmMZXO6J54kku0eWU3Ps
	YwKpmhe/L51ADmGMk4L0hLhO8OAtRUeFutbqZieWgY+vHhU7aP9otujtyPgNxusoB48fsi1aEP7
	DfqshKxVQ3I9kMb5cbFIS3ouGrouYc+Nmpsb15AXXX+/o4pVtCz05wRcFQtkZsAnFnAT4tx0dW9
	bBCQXuBMsfU8C4ZP5X0=
X-Google-Smtp-Source: AGHT+IGAM9fWa334ZtBPaOL0PnfxDYfgExRHU1f3b3m6nUQXapSCPZuUsnKPHpGYyyANgv/3I1kclg==
X-Received: by 2002:a05:6102:549f:b0:4af:fa1b:d8f9 with SMTP id ada2fe7eead31-4b3d0f046aemr4626198137.7.1736412579315;
        Thu, 09 Jan 2025 00:49:39 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f86d6fsm531257137.17.2025.01.09.00.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 00:49:38 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4b1279ca1d2so213071137.3;
        Thu, 09 Jan 2025 00:49:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA0Lm6S3myBbqNqJJf+iHflFErMWZzJp8jAfipbGqLCrgw0JQfvDwcEHY0YE7NY0QC8ByD+8mZ6x4=@vger.kernel.org, AJvYcCVgYCzcNvjA5B9q32eBIUP298tyHDrzCg5mQr/zBp+jjGnYajez7QYhCdSlpFG7pDeGIaVntqQcu2bWvTtxbg==@vger.kernel.org
X-Received: by 2002:a05:6102:290f:b0:4b2:5d63:a0f3 with SMTP id
 ada2fe7eead31-4b3d0f2d89cmr4381603137.15.1736412577224; Thu, 09 Jan 2025
 00:49:37 -0800 (PST)
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
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <0d2df37a-a167-445f-aacf-714a29587511@landley.net> <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
 <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net> <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
 <4b9b20a0-ab3a-4ef5-9ae5-5a32a2eb6be7@landley.net>
In-Reply-To: <4b9b20a0-ab3a-4ef5-9ae5-5a32a2eb6be7@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jan 2025 09:49:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZU1JBFg_Z8gkvi=ovXdyFomvG4R-oUUCKiiuyXs2LKQ@mail.gmail.com>
X-Gm-Features: AbW1kva_tBde59Tj-FtT2FMM0NeMlWqY72yftUafHQ8o4qk5LZMDGlu0s4tj9bc
Message-ID: <CAMuHMdVZU1JBFg_Z8gkvi=ovXdyFomvG4R-oUUCKiiuyXs2LKQ@mail.gmail.com>
Subject: Re: or1k -M virt -hda and net.
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

CC linux-sh

On Wed, Jan 8, 2025 at 11:40=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
> The sh2eb turtle board uses JCORE_EMAC which is still an out of tree
> driver. It's not secret, just too ugly to go upstream: done by a
> contractor and never cleaned up, full of half-finished IEEE-1588 support
> and so on. It used to be on
> https://web.archive.org/web/20200812035510/http://git.musl-libc.org/cgit/=
linux-sh/
> but alas Rich purged his trees when he stopped being maintainer and
> archive.org didn't crawl that far down.
>
> I have the patch locally if you care, but without the corresponding
> hardware, not much point attaching 1600 lines. (We sent several turtle
> boards to Glaubitz and his assistants last year, and at least one of the
> recipients asked for a copy of the ethernet driver patch, which I sent.

I still have to ask you for that driver, so yes I am interested in
the patch ;-)

> Still applies and works as of the last kernel I updated on the board,
> 6.18 I think? The update is a "pop the sd card, stick in laptop, copy
> files, move sd card back" kinda thing.

... which has been the main obstacle for me to integrate turtleboard
in my regular kernel testing workflow. There are only 24 hours in a day,
so usually there is no time left for juggling SD cards :-(

> I should do a linux image that
> can wget and kexec, but haven't yet... Anyway, doesn't help with this
> issue.)

Does kexec work on MMU-less J2?
On SH4, there was never an upstream kernel that worked with upstream
kexec-tools. The only one that works is the kexec binary from the old
landisk distro, which predates SH support in upstream kexec-tools,
and can only start a new kernel from a system that is running kernel
2.6.22...

BTW, this is seriously off-topic for openrisc and qemu, so please
reduce the CC list when continuing the linux-sh discussion..

Thanks!

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
