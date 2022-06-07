Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF11C433EF
	for <openrisc@archiver.kernel.org>; Tue,  7 Jun 2022 12:12:14 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id C2E8724917;
	Tue,  7 Jun 2022 14:12:13 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mail.librecores.org (Postfix) with ESMTPS id 0D72E24917
 for <openrisc@lists.librecores.org>; Tue,  7 Jun 2022 14:12:12 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id q140so621096pgq.6
 for <openrisc@lists.librecores.org>; Tue, 07 Jun 2022 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GijARRYnxL8YO0+sEq7CgmOSfAqFvvakkFBsv6at5Ao=;
 b=QjzQzhgN46s/kESurvy5S4WXixwl3Jm+2nFPnTlxnjoSrWHmBxRXLsMr3HMecO2Vnr
 lfVnS8JFp0oF1rJXEjgZEkvnIK3V1pb+p2LJLKQCKwpe1GJTL5x9JAVxRpf5ZZSmyFC8
 Qh91hc5xUPBJfy0S1PAulnlR8qZAEFmhM6vCI8l+iCJmD8MzC3lj2njzB1l0jgKRoVLj
 +J6d+GMrx8b4RUDTxxHQNafJTXpvnQGSbkhaqCIebWwJEFADOyWOQumc0WlnZasuDu85
 uC1xwpDV4Vg2XPBCEjsn4vm412qsUYFOKz9mZyIPWK5l3s30sdhQltu2bDmO8pbGa9PK
 kiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GijARRYnxL8YO0+sEq7CgmOSfAqFvvakkFBsv6at5Ao=;
 b=dWXnSXW4Nlw9V8f7XFhzkBU50OeFiLpHTCDYDmoHiMfCJmqYZgZioUiDtmHxmJZxNc
 7U1gSX51YL4c/uqtF3/u5wzsigRyQppZVXRM2SBMHn8UMMKh2Z0fKqi6pj73qFAp75Oo
 weJ4yVuovQIZlqGC3+yiUoGoagbGrNbzn2XVYb4w6Qh18I0luXk/6VZR3IuOF07CVgq9
 Z7tYvkrsjQYbH9yEUVJFCkO07c2hDxbNaD3EgdEV4wOzxhLPwK1uS12h+l8w2h3+Tj3Q
 qFLUDnWc/FeqF40QwDyq292KPlX5V18+04KnPoRdMacdLTpWc2o2tfI0ZLMQE21VHzFY
 Y8Zg==
X-Gm-Message-State: AOAM530D2NLn/6iQVUrdJhGoyReJIQjTve73PnSoG3hKCzyrDJUItgBa
 VZb0JjJgH3QCSWtFdUSMMg4=
X-Google-Smtp-Source: ABdhPJwCSCn5Byw+9714s59/vTRyhGwy+WF9gUTl/b+De7VI8bPEHCvQiZzq5tYWiT59Mdr5aE1XgA==
X-Received: by 2002:a63:f003:0:b0:3db:84d3:743d with SMTP id
 k3-20020a63f003000000b003db84d3743dmr25232916pgh.97.1654603930382; 
 Tue, 07 Jun 2022 05:12:10 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b0015eab1b097dsm12335643plb.22.2022.06.07.05.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 05:12:09 -0700 (PDT)
Date: Tue, 7 Jun 2022 21:12:07 +0900
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <Yp9Al1UfqvIzStI7@antec>
References: <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
 <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
 <CAK8P3a3Vpn02uDe3rdXSNXANY=u4ZM+wjm-qqszTXzjOKkAeEg@mail.gmail.com>
 <Yp8epZsizfKMEVZV@antec>
 <CAFEAcA97oraa5OSdqmubmJ2-ONTCTF4ZszwfTcZ9VhqKRFhogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA97oraa5OSdqmubmJ2-ONTCTF4ZszwfTcZ9VhqKRFhogA@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 11:43:08AM +0100, Peter Maydell wrote:
> So I don't have a strong view on whether these devices should
> be DEVICE_NATIVE_ENDIAN or DEVICE_LITTLE_ENDIAN (except that
> my impression is that a DEVICE_LITTLE_ENDIAN device on a
> big-endian system is a bit weird, because it means the guest
> has to byteswap everything. You see that with PCI devices because
> the PCI spec mandates LE, but not often elsewhere).
> 
> If there's an official-ish spec for how goldfish devices are
> supposed to behave (does anybody have a pointer to one?) and it says
> "always little-endian" then that would probably suggest that fixing
> m68k would be nice if we can.

I think there are some conflicting thoughts on this.

In Geert's he mentioned:

  Using Goldfish devices as little-endian devices should be fine.

In Arnd's mail he mentions:

  https://lore.kernel.org/lkml/CAK8P3a1oN8NrUjkh2X8jHQbyz42Xo6GSa=5n0gD6vQcXRjmq1Q@mail.gmail.com/#t

  ... the device was clearly defined as having little-endian
  registers,

Based on that I was thinking that switching to DEVICE_LITTLE_ENDIAN would make
sense.

However, in a followup mail from Laurent we see:

  https://lore.kernel.org/lkml/cb884368-0226-e913-80d2-62d2b7b2e761@vivier.eu/

  The reference document[1] doesn't define the endianness of goldfish.

  [1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT


The documentation does not clearly specify it.  So maybe maybe or1k should just
be updated on the linux side and add gf_ioread32/gf_iowrite32 big-endian
accessors.

-Stafford
