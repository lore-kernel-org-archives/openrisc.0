Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4435028D;
	Tue, 13 Jan 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324919; cv=none; b=A0QHVmfQkMpuvpR1VlJtBoWfn5q2IVBVM++cwyfRJUznI2AAPxnUcCn7KEMHmJWupXcaSZBwr4iPx51zHGkHCG7en1stjV9x/GjR2g8fo8HifhLj7o0nP9Ue8GhuEB6o3WJSwDSvFds1qm32vd+sIoKK7PPV2UzGmUE8ghD/F8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324919; c=relaxed/simple;
	bh=DmdxVNADDSkeNMAizGMypkPsSI6HPYbYejnjeZHryHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWaYEjR6vDFj+/Ssz7riy71OY3BN0f6sAn4ZH78jCBKIC1x9MwR8RJ07EtgB58JzIEZYhlGViSg18oFTJ76ydQ8Y6r3Mf4C2pyN2txfyljUzRucoMlGTXtwGeJuw4C8mwUFwNkHAB4KNYK4HoDX1uKbewmNPeQqBApoDTuvWoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+MS80qH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+MS80qH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDB6C116C6;
	Tue, 13 Jan 2026 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768324918;
	bh=DmdxVNADDSkeNMAizGMypkPsSI6HPYbYejnjeZHryHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W+MS80qHLW0VHLsxCa0/gp40GFMcd0SQr/LIc1MRfwBkPFqrK2rtiTIjqGaFB37R9
	 urg+Ai959hw/XSgffwSs+Hhiz9x/SrqlFFrfj7bbQPi+RGxOJBRf2eI6Ngwai5wivo
	 VskgfuizXS4lrs05Uo2CjIGgk2FKpwXtcdHGIbWPO3yEIj+TQQwQZpXneYX0K9R6YL
	 67IoqTcIvCGqVPRWA2LX+FfnYa26/C6f5JlGD0+P+wm/eEwhe/hIB0O2cIwIOE8ijv
	 ghCYDX/e/gdzN3V/mldeacMmCfj0e+3A0KUCTTbefGb5MIM3LOIAJUAsfG1qLklmbe
	 V08HDoWRYGGYA==
From: Thomas Gleixner <tglx@kernel.org>
To: Stafford Horne <shorne@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>, devicetree
 <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>, Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH v4 4/6] openrisc: Fix IPIs on simple multicore systems
In-Reply-To: <20260113161152.3688309-5-shorne@gmail.com>
References: <20260113161152.3688309-1-shorne@gmail.com>
 <20260113161152.3688309-5-shorne@gmail.com>
Date: Tue, 13 Jan 2026 18:21:55 +0100
Message-ID: <873449jumk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13 2026 at 16:11, Stafford Horne wrote:
> Commit c05671846451 ("openrisc: sleep instead of spin on secondary
> wait") fixed OpenRISC SMP Linux for QEMU. However, stability was never
> achieved on FPGA development boards.  This is because the above patch
> has a step to unmask IPIs on non-boot cpu's but on hardware without
> power management, IPIs remain masked.
>
> This meant that IPI's were never actually working on the simple SMP
> systems we run on development boards.  The systems booted but stability
> was very suspect.
>
> Add the ability to unmask IPI's on the non-boot cores.  This is done by
> making the OMPIC IRQs proper percpu IRQs.  We can then use the
> enabled_percpu_irq() to unmask IRQ on the non-boot cpus.
>
> Update the or1k PIC driver to use a flow handler that can switch between
> percpu and the configured level or edge flow handlers at runtime.
> This mechanism is inspired by that done in the J-Core AIC driver.
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Acked-by: Thomas Gleixner <tglx@kernel.org>
