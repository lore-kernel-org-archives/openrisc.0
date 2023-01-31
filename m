Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683BBC38142
	for <openrisc@archiver.kernel.org>; Tue, 31 Jan 2023 15:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjAaPZd (ORCPT <rfc822;openrisc@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjAaPZG (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 31 Jan 2023 10:25:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1944B771
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:24:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m7so14550953wru.8
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tv8nZDkSKPegxMMxlkdN3bH3dixOsj4ChgLPbrH3vgI=;
        b=MBNMEuTWrEimsrkM5aFo7GtYLhSiWK4y8FukcgHl9B9xpu1f1tChlmVPhh0r+IVHRI
         +ZuAD4kncT2HQMTkwH+bG/2toFZldyqHsooeJiPK3h8KwXlOn3uzXStGh0CEkUjZsRhN
         akzgie2r9FCNYiwNEaVPQHJQSZEWc74Db/pGECsv4M2ZkhiowLSp+nF4tx9JQOHKqsrh
         erm/f54s+dC5Xd2otNdmAD6oIIO766F+zrM8zCELv47UQ5a3ewCbA9utY9EGZwSIoQrC
         AochdZGTX1SPvV+QouJJ+q2mGGosDJ+p1SKLwiLkiWmqlG9IocQ7jwfq2NbcvuVqeIY+
         8prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv8nZDkSKPegxMMxlkdN3bH3dixOsj4ChgLPbrH3vgI=;
        b=N1i8x5jeSnMhlQykuY2TQEsA3+3DUFj+Tw7Ijp5giJEm1cZfn8vUZaQ24ocMkZxZuc
         PiBCZQYoW5dmlWSLsgR1Hj4nviqbVICdVJv+KH1B9qgnQjjo7TWIIVfVFWbgEEkksq7O
         j33MoRlesdjFPOondPC4Vr9yZMDsnrsr1vGP60PeWLbXJBYlO/kjzAD/HH5Y3nev7sOb
         R7g1vUIEcJTnxdtO+LYyvt+QNbKgwSyKN2sXgN7y6GXayGaxjxkgPHhXGq3wwKUWuHRD
         jmcorJlvq5jOIkr0w5KIbBlnvddi3yq7f0FDhpXc+CJWobYN0t+WDSNMI9DcWZVfTuEW
         JUbQ==
X-Gm-Message-State: AFqh2koJf2aj5yv6XnIIwWIaJH2eJ0KimA8tjhjfolyMYgXTHh92GGgw
        wykDi2NTIt/j1ljCSHLMSiwZ7vuUwqM=
X-Google-Smtp-Source: AMrXdXvkwBbp+EbM4jNm32U+eIoo9M9DZBc2my+4cpsBGArrleO97urpU+GzknpNVJj92bSX/n7u9Q==
X-Received: by 2002:a5d:6e82:0:b0:242:5563:c3b with SMTP id k2-20020a5d6e82000000b0024255630c3bmr47370660wrz.59.1675178639271;
        Tue, 31 Jan 2023 07:23:59 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002bc7f64efa3sm14761785wrr.29.2023.01.31.07.23.57
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:23:57 -0800 (PST)
Date:   Wed, 1 Feb 2023 00:23:56 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: OpenRISC mailing list moves from librecores.org to vger.kernel.org
Message-ID: <Y9kyjEaTtPQ5sKeH@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-riscv@vger.kernel.org

Hi All,

After some recent issues in infrastructure the mailing lists at librecores.org
have been shut down.  This was brought to my attention earlier this week and we
have migrated all users over to to a new mailing list hosted on the
vger.kernel.org infrastructure.

This is good news as it should provide a very solid mailing list for our future
OpenRISC discussions.

Sorry, I don't have too much more information on whyy the librecores.org
infrastructure went down.  But it does seem to follow the announced shutdown of
librecores[1].

If you want to manage your subscription please do that via vger.kernel.org[2].

Next steps:
 - I have requested to get archiving setup on lore.kernel.org
 - I will be sending out a kernel patch to move the OpenRISC risk development
   patches over to this new list.
 - Need to update the OpenRISC website.
 - Update any other projects linking to the old list.

Thank You,

-Stafford

[1] https://www.fossi-foundation.org/2022/10/19/librecores
[2] http://vger.kernel.org/vger-lists.html#linux-openrisc
