Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D96C433F5
	for <openrisc@archiver.kernel.org>; Wed, 11 May 2022 20:53:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9840E248C4;
	Wed, 11 May 2022 22:53:43 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mail.librecores.org (Postfix) with ESMTPS id CFEBB24911
 for <openrisc@lists.librecores.org>; Wed, 11 May 2022 22:53:41 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id x52so2968885pfu.11
 for <openrisc@lists.librecores.org>; Wed, 11 May 2022 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qomn5aGoZaGFF7YfMwCV994a0HTGHRl6Ajkt+O+1qEo=;
 b=l5AP5ASNNc+8ippjKBiXDrQ4Yp1M2Lg7GK/iUVnF1nsieHQ66IIPTwYc2O0TW3wGCK
 s3vclApI7IAP1KckonupSTOBsNZjH9Ypl6PaHu4wT3SCydJcVCudunMeGs4XwkmdY4Oe
 MzOJvny3ik4iRfF5EtCy/ZpBCGNIDovolOAfspsJnXTuZ3jod5b3QAHOnirGGoWNsxEn
 fE0gZHcCUoSHYG+zUXyuiKl6B/0Cqua+ShhPdhKm7WIORTMomUm4rhxRhZxUTBr8xIlt
 LyhX9nVkW9RuFm6uVtAjdhBNcPcWUWmjZcydEank/QoUSx9MXRThE95njISrj/HxrNFq
 C5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qomn5aGoZaGFF7YfMwCV994a0HTGHRl6Ajkt+O+1qEo=;
 b=rQv4l/5zCkQtO+y/V/GvvZ1h/sz7iffN/d2bHKVVojLa9mNPSJjhukp9iL8D88Ad6j
 FyZ2j8K7uPDVqA51x1XpXnEOzgaW7ci2snaAp2sBQrQ389hOkqdYSBw842nrTNlRObwA
 5cbLABuOX7GL7aapYT4bjfDHQH8lfdsBmotZxhY3jUxXZoeTHENW6wlOHb94qdzzAs57
 CK4oXckGw0/10smxkA9ndrk66Gl0saixsjq445RJ0npw3gZ3SvY+ai4ssBJcIWyF/DIm
 DTFctxij1WDrCt59AB5X68brVzwu9ziqEAwJMus550epezU4AItecDYmj8MIDQex/a2f
 IqQA==
X-Gm-Message-State: AOAM533UgbnIKcgcipZcjAge4CRk2iPXOE3yGRP+G+6DpsCK/Q5ZWYZP
 LUjFJyfL3jXQw+zS35ev+Yc=
X-Google-Smtp-Source: ABdhPJypq7gbzaXZSJEdYfhdginmesRBp9KaNB+XA620lHfHN31PLcOFqb6vpQRyVs1rfRUU8UbRPQ==
X-Received: by 2002:a63:34cd:0:b0:3ab:a3e8:7b48 with SMTP id
 b196-20020a6334cd000000b003aba3e87b48mr22715592pga.524.1652302420138; 
 Wed, 11 May 2022 13:53:40 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 y15-20020aa7804f000000b0050dc76281besm2138203pfm.152.2022.05.11.13.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 13:53:39 -0700 (PDT)
Date: Thu, 12 May 2022 05:53:36 +0900
From: Stafford Horne <shorne@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [OpenRISC] Add openrisc@lists.librecores.org to lore.kernel.org
Message-ID: <YnwiUOt7biixqPaZ@antec>
References: <CAHmME9ooFW5unm1AOWU5738_GHkYqVZ0whEgfKn6RH6k=SCm5g@mail.gmail.com>
 <20220428201950.6emdw5i2fvyktt2i@nitro.local>
 <CAAfxs75mxjefcTi5ficG0YvDr1THkPGG6aOxX0oor6WWTUngxA@mail.gmail.com>
 <e9227aed-3450-dfdd-5bc2-4d14027e41b9@philipp-wagner.com>
 <CAMwyc-QRwkSa4rEDRsqiHT+cYPACrHm4N6N5xUNXuqJwi6yVVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwyc-QRwkSa4rEDRsqiHT+cYPACrHm4N6N5xUNXuqJwi6yVVg@mail.gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>,
 Stefan Wallentowitz <stefan.wallentowitz@gmail.com>,
 Philipp Wagner <mail@philipp-wagner.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, May 11, 2022 at 12:55:05PM -0400, Konstantin Ryabitsev wrote:
> On Tue, 3 May 2022 at 12:38, Philipp Wagner <mail@philipp-wagner.com> wrote:
> > >     We can add it, but it would be great if the list can be made
> > >     DKIM-compliant
> > >     first:
> > >
> > >     1. turn off subject modification, if possible
> >
> > done (unset the subject_prefix setting)
> >
> > >     2. remove body modification, if present (mailman list footers, etc)
> >
> > Done that as well (cleared msg_footer setting).
> >
> > >     This way any messages sent to this list and to any other lists are
> > >     properly
> > >     deduplicated.
> > >
> > >
> > > I think it's a good idea, I am not an admin at librecores.  Can you guys
> > > help out?
> >
> > I made the changes above, let me know if that's not sufficient and more
> > changes are needed.
> 
> Looks good. The list is now archived here:
> https://lore.kernel.org/openrisc/

Thanks it looks good.  I have added a link to this here:
https://openrisc.io/community

-Stafford
