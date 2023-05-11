Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92D4C77B7F;
	Thu, 11 May 2023 14:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjEKO0X (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Thu, 11 May 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbjEKO0E (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Thu, 11 May 2023 10:26:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FCA170D
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 07:25:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso5037583f8f.1
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683815149; x=1686407149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkyZOvx5qmGpsduQvq1ZNuG43m7DUiPCKnBykl3eb7A=;
        b=kcO99qNQ10y3Csiu0QV1nwZMtjt6pQq+YNOQFzTEP0W99IS86P3hogiNs9CjN7E0gT
         4Mp8YE/g+xKYc3UPCVTDjBhcZKpdfnyg3NpgB2MKfSXSfbDyqS81yj49jCUfiCfoQjw2
         E7j9QZ3Gs/N4FFLLvTb+7g8AWgxfOKkAbumXVVnxn8LToViHnC2NNY5n15DmouIMBrAW
         K7fsn84XtmHOVhUEzzvN8GLknotqprcZWAKX3C8A6gzXqo/8fS/6X2j2M4XIbI19vaza
         JEHG17ClJmiJGXySRqIHOOEoCyqMX+3/YS7MM7/jgh9n6g0SmgkBjFCN3KjLriMOWpYS
         k0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815149; x=1686407149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkyZOvx5qmGpsduQvq1ZNuG43m7DUiPCKnBykl3eb7A=;
        b=ER8zpsK0hQV5ezpXl8A9CnSZ+u7z756a3BAsvprNqpkpmmO7omef9TBNeXh608ZiTS
         MFSX0/WiDlO6wrDT4OjCS+nnqmh5LZGNjYY4D2nAqM9Px0XqYs+SpDjToI3ydrqHkYBj
         peojK39jktIhZ8XEbmz7NZ2+sD3lNctTLcV2N1ezqmtv4Zvw75aFiX59a1UxGjAmYsSB
         XRRcB6TbXadkMB+kAptuZ68M03wAdtf9QQohJbpDGAgpuBHL7kyLjnpmtyJmI1CNNF9f
         gUQGoZr12U7YIbNa0sptZ8AThlXXnK1sofDqldHJ45AuJL9uYTybmR3bFylwQbxUpSCg
         YNrQ==
X-Gm-Message-State: AC+VfDwf/OWLAttuJDsFjZ2JwwbtHYtx0Hn2jKtEEIS7zbBUy7jMJsTX
        EjMPNy4s3VAA0yq+z7jcttME2I0Dohg=
X-Google-Smtp-Source: ACHHUZ6vEaH9Aojgk6BZANPEw9MVQELL/5I+FFf6agBqXqBGQ/9EMhyI0JK4h5Uu1PsLnGu1Lv9xCA==
X-Received: by 2002:a05:6000:100d:b0:306:26d1:230a with SMTP id a13-20020a056000100d00b0030626d1230amr14338261wrx.65.1683815149424;
        Thu, 11 May 2023 07:25:49 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c740e000000b003f420667807sm15897024wmc.11.2023.05.11.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:25:48 -0700 (PDT)
Date:   Thu, 11 May 2023 15:25:48 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     QEMU Development <qemu-devel@nongnu.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] target/openrisc: Allow fpcsr access in user mode
Message-ID: <ZFz67B+EehEOx6g7@antec>
References: <20230510153228.264954-1-shorne@gmail.com>
 <20230510153228.264954-2-shorne@gmail.com>
 <c7e792c1-8229-8b6c-8e6a-1eda14d77c03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e792c1-8229-8b6c-8e6a-1eda14d77c03@linaro.org>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Wed, May 10, 2023 at 05:13:03PM +0100, Richard Henderson wrote:
> On 5/10/23 16:32, Stafford Horne wrote:
> >   void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
> >   {
> > -#ifndef CONFIG_USER_ONLY
> >       OpenRISCCPU *cpu = env_archcpu(env);
> > +#ifndef CONFIG_USER_ONLY
> >       CPUState *cs = env_cpu(env);
> 
> Pulled cpu out if ifdef here...
> 
> > @@ -204,10 +220,22 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
> >       OpenRISCCPU *cpu = env_archcpu(env);
> >       CPUState *cs = env_cpu(env);
> >       int idx;
> > +#else
> > +    OpenRISCCPU *cpu = env_archcpu(env);
> >   #endif
> 
> But replicated it here.

Right, let me make it consistent in this patch.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thank you,

-Stafford
