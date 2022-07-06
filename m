Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D871C433EF
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 13:24:15 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 182DA24844;
	Wed,  6 Jul 2022 15:24:14 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mail.librecores.org (Postfix) with ESMTPS id 70AD12422B
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 15:24:13 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 i8-20020a17090a4b8800b001ef8a65bfbdso8217143pjh.1
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=V4tYWS6dWP+j40mx+/UNIOoszj7Dg0+fwwT9LMM38/A=;
 b=BymM1sgLJt0ol6c/OkpKcKga1FfwNzmj7SD3OVhwdIzmeiXka3XMDDYBOZz7N/unqb
 Yc1CQm5KJBp+A9+pGPu7amuQkf2evnu3jhzRx95ns4w6rWRASkpj0aPC7hKBc29GZ5wH
 c2NVSBShJgMbjAtfU5DG9aOnT/nBqEHa6lbVajwOcZqWRhZI9BM6zjbzdA3YFdZ2qi4M
 1E69zM2GkrFzsYjQS7spE6yKbaQgI0zQdjsJwebF8CA35S7tYc0bSruS98u2jqL0sGsV
 ITvfDdOPvZetx38qWdvVpyvqBDg6fYgBqAF0xlYhsdVFYYdafJzdAA/ql23igshpuRNP
 +uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V4tYWS6dWP+j40mx+/UNIOoszj7Dg0+fwwT9LMM38/A=;
 b=h23YFkM/vEcHf1x5MHtA0cajDP9nPushJBqJNX0OqKgwpSovZRp3yWxSVIHVyBD2Ht
 DX3GktrILUZmB5LZbtQeQJgSE5CvVEfEZf08azywbXn39nUZn481YVujX56hwe6Z/UH9
 srjMl7ONxD2rjcPCtr/GTnxIGnDHUUguBvT4ztVFoW6BrSHqtdoT9v1kM6guZ8oW1pKN
 nBRes8kOftG6cfYaNGKGDwHCsifGDUvf6+MPe+oF+RRVQL8xRC2J1GeL9GPdWd2MghnF
 vPEFB7H3raU4dsfEBifCpPieES8/xs3sodSJtWS9ayHN74Dgy49Ly0oDEq+VLU/DuKwx
 Xv6g==
X-Gm-Message-State: AJIora8YDikCYPeiL+ZWcCd5HlLWvWe+G+obFYWmhm2BE09/MhbKOhoR
 vtraV4Wepe3fXRMly4jYmuA=
X-Google-Smtp-Source: AGRyM1v1X0JOuWMSFiehFCvxxt1YfSFIT12ay1QZmQPqS97R0CElAt7P40mDOtgXxuBvfH+b3Bg2bA==
X-Received: by 2002:a17:902:ba8a:b0:16b:988f:9279 with SMTP id
 k10-20020a170902ba8a00b0016b988f9279mr42995621pls.114.1657113852026; 
 Wed, 06 Jul 2022 06:24:12 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 m184-20020a6258c1000000b005289eafbd08sm2432646pfb.18.2022.07.06.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 06:24:11 -0700 (PDT)
Date: Wed, 6 Jul 2022 22:24:10 +0900
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] OpenRISC fixes for 5.19-rc5
Message-ID: <YsWM+im7pmU8MdeZ@antec>
References: <YsWMXAF3ePlWuxyF@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWMXAF3ePlWuxyF@antec>
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

Sorry, again with proper subject.

On Wed, Jul 06, 2022 at 10:21:32PM +0900, Stafford Horne wrote:
> Hi Linus,
> 
> Please consider for pull.
> 
> The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:
> 
>   Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)
> 
> are available in the Git repository at:
> 
>   git@github.com:openrisc/linux.git tags/for-linus
> 
> for you to fetch changes up to 48bddb89d59eec27c3305d179b1832d5292e285d:
> 
>   openrisc: unwinder: Fix grammar issue in comment (2022-06-28 17:31:24 +0900)
> 
> ----------------------------------------------------------------
> OpenRISC fixes for 5.19-rc5
> 
> Fixups for OpenRISC found during recent testing:
>  - An OpenRISC irqchip fix to stop acking level interrupts which was
>    causing issues on SMP platforms.
>  - A comment typo fix in our unwinder code.
> 
> ----------------------------------------------------------------
> 
> Note, if you do check this against being in linux-next I dropped one patch from
> the linux next tree before creating this pull request.  The dropped patch was to
> add wireguard selftest support, but we decided against it as there are still
> some qemu bugs to workout before turning on wireguard selftests for OpenRISC.
> 
> Stafford Horne (1):
>       irqchip: or1k-pic: Undefine mask_ack for level triggered hardware
> 
> Xiang wangx (1):
>       openrisc: unwinder: Fix grammar issue in comment
> 
>  arch/openrisc/kernel/unwinder.c | 2 +-
>  drivers/irqchip/irq-or1k-pic.c  | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
