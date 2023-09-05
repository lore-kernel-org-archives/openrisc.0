Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B486CA1004;
	Tue,  5 Sep 2023 16:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbjIEQXp (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 5 Sep 2023 12:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbjIEEIm (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 5 Sep 2023 00:08:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A5CCB;
        Mon,  4 Sep 2023 21:08:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1838855f8f.0;
        Mon, 04 Sep 2023 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693886917; x=1694491717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2SDAUpknhys9o+6tPMB0iQft2FfIs0q3U3aWMpY+Rw=;
        b=kFCzvx1rB8rNTH0ey2839A7o04LLo0QpzLdQbB4Ie0zHyxH7ANUoe78q4v1qJNegFf
         kPhOqKDIK94F0pKMNL1/7/8dcRYH23AOj7Fa0DQw1c3KiUhVoDrPNCQalT/ogEoYfJC6
         Vxk6YuSdcum7pWm4I/3KzmDCAfK1gO0alQkjw9Ny0U46sC34ott92cNjSX0Al0KSM8iF
         aGVjxAhAw/iDHS12ychN/PrPhg0t/FNx+CFhUIf2UOwVvcwNRKH75uvtvdqhr1cGHTaL
         dQcLxF2bkydLW91qVNlzoiDNSY2zc4YFEpLZzgKaMGIhOM6cquO69qmwLBO9Mh9y/3wY
         QzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693886917; x=1694491717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2SDAUpknhys9o+6tPMB0iQft2FfIs0q3U3aWMpY+Rw=;
        b=lK/DHNGxsaB6vLm/8tgeEwLSnLXRDwXxtmqRBohIc9tzdICgVUpwLdW8D7ywz101YD
         Puj18sFxpuy8FC4q23dnLGs08LIgnpeNIkxofqMNTEbOLcv/sRjeO2AhA7tEFmngKR3X
         X5/md3oewGu0ObXdlki7OBwkWU9LaSnfkclIyOIXz2khkWtzKcDYbALo0pLDFnGCrao+
         nEDK7B2Ma4c2mpGZuyYuQ/F7tzTxQ1QK2sY27O3DcZsMHFZ3xjyXL1DtsXi8SSu5Bae+
         0u5klcROh2hqwcsPZQW1fGXobPLm7x2htP/LmvCSGdjYAMVyUlLvT+DvP1HDhyJRrVxr
         /40Q==
X-Gm-Message-State: AOJu0Yxl2R9ui2mvGBXm/4lj+/0x0qhqNpRft2LuXfD0Q8K6YByaIz6V
        h4uphWuQxPWzK2+9Or8kr3o=
X-Google-Smtp-Source: AGHT+IEhLMAL77uDRJa7fHqfmvc43+KTiHZ7By1R8NBsBj7DRTfZmee4HsR+96MVsm8712C/neD7zA==
X-Received: by 2002:adf:eac7:0:b0:31a:dbd1:bf6 with SMTP id o7-20020adfeac7000000b0031adbd10bf6mr8688921wrn.68.1693886917228;
        Mon, 04 Sep 2023 21:08:37 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id r19-20020adfa153000000b0031f2dea4810sm11819574wrr.61.2023.09.04.21.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 21:08:36 -0700 (PDT)
Date:   Tue, 5 Sep 2023 05:08:35 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] OpenRISC updates for 6.6
Message-ID: <ZPapw7PQse62TjT+@antec>
References: <ZPYuGlUw9K2PcShj@antec>
 <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Mon, Sep 04, 2023 at 03:37:31PM -0700, Linus Torvalds wrote:
> On Mon, 4 Sept 2023 at 12:21, Stafford Horne <shorne@gmail.com> wrote:
> >
> >   https://github.com/openrisc/linux.git tags/for-linus
> 
> Nothing new there. Forgot to push?

Oh Yes, I forgot to push.  the tag is pushed now.  Let me know if you need to send
another mail to trigger your process, ohterwise it is there.

I will figure out why my tooling didn't warn about the unpushed branch.

-Stafford
