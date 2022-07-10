Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3AC43334
	for <openrisc@archiver.kernel.org>; Sun, 10 Jul 2022 15:54:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8AE4B24915;
	Sun, 10 Jul 2022 17:54:41 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by mail.librecores.org (Postfix) with ESMTPS id 8E9B9248FA
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 17:54:40 +0200 (CEST)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MMGAg-1ntRaT3qR4-00JGZb for <openrisc@lists.librecores.org>; Sun, 10 Jul
 2022 17:54:40 +0200
Received: by mail-yb1-f181.google.com with SMTP id h62so2604546ybb.11
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 08:54:39 -0700 (PDT)
X-Gm-Message-State: AJIora9Q1MT68bt8pbN5ffknm1Nc37/o8Bt6x3H8U4gMSslr5q8YAkL+
 sf1Lq+UcBtrYhDA0Gixf2TKZ1YuAanSn0raouAU=
X-Google-Smtp-Source: AGRyM1v76RqBo2D7VhFl4oAJQaPAg7TpvkmoPNin90N0WFoFrvnqtRzOLmYN6ml20bwZUgBEMBYB8fqRnilO9oXeKmI=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr13465980ybc.480.1657468478668; Sun, 10
 Jul 2022 08:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220709211549.1163327-1-shorne@gmail.com>
 <20220709211549.1163327-2-shorne@gmail.com>
In-Reply-To: <20220709211549.1163327-2-shorne@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 10 Jul 2022 17:54:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
Message-ID: <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] openrisc: Add pci bus support
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hBLzaZ7WZoOG4xLkAtlBx0xJ8yGCyVaGlwDSuLq+IRsY/wddOxR
 Q40Bksz2/YgNQdqFnGqF5PVbalRW/5CSV3lkOzflNjUWivwjvUdC/V3kS78Iqvaw0bYqiXK
 MG6UWbE1VI2miFpAD/vgDh1SQqmxNAucy99t4ppi5ItH9Fsz4xmOE4F290KqEUmczUwjPVV
 U2djDmh/l0WIuTkD1e/EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3CfsY8e5NfA=:oaMO07Ol0IN74vpbpBpLCm
 WCpV9tb4CiFntcRsnDelHvyJ45P1+RC9tRqS1mhBTFIGgFo/YtTBG6Sqzjtz+pNwC8NQVPDqg
 xPZKnMTXGC8TmhS+19Q8PzcgjxV1zh4XLeHKvlA016OYtNQBiRRmUonIapsXHFir+2Z7OaeGw
 kXl7Ydn9JUAXbnbGyeoGNEAGGA6dOMEvzSYH+FpfedXX1eP8g9f4PKSxtUqjaEAK5V9mSjvzR
 pJx1119UzWUpSk0ulW9BG768948fWTWqWPqLUYCrPxri3WNlADLbdPCwhqF8FnT/Z3h6SkW26
 wmhQJ0b0n6c7EBPhrgc8HJeuGFUI2bnnZc0PDlfUFKJJnLCNoLrZp871k+wlWK2TnptbJM/Gn
 YJzoFnxJNIo/WlHi56fGjUoUQMRVUqyvXUmEP/l8bYjTKTme0Sgta/yCEEXL9RMGAdUKBRyEy
 NCiqlSJ7PtxuSFJ3Ze2eLBvgbmi/EgKTg08fJ+wz7BpKF08CTxlpQN5oOjjvDOPj71ibXGOXE
 M/SwbsMzkdNyQfQQ8+Av17ZFQu53/wbpM3di69klcX5Ty8y1R1oT4d6yO5PJ6oQ+MFIQ70LWf
 ZOFLoGqWQ2vP8f6GRajE1F8ZDtugMoPLPEU/a3tVSp8D0PK7rh0oMe/xRuydzAq63mAiqQXPU
 xLdQXVs2nKal9MvX1RmIgPzYvcSLJoriRTJMTBxwf5W2js++CuDuLyRguSwP/rhQqO0TIBaPP
 OByiyl5ggeRY+xUTAK/kXvO19OtfEeTPR26Zvw==
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Sat, Jul 9, 2022 at 11:15 PM Stafford Horne <shorne@gmail.com> wrote:
>
> This patch adds required definitions to allow for PCI buses on OpenRISC.
> This is being in the QEMU virt platform.
>
> OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> MMIO for all IO.

>
>  /*
> - * PCI: can we really do 0 here if we have no port IO?
> + * PCI: All address space can be used for IO
>   */
> -#define IO_SPACE_LIMIT         0
> +#define IO_SPACE_LIMIT ~(0UL)

I think '0' is the correct limit here if you don't support PCI controllers
that can map their I/O ports into MMIO space. If you don't define
PCI_IOBASE to a meaningful value and set IO_SPACE_LIMIT as you
do here, every virtual address is treated as an I/O port, so accessing
a low port through /dev/ioport or a PCI driver results in an access to
a NULL pointer, which is either a userspace address or low kernel
memory, both of which are bad.

Most PCI controller are however able to map I/O ports into the
physical address space of the CPU, and in that case you can just
define an otherwise unused address as PCI_IOBASE and map the
ports there from the PCI host bridge driver.

       Arnd
