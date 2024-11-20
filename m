Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8261C3F0E;
	Wed, 20 Nov 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143731; cv=none; b=KWv5HnCOc2ufvPzKWX0Lv0VRiCDkaF34w3R2AUDxkJ2IRR+qZqp4Wi6k4ctvvPYS6ARa/c+H0XYmZPvedEI9PrtqAf/bPSGJVk8/39E0mGeJ+CfFUnffdJhXPWmWjq/5jrKdND6udIq64FuZwuUJyJmm8keTOLlQxT66sNziPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143731; c=relaxed/simple;
	bh=8GHbCl3t8VJMjQb+KE2H+as1WBZAPmH4COqvqRR/Keg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AcqboiCvXRGQbtLyOJu+JIThEAmsXpX0oxqYt5O9q4Fc5IWWU0t0iSJLE2srHSw7vXAGfyhfwXvG5OGDSktReb09Ctd2GDITgtcgXD+rN9aKwVozXOZRauxNLf8XPn9AOORwUaUh2Db4lOMuH5BDI2mzwqj1aFuAHIABEGRrHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJf4er7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJf4er7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F65C4CECD;
	Wed, 20 Nov 2024 23:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143730;
	bh=8GHbCl3t8VJMjQb+KE2H+as1WBZAPmH4COqvqRR/Keg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iJf4er7mA3nbcQRyWhl3CZqq5SUFqIDRqzb+Wt9+Lnkw5emYYaPYRBGjGuEqp0qss
	 MkJXfmhGBKJiU9xIid63smp0bSCKRbLZa98erbx0fBiFDzYscSfIwl8wH+8ZTkRbyX
	 Q8LJemgAhoeIEmNytYWSJxhk7eaF8eFIS9a2+AETqXgO/T+Lo/ep+BZtdRmRKrB1H9
	 IK4nEXF8CDnJAwDe1W6tC0R33LBXSEwRvNgJUKV6KFNs9nkBK0MTA48Xl4E2b1+nY2
	 N/6PMLNIulkkEsbZg6V/yYbFvwazQP6W+TMSOXuh5pcMLX+BlB95o9f+lM9nByi2fR
	 QIQ9sGIcjud9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F783809A80;
	Wed, 20 Nov 2024 23:02:23 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzzFr1e0ZUOcl_2R@antec>
References: <ZzzFr1e0ZUOcl_2R@antec>
X-PR-Tracked-List-Id: <linux-openrisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzzFr1e0ZUOcl_2R@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 1037d186edfc551fa7ba2d4336e74e7575a07a65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c66fbc6c3df9ccefbb896695cfc4db279d517ff1
Message-Id: <173214374194.1381175.17079041985327864018.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 23:02:21 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 17:06:55 +0000:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c66fbc6c3df9ccefbb896695cfc4db279d517ff1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
