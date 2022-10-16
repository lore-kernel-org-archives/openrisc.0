Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9FC433FE
	for <openrisc@archiver.kernel.org>; Sun, 16 Oct 2022 00:15:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4FE2A24BE7;
	Sun, 16 Oct 2022 02:15:41 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 647B024BE4
 for <openrisc@lists.librecores.org>; Sun, 16 Oct 2022 02:15:40 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D224EB80B46;
 Sun, 16 Oct 2022 00:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78E35C433D7;
 Sun, 16 Oct 2022 00:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665879338;
 bh=t5U11+x4czcTlpCrS/3J3OedwSEGUOn1KQy3HtgOllk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=dkoJMzC/LSC973QoDYOvqn5nKJpKo2VoqUbIXCW9H4QX2EiZh03A1hfDDgaZ/XHGb
 aET+oHn5YJVQCjBRnj8j2iuJFdBTYEdMfEch4rNh/QDd9P+FxkHvLBTQOtd7dXLiAf
 RySq6QQoNI2OvnL7qGMeH1MEXHVeUQ9SN6U2jDfLHXCsWZJHfadj3NY5JvwKSO4XEM
 B65ldKbLmOnS6ANT6ezUYBihRCWD5c1R/0XoQZ2wYPmhJKwI7mEq2JXMtdnvvzTC7Q
 GGiGcE16hj8/n/kN1ItyWqaMa2xMF+PNKr0zxuNG77C0DUnAXuopkj6+8UIRcTWJXD
 io/RNd9KUH01g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 6620FE270EF; Sun, 16 Oct 2022 00:15:38 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for v6.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y0rkcqBr6Wan4ueU@stafford-asahi>
References: <Y0rkcqBr6Wan4ueU@stafford-asahi>
X-PR-Tracked-List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
X-PR-Tracked-Message-Id: <Y0rkcqBr6Wan4ueU@stafford-asahi>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 34a0bac084e49324c29e6d0984d24096e02c6314
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36d8a3edf8bd504320fca970f8b0633b8226cb58
Message-Id: <166587933841.18523.260321128044065343.pr-tracker-bot@kernel.org>
Date: Sun, 16 Oct 2022 00:15:38 +0000
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

The pull request you sent on Sat, 15 Oct 2022 17:48:50 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36d8a3edf8bd504320fca970f8b0633b8226cb58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
