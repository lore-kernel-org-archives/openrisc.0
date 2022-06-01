Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B1C433EF
	for <openrisc@archiver.kernel.org>; Wed,  1 Jun 2022 03:18:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7F336247D6;
	Wed,  1 Jun 2022 05:18:36 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mail.librecores.org (Postfix) with ESMTPS id 8461824819
 for <openrisc@lists.librecores.org>; Wed,  1 Jun 2022 05:18:34 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id p10so460411wrg.12
 for <openrisc@lists.librecores.org>; Tue, 31 May 2022 20:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=8qq9U76KXBleoXKJViGEPxvE4CRwWO7/SSv6TTEuDpE=;
 b=akY6i2GqGy/rPN1B1FDGU9hH9s1AQCOACmhcpCYEXsZGg8iwqjzJttqfrL3WWmnh18
 UUZy6aXt/CiBMe3jo+/0gFCoVhJAnunViCKZi8/rqxmQfTPTFTSestXwwDSEkrQ02J5s
 jMpiU+ywJ1bImzwrjU6b6jiZ56JQYyuQy7yfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=8qq9U76KXBleoXKJViGEPxvE4CRwWO7/SSv6TTEuDpE=;
 b=s5Phs0ZtBqQFVRPSbRerKLVt1Pl3ig9qjb3Ct5ruZzm/n6YzATUFvoY2svdX9/L/ue
 ZtOmGGI4rrBYG9fy3qKrxNDNw5I9OJKLL5Yv7lHgF2ZunIXsdpf4Hkg3+4lEwEbEytO7
 ms+NTOC+c85aLPKqhCenBGUtDcPxlsKs/BhyRJqvkgOgbb7Wa4K63xxjPZSH2AifAhep
 G7r8umDrGlljuwmTW//CuCQg0qCvbpuyjxlqw8qpbfZ6NHwncp2t2Ws2kaFlK3s1wmlA
 Fe/8K8ZgYp5zl2BZTSZr6S3/QvwKEEiFBV4TjNk2MQYU8BzuksDbQAhwnNonKN+U+GTp
 yrXA==
X-Gm-Message-State: AOAM531mLFAzKULB4v2i5YgCBJnho05+mACVnPh9u1/c9XZ05jTRCUm9
 8IlTTgQ+GbwAcCgxtJTUn9+09Hp+AHJb9SBzklUXWrAyB5Y=
X-Google-Smtp-Source: ABdhPJz8nc7FlvZ7PiGoEVE1jtNMegYskYl11hb3abimwSYCLqgZuF5x4huapo6gl92q8HnxKCI8qwibXH2rA/wxcpw=
X-Received: by 2002:adf:e18f:0:b0:20e:6352:211d with SMTP id
 az15-20020adfe18f000000b0020e6352211dmr52450506wrb.606.1654053513504; Tue, 31
 May 2022 20:18:33 -0700 (PDT)
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Jun 2022 03:18:21 +0000
Message-ID: <CACPK8Xebta2r7cdC7R2e2=+HE2FYOfoNMpZpyjju9z8gb+K=3w@mail.gmail.com>
Subject: Qemu TCG crash on arm64
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

A FYI that I opened this issue in the qemu bug tracker:

 https://gitlab.com/qemu-project/qemu/-/issues/1051

When running the openrisc kernel on my Linux arm64 (Apple M1) machine,
tcg SIGILLs inside some translated code.

I'm not sure if it's related to openrisc specifically. I have been
able to run ppc64le kernels using Qemu on the same machine without
problems. I've also been able to run the same or1k kernel under Qemu
on my amd64 laptop.

Cheers,

Joel
