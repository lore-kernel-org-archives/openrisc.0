Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE30C43334
	for <openrisc@archiver.kernel.org>; Tue,  7 Jun 2022 10:04:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E9D0224918;
	Tue,  7 Jun 2022 12:04:33 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by mail.librecores.org (Postfix) with ESMTPS id 9C37B24761
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 12:04:32 +0200 (CEST)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mq2rM-1nTHmn41Ba-00n5nv for <openrisc@lists.librecores.org>; Tue, 07 Jun
 2022 12:04:32 +0200
Received: by mail-yb1-f175.google.com with SMTP id f34so30289650ybj.6
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 03:04:31 -0700 (PDT)
X-Gm-Message-State: AOAM531bCzCoRi67XtiJj8k4VMrRdD2TbN55Ig/mADhrt+8V3Wn7JPzf
 AjunxT+RpEVBOIydx7+W1Ov+Z5iIFcfRpmsbSLE=
X-Google-Smtp-Source: ABdhPJzwRpYKwEkLLVAKUKAZ7ioUX6Kw8vDMVEignXpaaC9z+dzb6hkZrFCGT4AEYJViKABnTFhsrvkryOQS+qR8XLM=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr28771253ybx.472.1654596270741; Tue, 07
 Jun 2022 03:04:30 -0700 (PDT)
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
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Jun 2022 12:04:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3MDDE3ko93E0fMmHoXXveTUeYJXdEJbf0DEy3kcBFn0g@mail.gmail.com>
Message-ID: <CAK8P3a3MDDE3ko93E0fMmHoXXveTUeYJXdEJbf0DEy3kcBFn0g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WQxbFUgEwX/XxzE1eUIlJfzO/ZwowAqNrkvUcipsmu4wP3jgM7V
 xcjRNQzdxlr5qXmctzrYmXy8yAXyg4Y9rlfwZUhoCCDBWZrOdzh0sCI9utZNbsTbWSqkzbF
 doCq5+Pi4GD04O2HAdc7lOLG+J3ugKmcoL3uoK35KhstoHnxLyZBnIKUEYIcYMdSnqPpJL0
 3Uu8MYPy3z/RdqOWkJaXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKbINkQYvII=:kVBBoyQhf+lu6EhRImQ94I
 Xkcu0P4sOUmsBu3tr82otEndlxWHVRM49h0LpK5iextk1rCyku718dVkT+1Ua2Qyj8R+Bmy+f
 TrwIpyNdb9UcriC94XawzRQTZnumjPI96xiYt8XpLnUTQr84p2Ykl6Xk6JfMEMry9FJDTO3VZ
 89s57vZi/V2YcpT9SEjxM6X8KUPPPsACXpnZl03tEB2byD/gFW26Kon4VQbjUsx9+B1EKB1mM
 qyrY8q9vCwB/PZBg+BfZ986A6gW3h5yjKZMojzuhUBImaeGLULw6KtrlG5NLU8ssyr4WGNzCT
 XzjNbyZM70RKNPMz+CTbRqSNWBekgfBQUSoPMzQsDCNSc/E/zXh/M5g/CpHsU2CDzsqI0dS8v
 yhkD02xKZXPSvR+8MD1DiO3VhFSiKsTmVGEjyZYLmfYBxT8I06DfGI89cX/y8cesn5bc9kV7X
 NM1vmTW+xAJBTDLxdy1AOXM53QFn2UE+throVwv+gwNIi8HP4ZAySbITaGfofBhgliiXgNuiR
 yd4kknhU+7LaKAGdmg6QFr/zSehUugNNwh2sB/uCtWwcT9Gu8LP69lk2cDM/ILmtvVigb+ccQ
 9yddq8w1d5zJbCToJfJkuW6rO4FeS4fMlYL/5q+i7OSSWD1peIDn+oA5HemuPVBQ5DChKXWsc
 sRi8YPuLK9E+UKC9YhS+B7HQymwdiK9T+tRVzKy340nrB5fFxN8YXa2K1p13hEDPGnW+Vf7n0
 MTc6idJ6XjBNc0J902tNDEZEWFczlY9VTqzv1d7zjOZ2gdFtqdYpv190DtwdOO72bM29syyMr
 PiQwfqHbLbTPitcTRS9zyxpaq5AfjZvCP6k0bgg+jTobsJv4TH49anabEf2xxYaZwlT2tbYEi
 +KhLPh48+bFukk7lTvSw==
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

On Tue, Jun 7, 2022 at 11:47 AM Stafford Horne <shorne@gmail.com> wrote:
> On Tue, Jun 07, 2022 at 10:42:08AM +0200, Arnd Bergmann wrote:

> > Goldfish is a very old platform, as far as I know only the kernel port =
is new.
> > I don't know when qemu started shipping goldfish, but changing it now w=
ould
> > surely break compatibility with whatever OS the port was originally mad=
e for.
>
> Hi Arnd,
>
> As far as I can tell goldfish in qemu is not very old. There are 3 device=
s, 2 were
> added for the m68k virt machine, and 1 for riscv virt.
>
>     $ git lo -- hw/char/goldfish_tty.c
>     2021-11-09 65b4c8c759 Philippe Mathieu-Daud=C3=A9 hw/m68k: Fix typo i=
n SPDX tag
>     2021-03-15 8c6df16ff6 Laurent Vivier   hw/char: add goldfish-tty
>
>     $  git lo -- hw/intc/goldfish_pic.c
>     2021-11-09 65b4c8c759 Philippe Mathieu-Daud=C3=A9 hw/m68k: Fix typo i=
n SPDX tag
>     2021-03-15 8785559390 Laurent Vivier   hw/intc: add goldfish-pic

That is much younger than Laurent made it appear, from his earlier explanat=
ions
I expected this to have shipped a long time ago and been used in other
OSs to the
point where it cannot be fixed.

> The mips/loongson3_virt machine now also uses the goldfish_rtc.
>
> The problem with the goldfish device models is that they were defined as
> DEVICE_NATIVE_ENDIAN.
>
>     $ grep endianness hw/*/goldfish*
>     hw/char/goldfish_tty.c:    .endianness =3D DEVICE_NATIVE_ENDIAN,
>     hw/intc/goldfish_pic.c:    .endianness =3D DEVICE_NATIVE_ENDIAN,
>     hw/rtc/goldfish_rtc.c:    .endianness =3D DEVICE_NATIVE_ENDIAN,
>
> RISC-V is little-endian so when it was added there was no problem with ru=
nning
> linux goldfish drivers.
>
> MIPS Longson3, added last year, seems to be running as little-endian well=
, I
> understand MIPS can support both big and little endian. However according=
 to
> this all Loongson cores are little-endian.
>
>     https://en.wikipedia.org/wiki/Loongson
>
> As I understand when endianness of the devices in qemu are defined as
> DEVICE_NATIVE_ENDIAN the device endian takes the endian of the target CPU=
.
>
> This means that MIPS Loongson3 and RISC-V are affectively running as
> little-endian which is what would be expected.

Not really, the definition of DEVICE_NATIVE_ENDIAN in qemu is much less
well-defined than that as I understand, it is just whatever the person addi=
ng
support for that CPU thought would be the right one. A lot of CPUs can
run either big-endian or little-endian code, and e.g. on ARM, qemu
DEVICE_NATIVE_ENDIAN is just always little-endian, regardless of
what the CPU runs, while I think on MIPS it would be whatever the CPU
is actually executing.

      Arnd
