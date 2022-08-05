Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FFFC00140
	for <openrisc@archiver.kernel.org>; Fri,  5 Aug 2022 21:25:36 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 502EA249B9;
	Fri,  5 Aug 2022 23:25:35 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 7676B249B9
 for <openrisc@lists.librecores.org>; Fri,  5 Aug 2022 23:25:33 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 895BFB80D83;
 Fri,  5 Aug 2022 21:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39FE0C433D6;
 Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659734731;
 bh=7GfYWcT6+l89XVda1+TcRuG0YqV1wtvlmyc1VeLGRmw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=fYX4wpaSjGV8hXlnrjzjU4SJSHdmJa3OEbHVXkQ5S6RvsNFyU5VRCLZdwgG73HYrh
 VXosQi0TmgWUGHIcv8lzUNubPMX4Zff6rkQReNtNrTylWOCpj3X3KgL1kkUy+ejBNK
 yxr7eDfM7f1c7itMzw7Eu1xAL0aZ9ERgXU9IM2I1r+P+Ggb/kyy/LYfjKhuxRoCWb5
 BNiG4XOc4XSO2x1zHFxbQrn8m/NyhBdkoGnruStqZvtz8FU7mkVFtH++wGQKg7JQnJ
 Mu1zpQ9rYqcpJlkbQfLU2OvY/TKk4j+WiBK96QjqeakUpQJE2H7s/Ti6/T4c0M6hWw
 vIJfrcMtAEZkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 29FC0C43142; Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fixes/updates for v6.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yu19zEVnjSkH8nO2@antec>
References: <Yu19zEVnjSkH8nO2@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu19zEVnjSkH8nO2@antec>
X-PR-Tracked-Remote: git@github.com:openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 52e0ea900202d23843daee8f7089817e81dd3dd7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d5398a3ec060c1e3094097e52a19a4d0013c0e0
Message-Id: <165973473116.8747.13652673284909489427.pr-tracker-bot@kernel.org>
Date: Fri, 05 Aug 2022 21:25:31 +0000
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The pull request you sent on Sat, 6 Aug 2022 05:30:04 +0900:

> git@github.com:openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d5398a3ec060c1e3094097e52a19a4d0013c0e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
