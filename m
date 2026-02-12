Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9968632A;
	Thu, 12 Feb 2026 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936514; cv=none; b=iw/dtukPLe2fYKYkzLWymomJcAPHksHPujuegfcUX2/yPBBEpnex/XoF2X2CtyagqC2d121gEH29A+gs3GOf607vgietmxplv9bA/lxbpiEVo5w70ZM9/+vlMaALzyj1IPt1eMYl3YMcpCjcfm8VOBA2FVGo4nuGZ6Bt4Qcnubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936514; c=relaxed/simple;
	bh=OLsibJ34Mjj97Fye4XiZI7myxikYllBnGmZ1+hhK4B4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c+/mJSQKQKf3jiqU9uQNM6Kl+LwMquMGPCX4WKS7/4HG+dMvoDf+OH5qNuuCmx7GIa79/eSlCoTc5zh5UUggoLUUZdmO4DS8+mKVr7rFjO9SOA122WQoTAFHbiYHmuKqMoqTXB7x6yGvgzuZbPN6zPY5G7K0esOagOfE78/m50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcUYa8lF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcUYa8lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5531CC19421;
	Thu, 12 Feb 2026 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770936514;
	bh=OLsibJ34Mjj97Fye4XiZI7myxikYllBnGmZ1+hhK4B4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GcUYa8lFLe+PieRtEJaGGnW5qPoxyaiO1e61ytXT3VYvptAPJqgwUgubXTwOrXA27
	 3rwV1YCIsGx+wQB2c6XfyGS6HuyyTlNl6MXarG4fJPNU/5uc2OkaL3MN8/fSWeO2o5
	 ac3Zg7CYDNhBw9O+6nIm1Mq1d/kM/lNd5AmuLE3ZeUCu289Zo8k1TmxUwLPivsyFK3
	 39wsZNiHbOhK0ILFFu2Avo2I9+75sbMG5KzwYUhRIggPuLrHPC+z9WCK6iNStmzaue
	 PVQEqsEoLKpPO2LEQCVShS3qBObzLZM/wWSr/Fqp7Dfbg2xp/BvbqRM3m3QG+tEOO0
	 X9YXW3gxVNJlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23633800346;
	Thu, 12 Feb 2026 22:48:29 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.20
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYw9r7h2ej3BUTMH@antec>
References: <aYw9r7h2ej3BUTMH@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYw9r7h2ej3BUTMH@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 0dfffa5479d6260d04d021f69203b1926f73d889
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a67594c977234b0ad6887202740e9e8b9821473a
Message-Id: <177093650828.1745286.2323263797954358240.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 22:48:28 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Feb 2026 08:28:31 +0000:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a67594c977234b0ad6887202740e9e8b9821473a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
