Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A711D5AB2
	for <linux-openrisc@vger.kernel.org>; Mon, 10 Mar 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601983; cv=none; b=NtSIls0jTx/gasIupcSyKlLVDt6FslsV5OaeRTBURQ3xuLGIaT0CI3FSZBw8svC1t2HMejvNZdX67ro9mgDfgM9zAE11vP3wLzNhWSYWmoVq+pGQeBahY5NNx3O1RzHXBjbnmvPcjhf5tLe2StMmB8Ps7nBPh93rbDuWij+8Ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601983; c=relaxed/simple;
	bh=ycFiyAgaLUDPEqMiuTPYlotGOJ0SndgF5M760zsiYGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IEuZIhYLSD5LSyxwa5ULdTdUWURNJsdqtOd4ZQos7S2wNHZrfLZICW/C3Xgkdv9korUvaCbl7LlGMCHZYZmRvRTNEl3geA7U4URt2bK9FdbEdT/pZLSkQ2tHgFlA1M+sFobt8kSKDjjHtf+TJSozK248pMEGwojVSbvadyJ/0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ftYExzlE; arc=none smtp.client-ip=74.6.131.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ftYExzlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741601974; bh=j+Fx6nRQAcnvlctoNadDgdR3v6BsKeHUtyKMxVMMUTk=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=ftYExzlEr51zVfM7H/IAoALRcpSVZuRPGKowahY8Kp/safdrctgVWwGLRZncSNvLudQ/Yo9Ek7UfhMrlKKlcKjGqOqxyU3F7X+T0FvuJCm46VdL2y+payZdP0JPrG+7NZFc1DjR7dZnokjgg3Cfc+WOxbA5e0I1G4TUMSD86B+R0wr9uoiIf70jTC/FoUnmpa/P9hKUKfqfZQCLBWq9qOZoIfrP6Ky9k0HjmoP1wsGonpDxtDqCm0/d+xQgcxVqzOpk4/MMqQYc41yzd+y+CtWGb5nkZK3D7R6c0sCtFN+X4RArrXYK42yd7dcNPy3N4eW0SXNnTHZ6Uv1qS1yv4Yw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741601974; bh=5y2tCukdi98tBL+89f0qIhxpOooLCn+0163qnlLm1wL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=P3oq0rfNhb1JHOc62VfiwvVTiOZqf/FNm0x2HvbmSnkJ9BdZI0IO9PlZLol6aTzQ7zsAOsR3wPdAmThHz+MXPG4QGmYkmGjHzxBff5cmI8XPwTXbE3MC6Q4pwGuDDhFbXsykh+rBVnSJfBFADjKehfygLxLVoOvqzxRKMi793R8N4Z1oNY00V5+zx1CDeasmanQ0b1SNgJh7WbG7VUKr098YlU9oaF4YGX3bU4VE/G7otQIgdgNwk/Am69XKbYq1PzmMciE7U2lZ6RrjqE9jU3GNP9vzgSbe+EZh9ZjYTYtbvirqgn16TIwDlgNDZmv/9UHW1APHneYsy2Pwx1CKHg==
