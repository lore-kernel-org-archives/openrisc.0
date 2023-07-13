Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53CC001B0;
	Thu, 13 Jul 2023 21:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjGMVlf (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Thu, 13 Jul 2023 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjGMVle (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D812691;
        Thu, 13 Jul 2023 14:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B4361B7C;
        Thu, 13 Jul 2023 21:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33C5AC433C8;
        Thu, 13 Jul 2023 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284492;
        bh=3JvPqEa1GFkBw4E++eZtthSt3xnfoZDBIXWi5DtceVw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IHhavEOSY2lVw6TLkVP4vX4cA/Xftf+irYY92S8laMAcLbrPljPFly5hwlG7hqRpR
         XXmx+zcMt2TTRLVeDci/cagwNwKxA35dk72ZOBW26oj+mEe+x31am4WnFU9UqhAQ3s
         w8ZoCUZ0VTRX+KeFaGxK6fU18KlurC2xGcxAJk6WVOJWtihVSnzFZaShAe+8WRuLVl
         /pTbuRarC4ZY99hHZhAln8YKsS0nzcAO+N0MigE1bIN0i+nTpKMphd/7P46sEhwwSp
         OpAnpwf5EGoYe5qEOem2M1L0ZUegInC8vDHC5wfld/JLO76s0g6aMhHpiTj38BjDQO
         yY5tlIp+tR7GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21F19E29F42;
        Thu, 13 Jul 2023 21:41:32 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fix for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZK8NY+xAAHRTSEPc@antec>
References: <ZK8NY+xAAHRTSEPc@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZK8NY+xAAHRTSEPc@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: dceaafd668812115037fc13a1893d068b7b880f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0099852f9d7322890636503146f303b41cd8663e
Message-Id: <168928449213.12038.10658881121373883641.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:32 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

The pull request you sent on Wed, 12 Jul 2023 21:30:27 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0099852f9d7322890636503146f303b41cd8663e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
