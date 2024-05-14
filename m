Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AA181B9C;
	Tue, 14 May 2024 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712119; cv=none; b=W2T29jwL4ItV8hGNJVQecHyiKfWOOArlAqXkPAHHVQtkeovvOiXpCCKru7HjHyzyJtULEbTar3JyyR3k4c28I/kpstwL5i/ZOwlLdp84RpJCmLqA0T/2xCLaN055+Z6KKxRMVWCFkOO+4JcCB4G449glXKqQp/3uF6oxojXMIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712119; c=relaxed/simple;
	bh=1kh35XskmiMKH/cxumaDajFCWX/O2Ot3u6gKjNAxahw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M3dzdano82Vurvd86FTG4t1x6V76i0sc5jC/Rb+DFUp2w4Wzc6tr5DJIgSglw0exrER51hZt25iQGoXKBnHttMDusZ9Q72VBPZr3qEtMx017fIZlWoJ4kxOylyW8kEI+zW6km2lVByJ1MVEHZRCcxUVYKAGxIo7/321tULtJvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q86/qKve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q86/qKve"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A36F7C2BD10;
	Tue, 14 May 2024 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712119;
	bh=1kh35XskmiMKH/cxumaDajFCWX/O2Ot3u6gKjNAxahw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q86/qKveITjyWtKEvU5jigorenRST5RBL+9BQpK17jWO7U016zxHyYPsSmeVcv0g0
	 LpAbT2dBcCMmbEefAFK2ZQOfkpquoxRemmPIwHTuZC4rWN9/fhCoRTVeROlteQ2gjj
	 AGAYOEaHjiKN/0xqOb2YMPW7CzxPDhEqI3/y0ue6s8LhvloXGQtc7O1c/CS1uAiWG1
	 fIL7oCEegCvR9BRvwK+ZAvpR2erk570a2YdQ3nM2J+6vabBF2gQhNWpXoIwcXzesyQ
	 ITFI57Y0nWF3U6HOZBQf1GVGLYNqnox1WvSJd6Z12RLA/+TkmXAQZ8EB3gskOIFxVW
	 GgzBgStkfpPDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B187C43339;
	Tue, 14 May 2024 18:41:59 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkOEkhs_-wiwucSO@antec>
References: <ZkOEkhs_-wiwucSO@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkOEkhs_-wiwucSO@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 4dc70e1aadfadf968676d983587c6f5d455aba85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 590103732442b4bb83886f03f2ddd39d129c3289
Message-Id: <171571211963.4202.10926114607793169471.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 18:41:59 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 16:34:42 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/590103732442b4bb83886f03f2ddd39d129c3289

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
