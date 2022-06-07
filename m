Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D5C433EF
	for <openrisc@archiver.kernel.org>; Tue,  7 Jun 2022 08:42:28 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E4B2824895;
	Tue,  7 Jun 2022 10:42:27 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by mail.librecores.org (Postfix) with ESMTPS id 8100B24917
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 10:42:26 +0200 (CEST)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq2za-1nTKpH3U1K-00n6Y1 for <openrisc@lists.librecores.org>; Tue, 07 Jun
 2022 10:42:26 +0200
Received: by mail-yb1-f169.google.com with SMTP id y188so494694ybe.11
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 01:42:25 -0700 (PDT)
X-Gm-Message-State: AOAM532yXybhz4H+5E+7pLvfs1+P6VKyfpcNOc9B/FlF+yApMCWG2jMb
 1P0Tdak1aKDtusISHx74zxvzQbw1Kz+bb8h1maQ=
X-Google-Smtp-Source: ABdhPJxwjVDItlSrS0Al6JxMF6wQWQ9M771OSq4DvGMAHa7nSVUVMDBgXcT7K8EAkDFuyPvAEXPNZzO2/pl8+RGy/kQ=
X-Received: by 2002:a25:69c4:0:b0:65c:ed2b:9106 with SMTP id
 e187-20020a2569c4000000b0065ced2b9106mr28705119ybc.394.1654591344613; Tue, 07
 Jun 2022 01:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
 <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
In-Reply-To: <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Jun 2022 10:42:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Vpn02uDe3rdXSNXANY=u4ZM+wjm-qqszTXzjOKkAeEg@mail.gmail.com>
Message-ID: <CAK8P3a3Vpn02uDe3rdXSNXANY=u4ZM+wjm-qqszTXzjOKkAeEg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:51uQlDs6zhREqFh5uMLd01PDRSb/GQkEFEOzSECwpWsBf4yRKBn
 ToSk4EExX0AI6bYLqc4gUW9UVyL8c8kuqTMDQz0F6xd/IFIO+V3OkYjOZfo2BUoCnxm2PyZ
 04bGWohgw+g1IlD/pOnHCbwTfPai9Ks0bwvdLNGFomxZOdP93/gezpPKrcl+uXmjQ5iXgYe
 IbVUsxpjT9B+sGCBpolJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VWL5ffAqE7g=:nMWE+xu8zzJBipjxcnauWG
 FLLj4folc/f5k9sT2upZgIR45ErKvl3FCTz7y/FEZb+CPJBK8xFq6TM+ZRgMC79N84xXSAfM6
 reOJ2jr7Obr0KWD686nXviL2AP04ORDt5pLSB1+ktaAK18lTU69q0aaoaFP0HpXvgbB1PjJXx
 fBErM3AZdizaV5RuclBsuLWHq7N1BUvRYo1X4J2E8hFgNMDYOmkTZ43+0ucLaE33fZRd9F2y6
 ZYg0H5bl0DGFvb8U5GnfR6qPxpCCn9tcvhLKZIUcNcglEMOy9jTqwi1ZO4AIeqpxWxxcKvKUQ
 yke/TNXMIzi4MReQv/ciqYsKyQmFscjiFA6shBPPT6fWAHSRuRThkXbZcEhDNagJirzeH4q+B
 eaPgs8QmbuME0EWowm0hiZn8sede7f8sC43rlkK3o+INd0jqkSLothwvtMnXPrnskq4A8C0LP
 Sz/AO58znBHiQi4Qwqnvc3qKbEiGbBrhVhxVERHuOHUKMmxit1Y+JwkXqmpYaYx5EcJJz4ixv
 zld5JLR+UaZz26kPqSUxgC3zobnMuA6gQBG5h3OafNdKKZNUg7doAhZaUXtJwyBuscv4tT9kp
 q2AcrBqf09Z4IMSE1hwW2FdODEU9pl0sDucJK1EyurnUZI+QLe/ny8jRkrXNzXi479L3yAK5r
 Ng33MiCgJPF1vCitsknQP3ywjZ0uQncwEXxHiBdvXwvXIST/PXxgtP/VAhy2nTGfMY54c9dSH
 sSMQwpSf+BSO1pGLEwYvjynFsbspRqIvIJ3/ZkWIJ62cWVuvHJf26qJklCVIKB2gfi9A+1/iL
 KkZOmr6kCr6bhgJHAihZQSrxyikc+ydbW1bACXE4W978pxOmXELPMGv5dxRDsMHkYCfV6MeQf
 3QP4OUB7mkWB9tqYpe28lvnCBE/EorQJSzSM9vR50=
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

On Tue, Jun 7, 2022 at 10:11 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Jun 5, 2022 at 9:32 AM Stafford Horne <shorne@gmail.com> wrote:
> > On Sun, Jun 05, 2022 at 10:58:14AM +0900, Stafford Horne wrote:
> >     It might be a good idea to revisit the qemu implementation and make
> >     sure that the extra byteswap is only inserted on m68k and not on
> >     other targets, but hopefully there are no new targets based on goldfish
> >     anymore and we don't need to care.
> >
> > So, it seems that in addition to my patch we would need something in m68k to
> > switch it back to 'native' (big) endian?
> >
> > Looking at the m68k kernel/qemu interface I see:
> >
> > Pre 5.19:
> >    (data) <-- kernel(readl / little) <-- m68k qemu (native / big) - RTC/PIC
> >    (data) <-- kernel(__raw_readl / big) <-- m68k qemu (native / big) - TTY
> >
> > 5.19:
> >    (data) <-- kernel(gf_ioread32 / big) <-- m68k qemu (native / big) - all
> >
> > The new fixes to add gf_ioread32/gf_iowrite32 fix this for goldfish and m68k.
> > This wouldn't have been an issue for little-endian platforms where readl/writel
> > were originally used.
> >
> > Why can't m68k switch to little-endian in qemu and the kernel?  The m68k virt
> > platform is not that old, 1 year? Are there a lot of users that this would be a big
> > problem?
> >
> > [1] https://lore.kernel.org/lkml/CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com/

Goldfish is a very old platform, as far as I know only the kernel port is new.
I don't know when qemu started shipping goldfish, but changing it now would
surely break compatibility with whatever OS the port was originally made for.

      Arnd
