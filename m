Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9121BE251;
	Thu, 12 Dec 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038843; cv=none; b=ZNNE4sVlFGTYdq+rGuVf/e0fzSkmMawHjVHtDVtL3NFIsOBjCvVV/amjt6lWE5WgXuMtWP4IRs+TqIP3Luf6mgMxR6L2d7ZqC49DD+LBAH4fn0w0gFQca+kCoK4fT1oQZm0JUrKxrOzaRYnhdaU3vcP++Y6TurhcabhG/SpXmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038843; c=relaxed/simple;
	bh=yeMpQMu8vtjPyTNchnmQp71H5DFVu4LKHiQqjpgPshI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kpNXG9Egai6sOD2p1I6PQBuDUt5eNiUQCdMDShRMJw5PEzSwDNjvVIAGegspSIgu1yKaEVWqNoFAEhZPC0AR1tm5PQTQB84PWBD2Hy3M0gDxFyStffx5xhISjLl8Owo6GkeeSyrhucPwGwlW9mZATsECKsRU2id9QLsOFqd+kL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq6u+UCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq6u+UCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C178BC4CED0;
	Thu, 12 Dec 2024 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734038842;
	bh=yeMpQMu8vtjPyTNchnmQp71H5DFVu4LKHiQqjpgPshI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cq6u+UCVcaPRwfHz5xSzkuFMOecJdkYEOVO2HqYdUsCWjFU80sthI0ZLmjYhejZjy
	 8o2+JUoCVyWRrYD1Dt25EQx++k+98tHJm+4u8hnW4JluRX9/FI7g80yATc+Vk3Jn4v
	 QRlEbPVXvzS2RaLV0flL7M2VVXZBdH7ChfNxNgh9XAoTl9Vwh+w0F+tUDZeUDOCFNw
	 /kWxsAWd5WilKu9Rmhw9UF6/KCP6wHLAIp/60KLxZ8B++jLqKh18VGhsEi61YDZVUJ
	 iQEm/CLcrozS2SKvS6IhGOXdVSd353letgE7I3ECIlgBlNAJKCLkZ/Gim21BKDrvYf
	 t2rYfBe9J7EwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D59380A959;
	Thu, 12 Dec 2024 21:27:40 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z1sUC4d1kUipZIy1@antec>
References: <Z1sUC4d1kUipZIy1@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z1sUC4d1kUipZIy1@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: c8f8d4344d50d72181207ee73175bba567c25f58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eefa7a9c069908412f8f5d15833901d1b46ae1b2
Message-Id: <173403885873.2445651.5754106919114040116.pr-tracker-bot@kernel.org>
Date: Thu, 12 Dec 2024 21:27:38 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Dec 2024 16:49:15 +0000:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eefa7a9c069908412f8f5d15833901d1b46ae1b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
