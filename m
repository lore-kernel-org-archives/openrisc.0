Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F447EB64D9;
	Fri,  7 Jul 2023 21:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGGVRP (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Fri, 7 Jul 2023 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGGVRP (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Fri, 7 Jul 2023 17:17:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79178BC
        for <linux-openrisc@vger.kernel.org>; Fri,  7 Jul 2023 14:17:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31454996e06so2159777f8f.2
        for <linux-openrisc@vger.kernel.org>; Fri, 07 Jul 2023 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688764632; x=1691356632;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xu7YxKJmYph9QJyiKNUwRCUSNvsHYU4XYxivp2t68rs=;
        b=JuuRXBrbmQf0FhR8YlU5ZtQPea7hki4kvkDFuJvXNhhZqjVzpBUhdTypK4tuHLFaQx
         sbvpxhKh1N3K5e+kZXgD/GJ3daimCXWjyih/1XlbJEHkQqGvez8/JMOiVf/ee2M1Oj9l
         tIQeljtVOYSsC1itUjsMFneyrAomsXg1mghtOTGaw3n/qiPJpH0FtXTECbkLqWtaNw4+
         H9Hv88cn0d6JDNAFFSD3QVUCBjJTPCc8xuM+9d+jqaHjPew1CcVYQsqoRwGfmMv0eSEv
         h5oHA3Dug4bre7PDA/RMzNaPg10qZmz3ph+kJZQCYneozXSKYRIkVxS0iee4GEa0CvEz
         X2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764632; x=1691356632;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu7YxKJmYph9QJyiKNUwRCUSNvsHYU4XYxivp2t68rs=;
        b=Co2rJXO6Pu6opQna7RMb+533JXr5Y2mwBRqbBAVFItaY86Z6pSn4yT5SWAVzeU7n8y
         ih0DxYelQvf6qX9GEKuprXY9KUKIAOIfisuG02RapUDnWdyxITxdMZKeG6G32j0C18x+
         J2WVIoentm/LEPfVgc4Gxz7eHWTp5lmaToL9cUsXGVpq0MQifoE5hoAxR0PQ6JjHrVPe
         gMGKUF34YM6rAhphCbf8LbQwtPxGsCrn0Yl5JDgZ3nsFq9AA5wXJKezFDhMwqdbRoKTl
         gwrWkiCYumXjca7X1DRcuejkbXkAOIhjZ6sllTQODObwzxhcwtRpPge+HgxwXTpIdSZi
         5CFw==
X-Gm-Message-State: ABy/qLZ/byL6gfMbFFCLdj/XUx/z4pUSMtHVtU42hOcQZ9UueVCwf/oY
        hn3jde8frJYJNODPuZTX4WXmS3GgAEXMZg==
X-Google-Smtp-Source: APBJJlEapiD0Dkp/J6P5PYH62h2RnKxuZ5Ah5VEa8FCkLN6eXCXp55h7thPb3s7TvqWd744C9Ioj3g==
X-Received: by 2002:adf:f20e:0:b0:313:eadf:b827 with SMTP id p14-20020adff20e000000b00313eadfb827mr4746659wro.56.1688764631585;
        Fri, 07 Jul 2023 14:17:11 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6190000000b003143867d2ebsm5329370wru.63.2023.07.07.14.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:17:10 -0700 (PDT)
Date:   Fri, 7 Jul 2023 22:17:10 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     helpdesk@kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Mailing list archives for openrisc.lists.librecores.org
Message-ID: <ZKiA1mwNXnKl3Swt@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Hello vger/lore admins,

Previously Geert sent this mail, but it was at the end of a longer thread[1] so it
may have been missed.

Is it possible to:

 1. Add the openrisc archive[2] link on majordomo vger-lists page[3]?
 2. Add old list archives to the openrisc archive[2] from Geert?

There is an openrisc-combined.tar.xz archive on Geert's google drive here:

  https://drive.google.com/file/d/1by9h5WbyWEaTtTcwxwBUmbQX6uX6xaGK/view?usp=sharing

It contains multiple List-Ids:

Description                               dates     List-Id

Official OpenRISC processor discussion.   2014-2016 <openrisc.lists.opencores.org>
OpenRISC Linux                            2011-2018 <linux.lists.openrisc.net>
OpenRISC architecture discussion.         2013-2015 <openrisc.lists.openrisc.net>
Discussion around the OpenRISC processor. 2016-2023 <openrisc.lists.librecores.org>

-Stafford

[1] Message-ID: <CAMuHMdVK_CQXWUuvxZOavNfDTbik1rETj+2aJ9-5Yi7-ttop8A@mail.gmail.com>
[2] https://lore.kernel.org/openrisc/
[3] http://vger.kernel.org/vger-lists.html#linux-openrisc
