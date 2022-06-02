Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA97C433EF
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 04:52:16 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1A48A24322;
	Thu,  2 Jun 2022 06:52:15 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mail.librecores.org (Postfix) with ESMTPS id 27E14240E1
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 06:52:14 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id z17so1993761wmf.1
 for <openrisc@lists.librecores.org>; Wed, 01 Jun 2022 21:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JY0LkzNQp3voHmO4bVHL7HUQmLUIf+zQCgS0IleM3cY=;
 b=Aa+SiZvu9CMIKj4qZDDScXWrO26GTTmGDw48/uqTm7Sn2Rt8CgtHNidmJhMl0yDRGv
 Md/GfNWrVCAVIq3crE+9c/zoFkUu3xzTxPveRJPQ3EtSeJjo1n71hgbIkHBZsoZE8FAt
 yAJqRokccP+hsHQS4JdsTAwpZzRd4Dg6t/VMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JY0LkzNQp3voHmO4bVHL7HUQmLUIf+zQCgS0IleM3cY=;
 b=UcjZUxJJK/+N5CnmdIrELa3PY79hI+ddqg659CBq45XW0W8xZt0Byn05gMeWkDLlgG
 mRcPdbyTIZU07nV/F3AgN8ticFkimu07fmjUCf4bf7DZIoWVSEEk1vER7wyG56PEdafG
 uPORo5t55qMU/0LVS8ZAvM2HOoj5vHMZORJf5T/yQIY3MstPRLADoIhMidTUcH8kOm4Y
 f0i0mkKXy9G3aJNPsUeyKOlL1rt/s42b1qxUdzq/1OvG/hNkfaqNO3apfmMv0ZypwwwV
 vtvFBaEK1MInFLXATeggbb/LSwtE4SqiBloDILDYgiPiYgaB5qrNPbD5oK3p9ypuDhNV
 4BPg==
X-Gm-Message-State: AOAM531Y0NckP5gKblj/6C0jECQBAzaJLjbfE1EW8jFVj9yEdUW8bXhm
 YfprbTCM0o1qnC87rwLZoDiPztXRdqtp199o3vI=
X-Google-Smtp-Source: ABdhPJyGsyE8lN2G/DzEEhz9Gn6qzzAq6FEA0wK8G3cE/ZvUOinBhMTwqZqfrd/Yn/Yzl2+81ibp1ZJpeXqV6l07Q+Y=
X-Received: by 2002:a05:600c:4e43:b0:397:7493:5f02 with SMTP id
 e3-20020a05600c4e4300b0039774935f02mr2328576wmq.34.1654145533775; Wed, 01 Jun
 2022 21:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
 <YpFSzpl5fdq7O3pk@antec> <YpHwhlF0Dhf58da7@pegase>
 <CACPK8Xf5F+LJiYrCX50Muq9Eh2SUQNwMAP-LE6zudSE119Hhgw@mail.gmail.com>
In-Reply-To: <CACPK8Xf5F+LJiYrCX50Muq9Eh2SUQNwMAP-LE6zudSE119Hhgw@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 2 Jun 2022 04:52:01 +0000
Message-ID: <CACPK8XcmXLGyn+2BK-nthgVyo5U9SEr+jaw8GJbZTK6Fhy7mfw@mail.gmail.com>
Subject: Re: Link failure with Debian toolchain
To: Nicolas Boulenguez <nicolas@debian.org>
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
Cc: openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, 30 May 2022 at 08:27, Joel Stanley <joel@jms.id.au> wrote:
> Stripping libgcc.a breaks it. I could reproduce by running:
>
>   or1k-elf-strip lib/gcc/or1k-elf/12/libgcc.a
>
> If I then reinstated the original libgcc.a the build succeeded again.
> I suggest we drop that line from the Debian package.

Nicolas merged my change to remove the strip from the package. Thanks!

I was able to build and boot a kernel with the new version of the
package 12.1.0-2+1.0.3.

I've proposed a change that enables the or1k target in the Debian
gdb-multiarch package:

 https://salsa.debian.org/gdb-team/gdb/-/merge_requests/11

With a local build of that I'm able to connect to qemu's gdb interface
and poke at the running machine.
