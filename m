Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6683C77B7F;
	Wed,  3 May 2023 09:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjECJMn (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 3 May 2023 05:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjECJMl (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 3 May 2023 05:12:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFB4EF5
        for <linux-openrisc@vger.kernel.org>; Wed,  3 May 2023 02:12:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so14845175e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 03 May 2023 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683105132; x=1685697132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zod5xsswpVBR7hlKEzwTqzhAu9kilTeSo6vjGfoZzY=;
        b=fl3+0HTDclChX9Eoz4UASBvCMsATTbetGEowrH/weZ1bDHTMayoXkdjPDhUGyAS4ke
         12DrV+kTixHFmWaEElgDO8rQqcfacOi8lPYKQNOklhO7iYa6vI/Vth5YSpjrL5Cxh540
         lwMBXm7o4A3QvMfGN1mL/DqJW7lw9xCSdHgpdXnotShWRWOw94HMhvGPPKE4l3MmrEkN
         3ZSh5OtOxwDtz3wD4HAocDuJPZdgC9wz8raJawwZmgXxu2ea/el8as7ktCUn64bkYLpv
         egBn3ML+2xI+xkPEnGZK9OIoEPXC5wkxvwvtSDDW+94uCRJUfGfU1tzqbJ2+k+AH2W/B
         xAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683105132; x=1685697132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zod5xsswpVBR7hlKEzwTqzhAu9kilTeSo6vjGfoZzY=;
        b=dU12psCXweOTmTbExkepLQKodSYuyJpluKyQ50FXZo6zflxBREnOJ9sxyDk6cN//4/
         nNF+LJE4/uQ4VYTR7ST+7ttC37G4H4uLxa+3PKxkdn0H48rOs+fZxu1oxLnAJQwAiyE/
         3NB3rfJEgLriDeQ5fw3wvgADVOjz8zss8qzX/zLhkY93kV0StFGzEBvDXPoXr3/bYcTb
         G1xfeIxD2Y6BiaMfa27bnd7X+e6oqbMwVpbmMg9qLUdXJk7e0ZwrWTodXkP/rBOT3F61
         6GL9i92bEKz+euv0cNlAYgtOm9Ie5zGGBZJVf9DyXIDmhEvMPjygHikLAu9spZcsZdpH
         JLDA==
X-Gm-Message-State: AC+VfDwt127bcEMTCOCxqVHXo1BjwRA3ocv7mkaL8fEG5I+acNxyelEV
        g5Wj5IQ3G24SLN6mURFNmAYRZNBZ5j8=
X-Google-Smtp-Source: ACHHUZ7kWoco+FaWmgUXPr0oeiUX9ydgEiurzrvHGnGrKsx0JQOfPK27JvaMG+qFbQYk6+dUhLlByA==
X-Received: by 2002:adf:f8cc:0:b0:306:2639:a1a2 with SMTP id f12-20020adff8cc000000b003062639a1a2mr1036581wrq.31.1683105132475;
        Wed, 03 May 2023 02:12:12 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003f07ef4e3e0sm53270511wmq.0.2023.05.03.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:12:12 -0700 (PDT)
Date:   Wed, 3 May 2023 10:12:11 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     QEMU Development <qemu-devel@nongnu.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 2/3] target/openrisc: Set PC to cpu state on FPU exception
Message-ID: <ZFIla2Jlaa5gCr6o@antec>
References: <20230502185731.3543420-1-shorne@gmail.com>
 <20230502185731.3543420-3-shorne@gmail.com>
 <baea6704-7a22-6934-54f3-76ff4c0fc298@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baea6704-7a22-6934-54f3-76ff4c0fc298@linaro.org>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Wed, May 03, 2023 at 08:36:13AM +0100, Richard Henderson wrote:
> On 5/2/23 19:57, Stafford Horne wrote:
> > @@ -55,6 +56,9 @@ void HELPER(update_fpcsr)(CPUOpenRISCState *env)
> >           if (tmp) {
> >               env->fpcsr |= tmp;
> >               if (env->fpcsr & FPCSR_FPEE) {
> > +                CPUState *cs = env_cpu(env);
> > +
> > +                cpu_restore_state(cs, GETPC());
> >                   helper_exception(env, EXCP_FPE);
> 
> Better to mirror do_range().

OK.
