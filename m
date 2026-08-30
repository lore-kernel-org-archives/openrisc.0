Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB421D3E8;
	Sun, 30 Aug 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788110669; cv=none; b=ituo00sgDSDsZ4IwaSQGAHQclV4OUV/GzeL+5ex58m4DVy9sHUpHRfBQ6Z9CvNdqMB79cuzQMSd7voJSdEL+Le3K6hnb6pMQr5kZ8Ky7CaNTrpVhczabXW3hrRg0mTwY2KB+H/ourTbMV++mCKWHStjUnKqV6+NQ9fDJNWNlGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788110669; c=relaxed/simple;
	bh=EeA2fkxwyH+Le8SDL7EPsQLTrHevInLnmfczSuL/rQ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ajen0THjAmDAKtURjugN3Mb5ISkCjej/mOPvPmfsPsJM4qYZtQkhrfTxh2kwFfGeYrzZSVBdH/vxRvWyqeOyGZqc4aaIS5QTiQvmo6XGXDGH3KdVkbg7ZZmXY234OOU1OnJAI6nMA6g059JMt+et+PYm/PxcEXa5VAOeTesAkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6q8w7zs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6q8w7zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E4C1F000E9;
	Sun, 30 Aug 2026 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788110668;
	bh=ORApLwr3322PzRUx0EEDKux1YbeBy3RWLX6F4hxWCqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=B6q8w7zs1kpW3BmGSPZhaXmU55uAsyKshv7mccMiRd2RYsFSj+Iz5oUtAF3iKInl4
	 RLsOm1SoAi6uZRduwpp4sB0JtaW1LOqWUOHIXrrgFlil22zwbahJwB5vgfq/qnZESD
	 icXI7akpUXuFv8Vey5/zPbqbPrV9YXbE5cQZBnPGHzp7A1FhOrWSBfX8OgYKOlYnSj
	 Pl+N+dixQBv91NZZ2XjgerDXY/Dvs7OMhA1f6/1Pc2vLOxE1nU3+1dXLiopbsnleBp
	 SCqcuQH+sMS1aqBVzgVnx0681MAjyqiytHhn0BS6GonPx+DCZVm+4KaQ0/RKu4ExXy
	 n/Lu/LK5//ZrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19999380CEE3;
	Sun, 30 Aug 2026 17:23:33 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC 7.3 updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <apJ-2fH66_goKXF0@antec>
References: <apJ-2fH66_goKXF0@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <apJ-2fH66_goKXF0@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 78004e9a87f240df03e2f73120d291763c32e0a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb5b59a6a678bab054a78d99eecfdb6f5558e82e
Message-Id: <178811061170.3405738.16015315399149286089.pr-tracker-bot@kernel.org>
Date: Sun, 30 Aug 2026 17:23:31 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Aug 2026 07:40:25 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb5b59a6a678bab054a78d99eecfdb6f5558e82e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
