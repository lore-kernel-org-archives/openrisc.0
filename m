Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001211;
	b=1YVvYzXOThKpb0YF1Ykr0vo2/pnEQ3YHYFbEhHTlul7vxXlwGU+EDmVQ40r/H8HCs69M
	 B5PJJ/AE+wz7wgt/n7x1JSOHj9KyE3JfdWFaaiyiEoRCI675nfGQlU7zzd9lQuO4Omjqt
	 uu7hJlKRHrIsdeLpZnM9aIHJdfq2utTR68yErfRtnpDtYli5sCJsgnouvOPakPQOZ+Qsm
	 lIoPjpN79oQh6Q/OadaPFj0I40TkvykB+zVYjncaypT7tLrcoxDRpv/9sgyfC2+JAT6LU
	 e4a312NAU9WpGY311wdW0Z6glKj1LV30iZ0v9QjAMtN3h7hWiH41NwkPUcPfltVHA6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=msXJndjH6JzkweLBaiGxmBinT8C/Wtkx/0H1bh3p3rU=;
	b=iUpJjDm7TKFhloGdpUcmCXDi4hy5dF2TyO9vNKYn5mrY/FCH0G134iHZwaF+UEr+vxlt
	 sEWgYnCdohX15FlgqtV512DapHD77N3+Axxa/MVJ2WYol43iWDFU9/JcgTuOUiILurQws
	 GUFsWTZV8l9eH3vPe+I4u1qApXzIjAWrD8uD6AphIjAgfdgJ0sBwupi3sxMI3CGBnI/Gd
	 y8eEZbxaJGJYHStOIOJ3Ugf2n/EaLX6PBEmNvi0sV8rFEnxPd2Pg12YkoO1JGCtKSFRW1
	 1Xbqbv4agxNn9Yq4lHjUnWFKSa4ZGT68L8LxjmeWnzu4nrm75Cj+R5hGy1Phru4M0Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P5otasT3;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55640606A32A
	for <linux-openrisc@vger.kernel.org>; Wed, 18 Nov 2026 11:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55640606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P5otasT3
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdab938dc83so467937a12.3
        for <linux-openrisc@vger.kernel.org>; Wed, 18 Nov 2026 03:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001210; x=1795606010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msXJndjH6JzkweLBaiGxmBinT8C/Wtkx/0H1bh3p3rU=;
        b=P5otasT3x0KiFi3TS4Vwf6vtcEOMgiVWP29dcN/e9s7NBmiEG7HdrHGZImmidMDo5o
         5xU+BvlKcj0+KXFWFEC6gq77MtAhKse1eou1ji4Zd3lSWe8x2gQiVXGBx0eaaDdXC3I3
         wD/SMzHcbNyQGxuokrJROPQ7UU26BYymJf6lubkRav7AWx7Vn2P5Vi6z94wCSxUojU+s
         +xApZYHKHYnFFfeCQ7t+Q6hM32sj+uTaXL5J+NtlmYzf2R1JsVDdgFZqZiRmPH4jyDNX
         TVXJxEdQW6qA8P98NZx6jAwMpmvFTLN8U3ybDvWsif3nBIrOCjLrCqyesYadO329VCr+
         tBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001210; x=1795606010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=msXJndjH6JzkweLBaiGxmBinT8C/Wtkx/0H1bh3p3rU=;
        b=ypSTCao+uNx183XJTHw72aw+AazvG6meLUjU9GcmMBa+IwlayeP1H+Lo3nTtW0QZyK
         vy14fBZC4Pmv7/sMUn+y53lVbhd5GWiSwuq3QBU/TtFAUbfVh+c9gyQpfTyShh+8/koC
         SrdedpTEOjETqUO2Uj9noslrur7LxkPJ16MEwJAJrpTStIVLucC99+dmjj51PD2eT5P3
         O+40F82ZeJZ9HyVcCDxVYHb0J39nHEDaUvzdG49FXFRp7cx0Z4djNLkZhiA0O7IdQebH
         nmccOJciP+DRHkIcwn8nlAl5ZUykRRY4kHmgIeIrPXitUDeaNWwPphfF8oEbJGLWbExJ
         qA+w==
X-Forwarded-Encrypted: i=1; AL+hErFBo1wjeWrgtBvvz4rSm9/JXk47jq6ZU45yvLdPR4OdLePrBxquSREP9SrzTjNTx1P7jWoY/ospI4HLYFYZ8Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9sUMys64QSBe+ucpVVwPnZ9SXt5xxlefiMZz7j3vQooHxXVt/0
	tn+RjN0a7AIHgdWt/dlkiSqCJ22ipFzeRyvzQzWfS3t6rx590n9TVpBf
