Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72D35950;
	Thu, 25 Sep 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820719; cv=none; b=uUrU1LywIjsMY77fP2DxfMOEKc648SNULVvwby3nUfqcYEu483sN8UgzNiVbbgDhw/qRRWKVPiH4r5scanbqWOPBeMCw1PvN4aIiy1S8+cxklX0mKvR+Z896FuHRBXN6mde2nqAeBmVj0ZYEgeht4YM8+D0CA6P9VI+5WPOryTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820719; c=relaxed/simple;
	bh=jYaGC2W307AcjKp10yv8xV/E7xq8yq9f5BboueFwMME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pOdEx8PxKbHk4KYM//BfNcwxsV9bpdCf7d+G9D1yEmIWxo8JFgoowi8Mb/SZPtFe8QKXTGR4lw48faBe1Bo43Wa4d0umO1p7fFVmGCqcdZsvGHwfHY+Ebf6/p+4DyTDKka1i8tcuh6ZMv4ow+LphGQtuHsctBawTh2CRB/JS/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R0Wn+1ob; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R0Wn+1ob"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A312E406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758820716; bh=s5E6NQtQfTfIKPQQ0U9jD4/CMTy4US3OKTTLePkEQTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R0Wn+1obn8KJeQvchJRf2wnbf497DYVq2eKLFn6QktuoOjJ3ybxEAFLi03ACkYszP
	 aV/OjxtFF+hU4Tsh169FcOQDax4qxVQ9VTRQ5PJJSjch78kboyCe+GLpFs9u3faXwK
	 sLzdeUNWhiACyJ/ZAjFBZLz6tdfkBQ6C8B7WndqpWsfVcZvxEwMZH1A4qhyV9lZo3Q
	 b2wTCYQQXw6BYIqMZBrOclNa/e8um3UEGq8N8lfZ1blNtXGR699/rVD18qJIcDrCWL
	 7pPTqB2KjqyLNniqzC3PcY5nELWvyV6nwZIgjgws1HbGWRaL1WoJz8JVj6dHvLD/SZ
	 AqCkRcme8WerA==
Received: from localhost (mi-18-37-83.service.infuturo.it [151.18.37.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A312E406FA;
	Thu, 25 Sep 2025 17:18:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lbulwahn@redhat.com>, linux-doc@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
 linux-openrisc@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] Documentation/features: Update feature lists for 6.17-rc7
In-Reply-To: <20250925073634.112142-1-lukas.bulwahn@redhat.com>
References: <20250925073634.112142-1-lukas.bulwahn@redhat.com>
Date: Thu, 25 Sep 2025 11:18:31 -0600
Message-ID: <87qzvu30yg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lbulwahn@redhat.com> writes:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> It seems that ./Documentation/features/scripts/features-refresh.sh was most
> recently used in December 2022, with the latest kernel release v6.1-rc7 at
> that time (see commit 7f2e60ff51ca ("Documentation/features: Update feature
> lists for 6.1") to update the feature lists in this subdirectory. All
> further changes to Documentation/features/ since then have probably been
> done manually, without checking for changes in other architectures and
> features, that missed to update this part of the documentation.
>
> Running ./Documentation/features/scripts/features-refresh.sh now showed
> seven changes of supported features in various architectures (one in arc,
> two in parisc, one in riscv, one in openrisc, and two in um), which were
> not reflected yet in the current documentation.
>
> To confirm the sanity of this script's suggested changes, I checked if the
> commit messages confirm that the features have in fact been added in the
> following commits:
>
>   - commit f122668ddcce ("ARC: Add eBPF JIT support")
>   - commit 4800a6215e33 ("parisc: Wire up eBPF JIT compiler")
>   - commit a869b8c29f86 ("riscv: enable mseal sysmap for RV64")
>   - commit 2f681ba4b352 ("um: move thread info into task")
>   - commit 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
>   - commit 7ce8716e2769 ("openrisc: Add HAVE_REGS_AND_STACK_ACCESS_API support")
>   - commit b5ff52be8913 ("parisc: Convert to generic clockevents")
>
> So, update all documents to the current state with features-refresh.sh.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  Documentation/features/core/eBPF-JIT/arch-support.txt         | 4 ++--
>  .../features/core/mseal_sys_mappings/arch-support.txt         | 2 +-
>  .../features/core/thread-info-in-task/arch-support.txt        | 2 +-
>  Documentation/features/core/tracehook/arch-support.txt        | 2 +-
>  Documentation/features/perf/kprobes-event/arch-support.txt    | 2 +-
>  Documentation/features/time/clockevents/arch-support.txt      | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

OK, I went ahead and applied this one, thanks.

jon