X-YMail-OSG: B.c2o1EVM1lbQCjEhfGVG7kskKr1FT_yFmsetIsuVEzc51feFnLNXoP7t05oXay
 V2nHWiUTPMFeGWuJQywrX60ctGgGq4zzzRHKp71vFU35XMTmVPMbKRLBi4nb465IE1jQ8VGmph0J
 CdRiPA1zE7Gb2ffKrVF91DajFMO_n6wMYiRB3KBBuOVt23mW.2iiRVuK0FoZ5Da1dELqAz3APcU7
 d0SaNfLCTvpALkdTt_ntN1Ap_JDjHo2bbm_QPS.2krMQEdeCs.lx.I1c9rw3xURkZslk7TbwPfDl
 Swo_h6QAOsdzPK734Ib2QZiFoiWEyksIz4Fcwk0cBCreRgBlIBSGq0CvI7f7P7Trff5URGTGP3K.
 vvGjKlHhRZmmv3x7BRTh.tTgjV7FYNPlz7e7PN7TyOOvswSp9wXmVQhxyzZXQ3CpCyZDej.lFFSV
 hirnxEtxqvsvi4mg2ntoALNtlzzBrXEiidgO1VyzX5Fz.dZOMw0JheIn1tx4BU.3qSQCnFurA8Kv
 y8nrlPWl6tLD2i1iJkhn58rPclu9.Yfl3gS6AOXOna.VE8.qWCy1nmnzS9ovXCQPUJg1_B3TwAgp
 G7Tkwus9TkKRRy.D0YTAMaR30c.JqD65xVcW2GBc1JfmWXTZmDGNjlJMi26iTn2MuuM6JLseqWLn
 NP8zmdXYFPQoMrwhDMNfMa_VpI2.ALfkN5PFZd3RTOQxBJ7kU4ViFbL2hrGgVa488FIZN8pIlTM8
 SsG.R9UeQmEIXeqIF9qAj2ezFSVzXZAVceyhuV_hCs2t86m8nVCZeGrRggsCjc1BQUpjT3DV_sKM
 S1bZ0ulD_pB6d9qLqdmuVY7Kxq1k5d6YxB1SWzZix4IIASQyIRdiOJf2LVvgzynFU1FHFlMZyvKd
 GPybPoFjnk_kNyPAPsH6PLBvgBrBJgMFDB_8JYFTWTkXQtoqVTVBXj5yL1xpBGztCHToM3YPfLcA
 0ScGb0LBCr91X5Dpkzs.wPc6bEzlwt4yvByYiNIIBRraoWhDbT431EdMhXUQ_avQYtp3zLcP4oBz
 F8LkUW4eB.uvAX5cp4EN0K9zE8dFPXH1NFPB2g3E_aM2_dW0Z4stOvSNlYCXz9WDgjcdMhUMfwUy
 dOkXtGttcHh4tIGV8wZbeikntqa1aspCf4El.3idcdb5vSTki6mDuloh0FWbfGVGzMMie1mwe1ef
 I8gbJ0Z0.Ps1x2_xPYxX6EPZgACHLhrKFfKmMpBbAhasCTdS7HTzUmZoTJ2PPPw3YiY.uMItn.az
 CSQyXk5qymmnvaVBCU7cFfYkGbJ.BFQi0vegvgB6DKVWOyFzZKxSfSU4RNruj6c6OUUWHZtIvUvY
 fgCfoN8vPbc8CqEI6jVx7YqRB7f0uo_C2acvSeldWoYgBs2TXeI39354Atk03hBhHgvInpI07Shk
 WF85A8lb1T7yr7WI8tFTEau7omlQVntTac0W804sSssdmwxT8hdnaAQ6LyvCeyWDsgPRpgUpufBh
 XeixzdTbCbPwsJc3Zrz1dkesv5WryBjyKTzMCtMyv_8aYzQgKQfaUDbRpeIPXukxM.Ucd6wZW0PD
 Q9_oVTpqLDyjnKaJecYbGDz_kcAFrryiBpwXZYUn_HIpzhK8R1BgeepBR2NhuR1bD5wj57LfVMva
 ulfE81nd32gQFbAiUDWCcjHqEhmMd1wu6MDG.z0XOw7onqljmXOhaweRrRNaWpRiWU7Bl7yyZ_Hx
 IhAnZog7_uTmbj.8XUmuWkZdsX3HtifvpISevWrhuS1WepTAgWvpu.j5zFWbhq6CzOyFl5bq0uFk
 xBzYB_wLWOomZPa7P5DHLkiOCoOpAGPN7fUvn1jK7cjbj5d2tYZTvR3GFzcyJvdTyPZ5iSykxupk
 i9NH6845t06Ug9yYJR0OvLaMmCw1H9M7k_w2xxgNwVs6._gKpWy99t2zx6vdpiru7.9mVFBTCUmH
 ll3U0OYZ7L.xb1p_UzwjWwKUao4eLhoYu2fZq3a.LKqmoPBtw_NgSE37wFXpA1C5QDHofX1CDB5t
 WgoylwaQQdQkFoPPNxgYHy98ej5Std.Bkl.kT6F1tyEHUfwqOHNUy5C3S3xHuLHFskXDyTmBwDZO
 JcYfwNoMM8UdTYL0gWCGJO.pHva2yEd5VCkfYLf3vFh1XQ8qtxcCGalNB26NgGhQLKSFnQXp8kPI
 EtbrNkowv53D8HBNdzunfeqFq2dmn4q9A54Q4o_IbagmXMESz1F0PDzFHrSm1OHOOErlOWDjo2GY
 fT08dz5bC7x3aDJy8JirvAJIexOCaWhmkr_QZkUQ4565kUhae5wU_WFpK5foUVnflokiALDvDGTG
 PIm0tv2A-
