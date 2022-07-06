Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D563C43334
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 18:12:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D0A242496D;
	Wed,  6 Jul 2022 20:12:42 +0200 (CEST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mail.librecores.org (Postfix) with ESMTPS id 3730824956
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 20:12:41 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id fd6so20286274edb.5
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6WkeFi9/MfvFPZabTkFO/+z+qTX2NRIaktMM35/VLs4=;
 b=YPoiEtXlCOn1CAotjFMeoYWMAVUa1VAwEXx0SXCkZgy80iaObV0By3/8fkArYHBgc4
 C+k23RvYj7Z0SQ1lC7nGvaGEGFTM7LSEBC0C6lgwlKsqCpDZ7ZJ9XsHTZluuK53l/wVU
 56Tv2STb5ujU0jpC2Hs5qqgtJfdKcJnDGMPDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6WkeFi9/MfvFPZabTkFO/+z+qTX2NRIaktMM35/VLs4=;
 b=b4iwduXwmHQ+aUk73/1/ah63utLQCH1cYkj3KZ6KcGt4KLlNdAcwuuTGg4mbu2bih3
 AvBe0lCQY66lFQV2Y8ViDDLtrOvMxlp3SXVC0ZqdpZpzW3KaOdhuHu7eken3OXc9ZRDN
 FAcae8PG9nfDuFL2BCgLr1a83dE4D/NhuV2hehGZG4xMsaunR8VwQVesEJeRU3r8w0lh
 cBLByLZh0Xj0oJxXj3rqwPeetS2BQ8SubrT7CWUmTONIK+GRf+7fGamvjjP4nAlC2nzw
 aghnWdfZcioO7jAPgVD8gZGZgZwZ0+uEfr+WFRprVvEeKNgYlmn+KffqgIbMd6OddxqF
 Qfrw==
X-Gm-Message-State: AJIora+sYNe8P4Kh6aR6++Q+JUzHa6I+x06qcdFHAHaSkdgHfplXeYIM
 RZxQt2BtfdenPRex2lcsRDxOgCTPt9JXb34O
X-Google-Smtp-Source: AGRyM1szE8YUPuoXADO1URPVCBsVd2G7K/tBzQQL/00GNhrnFoUVeyNcQwf/klF32wwJ3gS3t9c7iw==
X-Received: by 2002:a05:6402:540c:b0:434:d965:f8a with SMTP id
 ev12-20020a056402540c00b00434d9650f8amr56186117edb.30.1657131160619; 
 Wed, 06 Jul 2022 11:12:40 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44]) by smtp.gmail.com with ESMTPSA id
 hb10-20020a170906b88a00b007266185ca67sm15588201ejb.150.2022.07.06.11.12.39
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 11:12:40 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id v16so11727579wrd.13
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 11:12:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr3874613wrb.442.1657131159375; Wed, 06
 Jul 2022 11:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <YsWMXAF3ePlWuxyF@antec> <YsWM+im7pmU8MdeZ@antec>
In-Reply-To: <YsWM+im7pmU8MdeZ@antec>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Jul 2022 11:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
Message-ID: <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
Subject: Re: [GIT PULL] OpenRISC fixes for 5.19-rc5
To: Stafford Horne <shorne@gmail.com>
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
 LKML <linux-kernel@vger.kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, Jul 6, 2022 at 6:24 AM Stafford Horne <shorne@gmail.com> wrote:
>
> Sorry, again with proper subject.

Well, pr-tracker-bot still didn't like it, probably because you
replying to yourself meant that the pull request details were quoted
and indented.

So no automated reply for you.

                  Linus
