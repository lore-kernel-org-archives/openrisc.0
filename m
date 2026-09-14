Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FD3382EC
	for <linux-openrisc@vger.kernel.org>; Mon, 14 Sep 2026 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355358; cv=none; b=TecHJMKw6opRnG4H59cFvz578DigZpLTOvZluExJxMjVQMB1cY6Z+I5+SiZ3/bwkjw1mpWxPkvwGSfA7YiWri3+lFzrUZYIMB/NtZYW2i9mecny0/2cnCx5xrjVqyLur38zXc9wLC9GLkmA7KlLy4tjkDrrn9zGs3HXmVwfZuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355358; c=relaxed/simple;
	bh=yu8yRrlGW4NpnhP6b7DY4uyaoiBALVriYoMPFQd5ouE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naxRsTYPsVWoSEfEEuF5Cm8e6AeNaOReSVP0ACwwcfLYg+kbf/QGfEFQ4pX9GS6c4KqJ33BzDdrUv19F3YbIS7gLqlHnVIMkt5v3YIBMx6l7kRGAWH4KniXjZ6q0BI2S1cEbi/ZjxVyl9azC4iz+f9FA7uaRTD/tBA+Le2rp6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/blrnhI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/blrnhI"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-86265451beeso1726681b3a.0
        for <linux-openrisc@vger.kernel.org>; Sun, 13 Sep 2026 20:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789355349; x=1789960149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxEpeUk1PHnMzQBm4htKi9eebktVOTJEfLrkD8odnPI=;
        b=c/blrnhIz64VZ0S2x8yohqSUvNfFZ7kxxBFYROKzDXd7nQOECw3Ll5hmb31Q0V4A46
         m5lNVE6nLP0QRSaYz7zOX18FE1KV5y/58zpNbyZCXeai+3LZhf0KWUu59HBn50HocAIw
         DoxtvY+oRJbpDJNjQu8mge70dtcp8qYm2cQ72Xlpd/wrSK5PR3yOHp/0TaDrtwJwUAyS
         vwmpTAkqk91nY+uWP05sXb6rTKpc8jkf1iEcmjyzEnIKKNMFM62JJTFbLNhSCXaH8JmW
         o/ZjnbArW8oTv+qF1KC0m9LWMYCX/ZFMcrLYM4NfgSrRsacAWDTZIhMtT44XvTJB+nu5
         Rp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789355349; x=1789960149;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxEpeUk1PHnMzQBm4htKi9eebktVOTJEfLrkD8odnPI=;
        b=MaDKZTFPLeAmZmKdOUgRAEgjW84lFN2Kmr2IDdxNMPOJT3g/MCnQTSNzxXp15pT/Co
         s/u2eRb75ztx+Q9+iQMti8OdZkQt1VgUNgmWIfFfhj8ow1PqIz+BDH7Z1CA06YLPH6iV
         9umehUVPVHT40eTg95CFAG5bcSD6j+JhbOyF8FixpnZZeqhi6Y7boTIIbdpK7SSFdp6j
         ub6SmYmJmnSOZH78n2/rzNiXnzG/l0WtuwKR+Xnox05NX3kxGd+2B9V8KqXfTSah0uRz
         9XkVM2RIAh94seiFZU5O20RWy3pbrU21ymD6/5zZx8EOKV6fz3KxkZq1cmWjWMpQfKcP
         kAow==
X-Gm-Message-State: AFuF++kg0Hf9kMJLWotid/EgS5emxrVKHRoGKLuAUZx7gMYc43Sjw1xG
	c2KwDVh5okgun2MuCfYVoy0kLaE1vcDMl4AcONO1WY/Ac868l8zNz34Hinpsyof8iKc=
X-Gm-Gg: AYBFou0jkfaOpGCO6UWPDyQZALcr4d2XruBvXhgAm8oeYJ3VXFk2UEKPXrtZRnYbIF3
	rnWZpLTAG2c19I7YZeqiLUzvvrPOXwzqU0CS3WPuenQiNazFOCE2+3cmIOlHSILErFAYMd97ymD
	97GeCVXm5+3kmuVCLeer68HS699j59SNsARvfY+ciWCmi0pGDg22VrnqiF17jrefSn/bXD/FiIq
	MxTA50PARyn1LuI2nGccOiGKgTFrjiQki0Vesifs0jaEMY8LcsCVu4/tYiOpWWUWY/3hrL+H4Ho
	ce5xfyizVV8l1rlWnmnbvCInFb9xGfbr6uIOG6joCesjhyMAUa68ur7ll8d7jppVI/Ijstprzlw
	DAmyslbJ2s1hjKYYM0PP6++aXPKTy2ikB/qDCjiGP4/twMP9g7v2niUhyRkP/h7RsHG25Gcqjb4
	d3LSWQ3IUkjEtMz+HQSS3ZQyqX+pHilPUId9UByNM1hFEHBYkFS36FLJogXTyj7CQmix85661RV
	S2J8Lz/MPwNw1gdfpxli3oADahC2tCjYFki5OrXs5Pgz59xTU8mkDHgG7Mzag==
X-Received: by 2002:a05:6a20:c88b:b0:3d1:c0e2:936b with SMTP id adf61e73a8af0-3db404269e1mr1262320637.7.1789355349223;
        Sun, 13 Sep 2026 20:09:09 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870? ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm20325577eec.5.2026.09.13.20.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 20:09:08 -0700 (PDT)
Message-ID: <1abf89f0-51ec-427e-9b9f-3fc2a4570719@linaro.org>
Date: Sun, 13 Sep 2026 17:09:06 -1000
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] OpenRISC Updates 2026-09-13
To: Stafford Horne <shorne@gmail.com>,
 QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260913070303.1010504-1-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260913070303.1010504-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/26 21:03, Stafford Horne wrote:
> Hello,
> 
> Please consider for pull,
> 
> The following changes since commit d43c2d5f89db70359a7b3a7e2ad7098fcc0165ef:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-09-11 12:04:42 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/stffrdhrn/qemu.git tags/or1k-updates-20260913
> 
> for you to fetch changes up to cfaf6a1edd8803f0334007dbbff9ca5eb293e98b:
> 
>    target/or1k: Implement l.extws and l.extwz (2026-09-12 08:31:14 +0100)
> 
> ----------------------------------------------------------------
> OpenRISC Updates 2026-09-13
> 
> One patch:
>   - Missing instruction definitions for word sign extension.

Applied, thanks.

r~
