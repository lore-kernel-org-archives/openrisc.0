Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA65C43334
	for <openrisc@archiver.kernel.org>; Tue,  7 Jun 2022 10:43:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4458924917;
	Tue,  7 Jun 2022 12:43:30 +0200 (CEST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com
 [209.85.219.172])
 by mail.librecores.org (Postfix) with ESMTPS id 39CC724953
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 12:43:29 +0200 (CEST)
Received: by mail-yb1-f172.google.com with SMTP id l204so30419652ybf.10
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VITNEksPVq7xoKlKRxE6fmTTVanCV3r1QNLeiExqK3k=;
 b=NuH5fbz9EQbS5gMzyD5qFmsslsI8QIDOWOi29XrDy0shGdgCSDsyeosDE2FuAP2EPq
 7EmLiW1XNlqP14J8RyvpJghh4UoHHIfYv5J2DBulIKpEXXHccZvTIlGvBOhy9hPN8IGP
 nkHceODoYD+Q9T0hr8MaG514vFaBJ3q644oIjp+FJwHmEGRFpmAeIIFMi6FnRa9D1xGY
 o0JL4v9bbw3qoU1m1gydaxE35RRlkGR7N1EsudJ87QcgffTlgt0wkNAIIMnYwjpjf+pQ
 DXPF1DvMhaby6Nnq2A9eegbtnk6QgwYotyY2zAZ0g0HXwHPYBXHG/Htw8BULdZVwfn3/
 noLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VITNEksPVq7xoKlKRxE6fmTTVanCV3r1QNLeiExqK3k=;
 b=1j6cmw/FBE1MHExJWsu9s/ykqWqui7f8o1XKortLed9FC3XSUri9jNqpWOOiiUOJQD
 gh/cEZuqb7XLqIP70BC8pAeDznCwvotahj53/KA63tc4vlfig2RhRKqbVN3HUEOlKRqX
 QfWduH66bMkfzj8POvR6TfFL1RXN8UBNlPdvu6ILklWyof7KveMPmlxnBEZvQw1URrcB
 7NQmtxe1DMEyHZ9O53y5sXsGJ0fCggb+1e331RXcj681E4LPJgmdfk0NYlMWkukeXtZv
 mO/VEG5Sh3igI+xwMeKIqoLXJgFrvVLYYH4wCm07d37tQOlZLbeiRSY54tJauhzi0o7m
 ne8g==
X-Gm-Message-State: AOAM533iG3e3dVZoq/y0uCX0hYgt/A/M77Y9ncWMTqBhRk2c4T8Zau5B
 U/WuGK6RQUQ4Ts13MSY+AySgUXQVcUZIV4/nXNQVmw==
X-Google-Smtp-Source: ABdhPJxQLOyUqMsOThJ+1SV0/klGHBwVILdyuPskFeBoI1LWERKAGRKbnof/wEYnWGV90IDWsUZihKWDgFLrv5fLbeI=
X-Received: by 2002:a25:b94:0:b0:663:e6e7:c5 with SMTP id
 142-20020a250b94000000b00663e6e700c5mr1107735ybl.85.1654598600017; 
 Tue, 07 Jun 2022 03:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
 <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
 <CAK8P3a3Vpn02uDe3rdXSNXANY=u4ZM+wjm-qqszTXzjOKkAeEg@mail.gmail.com>
 <Yp8epZsizfKMEVZV@antec>
In-Reply-To: <Yp8epZsizfKMEVZV@antec>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jun 2022 11:43:08 +0100
Message-ID: <CAFEAcA97oraa5OSdqmubmJ2-ONTCTF4ZszwfTcZ9VhqKRFhogA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Arnd Bergmann <arnd@arndb.de>,
 QEMU Development <qemu-devel@nongnu.org>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, 7 Jun 2022 at 11:12, Stafford Horne <shorne@gmail.com> wrote:
