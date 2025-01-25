Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F7800;
	Sat, 25 Jan 2025 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737830074; cv=none; b=sBnkO4McYnRRnn0a1TDr00+Ey1s5cRxO5JD77QkNpu+Ly8oRHrfYozO8ZZlBwfTvtQdlAbLlpyeEyCZpqE47o2Yu8q46MP5GKT2mSoKjm7QAeS60861n5X6TOF33WcXZuaMYTNIfbNG6T1wmt75F8oVXVRLGTcU1PHs+41n9uds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737830074; c=relaxed/simple;
	bh=IKI5RySQQLMbAlOV+I2NtbVwBCfMpzW16YGxaabCG+k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xv6ilrXI+hwKqPL/rn8zg+R6KnN0K63fJryUnXHoAG2N0yHKwFBBgwbW0gCbmIbCTsbny8T0I/6uqIi0LCo+roqZDQSrxuMuIZDHtjRr6rLQ+02EEdn+30y7mOcSIDtVIzw38dh/sJQRS64x0TXnpdxH9YzNWU2Ngy4jE233qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKar3Bzb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKar3Bzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C20AC4CED6;
	Sat, 25 Jan 2025 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737830074;
	bh=IKI5RySQQLMbAlOV+I2NtbVwBCfMpzW16YGxaabCG+k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bKar3BzbL5reybmOCOm0dRDLkvrIt7OMbMRdbEYojMFz6yHgN+xl+YloEqCNs6f8f
	 WPQ9kH85+Oz3uXtCkLqED/6YhNRbJBFDI/tKlwj5qLgxD9X0I4mEd81L+P84veiOJ0
	 uMT3bzjO/12CsnOIYqvGNs6655u4Qk2pT3vvJ+GCAdR5tl6F7qAFuGrWnimBRbjLwx
	 qvLEeKqPKg6UldIokOKWZLQMn+6V30fqHhQKGq9tDwPWPqid0MTAJFjfOOk4DnQt/9
	 9NZ+vMPXe+CTz7RWwlhh1Qw8SF00GH//EzEnKdBwGf8XGOLzDkNxNsrz2jGNIm5Zts
	 /PR31UJm+LwlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E7D380AA79;
	Sat, 25 Jan 2025 18:35:00 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z5SE0Ybg7afKcihs@antec>
References: <Z5SE0Ybg7afKcihs@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z5SE0Ybg7afKcihs@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd56e5104a37f96e1b1ca42b4fd64fd49257fdce
Message-Id: <173783009912.2584418.11258890460521643991.pr-tracker-bot@kernel.org>
Date: Sat, 25 Jan 2025 18:34:59 +0000
To: Stafford Horne <shorne@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux OpenRISC <linux-openrisc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 Jan 2025 06:29:37 +0000:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd56e5104a37f96e1b1ca42b4fd64fd49257fdce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
