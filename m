Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429DC77B78;
	Wed,  3 May 2023 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjECJPP (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 3 May 2023 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjECJOt (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 3 May 2023 05:14:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10525FE4
        for <linux-openrisc@vger.kernel.org>; Wed,  3 May 2023 02:14:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f178da21afso32662055e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 03 May 2023 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683105258; x=1685697258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/v/5578I+S3Crmtq0JIaHpyxyBUFP1tU/u2+Dgdt90=;
        b=J7FKujiZmG4VjwD7aaVOpXBupeuoYlui2mJx95KDwjNlJSpXqS+W9Tztf/LhzwvstY
         jcpORa1fKKnYDlSr/QrMkhictT6yQrcMyhfax7+YOF1SCmKdOBvPuHUYbFm3IzoRMD0q
         66crNjs5pOxNlt6Hfo8RiWOjGbC3jerK/oHmlNTKq+KMJtYhOAkStv1VF5MisPGcPMtC
         C2KmX5c0GCgrM68reHHNwhVKgRZLtYs/UHRrBzyU8VSaX5gRw7mUh1Vxt//Ymakx4xDl
         L4WB4X3hh64Y2vUMV4K8un3kkgo6SUKkmCnJSIEs98U+vDsaCXNboqFcxuG+kamotBtU
         bnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683105258; x=1685697258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/v/5578I+S3Crmtq0JIaHpyxyBUFP1tU/u2+Dgdt90=;
        b=evMRjKt5HpqZY9EgULIS5TveXEIxkhMA4NE1xfKcp8lMYc0NH1GGJfThdLjq9n8iWp
         w9Of+hhBn+F/+9YNc4LTnqU6avQ8a6xKVZHxmephPSq3/tq5/+8U4GRd+3DhuW4Nc2Cb
         4sPCi6bUTdHRhoRVP9Mpg0O3NRN2tHb193p4BKJClbo+pxHM6gBUagTzBO8dlP+3+XAZ
         /MLZ06QPjFUFZngwa50dxg3pmCTgYIxRFE02Y+4OjjMHXNUgc/dZsu4iUs072eNs2oJP
         VdTsQMRNOUBSP/MjwhaeAu6kkC25sbBAtTuAmltX5JRpbEdCEc5jpmOugaVUoK9zWoU8
         Q1rA==
X-Gm-Message-State: AC+VfDxOojtcFzhttIGwTV9c0JHNQwTbosBvqb9Pkq52nH6wteUdWvQL
        wg8CvspL3kQ3nLerja09foA=
X-Google-Smtp-Source: ACHHUZ6UZ1zaLJe6vboTg/B8odSiPOsxnKi7tS2fvd5fFMY+FQ6oHCAWevKS8ENFU4UuilpaLoOWrw==
X-Received: by 2002:a7b:ca53:0:b0:3f0:a08e:811b with SMTP id m19-20020a7bca53000000b003f0a08e811bmr14317681wml.13.1683105258127;
        Wed, 03 May 2023 02:14:18 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003f1739a0116sm1255349wmc.33.2023.05.03.02.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:14:17 -0700 (PDT)
Date:   Wed, 3 May 2023 10:14:17 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     QEMU Development <qemu-devel@nongnu.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 3/3] target/openrisc: Setup FPU for detecting tininess
 before rounding
Message-ID: <ZFIl6db3isktCOk8@antec>
References: <20230502185731.3543420-1-shorne@gmail.com>
 <20230502185731.3543420-4-shorne@gmail.com>
 <933ff5d8-3875-34ac-9bc4-ed06f74efad7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933ff5d8-3875-34ac-9bc4-ed06f74efad7@linaro.org>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Wed, May 03, 2023 at 08:37:31AM +0100, Richard Henderson wrote:
> On 5/2/23 19:57, Stafford Horne wrote:
> > OpenRISC defines tininess to be detected before rounding.  Setup qemu to
> > obey this.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   target/openrisc/cpu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> > index 0ce4f796fa..cdbff26fb5 100644
> > --- a/target/openrisc/cpu.c
> > +++ b/target/openrisc/cpu.c
> > @@ -22,6 +22,7 @@
> >   #include "qemu/qemu-print.h"
> >   #include "cpu.h"
> >   #include "exec/exec-all.h"
> > +#include "fpu/softfloat-helpers.h"
> >   #include "tcg/tcg.h"
> >   static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
> > @@ -90,6 +91,10 @@ static void openrisc_cpu_reset_hold(Object *obj)
> >       s->exception_index = -1;
> >       cpu_set_fpcsr(&cpu->env, 0);
> > +    set_default_nan_mode(1, &cpu->env.fp_status);
> > +    set_float_detect_tininess(float_tininess_before_rounding,
> > +                              &cpu->env.fp_status);
> 
> You don't mention the nan change in the commit message.

Right, and I am not sure I need it.  Let me remove it and run tests again.  I
was just adding it as a few other architectures did who set
float_tininess_before_rounding.

Will clean this up.
