Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB560C83F33;
	Mon,  4 Sep 2023 22:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbjIDWhz (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Mon, 4 Sep 2023 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbjIDWhz (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Mon, 4 Sep 2023 18:37:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF149D
        for <linux-openrisc@vger.kernel.org>; Mon,  4 Sep 2023 15:37:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so2525343a12.3
        for <linux-openrisc@vger.kernel.org>; Mon, 04 Sep 2023 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693867070; x=1694471870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qca5uXQ/xF+tdAyo92FlBltmSbX5l/XJqzvbOU7OH0=;
        b=f1lSYIFW23sFdesDoqVyYdff2pko5C0ql+kWIC9K/Wt7uMWAlmdHJxB7I8OQXXWKXU
         IgFjM2FD7agDRMJmo3isBlWIs3zmrPuFpz5cySzpmKRT7s6lwF5LAn5791iZzgKlCNWl
         H62vjHpF1JX3hzsJ8NgGjyDET4P+Jda5lHjdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693867070; x=1694471870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qca5uXQ/xF+tdAyo92FlBltmSbX5l/XJqzvbOU7OH0=;
        b=eRuubeYsBYfO1brdjOjuFI8YhA5pMkEE3RyIPLxm2MCuAtiqY/qX+zZNK1EsXer6WQ
         n5aRXdGsQkQJQp72e8YGqpBrZVtkmI+o427i9dGg5YlYWzV1zHpns/nhcA+PPaREy/Ya
         +8jNPZW1KXz6zJ6PnZZjcrMI7JRWbWKstr3Non8P3LUL8X8tyR4oJog/VMj5OrpdhFIO
         alVKA3Qwd5rvxJWaW0J1jSCiptooBT8orBAuLMlT8ksrp5yCTCHOKEp8ysJmzexFLY6y
         w/+CsdQv97zjEPJdwtwvC2MurS+/x5UzvPqH23afKIMrF3ClaSb4o17GEL+gWfQS8OIU
         +qcg==
X-Gm-Message-State: AOJu0Yw88XqDMY33VBovZy/sWYMn8z6y+S4IAJXMPadczF54m40i1wHc
        tZcEz8QnUoVBy4uodSxPsVgDLgurldwZBK0L4eGFL+uv
X-Google-Smtp-Source: AGHT+IH+FwEwLucQJKZZqPlu71HQEKvlOc7UeRhtOrnnxCtv6Q2PeFNZyoLTGCUTBHgxXuR7ToTu1A==
X-Received: by 2002:a17:906:cc54:b0:99e:1581:6437 with SMTP id mm20-20020a170906cc5400b0099e15816437mr7267954ejb.46.1693867069724;
        Mon, 04 Sep 2023 15:37:49 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00993004239a4sm6762392ejb.215.2023.09.04.15.37.48
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 15:37:48 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31c73c21113so1571953f8f.1
        for <linux-openrisc@vger.kernel.org>; Mon, 04 Sep 2023 15:37:48 -0700 (PDT)
X-Received: by 2002:a5d:538b:0:b0:31a:d8be:d6f4 with SMTP id
 d11-20020a5d538b000000b0031ad8bed6f4mr7686624wrv.10.1693867068514; Mon, 04
 Sep 2023 15:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <ZPYuGlUw9K2PcShj@antec>
In-Reply-To: <ZPYuGlUw9K2PcShj@antec>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 15:37:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
Message-ID: <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
Subject: Re: [GIT PULL] OpenRISC updates for 6.6
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Mon, 4 Sept 2023 at 12:21, Stafford Horne <shorne@gmail.com> wrote:
>
>   https://github.com/openrisc/linux.git tags/for-linus

Nothing new there. Forgot to push?

                Linus
