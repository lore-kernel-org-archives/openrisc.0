Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221671A314F
	for <linux-openrisc@vger.kernel.org>; Tue,  9 Sep 2025 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391973; cv=none; b=THp9WqUgB2aXWyUCYYw3pirVGt5OCg+hzTvzLWPXZ+YFKQqEq58PGYrsGksV4Vz/LMhXoReUQI33/+S7SS9MXWNMYzeB0lHU2StoqcFlMRD7x2ENAjUvk/up8ZivF79tXRsenNoHk4pSLCfOMylIipFRA0sR0nDeKughehEJBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391973; c=relaxed/simple;
	bh=irYqXGiwx14B8l2hUSGoqBLVmm6B6V85f2KI9ipbHvI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZIXERbPdfHtz06IkEPtlevYbG6Nb0dOWQQg4bwwBIJFk3xFUbyxXLj/84EwfX7Giqs/DkPeVhHUO8+WcQnboHQGJ3WideVug2uRhUSxzSZY4y5xsApWahISngpM/IoNhmsBC2b20kkB19XpaCkbLY/lcRL8kyN9wY8SG1wm8KEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImFPFaFT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImFPFaFT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso3292907a91.0
        for <linux-openrisc@vger.kernel.org>; Mon, 08 Sep 2025 21:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757391971; x=1757996771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irYqXGiwx14B8l2hUSGoqBLVmm6B6V85f2KI9ipbHvI=;
        b=ImFPFaFTIDUFdhIzy9OCGEReOBlcN5YlrIriWTZToBzgzRFXsqg+Hm0mbFbUMXxAiq
         //0JpKEuuRYimLm9SrCjBWFR8VtaH/q8aHeHlh+aY3m/DQM8evi63pIb2b6CkDmSz5/h
         PR970/R9xQ+5OOzAz2VT5xfU1EerZcwGMmEn+ggjyC52p2IMh+tzXLepyPcOCBUN2f1s
         2XqSegxd4Mhipo7Ftf3MJwWGrSYCNQvxAIvwZmpL1N+zOTSgPBPw6MNB8Ebijf5hzXK1
         NQJ/BmnTjQTiIfbsBkMOYrsBo+OLatvQir4AnphI+BQFoAKGLKcFG60wGS6tls1WmHs2
         UvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391971; x=1757996771;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irYqXGiwx14B8l2hUSGoqBLVmm6B6V85f2KI9ipbHvI=;
        b=Oa/+dL6TVJtE142RIInS1yqSu3qsH1aw2IMCwq94cry/GQZH56Pa/m+7LFNIKDvnyA
         XE7J1mjik8TT7GJ+l8icxeIUhEqXGidL1FSDtVJ3pMW+gW5taH6gSGoHh12bmKtaI4x4
         DA25wf944AHxr486T9/EMfJybJJZAemmeuNpkrStk/AalbVDrMXsPAA4/v1afWGODAo5
         UXvcUWVOHz0qV7RxncswQ3e83gfL5wnmQLuOJNLrWnMPazvoyKMo3j5ywhhjgyIu4WZo
         9b62thheHiKe1z+VSdGdwsRAoBFBGpH7ozD3V9AT3R9O8sFrGcKXvHe5HTWAuoMdUIz+
         VqfQ==
X-Gm-Message-State: AOJu0YxOogcoEtUc217PFrbqDDOe0x7tzpZ7CH9Bpu8oBqYISSJynzAl
	GvHWZWLNvWIM1Np/yz0J516q5CvoFX/JgIwSzdeiKO0PyYIWrN26DLVo0kUj+w==
X-Gm-Gg: ASbGncuqBteTSe3KKfmbaW0YMAxWdSGbwlP5yjFvinPMXJLQVnrv1JArQkkmLjhR1Gf
	IFIyZ+SchvA1Pkg8v13gH3PbLWvuNFsBbpQjtE3IhMstyaiJDV4uLBRuclI0u76wuEyizY7GjHW
	tq7j/onVpVYDE9j5hPXnPR5xpjZnvBH1LMez4UakywD3EIUOsyb/9BmfFMEqKvbB1kyVxJlDHjD
	UEEOrc9K0hiABO/hxWgyG9uG5P3corRDl8laOylzvVk9sxom/hS3hT1Zn4sNxVf7RheiPzVBD34
	wHD2ChlQoYBof2maGnMydX2GzeXBr94d3jWg79wGJYhlSrUjveiC51w4fV1JNAFU4LH5laBa3vY
	3L0omKzf70Uft9bKOIBfon/awb28lwwK5hvtXw60fz9hsqxhVJLlNhUEO3E0breq43A==
X-Google-Smtp-Source: AGHT+IFy11YiKKYpQRIgA5fVwCIUjurJ1spaRlGRW8a9w/KBKfCe0NdS6I0FlhJtwXUKXM977Px3Tw==
X-Received: by 2002:a17:90b:1642:b0:32b:cda6:4e8f with SMTP id 98e67ed59e1d1-32d43f95cf6mr14157168a91.19.1757391971062;
        Mon, 08 Sep 2025 21:26:11 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:90c3:a5a8:9996:dbb8:9774? ([2401:4900:1c45:90c3:a5a8:9996:dbb8:9774])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e445d875sm20339105a91.11.2025.09.08.21.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 21:26:10 -0700 (PDT)
Message-ID: <56e910a3-46c7-4df1-b1cf-ebdfaf8e49dc@gmail.com>
Date: Tue, 9 Sep 2025 09:56:06 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: KProbes for OpenRISC-linux
From: Sahil Siddiq <icegambit91@gmail.com>
To: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Stafford Horne <shorne@gmail.com>
References: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>
 <aBoks-Muf4CxQvhv@antec> <278be55b-49e8-41ae-a7d4-c0eec6f1d90c@gmail.com>
 <aB5Qe9EpVSYAf60G@antec> <51b89c55-ee58-461d-a2a0-5c8dd8ba77e7@gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <51b89c55-ee58-461d-a2a0-5c8dd8ba77e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/10/25 1:48 PM, Sahil Siddiq wrote:
> Sure. Based on what I have understood from the synopsis of the GSoC proposal [1],
> the focus will initially be on jump_labels. So, I'll start going through kprobes
> in the meantime.
I am writing this email to let you know that I am still interested in implementing
KProbes for OpenRISC-Linux. My changes make use of Miao's text patching implementation.
I should be able to send a patch soon.

Thanks,
Sahil
