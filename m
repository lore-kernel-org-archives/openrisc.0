Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAE1C43334
	for <openrisc@archiver.kernel.org>; Tue,  5 Jul 2022 00:53:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1A802211D5;
	Tue,  5 Jul 2022 02:53:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mail.librecores.org (Postfix) with ESMTPS id EF3ED21052
 for <openrisc@lists.librecores.org>; Tue,  5 Jul 2022 02:53:29 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8A118617FF;
 Tue,  5 Jul 2022 00:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5C2C3411E;
 Tue,  5 Jul 2022 00:53:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="eRlWDnT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1656982405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBj62MjJ2VIbiGWs/eNHFVJd5tihvIWhRW+pstEVFFg=;
 b=eRlWDnT5ghp5r2IdRoKNpM5LbEBcUFbexszN8zJCvE+EMHHsE242BXPkbfcFc5ahWdALTL
 ATFiSIYIz1oY+DCgny/y37O2EhSFNK3DfbxfITFvJ0OasqqTSXhROz+U87wEs8ZCSmPt2u
 ikAguaBR/YIF0tbqZCnpK7peeDG4Iiw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e151ae2
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Tue, 5 Jul 2022 00:53:25 +0000 (UTC)
Date: Tue, 5 Jul 2022 02:53:21 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
Message-ID: <YsOLgWl0N8RFvZyc@zx2c4.com>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
 <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
 <b8d2595b-c86a-b1b8-8912-13fc9ba782d3@redhat.com>
 <31017a43-3ebb-0aa3-f6ce-d2df1b5dc177@linaro.org>
 <78ac87ee-e40b-8d18-3775-4417edb74fa3@redhat.com>
 <YsNQP9UJ5faHNguC@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsNQP9UJ5faHNguC@antec>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup.patel@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Development <qemu-devel@nongnu.org>,
 Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Jul 05, 2022 at 05:40:31AM +0900, Stafford Horne wrote:
>   riscv{LE}--------------->goldfish_rtc{LE}
>   mips-longsoon3{LE}------>goldfish_rtc{LE}
>   openrisc{BE}------------>goldfish_rtc{LE} (LE to BE conversion done in driver)
>   m68k{BE}---------------->goldfish_rtc{BE} (only big-endian user)

I wish the powers that be would lighten up a little bit and let us
change m68k to be LE, and then we could avoid all this...

Just a last grumble, I guess.

Jason
