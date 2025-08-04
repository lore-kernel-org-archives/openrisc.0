Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EA238C08;
	Mon,  4 Aug 2025 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323512; cv=none; b=hO/cKjPbkSkLQ+rpjp5FzDZu+WHUrlJNb68sjaXomEbTgSiHDzB9Azey4zd7lbe2kxn39eCQexiEt5oZw/8U95xz/b7A65WU9/rBvTWaSBgQijINzNALCyv7zZVgiwRK+B/XxlFOx5uKhUmG4kutZDXpFYCMKbJlz6Jmju1/UWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323512; c=relaxed/simple;
	bh=GYCTFAmn7Ea7vLISYyAAuTqFgAy63YlP8MQPb9Dw1r4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S/RdaYv/VJ8dL3t/KdUhfoz+UZ3/X+mUcX8n+5EmYF2ZsO5hYV5xc+NBfOpxRsatbVsJ9Gd1o9TL00NQNOOrt/8uBFXX621oM0dOlhjCtx+PCDvlfXu4DuLyU1ljFtiFvFMcBRF9ev6CnuilcmvetXaenOiBAV3qH7nz92Wan3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcYzMoQt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcYzMoQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E4DC4CEE7;
	Mon,  4 Aug 2025 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754323512;
	bh=GYCTFAmn7Ea7vLISYyAAuTqFgAy63YlP8MQPb9Dw1r4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GcYzMoQtRjHwNtYMODDyv5QlW21rsfRm23itcvDRitQ7vaYmdvUTj46rcsaU0pSzk
	 vPy6VEpdD8DTkksUoIUJ4Zc5GBLxrqgq6dJHC/XPofR77TQuiaqChr46AF7nsDCFGk
	 o/k9yINPcWJ2RlREc4yem7Zgg6XfApnUFl+s0NVV1Sfm4qWxIAqQE4SL70lxHfwpUS
	 27lmEzahYvLH0uG3FrE0a2gcCEO8U3tSGP43FKgy+JM9WTH4USoC4CjTQ096JLA5He
	 ux8SflFSMWBgNgrudc2Koejpdqo6YtEgq3dtzkBG4Pmsp9DbCFN+nkeHtMDT1Yg/60
	 glKv5z7mULNAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3411E383BF56;
	Mon,  4 Aug 2025 16:05:28 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aJC1Ex3rjGT_-vxI@antec>
References: <aJC1Ex3rjGT_-vxI@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJC1Ex3rjGT_-vxI@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: f0eedcf22581ca1cc438fb38a479ff41ab882d51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69917dbfb67e5e7869b67425e2c799aea4d00874
Message-Id: <175432352682.1247654.9179057017808071856.pr-tracker-bot@kernel.org>
Date: Mon, 04 Aug 2025 16:05:26 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 4 Aug 2025 14:26:43 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69917dbfb67e5e7869b67425e2c799aea4d00874

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
