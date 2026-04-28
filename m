Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23E37BE8E
	for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399070; cv=none; b=iAE5vM+A8ijKlEjwq3GR1ygxJa6kdmBkL40yaRCOSyFnv01gsyB0p0Mb/DrQlhhb/wfpDYuLn+tY80HdIpGOQB2GfpKDdcRUqvu0US+JaRphISMNbqvyz9dMtV3LP73Ym27wqhmCeTaEY4CyUyrxFCAXpTBumsQMn7CCWv2vxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399070; c=relaxed/simple;
	bh=xbHtrzegYf0nfkLPcsRJNj00sBDYJttTqCNBuivCAbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3+PtYlsOSaaXzoCP0q4wEtfEgtd9HZlTit5z4JvYFrcvZLxzB8Hb9zK9GQcVixiBQ/JsrjQrhgc+9JZ/EVhX55lYt2T5rhxK88jWHluT5ss+nhHyODyMSPjDMBqojZt4Gh2r9kE0hDwD79R22LlOmpQYA6iRJRB+waDqI1ZgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i12WVbvx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i12WVbvx"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so548525e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777399067; x=1778003867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5dLgzUq25eFXbjvfMZAItHmjh4pTq4+QRuSVfgK4SU=;
        b=i12WVbvxX5xIr5l+mKqk3K3SH80EQMBRYl3rUc3DJypIYQsciy6pgy5mk99ZeTH9dt
         04qrfhHKCry8fz6WII0iBVA1O1FagAD6nKF0WSRD3YMOz4lMnLNS6D5bssr7WA5OeVKt
         cvyxAfGiF934nvoc3y7j93r+9oLXJTajqp1xKwUz6hVix+TPzibbqDaTKUcfZtVfYl5y
         fXF7mw9zvDpkLRJorW6JhnS9Tz5iWrLo5qvNdwmtFX8rHKJscyxLZXW+93aB6y57O2gA
         NW05L7I5Cjng9hq8ZPbHiQCXPK4Lapu47c3FC+Myvf+5MzYZythWXr28QN/EazvwGqwF
         WYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399067; x=1778003867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5dLgzUq25eFXbjvfMZAItHmjh4pTq4+QRuSVfgK4SU=;
        b=Bl0vWFRdAXGYRKtBDtOVNl65AXJL6XWGfvyTn4Fz3m0jcty+Klh5Y/ZxwTwfLekFxU
         n07SjgvmyXt4c/O1YpDhxxIA761KYG6CN77bL7aNaf4vMNESqfanxkrbPOEY89cVMJDH
         RTUdH8bGufR52NaPg98CFVl0cx0qNEth0JOy7zsguZHbvKxY8OPoC94QAJrsNERyJP8W
         Urjp52cDKG53OY+uMPgKGtSTQIs4hJXhQOhDjNf5MO54FnDlzaakwlmOv31bSeRcPU2u
         2AC7/ChF5PnS5xaB16ezv6gAeXdz7/HWA/1aWnhanDVcT663nXnwUSOGzkp8MAsjubu4
         fsrA==
X-Gm-Message-State: AOJu0YzhPq6IXN8oiSamQC7USGPHGVEdS0sHbZ1ioCnQA6VUxhxR9SWP
	yX6AbZyxEZkNiRJ9edOGPgBpRi4B/kPIHwJ9orfYq52Jvffb+b29dhEn7+Fd79ekh1E=
X-Gm-Gg: AeBDievu+ccrFFgUHlcWWVZdnsBYGtXJMweoZs/2siNxkJp8kn4JtBip+AxaD9rXjyO
	aJ+hrhrvqrfOeIuzJEfiGGeRKAjqeNKI/ZqT6q7w8yNVaKCcw5k+KAV4s3QHA+dE+c9vIGs/0SE
	OgO2B5tXC7xLGrDr4IcN8D9GctryQkuAFiIB/47j10pzNUGhBSrAXN2t6j1rbfN2q+/W2qxhVTv
	mIhOZB974VqzSuzjxSAnuimX0rOUoA9cqQiWtSf4vLXJg+AqfLBKzDvWifxrF/5O+6JJBMfbD0X
	bIZULgxuw7jDuviVsporf+hPKD1pRZDlvg0//T+DKwoJOBB0ph60MjJesQNgm/QD1tjlEkuTc5b
	FvzzuOVFu5sQl7Qk3ZeMuu8TxQtMVaWvBLgkeZ7xB+1VCCUt4MHYE+OMI13u+S+4WFs12jR8z1D
	laChey2EZ6Z5MOR76CwS0EMd3smFFjzdUOBmIyyC1XClSez96k43LU2HIpvW3oZulObo/uRnZ2t
	j3H
X-Received: by 2002:a05:600c:c08f:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-48a7beee40bmr244545e9.3.1777399067159;
        Tue, 28 Apr 2026 10:57:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bea9824sm819825e9.13.2026.04.28.10.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 10:57:46 -0700 (PDT)
Message-ID: <24efbecd-446f-453f-abc2-2955a65d5e87@linaro.org>
Date: Tue, 28 Apr 2026 19:57:44 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as OpenRISC board maintainer
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>,
 QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260428172055.1525176-1-shorne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428172055.1525176-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/4/26 19:20, Stafford Horne wrote:
> In the recent changes from Peter I realized the OpenRISC board maintainers were
> not properly documented.  Add myself and ensure virt is properly listed.

Thanks Stafford!

Series:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Stafford Horne (2):
>    MAINTAINERS: Add myself as maintainer for or1k-sim
>    MAINTAINERS: Add myself as the OpenRISC virt maintainer
> 
>   MAINTAINERS | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

