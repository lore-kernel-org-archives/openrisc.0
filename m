Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62FFBF6
	for <linux-openrisc@vger.kernel.org>; Thu,  2 May 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675494; cv=none; b=OTxBJJmPBcrvCPn9Ff/sBOWewpk487FHmqTjLDBM2aA5osXnScGDRjx81Dz4aA40Ty1fPj01XnGIYAqqoKLWDCpEBzDo4/iLYj0YJFIj+uVwsvaE6G6pIiDBbsI99jHoVSn1+MYYwqdO+2IIulpmY1oEgzAsH3W2ZUWE+ntRH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675494; c=relaxed/simple;
	bh=0ZG3moQymQs3baUT5ItQ48s54slq/2lFWQKR4DLH1R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY41r2bf8oR8mF4ognGcKlTv9sNTpnnZKMWT9pl0FGAu/bS5w5f0RbDvttWf5xrrFzO3lo1MIHeqSZTWMmmh1/PSrLN+a5sXPc4aRnFp5f/57gj4cbpGEFpBhs9TvHbt8BDYTD9RPE5jrNGAyrL1MlozfRE90kcmgY556zg387k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d809S+jA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d809S+jA"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so45458815ad.1
        for <linux-openrisc@vger.kernel.org>; Thu, 02 May 2024 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714675491; x=1715280291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nrYvKKBGSOB5I3iXvr0ODVUEP7uXJDy8GrI/I/VoBw=;
        b=d809S+jAjngScmR3PIkBkBRh8cy0G06cxJZZupqbmthxd6kreF9c3decYdJFbgrsoH
         Kn1ypBbu9ZgoNtaUmQJKfxB1oVw1pvqyNCxJRi62YOfuhie2pR4oLC8rbt6RYUgZaOaJ
         TGOUoRFK5v3qkDKHKrpmtLzNGyGP/VNrsx/Ik+r7mS4A+EisgoKuFvPt+9ww9m30zZYH
         nI7FJfmTrkj53hcJgzvIpNVTyMs3bV5HhVx9j6PlLSAnHKaVwxzEwor5PAGvStholKJS
         DK/YZvEEXApWaT00UPij/EQh9L10pGmE6XrLe2dk06GgTR/ZgNx8SpSn+onLQYxw5WJR
         lJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714675491; x=1715280291;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nrYvKKBGSOB5I3iXvr0ODVUEP7uXJDy8GrI/I/VoBw=;
        b=vR/+TR3KqFJt8EkMMvEn1KGRKW3T5K+e41Sf01s4JtKkxcjwEXiR4VeYX21KyaZUSh
         6+3kh97Xp9GLto+L4AXjFQsV6KQ3XZ3FjUeRUmit/BBIofmqz70g7Ms+huJBHZTqxmwA
         O75JnQIrTIgj8T9/ShoeIo1alSBulHuNBoKYUcbFeyVnY5yjf3vfUfAv86RNCcuMd3DE
         l1RrFktsqteNxjwJEsCSafY847QNT8uCGlnJcIr0SGTQTHUUV1sX/Zal7Tf5HjTvoqPH
         EhllHRL5VNyTlKexm9ca2VwJDq3PGo4AoNY+1wTUUNbRQbdnn6XdRJVeJHEttGMuY1oV
         Kp+A==
X-Gm-Message-State: AOJu0Ywty0L7b9pRu2rPuI+j262jwOVHsIn5ws08Kos65E2fo2+OuxY1
	7qFaGUumReYbVFgTAniCsphA8yfIwn+byxw1jeWmLPIvS3e2VD81v8ONbT8mNZA=
X-Google-Smtp-Source: AGHT+IEIiTiASKBRjApCTfi7P/1WUM5NSEUBuCYoOPLuhE+uqcbXNA1BeYid1daRLlIE34J36VJuWw==
X-Received: by 2002:a17:902:ea01:b0:1eb:7dc:7097 with SMTP id s1-20020a170902ea0100b001eb07dc7097mr737399plg.48.1714675491036;
        Thu, 02 May 2024 11:44:51 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:e3c5:bdc0:8ed:f45:eff6? ([2804:1b3:a7c1:e3c5:bdc0:8ed:f45:eff6])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001ea02645bc9sm1646222plh.148.2024.05.02.11.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 11:44:50 -0700 (PDT)
