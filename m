Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC163C636CC;
	Sat,  4 Feb 2023 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBDKUq (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Sat, 4 Feb 2023 05:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjBDKUY (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Sat, 4 Feb 2023 05:20:24 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103CE05F
        for <linux-openrisc@vger.kernel.org>; Sat,  4 Feb 2023 02:20:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j25so3043535wrc.4
        for <linux-openrisc@vger.kernel.org>; Sat, 04 Feb 2023 02:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xd8Fo9eEbiipsNS7nTIvRFcpVmP7SyPhpJM6alSmhc=;
        b=Dzv+7V3rvCl0E73Dedt5n12r3A+g3l/iAQFHrrLY28oCwbXPEzZ8cEmmDllMfsyf7b
         ERqfVu3KShTSmiN+QBBYcr9U2o6XNoq0GRdlRgh6ApKraF+hDFW1X1W2zb0sTDc53L/W
         b//QkXDrDGbkoo8BHx2mRzDSiCUKhQs9dGwldv1l7o33xqfWbOvdnXixYRKFEQ3lH0w2
         5JpGI9chi87WHH7iK3wvLFAMJw018RC6KcqdU/Lg7mClCdHhH7BPbmtdy2uN/CQ4C3QF
         6AjsgxjzGpkc/1CYzpTlC7Xmvr1VEEeA2pbumZ6efDne7xtRUoB3OlJ3SfrfoTmoe6Bf
         7s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Xd8Fo9eEbiipsNS7nTIvRFcpVmP7SyPhpJM6alSmhc=;
        b=qcrKVpRkWyvmIcwOqfLX+5C/rXznY0IeSQ1wKNVHnCLq0ya2kwKBHGnV4+Zf7RuFDk
         74lFkn9+IiPSPdRUGjf7HVgu43N1noGF7GEY4+ZNOC5PQpxBlWAuN9Rx+nXGSGnXlPiJ
         r4kszWT/NLKeNOYesOUewWNaMj56wguoi1tmlvhHJl++wXVvcYumfC2OIB71FgFdoipr
         A4KHjlD2YfcdyfYwMmijWe6Uu0qp1FRG64z7tTJTnl4KUB/i8SrWQigCzfpcJh7tuxlF
         qyKkSHj87YWpocVK9Pu0N3Ic4WiVrPql0iBE6LhKIRXoMJyN7kw/OtzDqebYqIgPFnrQ
         NEyA==
X-Gm-Message-State: AO0yUKUPHjJhPv7fn7iqEH9k+Cd9JBu2yJWRgBUlLT4jK9RmArKld1T0
        Fz3ig1fenEjAnV+Ly+hOrIwrmrHSK5I=
X-Google-Smtp-Source: AK7set9I+HUR6vYce54tLgGhhWsPZI/9TejN7TolYZVObdPntnQCtiZQLXqmsz9S+qbB4kjlxso9Pg==
X-Received: by 2002:adf:dfcc:0:b0:2c3:d65e:d12e with SMTP id q12-20020adfdfcc000000b002c3d65ed12emr3847751wrn.71.1675506018728;
        Sat, 04 Feb 2023 02:20:18 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id w7-20020adff9c7000000b002be546f947asm4061798wrr.61.2023.02.04.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 02:20:17 -0800 (PST)
Date:   Sat, 4 Feb 2023 19:20:17 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Subject: Re: OpenRISC mailing list moves from librecores.org to
 vger.kernel.org
Message-ID: <Y94xYXIMBAGdnubl@antec>
References: <Y9kyjEaTtPQ5sKeH@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kyjEaTtPQ5sKeH@antec>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-riscv@vger.kernel.org

On Wed, Feb 01, 2023 at 12:23:56AM +0900, Stafford Horne wrote:
...
> Next steps:
>  - I have requested to get archiving setup on lore.kernel.org
>  - I will be sending out a kernel patch to move the OpenRISC risk development
>    patches over to this new list.
>  - Need to update the OpenRISC website.
>  - Update any other projects linking to the old list.

These have been done, however the kernel patch hasn't made it upstream yet.  I
will send a pull request to Linus for that shortly.

John,
  Could you help add the lore archive[1] the the linux-openrisc vger section[2]

Thanks,

-Stafford

[1] https://lore.kernel.org/openrisc/
[2] http://vger.kernel.org/vger-lists.html#linux-openrisc

