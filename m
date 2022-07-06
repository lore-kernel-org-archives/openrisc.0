Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0BEC43334
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 21:24:51 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 8C0E52495D;
	Wed,  6 Jul 2022 23:24:50 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mail.librecores.org (Postfix) with ESMTPS id EE0EA24973
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 23:24:49 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id 5so8802529plk.9
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Lhp1fGKvwPNvsFfAFG1v3Vbo0uyHrO24/F8qohRrG4o=;
 b=TRsoU0qDks4bE5PcZFE0V98Tfj8OdOJ1+B8/RemOIavn7ZRlu4qEFl8Ey+KDlPIEDa
 q+RfpsegBpcL43ZGX1Twpx6xURoNXLhB8+hTEAKfaz1WV60ps5HS0F7F3kKRW++YS5B+
 JFchZcVx5CIVb2fY2Hk3Tf22puSNHCGEuFUqSzUjLyIWNtnqpq1GKoO0dCF+Y3jetJjz
 ydWxtnAFo9aEz2xW97yoU795D1iSalUQvs0m3vwyCabunIBAjHd4o3LtgQO/HbR7kJZl
 r5IwJC5rfa/6VRZpMsQVZryp13AHThbNiuILkjF8jgDlhaemC3MGv3jD8EaL7415som4
 uuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Lhp1fGKvwPNvsFfAFG1v3Vbo0uyHrO24/F8qohRrG4o=;
 b=FwXxWDBqc1GgUi3Iy5rxFfSGh5EAoPqtuD79uej3R9Blsqc2o5hi9FaIWgtSC/XVVa
 UNvT4tfXHjob0bbJb0ADQJtNxCXI2cD2dMjPQRg8KZwzxmKoS4XHv3/w94OZsOP33vSd
 3g1+lgUd0C1hRENGNgXKTO54Ft+AKlQ3oayvOghzD4CpiM6qcf51aqFUfRzjHXR4ktTb
 YbQ7ncvCJNRhVGPzBzHjtKOfM/3w3Q/rL12o+V/8iV3f0T4so0Uy0tjjYQ9QxJWxX/KR
 C+0VSeLU1bHiax4JQOfS+oU1yOseACSr1lGzEdjF1/pFQ/Sajhok1xDyrChKQtYVt9LI
 P/LA==
X-Gm-Message-State: AJIora+5yCJfA6nlpHimQpUsQd0LqlCo8+OTHs/ApvcRYz1ewY6dUQkI
 azG1vsKQTgPMXxOxEFaYA5o=
X-Google-Smtp-Source: AGRyM1vMNxnbxtFl/qv8nXCo7/FyRkmRkL9VygDE57x/TUc1m1XNkCtk/aXL01zatnnkHJ/XNfCqvw==
X-Received: by 2002:a17:90b:1e44:b0:1ec:cc44:be77 with SMTP id
 pi4-20020a17090b1e4400b001eccc44be77mr861283pjb.34.1657142688375; 
 Wed, 06 Jul 2022 14:24:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 cd24-20020a056a00421800b005259341029asm22166467pfb.49.2022.07.06.14.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 14:24:47 -0700 (PDT)
Date: Thu, 7 Jul 2022 06:24:44 +0900
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] OpenRISC fixes for 5.19-rc5
Message-ID: <YsX9nNRJb4qVqYW1@antec>
References: <YsWMXAF3ePlWuxyF@antec> <YsWM+im7pmU8MdeZ@antec>
 <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigH3PcQFjvEYcOZRQvqREcwy88iNFg0_ah32TJhQLCqw@mail.gmail.com>
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

On Wed, Jul 06, 2022 at 11:12:23AM -0700, Linus Torvalds wrote:
> On Wed, Jul 6, 2022 at 6:24 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > Sorry, again with proper subject.
> 
> Well, pr-tracker-bot still didn't like it, probably because you
> replying to yourself meant that the pull request details were quoted
> and indented.
> 
> So no automated reply for you.

Thanks, I need to automate creating these mails in my workflow.

-Stafford
