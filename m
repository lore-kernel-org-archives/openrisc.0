Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC8EC433EF
	for <openrisc@archiver.kernel.org>; Sun,  5 Jun 2022 08:19:53 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id AE50124216;
	Sun,  5 Jun 2022 10:19:52 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 0BDC824952
 for <openrisc@lists.librecores.org>; Sun,  5 Jun 2022 10:19:52 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2B3B7B80ADE;
 Sun,  5 Jun 2022 08:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C6C385A5;
 Sun,  5 Jun 2022 08:19:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="obdTTv7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1654417187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o24HQC0IbzRM+d2f5G9/kKh3ZrByIzzeza7EDocM5ps=;
 b=obdTTv7zxjjhGe+bHzWnn8fouuH2K6Q/9mne/epkE68iRwWm1S+OJS3umy9ytYHJ0dSz3t
 dPLc6m3he+aBEDNvwUxH8Kz4H8HW4cGfUF+XhkcXWK/sc8uy1Pca1yDNb52npYL/HVHuam
 KrCyOBm9Ggyu/1R2XBWiqcLXUcds5yo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4fc6aae6
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Sun, 5 Jun 2022 08:19:46 +0000 (UTC)
Date: Sun, 5 Jun 2022 10:19:41 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <YpxnHaaizsNpOjx8@zx2c4.com>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ypxb/VDfYLFg3n2s@antec>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi folks,

On Sun, Jun 05, 2022 at 04:32:13PM +0900, Stafford Horne wrote:
> Why can't m68k switch to little-endian in qemu and the kernel?  The m68k virt
> platform is not that old, 1 year? Are there a lot of users that this would be a big
> problem?

I also share this perspective. AFAICT, m68k virt platform *just*
shipped. Fix this stuff instead of creating more compatibility bloat for
a platform with no new silicon. The risks of making life difficult for
15 minutes for all seven and a half users of that code that only now has
become operational is vastly dwarfed by the good sense to just fix the
mistake. Treat the endian thing as a *bug* rather than a sacred ABI.
Bugs only become sacred if you let them sit for years and large numbers
of people grow to rely on spacebar heating. Otherwise they're just bugs.
This can be fixed.

Jason
