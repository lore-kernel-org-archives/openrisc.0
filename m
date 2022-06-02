Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A186C433EF
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 20:05:20 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 627FC24917;
	Thu,  2 Jun 2022 22:05:19 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mail.librecores.org (Postfix) with ESMTPS id 6B812248EA
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 22:05:17 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 v5-20020a17090a7c0500b001df84fa82f8so5680571pjf.5
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/4F3P04RiqaLnCxu45Y6BfA+mNcWRXPng/jNjafuIFE=;
 b=SqiBbXYPKjTv6QPf5coEYt+sAi5YcFPcWkSmAKcZDED4xltESQvKq0lFNX3rKlN9+G
 EHzQW027dOxBjgc+K8AdZaNLz0Qy9RAvPxlr6Rmx/yW/xJAamgKcUr8apnCeqYbpheDe
 ObLJuYGgMzV9mXglV/BwO7RtoJMx1hiydHw+y1ybGBtQBAa5i/41ArvfkXyXNCn35wn0
 kXQZmLSgi4jCm2pcL3XKd4EaA/jt7G8i8fo9cp0xCulqi5GbGbxtsQOIKGz6eU+kRZMV
 bsm7uvSOpxSNzCQwvaTRU7T72Xxd2cVDW+uHsYt6TjlY7jxhdWSz+bKkDeiAMeUqNTgH
 GYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/4F3P04RiqaLnCxu45Y6BfA+mNcWRXPng/jNjafuIFE=;
 b=IRI4rmOv/4ZYrvMLjPt63BmgEOyb+mufCaCvYiawIqGOWHDiVIZwYE2HmVGGDZeN7J
 M4+MabhRsI78xtL0sfFa3x/Nq2l+V1GWA9PEob9dSc3V7BsNzDk5lKqwy3lWMSYtOX0u
 GjrGIoMzePwxdGauSud4i403p2bsOldIOhykyLtz8LMkLHmQhqkfcNcDOxjy3oRWSY/L
 0ni6anGLtBBHVrrnxW0SfJ5blajCjWMgoqugFDH3CVdKEF0rmyLosrOkaUixNZ9+V0nR
 NDk3I9EeGTvb26OfkwEzjg2pqW9226Ho1RVYu9rDk9VK3AbEUyvPSYdotjsX3OfyuBOz
 pf6g==
X-Gm-Message-State: AOAM532qRWUEbJohta18wK3t0waDNxFGpTEEjK4r7fuRnHFBQsT2CwBl
 joDrVYbsw0ZCnviTM46Ebwg=
X-Google-Smtp-Source: ABdhPJwRmKF7LxBzDNuyOIjo/5kwLg50mZczO/PSha5zlUbxbl95I/ezjOxYmo9WFY5PXc9jCnbCUQ==
X-Received: by 2002:a17:90b:4ac8:b0:1e3:4f6a:2d04 with SMTP id
 mh8-20020a17090b4ac800b001e34f6a2d04mr14148982pjb.233.1654200315962; 
 Thu, 02 Jun 2022 13:05:15 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 g29-20020aa79ddd000000b0050dc762819esm3858035pfq.120.2022.06.02.13.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 13:05:15 -0700 (PDT)
Date: Fri, 3 Jun 2022 05:05:13 +0900
From: Stafford Horne <shorne@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: Qemu TCG crash on arm64
Message-ID: <YpkX+eMY9bCa8+PW@antec>
References: <CACPK8Xebta2r7cdC7R2e2=+HE2FYOfoNMpZpyjju9z8gb+K=3w@mail.gmail.com>
 <CACPK8XdaqBtsyLH9ony0jS4cSXOzJ-3pepo1V3=1fF3u2cUGkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdaqBtsyLH9ony0jS4cSXOzJ-3pepo1V3=1fF3u2cUGkA@mail.gmail.com>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 02, 2022 at 04:39:21AM +0000, Joel Stanley wrote:
> On Wed, 1 Jun 2022 at 03:18, Joel Stanley <joel@jms.id.au> wrote:
> >
> > A FYI that I opened this issue in the qemu bug tracker:
> >
> >  https://gitlab.com/qemu-project/qemu/-/issues/1051
> >
> > When running the openrisc kernel on my Linux arm64 (Apple M1) machine,
> > tcg SIGILLs inside some translated code.
> >
> > I'm not sure if it's related to openrisc specifically. I have been
> > able to run ppc64le kernels using Qemu on the same machine without
> > problems. I've also been able to run the same or1k kernel under Qemu
> > on my amd64 laptop.
> 
> This has been fixed now. It was specific to running on an arm64 machine:
> 
>  https://lore.kernel.org/qemu-devel/20220602011459.294754-1-richard.henderson@linaro.org/

Great!  Thanks for helping posting this.

-Stafford
