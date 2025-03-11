Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB6223335
	for <linux-openrisc@vger.kernel.org>; Tue, 11 Mar 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723228; cv=none; b=o8vR6HoozBdbzWTDxGvg8pceFGT9ZwdOIFWDsKBEv1hCQFVjWBjQ4hHzaInMTbD4V+79Zcqyzy/zbFhlDxxkpxJecRM+IPotP3z4E77H48q8py2l+OAwbhPh2Hnz4oEuWY+twqFVvE2yPxYk3NHlk9BQeTN+VE5iRd1gmtL1Jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723228; c=relaxed/simple;
	bh=dQ/AyXc2NIr13EXujeVDPG7Aop/eru5YTYIiS6mm+cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qPx7VKx61mHdkyvmIJhCOmfubnvGm5UQFAcwhVGYywC/GznDFNzCW5z3zTE/lE83rXLa2tC8cs9ZbXQ0aiWF6mY6ofgwE4ktvH0bshABR77vsNX0fUS35oXMTWsc1KyPah5Wn92hawPYGuHvK8woq6B08uH2O959tV0fcYxmxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfT95wPk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfT95wPk"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c07b65efeeso557446985a.2
        for <linux-openrisc@vger.kernel.org>; Tue, 11 Mar 2025 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741723225; x=1742328025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FAbXnq+8at0OW+uVXOCeffGNHW2g+BuBjY5zrgBmcTo=;
        b=gfT95wPkElFg9zd+ttH/UfZ0WlbKdEmwSTfCQs9Fu0LjBqxta2eMG3IPP8ttMrenM+
         PoK7yL10k3ECYHjTha2t0XTw7dppTyJj36CU4MT6U+Q+DYj9rqjEA6vDurgkJXH4nznQ
         y1b9uNX7wJBOhRhsmh+8tKACG2upX8sLxFetvJkbOAPi6CfI4w7uMHrmJEj6TTkY27no
         m6QCQI8jGN2qJ8SjaaqEO7poIsbwxEodRidBPjyGXW9KNeUuZ+fP9JEn2gbsOtR2rdyv
         oyeqXgeN/bdhu+fEvLeCxJGEP2RGpwDdMyAPjHnEgl24HB7IBp6CdFOLBbaXwgirE5oi
         fr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723225; x=1742328025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAbXnq+8at0OW+uVXOCeffGNHW2g+BuBjY5zrgBmcTo=;
        b=k8WDzyUMmpVHO8130oH4kl6hFTpepWEd0mSG52mruYcPm5ZO5ZPPAUEKyUwfYXoGOx
         ywYDlq00Ub3uzrPW2VVT3ziXbRiyL9jlw7iRARLFrS2qXqCS2OtKhSI6NgjhmsPHwdB5
         PnQQPV+1aD5a4GKq5BvfNfXZ+rZdkoLlc2iTrM336UUpsdxa1kx1McT+EapFShogRpl6
         dZVN5k7ECI5d+cv/u8MDzQ4P12wtXYqKt5WfWtq/QUat84GITEmlzb6uLRnaxqfMC6E9
         gBTEk1b8/px5Rbebn0TMRzptMfz3/XYVVSUFxP8yTZLQqRdhN7ViCeLv0JutdfBjPxrr
         cL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG6a1P+wBatHaYPalAVJ528vYT4mAE4Ab/N1vZrMS27OA3WQI89FzsgvrBTIHfG3i1P/hg7QFl9x1+E2xzkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYh9jE56BjZ84qtNiokwPSR6Ea3ZqxdBTdTr8L+0Nzx1rC/Vlc
	epDYZWrqKNBYg8fE3m72bdsYVeLOAIlnEvjm9RDV0hmTuTGbnuMC
X-Gm-Gg: ASbGncu0Kp+wt6XAetgCxe0N+GKoJI6ROWL0hEFt5GxTVI0RYWKC504a/7kMhWA4sls
	UEkAg8Hwk1VsiS82TCdPaRjsyqyPtM7kuRWZFmiLqJIWFSyHo0DU36zNU42Ap6rLl7GUdr2TGyQ
	54grVU6nE/hNkF40iquwksliilssAA2zVIspbsZbew4pTodiIMlzQxBCNMQ5I25S1y1NvbfhJjA
	hPzPuX8GL0tAt/aJe9ur2iL9Ma/mHn3UHe44JMQC4Dx2yo/BM4JmJ/RSmN+KEvT4A/5bp/zKO2k
	oEJr/tq40PC7JP2n/iusi2ED3xiQY5EtVJbta3ea+WEVbDFuWa8Hl1vc/UG51kWDUzW8IR+fvpU
	1sYO3RmPunfLAaXDm
X-Google-Smtp-Source: AGHT+IHmJEcmvIS109VIaPPwT0tPeSIKmh4JzzfBujQ1ad5YqylACnT9xBLTq5pWuRT+Za56ZWjIfQ==
X-Received: by 2002:a05:620a:86cc:b0:7c3:c500:ca9f with SMTP id af79cd13be357-7c55e93de0fmr753058585a.56.1741723224862;
        Tue, 11 Mar 2025 13:00:24 -0700 (PDT)
