Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556ACC77B7F;
	Wed,  3 May 2023 16:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjECQbs (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 3 May 2023 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjECQbj (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 3 May 2023 12:31:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9C76BB
        for <linux-openrisc@vger.kernel.org>; Wed,  3 May 2023 09:31:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so33731375e9.2
        for <linux-openrisc@vger.kernel.org>; Wed, 03 May 2023 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131467; x=1685723467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UuGHsehsGI6Es291zJSGyeFgIQ370eU/4ENt0MxEVT0=;
        b=kk8FPAsm422dYeCg85xPvdQEKho092eu/UH780JUE6+PC14rw4RdyDBmS7miVU8zkB
         dYaQAyJfGyvgp+SQ+VttdMlMVw1oqQ1tDAW4q7+1ogIYoVqyRL4FrB+bLMYPQ4E3seVg
         48H0xVUr4RUHniWtazbgPn8ofx/zXxMTr7Q5ELlZc9xQHhcN2KIjAVLbK1pXDQVz6yym
         FnMKgZvenSM6gf34udJzeAf8x+ctjLSyQOeSXK6F5NQ+IIX2e/+VaBGl27sM3HT6ew3y
         kxpHu3U2ZTk1X6BPznkjrB30DwQKdqVBBhRoyib7BiBO8MgcLJovmwRgv/E/nJ8M4bnT
         bpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131467; x=1685723467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuGHsehsGI6Es291zJSGyeFgIQ370eU/4ENt0MxEVT0=;
        b=ZUz8q4JFvVRVZTB2wd2Vdp0PAGlYKsHjpgKuVCNqWfeP6lCtCzuAUa5ANS5mHjeRSH
         YWq/gdC8pWamfXltuM4dF1Fq3+YGX1kNTFZI/h7pdXaRl67/vJBqAO6+7gN+MFCCtAyK
         1/gFElx6JCXs2hOoYy0H/ddAC4+NaArqvHAnn7cCd3DorZMXkF6n60sdlMgpDG8eF/UM
         iuKXqKuCsd/9rYEyUQse/Rwjz46Oi18SuCwKOlav047a3NvPmIKbSqJFrzWkrlgE+sZL
         mj0rMYxmALvH7uDNM9Xdjct6GaZDRNnZ5LwOfqHQ5HcYnyyLaEUdz/j9fCvARYd3Ebu0
         kVFg==
X-Gm-Message-State: AC+VfDyBah5IJ0VdQpGWWb1xuRyWc8FI6F0v400qsoN5DWAafKeuGRCg
        SORmDoP7GJTmyGkjLXNFOoA=
X-Google-Smtp-Source: ACHHUZ6ympucnTIeT+ZkU2dmSV9drzo6+N75j2PiCzL3hL2ZTWfWu08zisQsbzDhim55zjKjoy3BwA==
X-Received: by 2002:a7b:c398:0:b0:3f1:738f:d3d1 with SMTP id s24-20020a7bc398000000b003f1738fd3d1mr14838656wmj.4.1683131466661;
        Wed, 03 May 2023 09:31:06 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id b5-20020a056000054500b002e5ff05765esm34673327wrf.73.2023.05.03.09.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:31:06 -0700 (PDT)
Date:   Wed, 3 May 2023 17:31:05 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     QEMU Development <qemu-devel@nongnu.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 3/3] target/openrisc: Setup FPU for detecting tininess
 before rounding
Message-ID: <ZFKMSfkJupFHXtrl@antec>
References: <20230502185731.3543420-1-shorne@gmail.com>
 <20230502185731.3543420-4-shorne@gmail.com>
 <933ff5d8-3875-34ac-9bc4-ed06f74efad7@linaro.org>
 <ZFIl6db3isktCOk8@antec>
 <e3fabb1d-7bf6-f251-9649-5a813b409200@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fabb1d-7bf6-f251-9649-5a813b409200@linaro.org>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Wed, May 03, 2023 at 10:41:42AM +0100, Richard Henderson wrote:
> On 5/3/23 10:14, Stafford Horne wrote:
> > > > +    set_default_nan_mode(1, &cpu->env.fp_status);
> > > > +    set_float_detect_tininess(float_tininess_before_rounding,
> > > > +                              &cpu->env.fp_status);
> > > 
> > > You don't mention the nan change in the commit message.
> > 
> > Right, and I am not sure I need it.  Let me remove it and run tests again.  I
> > was just adding it as a few other architectures did who set
> > float_tininess_before_rounding.
> 
> What that does is *not* propagate NaN payloads from (some) input to the
> output.  This is certainly true of RISC-V, which specifies this in their
> architecture manual.  OpenRISC does not specify any NaN behaviour at all.

Thanks, that is what I also gathered from reading up on it.

> It's not a bad choice, really, and it almost certainly simplifies the design
> of the FPU, as you can do NaN propagation and silencing in one step.

Right, it makes sense to optimize.  It doesn't look like any of our FPU
implementation do that at the moment.

I will check with bandvig who implemented the FPU to understand his thought on
this.  It at least deserves to be discussed how nan payload is to be handled in
the architecture spec.

-Stafford
