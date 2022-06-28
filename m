Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1254C43334
	for <openrisc@archiver.kernel.org>; Tue, 28 Jun 2022 21:01:41 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E16D5249B0;
	Tue, 28 Jun 2022 23:01:40 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mail.librecores.org (Postfix) with ESMTPS id 2B1832133D
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 23:01:40 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id x20so6551973plx.6
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 14:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=op7eUwnJSuDxiUQ7wEzydCPAKOVz5BBBkZHnysyBNQY=;
 b=nZImfPxtvFd+PtvuuVUOznr+c43CAJNmNug6lKpgDK9tHOSt4DMJN9Qy8zuuoCH+V1
 kzkvURahXkI+/wUpap6n2BFihTGyIBvoC/46tb5oTgrddJXKi+6KDrXonSE4bXSYE1cN
 pwzhrEFPYmLxAAepUTC5ykHV3lE0vT8MW7vxCr7x2zhpRlH7YnXpTBdqCKpTxnYa1Seu
 XZ8eXKygnUttchw6hx6wj6cGzDUQm9V48Tj0WLdQoIwcOW2GylgfiZz+3RxQ93V3dMqb
 RUcDywSmX1kN0ZNYnNxs/Bl39B1IkshcCMbOd3EZzr7/PORZ5hRBKEIpFK/gHyGItGkU
 UNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=op7eUwnJSuDxiUQ7wEzydCPAKOVz5BBBkZHnysyBNQY=;
 b=5LXQPT3QGf71DJJ6Xe+yNsmcU/1kKrPD0alNqhwuvMycsTuEX6G3EjgnWItk6J+DqV
 MF1y8dDniWE7nWmmK3ZR/qKTsfnORckrOju609j17gwpc/Mhvp4Zd/QJ1OS0zCQnZ6iv
 ZYXuQZs12aAdUrih3zZStOHem1BevUza77/xCerWhNQJmqK2h9AMlqwjUUrHmTHk46VG
 3eVeFZka2ks0uf/Ogj5WcmO9rPMkaAQfoSgtiTA2b9kJYogAwqWU0mmVq4/lp2WpxqJn
 BJTEN6ry9VbbhJLjzHdhuDTA3jJlq0mE60LRgBHxBf16+FLD9FQEKxkix09BFxxvIA6d
 lLEA==
X-Gm-Message-State: AJIora+oGyOLrgSGJKNH06X34tSZeTdb+i5kMhDwbAkEIQCK6EguvPZx
 Uev9Chw6brf0tZKKvVCsFeNog6sMXrM=
X-Google-Smtp-Source: AGRyM1tynwG8Qi9BmZsJECoNPZUqjR7PtEj8llMTsNvXuUowRN9ZrBZxWRSCg8ZnSD380rimtq0mjg==
X-Received: by 2002:a17:90a:b701:b0:1e8:6d19:bcb with SMTP id
 l1-20020a17090ab70100b001e86d190bcbmr1670430pjr.218.1656450098653; 
 Tue, 28 Jun 2022 14:01:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 y201-20020a6264d2000000b0052521a00e69sm9899175pfb.124.2022.06.28.14.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 14:01:38 -0700 (PDT)
Date: Wed, 29 Jun 2022 06:01:36 +0900
From: Stafford Horne <shorne@gmail.com>
To: Joe R <joelinux1992@gmail.com>
Subject: Re: [PATCH] wireguard: selftests: support OpenRISC
Message-ID: <YrtsMCYXCkA+oncE@antec>
References: <CANmBqSDd-n2gyvkDgAqOO_Q43dRodrS9_BFmkxDY27O87p=Q=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANmBqSDd-n2gyvkDgAqOO_Q43dRodrS9_BFmkxDY27O87p=Q=Q@mail.gmail.com>
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
Cc: Jason@zx2c4.com, openrisc@lists.librecores.org,
 linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Jun 28, 2022 at 04:36:34PM -0400, Joe R wrote:
> Thank you for the patch, it seems like you put in a lot of time into it.
> 
> However, I do have one question: on the website
> (https://www.wireguard.com/build-status/) it says that the test is
> still failing. Is that due to the QEMU changes that have yet to be
> upstream, or is it outdated and has already been fixed?
> 
> Thanks again for all the hard work you do!

Hi,

Jason mentioned this to me too.  There are still some stability issues under
load that cause the platform to be unstable.

We will need to sort these out before turning this on. So this is on hold for
now.

-Stafford
