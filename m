Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401CF20C029;
	Sun, 21 Jun 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782062868; cv=none; b=coxt5mueZ0/e1V8oyI2OpMPpaUPAYc2fveRS0EbNoUD2v1Mo16K4m2oEGWdtkUjajkDSsjyo0kgo7OA40znxEk827pAV2oEZjA4KPPQkVZQEBsz+zzSnv33UY1VhWGmC1OYB9HP1lnwxEYSbDs0IxSEZ99YdKs0zup3yk+Sq+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782062868; c=relaxed/simple;
	bh=DqJDGOiRZ6lYbOT3dtZFQrpZtmaFBoIoE/dtOaRrJrc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=byNnFGhFoBNQeJZqP/bMaxHIAdSLSrdImot+0Fi9PqF4QvLZYn9D72aPfYUw3PUbznz/B+XaIxXZEUgIcOgr2ObSzB+j5PBUcr1K2TkB9KWQkeCUazxh1SMOy4AGeJH0M3cf15+eksbg5NB//TGD1RW4YXXEFkBb9TyUEPaT+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDn3qn1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDn3qn1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264BE1F000E9;
	Sun, 21 Jun 2026 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782062867;
	bh=6i1+MqxGci79aEmBnt/1aIA3OnuHFfcQ/t316heJvkk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EDn3qn1yiJOeZy3Fj9VQ/Tve1yaReHghVs+nwSIVyPjRIfUjqNHVUDM8V7efNO06k
	 s0l1CMRH5BW+AN/malO2v55MV+JHBlRoYRW6Hq0doXzzz0C2uoXzD8JWPA2m/sLj5y
	 u6W0R/GkE0EoRbae4azgsFYffK8tJ5BU6YUhGG0SYyCKa/VYzDTe4pFeZSm1NbyQzH
	 VGE9GHlCx+oVwaduNvkhOl3X+pObT0YZ9yYjDq2bYYdIUKiD+2Big9BvLzfqFqMzyp
	 m7NTFSj0nV6m/btYNzDQ0zcYp0gyFmywRgsM5fDL3lQKmYnhe1fdVvd0gZ+i3uic3D
	 sOtXKYkL6CKtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FF3AAA6E4;
	Sun, 21 Jun 2026 17:27:39 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajYuTOzdrCbV8NM3@antec>
References: <ajYuTOzdrCbV8NM3@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajYuTOzdrCbV8NM3@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: aca063c9024522e4e5b9a9d1927433f6a01785a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e762b53a86d7ed19016c66cc1883e4b9f8b2c1b
Message-Id: <178206285855.447873.18262168997631294097.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jun 2026 17:27:38 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jun 2026 07:08:12 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e762b53a86d7ed19016c66cc1883e4b9f8b2c1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