X-Gm-Gg: AZFdTZcAJ9nYFkCsj4e9/tSUrcEKEOcXzHB83+vFqMCk5yGXkwE//RlHGBha8i7K5cw
	mQmJHqJZpkwWWzZw++cpxzIXJfYqbdTPMrK/RM3XmiPZU52PK8L1jfuOmI58SPfM+EI0c9Ssakw
	BeKu/JhyxSyQyx62QvzqGskJEUNfdpiJY7Br3x5K4+OTqAboJ65ilNrdR4T2MO1YXnZLtwhMP/L
	DVlDG5AhnkAxYJUSQzpWK1YqerOEJzFQGpunts2C0qjnU7FX8jaJs66KOsEBfDEMyL0AY+7gg9+
	bq1rtlx7wkLyJA1TOoQGRJWQdzfz8R6rXDSBbQTaCj8M4CsCsQ3zdKYvRL8T4rNtItu+y3P8PrS
	d/30v2WdENOT522r3vWLhikpbpMjrIXBk0kFxSQ4UmkDiHmOHBqFyYSqJrbwesBlfbUgfFWyqHJ
	nsqbPj3DCtn/JypeVXVxuArtcfYKapR2cd2CIqP9M1Tu4t48z82swWHtdEUk40TDOHSG9SKVsMJ
	2Ye85/AA1E0xLvFlWxVPDQE4n3aqio0anScl27i2fsoO/xA5az5qey8Y0A5b2Dk9eqcr4IuY0Io
	wj3dyij1nVVmbO8ftC3SvgGGfdxtuenGmasrQgx1C1kFb1ksk0ag1vz/8Lmnead4tvWY
X-Received: by 2002:a17:90b:440b:b0:3a6:f1d2:57f3 with SMTP id 98e67ed59e1d1-3b3d07e3950mr2232429a91.58.1795001208717;
        Wed, 18 Nov 2026 03:26:48 -0800 (PST)
Received: from ?IPV6:2401:4900:1c43:8cbf:33a7:8ddc:7a9c:40f7? ([2401:4900:1c43:8cbf:33a7:8ddc:7a9c:40f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acd118sm3997301a91.12.2026.11.18.03.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 03:26:48 -0800 (PST)
Message-ID: <fe93e84a-1876-4416-b3cc-547b9816c865@gmail.com>
Date: Wed, 18 Nov 2026 16:56:41 +0530
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com> <avAsy43KVO-7Nm9z@antec>
 <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com> <avkQctt0CKt3YcsH@antec>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <avkQctt0CKt3YcsH@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 7:22 AM, Stafford Horne wrote:
> On Fri, Nov 13, 2026 at 10:45:03PM +0530, Sahil wrote:
>> On 11/8/26 1:33 PM, Stafford Horne wrote:
>>> On Tue, Oct 27, 2026 at 01:42:39AM +0530, Sahil Siddiq wrote:
>>>> Tests already exist lib/tests to verify the generic functionality of
>>>> KProbes. Add unit tests to verify that KProbes work on instructions
>>>> that require simulation in the OpenRISC ISA, and that the corresponding
>>>> delay slots are handled correctly.
>>>>
>>>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>>>> [...]
>>>> +
>>>> +SYM_FUNC_START(test_kprobes_j)
>>>> +test_kprobes_j_addr1:
>>>> +	l.addi	r11,r0,0
>>>> +	l.j	2f
>>>> +	l.nop
>>>
>>> Just a tiny comment here about indenting the delay slots.
>>
>> Got it, I'll indent this.
>>
>>> You could also use the delayslots here, for example:
>>>
>>> 	l.j	2f
>>> 	 l.addi	r11,r0,0
>>
>> I initially thought of that too. But then I thought by keeping l.addi
>> before l.j, I would also be able to test this for the case when
>> there are no delay slots. I can reshuffle the instructions if that
>> test isn't required. Please let me know what your thoughts are.
> 
> I don't think it matters either way since these are tests.  But, it would be good
> to note that in a comment at the top of the files where you want to maintain
> that convention.
> 
> However, thinking a bit further that may be hard to enforce down the line just
> for a handful of files.  We should assume the kernel code uses delayslots.

I agree. Since "head.S" and "entry.S" already use delay slots, I don't think the
kernel will work with a CPU config that has delay slots disabled. Also, there
should now be no need to have a static key for "delay_slot".

> 
> -Stafford
> 

Thanks,
Sahil

