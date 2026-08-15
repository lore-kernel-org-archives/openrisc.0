Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CD41B8E4;
	Sat, 15 Aug 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809656; cv=none; b=ePnC0zTfAGpkuYAL9sx8QWgkykMEjjWq3bAaxFXkOnMofKa/oVVKYR19sctNZqp+G0hq9heT9oFxepQ0wLcaLh9uPqHVKtNsNjFBUEZUd5ml3KcdA3+Wb1+fVXq0Q4Uj2Oy6UwBpHLsZ0Pel/HUf4eS2pc20WcXpX/nPyB0x+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809656; c=relaxed/simple;
	bh=rjs/5JnqDZx4hsfBla9z4d2Z94aBzfS/cSVYAmOcIVs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lTG5fxmtY1XoSPAaWdAcCPyM1faK7a04fVUGH5ace+du7WAiZINjWt7JpZCybGvpO+lC/zBxrbK/0hPa74TCQzODSZ7UUBdvtWMLGpVW4geuQtsnVRbUUVXWu3HI7oS72l+eMZ9R42OPy9gaEIwXHcmHve2Hr35JAFpLaaWWAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ9+QjNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ9+QjNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928881F000E9;
	Sat, 15 Aug 2026 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786809654;
	bh=VI+22rBfL1vqfUw+os0ANUx7Lk6TqwC1HBkqUw821Zs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RZ9+QjNOKp18OQA4qSKOI/j2FZDhfeb2qKsTD30RSmsc5vA9jVBUS9ctATupG+dsB
	 u4jNAMU9XMiebKGqyrh2T868NBMLeGtmennm+HcL9wVMT6ATuWU+a3vx+BYj3NESw3
	 XNVONunVXhkBrguzLgIiIXQtLQSLI164H3fhorSEsLUgaX50h2eKb+CWHvgbv8sSfs
	 WCA+AYTJvoW6zq6MA6uPic0Vjq/2jZOPv0rVRLw2aWFQYsJatnXOtHALhp5MI/J25t
	 tKCTGbX554i8a9CN3IsaGOoCGspzTK1KmPyrOJlGqDC26y1kZLGGe2kVm9B+tP6joG
	 FTAX/m8cViy9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691F3924A48;
	Sat, 15 Aug 2026 16:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fix for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoAHUJuULSJM-caZ@antec>
References: <aoAHUJuULSJM-caZ@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <aoAHUJuULSJM-caZ@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 32ef1b30ad736519f7a207bcc2986f3d4129d972
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e060ff9d18748dbb21b12b821fcfc738823ba93
Message-Id: <178680960800.22095.17341952039664582264.pr-tracker-bot@kernel.org>
Date: Sat, 15 Aug 2026 16:00:08 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Aug 2026 07:29:36 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e060ff9d18748dbb21b12b821fcfc738823ba93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
