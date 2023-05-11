Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4ADC77B7F;
	Thu, 11 May 2023 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbjEKOen (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Thu, 11 May 2023 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKOeW (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Thu, 11 May 2023 10:34:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309CB11B50
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 07:33:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so45957045e9.2
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683815585; x=1686407585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpHzLOSJrTCY3XJh7eVaSPkQ6h945WIPK/8UNUd2XSQ=;
        b=se1oSMrLpho2+tfA02dn9DLPuw9mcNtZgx3zp+Hh2G4W/xpkCQXbUKOwQcCKV4JSw2
         9nV5amOnw1cf6eTGeIs7K9cvJ5YfpHfTZn/DOe16qF6AZ7uF019eNVV733ikVtSPW7V2
         pKEwHh4BWzDPd59fbD6FcEjVs2c3SydqD8LEzQ4jfMKKqY8AwLbmt+dz7uyNcDFVBheh
         MFFjDw6fzP7z2U49mA/eFMRV9Te7MYqmaxtGQF0tOI3Pf5vFqWHHkCR6lMod+/of9DxF
         ZGQypNeRx/VFDd2gJN7QOO8rTjYmvPvmYxRg4cmShEVoDHjn/51N8bDb/p3OFRHwhtiZ
         WRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815585; x=1686407585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpHzLOSJrTCY3XJh7eVaSPkQ6h945WIPK/8UNUd2XSQ=;
        b=F+Bn4O263fM1jQBc9XiU+ArdaLfdl2icoooRBBLvA9WFV9Oa/3eLn56iXPBXAIlNXa
         abzL037CCBwqhA7eWZqG1f4JzAEZRdvVm9hM5dqsoy1COIXAQ65SoKGAOZA4wIHy7gjN
         ds5YP8BXIRCovmbkyO/NY07PtxyB7EXB/bzffzsL0t+l3IJ10ke8ySjHUOJtCyEcaBCg
         5DJcUPbsvdwEIRlNKhcY0FjOSBiqpJDr7I7S6cDuHbujJZbg9PxwnoBfG1XwcRbZoL0/
         1VFdhOR+k8MTgcTakzx13OpQIY6R+WMaTaZCLOO7UCaM3ahLovHjlMdEh4LleeOV0iFo
         1K6w==
X-Gm-Message-State: AC+VfDwRB/XviAqGYRMQiyyptzF/F+eKmDv4N8AiXnqYQS+mDq5nSMc+
        RDDqGndZB5PaS0Pt4Z3oRxhg2X5wnQ0=
X-Google-Smtp-Source: ACHHUZ4P9KuQYmmiafte5mMjC9Qc0TLL7eBZpQj9OgS0ETheLOf9eOcUWZgk3zw4FBwLAgKZe7skzQ==
X-Received: by 2002:a05:600c:243:b0:3f4:28db:f60b with SMTP id 3-20020a05600c024300b003f428dbf60bmr7630206wmj.29.1683815585169;
        Thu, 11 May 2023 07:33:05 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b003f1978bbcd6sm12077257wms.3.2023.05.11.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:33:04 -0700 (PDT)
Date:   Thu, 11 May 2023 15:33:04 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     QEMU Development <qemu-devel@nongnu.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] target/openrisc: Setup FPU for detecting tininess
 before rounding
Message-ID: <ZFz8oJ+hYdsoZeoi@antec>
References: <20230510153228.264954-1-shorne@gmail.com>
 <20230510153228.264954-4-shorne@gmail.com>
 <390d7ef2-1240-55a3-4b13-ab8796921b7a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390d7ef2-1240-55a3-4b13-ab8796921b7a@linaro.org>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Wed, May 10, 2023 at 05:16:20PM +0100, Richard Henderson wrote:
> On 5/10/23 16:32, Stafford Horne wrote:
> > OpenRISC defines tininess to be detected before rounding.  Setup qemu to
> > obey this.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Since v1:
> >   - Remove setting default NaN behavior.  I discussed with the FPU developers and
> >     they mentioned the OpenRISC hardware should be IEEE compliant when handling
> >     and forwarding NaN payloads, and they don't want try change this.
> 
> There is no such thing as IEEE compliant for NaN payloads.
> All of that is implementation defined.

I see, I haven't yet seen to IEEE 754 spec so I don't know how much is covered.
It was incorrect to assume forwarding semantics was covered.

> All OpenRISC needs to do is document its intentions (and then double-check
> that fpu/softfloat-specialize.c.inc does what is documented).

Understood, that makes sense, also reading that code I see how all other
architectures are able to ifdef their way to a specific behavior.  I will see
what our current implementions do and update the spec and qemu as a separate
task.

> 
> Anyway, back to this patch,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> :-)

Thank you ^_^

-Stafford
