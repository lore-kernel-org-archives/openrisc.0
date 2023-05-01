Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3462C77B73;
	Mon,  1 May 2023 19:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjEAT1N (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Mon, 1 May 2023 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjEAT1L (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Mon, 1 May 2023 15:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5282E213A;
        Mon,  1 May 2023 12:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C94061ED5;
        Mon,  1 May 2023 19:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0E50C433EF;
        Mon,  1 May 2023 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682969145;
        bh=o8zFzD8klOF9d+ygaHWEwDxr8HTjtvXUStuRIgNiEpI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B1uONizlB/xQBD/9Aru9ZJC0RL7PvK5fWNOZUkzvWshVW/ibWAT9OaDKtiU+L029R
         MGAku4jYS+ZQCr4Ho1NWjrVuyOb92NkT4Ch4e2CII94puss41qRwWDm5JyES38u4y1
         8pq5r+S1Q0Tf31idcnTUWWd+RPQn2gC5e8RMRNUkXKmIOGMyqCgcNgrFW9lMYJcROA
         PYT9Q5Z9JT+3Wbm4csdd77vq9igxtvDYTLX2siegMikPITFqP6GVag2pPwcNUuKvfM
         UNywYseD4wfDUPrwNwnAlHM0s3YvJzj0H8omDHbqcuEeJvR35/Wx4DhaqtdYmgASeU
         NnBa7sA4xuV8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EE8BC395C8;
        Mon,  1 May 2023 19:25:45 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC update for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZE7DIL5TkeLZrOB+@antec>
References: <ZE7DIL5TkeLZrOB+@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZE7DIL5TkeLZrOB+@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: c91b4a07655d5ba67962a08dfac8bd7f45ad049c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d75439d64a1e2b35e0f08906205b00279753cbed
Message-Id: <168296914563.17937.14505691544157983972.pr-tracker-bot@kernel.org>
Date:   Mon, 01 May 2023 19:25:45 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

The pull request you sent on Sun, 30 Apr 2023 20:36:00 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d75439d64a1e2b35e0f08906205b00279753cbed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