X-Sonic-MF: <idzwan.nizam@yahoo.com>
X-Sonic-ID: 5add2714-2f45-420a-8992-26afd2a4683a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Mon, 10 Mar 2025 10:19:34 +0000
Received: by hermes--production-sg3-fdfb796d6-g2nmd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 16f5d2d74d96d5b2a9f20e98df8789c2;
          Mon, 10 Mar 2025 10:09:22 +0000 (UTC)
Message-ID: <4da2a6d4-bd1b-4043-92fe-4c16d2313a31@yahoo.com>
Date: Mon, 10 Mar 2025 18:09:20 +0800
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance improvements of Marocchino implementation
To: linux-openrisc@vger.kernel.org
References: <810295975.3514440.1740967866807.ref@mail.yahoo.com>
 <810295975.3514440.1740967866807@mail.yahoo.com>
 <917f2fb4-adf1-4c1a-a268-8229a90161db@gmail.com>
Content-Language: en-US
From: Idzwan Nizam <idzwan.nizam@yahoo.com>
In-Reply-To: <917f2fb4-adf1-4c1a-a268-8229a90161db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23435 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Would it be OK and consider a progress if only FuseSoC were used?

On 10/3/2025 1:02 am, el 01 wrote:
> Hello,
>
> Hopefully this makes its way onto the mailing list, my previous email 
> didn't.
>
> Stafford's previous email basically covered what I did last summer. 
> I've been dealing with some health issues and haven't been able to 
> consistently document my progress; really sorry about the lack of 
> documentation.
>
> I left off at trying to figure out some (perhaps superficial) 
> differences between measured cycle counts when running a benchmark on 
> LiteX and FuseSoC, two different 'build systems' for the HDL design. 
> This doesn't directly address the discrepancy between marocchino and 
> mor1kx, but was a step along the way.
>
> The build systems bundle the OpenRISC core with some other necessary 
> hardware (e.g. simulated memory, peripherals, etc.) and build either a 
> binary for simulation on your computer, or something which can be put 
> on an FPGA.
>
> When running binaries from the Embench benchmarking suite on the same 
> processor core / simulation engine (and only changing the build 
> system), there are some tests which have substantially different cycle 
> counts.
>
> Some initial data I gathered will be attached, it seems like there are 
> some substantial differences in the cycles required to execute some 
> instructions on LiteX.
>
> I'm also not 100% on whether the measured cycle counts are completely 
> accurate, as the debug / trace parts of the LiteX and FuseSoC are 
> somewhat different.
>
> Another minor thing that I wanted to address was some inefficiency in 
> running LiteX simulations. Because of the way that the Embench testing 
> script for LiteX works (see 
> https://github.com/hhe07/litex-esp/blob/main/sim.py -- from what I 
> remember this is stuff that you can copy into your Embench install 
> folder to enable compatibility), I think the CPU and some of the 
> supporting software is rebuilt every time a different benchmark is 
> run, which wastes a lot of time.
>
> As for where this fits into the larger issue of the performance 
> discrepancy between mor1kx and marocchino, (in my opinion / 
> experience) I spent a lot of time trying to figure out the tools and 
> determining if what I wanted to do was a feature of a tool or 
> something I needed to figure out. So, I'd recommend trying to 
> understand the tooling and perhaps doing some practice tasks around 
> it. YMMV, though.
>
> I know I haven't really made this problem better due to poor 
> documentation on my part, so please email if you're unsure about 
> something that I did. I'll try to reply ASAP.
>
> As for the attached files:
> - profile.ods includes analysis on cycle counts per instruction for 
> one test, I think nettle_sha256. This is for the mor1kx CPU.
> - results.ods includes cycle counts for all Embench tests run on both 
> FuseSoC and LiteX, and calculated percent differences between the two.
> - nettle-mor1kx-{fusesoc, litex}-trace-prof include the outputs of 
> cycle counts from the analysis scripts I wrote (basically same as 
> profile.ods), as well as some additional information on the PCs of the 
> start/end of critical sections in the code, and how many cycles they 
> took to execute.
>
>
> ~ Leo
>
> On 02/03/2025 21:11, Idzwan Nizam Jamal Abdul Nasir wrote:
>> Hi,
>>
>> I am interested in OpenRISC Benchmarking and Performance improvements 
>> task listed as one of the project ideas in Google Summer of Code. I 
>> am unable to participate in GSOC but I would like to contribute to 
>> the task gradually as I acquire skills in digital logic and computer 
>> architecture.
>>
>> Is the task still open? I would be glad if you could point me to the 
>> right direction such as documentation I should read or tools I have 
>> to be familiar with. Any guidance is welcome and greatly appreciated. 
>> Thank you.
>>
