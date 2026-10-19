Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026533E347;
	Mon, 19 Oct 2026 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420485; cv=none; b=XRM5Ol82Wljyk6pryU05WwhLSEqJqTJ638n2AtuKGjk2V5v903T2g0/wdLjxwmwa1wKp0pINr3lykEn3kNYXzDMXAzEPTCCMRj3xVdkk06wd22I7IaHc8I42IX7QM9/Fn+dZgdO6a4ycXub+iN89JYRPsyqDKqsGAs+4FM9RKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420485; c=relaxed/simple;
	bh=rc+zKALt4qnaEwGbLyIzDV3lrQqxqfpBYgKghcRGmR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjlDgwXs9Tjn+HUSVNVsDS8wymSV8iqO3Ks+2d451QItZvxQiYavxAexkAz8f0M585ip5sPJuRSMlZYW+m8aNITXm1ErTRjLWZXFupc0KW+m/6fKQ5uApaFha3UFcwNLij6xJktv1VW/q9/XnE+vDnTb7PM9WvHOUXWbunSZSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0dOdEVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0dOdEVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715E11F000C4;
	Mon, 19 Oct 2026 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420484;
	bh=mOXe4LQGts3ArD2pw3xFg+XnFDQf4F0VIInax9HK9h4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P0dOdEVKyjVx5vtpkFSVJWNshcCTE0EM/gbdejGiGHRqXaYTe3X1uN3UJr+BKMX48
	 2eHu5giELY/4A14GKat0gGAE3R0C6jbo2LdCFj9ZvXnv0SC8txuPAIgAO0mIz5hvt0
	 oOwmDK3ZwdVOEXoc/1Rn+bAsYQuYHCu2HvILVZiy1yG2ohZpR5NoKcBfmRubVRR+UR
	 eIeg+TLJuVavVoZB7b59YeW2YNv5UPtWVJXf2fPp8nfRw58lAIk8qV57Vik5SqluEv
	 NunTcMsjvbCfebyTOSLRGcKIqtIPNV1rbP9SqPrP2MMkL6r51PLf566pq/Pq2epv8v
	 WLmgqxdhHSmhQ==
Message-ID: <c32b7ed2-fa3f-4a58-9300-21efcc88f056@kernel.org>
Date: Mon, 19 Oct 2026 09:34:42 -0500
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nios2: ksyms: Declare __mulsi3 export
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 Ley Foon Tan <lftan@altera.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
References: <20261019-nios2-mulsi3-v1-1-4fd75b1bacef@linutronix.de>
 <47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/19/26 06:16, Arnd Bergmann wrote:
> On Mon, Oct 19, 2026, at 11:49, Thomas Weißschuh wrote:
>> GCC may emit libcalls to __mulsi3(). As modpost is not aware that this
>> function is provided through the linked in libgcc, it fails:
>>
>> ERROR: modpost: kernel/locking/test-ww_mutex.ko: symbol '__mulsi3' undefined!
>> ERROR: modpost: kernel/time/test_udelay.ko: symbol '__mulsi3' undefined!
>> ERROR: modpost: kernel/resource_kunit.ko: symbol '__mulsi3' undefined!
>> ERROR: modpost: fs/fuse/virtiofs.ko: symbol '__mulsi3' undefined!
>> etc.
>>
>> Make sure modpost can see the symbol from libgcc.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202610171933.J4bFOfL8-lkp@intel.com/
>> Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> The patch looks correct to me, but it would also be nice to not use
> libgcc at all. What I see is that only arc, nios2, openrisc and
> parisc still link against the toolchain-provided libgcc, everything
> else uses the kernel's own runtime.
> 
> It's probably not even that hard to do right, here is what I found
> is imported from libgcc.
> 
Patch applied!

Thanks for the suggestion Arnd, I'll work to on the NIOS2.

Dinh
