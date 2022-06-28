Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2272C433EF
	for <openrisc@archiver.kernel.org>; Thu, 30 Jun 2022 22:08:08 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 943582406B;
	Fri,  1 Jul 2022 00:08:07 +0200 (CEST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com
 [209.85.219.173])
 by mail.librecores.org (Postfix) with ESMTPS id 2142424987
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 22:36:46 +0200 (CEST)
Received: by mail-yb1-f173.google.com with SMTP id i15so24311233ybp.1
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=Am+buBS6l9nDliYi+u6nlrkdsgJwYS/B4MsYLVetbz0=;
 b=D+OVeNm+qvlXxecJvzQgMO+iI5wnx/Q+mmwN4AY3Lk+s3B2SwNd9P1y9S+PGzcyFzV
 bZ1n9262BipKLcCfsy4kigvYQiheYVnfgCmWcUusxVNPE8tgJyqzmmqyPg7q0YPoP8XY
 sBQEeSytPIU4FhSXkTuxZD7+ddIgxI9Z4hmeZx1r4LjPVE1+/forNrC+qxY0COQ3b9sh
 Se0VL0Mt/Dq6iiq1HzWEFJFk9ja+BIEK2KeOdGZ0nPsapflE8jJ413qa6OxkupFS9vxD
 vgra8Hzvb9AurSik+ryWVWxUcUl42un9D7jR8K4f8O+BkBDMrpDOiBHclho6e8A6qPct
 g2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Am+buBS6l9nDliYi+u6nlrkdsgJwYS/B4MsYLVetbz0=;
 b=KPJZphsCY0ZhxSR6EGgkk8zjnCr8udQ3GU9L8wLxAeRGd2h6PFB27KVo5axU/LjreJ
 MqicF8ZqEBPVjPMgrj668dXgED8PaqfnK+T5UEVTjRy7QdlVhLFULvHUhQeGpW07l5Tv
 OxeSokbSsBVs6tVq/JVawEtntKb3AFB1b0IRq7UWQoxTgPzLcg6DjBeIRPbmwZ9NgywS
 Q6DDueZ4HcLC8K2UrFeqzGIGaXNmxJUGkWsolrU36KpyvaoBgpX7sT3Lhl5kb/TA/2H7
 JLSV5GL1XY8Bojncmvd+S33r/JGuaHqDIh4VzzClIv77vkeZZSVmJLbZttoa55NBNfHZ
 FSOQ==
X-Gm-Message-State: AJIora8WewdZJUZ0Cr+Yr6G8G0XiQExQo3TkcHVSL0IgycCp1Ospk84W
 2ESHrlGwLwizhLW2NhfXm/fltTnKVhqQRN3LQ+DQAJtfYQRMX2QJ314=
X-Google-Smtp-Source: AGRyM1s5E4nHxae1yrblcbA4tTqiFMh24HYtR3/tjtzturQ07ZM7iIEDC9rbqQPZlZI5e3z6g50bhHP7kYzrpMPKrq8=
X-Received: by 2002:a5b:f43:0:b0:665:6ff:c70b with SMTP id
 y3-20020a5b0f43000000b0066506ffc70bmr21793547ybr.216.1656448604796; 
 Tue, 28 Jun 2022 13:36:44 -0700 (PDT)
MIME-Version: 1.0
From: Joe R <joelinux1992@gmail.com>
Date: Tue, 28 Jun 2022 16:36:34 -0400
Message-ID: <CANmBqSDd-n2gyvkDgAqOO_Q43dRodrS9_BFmkxDY27O87p=Q=Q@mail.gmail.com>
Subject: Re: [PATCH] wireguard: selftests: support OpenRISC
To: openrisc@lists.librecores.org, linux-kernel@vger.kernel.org, 
 shorne@gmail.com, Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 01 Jul 2022 00:08:06 +0200
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

Thank you for the patch, it seems like you put in a lot of time into it.

However, I do have one question: on the website
(https://www.wireguard.com/build-status/) it says that the test is
still failing. Is that due to the QEMU changes that have yet to be
upstream, or is it outdated and has already been fixed?

Thanks again for all the hard work you do!
