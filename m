Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D481DF72E
	for <linux-openrisc@vger.kernel.org>; Sat, 10 May 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746858460; cv=none; b=caGP8KgS/FYVKsIWdJ4EG6D+SNmpirJ06gQjA83Pr0AbhrZyPVgMuspTuWED+sG+PRZTC87ANjz07Nrxk7DgryrSpmhXupPZt4+qxrib4tjUES4IhJ6+sU4YNh0kLrmOvTI8XC2GTGRxLn+kJZ1lG7smv8fYMcbZmMdsu5VoT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746858460; c=relaxed/simple;
	bh=XMhMarWC4iTfQu7CYRNiRHY0D7mG7GOGwRkPgSA2RcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWWYP2bOrvyTyr4iHQhia65sWg7gra/4bDnVnze2gwxb2BgsUmhxn9FEqyevswMjI3G4Ddjx3m1SjK29zFeOS6bsuZvUEVaeKQNIOO6PlrM8CCqE6qV35nZWrC5lKewA7cZoVxT2LEEEINMrtOfGquc9TsFoQNChKmB7Q9PPbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=degNNMoJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="degNNMoJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3499275b3a.2
        for <linux-openrisc@vger.kernel.org>; Fri, 09 May 2025 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746858459; x=1747463259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YtYSZsAqcEGJ+4WDsQaj52Ocf46yF0HDWpxG1o0+OVY=;
        b=degNNMoJ4gVm4JgoelnWJHV6uVtzhrunON5tk/N6JZgv8hecKqU9hiwFm8nnjaUvgg
         nXbByPCE1FrofTUIK6P6fuVtO9I6aPGs8pmxrAi80o42gwthvTYyjr74ppPgUrqrz54z
         P54pzjIVNQrzaMZVURqFndTbSb7uvissKlU8YXklsybifM/Enpbd66NGcoIOxKlQMRmm
         k3y2Y6Hcao8eYWMsMFjjxUfVrjMLrEFBuKfENKg3W42kRLQNI7nNBeoEO5T28Zi3WFGI
         +NJTPYWerUeoiOq1mfmsoY4vprackVmeihQYcJYpuIGWlTzh9EkY0xsq55Y0ie/8tOUT
         BwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746858459; x=1747463259;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtYSZsAqcEGJ+4WDsQaj52Ocf46yF0HDWpxG1o0+OVY=;
        b=nBGlFPwXzBSdpPdylNC+e/LR3hKXl8mZCvCLPJME25fcI8AQjHvPtQrbmKjQZVcqYO
         +i5TGG6wVXZOkgpdGmX5w4a2nEGsXfNlAZS6FHleaGg5ixodOeUOG+TbbFJLqFQO2GVG
         ctseDyISY0+743HnLuKMUn6hYkQB0P0vuNBjgfg1nC5FGSC5uabXqEMQReGiJJdSpi/X
         wI/I8gt3iHVT+Ju5+zwOM8DNLLq6xML2lPyaa0fBYmaVu+G3PXJHacjDKWVkT/ImP9Cb
         KwYs1uDBceHL8YopwamWnbgH0mIZS27FUrLZLQnP7z4HrMwNaKz7C6rnkSTOWArwPn+6
         y9LQ==
X-Gm-Message-State: AOJu0Yw8QF3UUuGgFCIrcLQ5hB28Ca15nGWVmj+AB9UqOBZpm30DhdNU
	nQH4J443hkX92uxp4MusSMvgk8ww2swBD/+Hz8sPKDq1D2erFp02h+fIqw==
X-Gm-Gg: ASbGncsRHJoFWUW0JTWSzmy5djYDJu9pXntE1VrCcNFvEuli7m4nlko25xYqaJEuS3L
	lVj0hAp8plIWCccLLK7uFKx1mi5WWZzwNkbeWfYRoNqps3oZZytLy+ObgAvT9YR5NAe7dlt7g5G
	T8RmbEJ/Bv4Yv6SwjNjl8sHi8NpNNJurRUYopgq1eHLqIdDy3SruDPynhxzLGnYm5fazaccw0h0
	0Aifrhq/t5YNTQRiN7tSb9eS7rI2+Lux6tnAUprKDHBJM64FrrgZG2T57GON6SZlvjw4dZr3q+z
	rO0pWtQrSuwV4w2aPxn7hXNzgz8IRUNMlnEVwFmt6yqJEAMioYFYm3oE1SO4uQhvpIwZoWEqPnd
	rKy9+JXtfIIG7cjkoKPxDtw==
X-Google-Smtp-Source: AGHT+IGvCYN+lCKKYUbX5M2uH+rVmD1a5GYOaxSICuWcCnxOcOhzn4uGzxjR/pliv1ktF5OnXp9+ww==
X-Received: by 2002:a05:6a00:17a7:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-7423bc128f2mr10323837b3a.8.1746858458602;
        Fri, 09 May 2025 23:27:38 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:fd:dbd5:746f:e581:917? ([2401:4900:1c7e:fd:dbd5:746f:e581:917])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a3869bsm2657171b3a.122.2025.05.09.23.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 23:27:38 -0700 (PDT)
Message-ID: <b476af9f-fd7d-4a86-ae9a-5be871d587fc@gmail.com>
Date: Sat, 10 May 2025 11:57:34 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GSoC 2025 OpenRISC Linux Feature Development
To: Stafford Horne <shorne@gmail.com>, Miao Chen <chenmiao.ku@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <aB5fdVgEiVZ4XsLw@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <aB5fdVgEiVZ4XsLw@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chen Miao,

On 5/10/25 1:33 AM, Stafford Horne wrote:
> Hi All,
> 
> Congratulations to Chen Miao for being selected as this year's google summer of
> code [0] contributor under the OpenRISC project.
> 
> This project will have the contributor developing, testing and sending patches up to
> the Linux kernel.
> 
> The OpenRISC Linux kernel support is under constant development but there are
> certain Linux facilities that are not yet used or available on the OpenRISC
> platform.
> 
> The project will be to work on:
> 
>   - Add tracing facilities to OpenRISC Linux including: jump_label, ftrace,
>     kprobes, eBPF etc.
> 

Congratulations on being selected and welcome to the community!

Regards,
Sahil
