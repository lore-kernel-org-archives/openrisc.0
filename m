Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828E1F098A;
	Sun,  1 Jun 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748793913; cv=none; b=G9fy6AHpSSPHzn+EutNSTw0gD7Xdcq5je5DQMuEuKF9ig3O9v8oY0jFqbj6wMRM6YyTtXo+fgJeDHTLLKXRrLAfPtjTIO9q3dpK+KhAHgQskVMF0MB7pFY3ijibWb6Yd3mi4aBLyvuMIl1GevxfhHXgTkxLIxjfA3nNhucIFgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748793913; c=relaxed/simple;
	bh=YDFNQLZGbof11TFJyQsbe25oGVLZXtc+QMNLR/0duZs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=on/e8b1lBMas3uLZJLrejWC7Eye4n9lpAsHAWR9ahBpcg3y5AsS1jxSGpxfsduKwolGWaJCFO88IkX4ggNaQHuaXU9p04N1hQlmR0lpRTvlH463oFJbjjjAqQSI5Cn0jBrVjZ6uzuiqbGCJ208dnpdAyZRu2M6T6dZ4QoDxqp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/tuSI55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/tuSI55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A53BC4CEE7;
	Sun,  1 Jun 2025 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748793913;
	bh=YDFNQLZGbof11TFJyQsbe25oGVLZXtc+QMNLR/0duZs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N/tuSI5583ixRQVUYYtu6HizP45i/PCrOXpxmVAHbj6LvYl/Yo7AE+GbGUKjX1cNf
	 8dTMs2YmvZ/d3Uwq4HE0j5Pp61iyfMkDzg9v0QqwtjlETGFGw3I9d6NF7YC4Ab7w7R
	 vpWoyfVK+20rYAOiZtse2zlXQN60BmqEImkXuPcI1cpnbJRvBOY0cViEpMeBCBC3k5
	 6xoIityMtXyvqD85sBsxzmvw1kyESrAkR6txaRptDgQ+h5olqgFUaLUkJC2xTlJYmT
	 wtu5+veyK47In81yO/EndjZNqXpKX1jCMKiXRbu4yNCKO0Hl9slXf7nMl+u4uE7gPq
	 Vys4y3MMb79Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7B380AA7C;
	Sun,  1 Jun 2025 16:05:47 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDwgkjzeTVNUs1Ee@antec>
References: <aDwgkjzeTVNUs1Ee@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aDwgkjzeTVNUs1Ee@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: f698ee1f40030118e3ae1af1a02fa76f79452b5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82dad698061c2db166fdcf92f549d34ba038e829
Message-Id: <174879394604.436212.1871579274146845516.pr-tracker-bot@kernel.org>
Date: Sun, 01 Jun 2025 16:05:46 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 1 Jun 2025 10:42:42 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82dad698061c2db166fdcf92f549d34ba038e829

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
