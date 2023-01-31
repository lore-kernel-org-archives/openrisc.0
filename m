Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235BAC636CC
	for <openrisc@archiver.kernel.org>; Tue, 31 Jan 2023 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjAaPmL (ORCPT <rfc822;openrisc@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjAaPmL (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 31 Jan 2023 10:42:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21130B22
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:42:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so5364786wms.1
        for <linux-openrisc@vger.kernel.org>; Tue, 31 Jan 2023 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Wf1FHW7SzcFQqxd8HUVQGpOCumj2ozDhCUYOXY3XkQ=;
        b=EUgdDDsKbgQeA44LWpqsSaChCGjFlopkpC12U46W7sKjMBsvCzAUhmgiw36691lLq7
         U8Ycp6/LLoTNdk/Ev3W2ucnS5ASFK0GLv5r7hSYaHFeEtbuw2+AyemkpBpxhKF8aVxZE
         1yQM2EGy2YfsxGSgkNhT0IcbEM3tkFE52oIgGBSdlhKlwKLT0U73GzlHyCNooj8CmGue
         C5kC4jyfw7ybwIyxDJU+1Dpxa6Bria8Y+ULcJ0NWZVLXf6zxRdcQaBa9W6oAjLIWAQ9h
         yIwE/eLVNRVbN5frl/Q4EASYD3WPcgvW51SVqRoLP8VwYTD9Il899pF6JiT+XSw/Y4Z+
         EwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wf1FHW7SzcFQqxd8HUVQGpOCumj2ozDhCUYOXY3XkQ=;
        b=uK05u876g1mU/HKm7IxJrIBp5xa0YOBxjWUVIY5hAxgqdFbOWhY2CXZUi2lqHVvteB
         gseAUpnkUz2w4rR0Sl4H7ihb9ZKBfhLfED9jsr+4JOgCJj2ZbwekQ0uF+NwC5RJQOFjQ
         /BeHKzk4MBnyx+Okj9jvNn619gNeHvmke+nky5TlBZy4miIqWOLoS/1Z6yYj9++dtfqW
         CZE4/nQOJh8j6A4USdVUIuzk1GI9L4BfIzkhORBALlUNuqBq6otiipmLc7LyQp0ZA1lp
         YLMPUjOD7q9MHRjSarOWH9LtkWUc6Ijs0/RdNQVfQ7kQ++AkIJ6TxYQXl2vh4NFbH5nY
         5pYA==
X-Gm-Message-State: AFqh2krGC/LxWMaM7aTlfjOnfCkn0xZ2T9l1hlJ//+LsHlmdzWBfLJeq
        U7adCS9Z4sGHGB44oSaGtxgJQ04WnlM=
X-Google-Smtp-Source: AMrXdXuOH8LYXPsiVDGoP5qZ/z5A9rnr9JryxZ1nd7cw/xkif9e5aj4OCKESr4Cr734MJ03ECMgWjA==
X-Received: by 2002:a05:600c:4f56:b0:3db:1f68:28f with SMTP id m22-20020a05600c4f5600b003db1f68028fmr45777311wmq.24.1675179728762;
        Tue, 31 Jan 2023 07:42:08 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b003d990372dd5sm22733574wmq.20.2023.01.31.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:42:07 -0800 (PST)
Date:   Wed, 1 Feb 2023 00:42:06 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: OpenRISC mailing list moves from librecores.org to
 vger.kernel.org
Message-ID: <Y9k2zjTd246QCDVO@antec>
References: <Y9kyjEaTtPQ5sKeH@antec>
 <CAMuHMdXiV92J538Yq-yFi0b25u2GSEoR6XAW5t=kR2dR3dEXDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXiV92J538Yq-yFi0b25u2GSEoR6XAW5t=kR2dR3dEXDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-riscv@vger.kernel.org

On Tue, Jan 31, 2023 at 04:35:30PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Tue, Jan 31, 2023 at 4:25 PM Stafford Horne <shorne@gmail.com> wrote:
> > After some recent issues in infrastructure the mailing lists at librecores.org
> > have been shut down.  This was brought to my attention earlier this week and we
> > have migrated all users over to to a new mailing list hosted on the
> > vger.kernel.org infrastructure.
> 
> Thanks for taking care of this!
> 
> > Next steps:
> >  - I have requested to get archiving setup on lore.kernel.org

We do have most/all of the librecores.org history archived to lore already[1].

[1] https://lore.kernel.org/openrisc/

> Do you have a good archive of the old mailing list to populate lore,
> or do you need help to fill in some gaps?
> 
> My local archive goes back to November 25th, 2013.
> Oh, it was called linux@lists.openrisc.net those days ;-)

I don't have that old history and would love to have it up on lore if possible.
Let me CC you on my other mail to see what we can do.

Thank you,

-Stafford

