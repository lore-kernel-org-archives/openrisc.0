Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8236C433EF
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 04:39:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id BEF3724042;
	Thu,  2 Jun 2022 06:39:36 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mail.librecores.org (Postfix) with ESMTPS id B3E2423FA3
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 06:39:34 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 n124-20020a1c2782000000b003972dfca96cso2132884wmn.4
 for <openrisc@lists.librecores.org>; Wed, 01 Jun 2022 21:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=vUlqOcPZnFCh57G706+g28LBY1zHPo82Z6a+Kxl7ceE=;
 b=Db2bxQu/VXwUE7sMikyE5KUHTsMdhWBpmk0OK8a/eYdpSYJ2B6P4vX+ftQkZR0lLUV
 OzQUlK58RZFSPejVkO5xjB0eoOnbQ7RrKj2z3GyFkUMJx+klimjlgNwWpzP6FcoAHOYk
 ZmIe27z0H3WVRqIKHMqb8+krsGAJZVZI+IRrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=vUlqOcPZnFCh57G706+g28LBY1zHPo82Z6a+Kxl7ceE=;
 b=s0oEZ3ectrheKH0UY2x3/k6yp8NlT9/8cF1v1FN/UXI07wvZ+vhFYCYWeVqIbTzmUz
 jWu0KI37pIqmumlQikN5i+QgckPy2XGnZxL1E18LUamGwFje/EZIL6sIpTdk7a39uIjv
 i00+mm2Vu/uevXWxTByPn3ooEQ/ZHIoRGRfCe0aSpntVAqbp43+ZbCPbcBJbnp/ewn7j
 vGgItRTfvdQhAlXuGHvbu5L2AZhGQNF96sQ/ehz0qtiCwlEZGktgNMv5z6u4fLSGxoTN
 xUJJZsYpORy47T1VO6PVTLdppsgIdy5OMGQby+mzMpTflYc+RqlOciZHzIIVvx8ASA7A
 k93A==
X-Gm-Message-State: AOAM533zSQGW3/CE/AYLgd3jn4YPnPQsoaxxymyBHZRdxKmbv9TQcfmY
 OfNRymxEYYXiyTlhCgX/iPPxqFpeYXojVcoPJjGipfxonlU=
X-Google-Smtp-Source: ABdhPJwb5QFoGqWFBjP/rC+OJpfW6CZ3w9oBfzlKYhSbzd5cwW1S1OH3CzE0mDRqcQzDHB4z4UmsDtmFefUk9VhrFs0=
X-Received: by 2002:a05:600c:198f:b0:394:952d:9a72 with SMTP id
 t15-20020a05600c198f00b00394952d9a72mr30627894wmq.72.1654144773804; Wed, 01
 Jun 2022 21:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8Xebta2r7cdC7R2e2=+HE2FYOfoNMpZpyjju9z8gb+K=3w@mail.gmail.com>
In-Reply-To: <CACPK8Xebta2r7cdC7R2e2=+HE2FYOfoNMpZpyjju9z8gb+K=3w@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 2 Jun 2022 04:39:21 +0000
Message-ID: <CACPK8XdaqBtsyLH9ony0jS4cSXOzJ-3pepo1V3=1fF3u2cUGkA@mail.gmail.com>
Subject: Re: Qemu TCG crash on arm64
To: openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, 1 Jun 2022 at 03:18, Joel Stanley <joel@jms.id.au> wrote:
>
> A FYI that I opened this issue in the qemu bug tracker:
>
>  https://gitlab.com/qemu-project/qemu/-/issues/1051
>
> When running the openrisc kernel on my Linux arm64 (Apple M1) machine,
> tcg SIGILLs inside some translated code.
>
> I'm not sure if it's related to openrisc specifically. I have been
> able to run ppc64le kernels using Qemu on the same machine without
> problems. I've also been able to run the same or1k kernel under Qemu
> on my amd64 laptop.

This has been fixed now. It was specific to running on an arm64 machine:

 https://lore.kernel.org/qemu-devel/20220602011459.294754-1-richard.henderson@linaro.org/
