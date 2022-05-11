Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC4C433EF
	for <openrisc@archiver.kernel.org>; Wed, 11 May 2022 16:55:19 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9ACF32481B;
	Wed, 11 May 2022 18:55:18 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mail.librecores.org (Postfix) with ESMTPS id 0CB5E248C4
 for <openrisc@lists.librecores.org>; Wed, 11 May 2022 18:55:17 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id w3so2733080qkb.3
 for <openrisc@lists.librecores.org>; Wed, 11 May 2022 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1c9tYiYWacH6RIwu56J5OBC4/x7TeHmZdTW+unC9res=;
 b=ahFXrDI7SMRjN8LRWOrl+OJxU49/sy8fxu20FF5X6wPQ+Gqj6uVupC8QptJiti9CxQ
 1ZCX1nYoSjYcZbXF7wfPKre/qvaUWnQ1sRUegZOp/4bAXqNvx+m1/mDKMEcE0Ou1gfVU
 w4kbxEQxupXsB2Y1NV4sLxyrvHaP3V8fWKleE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1c9tYiYWacH6RIwu56J5OBC4/x7TeHmZdTW+unC9res=;
 b=wD8G3e7B/BjE7shaqOu2BIxVMltjmf5yhnwjltMgeFrYLwN/lUJAZYmbbvEmntEkxV
 GC5Za88+i6uyLS2mxLfL29uAvx9lo6RBA1fhmHZTpng9OFCF9khsjoMP8t2LH4kClOVg
 AcU4Dgf8JpA9S3xE5Q6oTgaSeWHD8+9gXtSKtAfXTJWHkR2jZ/AGW+sqFUizzhLTur6F
 ZyU/elro917aGtNBK98XSPyNkTKlWjZMzID/HymloX2rm0vLXhtvKoxyLLyvbbwyNR9j
 zUKhYt8vM/rhHO57vXR7vZEHgRFfKlryAv6XEbrlfMVREmEBU0YQl8sfkDCxupsxG6n0
 t6ug==
X-Gm-Message-State: AOAM532eNv4acF+ZZM5d1llZQZ5EGxB1BGzpKT4Rumw0lVgScpBtL62j
 bJy9puUKzWvJPzSEz1aaxX5rgeOY2jwdQIIfKjXHkA==
X-Google-Smtp-Source: ABdhPJwqZB43pmteBd9Y5WGjA2byFvU6PxkOc0UraGou29fdf9grUJq0sr8ZDNoNUf3HIAIOVLNpZhZrcc/Am5C6Xpo=
X-Received: by 2002:a05:620a:1ec:b0:69f:9f4a:161c with SMTP id
 x12-20020a05620a01ec00b0069f9f4a161cmr19994032qkn.54.1652288115927; Wed, 11
 May 2022 09:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ooFW5unm1AOWU5738_GHkYqVZ0whEgfKn6RH6k=SCm5g@mail.gmail.com>
 <20220428201950.6emdw5i2fvyktt2i@nitro.local>
 <CAAfxs75mxjefcTi5ficG0YvDr1THkPGG6aOxX0oor6WWTUngxA@mail.gmail.com>
 <e9227aed-3450-dfdd-5bc2-4d14027e41b9@philipp-wagner.com>
In-Reply-To: <e9227aed-3450-dfdd-5bc2-4d14027e41b9@philipp-wagner.com>
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Wed, 11 May 2022 12:55:05 -0400
Message-ID: <CAMwyc-QRwkSa4rEDRsqiHT+cYPACrHm4N6N5xUNXuqJwi6yVVg@mail.gmail.com>
Subject: Re: [OpenRISC] Add openrisc@lists.librecores.org to lore.kernel.org
To: Philipp Wagner <mail@philipp-wagner.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 Stefan Wallentowitz <stefan.wallentowitz@gmail.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, 3 May 2022 at 12:38, Philipp Wagner <mail@philipp-wagner.com> wrote:
> >     We can add it, but it would be great if the list can be made
> >     DKIM-compliant
> >     first:
> >
> >     1. turn off subject modification, if possible
>
> done (unset the subject_prefix setting)
>
> >     2. remove body modification, if present (mailman list footers, etc)
>
> Done that as well (cleared msg_footer setting).
>
> >     This way any messages sent to this list and to any other lists are
> >     properly
> >     deduplicated.
> >
> >
> > I think it's a good idea, I am not an admin at librecores.  Can you guys
> > help out?
>
> I made the changes above, let me know if that's not sufficient and more
> changes are needed.

Looks good. The list is now archived here:
https://lore.kernel.org/openrisc/

Best regards,
-K
