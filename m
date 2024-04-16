Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C213174B
	for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284408; cv=none; b=CTS8WS0TIU2i1273jm0cwbcpX7DeIMvcvAxztuyglqUUCgN8Y4ZQD56F/C49KlHocWi2VvxTBShsvqqJ4ydYVZ6P9oiB0g/SuCo9+brViTXhIWhz1OxSD69OLtyBmCw7vzriGWvM8+g7no9nLMYDbKFdULy6Saqlr8sKEzSa5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284408; c=relaxed/simple;
	bh=CdDioauzPsVdmvEvwfrE3wSe9nwoLNd0NWasPaII7Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Asu7UIw0QfliViXOrFGHu36mGetO2ANFsTgy6NhamS/zajsKXuHH8vDuhqBoqVRJoHDZuigkJ11m5Qf8w1hIbsXElnDADarxfInHwnVV3NNqThKcDQm12WSjangE1L85bZ3+Gie1+mA2mYYikULJesjkq+leALp0X4aRe7sSZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D845yYdC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D845yYdC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3cf5b171eso37577565ad.0
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713284406; x=1713889206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b0Ukbqz0oqZ6Qoqe3OK61DIx2Mm6BdJJcP/3/5uImOw=;
        b=D845yYdCg7anv69LSepOcRnQ6tU9Q9gu8TP2ANyhJjaoLghrqdqhflvenmPVahPBfD
         dg7E+NLP3Q4NJkSqIHfjf6dCbyyOrgwgbxJQh7yc8Wo12EQ1SNWpUfDnlppQ3bB8KO6R
         TheX2ioCetHQ+oX32DaBRjq+e022w+LohfnZ+KtB5B+Xr9JGSO3kbeMNnqXudRwIj1zi
         uB8i2JQTUBeE5X9gTxjMJouEJ1Jx1y2qbaXwaHTthcY/lumck18DeH6z6uHyYi2USFKg
         +KILGiIHRo0FfUcaP8NpWlStdwo+VeCsQxS1cmC/ubWuKu47/5l1l4E1aTlVMq29/++R
         a7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284406; x=1713889206;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0Ukbqz0oqZ6Qoqe3OK61DIx2Mm6BdJJcP/3/5uImOw=;
        b=igLclsZ3DtJAL7NGdD4mdNAndfZlWCWEf7SIe1lGxPH1JcFwP85MN/yQrUtxn3sJB0
         zm9S3jubLQ7FcigpjbkeM77JLHI+GSoxsdiI75rHuUb60ivfNEJnp+AZc1iLc2z3A0tP
         2ORd2iYPVWai5yJ3HwHCmp6xHHsqiJlHXmiLPA6bBXY6WHVionh+2PZMf6k7vI10kF28
         JL2CZf/c9bu0ZwnUYijWPbXy8k6SNDLexaqPiuIE0eV0gVVl7KNCq5JU/VDPxO+MqIi9
         XWmsesJVgiWWiAgPDC5siOGdc+dRuOMkwuxWdmu1Y3fQZe39aAa6srExMYaPsXP0sQwb
         W/kA==
X-Gm-Message-State: AOJu0YyU56icmWJvIQg/X4As02ECCvTm7odb5PGEU3v83dWidD4UYydb
	FIkRAEDE64LnAUlAKwG+LYUidmzBKes9VinXlEmjpVhSPP1yydNeos8tWi3crns=
X-Google-Smtp-Source: AGHT+IEql5Vhb3nkOLg4mg7UOMUdt1YqcDhWjffCcralyCfgRKgphiAJBjfXHvspBPAT+sNjdXGG3w==
X-Received: by 2002:a17:902:a601:b0:1e7:b7a7:9f20 with SMTP id u1-20020a170902a60100b001e7b7a79f20mr3793335plq.59.1713284406094;
        Tue, 16 Apr 2024 09:20:06 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c0:d8e5:34bc:e1c9:2b45:c06a? ([2804:1b3:a7c0:d8e5:34bc:e1c9:2b45:c06a])
        by smtp.gmail.com with ESMTPSA id v20-20020a170902d09400b001e435350a7bsm9934330plv.259.2024.04.16.09.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 09:20:05 -0700 (PDT)
Message-ID: <9870848e-0b2e-423f-8dd1-4bed6968aeda@linaro.org>
Date: Tue, 16 Apr 2024 13:20:01 -0300
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] or1k: Add hard float support
To: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240329074044.1961252-1-shorne@gmail.com>
 <20240329074044.1961252-2-shorne@gmail.com>
 <4fca2ce2-2a45-4021-b91c-3e0c9dd8f6e2@linaro.org>
 <b3bf9676-ddc2-48eb-9c94-7512281155a3@linaro.org>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <b3bf9676-ddc2-48eb-9c94-7512281155a3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/04/24 11:53, Richard Henderson wrote:
> On 4/16/24 07:04, Adhemerval Zanella Netto wrote:
>> If I understond correctly the OpenRISC hard-float ABIs uses the same
>> parameter passing ABI from soft-fp, similar of what ARM does with
>> -mfloat-abi=softfp.  So the the shared objects built with/without
>> -mhard-float should be interoperable, assuming hardware has hard-fp
>> support.
>>
>> However it does solve the potential problem a binary built with softfp
>> loading a hardfp built shared object, or even trying to link with a
>> static object with different ABI (and assuming a hardware without
>> hard-fp support)..  It means that loader and ldconfig won't recognize
>> shared objects with different floating-point objects if they are installed
>> on the same system.
>>
>> I don't think we have a strong policy regarding this, and historical
>> there were ABI variants that followed this (like powerpc soft and hard),
>> but most ABIs that support soft/hard floating-point usually advertise it
>> through ElfXX_Ehdr::e_flags.
>>
>> For instance, with arm:
>>
>> $ cat << EOF > lib.c
>> float foo_float (float x, float y)
>> {
>>    return x + y;
>> }
>>
>> double foo_double (double x, double y)
>> {
>>    return x + y;
>> }
>> EOF
>> $ arm-glibc-linux-gnueabi-gcc -shared -o lib.so lib.c
>> $ readelf -h lib.so | grep Flags
>>    Flags:                             0x5000200, Version5 EABI, soft-float ABI
>> $ arm-glibc-linux-gnueabihf-gcc -shared -o lib.so lib.c
>> $ readelf -h lib.so | grep Flags
>>    Flags:                             0x5000400, Version5 EABI, hard-float ABI
> 
> The typical reason for wanting an e_flags bit is because those architectures want the parameter passing to change when floating-point registers are available.
> 
> But for OpenRISC there is no separate floating-point register set.  All floating-point operations use the same general-purpose registers as for all integer operations.  So there is no point in a new parameter passing ABI.

Right, it was not clear from patch without dig into the ABI documen
itself.  So the only thing I am not sure is the mcontext_t change.  
Other ABIs added a symbol version to proper handle it, so maybe 
OpenRISC would need something similar.
