Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E3BC433EF
	for <openrisc@archiver.kernel.org>; Fri, 27 May 2022 00:33:01 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 67711248CD;
	Fri, 27 May 2022 02:33:00 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 9847B248CC
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 02:32:59 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E4201B82178;
 Fri, 27 May 2022 00:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C754AC385A9;
 Fri, 27 May 2022 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653611576;
 bh=KvSPMQIykRMdyjnTd5Ib7q9nFZwrFXGBZDk8gRCsW3A=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=GHbnDJ+S7mfdXyaqMWXEFp/0cozpPQgC67fignj4mleSMmF4CjSe/Tv1nHnmjijrm
 fxDtT2AANOXjO9/loIvbld+GG1S9S4JXU/OQObMqedtX0xc087Snjwh3F/NOvyzTIA
 K03GQhXHCtjRJBQA2mvCwgFZ8whorNj3Oa5R+4b3RgE1lf6TV5S9o18ohR9Qp5Ii1J
 Nelfgud/AZhj08ETSPa1jEXvEvmCdCUbdgUWVMdVDaeqk1GlIDza4+tNvjsj3stLzq
 GsLU/egry7fWphk2MrBN1DpFn/eeA9kKZvVxR/KkGmOiFddeIoz8nX1xNS6Cqkjcp7
 DScD7+OEyGhSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B4198F03942; Fri, 27 May 2022 00:32:56 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yo/955uRNSaSMBqn@antec>
References: <Yo/955uRNSaSMBqn@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yo/955uRNSaSMBqn@antec>
X-PR-Tracked-Remote: git@github.com:openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 83da38d82b2f7ac207646e55be94e8bd642e2c39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f50d4dfe816dd916a7cbf39039674825c2b388b
Message-Id: <165361157673.27205.13660904432958080717.pr-tracker-bot@kernel.org>
Date: Fri, 27 May 2022 00:32:56 +0000
To: Stafford Horne <shorne@gmail.com>
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
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The pull request you sent on Fri, 27 May 2022 07:23:35 +0900:

> git@github.com:openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f50d4dfe816dd916a7cbf39039674825c2b388b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
