Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3025CC62;
	Sat, 26 Apr 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687113; cv=none; b=ecMU/DPotdEJy1Iahqz5ONKS2aZsep1gX6sy414cZFwZ+dIkosxZKuLuVhDOP3sQ63uF3pL3nn6m9/vr/u65YRf31lAW3VvvCn19sQsfqh9GWrv8p8FdaNR/T/rISkhv6ghGj5BFei+zCOdhA49FwNSTnTTidIFIdx9KYus8qfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687113; c=relaxed/simple;
	bh=WPJx7uGEUu0qSBoHXXUKJoIaCIpAcLgbVUJ7OsZxi3Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ISe13wZzjWupacE6Z/UD/1f87/UI7vjLlnklF7xVJ4ZFs7j/HzYqjOGY9BjFq1tfWkABMsQH0QP7t1oUzQKBV8XgUPKPtr/bwEvdY6u2YOIh0Dgkm6cwCm6kwJnccvB+7vcQsduio9Gcl/dUtP2LVuBES6P7v2HjWc13LDDtWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOJ1jXpc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOJ1jXpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38394C4CEE2;
	Sat, 26 Apr 2025 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745687113;
	bh=WPJx7uGEUu0qSBoHXXUKJoIaCIpAcLgbVUJ7OsZxi3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QOJ1jXpcWIZvFJ62q1B9dX43QhcfwDjB4uyLQoYfb5jlEsuKpvmEQSWdJIccHo98J
	 Bc9Mqe75Bf3KJJla0vns0nmlHjXWASEjW/0QX/1PpufSDaIJEf2UvIHNTtI0H7oVWb
	 apEoSBN9HvzT8A5XZ+nCmcNfqf6qqLxTw4DFYM6STF8TYcIoWipk1Z65JPdnF7XmmK
	 eWAY3sG82BrboahozwmsNCqmCRk8pt6MrF5uaEHgcd5JgCI90zZas+kv9dfpnNzAYB
	 pN6Gl7EKPrhHm/PSD1tijiSeiTX+++ppKbK75PrOzI/2APANyLGMoJ7mpNoPRBDTYh
	 dcFPGwtEKOeMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE738111CC;
	Sat, 26 Apr 2025 17:05:53 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <aAx9lbfe28qzOpf_@antec>
References: <aAx9lbfe28qzOpf_@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <aAx9lbfe28qzOpf_@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 66ffd2f3161124f2f5019b55d8ef3add26a002a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec0c2d5359e2f288d75d98465829d31c6d26da47
Message-Id: <174568715187.4031081.4258314944883122973.pr-tracker-bot@kernel.org>
Date: Sat, 26 Apr 2025 17:05:51 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Apr 2025 07:30:45 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec0c2d5359e2f288d75d98465829d31c6d26da47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
