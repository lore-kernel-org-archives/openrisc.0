Received: from simark.ca (simark.ca [158.69.221.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916071A8F6D
	for <linux-openrisc@vger.kernel.org>; Mon,  9 Jun 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.221.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495945; cv=none; b=CGOwKDqoexDuTibtdh+0T/IbURO90mB768p8fI8YH6KZmi8HeZuAkkOTFHWdC08iFs8HPGGq1kfsk65VHbRSQy9pi5gi9B4ovm+Rmz9nwYvWJgMMlkq59azBA8n8heDVqfti37GqvtdWQIIOKnzEtKoM/glFI7pu5jSWIjhpHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495945; c=relaxed/simple;
	bh=QcqS0SM2SK3TYkfBZPNLYSFJrx6dKwgj7nMK1M9XNlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFEz46XkiVq2L1ImWrtUZRxIFJkmHjny2jEbwFHSe43rF2a3gXOMIjH6iIHrlxoWlH2nd8LZ6dvM1khqoJLWNrBHqA8Ru698LIoSU8rfpgmag4kzIOUwlbuRhNUry7tBhocr5thV2Gy0uDJlWFDFkcpbVM2hBkcM9GhbMXyl+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simark.ca; spf=pass smtp.mailfrom=simark.ca; dkim=pass (1024-bit key) header.d=simark.ca header.i=@simark.ca header.b=MEgV4jrH; dkim=pass (1024-bit key) header.d=simark.ca header.i=@simark.ca header.b=c3jLzD9K; arc=none smtp.client-ip=158.69.221.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simark.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simark.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simark.ca header.i=@simark.ca header.b="MEgV4jrH";
	dkim=pass (1024-bit key) header.d=simark.ca header.i=@simark.ca header.b="c3jLzD9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simark.ca; s=mail;
	t=1749495468; bh=QcqS0SM2SK3TYkfBZPNLYSFJrx6dKwgj7nMK1M9XNlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MEgV4jrH+qfqG+DDZqJc4pR8yLI6i6KycQjrJYB0YtAMmIeO3ldhkOLLqwA/q0p7I
	 LD458e4kLihMrvEUAaTuc2Y7/Fe8ObAKfAqxG1/5dpdoNqkStX63McjvkBxX5NMtcc
	 6/mjCAquSZvEQg5kPq36BVZrqbfUubDn5aR4Z4Yw=
Received: by simark.ca (Postfix, from userid 112)
	id 5509B1E11E; Mon,  9 Jun 2025 14:57:48 -0400 (EDT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simark.ca; s=mail;
	t=1749495467; bh=QcqS0SM2SK3TYkfBZPNLYSFJrx6dKwgj7nMK1M9XNlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c3jLzD9KqUn0oshjveAXjbNvN37iMP2siM+jdrBDmBH5GHJkD1IQ5DezS16yzppt4
	 W+gYAF+/8Z9nJ/T9ytsQqvvnEGlyVv9sLFAjZTpSbhDXjFI6xfda+owSWPbU9z1nhN
	 TbBM1fQSoNAeJIO7+ZKUiFystCgmpb+9dyH+4MjA=
Received: from [172.16.0.192] (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by simark.ca (Postfix) with ESMTPSA id F2A231E0C2;
	Mon,  9 Jun 2025 14:57:46 -0400 (EDT)
Message-ID: <ed2035f9-d5ea-4090-9d43-d6be9d40f901@simark.ca>
Date: Mon, 9 Jun 2025 14:57:46 -0400
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] or1k: Fix ICE in libgcc caused by recent validate_subreg
 changes
To: Stafford Horne <shorne@gmail.com>,
 GDB patches <gdb-patches@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20250609185222.1538148-1-shorne@gmail.com>
Content-Language: fr
From: Simon Marchi <simark@simark.ca>
In-Reply-To: <20250609185222.1538148-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/25 2:52 PM, Stafford Horne wrote:
> After commit eb2ea476db2 ("emit-rtl: Allow extra checks for
> paradoxical subregs [PR119966]") paradoxical subregs or the OpenRISC
> condition flag register (reg:BI sr_f) are no longer allowed.
> 
> This causes and ICE in the ce1 pass which tries to get the or1k flag
> register into an SI register, which is no longer possible.
> 
> Adjust or1k_can_change_mode_class to allow changing the or1k flag reg to
> SI mode which in turn allows paradoxical subregs to bre generated again.
> 
> gcc/ChangeLog:
> 
> 	PR or1k/120587
> 	* config/or1k/or1k.cc (or1k_can_change_mode_class): Allow
> 	changing flags mode from BI to SI to allow for paradoxical
> 	subregs.

Wrong mailing list I think (gcc, not gdb).

Simon
