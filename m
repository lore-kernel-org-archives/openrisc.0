Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7A361DA0;
	Fri, 16 Jan 2026 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564939; cv=none; b=KS3EFG47VCb8d3jcNE85z5hO1jjIP8gNAzlF8dSWgng0M0LU6xjTGDeHP1uAFCtFD+bzmE7/3Eqp3w3R6D+vh8Entkpl2Yux4vY2Jg/2/Hg/r49ZT5DO56qQH34viZE6ncZNWB08IkH4UafPfwl/XXZ/JHo+Q0J0Pu3iiJHQY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564939; c=relaxed/simple;
	bh=fnGV1jCqMjmGOp/XsK0A9qzcRTKs0fx1lqIUROAj7Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=up+/Bw7IgaJEQC1bWrFTQ7/Ja0A08wE222U/FZJOchX00ebQJGwVBLyVcPo9q1oqhDpxPitoGkNGoeiL3gMJf5XO3EjqdVtAVqNy6C+xYzORNeCdcFIRSX2TNLMPpLlxT9ljVh6sgLyLbr904qUzjSwKEMtfG5eQ7T84ZnDo/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF0vU295; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF0vU295"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF9CC116C6;
	Fri, 16 Jan 2026 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768564938;
	bh=fnGV1jCqMjmGOp/XsK0A9qzcRTKs0fx1lqIUROAj7Ic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oF0vU295FLg6/nc0XqjxtkAwnbHSdwxq4ItNN0/33CFg7OSd30Aci8fBxuUQBr1Aw
	 UHgfPlEjkze3pvwKc07nigknEpEFEryUtl0aNXGr4aYA/GQNjnyuGGuCYYSwkJKUf0
	 i3D6Ash2ssv1Wk3vo9HlhQWPqWcdVQh5moddY1dQaY57Hkwugg9Dr7qy888fQ9KThR
	 rw9K3nhqXtd0SWS/jeMq1gSIGbETKuT0DWYEI1ln7OO2hjnLkMrYtcLMIPsD/ANOk0
	 6BEc3YEc+c3+COA/jDJBXERRlO4qu35y7ZfoSbGMClBPfnxajP3Yl/CEnvxVvfxlzb
	 gzkCqQgi+5J/A==
Message-ID: <56e0c7bf-8f51-47b4-9ec7-edcf1b815c06@kernel.org>
Date: Fri, 16 Jan 2026 13:02:15 +0100
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v6 0/6] OpenRISC de0 nano single and multicore
 boards
To: Stafford Horne <shorne@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20260115151014.3956805-1-shorne@gmail.com>
 <176849165027.29734.708711779514578942.b4-ty@oss.qualcomm.com>
 <aWonvu4xgqIGBGmI@antec>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aWonvu4xgqIGBGmI@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2026 12:57, Stafford Horne wrote:
> On Thu, Jan 15, 2026 at 04:40:53PM +0100, Bartosz Golaszewski wrote:
>>
>> On Thu, 15 Jan 2026 15:09:56 +0000, Stafford Horne wrote:
>>> Since v5:
>>>  - Adjust dt-binding patch based on suggestions from Geert and Krzysztof.
>>>  - Add reviewed-by's on the dt-binding patch.
>>> Since v4:
>>>  - Rebased the series on linux-next to allow patches to be incremental.
>>>  - Rewrote the dt-bindings patch as an incremental patch, Due to this I
>>>    dropped reviewed-by's.
>>>  - Added acked-by to the IPI fix patch.
>>> Since v3:
>>>  - Switch order of gpio-mmio driver and bindings patches to patch binding
>>>    first before driver.  Suggested by Krzysztof.
>>>  - Removed example form binding suggested by Krzysztof.
>>>  - Added Reviewed-by's from Geert and Linus W.
>>> Since v2:
>>>  - Fixup (replace) gpio-mmio patch to update driver compatible list and just add
>>>    opencores,gpio to mmio-gpio bindings.  Discussed with Geert and Linus W
>>>    because the 8-bit opencores,gpio is not the same as the 32-bit broadcom
>>>    chip. [1].
>>>  - Update new device trees to use proper ordering, remove debug options, remove
>>>    unneeded "status" properties.  Suggested by Geert.
>>> Since v1:
>>>  - Use proper schema in gpio-mmio suggsted by Conor Dooley
>>>  - Remove 0 clock-frequency definitions in dtsi file
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
>>       commit: b2b8d247ad8ee1abe860598cae70e2dbe8a09128
>> [2/6] gpio: mmio: Add compatible for opencores GPIO
>>       commit: 3a6a36a3fc4e18e202eaf6c258553b5a17b91677
> 
> Thanks, now that these commits are on gpio-next I would like to apply the rest
> of the patches to my openrisc/for-next branch.  Since the other patches depend
> on the GPIO patches for system functionality, do you think it would be safe for
> me to merge the gpio-next branch into my branch?

They do not depend, unless I missed something. DTS cannot depend on
drivers because it is an independent (huh, so circular logic) hardware
description. It's also more explained in maintainer-soc-profile and DT
submitting patches document.

There is no single dependency here and you should never pull gpio-next
or any other subsystem driver into your DTS branches.

> 
> It seems a bit messy, Maybe I should just wait for the next cycle.  But if you

There is no mess, you do not have to wait for anything. Please follow
standard rules like we follow for all other SoC-based architectures
(arm, arm64, riscv).

What happens when you apply *independently* DTS? What is broken, which
was not broken so far? What features stop working? What existing DTS is
affected? What existing code is doing worse than before?

> have any suggestions of experience with this any comments would be appreciated.
> 
> -Stafford


Best regards,
Krzysztof
