Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133BEACD;
	Sun,  5 Oct 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686197; cv=none; b=LxI73C+srqTz2b56/jPlcILyKn50h1QtL8DUgx2Ymy4j2XKwjmJmy+03DFD+e3D5hnkL39nZrbt8D344BXpXpiUY/FEAAgQ62puRmCJOkexAMdbvvG/TaZ/EcgfxTNMrxbi9GxakfS6zt6MMv2gleO/0W9TDQCm8SXKinpINots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686197; c=relaxed/simple;
	bh=+7pguDcr2we/KzgWM4xKYN/cG8I2Dw+s2UaHd81qOMU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FDbgzosCnXh10LQ7omAd/K86hkxzyXsPtQRY0wvAIONF5PIODXw8W0afEZ3RrUzy6ifzxbhD7IH40VnKrNbPiU/7hPvX1qHwb/we9zH/opkTKzX8uRBL4gsYaocwWPxuxPlXO5F/y0gn4jF8p9QhHQ6vPK59p0idXXTAwUcY/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQQ+ZnyI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQQ+ZnyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CC5C4CEF4;
	Sun,  5 Oct 2025 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759686196;
	bh=+7pguDcr2we/KzgWM4xKYN/cG8I2Dw+s2UaHd81qOMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KQQ+ZnyIiyw84tI7qbhNSnntP2YLUtgwxnHWckCuomrvjQKLBqRA7Xx8tld2bmE9O
	 sBo5z/d82FQtYFc6LUfK4oE7IJiPHkx2qX2xgxjYFaO0hG19C40C3LUHkYqfy7pVJ9
	 PH9UoBsSjmkLsQ1s7bDfebEubgQa8yCm5CtxGo3VMewYA9+YFreWK+aPWULCpwhZM9
	 T8UrAoBLpzw5SlPOwOUveV3NIMx7fDVW80dzC1PLh+uAfY29L7Qo6PUBjALSTI8NZa
	 8E+Hgm76hI0VOhC8AwYlkSOHTZwB2OQD93MsLVLTbJF+qWqdpzRz4kt1Vitz4sgukx
	 0a16Ug3C2Udvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAE39D0C1A;
	Sun,  5 Oct 2025 17:43:08 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOIRtnhTn3Gt8yr5@antec>
References: <aOIRtnhTn3Gt8yr5@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOIRtnhTn3Gt8yr5@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 8c30b0018f9d93391573e091960d257fd9de120a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 742adaa16db994ba1748465b95548e2f28aa18ca
Message-Id: <175968618674.698585.16079975281024454367.pr-tracker-bot@kernel.org>
Date: Sun, 05 Oct 2025 17:43:06 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 Oct 2025 07:35:34 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/742adaa16db994ba1748465b95548e2f28aa18ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
