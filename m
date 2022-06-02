Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6038C43334
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 20:01:16 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DEB8824917;
	Thu,  2 Jun 2022 22:01:15 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mail.librecores.org (Postfix) with ESMTPS id 17CF7248EA
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 22:01:14 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id 187so5600375pfu.9
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=edO1iwQxgPlmgM/1u/oOlUyyoYGNoY3yTPEc3qv+5RY=;
 b=VoPoiaSl60pNBkyvSug6/isO++NiY9lRGzj+h/Uqv5jo+hhndoah1wt4hZhZtN+SC5
 /tL4WLWfmr12jG+G3hJ0j7+9CdBfDfzynTzUXcqoxbMN0wgDM9uqB6XG2fNU+bD94eUe
 Q5KrgOeKM3IPJUV7jRqtJcD9c/zLxmdp8yfRC1gcaz72fwPdXIH0obCPOw5zP0bXqdWd
 3qVhSFHr8oyByoKgOivTdW+XX2Cmzm3XS3zhbqNKYp70OPi4UJdyBqF9WFGxsF93ifqf
 cX55qRcBe0Dn25717ft3b988jmIXNRq/uomW3tCAh/Ja8VXP+ciGqmVd7A8u4y/JtnDm
 1FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=edO1iwQxgPlmgM/1u/oOlUyyoYGNoY3yTPEc3qv+5RY=;
 b=PBnIV5SRlrg5Dxq4OAEz9IbeEru7HWiBx7ta+6okdPrCgM5bV8MZQhO5P6fxg1kOwJ
 NsIlC7CswSQ1vLQPvwV+IKp1zHlsmGn9Ds0FyGgCv1bocXwQMG7M3DasREMpqxf43s/1
 tFxw885SGGfx6+Nflkix6rl1QLBpbc5RPcpFp9N0YMnTnPgEyVZdqliSPYPR2wvhqc1m
 x4v5JpdqfryjgoliCEBXbYTfpWlhrXHew6U/eZZWQAoyHV0mPBLLR9+t0jq6RdRR0rKD
 E+aNhWZYNefp00ZYhr6xuTd2AQJC5++XoNhkhFhRPa/+KL/KaTIsiZGghgrqU1AyRuvO
 SIIQ==
X-Gm-Message-State: AOAM531qOX7B0HzXL5dk5EsCEaNm+iQxDVt1k/2J7mGfnRVnDqU7vWxV
 ZjvpwD3fURLW9bGxtDMha88=
X-Google-Smtp-Source: ABdhPJxkJSGlBm6UuqGHHapDYbRHR/MKorBEqg+ZcAcF07KQChrQg4WPi4eZLUjXkcF2v4Lq7fIN9A==
X-Received: by 2002:a63:8a44:0:b0:3fc:a1f8:806d with SMTP id
 y65-20020a638a44000000b003fca1f8806dmr5716648pgd.363.1654200072563; 
 Thu, 02 Jun 2022 13:01:12 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 e63-20020a621e42000000b0051bbb661782sm3155784pfe.192.2022.06.02.13.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 13:01:11 -0700 (PDT)
Date: Fri, 3 Jun 2022 05:01:09 +0900
From: Stafford Horne <shorne@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: Link failure with Debian toolchain
Message-ID: <YpkXBWWyWSG6XwoO@antec>
References: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
 <YpFSzpl5fdq7O3pk@antec> <YpHwhlF0Dhf58da7@pegase>
 <CACPK8Xf5F+LJiYrCX50Muq9Eh2SUQNwMAP-LE6zudSE119Hhgw@mail.gmail.com>
 <CACPK8XcmXLGyn+2BK-nthgVyo5U9SEr+jaw8GJbZTK6Fhy7mfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcmXLGyn+2BK-nthgVyo5U9SEr+jaw8GJbZTK6Fhy7mfw@mail.gmail.com>
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
Cc: openrisc@lists.librecores.org, Nicolas Boulenguez <nicolas@debian.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 02, 2022 at 04:52:01AM +0000, Joel Stanley wrote:
> On Mon, 30 May 2022 at 08:27, Joel Stanley <joel@jms.id.au> wrote:
> > Stripping libgcc.a breaks it. I could reproduce by running:
> >
> >   or1k-elf-strip lib/gcc/or1k-elf/12/libgcc.a
> >
> > If I then reinstated the original libgcc.a the build succeeded again.
> > I suggest we drop that line from the Debian package.
> 
> Nicolas merged my change to remove the strip from the package. Thanks!
> 
> I was able to build and boot a kernel with the new version of the
> package 12.1.0-2+1.0.3.
> 
> I've proposed a change that enables the or1k target in the Debian
> gdb-multiarch package:
> 
>  https://salsa.debian.org/gdb-team/gdb/-/merge_requests/11
> 
> With a local build of that I'm able to connect to qemu's gdb interface
> and poke at the running machine.

Thanks for getting this sorted out. I have been on vacation for the last 2 weeks
and just following these on my phone but not able to get to a computer and do
any useful investigation.

-Stafford
