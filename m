Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5643FC636D4;
	Wed,  1 Feb 2023 19:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBATth (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 1 Feb 2023 14:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBATtg (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 1 Feb 2023 14:49:36 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD95CFFF
        for <linux-openrisc@vger.kernel.org>; Wed,  1 Feb 2023 11:49:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c2so4955402qtw.5
        for <linux-openrisc@vger.kernel.org>; Wed, 01 Feb 2023 11:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/De/5Abb06qSy8ya/WMDYMfRib3OqkWWHvsU7pm17ck=;
        b=aWtSCMhO/dGGyo9lveTYvdAySFgAVF5K2AVBvO7LOBWNMYTtCYoKJi+7ucCjbZLsI/
         /YwGIVi8kwUEaJx95qYp7aTDxid5jUFNjdawrGdZ4CdxhmhlCtnYuEFYiv4HVXoJeLRq
         /2O17kC4llvbnlmYX0tbuAnEknm1T52upl7J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/De/5Abb06qSy8ya/WMDYMfRib3OqkWWHvsU7pm17ck=;
        b=x+dtQSL9DJrtEiB6MKXk/prZo6tQaeHUBEM4mfLnAZD+7stxQLh/ABL3CsHvVGcyLq
         QlJ+Ab2nshG7rKkiR7ygkzd8iHoHi2F6qD4u49jfNit3Rx+1Se5jDNAeTv4P+7N0MAk8
         QxRcMU8G91r0aP9E9rPjiHdGgoAtNGu7wVzGsHl/IY8oiPK9vnlxxK6WvOlee9AVOhJI
         JCzcBl2cPBq6slOGjg2Ez9YS29lZWt58uxh+qNisDDxTllyjpDzVSX+Ls1vLnza0s9BB
         F33/rZkqbpASLcxlcXQKJEdC3gcNQSiWQtk4KjL0SsAyOam1q1SOig+OubyvQuiPY5gf
         uB0Q==
X-Gm-Message-State: AO0yUKWWR94wvClsrZwR8jpQQPqFAOC/5cqMvCH0B6N80m7XpYiY2WL2
        LbRGwvwr388HcH53y7+v/oYkYWEhYJmuenN9
X-Google-Smtp-Source: AK7set/N/kNeoPGy/GkgsQw5mEl/BDR+Refaa8KoFHKcBz7zuL66vEqUvLyvnd8ptnjDKeRwVzBfJA==
X-Received: by 2002:a05:622a:1ba2:b0:3ae:2272:e43c with SMTP id bp34-20020a05622a1ba200b003ae2272e43cmr5544016qtb.29.1675280967140;
        Wed, 01 Feb 2023 11:49:27 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id z16-20020ae9c110000000b0070617deb4b7sm12392826qki.134.2023.02.01.11.49.26
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:49:26 -0800 (PST)
Date:   Wed, 1 Feb 2023 14:49:25 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-openrisc@vger.kernel.org
Subject: Test archiving with new list
Message-ID: <20230201194925.cbmld7fpvm2pfgsu@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-riscv@vger.kernel.org

Hello:

This is a test to make sure that the new list is properly archived on
lore.kernel.org/openrisc, continuing old list archives.

-K
