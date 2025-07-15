Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE09460
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Jul 2025 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557788; cv=none; b=aMbbG6RF5oONmFcwZSWWpkqpqDbGIZnvlezFbJ2uZnBp7omXjecXQC5cRyjT6lguSmaDJnyMcsKs3hJ/y+m1Xv347FrWZywoFt1YJmNF7xOetoWhF02oybkydjii5QHyG4Eehqf19V1Hp3cd7KqWgrKgyN+h4luNGmNwX4QzysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557788; c=relaxed/simple;
	bh=7nF8ibOLBAh9590vwEYysMFOsuVXEC/+jWkJyBTKf6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cy2zVIBfo5060TV05FD0tgYKCo67zkjTGjxK0yUSaE4JNXPAJKuDgMHacn5Ys17sdCC4CqCmzm+OPBjxl4DO6EY+wfM8MIrSzZarK7NPkoknRQCVVxoMECXNK5ytDmZEAXDArJoTzdyHaFGOnzk/2K2Bq5m0kKW9eC61j3YGizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWGCMaRd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWGCMaRd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2995297b3a.2
        for <linux-openrisc@vger.kernel.org>; Mon, 14 Jul 2025 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752557786; x=1753162586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DbIPwgiaN8RSw0u6rZ126HDe4AOuH4ji1a0wkqZoEEo=;
        b=FWGCMaRd3cMdmZeYJ+y/E3Z89mCQcABPFRBbAp0KU1OVm4ulypcj9XaeF7TfweJnJG
         zWXuFpixzCAdB8KOMS4jK4aK4TCUdlqN5fPKBZk9Lx+1ww2lzgvqyciWuzT6zLOR/O2X
         3X4jIKhj6otNFMdLDsV7bDiqhiKpHx7GEQXR17oR1KaXiFS/yItpZ20k48UeQTn3yS1u
         ZTpRlhIwELJA+ctPqY4xGl/ahtlagS/a8BK1bQ8dJBHBDlGqi88xavPu3DGmYEmAxR2m
         Zgbs2xxO4klQz3Wb+dYy9zxGxZ7+dtgeicUnxi4TP7buRZKQ9slS8SMlUvoHU8g6R1rt
         ITeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752557786; x=1753162586;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbIPwgiaN8RSw0u6rZ126HDe4AOuH4ji1a0wkqZoEEo=;
        b=kx11YBZ9y3vpdLSI7xNG+DfagzA1g5vGMcm2izbj6ILvFbX8cgDH4kIh9KTK3l4fri
         yv+7sdRoBY+jD3/m9PKNnQCKnMRfYp+kOGjcMaOXKyqb8I+INhGfqK7JbTjiIT5sEajV
         okHRW72Tjft3gILzZhVePlOdj0aPtLmypTt4IMn+oVxxHV5q/9DOPFCBVthef+jyuhVR
         7e9uFhL2L2270VbrWPP8ooF3KTqPxRvFrtL+mLGWQsZP4rS3rA1I3VcaIkc+yYRxrgvR
         WurQS4GjEhueQg6KW8jmvnqJk+YNm1LPgdBKpnlSc19nu3tydH0zgxsmA//XwR0AVjB/
         zolg==
X-Forwarded-Encrypted: i=1; AJvYcCWwMu2SjFVBBWZoOwk/FqGtQXCKmrhyIlzsVMM53NA8lcVzDLyRu5RifynTSF+USZgmmpbaNhxwlcXEXeXCZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4naBbOU/5DrFY9zrD4uVa5+oeom3+4uXBaeCtnrac4+OGiD+t
	62nZID+Ij7l/gkkrR9yR8m7ba0jtIatn2y40EX/1W8KFfH5UR17QzyVqx3IVcQ==
X-Gm-Gg: ASbGnctgx81TfPIttkgupF9NQr7ZG/OiLPVVTYa+jzvqA0hJ5v0FBYcBM7v0dCUW+i0
	VywFcCj7ZpAx21MqgWrGY3XKtsByRWQyhGByGyl1I+DdrMQnzb19PsMKSXwsQVU77yxQlUitj01
	fDibIEuxfRyMu+3uthZEUjtlgqHnhyfSazjAiBLSM6SL54QgYYweKZjWv4IW2opfs6Rdxd1G7yP
	YJN+yEtHUTYhaSLwuPe9bybez/d4Pzxt/XXv4MeB6wmH3PadrSP56Ey46DJzz+luHQ+5isFYMoy
	26cXqfMZRIC9hwYucHY+t6vwSJ/hNFZMX7rq3Uucg6ECdJrE+BfRPLkc0NAstaVMxAPLHkUumnv
	PKFpJJxbBkyA+fBR080HMUjSd7YlU8l4oAUzNBlW+HQ68i9u09jNDb47dbNE9s52lhw==
