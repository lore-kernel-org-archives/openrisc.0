Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35EA1FD796;
	Wed, 11 Dec 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956352; cv=none; b=Hz32tOc8GwBopyogb7OQ/RYh0GUU73JXFCCtlHCydJkTvZ4PakR2XdmFTo8cBhW5PEADsXoovoNNJkVVd3r4t4yVL5LlT6wUWNcWW54sYcLZJ9FmrLdHOh75U0+taNircwv8p6no520KVLnoKlh60I5jJU0WhgGH+dapsVHwFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956352; c=relaxed/simple;
	bh=k0MtyxDbbtsm27qvkqsKV+jrSIBDfJRGa0WHRKH9KWs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UedqFT0o9CbqXJFusAfmMgrYbvTfH4ltrIQTP1boj8QDvEZs1BIfEkZnQErKZQmLTx256mrlK7W4NxUrpZb2bHj96uROuMEGTx7RZFhHzmp6JpPtZF2VrIV8ImM9s0PWm2/nv4iNG0stqiPOh6RdOoCIbIZJWEfpNTSYyTS7o+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPOtlX5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPOtlX5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31DDC4CED3;
	Wed, 11 Dec 2024 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956351;
	bh=k0MtyxDbbtsm27qvkqsKV+jrSIBDfJRGa0WHRKH9KWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPOtlX5TKBph2olV5g0D84w7BiGXyaTzX/kmSl/KB3xl8BPQoIcxG64kiVppaKWV6
	 UuVYIQk2nmWnJhIowxxs3i7Ezo4bFvlmC27nFpPkM/jb80vyzHBEMsDiWlhHJUBmrV
	 E4nuPLnavEZNBvgxCnxSG/erFAKypXE58/ddSXOGTSgdiPaf+RxWJKbmenqt6qmjdG
	 RpQEsDlCvg4cySX8p8aQt/+bGgUkkoqZuHIfhgpxn+qXexNXcqJewICJNI3vp9PVla
	 22tDI2SHe01OOAbfoiss8OadArWzPpX9wRC6bdennXUaIn34M8kF/jHgNGbizmzpuY
	 lZsn8ISnWGPaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEED380A965;
	Wed, 11 Dec 2024 22:32:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] of/fdt: add dt_phys arg to early_init_dt_scan and
 early_init_dt_verify
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395636750.1729195.6853192666319119853.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:47 +0000
References: <20241023171426.452688-1-usamaarif642@gmail.com>
In-Reply-To: <20241023171426.452688-1-usamaarif642@gmail.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, mark.rutland@arm.com,
 will@kernel.org, leitao@debian.org, catalin.marinas@arm.com,
 tglx@linutronix.de, chris@zankel.net, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 loongarch@lists.linux.dev, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-openrisc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-csky@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Rob Herring (Arm) <robh@kernel.org>:

On Wed, 23 Oct 2024 18:14:26 +0100 you wrote:
> __pa() is only intended to be used for linear map addresses and using
> it for initial_boot_params which is in fixmap for arm64 will give an
> incorrect value. Hence save the physical address when it is known at
> boot time when calling early_init_dt_scan for arm64 and use it at kexec
> time instead of converting the virtual address using __pa().
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> 
> [...]

Here is the summary with links:
  - [v2] of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify
    https://git.kernel.org/riscv/c/b2473a359763

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