Received: from [10.49.92.110] (nat-128-84-124-0-110.cit.cornell.edu. [128.84.124.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5568480d8sm341773285a.91.2025.03.11.13.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 13:00:23 -0700 (PDT)
Message-ID: <7084228c-23a1-45f9-bb58-8c85c1ae13f0@gmail.com>
Date: Tue, 11 Mar 2025 16:00:23 -0400
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance improvements of Marocchino implementation
To: Idzwan Nizam <idzwan.nizam@yahoo.com>, linux-openrisc@vger.kernel.org
References: <810295975.3514440.1740967866807.ref@mail.yahoo.com>
 <810295975.3514440.1740967866807@mail.yahoo.com>
 <917f2fb4-adf1-4c1a-a268-8229a90161db@gmail.com>
 <4da2a6d4-bd1b-4043-92fe-4c16d2313a31@yahoo.com>
Content-Language: en-US
From: el 01 <quantumleo78@gmail.com>
In-Reply-To: <4da2a6d4-bd1b-4043-92fe-4c16d2313a31@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I defer to Stafford's judgement, but please don't feel an obligation to 
continue exactly where I left off. If you want to work with FuseSoC 
only, that should be fine.

A bit of advice in advance -- I didn't write a script to batch run tests 
on FuseSoC. I instead ran each of the binaries individually by invoking 
``fusesoc run``.

On 10/03/2025 06:09, Idzwan Nizam wrote:
> Would it be OK and consider a progress if only FuseSoC were used?
> 
> On 10/3/2025 1:02 am, el 01 wrote:
>> Hello,
>>
>> Hopefully this makes its way onto the mailing list, my previous email 
>> didn't.
>>
>> Stafford's previous email basically covered what I did last summer. 
>> I've been dealing with some health issues and haven't been able to 
>> consistently document my progress; really sorry about the lack of 
>> documentation.
>>
>> I left off at trying to figure out some (perhaps superficial) 
>> differences between measured cycle counts when running a benchmark on 
>> LiteX and FuseSoC, two different 'build systems' for the HDL design. 
>> This doesn't directly address the discrepancy between marocchino and 
>> mor1kx, but was a step along the way.
>>
>> The build systems bundle the OpenRISC core with some other necessary 
>> hardware (e.g. simulated memory, peripherals, etc.) and build either a 
>> binary for simulation on your computer, or something which can be put 
>> on an FPGA.
>>
>> When running binaries from the Embench benchmarking suite on the same 
>> processor core / simulation engine (and only changing the build 
>> system), there are some tests which have substantially different cycle 
>> counts.
>>
>> Some initial data I gathered will be attached, it seems like there are 
>> some substantial differences in the cycles required to execute some 
>> instructions on LiteX.
>>
>> I'm also not 100% on whether the measured cycle counts are completely 
>> accurate, as the debug / trace parts of the LiteX and FuseSoC are 
>> somewhat different.
>>
>> Another minor thing that I wanted to address was some inefficiency in 
>> running LiteX simulations. Because of the way that the Embench testing 
>> script for LiteX works (see https://github.com/hhe07/litex-esp/blob/ 
>> main/sim.py -- from what I remember this is stuff that you can copy 
>> into your Embench install folder to enable compatibility), I think the 
>> CPU and some of the supporting software is rebuilt every time a 
>> different benchmark is run, which wastes a lot of time.
>>
>> As for where this fits into the larger issue of the performance 
>> discrepancy between mor1kx and marocchino, (in my opinion / 
>> experience) I spent a lot of time trying to figure out the tools and 
>> determining if what I wanted to do was a feature of a tool or 
>> something I needed to figure out. So, I'd recommend trying to 
>> understand the tooling and perhaps doing some practice tasks around 
>> it. YMMV, though.
>>
>> I know I haven't really made this problem better due to poor 
>> documentation on my part, so please email if you're unsure about 
>> something that I did. I'll try to reply ASAP.
>>
>> As for the attached files:
>> - profile.ods includes analysis on cycle counts per instruction for 
>> one test, I think nettle_sha256. This is for the mor1kx CPU.
>> - results.ods includes cycle counts for all Embench tests run on both 
>> FuseSoC and LiteX, and calculated percent differences between the two.
>> - nettle-mor1kx-{fusesoc, litex}-trace-prof include the outputs of 
>> cycle counts from the analysis scripts I wrote (basically same as 
>> profile.ods), as well as some additional information on the PCs of the 
>> start/end of critical sections in the code, and how many cycles they 
>> took to execute.
>>
>>
>> ~ Leo
>>
>> On 02/03/2025 21:11, Idzwan Nizam Jamal Abdul Nasir wrote:
>>> Hi,
>>>
>>> I am interested in OpenRISC Benchmarking and Performance improvements 
>>> task listed as one of the project ideas in Google Summer of Code. I 
>>> am unable to participate in GSOC but I would like to contribute to 
>>> the task gradually as I acquire skills in digital logic and computer 
>>> architecture.
>>>
>>> Is the task still open? I would be glad if you could point me to the 
>>> right direction such as documentation I should read or tools I have 
>>> to be familiar with. Any guidance is welcome and greatly appreciated. 
>>> Thank you.
>>>
> 