X-Google-Smtp-Source: AGHT+IHDH1Gwv7aotCj8ypH/ii7/wmBRwQWG5zeqtF8gkNhx6e1kGXUjXyEamBB2OhQgejF8X6gNMA==
X-Received: by 2002:a05:6a00:124a:b0:74e:a560:dd23 with SMTP id d2e1a72fcca58-74ee2d4cd93mr22036159b3a.21.1752557786152;
        Mon, 14 Jul 2025 22:36:26 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:cc7f:1c0d:8ac2:3401:3f0f? ([2401:4900:1c44:cc7f:1c0d:8ac2:3401:3f0f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd6c46sm11395474b3a.13.2025.07.14.22.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 22:36:25 -0700 (PDT)
Message-ID: <713c652a-895d-43da-98ad-5ef35f4557f0@gmail.com>
Date: Tue, 15 Jul 2025 11:06:23 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Questions] Inquiry about OpenRISC Multi-Core Support Status
To: Gary Lau <zgliu@foxmail.com>,
 linux-openrisc <linux-openrisc@vger.kernel.org>
References: <tencent_C8553A547F769459B4D614D938C0E6111C09@qq.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <tencent_C8553A547F769459B4D614D938C0E6111C09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gary,

I'll try to answer as many queries as best as I can, and leave the rest to be
answered by more knowledgeable members in the community.

On 7/15/25 9:30 AM, Gary Lau wrote:
> Dear OpenRISC developers and community,
> 
> I’m reaching out to inquire about the current status of multi-core support in OpenRISC. Could you please share some details on:
> 1. What is the maximum number of OpenRISC cores currently supported in the Linux kernel?

I see that there's an option to set anywhere between 2 and 32 (both inclusive)
CPUs in the config, with 2 being the default. [1]

> 2. Which specific or1k core implementation(s) are being used for multi-core support (e.g., mor1kx, marocchino etc.)?

According to their READMEs, mor1kx [2] and marocchino [3] both have options
for SMP. Note that marocchino is a rewrite of mor1kx Cappuccino. Cappuccino
is 1 of 3 pipeline implementations in mor1kx. You can read about them further
here [4].

Maybe someone can expand on this answer.

> 3. How many cores have been successfully tested and validated, either in real hardware or simulation environments?
> 4. Which simulators (e.g., QEMU, or1ksim, etc.) support multi-core OpenRISC emulation, and what are their limitations?

I don't think or1ksim supports it based on the documentation [5]. I think
it's best if someone confirms this.

However, I see QEMU has support for SMP. [6][7][8]

Again, I am not sure what its limitations are.

> 5. What are the recommended versions of Linux kernel and GCC toolchain for multi-core OpenRISC development?
> 6. Are there any available documentation or reference materials regarding OpenRISC SMP/multi-core implementation?

Section 10 of the architecture manual might be what you are looking for. [9]

> 7. Are there any particular considerations or limitations I should be aware of when working with multi-core OpenRISC systems?
> 
> Any insights, experiences, or pointers to relevant resources would be greatly appreciated. Thank you for your time and contributions to the OpenRISC ecosystem.
> 
> Best regards,
> Gary

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/arch/openrisc/Kconfig#L182
[2] https://github.com/openrisc/mor1kx
[3] https://github.com/openrisc/or1k_marocchino
[4] https://github.com/openrisc/mor1kx/blob/master/doc/mor1kx.asciidoc (CPU Pipeline Implementations)
[5] https://github.com/openrisc/or1ksim/blob/or1k-master/doc/or1ksim.texi#L1780
[6] https://wiki.qemu.org/Documentation/Platforms/OpenRISC (Last updated in 2022)
[7] https://gitlab.com/qemu-project/qemu/-/blob/master/docs/system/openrisc/virt.rst
[8] https://gitlab.com/qemu-project/qemu/-/blob/master/docs/system/openrisc/or1k-sim.rst
[9] https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
