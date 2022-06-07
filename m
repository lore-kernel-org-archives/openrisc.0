Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B4CC43334
	for <openrisc@archiver.kernel.org>; Tue,  7 Jun 2022 14:09:15 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id BE7FE248F5;
	Tue,  7 Jun 2022 16:09:14 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by mail.librecores.org (Postfix) with ESMTPS id 1B2F72425A
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 16:09:13 +0200 (CEST)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7Qkv-1nhsZB1Xtl-017oHT for <openrisc@lists.librecores.org>; Tue, 07 Jun
 2022 16:09:12 +0200
Received: by mail-yb1-f178.google.com with SMTP id p13so31347706ybm.1
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 07:09:12 -0700 (PDT)
X-Gm-Message-State: AOAM530UskvvJBi/j0wLnTr7eACEEwhExX90ZiKqy5VVnoI/OR+UPhKP
 j/WZ826OhRWcXy/8qNZjuPA5ot4lgCjgBz+/9hY=
X-Google-Smtp-Source: ABdhPJyrHRdcbFGwgQucIuXA511ekWmgPkpq2r3VzjMQDT7UGkzBdYp57tesIEB5uEfd/qHoqMrZCqWLJTK4O/DiuVI=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr29767520ybx.472.1654610951039; Tue, 07
 Jun 2022 07:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
 <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
 <CAK8P3a3Vpn02uDe3rdXSNXANY=u4ZM+wjm-qqszTXzjOKkAeEg@mail.gmail.com>
 <Yp8epZsizfKMEVZV@antec>
 <CAFEAcA97oraa5OSdqmubmJ2-ONTCTF4ZszwfTcZ9VhqKRFhogA@mail.gmail.com>
 <Yp9Al1UfqvIzStI7@antec>
In-Reply-To: <Yp9Al1UfqvIzStI7@antec>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Jun 2022 16:08:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a13PTsMExyXZm5sZM3WBK-8hoNFjYoi19pHmKKCJQmHeA@mail.gmail.com>
Message-ID: <CAK8P3a13PTsMExyXZm5sZM3WBK-8hoNFjYoi19pHmKKCJQmHeA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5ivZ7OVdGsuh2sUNrv1iv65YijLanJLupMyQ1LxJdIUBQOvIp13
 QMzEMxjLl0jJoY0Xq6qNlQ2OqRYCkgXlSljuRzsVVldiN6bgk9WzBccqkRcGNd/+00ZF9rD
 iiCaW59YUeGiOigbLpJMa0spYBn1443ZVuqwM2ZJG6FiNsZt1Wh1ZpqSO1hvuAk/TAgv+IS
 RqHvEwVx4Heb+apWOfd0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:quEVUw7sUyQ=:8KCyJAiuIbGvrtiLiIqO1v
 ZxAUiFPp+ZkkNzCl6ZTy9jhoGjIZzwHeajS8R21j1clKgza8lD1merWvUSrYOZAH+5TX7s2FS
 jq04C641EkdRNBonuMcDrw2XfyO4sjnooCr2lZE0jhWm+gAtgygDZiexKw9Aw0GN+IwlwbZG4
 drpSOw5rZtLryx90xsy8w5l7jcAvDl7ZDqolhb57decKjLhkl8Ms7Mmzk/tPKsPZKf+v9HvoW
 8I6YPmaxT4dHC3jfrc5VkkvU60l3dvlaiKfMeh8XBq8alqszKoO/gdW3G0xU8hiobqgzNDjZ+
 VPYvnQF7bebBcy8ZVC0ODGjFvxlAKMMMM/e3+j0C+eQ8jvTGYJRrISemR+9nkvhypTIzetJ9X
 wbu/rna+NehRaERZcoMOpTtWqRQkRtDgRwFzb7o2iplBwy12aCmsPYgquJ6EqkuyPsj8IJDrd
 7oeC6GLYZuYc0EIjWd8KSCw8U+t95LUwNMuUDYRWS9H1PqVeSTxbC9neaSx/KEdn7Z8fBFcil
 jfT4Lf6qS9FOMYgoj/HH5rateCJxIHgw8p2QLNwJ8FYsFFGfm2ZUjcg+23etHaf4JVW/0Uwj9
 jMCeztWL8E/V2UzCxG5u+ErnwRLH58/ZanO8k0oE5ZSO9Y5qMoQ0gyOCU4u6rmhlNxlT9htdy
 ed6OLoV8XbMEA9hJHN9I1tpO7nsUuFo4YR3Dk2B93qXItAsueNNX2ad4u6MP7WSa8Z9CPHQOa
 2WW9pZUXrowvgIErvgdlRSSjV/myhg/cqoQ5W+EF6h6cykhsAHJcHN9q2Zqsz01V6jW+y/x01
 hsTY8FaaYLcUojTE7QRVzYp4qO9p+UlnV46QIpN041o+vlgh37HXQtxml924tgE3+2NkDi2/x
 i4UIPfvNb3rCnVlzzO2w==
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Arnd Bergmann <arnd@arndb.de>,
 QEMU Development <qemu-devel@nongnu.org>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Jun 7, 2022 at 2:12 PM Stafford Horne <shorne@gmail.com> wrote:
> On Tue, Jun 07, 2022 at 11:43:08AM +0100, Peter Maydell wrote:
>
> However, in a followup mail from Laurent we see:
>
>   https://lore.kernel.org/lkml/cb884368-0226-e913-80d2-62d2b7b2e761@vivier.eu/
>
>   The reference document[1] doesn't define the endianness of goldfish.
>
>   [1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
>
>
> The documentation does not clearly specify it.  So maybe maybe or1k should just
> be updated on the linux side and add gf_ioread32/gf_iowrite32 big-endian
> accessors.

I don't think it makes any sense to use big-endian for a new
architecture, just use
the default little-endian implementation on the linux side, and change
the qemu code
to have the backward-compatibility hack for m68k while using big-endian for
the rest.

       Arnd