Message-ID: <d0bafe72-523a-45e2-aa58-9b0e18f1afe6@linaro.org>
Date: Thu, 2 May 2024 15:44:47 -0300
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] or1k: Add hard float libm-test-ulps
To: Stafford Horne <shorne@gmail.com>,
 GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240429054735.2467433-1-shorne@gmail.com>
 <20240429054735.2467433-2-shorne@gmail.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20240429054735.2467433-2-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/04/24 02:47, Stafford Horne wrote:
> This patch adds the ulps test file to prepare for the upcoming
> hard float patch.  This is separated out to make the hard float patch
> smaller.

LGTM, thanks.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>

> ---
> Since v1:
>  - New patch split from 2/3.
> 
>  sysdeps/or1k/fpu/libm-test-ulps         | 1115 +++++++++++++++++++++++
>  sysdeps/or1k/fpu/libm-test-ulps-name    |    1 +
>  sysdeps/or1k/libm-test-ulps-name        |    1 -
>  sysdeps/or1k/{ => nofpu}/libm-test-ulps |    0
>  sysdeps/or1k/nofpu/libm-test-ulps-name  |    1 +
>  5 files changed, 1117 insertions(+), 1 deletion(-)
>  create mode 100644 sysdeps/or1k/fpu/libm-test-ulps
>  create mode 100644 sysdeps/or1k/fpu/libm-test-ulps-name
>  delete mode 100644 sysdeps/or1k/libm-test-ulps-name
>  rename sysdeps/or1k/{ => nofpu}/libm-test-ulps (100%)
>  create mode 100644 sysdeps/or1k/nofpu/libm-test-ulps-name
> 
> diff --git a/sysdeps/or1k/fpu/libm-test-ulps b/sysdeps/or1k/fpu/libm-test-ulps
> new file mode 100644
> index 0000000000..948ec01cdc
> --- /dev/null
> +++ b/sysdeps/or1k/fpu/libm-test-ulps
> @@ -0,0 +1,1115 @@
> +# Begin of automatic generation
> +
> +# Maximal error of functions:
> +Function: "acos":
> +double: 1
> +float: 1
> +
> +Function: "acos_downward":
> +double: 1
> +float: 1
> +
> +Function: "acos_towardzero":
> +double: 1
> +float: 1
> +
> +Function: "acos_upward":
> +double: 1
> +float: 1
> +
> +Function: "acosh":
> +double: 2
> +float: 2
> +
> +Function: "acosh_downward":
> +double: 2
> +float: 2
> +
> +Function: "acosh_towardzero":
> +double: 2
> +float: 2
> +
> +Function: "acosh_upward":
> +double: 2
> +float: 2
> +
> +Function: "asin":
> +double: 1
> +float: 1
> +
> +Function: "asin_downward":
> +double: 1
> +float: 1
> +
> +Function: "asin_towardzero":
> +double: 1
> +float: 1
> +
> +Function: "asin_upward":
> +double: 2
> +float: 1
> +
> +Function: "asinh":
> +double: 2
> +float: 2
> +
> +Function: "asinh_downward":
> +double: 3
> +float: 3
> +
> +Function: "asinh_towardzero":
> +double: 2
> +float: 2
> +
> +Function: "asinh_upward":
> +double: 3
> +float: 3
> +
> +Function: "atan":
> +double: 1
> +float: 1
> +
> +Function: "atan2":
> +float: 2
> +
> +Function: "atan2_downward":
> +double: 5
> +float: 2
> +
> +Function: "atan2_towardzero":
> +double: 5
> +float: 2
> +
> +Function: "atan2_upward":
> +double: 8
> +float: 2
> +
> +Function: "atan_downward":
> +double: 1
> +float: 2
> +
> +Function: "atan_towardzero":
> +double: 1
> +float: 1
> +
> +Function: "atan_upward":
> +double: 1
> +float: 2
> +
> +Function: "atanh":
> +double: 2
> +float: 2
> +
> +Function: "atanh_downward":
> +double: 3
> +float: 3
> +
> +Function: "atanh_towardzero":
> +double: 2
> +float: 2
> +
> +Function: "atanh_upward":
> +double: 3
> +float: 3
> +
> +Function: "cabs":
> +double: 1
> +
> +Function: "cabs_downward":
> +double: 1
> +
> +Function: "cabs_towardzero":
> +double: 1
> +
> +Function: "cabs_upward":
> +double: 1
> +
> +Function: Real part of "cacos":
> +double: 1
> +float: 2
> +
> +Function: Imaginary part of "cacos":
> +double: 2
> +float: 2
> +
> +Function: Real part of "cacos_downward":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "cacos_downward":
> +double: 5
> +float: 3
> +
> +Function: Real part of "cacos_towardzero":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "cacos_towardzero":
> +double: 4
> +float: 2
> +
> +Function: Real part of "cacos_upward":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "cacos_upward":
> +double: 5
> +float: 7
> +
> +Function: Real part of "cacosh":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "cacosh":
> +double: 1
> +float: 2
> +
> +Function: Real part of "cacosh_downward":
> +double: 4
> +float: 2
> +
> +Function: Imaginary part of "cacosh_downward":
> +double: 3
> +float: 3
> +
> +Function: Real part of "cacosh_towardzero":
> +double: 4
> +float: 2
> +
> +Function: Imaginary part of "cacosh_towardzero":
> +double: 3
> +float: 2
> +
> +Function: Real part of "cacosh_upward":
> +double: 4
> +float: 3
> +
> +Function: Imaginary part of "cacosh_upward":
> +double: 3
> +float: 2
> +
> +Function: "carg":
> +float: 1
> +
> +Function: "carg_downward":
> +double: 5
> +float: 2
> +
> +Function: "carg_towardzero":
> +double: 5
> +float: 2
> +
> +Function: "carg_upward":
> +double: 8
> +float: 2
> +
> +Function: Real part of "casin":
> +double: 1
> +float: 1
> +
> +Function: Imaginary part of "casin":
> +double: 2
> +float: 2
> +
> +Function: Real part of "casin_downward":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "casin_downward":
> +double: 5
> +float: 3
> +
> +Function: Real part of "casin_towardzero":
> +double: 3
> +float: 1
> +
> +Function: Imaginary part of "casin_towardzero":
> +double: 4
> +float: 2
> +
> +Function: Real part of "casin_upward":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "casin_upward":
> +double: 5
> +float: 7
> +
> +Function: Real part of "casinh":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "casinh":
> +double: 1
> +float: 1
> +
> +Function: Real part of "casinh_downward":
> +double: 5
> +float: 3
> +
> +Function: Imaginary part of "casinh_downward":
> +double: 3
> +float: 2
> +
> +Function: Real part of "casinh_towardzero":
> +double: 4
> +float: 2
> +
> +Function: Imaginary part of "casinh_towardzero":
> +double: 3
> +float: 1
> +
> +Function: Real part of "casinh_upward":
> +double: 5
> +float: 7
> +
> +Function: Imaginary part of "casinh_upward":
> +double: 3
> +float: 2
> +
> +Function: Real part of "catan":
> +double: 1
> +float: 1
> +
> +Function: Imaginary part of "catan":
> +double: 1
> +float: 1
> +
> +Function: Real part of "catan_downward":
> +double: 1
> +float: 2
> +
> +Function: Imaginary part of "catan_downward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "catan_towardzero":
> +double: 1
> +float: 2
> +
> +Function: Imaginary part of "catan_towardzero":
> +double: 2
> +float: 2
> +
> +Function: Real part of "catan_upward":
> +double: 2
> +float: 1
> +
> +Function: Imaginary part of "catan_upward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "catanh":
> +double: 1
> +float: 1
> +
> +Function: Imaginary part of "catanh":
> +double: 1
> +float: 1
> +
> +Function: Real part of "catanh_downward":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "catanh_downward":
> +double: 1
> +float: 2
> +
> +Function: Real part of "catanh_towardzero":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "catanh_towardzero":
> +double: 1
> +float: 2
> +
> +Function: Real part of "catanh_upward":
> +double: 4
> +float: 4
> +
> +Function: Imaginary part of "catanh_upward":
> +double: 2
> +float: 1
> +
> +Function: "cbrt":
> +double: 4
> +float: 1
> +
> +Function: "cbrt_downward":
> +double: 4
> +float: 1
> +
> +Function: "cbrt_towardzero":
> +double: 3
> +float: 1
> +
> +Function: "cbrt_upward":
> +double: 5
> +float: 1
> +
> +Function: Real part of "ccos":
> +double: 1
> +float: 1
> +
> +Function: Imaginary part of "ccos":
> +double: 1
> +float: 1
> +
> +Function: Real part of "ccos_downward":
> +double: 3
> +float: 1
> +
> +Function: Imaginary part of "ccos_downward":
> +double: 3
> +float: 3
> +
> +Function: Real part of "ccos_towardzero":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "ccos_towardzero":
> +double: 3
> +float: 3
> +
> +Function: Real part of "ccos_upward":
> +double: 1
> +float: 2
> +
> +Function: Imaginary part of "ccos_upward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "ccosh":
> +double: 2
> +float: 1
> +
> +Function: Imaginary part of "ccosh":
> +double: 1
> +float: 1
> +
> +Function: Real part of "ccosh_downward":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "ccosh_downward":
> +double: 3
> +float: 3
> +
> +Function: Real part of "ccosh_towardzero":
> +double: 3
> +float: 3
> +
> +Function: Imaginary part of "ccosh_towardzero":
> +double: 3
> +float: 3
> +
> +Function: Real part of "ccosh_upward":
> +double: 1
> +float: 2
> +
> +Function: Imaginary part of "ccosh_upward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "cexp":
> +double: 2
> +float: 1
> +
> +Function: Imaginary part of "cexp":
> +double: 1
> +float: 2
> +
> +Function: Real part of "cexp_downward":
> +double: 4
> +float: 2
> +
> +Function: Imaginary part of "cexp_downward":
> +double: 3
> +float: 3
> +
> +Function: Real part of "cexp_towardzero":
> +double: 4
> +float: 2
> +
> +Function: Imaginary part of "cexp_towardzero":
> +double: 3
> +float: 3
> +
> +Function: Real part of "cexp_upward":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "cexp_upward":
> +double: 3
> +float: 2
> +
> +Function: Real part of "clog":
> +double: 3
> +float: 3
> +
> +Function: Imaginary part of "clog":
> +double: 1
> +float: 1
> +
> +Function: Real part of "clog10":
> +double: 3
> +float: 4
> +
> +Function: Imaginary part of "clog10":
> +double: 2
> +float: 2
> +
> +Function: Real part of "clog10_downward":
> +double: 7
> +float: 5
> +
> +Function: Imaginary part of "clog10_downward":
> +double: 8
> +float: 4
> +
> +Function: Real part of "clog10_towardzero":
> +double: 5
> +float: 5
> +
> +Function: Imaginary part of "clog10_towardzero":
> +double: 8
> +float: 4
> +
> +Function: Real part of "clog10_upward":
> +double: 6
> +float: 5
> +
> +Function: Imaginary part of "clog10_upward":
> +double: 5
> +float: 4
> +
> +Function: Real part of "clog_downward":
> +double: 4
> +float: 3
> +
> +Function: Imaginary part of "clog_downward":
> +double: 5
> +float: 2
> +
> +Function: Real part of "clog_towardzero":
> +double: 8
> +float: 4
> +
> +Function: Imaginary part of "clog_towardzero":
> +double: 5
> +float: 3
> +
> +Function: Real part of "clog_upward":
> +double: 8
> +float: 3
> +
> +Function: Imaginary part of "clog_upward":
> +double: 8
> +float: 2
> +
> +Function: "cos":
> +double: 1
> +float: 1
> +
> +Function: "cos_downward":
> +double: 1
> +float: 1
> +
> +Function: "cos_towardzero":
> +double: 4
> +float: 1
> +
> +Function: "cos_upward":
> +double: 4
> +float: 1
> +
> +Function: "cosh":
> +double: 2
> +float: 2
> +
> +Function: "cosh_downward":
> +double: 3
> +float: 1
> +
> +Function: "cosh_towardzero":
> +double: 3
> +float: 1
> +
> +Function: "cosh_upward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "cpow":
> +double: 2
> +float: 5
> +
> +Function: Imaginary part of "cpow":
> +float: 2
> +
> +Function: Real part of "cpow_downward":
> +double: 5
> +float: 8
> +
> +Function: Imaginary part of "cpow_downward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "cpow_towardzero":
> +double: 5
> +float: 8
> +
> +Function: Imaginary part of "cpow_towardzero":
> +double: 2
> +float: 2
> +
> +Function: Real part of "cpow_upward":
> +double: 4
> +float: 1
> +
> +Function: Imaginary part of "cpow_upward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "csin":
> +double: 1
> +float: 1
> +
> +Function: Real part of "csin_downward":
> +double: 3
> +float: 3
> +
> +Function: Imaginary part of "csin_downward":
> +double: 3
> +float: 1
> +
> +Function: Real part of "csin_towardzero":
> +double: 3
> +float: 3
> +
> +Function: Imaginary part of "csin_towardzero":
> +double: 3
> +float: 1
> +
> +Function: Real part of "csin_upward":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "csin_upward":
> +double: 1
> +float: 2
> +
> +Function: Real part of "csinh":
> +float: 1
> +
> +Function: Imaginary part of "csinh":
> +double: 1
> +float: 1
> +
> +Function: Real part of "csinh_downward":
> +double: 3
> +float: 1
> +
> +Function: Imaginary part of "csinh_downward":
> +double: 3
> +float: 3
> +
> +Function: Real part of "csinh_towardzero":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "csinh_towardzero":
> +double: 3
> +float: 3
> +
> +Function: Real part of "csinh_upward":
> +double: 1
> +float: 2
> +
> +Function: Imaginary part of "csinh_upward":
> +double: 2
> +float: 2
> +
> +Function: Real part of "csqrt":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "csqrt":
> +double: 2
> +float: 2
> +
> +Function: Real part of "csqrt_downward":
> +double: 5
> +float: 4
> +
> +Function: Imaginary part of "csqrt_downward":
> +double: 4
> +float: 3
> +
> +Function: Real part of "csqrt_towardzero":
> +double: 4
> +float: 3
> +
> +Function: Imaginary part of "csqrt_towardzero":
> +double: 4
> +float: 3
> +
> +Function: Real part of "csqrt_upward":
> +double: 5
> +float: 4
> +
> +Function: Imaginary part of "csqrt_upward":
> +double: 3
> +float: 3
> +
> +Function: Real part of "ctan":
> +double: 1
> +float: 1
> +
> +Function: Imaginary part of "ctan":
> +double: 2
> +float: 2
> +
> +Function: Real part of "ctan_downward":
> +double: 6
> +float: 5
> +
> +Function: Imaginary part of "ctan_downward":
> +double: 3
> +float: 2
> +
> +Function: Real part of "ctan_towardzero":
> +double: 5
> +float: 3
> +
> +Function: Imaginary part of "ctan_towardzero":
> +double: 3
> +float: 2
> +
> +Function: Real part of "ctan_upward":
> +double: 2
> +float: 4
> +
> +Function: Imaginary part of "ctan_upward":
> +double: 2
> +float: 1
> +
> +Function: Real part of "ctanh":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "ctanh":
> +double: 2
> +float: 2
> +
> +Function: Real part of "ctanh_downward":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "ctanh_downward":
> +double: 6
> +float: 5
> +
> +Function: Real part of "ctanh_towardzero":
> +double: 3
> +float: 2
> +
> +Function: Imaginary part of "ctanh_towardzero":
> +double: 5
> +float: 3
> +
> +Function: Real part of "ctanh_upward":
> +double: 2
> +float: 2
> +
> +Function: Imaginary part of "ctanh_upward":
> +double: 2
> +float: 3
> +
> +Function: "erf":
> +double: 1
> +float: 1
> +
> +Function: "erf_downward":
> +double: 1
> +float: 1
> +
> +Function: "erf_towardzero":
> +double: 1
> +float: 1
> +
> +Function: "erf_upward":
> +double: 1
> +float: 1
> +
> +Function: "erfc":
> +double: 5
> +float: 3
> +
> +Function: "erfc_downward":
> +double: 5
> +float: 6
> +
> +Function: "erfc_towardzero":
> +double: 3
> +float: 4
> +
> +Function: "erfc_upward":
> +double: 5
> +float: 6
> +
> +Function: "exp":
> +double: 1
> +float: 1
> +
> +Function: "exp10":
> +double: 2
> +float: 1
> +
> +Function: "exp10_downward":
> +double: 3
> +float: 1
> +
> +Function: "exp10_towardzero":
> +double: 3
> +float: 1
> +
> +Function: "exp10_upward":
> +double: 2
> +float: 1
> +
> +Function: "exp2":
> +double: 1
> +
> +Function: "exp2_downward":
> +double: 1
> +
> +Function: "exp2_towardzero":
> +double: 1
> +
> +Function: "exp2_upward":
> +double: 1
> +float: 1
> +
> +Function: "exp_downward":
> +double: 1
> +float: 1
> +
> +Function: "exp_towardzero":
> +double: 1
> +float: 1
> +
> +Function: "exp_upward":
> +double: 1
> +float: 1
> +
> +Function: "expm1":
> +double: 1
> +float: 1
> +
> +Function: "expm1_downward":
> +double: 1
> +float: 1
> +
> +Function: "expm1_towardzero":
> +double: 1
> +float: 2
> +
> +Function: "expm1_upward":
> +double: 1
> +float: 1
> +
> +Function: "gamma":
> +double: 4
> +float: 7
> +
> +Function: "gamma_downward":
> +double: 7
> +float: 7
> +
> +Function: "gamma_towardzero":
> +double: 7
> +float: 7
> +
> +Function: "gamma_upward":
> +double: 5
> +float: 6
> +
> +Function: "hypot":
> +double: 1
> +float: 1
> +
> +Function: "hypot_downward":
> +double: 1
> +
> +Function: "hypot_towardzero":
> +double: 1
> +
> +Function: "hypot_upward":
> +double: 1
> +
> +Function: "j0":
> +double: 2
> +float: 9
> +
> +Function: "j0_downward":
> +double: 5
> +float: 9
> +
> +Function: "j0_towardzero":
> +double: 6
> +float: 9
> +
> +Function: "j0_upward":
> +double: 9
> +float: 9
> +
> +Function: "j1":
> +double: 4
> +float: 9
> +
> +Function: "j1_downward":
> +double: 5
> +float: 8
> +
> +Function: "j1_towardzero":
> +double: 4
> +float: 8
> +
> +Function: "j1_upward":
> +double: 9
> +float: 9
> +
> +Function: "jn":
> +double: 4
> +float: 4
> +
> +Function: "jn_downward":
> +double: 7
> +float: 9
> +
> +Function: "jn_towardzero":
> +double: 7
> +float: 9
> +
> +Function: "jn_upward":
> +double: 7
> +float: 9
> +
> +Function: "lgamma":
> +double: 4
> +float: 7
> +
> +Function: "lgamma_downward":
> +double: 7
> +float: 7
> +
> +Function: "lgamma_towardzero":
> +double: 7
> +float: 7
> +
> +Function: "lgamma_upward":
> +double: 5
> +float: 6
> +
> +Function: "log10":
> +double: 2
> +float: 2
> +
> +Function: "log10_downward":
> +double: 2
> +float: 3
> +
> +Function: "log10_towardzero":
> +double: 2
> +float: 1
> +
> +Function: "log10_upward":
> +double: 2
> +float: 2
> +
> +Function: "log1p":
> +double: 1
> +float: 1
> +
> +Function: "log1p_downward":
> +double: 2
> +float: 2
> +
> +Function: "log1p_towardzero":
> +double: 2
> +float: 2
> +
> +Function: "log1p_upward":
> +double: 2
> +float: 2
> +
> +Function: "log2":
> +float: 1
> +
> +Function: "log2_downward":
> +double: 1
> +
> +Function: "log2_towardzero":
> +double: 1
> +
> +Function: "log2_upward":
> +double: 1
> +
> +Function: "pow":
> +double: 1
> +
> +Function: "pow_downward":
> +double: 1
> +float: 1
> +
> +Function: "pow_towardzero":
> +double: 1
> +float: 1
> +
> +Function: "pow_upward":
> +double: 1
> +float: 1
> +
> +Function: "sin":
> +double: 1
> +float: 1
> +
> +Function: "sin_downward":
> +double: 4
> +float: 1
> +
> +Function: "sin_towardzero":
> +double: 3
> +float: 1
> +
> +Function: "sin_upward":
> +double: 7
> +float: 1
> +
> +Function: "sincos":
> +double: 1
> +
> +Function: "sincos_downward":
> +double: 1
> +float: 1
> +
> +Function: "sincos_towardzero":
> +double: 4
> +float: 1
> +
> +Function: "sincos_upward":
> +double: 1
> +float: 1
> +
> +Function: "sinh":
> +double: 2
> +float: 2
> +
> +Function: "sinh_downward":
> +double: 3
> +float: 3
> +
> +Function: "sinh_towardzero":
> +double: 3
> +float: 2
> +
> +Function: "sinh_upward":
> +double: 3
> +float: 3
> +
> +Function: "tan":
> +float: 1
> +
> +Function: "tan_downward":
> +double: 1
> +float: 2
> +
> +Function: "tan_towardzero":
> +double: 1
> +float: 1
> +
> +Function: "tan_upward":
> +double: 1
> +float: 1
> +
> +Function: "tanh":
> +double: 2
> +float: 2
> +
> +Function: "tanh_downward":
> +double: 3
> +float: 3
> +
> +Function: "tanh_towardzero":
> +double: 2
> +float: 2
> +
> +Function: "tanh_upward":
> +double: 3
> +float: 3
> +
> +Function: "tgamma":
> +double: 9
> +float: 8
> +
> +Function: "tgamma_downward":
> +double: 9
> +float: 9
> +
> +Function: "tgamma_towardzero":
> +double: 9
> +float: 8
> +
> +Function: "tgamma_upward":
> +double: 9
> +float: 8
> +
> +Function: "y0":
> +double: 3
> +float: 9
> +
> +Function: "y0_downward":
> +double: 3
> +float: 9
> +
> +Function: "y0_towardzero":
> +double: 4
> +float: 9
> +
> +Function: "y0_upward":
> +double: 3
> +float: 9
> +
> +Function: "y1":
> +double: 3
> +float: 9
> +
> +Function: "y1_downward":
> +double: 6
> +float: 9
> +
> +Function: "y1_towardzero":
> +double: 3
> +float: 9
> +
> +Function: "y1_upward":
> +double: 7
> +float: 9
> +
> +Function: "yn":
> +double: 3
> +float: 3
> +
> +Function: "yn_downward":
> +double: 6
> +float: 8
> +
> +Function: "yn_towardzero":
> +double: 8
> +float: 8
> +
> +Function: "yn_upward":
> +double: 8
> +float: 8
> +
> +# end of automatic generation
> diff --git a/sysdeps/or1k/fpu/libm-test-ulps-name b/sysdeps/or1k/fpu/libm-test-ulps-name
> new file mode 100644
> index 0000000000..7f72f7a873
> --- /dev/null
> +++ b/sysdeps/or1k/fpu/libm-test-ulps-name
> @@ -0,0 +1 @@
> +OpenRISC hard-float
> diff --git a/sysdeps/or1k/libm-test-ulps-name b/sysdeps/or1k/libm-test-ulps-name
> deleted file mode 100644
> index 0af6591fd9..0000000000
> --- a/sysdeps/or1k/libm-test-ulps-name
> +++ /dev/null
> @@ -1 +0,0 @@
> -OpenRISC
> diff --git a/sysdeps/or1k/libm-test-ulps b/sysdeps/or1k/nofpu/libm-test-ulps
> similarity index 100%
> rename from sysdeps/or1k/libm-test-ulps
> rename to sysdeps/or1k/nofpu/libm-test-ulps
> diff --git a/sysdeps/or1k/nofpu/libm-test-ulps-name b/sysdeps/or1k/nofpu/libm-test-ulps-name
> new file mode 100644
> index 0000000000..76c66a0e53
> --- /dev/null
> +++ b/sysdeps/or1k/nofpu/libm-test-ulps-name
> @@ -0,0 +1 @@
> +OpenRISC soft-float