>
> On Tue, Jun 07, 2022 at 10:42:08AM +0200, Arnd Bergmann wrote:
> > Goldfish is a very old platform, as far as I know only the kernel port is new.
> > I don't know when qemu started shipping goldfish, but changing it now would
> > surely break compatibility with whatever OS the port was originally made for.
>
> Hi Arnd,
>
> As far as I can tell goldfish in qemu is not very old. There are 3 devices, 2 were
> added for the m68k virt machine, and 1 for riscv virt.

Yep, these are new for (upstream) QEMU, and AIUI the only OS we care
about for these is Linux, really. My understanding is that these devices
were added because they were conveniently available in Linux :-)
Where they do have a much older history is in the Android emulator,
but upstream QEMU doesn't care about that.

> The problem with the goldfish device models is that they were defined as
> DEVICE_NATIVE_ENDIAN.
>
>     $ grep endianness hw/*/goldfish*
>     hw/char/goldfish_tty.c:    .endianness = DEVICE_NATIVE_ENDIAN,
>     hw/intc/goldfish_pic.c:    .endianness = DEVICE_NATIVE_ENDIAN,
>     hw/rtc/goldfish_rtc.c:    .endianness = DEVICE_NATIVE_ENDIAN,
>
> RISC-V is little-endian so when it was added there was no problem with running
> linux goldfish drivers.
>
> MIPS Longson3, added last year, seems to be running as little-endian well, I
> understand MIPS can support both big and little endian. However according to
> this all Loongson cores are little-endian.
>
>     https://en.wikipedia.org/wiki/Loongson
>
> As I understand when endianness of the devices in qemu are defined as
> DEVICE_NATIVE_ENDIAN the device endian takes the endian of the target CPU.
> This means that MIPS Loongson3 and RISC-V are affectively running as
> little-endian which is what would be expected.

DEVICE_NATIVE_ENDIAN means "whatever the 'native' endianness of the target
CPU architecture is". This is a compile-time thing, and doesn't change
if the CPU changes its endianness at runtime. So for instance for Arm
boards DEVICE_NATIVE_ENDIAN and DEVICE_LITTLE_ENDIAN are the same thing,
even if the guest OS is running with SCTLR_EL1.EE set (and even if a
particular board in qemu-system-arm sets up the CPU so it leaves reset
with .EE set to 1) The analogy on real hardware is that the way these
"switch endianness" CPUs work is that they just flip the bytes in the
data on their way out of the CPU, so changing the endianness in the CPU
doesn't cause devices to change the way they behave. QEMU's "target
endianness" is kind of like a property of the interconnect/system design
in some ways.

From QEMU's point of view, the thing we really don't want is devices
that magically change behaviour when the CPU switches endianness
at runtime, because those are weirdly unlike real hardware. (Virtio
is the main offender in this regard, but we're stuck with that.)
Devices that happen to be wired up differently on different target
architectures are fine for us. I don't have any definite examples
to hand, but my understanding is that this happens with real hardware
too, where a device (maybe 8250-compatible UART or Lance ethernet
are examples?) with 32-bit registers might be typically wired up in
a system for a big-endian CPU such that the guest code can write
a 32-bit word to it and get the "obvious" ordering matching the
device datasheet. This sort of thing is what DEVICE_NATIVE_ENDIAN
was intended for. (There are also various places where we use it
where perhaps we should not where a device is exclusively used
on a CPU of a particular endianness, and so you could equally write
DEVICE_LITTLE_ENDIAN or whatever without any behaviour change.)

So I don't have a strong view on whether these devices should
be DEVICE_NATIVE_ENDIAN or DEVICE_LITTLE_ENDIAN (except that
my impression is that a DEVICE_LITTLE_ENDIAN device on a
big-endian system is a bit weird, because it means the guest
has to byteswap everything. You see that with PCI devices because
the PCI spec mandates LE, but not often elsewhere).

If there's an official-ish spec for how goldfish devices are
supposed to behave (does anybody have a pointer to one?) and it says
"always little-endian" then that would probably suggest that fixing
m68k would be nice if we can.

thanks
-- PMM
