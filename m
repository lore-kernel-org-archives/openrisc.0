Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C61E25FA
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jan 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353590; cv=none; b=G/O5RhyLfTviTTq1sbCqQjZ7DpvSBOoeEbWFxmmZw+d37o1x+4cuhgYx0oVpP4pOU6prfdX5oLulyHfoZKrLs1XDBpjs1IvIWO0nudwVtNPXt5Mqkm31I3lx/Kakr5o+526uqyvZ61uwfQEslzVywRQM+/tIqp/kafZC5wzdfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353590; c=relaxed/simple;
	bh=s9G2qVFjm1y8MV0br6ZKpCYDsZwIUT5mOqbbw46/oec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNoC2p0bprgLOX9j2gzrGwBZo/Kt4Aspj5lwSWZq04nnE/N5ivZrvLu4dcFHW1lSOnoK3oNI0/+uN9avcK4DNeSvBgQMNgFEUy8OMq/GYTaUhfMmMZzZYeYyJzigesk9152OAlMl1mo8KP75RLiA2p1SMLBWiiWfZNQK9c/FEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afdf096fc5so809137.2
        for <linux-openrisc@vger.kernel.org>; Wed, 08 Jan 2025 08:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353585; x=1736958385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9dwBsCn6Dej+H2X6wzFVUAriPyGB2FbdKvWMgwyGcw=;
        b=dFoEB7Bj1+hgFZhHhS1l6oMCe79VNpLen+sVT3H8S7Rz3ikMI+GGH0IWjT5qWf4WEa
         tLV4o7tquuOraQsq5Lq86ED8am7ZDwvt3imz/5coe8r/1KW3eunlq7oU4/gsLLp5rytB
         02Xe7ZzMUfYN4hyBKgoDB8FPc+d3rsXBdH5yThGGBydWjVZWeznqqpdNrSxY36KMdviu
         GESrWKBlZlWEUEHJoEP45KYJu2Al0ZOwT1eJHd7Ocwwim6WAW/neO7UbDGE8V1RSxVsM
         tZm1H1KyNHoXmOOlk1XpU99WkNHz4QGfxeLmhWFOSXtreoKmqGJKg0XI2m2cgCb90Pzq
         WG2A==
X-Forwarded-Encrypted: i=1; AJvYcCU4zgu0Z7PKVRcuGBPucTfPUPsW/NxBcri2c5U8BWI4xRQ+H0e08YaZWEY7BPUaIqSj4fNSsg8VXsc9TaOAiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgufqEeOKVbmf9EWhjkcuHQEwC3+8G6W1zqGb5/paInbNSmiU
	ev7SBc05S9vYXOVLGgBuzvuNhStdu0NPF+DVtP9azfuuWnJY9Rxwf4hS5RyN
X-Gm-Gg: ASbGncs06VoUHgT5xlFEkAF7/ORbPTHvhazgU+LoBLwXkH8cAaH1sxerb66FxRZ42s7
	J2BnFkDxyg0qlyJ0S6358fOS8yJmt4adLIGvOBw5CxZvnbofyvWv5Bckk0kERh/QWL83sn/6ohd
	etekpZJ16PIxr857Z7jZEgaHM3kbty0VhmANAWCLncL17Qmjq88vKQxECCgrZUNsqLTvwAe1uxE
	4YXDtISOkEIVBQAscvSJWaaz7kw8JqTpXmm84awSdTPNvIajGCIyqrpd/X86w9HayqvqKL2zEz4
	dDSAXFvbozbdn7qwP/s=
X-Google-Smtp-Source: AGHT+IGrXFXcuwaZZ2P7bzRGd15A7CL9Xu4EF1E5z7aazyT+9K8AHJ8/E/Zv7WU2iwnTMFcd70Nygw==
X-Received: by 2002:a05:6102:3591:b0:4af:be6e:f0aa with SMTP id ada2fe7eead31-4b3d0eccc9dmr2649553137.25.1736353585676;
        Wed, 08 Jan 2025 08:26:25 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ad3e9fesm8506260241.25.2025.01.08.08.26.18
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:26:19 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4afdf096fc5so766137.2
        for <linux-openrisc@vger.kernel.org>; Wed, 08 Jan 2025 08:26:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXumQafUdDGnNwNMa/SA2o91TQ75Uo9LZ99Sh2DWeSOmYMoQBqUjzuCofpI3v5FfAAGn0A1IAvykTQB0EvU4g==@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:4b1:1232:def with SMTP id
 ada2fe7eead31-4b3d0d84163mr2204501137.4.1736353578692; Wed, 08 Jan 2025
 08:26:18 -0800 (PST)
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
 <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
In-Reply-To: <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 17:26:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
X-Gm-Features: AbW1kvaWzqf26nImabkvqvG5nDawWn3pXa2qtdMQU5IFOL6qj_weGxNPM3O8VjQ
Message-ID: <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
Subject: Re: or1k -M virt -hda and net.
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, Jan 8, 2025 at 5:23=E2=80=AFPM Rob Landley <rob@landley.net> wrote:
> On 1/8/25 02:24, Geert Uytterhoeven wrote:
> > On Tue, Jan 7, 2025 at 11:53=E2=80=AFPM Rob Landley <rob@landley.net> w=
rote:
> >> Microblaze has no /dev/?da (as in there's no device I could attach it =
to
> >> even with the long option, I'd have to use NBD), sh4eb has -hda is
> >> working but it's having some endianness hiccup with the network card
> >> (works in sh4 but not sh4eb, I'm trying to track it down, I thought th=
is
> >> worked at one point), and the two "No kernel" ones legitimately have n=
o
> >
> > That's using sh_eth, right?
>
> 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
> 8139cp 0000:00:02.0: enabling device (0000 -> 0003)
> 8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0x(ptrval), 52:54:00:12:34:56,
> IRQ 128
>
> Is there a different driver I should use? That one works on sh4 little
> endian with almost the same config.

Oh, you're using an SH4 SoC without internal Ethernet (sh7751 in landisk
or rts7751r2d, I guess?). That indeed doesn't use sh_eth.

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
