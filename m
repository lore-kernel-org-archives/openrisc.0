Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638412F393
	for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279228; cv=none; b=W8ys7DsFRUSyl8a7sI2/IDxZtajoXJW3OLAmr4G+S829PjMO/AU3NveJie8Zuva6xyApvEJHEwdZaQsakarpBwAuOSlJkFyd9jnbTcZTLzhkdch6C6aI+7TQUDupDIK4FX+cjKQzFFIUmYnRb2dkqdC37oiT/z24iuljv7KRI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279228; c=relaxed/simple;
	bh=j5yc0s4TcUNxffKlr7NEk66wuBol0ugKtNM9kjFM2DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWyXdei0vq+OHGk7az5WapVvMx5FHlNKMqXsOIWpGk8CqSH5jUZbvOlkrHu5dfrmXUNlUkaN4Cb7XNcNnwxIaF2XuMDeuixCKoxjZq3eCpE4gYdmlQVEy5lk3f5MCf6aF6DBJB38eLDC0c6CT0QQFqzsRmx3lhE665m79uZnUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q42vOEkk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q42vOEkk"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso3666234b3a.1
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713279226; x=1713884026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IG9e5iG55e33wZLtcPelhxBmX5wUCwm90Rmb0DsqatQ=;
        b=q42vOEkknD/KaorSRUsjK7PwveY8K7MH+c6sXgx7B8VxAt92BQ6DQkcq2NgjYMqClm
         CBiyUSYxMUJiw8LDg+PVMCz4/jCdfTjpV1m7H55GU1N02hyQY+ssQ09SkUwL41cqdinq
         drb0I9WCGvWwosOzOuXJ9opX3jCt+/w+A57mPemNwLg5+K+D5hInQfNcX60QtcpLuYDL
         cWk+6yxAsgz5g+SmbmE1GZtKf5ZAXZDuWiSXUhZ7uByve52wp81Ed6CW0qGTiguFunso
         oLX6eJd2B3ZV1ugGEZ5WiDAfkHsswmq1+VHn/XBwK70ZOobjDxyFzijT4i7RGqf8LL/t
         btWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279226; x=1713884026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IG9e5iG55e33wZLtcPelhxBmX5wUCwm90Rmb0DsqatQ=;
        b=Agz0kOKUA8xfqC+aRbM+wYrqED/X6oKDC16RdfX6BETsWXPSzZK89pCzFdpfni8cYP
         K2VfGpkxz9Hvcz1aW0AhBbDBF9gPIOB92kwWlGiN4v29otVpDsqyXBjYsauct9MBsm5D
         GFDpXPBeQS83bIo2YcyW6IJJ6IpHwQZc25iM6NHVD8KU9gWLPMUlsyZr3cYZjB0m4jAe
         FOtwnGowWZjxZeILsv6lMQQ1nm+oatH2B/nSdQ5/MobblPCTv6BZVxOvjU0OILoc30Rg
         j+edJ5t6jtOI4TmwD2fTSqo0MwQQaCfVn3tDG0cbg2S2bdSZoL3Le/ARzJg+AR9g9pJp
         4Unw==
X-Gm-Message-State: AOJu0Yyp2OuaEmgBErde6y8DT0D7Iag0OUGBPjdNdohcgZV5D48xn9BU
	sEXSIZqi3cikSYlSdVOhk7Mi+3j7qw5VXZRUyMCCE4f0xn+9QkYsSnq5ooKadjU=
X-Google-Smtp-Source: AGHT+IHddjYaOvb0TfIg3FdVtrI7tO6xvQ6RsY5w+54srdfYVVNOtls24UmT0YY0fd/7/w7a94+/ZA==
X-Received: by 2002:a05:6a20:5609:b0:1a5:bc18:97d8 with SMTP id ir9-20020a056a20560900b001a5bc1897d8mr10750055pzc.3.1713279226565;
        Tue, 16 Apr 2024 07:53:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090341d000b001e51b690b7dsm9821723ple.295.2024.04.16.07.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:53:46 -0700 (PDT)
Message-ID: <b3bf9676-ddc2-48eb-9c94-7512281155a3@linaro.org>
Date: Tue, 16 Apr 2024 07:53:44 -0700
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] or1k: Add hard float support
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Stafford Horne <shorne@gmail.com>, GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240329074044.1961252-1-shorne@gmail.com>
 <20240329074044.1961252-2-shorne@gmail.com>
 <4fca2ce2-2a45-4021-b91c-3e0c9dd8f6e2@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4fca2ce2-2a45-4021-b91c-3e0c9dd8f6e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 07:04, Adhemerval Zanella Netto wrote:
> If I understond correctly the OpenRISC hard-float ABIs uses the same
> parameter passing ABI from soft-fp, similar of what ARM does with
> -mfloat-abi=softfp.  So the the shared objects built with/without
> -mhard-float should be interoperable, assuming hardware has hard-fp
> support.
> 
> However it does solve the potential problem a binary built with softfp
> loading a hardfp built shared object, or even trying to link with a
> static object with different ABI (and assuming a hardware without
> hard-fp support)..  It means that loader and ldconfig won't recognize
> shared objects with different floating-point objects if they are installed
> on the same system.
> 
> I don't think we have a strong policy regarding this, and historical
> there were ABI variants that followed this (like powerpc soft and hard),
> but most ABIs that support soft/hard floating-point usually advertise it
> through ElfXX_Ehdr::e_flags.
> 
> For instance, with arm:
> 
> $ cat << EOF > lib.c
> float foo_float (float x, float y)
> {
>    return x + y;
> }
> 
> double foo_double (double x, double y)
> {
>    return x + y;
> }
> EOF
> $ arm-glibc-linux-gnueabi-gcc -shared -o lib.so lib.c
> $ readelf -h lib.so | grep Flags
>    Flags:                             0x5000200, Version5 EABI, soft-float ABI
> $ arm-glibc-linux-gnueabihf-gcc -shared -o lib.so lib.c
> $ readelf -h lib.so | grep Flags
>    Flags:                             0x5000400, Version5 EABI, hard-float ABI

The typical reason for wanting an e_flags bit is because those architectures want the 
parameter passing to change when floating-point registers are available.

But for OpenRISC there is no separate floating-point register set.  All floating-point 
operations use the same general-purpose registers as for all integer operations.  So there 
is no point in a new parameter passing ABI.


r~
